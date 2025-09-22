Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3531812E;
	Mon, 22 Sep 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564594; cv=none; b=PBkhfFAtOHaWWyq6RDY/Dz+0KaOxM8/pkEr2SD9w7Yrv9E8e5lwq9nsDL7Voz7/KZZMdondIwD9Xd4taju35FmfU14ZZ9L6q54kdvG5bFm+fegfuWyMpmytJZh/gDS3ioHmu2JFOkGr2lTq8SFznIaFxe4p3PsnQpYxso7PlM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564594; c=relaxed/simple;
	bh=Gcrrr/pU9hEwQkb8+P4aK7R5PmqmjlP4aLroqziLe7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUi21DzK8ijrI2GeFGLwIDQ7oNrOlVFg66/VqR7tilF5mJ3kYR9pdWyc/6bdMr79Hzm323AoJ/8VMKPpsWri3VAZ48vCAaKVdg13AIToAPO43tSxZ1gKt4aezG+5IOqlBuGddk7sa1iDrItwwvHpORerdfayinsDMLSzTBNu0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V78bR3D8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V78bR3D8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FK0vhlcwzVJAcejz4cqAmDuYQ9iMTjiS8A6uqr3V9Oc=; b=V78bR3D8A5q1wK68XXXyD43mjM
	v9k4tb6BPM2wWULfmvZxAOgd63Nt0qA3qTKyd1a5ZIfitDlETwgbhuMmci8VKDs6tCg15oKI0n1q+
	67zHBTQy4A8EHZmgNNAJs+9YW5p0vaPpces4GfB1etOYPP4UBnmpmLW6pRTKWsCdj/WLzKALZDWKH
	ROumwbJZ+6xAzHPetLhZ8np8HEhCvuAyltz1DQbCdl3FqGvZfe8EmMgq87eUdPjUVyRPDKTr/Z9Cb
	0aJm3eLOuqpLB5CAE0anOgU5ed7IRsMqzXAraXI7YYAxmKjzRvFZA6r3svtkGZCZvDGL+UFZlLpzS
	ObcBJ3IA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kyx-0000000BDg1-3gyU;
	Mon, 22 Sep 2025 18:09:47 +0000
Date: Mon, 22 Sep 2025 11:09:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop
 driver
Message-ID: <aNGQ66CD9F82BFP-@infradead.org>
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 11:29:15AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> For now, my android system with per pid memcgv2 setup are suffering
> high block_rq_issue to block_rq_complete latency which is actually
> introduced by schedule latency of too many kworker threads. By further
> investigation, we found that the EAS scheduler which will pack small
> load tasks into one CPU core will make this scenario worse. This commit
> would like to introduce a way of synchronized read to be helpful on
> this scenario. The I2C of loop device's request reduced from 14ms to
> 2.1ms under fio test.

So fix the scheduler, or create less helper threads, but this work
around really look like fixing the symptoms instead of even trying
to aim for the root cause.

