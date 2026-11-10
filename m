Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347248;
	b=e+SUY2B5e/Gb6zAOk2/X9AiG9zX7S4jzb/xFF84L+KLap8cDuU1VVxuJE9l3ME6M+LPd
	 /LNsWYvf7lDiVI34ZE/TEK0X1ntnxMZ9aRwG7cUuHQ5+z5yKftPMbDJHeM8A2NaOBBj9p
	 34LKv5XZS24drayrSZHIHxjiAPuS8Cz4L562lSUDegdmmYLUq65ayovkZkJ7WCHg5upWV
	 E1E3hKyyPqxDg5KEWDCEA3FvGGvLdVaaCVYREh0jrmmUr6uqh6urMrfcOKZ11owz9jiGP
	 747JKjb2qRw/l9XqzhC5SfQai9/Z5Lt9t5MoMtUvHROgElFuU+l7wBoLII7J60ziEeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=itQt7baLboByvaqThpANlw00X2jZNEvZSlvEBpjTN+A=;
	b=OynC1P2iQDSkM4B5mmtxo5fuQsb0+LDz1exbGFE8NasPhN8IVNI53eRuvxKk/p9lAANm
	 7bKklHSZSty9uk2srpcClPFR2UJ22YJnrqbjMl6b5f89aIA2BUTXCo9454Nv+W9jGfdyS
	 4TLPTQTzzzxqPonQp2sAcc5kGu1B8Kzficu9E6eRen0jsCpv7cl+D7q6PLTcL5qPxj23t
	 /t5gsWqfKVy1pNfxZJLwAnZkoy4Fh11P/pcDeJopc1mSPqrh3xDBlch5Lz9CZdh5rR8ox
	 dzHwvGqyJYAUGimP9M19e5L7FI/1lOda9HSCh1quIs2U89fDN/BZk9C3rDw+0+pPXYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20260707.gappssmtp.com header.i=@philpotter-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="W/KnlQ0D";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FE606A31C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 21:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E0FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20260707.gappssmtp.com header.i=@philpotter-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W/KnlQ0D
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so33321195e9.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20260707.gappssmtp.com; s=20260707; t=1794347245; x=1794952045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=itQt7baLboByvaqThpANlw00X2jZNEvZSlvEBpjTN+A=;
        b=W/KnlQ0DeIBoAK9St+jmdXu4f0Pu4sY6irZz2N4aJqAWfDFYOuXjqgjeH8qK//147d
         bQVUHJkmuXQjwKJ3kJSh8KPBQuHUuwuwQH7cJwMbD/H3f0VMVm3r8B2hVhcqWe37nYgJ
         kSWm87fIZHHJiquNv7AsRNAzf3VXY5ZkB7A17Qbzrwa5MTIQQuB/VEoag9r9KJcjDk15
         H68a+YqMTyE3NlAfgScs5kKT+Ck5P3gZvyIVuGnj0C+0xSo784bw4PFqU0nCs23AZh8u
         2FqlLwEv8ila/dWSUqxHGKr6oU59QigN1iEtpw1jDODJLrI8P3Zwv/6UGdhU4LpdtDvv
         ONbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347245; x=1794952045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itQt7baLboByvaqThpANlw00X2jZNEvZSlvEBpjTN+A=;
        b=FKECsxcriAybgIy74AIaQNvdCrZgvi1WoCmQS4Kdv49snNtwPNCCTih4zeDJDqUUF+
         1IAdQ40AmtTyFDaSF3osIgg5IAB18s9MSXvj39WoyYmq6HfUix2mqiz2yJAzefNh00xK
         bQo4XVee5HOH6+twv1kVUc//S3xAB1vQq8d4GltfsXoE0H4wLAZfclh74JmHFlev5iPt
         L7I4O6ammlfwht8vPpsLkGH04q0hs7qZZDR2lwyo1eJvyRNrHDYTxkNvXnp0iELUWn38
         1rsuoJIBuxXK6m2k+jdpjhGLdA4RQfl/I70Tnqrt6G45Pc+26mb/dTQW+xzBeVCpjWSA
         yYzQ==
X-Forwarded-Encrypted: i=1; AL+hErHfrUGXY649EzMilp1xAd+K/q2k6mUJRtju4E7bFmpe8UoldegooLab5QW/78Dviey4jC5OzXFf46piyg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8k4hjhVFULGbs+y1tx60v4DbJNuXP+tI0BmL9gUNVZrkvEZflz
	PiZKf+8+2zS8lUrHAAjLExj1UhBXoN1PMeSPKXm/a/VgSZILEJbw+enS0mEqG125/Do=
X-Gm-Gg: AYBFou2RNFmF7uma8bFh33uJdfOUlS0kvy1JW6VQ5UTg/BKXo1kSsxHntlwRC6HMd4E
	1r2hjithOIyJBVLhkKiyyb67RcU1lwKmzoqtnQlcmXfT1YoUwSYepPKOfx+6HMVXzRPEgknCKNW
	e4MIvvuW/vZWvci4cNJQgF7fMqYMGoQmrbVL0VtkitMrJan+jCdAcqm7Lr07AJVC1XhX+PHqk+x
	K42v2qOrYM0aODdT8PkHczGEA+tkl/xWD/eSm2Zw224hk1qj6D1ICpDQzXpRkumrzlsu9taK/Bb
	hwm1/EJm4ZCAZaw/P3frbmAu2QhaSN+DbVTRljCrysGwH2Lvcfx7f5TiHVwWlQ+o1/qUvUXYxZm
	adCs4SIGZrGcL2bNGuoO20AghLkQGv/jXM/Shl3MlNka4S4y8LEWJqYn3EDwfNcZ0E8FGyGAGWL
	JpR3fyf6MVPb1XpHByEbUrCjgJtfKZpaBoSnkNRcTEfHNh9hk/qeNDPkq0/TPmSp727VyzoC//n
	cJ9iaM/kZAT858dLykYyNR1zoYZZYcHlgDkCmP+Ctp0Z5PgbIhPaHYc83u19r95wlpUqvZjKfE=
X-Received: by 2002:a05:600c:4f81:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4ba09377c5amr6608315e9.8.1794347245373;
        Tue, 10 Nov 2026 13:47:25 -0800 (PST)
Received: from equinox ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe63e6sm138029575e9.7.2026.11.10.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:47:25 -0800 (PST)
Date: Tue, 10 Nov 2026 21:47:23 +0000
From: Phillip Potter <phil@philpotter.co.uk>
To: Jay Vadayath <jay@artiphishell.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	phil@philpotter.co.uk
Subject: Re: [PATCH] cdrom: bound the device-supplied offset in
 cdrom_mrw_set_lba_space
Message-ID: <avOQ66kCxOghtFp4@equinox>
References: <20261022181955.35758-1-jay@artiphishell.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022181955.35758-1-jay@artiphishell.com>

On Thu, Oct 22, 2026 at 11:19:55AM -0700, Jay Vadayath wrote:
> cdrom_mrw_set_lba_space() issues a MODE SENSE(10) into a 16-byte stack
> buffer (char buffer[16]), then takes offset = be16_to_cpu(mph->desc_length)
> straight from reply bytes 6..7 and does buffer[offset + 3] = space. The
> desc_length field is fully device-controlled (0..65535) and nothing
> checks that offset + 3 lies within the buffer, nor that size (derived
> from mode_data_length) fits. A drive that returns desc_length = 24 turns
> the assignment into buffer[27] = space, a one-byte write 12 bytes past
> the end of the stack buffer.
> 
> This runs when an MRW-writable CD-ROM is opened O_RDWR, so a malicious or
> buggy USB/ATAPI drive (or an emulated one) is enough: no privilege beyond
> being able to open /dev/sr0 for writing on an attacker-supplied device.
> The sink lives in the CD-ROM core, so it affects every cdrom driver
> (sr, ide-cd, pcd, gdrom).
> 
>   BUG: KASAN: stack-out-of-bounds in cdrom_mrw_set_lba_space.constprop.0+0x25c/0x260
>   Write of size 1 at addr ffff88800639f6db by task poc/133
>   Call Trace:
>    dump_stack_lvl+0x64/0x80
>    print_report+0xd0/0x630
>    kasan_report+0xe5/0x120
>    cdrom_mrw_set_lba_space.constprop.0+0x25c/0x260
>    cdrom_open+0x1169/0x2080
>    sr_block_open+0x9e/0x140
>    blkdev_get_whole+0x8c/0x200
>    bdev_open+0x214/0xc40
>    blkdev_open+0x1f8/0x370
>    do_dentry_open+0x408/0x1290
>    path_openat+0xb2f/0x2210
>    do_sys_openat2+0x126/0x170
>    ...
> 
> Both desc_length (offset) and mode_data_length (size) come straight from
> the device reply, so reject anything that would not fit in buffer:
> offset + 3 >= sizeof(buffer) or size > sizeof(buffer) returns -EIO before
> the write. The sibling cdrom_mode_select consumer of size is covered by
> the same guard.
> 
> This bug was discovered by Artiphishell's vTriage pipeline, which
> generated an emulated raw-gadget USB BOT CD-ROM (INQUIRY TYPE_ROM
> advertising MRW-write) plus an open(/dev/sr0, O_RDWR) client that drives
> the capability-probe chain (page 0x2a -> GET CONFIGURATION CDF_MRW ->
> MODE SENSE page 0x03 with desc_length = 24) and reliably triggers the
> KASAN report on an unpatched kernel. The fix below was drafted with the
> Claude coding assistant; a userspace reproducer is available on request.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jay Vadayath <jay@artiphishell.com>
> ---
>  drivers/cdrom/cdrom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 4f1fd389260f..5e910d79045f 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -571,6 +571,10 @@ static int cdrom_mrw_set_lba_space(struct cdrom_device_info *cdi, int space)
>  	offset = be16_to_cpu(mph->desc_length);
>  	size = be16_to_cpu(mph->mode_data_length) + 2;
>  
> +	/* Both fields are device-supplied; reject values that overflow buffer[]. */
> +	if (offset + 3 >= (int)sizeof(buffer) || size > (int)sizeof(buffer))
> +		return -EIO;
> +
>  	buffer[offset + 3] = space;
>  	cgc.buflen = size;
>  
> -- 
> 2.51.2
>

Hi Jay,

Finally got around to looking at this properly, sorry - been very busy
and life stuff happening too. The fix looks decent as far as I can see.
Can I ask a few things though please:

(1) Please drop the Assisted-by tag.
(2) Please remove reference to Claude itself, and mention just "LLM
    assistance" or such like if you want to (in the description).
(3) Likewise, please remove or substantially reduce the final paragraph.
    How the bug was found is (in my view at least) not relevant to the
    fix, and (perhaps unintentionally) could also read as an
    advertisement. The relevant information to the mechanism the patch
    guards against is all contained in your earlier paragraphs anyway.
(4) Given your inclusion of a call trace anyway, probably worth
    including a Fixes: tag. This may well just be 1da177e4c3f4 in this
    case, but it's a good way of signifying this is suitable for
    backporting.

Hope that's ok? Based on how the patch looks to me, I'm happy to take it
though provided the above is addressed and no other problems are
discovered during runtime testing.

Regards,
Phil
