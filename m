Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2B257D;
	Wed, 10 Jul 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629715; cv=none; b=nSsUiWyHUINwx5xNlbSQIlsC5bxZTiZs4dUAMHWXy0//6PtAkNwPbRUmTWW8trpTDh05+gqhsqmL7kKjgFtVqjxbgACJRwa4hZIW/dQJP+rflxG7g+FBOE0zBBOCJ0YM5gw4/oEyVruFBNODEC/4/sdBFtl/UsspLI/T9ow10z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629715; c=relaxed/simple;
	bh=PoKxAIKtlOKLK7nQkCY1kP9FtSz8M9HmTymuhjmmnjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mtGQ8ApU/Z9RKAMMef7gOFiCY6mKUeSJQQfUuuoDdshvmvFFXENp/CC7VhnADez1NAlr7AuuCsRo/TmLpLLh740m65WqIhMl279gVuS/8hObEbdN4FgA+e8djDz9z5w7PbmYZVoRSt8yuo3P0b6p9xUo750hcNGg5Ej+5G54q7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=j2tS4mbK; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="j2tS4mbK"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WK3Xx2XBKzll9bb;
	Wed, 10 Jul 2024 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720629710; x=1723221711; bh=xWd2IKu2oYhPTt7Qc1nOLYhk
	MWMTyWkCKb85BbkUmDA=; b=j2tS4mbKjd2JFa0OKIaCQ2ED9lQ0PX+3qw7+3wlh
	++Q66kBL7oDcyU2X3ZnLYA+8CghbrrcUSWq3vpayZPYz/dfOf2CKqWGwnKrC2vXT
	0NkeVGkJa9M2mZ33TQoHxYM5t++9yI/l9TPqGgqsR6+Orw60rZ4zkg5ISHaGhS13
	vcYrTuqafi6kaLy5hacVNWR9qO4nX01QDEw+Le6BciSNGY3kcC0iNoub+0m1HVu3
	scQG2Gqsm9R1Mnbk8Te/g0DUl0os7sT9CbG1FNwvfzyfpXt/b/H5ipeypkRefesT
	J3dE4sTPaxMjsj4sBSh+apgxZx5LUBbPqGjnzgBzKMfN2A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wMfm8cbxVuAE; Wed, 10 Jul 2024 16:41:50 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WK3Xt1Gc3zll9bC;
	Wed, 10 Jul 2024 16:41:50 +0000 (UTC)
Message-ID: <ff5cc2b2-bf8e-4a48-8422-cdaac4129043@acm.org>
Date: Wed, 10 Jul 2024 09:41:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240710065616.1060803-1-yang.yang@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240710065616.1060803-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 11:56 PM, Yang Yang wrote:
> +	spin_lock_irqsave(&map->swap_lock, flags);

Please use guard(spinlock_irqsave) in new code instead of 
spin_lock_irqsave() + goto out_unlock + spin_unlock_irqrestore().
That will make this function significantly easier to read and to
maintain.

> +
> +	if (!map->cleared) {
> +		if (depth > 0) {
> +			word_mask = (~0UL) >> (BITS_PER_LONG - depth);
> +			/*
> +			 * The current behavior is to always retry after moving
> +			 * ->cleared to word, and we change it to retry in case
> +			 * of any free bits. To avoid dead loop, we need to take

What is a "dead loop"? Did you perhaps want to write "infinite loop"?

> +			 * wrap & alloc_hint into account. Without this, a soft
> +			 * lockup was detected in our test environment.

Source code comments should not refer to "our test environment". Code
that is intended for upstream inclusion should work for all setups.

> +			 */
> +			if (!wrap && alloc_hint)
> +				word_mask &= ~((1UL << alloc_hint) - 1);

Above I see an open-coded __clear_bit() operation. Has it been
considered to use __clear_bit() instead of open-coding it?

Thanks,

Bart.
