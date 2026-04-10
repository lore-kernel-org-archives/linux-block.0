Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527129E114
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841466; cv=none; b=qDwRXKgiFa0zz4/p/auHAnnJiwcmcjKDJuLpoaBcjbykoq04eit6TKGtnGLJvPfxOP4ug4TtG0HtcKnfakhKRvn1xRccPY/+teQSBFNRM6v0li7w56bbCjjMEMP4VC5r6IXHZWhdCfgDQ3ny9XiDnrEHzaa5DAFI15C58RhtSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841466; c=relaxed/simple;
	bh=yH2VjPYAV2mfZ0QU6BsZbPM2CjA0lDI8TQUgJbFj0ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO7Zxzx5ToOQHiovEhm4u1a2xBZ9kMXKbRzVq6dW73iqQycclomybsSrdQNNDDhvnSyV6lm+ZdMnGwOd35FvxZfmoJBfjY0NVgJcyGqN7fXnLxnvOAZRuNssDClX8M1oZq6fznFRV5M6b5rZJsovnZ9/hIGRcszaT3wzR17xuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4GjM0UlE; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4GjM0UlE"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fsk5N6g3cz1XM6J6;
	Fri, 10 Apr 2026 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775841460; x=1778433461; bh=PDjgSW4OxB0YGCLBKCXNwdN/
	a873QHh95uMPm+thWbI=; b=4GjM0UlEPBvlKC4Qc9F6bxRKhppuIN/AvaJUfgoA
	MDi8YCC4LtiQXhrQxjpKTIhBvGStSKE0iObY+z2r9XLUFoM89R881JSSCNC+MDG0
	CgHXphGwRT2WArVRo6xmoAA55EZxQZt3HMEXtyfwI7qrxFHKbYSmGz2J/RbcswFn
	4HFEKJdmuI6DXTmAODm2VW0B0QmarRvsihBnIq6UYIfB+7Pw9DS1jDNKMOU6nViT
	YYwp0rImiJuHv/V1a316ZMb9R22fWQjlNVKYT5GXcfkwTREaXi/40a8gEY5HTCfP
	MWhAI0iYreQOgXxycedWFol4nQQe3f0TOqRCPBI626dT5Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id liyZgdLdP5Ts; Fri, 10 Apr 2026 17:17:40 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fsk5G2nFMz1XM31H;
	Fri, 10 Apr 2026 17:17:38 +0000 (UTC)
Message-ID: <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org>
Date: Fri, 10 Apr 2026 10:17:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback
 invocations
To: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
 <20260402183950.3626956-3-bvanassche@acm.org> <20260409064221.GA8378@lst.de>
 <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/26 6:27 AM, Marco Elver wrote:
> On Thu, 9 Apr 2026 at 08:42, Christoph Hellwig <hch@lst.de> wrote:
>> On Thu, Apr 02, 2026 at 11:39:34AM -0700, Bart Van Assche wrote:
>>> The four callback functions in blk_holder_ops all release the
>>> bd_holder_lock. Add __release() annotations where appropriate to prepare
>>> for enabling thread-safety analysis. Explicit __release() annotations have
>>> been added since Clang does not support adding a __releases() annotation
>>> to a function pointer.
>>
>> I have to say I still hate this with passion.  If we can't propagate
>> the lock context over function pointers it isn't ready for prime time
>> unfortunately, as much as I'm looking forward to it.
> 
> Let's see if we can land this: https://github.com/llvm/llvm-project/pull/191187
> 
> I think we'll be bumping min Clang version to 23 for context analysis,
> so hopefully it'll be included in Clang 23 and should solve the
> function pointer false positives.

That LLVM patch does not seem sufficient to address Christoph's concern.
If I apply that LLVM patch on my local LLVM tree, and if I apply the
following patch to the Linux kernel source tree:

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e354b771a8ad..81b8064b4612 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1741,22 +1741,26 @@ void blkdev_show(struct seq_file *seqf, off_t 
offset);
  #endif

  struct blk_holder_ops {
-       void (*mark_dead)(struct block_device *bdev, bool surprise);
+       void (*mark_dead)(struct block_device *bdev, bool surprise)
+               __releases(&bdev->bd_holder_lock);

         /*
          * Sync the file system mounted on the block device.
          */
-       void (*sync)(struct block_device *bdev);
+       void (*sync)(struct block_device *bdev)
+               __releases(&bdev->bd_holder_lock);

         /*
          * Freeze the file system mounted on the block device.
          */
-       int (*freeze)(struct block_device *bdev);
+       int (*freeze)(struct block_device *bdev)
+               __releases(&bdev->bd_holder_lock);

         /*
          * Thaw the file system mounted on the block device.
          */
-       int (*thaw)(struct block_device *bdev);
+       int (*thaw)(struct block_device *bdev)
+               __releases(&bdev->bd_holder_lock);
  };

  /*

then the following errors appear while building the Linux kernel tree
with Clang:

In file included from block/blk-core.c:18:
./include/linux/blkdev.h:1745:15: error: use of undeclared identifier 'bdev'
  1745 |                 __releases(&bdev->bd_holder_lock);
       |                             ^~~~
./include/linux/blkdev.h:1751:15: error: use of undeclared identifier 'bdev'
  1751 |                 __releases(&bdev->bd_holder_lock);
       |                             ^~~~
./include/linux/blkdev.h:1757:15: error: use of undeclared identifier 'bdev'
  1757 |                 __releases(&bdev->bd_holder_lock);
       |                             ^~~~
./include/linux/blkdev.h:1763:15: error: use of undeclared identifier 'bdev'
  1763 |                 __releases(&bdev->bd_holder_lock);
       |                             ^~~~


Thanks,

Bart.
