Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40D2907;
	Mon, 23 Sep 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131313; cv=none; b=uQLnASsUYdWd01hzh9GbnjCYnM1j+VRciXnwDVvNi7CFnezYdgufQNMBUhXFzpSbHFnD/XDXprq2Aje1rH+GFsIP52XUaxILQ7K+vDaiuL0s9Rj7N0mnnhL8g7gEuRK+hnfTIUpZBoYGCCmV1WHsOzK9/92XSqLbnBkyrBb9S1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131313; c=relaxed/simple;
	bh=acQ5Pnzd1240AHA1UDSkE0rzkawSJCtsodK0HhGjupY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGpc6bE+aHrN8X1b+450kZHweTtmlekUHuJIICa/JsA0DhPsAZ7JYR3Heqd3AENnLhbjiuVVVTiaFUXjOz8CdF3a2oipG1l9DQHplaYTtALyQ8yPmStkRk1kGTCYFcK+B/nrYYUYNP9dIPg/cDpeF3lXd+jEoUKeR2dSYUUZfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkVopzGh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkVopzGh"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso2074085a12.1;
        Mon, 23 Sep 2024 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727131310; x=1727736110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mLSVu9L4HSBxCS6PoRCoaDYO+/BcP/6sIijJJk1cM4=;
        b=TkVopzGhojoWJZuP+5q2nf/+m81FlUchh8AY2jqVjk3mUSdlfWBwfSSJ6wbtxEfSLM
         GAm7t3oJTn2k7E3pxXiLyzXnpHcotVND13GmApvnmREXKCOpS/0bkqQ7z90HV1Y13S+j
         ZPRftuLD3deE77LOft//aWVbf/MhXBPcF97PRkKFA5FuJ/7lZLDNUVHI/MJDzHdMtAkT
         5NGGKp3S3QCKSqXwMPxk/wOnrEUiuyA7V/ii6t/30a82+9LfP/ihWk2jMWiZhONwBOjj
         g1n/Vwa8m/ygvsuxHfilxWyjrh6hjCnRC2SptGSye6oYrxDHIBcVi5wjTbSZHozI7vAq
         rzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131310; x=1727736110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mLSVu9L4HSBxCS6PoRCoaDYO+/BcP/6sIijJJk1cM4=;
        b=uTwg9rJlurmOd3p9C57Y4C063kAxqcBuF07A2GohvQkfLcP+WQe2LW5aJYR0DwdiAV
         QJZrL9Ru+S+eOP1RI0JAdRI748cg97/sEdSpOB0f8ARquRPQStCLHrC4IwQDRVHPUjwh
         mZeaNVw4/CiAFz/SHUlw+J7y21+7+PkWFVHULkjzprUJSSqTsX/4k1V2uV0ObvHHLFON
         lwguJujN9prhTqT9ZssENo071du1KWDmqSwdrx1zv7al4Ay/xu+cujuZZw9QevgS1leQ
         OW5WxgZmemZqMe/c8qEyd3E/iHjKHf/aa3HNHEqOczmWQ3bIf4ynbR5h84hPCkRXg/gI
         G/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1pVPZT0lnxnFXgeEftVnoa4ofO8UArHdZoTUxg3bYD8zOUbCw6RjlT6xU/VYDIUp5trKIjKk@vger.kernel.org, AJvYcCUEZ6eTozMzu/XR43mO0Zl1w8nGWGGrengDCE+A18ZuGpOlvem7Nm8az41FPLFsI1cBbHYmK6hwETNlMg==@vger.kernel.org, AJvYcCVR5aVbxawMg5TDIrPQVYiVQBdvJCxIvoYDoP5cPPOfdf3Q4fw0o6rsrU4HzuhxD8fluF1Spj3ga51yrRP+@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6fZASkRobU/VtdTscwgHbHHDM0IvPsW0QA3B7GdVflqSIi9Y
	W09uzpJQJMjj3D5h+LRD9joH04fLjO2ZZyaen0OGIl11dELN2lAc
X-Google-Smtp-Source: AGHT+IF5GT9BxceuPGXm9hIQeBh6VgNixEhx7RT03nonjeZH/Lkby1khb/iWWCk6+GdsPoYKqOE8PQ==
X-Received: by 2002:a17:907:9450:b0:a8d:7b7d:8c39 with SMTP id a640c23a62f3a-a90d59266demr1315351666b.43.1727131309679;
        Mon, 23 Sep 2024 15:41:49 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134c33sm8770666b.197.2024.09.23.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 15:41:48 -0700 (PDT)
Date: Tue, 24 Sep 2024 01:41:48 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <ZvHurCYlCoi1ZTCX@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>

On 24-09-23 19:40, Christophe JAILLET wrote:
> Le 23/09/2024 à 18:48, Andrey Skvortsov a écrit :
> > When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> > default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
> > so we need to make sure that we don't attempt to kfree() the
> > statically defined compressor name.
> > 
> > This is detected by KASAN.
> > 
> > ==================================================================
> >    Call trace:
> >     kfree+0x60/0x3a0
> >     zram_destroy_comps+0x98/0x198 [zram]
> >     zram_reset_device+0x22c/0x4a8 [zram]
> >     reset_store+0x1bc/0x2d8 [zram]
> >     dev_attr_store+0x44/0x80
> >     sysfs_kf_write+0xfc/0x188
> >     kernfs_fop_write_iter+0x28c/0x428
> >     vfs_write+0x4dc/0x9b8
> >     ksys_write+0x100/0x1f8
> >     __arm64_sys_write+0x74/0xb8
> >     invoke_syscall+0xd8/0x260
> >     el0_svc_common.constprop.0+0xb4/0x240
> >     do_el0_svc+0x48/0x68
> >     el0_svc+0x40/0xc8
> >     el0t_64_sync_handler+0x120/0x130
> >     el0t_64_sync+0x190/0x198
> > ==================================================================
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Fixes: 684826f8271a ("zram: free secondary algorithms names")
> > Cc: <stable@vger.kernel.org>
> > ---
> > 
> > Changes in v2:
> >   - removed comment from source code about freeing statically defined compression
> >   - removed part of KASAN report from commit description
> >   - added information about CONFIG_ZRAM_MULTI_COMP into commit description
> > 
> > Changes in v3:
> >   - modified commit description based on Sergey's comment
> >   - changed start for-loop to ZRAM_PRIMARY_COMP
> > 
> > 
> >   drivers/block/zram/zram_drv.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index c3d245617083d..ad9c9bc3ccfc5 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
> >   		zram->num_active_comps--;
> >   	}
> > -	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -		kfree(zram->comp_algs[prio]);
> > +	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > +		/* Do not free statically defined compression algorithms */
> > +		if (zram->comp_algs[prio] != default_compressor)
> > +			kfree(zram->comp_algs[prio]);
> 
> Hi,
> 
> maybe kfree_const() to be more future proof and less verbose?

kfree_const() will not work if zram is built as a module. It works
only for .rodata for kernel image. [1]

1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177

-- 
Best regards,
Andrey Skvortsov
