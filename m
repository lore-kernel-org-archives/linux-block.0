Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A516B752;
	Thu, 11 Jul 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715606; cv=none; b=KsF30frKytvttiAip0/lyVJcQ56q0jFgtnJRXkcnAojqzaYj+IOvAL4PfbJ44JgmtIexZ512Yjg+sEY1GBlBdduTq7T5KS2qoBjwvFKCtWQrgdHlHMTKtRRoTcPdRs9PeePpFIBEOirSJbhqy4lJy2c0NgNTS6737d0svyUUuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715606; c=relaxed/simple;
	bh=+cFg23U/Sp4cyNP8PMArI4xoQiF/Na1nVbuUyhMvj50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr+Hk5FtfeWjxm0T1Kv0Rmj6Dlu/j/X0j85uLjoxvtAbdBVdIQKuwq2Vjgo4ASAptxi6oj/4i0q6jMnwbP+jhO5HM/Z3vpys4Rq7D4PfuliNQmnCN69/SSZ4fBJD6XaeYxnFrHsvYGO6vY+q3abYL/9Fy1FKDH+cGM3r3BEIexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yO8Rtsz5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yO8Rtsz5"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKgJh2Xyfz6CmM79;
	Thu, 11 Jul 2024 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720715601; x=1723307602; bh=A0uDqH2glvb4KwtXopXocLVy
	OkGVAxng0SI+sH9s5qk=; b=yO8Rtsz5y39fnEwLThnMD52Vr1L4t/BB0TW372eK
	9+Ps5ui5o56lQ0Cufh8PkFkYSK1EZf+7CbrDiJ6HoZ7TvBFfv9IkRBZl0/QfOd2w
	OSHo9yuu7An31sSXIJtvFxmGnQOvs3ofunZAkINB6fAE4Ov37Fw55SshLlKfmSKi
	1ce/guptRVmQJFYYHYgYPo0zJA5UL2ZXFzesWD/lshcoD/q2lvna9WW+82HxMT5t
	64wvL4hJ7XaDfVdgYye2IkSVpBulkEXiCkMf1i0Q4A6547pffnublcteF/h1Z/MN
	ycNYGPiFld0yxEqdpMNM6dAHYxWw718D1Tc2cIZuuC4rqg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gyaa-T2nZ7Qo; Thu, 11 Jul 2024 16:33:21 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKgJc717Jz6CmM6f;
	Thu, 11 Jul 2024 16:33:20 +0000 (UTC)
Message-ID: <6acb93c3-f11b-40a4-bec0-b17fb77ad0c9@acm.org>
Date: Thu, 11 Jul 2024 09:33:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Ming Lei <ming.lei@redhat.com>, YangYang <yang.yang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240710065616.1060803-1-yang.yang@vivo.com>
 <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
 <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com> <Zo/gevNqftePGvic@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zo/gevNqftePGvic@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 6:39 AM, Ming Lei wrote:
> There are only two WRITE on 'cleared':
> 
> - xchg(&map->cleared, 0) in sbitmap_deferred_clear()
> 
> - set_bit() in sbitmap_deferred_clear_bit()
> 
> xchg() supposes to provide such protection already.

Hi Ming,

The comment above 'swap_lock' in this patch is as follows:

	/**
	 * @swap_lock: Held while swapping word <-> cleared
	 */

In other words, 'swap_lock' is used to serialize *code*. Using
synchronization objects to serialize code is known as an anti-pattern,
something that shouldn't be done. Synchronization objects should be used
to serialize access to data. Hence my question whether it would be
appropriate to protect all 'cleared' changes with the newly introduced
spinlock.

Thanks,

Bart.
