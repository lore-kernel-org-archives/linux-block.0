Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B488276054;
	Tue, 20 May 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740495; cv=none; b=lN8Mm5OMHLhgyEYdw/NjHIviIOfCJtae2UPc95cMVLXkQYmDiPxoHLTKCSZduwhs5J6d0uxHyesFAdxytCyMS44/bdKhLkNw6ETFlR7PBCNhhTcNS98bnkAkzYAYKz1E15beOk4J3bE4MSG9d1M7cZ8RXCxMefNh3ipbvy/eHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740495; c=relaxed/simple;
	bh=g7OY5WybUm9G3Cy04ex4HQekyAsnRVbXn65QIjP2Q2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAlYEqrW/Ahqo4PpAQSeiXz6xlNcStMzLaKvXLHfHU4Yzp6QaB5LYYQdzy0/JWq3sYuA5JOjx8nJCwS1Bd5AbbGLI+qT0JH+ejx/OrmN75TyNhdl6KMMKt66KgpuTnvHvpNS8WUV7ipWUvFUyWe0vNj68c3dZl0l0b9VDWVoiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ItqAMUEh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItqAMUEh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g7OY5WybUm9G3Cy04ex4HQekyAsnRVbXn65QIjP2Q2I=; b=ItqAMUEhsX4FHyFmcU4S6Rw+U4
	Hf23cUrLW/6my3b18qjNrkvSy4/atsPA3tY/3Fkw27Uq0JR7uzkn2ICCCpMZhWNnwhsCr5PnXMhGs
	DdIyKLHUI6w3gz+DDPj3J/Tav6S5AJfuHfvyMgCUzm/W5uM2Gu7tOaNggNd6330kDnXDnQW9ATs8i
	wGfVvx95d9TAt7YeWlFx1cx5GBkHEiDQSDwADkv5amNJGgp4+pGeHnmJm8DKyOahrA5mBpVUkPwWY
	lZspSSqbXWHkRjFRzn8JcPFfijJMucUQcHQRkmswGIpR+FEp1ZTx0sj8ToEhaoa5IQ8jLva1XZBY+
	04kfhL0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHL8m-0000000CdyH-1LOk;
	Tue, 20 May 2025 11:28:12 +0000
Date: Tue, 20 May 2025 04:28:12 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Christian Hesse <mail@eworm.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"christian@heusel.eu" <christian@heusel.eu>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com" <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= [PATCH V5]
 loop: Add sanity check for read/write_iter
Message-ID: <aCxnTIwiVhBK-XIt@infradead.org>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCwlRMEuvvP31UGG@infradead.org>
 <BL1PR11MB5979CBE5243379E686674B1C869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5979CBE5243379E686674B1C869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 20, 2025 at 06:59:14AM +0000, Xu, Lizhi wrote:
> No, isofs does not support read_iter.

Of course it does, check again.

