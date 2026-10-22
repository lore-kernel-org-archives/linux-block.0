Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712229;
	b=tYorJMDDyXvi5LHW2qHbVhnZExdmqdl0JTww49QRzbZm849BQDrowDdJ7+8SIeHnFABk
	 A4vxntfjZICoCTQ8SQaTHYBAGqNpyzitHqjlsQbWngmcne0K6ywlKUoK7+JfCKfSHWMlH
	 hF13DOPPtIDF+FxPmqdwEIRnBaInLbdpu2E3It+j+OiCe1xqydcwiesUdfYyVYv47TzWh
	 tIZezJGWTM+rg0BVgQJ2pJTEKYZB6Lfusp3/OEEvwREMOeRSEI6lztvwigeblOfx8p0Or
	 AY4ueD66fNzW/3Ymem15MXnlAfAlkpcfvm8f8mBqKAP0eGTjbH8QBnYwXWiRmJMNj1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DZe7BrAk5zBCkd0NeVHDBaZKn/NdewiBteLo8EHOX94=;
	b=rVojXkZzWffkJRPI/kMh/Equ4cT3oUax19ijERJNwDFC4yRWTdB/LEz8yNNwzIUAin+T
	 odSfijEFd1g59k6AMwXfzEttY4coIFh4+s6FDzkrmF4fNh3j6I3hVij7iEWgxUJOglP6T
	 nY3XLmNaEKZRwrfxh1cI1XdcNse8BbCv9Q4MD3DcBHYby8LfRDJLpK6yaLc0MdTCO4q6k
	 /9wYYkn5WyHXT/4YoEIguasGp91DOh8vjd+BrOzFjMr/+B9+DA+2gxtLKitzoD8ptlein
	 Ae0vVL6mJI15W6oCHgo4BrrQgUE9SFSaUFLBKQxKbbqL1YYWhaL+ecmGW90ng0E5fYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=bh4TBW65;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E9606A320
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 23:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271E9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=bh4TBW65
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j9jH24GgQz1XM4Tn;
	Thu, 22 Oct 2026 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792712220; x=1795304221; bh=DZe7BrAk5zBCkd0NeVHDBaZK
	n/NdewiBteLo8EHOX94=; b=bh4TBW65mfdCr3bhM7x62cD9Sce7Gp6+uAKrTowD
	Dkx9Jf9Wnzb+5Lb0HEByKGvnfHPWZzT8SzTc0XB1rOH5opYDvL2axdq3KunRu6ff
	zgfu4/Y/pVtR6ySZbS72PqIFJ0PySjOihJld1lG/sItFMj57cxQcRUmIlWm+5ckO
	LfpK3gy9C3XmVGWI1nnQZE05dyWORD1BSzpsPe15ZikgqBiHAIGOSx8jmPGnptSr
	i/sYzIpYBjqPUgn/v4zvbQOvmXCKry5obYHnj7Mh78I2cOxVW6TGKxzGY6IAQwiP
	st16bnYZFQMJmJNaPjVEwYoOrIRPokzQ0mwVH64E/CUdWA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MxR9ZLazOqAg; Thu, 22 Oct 2026 23:37:00 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j9jH00m7Gz1XM4Tl;
	Thu, 22 Oct 2026 23:36:59 +0000 (UTC)
Message-ID: <06d396ff-03bb-4bd0-800d-b09eead0ca62@acm.org>
Date: Thu, 22 Oct 2026 16:36:58 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: check for read-write open mode on LOOP_SET_STATUS
 in lo_compat_ioctl()
To: Dominik Maier <dmnk@google.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com
References: <20261022232114.2535802-1-dmnk@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261022232114.2535802-1-dmnk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 4:21 PM, Dominik Maier wrote:
 > In 64-bit lo_ioctl(), commit 7035b5df3c07 ("loop: cleanup set_status
 > interface") added a check requiring (mode & FMODE_WRITE) ||
 > capable(CAP_SYS_ADMIN) (now BLK_OPEN_WRITE) before allowing
 > LOOP_SET_STATUS or LOOP_SET_STATUS64, but the corresponding check was
 > omitted from 32-bit lo_compat_ioctl().

In the Linux kernel compat ioctl handlers allow 32-bit user-space 
applications to use ioctl() interfaces when running on a 64-bit kernel. 
They provide compatibility between the data layouts and calling 
conventions of 32-bit applications and the 64-bit kernel.
Hence, the above description is not correct. Please consider
rephrasing this as "lo_ioctl() ... but not lo_compat_ioctl(), the
handler used by 32-bit user space on 64-bit kernels".

 > Fixes: 7035b5df3c07 ("loop: cleanup set_status interface")

Commit 7035b5df3c07 is not the commit that introduced the bug fixed by
this patch. Since this bug may be as old as the loop driver, please
remove the Fixes: tag and add a Cc: stable@vger.kernel.org tag.

Thanks,

Bart.
