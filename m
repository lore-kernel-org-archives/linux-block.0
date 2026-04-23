Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E533F5A4
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978378; cv=none; b=SKmU1VqmKQ25kWlhIm0LW213XVP6JYgl4kZfplgumzlhnVSCDYghKGnE5/cmlDLVRUV1aLjrKdiO0ikBBl8vEeod1dJgMhUiBYQXsLH/Ts7xy/pTnIfBI3ChoZqL4+q7BNF9M43PuSUsw9Ha+DeEwDNZ5n1dLhvKYK09rb6I3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978378; c=relaxed/simple;
	bh=0FwnoU7crsng8ZdY1lihmMOcw4yZIHGTIaj/iUR76Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At4IXIMPzm8jNZIIBMEoO4FzF11zD/GksckKy5sxV1iRWiCBQJbOm5j7PCd/4dYpk3MAO0A+fg+zJmZ0mczoZXfmCxvCh15AT2b4Nwnry9ESrnRwiT8fwKgefgtCo9CAiDOLJvNbmNCk6hgqgn0JyrkB9intrxEjTchTbyCafh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=LqyluZUJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="LqyluZUJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso96967015e9.3
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1776978376; x=1777583176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oEVVbYJJp7mcAvHLiflerbUEp4PM9+aREz5+ZVnbHk=;
        b=LqyluZUJs3rOa2H72QmgULEYCpeLS3M9tPk/IwwqOLBpexwm33lPc2mv3fuj1ZSlhL
         /uruXMAVSD37FJ+7rugnSSrxJx71OA3ovtUatCCOUEyKAFCo8yifrvIljpzU+HWJ/DN4
         8oVNnfVUeX7SkD9HhlP32mDjzhvrKIoTVAptCiZ9YbDJ71abMlg09JgF3R0rcyPc1lLk
         A7jKDTSxop/b0neYPCbZa3bRQDY1bqWI0Z0o64nwB9AaC5PXfpGBEqmCdxVXVK/DRNTm
         hjxCUJYHN8gwzYHtugKBsi+b+MXWcbqNkM/fgUy0D0S6eH7fasVl3oav4MC3Zo19mvER
         8qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776978376; x=1777583176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oEVVbYJJp7mcAvHLiflerbUEp4PM9+aREz5+ZVnbHk=;
        b=L7ObTPrs9VffvfX36K1Xs/EJoR/Q5i6U7+q//iNMd3K9fGWmFD7tpKAvng54bXERaW
         0bh6Vy7IM6Rj4M/plHRAcrIsOM5gnTpJyAurE/VUrxGrOtlvnFI3+t6Mm568d/nkYrep
         OujvbwF2F85lmUMebbDqcihDjQJ8+5GvICDA6rebcQBCwC9kaGQtE1Ic3pxlFLAKJpcN
         WYjYnBW/oeBcOX/It5MSf6NwxPXprDwfqbPFkBrULF5b0y2Wwr7+7cuuvnZhDAZorEnk
         B0SqimnRUl6JG8SP/8ZrQKDaFpmKUfX2ut2VRQoh6C9wv7YW/O7Z0NT+8QLRyZ5ft1SZ
         vhaA==
X-Forwarded-Encrypted: i=1; AFNElJ9Hbex49nti25wuwf4EQQSJJJ3B3L/uAftpRq/tvHCLd7BGcajosLebMb4WxrQhN/pNFFV+rr7DxVzXLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRf6myNiNEhnJic9XYysWEkQjbCnnA3CdZrbNJBxxU+XL/h8W
	j9xul4+FsltICYpWTagGy0amk7jzeoPpbOzI3KNyg1QS2wFDa3w59BPXRaX/Mj5cnq8=
X-Gm-Gg: AeBDietUqxvsTN/BcuevN/Krkx2QEiExcSO3/q6kaG5i0UhIzpM9St/+Uy7Ejm6xvBF
	YaBO3h3DzR3BY8W4cwXL/nNTrHmt1V4E6+w7/aYTOpKk0sOFl1OnCqTFCk8tbxpJAo5aFQsdRog
	oWrDtoNIOr/lJBIQIwkP95XkZgPXJJWBFz/GV5ELAIbJFg52ktfQScvDxPBgtirvw+VKk7zRmm5
	v1LmJsMdLxFyAzKWFxhzVj8GmhJUEB7bAmRz4ieLujBpR0H8YNS8W0DTGx8UhhWawvjfd9KGRiM
	aQjcD0WKSW/JPPlxh3MCJ3uhLROc/VKCRuhri/VNi7Av2jKP0OGAICy3ZeCkKl9K3XjYX0MbMJ5
	/oldqCM6QzBRb/Dmjym1aGSwNwc3gitlR4Dyuw9pjzDUa14mtPsi4kwyVs28fM3nwGFqrPYcM6P
	bk+hfO1u6wQZVcL4VWTbD5PJ54b/vOBJXYYFRwcoJhN2AbkLMBjZH+37YIKX2MpHI9RFY6YGWkF
	GyulXtlpZlAJtl/9ipdSjXspAi6gZs=
X-Received: by 2002:a05:600c:a105:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488fb7826femr289011485e9.23.1776978375112;
        Thu, 23 Apr 2026 14:06:15 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffad20f2sm268386685e9.0.2026.04.23.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 14:06:14 -0700 (PDT)
Date: Thu, 23 Apr 2026 22:06:12 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	axboe@kernel.dk, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daan De Meyer <daan@amutable.com>
Subject: Re: [PATCH v2] cdrom, scsi: sr: propagate read-only status to block
 layer via set_disk_ro()
Message-ID: <aeqJxCKP6nm4iZDQ@equinox>
References: <20260330133403.796330-1-daan@amutable.com>
 <20260422113206.246267-1-daan@amutable.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422113206.246267-1-daan@amutable.com>

On Wed, Apr 22, 2026 at 11:32:06AM +0000, Daan De Meyer wrote:
> The cdrom core never calls set_disk_ro() for a registered device, so
> BLKROGET on a CD-ROM device always returns 0 (writable), even when the
> drive has no write capabilities and writes will inevitably fail. This
> causes problems for userspace that relies on BLKROGET to determine
> whether a block device is read-only. For example, systemd's loop device
> setup uses BLKROGET to decide whether to create a loop device with
> LO_FLAGS_READ_ONLY. Without the read-only flag, writes pass through the
> loop device to the CD-ROM and fail with I/O errors. systemd-fsck
> similarly checks BLKROGET to decide whether to run fsck in no-repair
> mode (-n).
> 
> The write-capability bits in cdi->mask come from two different sources:
> CDC_DVD_RAM and CDC_CD_RW are populated by the driver from the MODE
> SENSE capabilities page (page 0x2A) before register_cdrom() is called,
> while CDC_MRW_W and CDC_RAM require the MMC GET CONFIGURATION command
> and were only probed by cdrom_open_write() at device open time. This
> meant that any attempt to compute the writable state from the full
> mask at probe time was incorrect, because the GET CONFIGURATION bits
> were still unset (and cdi->mask is initialized such that capabilities
> are assumed present).
> 
> Fix this by factoring the GET CONFIGURATION probing out of
> cdrom_open_write() into a new exported helper,
> cdrom_probe_write_features(), and having sr call it from sr_probe()
> right after get_capabilities() has populated the MODE SENSE bits.
> register_cdrom() then calls set_disk_ro() based on the full
> write-capability mask (CDC_DVD_RAM | CDC_MRW_W | CDC_RAM | CDC_CD_RW)
> so the block layer reflects the drive's actual write support. The
> feature queries used (CDF_MRW and CDF_RWRT via GET CONFIGURATION with
> RT=00) report drive-level capabilities that are persistent across
> media, so a single probe before register_cdrom() is sufficient and the
> redundant probe at open time is dropped.
> 
> With set_disk_ro() now accurate, the long-vestigial cd->writeable flag
> in sr can go: get_capabilities() used to set cd->writeable based on
> the same four mask bits, but because CDC_MRW_W and CDC_RAM default to
> "capability present" in cdi->mask and aren't touched by MODE SENSE,
> the condition that gated cd->writeable was always true, making it
> unconditionally 1. Replace the corresponding gate in sr_init_command()
> with get_disk_ro(cd->disk), which turns a previously no-op check into
> a real one and also catches kernel-internal bio writers that bypass
> blkdev_write_iter()'s bdev_read_only() check.
> 
> The sd driver (SCSI disks) does not have this problem because it
> checks the MODE SENSE Write Protect bit and calls set_disk_ro()
> accordingly. The sr driver cannot use the same approach because the
> MMC specification does not define the WP bit in the MODE SENSE
> device-specific parameter byte for CD-ROM devices.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Daan De Meyer <daan@amutable.com>

Hi Daan,

Thank you for the patch. I will properly review it and build test etc.
this weekend and come back to you, hope that's ok.

Regards,
Phil
