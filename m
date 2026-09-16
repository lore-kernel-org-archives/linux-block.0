Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C703B19DB
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599912; cv=none; b=j/yTJCIelrV+k0J+TdXOSEUVYFTUUCsoFwLTM1QAqFCdWNb+6AjsRZbo64d02r+XyQTNwROBFFsrJYuXbiDkJrSvl/KNilrRWDfmQHuG+ItZ/lKitulyC80UNrSJLqTD5i6IEFhHtBo1UWXzoVAZldx8By5bAkKUmxtKsHh7Mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599912; c=relaxed/simple;
	bh=hcg7VssTobbYSELzEt2yBJVTPzOjogKbSQubA7nlgXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBwAMXEK/vj76asYaVqNXtxX7y/rhPyknRFSrVwLNWYRe4SlZtjSeUtlkLjbiIRpiNoco+iPMy9HOulhX45uXUhEJaEAULkqpY53Jq0aT4l2XGsXf1VnYE2/N4PflnXNPWe2F1uAoBb07TrSMSmUFSSno5DwgBK4b0c0sA8UnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=L6aWfoeA; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="L6aWfoeA"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hlZGt4Bklz1XM6J6;
	Wed, 16 Sep 2026 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789599906; x=1792191907; bh=+LPLkZ51n5ikrRqn6597SK6v
	7ENuUmMk04/+P1U2YmQ=; b=L6aWfoeAWb5NUZbLTU/TMxU2Q1J5BIgZANij3Sss
	/acN/9Vdza0+wS5PuLxlGH8Qn0qjdg4gNyR791JCKIBWQOZPtHrlMxHzgAhgiR+F
	XfWbap4hs7OG2mSnDsvA+zuQbWje4RHjnciCaRSz3gOv+kHQ03SHQGamWJKbFWu5
	QY77TYDa1/1Gp1b8BIVec2VSHas8+6KnPB6i0Fg/uD5HSJFO0b8F1fhkhNa4fhrz
	wz6/fHpUSORTsQUQKWcgAgsn2EIFZpLL2z3BbW79VpqGHE/C/BZPLUKgPg8+I3VF
	dJfbvRocQDNFl6VpDIe2L7Qiq4KVMkwUBn/+N85L0rXIxg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U5IZskIWgdAE; Wed, 16 Sep 2026 23:05:06 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hlZGn1xL0z1XM4Sx;
	Wed, 16 Sep 2026 23:05:04 +0000 (UTC)
Message-ID: <e80c661a-1754-4842-89e2-8f0737e49055@acm.org>
Date: Wed, 16 Sep 2026 16:05:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <cover.1789587960.git.bvanassche@acm.org>
 <cb1383e61e1b4d63906deb9a947f781416282939.1789587960.git.bvanassche@acm.org>
 <aae44539-837a-4f75-9af5-694ecfd10784@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aae44539-837a-4f75-9af5-694ecfd10784@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 3:47 PM, Tetsuo Handa wrote:
> Please stop stealing my series

No, I'm not stealing your work. I credited you in the first patch with a
Suggested-by.

> and stop proposing broken series.

I think we disagree. My view is that your series is broken.
Additionally, I have explained multiple times in detail why I think
your series is broken but you chose to ignore my feedback.

> Since .post_release is called entirely outside of disk->open_mutex, multiple
> non-final close() threads can concurrently invoke lo_post_release() and race
> inside __loop_clr_fd() without any serialization.

This is wrong. The .release() and .post_release() callbacks are only
called once. The following code from fs/file_table.c illustrates this:

void fput(struct file *file)
{
	if (unlikely(file_ref_put(&file->f_ref)))
		__fput_deferred(file);
}

/* the real guts of fput() - releasing the last reference to file */
static void __fput(struct file *file)
{
	[ ... ]
	if (file->f_op->release)
		file->f_op->release(inode, file);
	[ ... ]
}

Thanks,

Bart.
