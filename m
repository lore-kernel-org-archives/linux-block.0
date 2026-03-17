Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F234678E
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765383; cv=none; b=Kx+x9CO8JDy3Mc9bYtcsOo7A/eeIoCfqG+maVasn0UQYDHdxevCGeWA/A0vgAM31RG0atneIcgHYe2m7qMGmw5l8FXe7OwBZoKNEBUT0dYfaYRRTfNbbnutStixKMQauBnjfUpXNza6/NEg93OkRnNBUIJ9kCUEQXcie3Cr0JGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765383; c=relaxed/simple;
	bh=XkRMh7EmDUyNCX1t1plKdIKHAPzd6mxy2iI0nFtWsYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLYEancZWj/cLuzlWBsZEW+4LyWrdCVWsO/f/YmYs6hnX5bsAkbkr/IZtsZj2c2L2CQnaucbwZ5zk87FbrQo64cfUumH2IDRWFNjxdlDZ+gW2h6wg1HU7vT6BKHk3BHre7ew2y+VK0lMU/Iryr44dKNt1uV5n5cogSxhsm6Pv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bnmlaQ5p; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bnmlaQ5p"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fZyJj5xM5z1XM0pH;
	Tue, 17 Mar 2026 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773765371; x=1776357372; bh=+GLQ0cuq+YiBGm/thG0rCv0R
	4fROyS3t4htvRvr9mvo=; b=bnmlaQ5pdrJWk2y5UhesZDwC5OEUeka4L0TPd017
	KfRL5ZLWuRWiuCAOFDFkott0+zis53hXX68NIVPjwkGfQnPNZ2KOV8LUk+Umz/HS
	+JGBEF63utEcJWC9FIuwa4SN37M9nwQV+A5v7QmClfgL3CcTysYoqb311sFJjgv9
	XzbrbgIlbsMks+IxyutwfJ7DoCUa+7sWG1nA/WBDDSXcN1BzmOkzf2mvzXfq7RXI
	ZGvJXtYAj2tIhMaFC7MjYPQsDeFnQCMev8B9kevZm+HDzB0dl5/wN9N37R2MA8CV
	Nlt8EWXrANa+Z5exH+zARXAm5Jae1ifrbUW5fZN2V8PKmA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6FU34_-vl-td; Tue, 17 Mar 2026 16:36:11 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fZyJS3wc8z1XM5kD;
	Tue, 17 Mar 2026 16:36:08 +0000 (UTC)
Message-ID: <5f77416a-e7ac-4355-b536-62232429bc77@acm.org>
Date: Tue, 17 Mar 2026 09:36:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] block: Make the lock context annotations
 compatible with Clang
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 David Hildenbrand <david@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20260316200901.4111651-1-bvanassche@acm.org>
 <20260316200901.4111651-4-bvanassche@acm.org> <20260317140448.GB2670@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260317140448.GB2670@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/26 7:04 AM, Christoph Hellwig wrote:
> On Mon, Mar 16, 2026 at 01:08:39PM -0700, Bart Van Assche wrote:
>> Clang is more strict than sparse with regard to lock context annotation
>> checking. Hence this patch that makes the lock context annotations
>> compatible with Clang.
> 
> Does it break sparse in the way?  If so we'll need to find out a way
> to disable the sparse lock annotations conditionally as there are
> other warnings we only get from spare.  Most importantly the __bitwise
> warnings for endianess and the address spaces for user/mmio pointers.
> All these are arguably more important than the lock annotations.
> (If only the compilers could pick these up natively...)

Agreed that the __bitwise annotations and sparse support for these
annotations are important. The following patch has been queued by Peter
Zijlstra to restore support for analyzing the kernel with sparse:
"[PATCH] include/linux/local_lock_internal.h: Make this header file 
again compatible with sparse"
(https://lore.kernel.org/all/20260311231455.1961413-1-bvanassche@acm.org/)

 From that patch:

-----------------------------------------------------------------------
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -315,7 +315,7 @@ do {								\

  #endif /* CONFIG_PREEMPT_RT */

-#if defined(WARN_CONTEXT_ANALYSIS)
+#if defined(WARN_CONTEXT_ANALYSIS) && !defined(__CHECKER__)
  /*
   * Because the compiler only knows about the base per-CPU variable, 
use this
   * helper function to make the compiler think we lock/unlock the @base 
variable,
-----------------------------------------------------------------------

Note: lock context annotations are ignored if the kernel is analyzed
with sparse. See also commit 5b63d0ae94cc ("compiler-context-analysis:
Remove Sparse support").

Thanks,

Bart.
