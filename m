Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55394525A98;
	Fri, 18 Sep 2026 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764129; cv=none; b=P5PtbuXl/L+Sdy5i8f/k1FiP/KJKOkyNx5cfKKBFW7nAFL7zgnsXDoAS2StoMDTfqkcLNLD0I3MYijn/PGv0zc9L4WF8ZfRn6nfqek0TTHDjGXtm74Bw7zfMr4N7VFeoRreSmdr5re1GNRoSPCVLyj3rbgAWfocBmRajJCr8yzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764129; c=relaxed/simple;
	bh=8V2Tfqm33H9tR9Xi/9JcCE3Gv1P6YkrVqBr0K1VUf5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhnGhjZYLwuNx1aNDULyRgisniRjHpCpzNEEsoGyuMKp1KIcPU2DhKgbwJlPItdNF6Nuq0otah8gzanZ8okjJVgZzrphAxaK1Phhqb3aM6Js2HKXFR2/gbrq3tjZOjhgJ8PwWlv1DCuNVyv/6s3YSt8+YsI9V2Y+2WApM6BM6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gzfp0oqV; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gzfp0oqV"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hml0t4QjnzlfwJB;
	Fri, 18 Sep 2026 20:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789764117; x=1792356118; bh=8GpvTBHJU9j/bcF7uMw4q8xd
	JvrqvWcsOcx+Fkx1WsI=; b=gzfp0oqVv0J6K1Fuu6NVfKgovfQ7p0kkIW2wD/1U
	p+whQXnebpPJhl2gYXTv0ooZO/ZuinuHkusBFDlfLc3s6bzW9ZF+huAyB6wDUrul
	Z6Du0KsQEj92yEar2TENp8Ld5LhEfikYh+KOu04uUI47xLkRfcvt9dTIz4Z4d4oW
	pL0qws2SWtBtk/ULISRzH0LTMLUQqkTKmtMHE0AVMGxy1qMIIOMp8StFwzI3vetX
	u9rgDiW08ZPAO29JhX11pfhmoi7/ak8uVv/cEOY8/qslkd0vR113E6WvLgZ6x3U/
	i6aCupbyGCOZAMcgoFq4UEB/bEeRqlPRksHo1kDWBBA2KA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id onpb8rV28AlA; Fri, 18 Sep 2026 20:41:57 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hml0b60Hrzlfvpc;
	Fri, 18 Sep 2026 20:41:51 +0000 (UTC)
Message-ID: <f232b118-f4d0-426a-94d4-eb9aa1f2d626@acm.org>
Date: Fri, 18 Sep 2026 13:41:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] loop: Perform __loop_clr_fd() after
 disk->open_mutex is dropped.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <f597b6e6-77a7-4c09-9d72-e5a9cbe6d7c2@I-love.SAKURA.ne.jp>
 <8ac41772-c397-4069-8878-7a1924e8b8a3@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8ac41772-c397-4069-8878-7a1924e8b8a3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 8:00 AM, Tetsuo Handa wrote:
> +	/* Step 1: Flush all outstanding I/O, without open_mutex held. */
> +	/*
> +	 * Since loop_queue_rq() is called with RCU read lock, this synchronize_rcu()
> +	 * makes sure that no more queue_work() calls are made from loop_queue_work()
> +	 * from loop_queue_rq(). Subsequent loop_queue_rq() calls which are made after
> +	 * this synchronize_rcu() returned shall see lo->lo_state != Lo_bound and
> +	 * return with BLK_STS_IOERR.
> +	 */
> +	synchronize_rcu();

Calling blk_mq_quiesce_queue(lo->lo_queue) and
blk_mq_unquiesce_queue(lo->lo_queue) is cleaner than calling
synchronize_rcu(). Additionally, it makes the purpose more clear.

> +	/*
> +	 * In order to flush outstanding I/O (without open_mutex for deadlock
> +	 * avoidance) before clearing the backing device, defer __loop_clr_fd()
> +	 * to lo_post_release().
> +	 * The Lo_rundown state guarantees that lo_open() will fail with -ENXIO.
> +	 * The failing lo_open() guarantees that lo_release() will not overwrite
> +	 * lo->rundown_owner until __loop_clr_fd() resets to the Lo_unbound state.
> +	 */
>   	if (need_clear)
> +		WRITE_ONCE(lo->rundown_owner, current);

The above code can be moved before the mutex_unlock() call and the
"need_clear" variable can be eliminated.

Thanks,

Bart.
