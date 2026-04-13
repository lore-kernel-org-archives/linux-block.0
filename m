Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC813282F3D
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096378; cv=none; b=LJ16AunPMolr+0AOhTDmPJYXSFFxv5p93ELXtVvxlnsRwbuPYjFSlgm0SyeJUzK2k5xXfFpZISfe1vSvYCcnXp63c22CEmILNsP2skAaxIVWzV8TET+Yf8DmBBjGgMJ60o3JyQl1LJOtKoJln7NvEUk4k3NrE0nJtnie1G+oF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096378; c=relaxed/simple;
	bh=FhVY7NBOQogmfepaJ7wjy6ak3lsL5/MmQzOcEk8UyGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxSkJOCmpNFPhpEkzDeYRzxy7tcDpPeOs+zdjf2NjhjAtQpOmeK85wYhuvqO2LyAd//o130hAODAFjNM4XkzlQQVMNEnandsnjFcyy9N6NGewLAWzvlj7VAFIfGb3/QYxb9ffm8YlzG1PmSljUfvZ4EVlEIOcfyVQbveRdLlIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KzSxYqTH; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KzSxYqTH"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fvXMX40lPzlkS9s;
	Mon, 13 Apr 2026 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776096372; x=1778688373; bh=VSI87XV2ZBkf3IwSXv2+Kein
	Zr+CRVrMAt4Khs3Dljc=; b=KzSxYqTH7jVYjhDLflWUlD3nrjBil6e9ZwicvVRM
	HECxC+DSP9djzX2aZheN6SkdJ9B/64iJ6Fh4wyYXalcQhrJO6rnjjAIsoyYLituk
	g3VkUdrTekhVf0rWMNrivTG7QjHIRac1mibo43EWkubHf6mDCm3wR1njM0zQTA3v
	LXgSMk7OIn0J0vJiYwc4EumjKNHIoesfz3/QfJKJYa+3/FRHJ4zE9zYqC4Rww/q9
	CSf9OxLjPUQZGHOSFbCiJA8iYpkmjaTZUFNUNkRJwlz4Cme0BcX/5JiuxiwPDBTM
	4WE/X7LTU2FYFv/mF2ewCxpaQdcYJrIhbQcmVLAm+bRhXQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GnyOLuQsKeUz; Mon, 13 Apr 2026 16:06:12 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fvXMP2YpkzlfgPZ;
	Mon, 13 Apr 2026 16:06:07 +0000 (UTC)
Message-ID: <2a2c46fb-c934-4ecc-b3cb-4e4114a6d6bf@acm.org>
Date: Mon, 13 Apr 2026 09:06:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback
 invocations
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
 <20260402183950.3626956-3-bvanassche@acm.org> <20260409064221.GA8378@lst.de>
 <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org>
 <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
 <08078df0-d3e6-4860-b22b-937035d45857@acm.org>
 <CANpmjNONpHgSzavkbqdbM2N0oCtt2_2+UqBCMWjMaWEcWrCy4w@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNONpHgSzavkbqdbM2N0oCtt2_2+UqBCMWjMaWEcWrCy4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/26 11:00 PM, Marco Elver wrote:
> For now, that's intended - focus is on getting rid of false positives.
> Doing what you suggest above would require abusing the attributes to
> effectively become type qualifiers; that's generally questionable,
> because that's not what attributes are meant to do (and reworking TSA
> to provide real type-qualifiers is an intrusion into the type system
> that's also a hard sell). So for now, I'll try to do the simpler
> change, and later may look into adding -Wthread-safety specific
> warnings that points out such mismatches.

Is there agreement that the Linux kernel Clang build shouldn't break, no
matter what version of Clang is used to build the kernel (ignoring Clang
bugs)? If so, I think we either need a new macro to annotate function
pointers or thread-safety checking has to be disabled for Clang versions
that do not support annotating function pointers.

If I annotate function pointers with __releases() then the following
error message is reported with a Clang compiler built from the LLVM main
branch:

In file included from block/blk-core.c:16:
In file included from ./include/linux/module.h:20:
In file included from ./include/linux/elf.h:6:
In file included from ./arch/x86/include/asm/elf.h:10:
In file included from ./arch/x86/include/asm/ia32.h:7:
In file included from ./include/linux/compat.h:17:
./include/linux/fs.h:2309:55: error: use of undeclared identifier 'sb'
  2309 |         void (*kill_sb) (struct super_block *sb) 
__releases(&sb->s_umount);
       |

How to prevent such error messages? Is adding the capability to the
Linux kernel to detect whether or not annotating function pointers is
supported and introducing a new macro for annotating function pointers
the only solution?

Additionally, the __release() annotations introduced by this patch will
have to be surrounded by an #ifdef/#endif pair or thread-safety checking
in the Linux kernel will have to be disabled for Clang versions that do
not support adding attributes to function pointers.

Thanks,

Bart.


