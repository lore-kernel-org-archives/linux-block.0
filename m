Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC24C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789132077B
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLIRDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:03:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37883 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLIRDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 12:03:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so17117688wru.4;
        Mon, 09 Dec 2019 09:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:reply-to:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7QOUlkYUUcL9RJraaiKsihHk7jZjKK6PuheJk93ZnR8=;
        b=ctEOjv8hYW1/QL2SnxSD7+hHIKBNiMHTop+gaLx5eyNbx4ti9Pit40arXxbDgusB3P
         dOiAu0L9eNgHBH1hqDsDpQyl0hd0gEk9b+0Xhssne9CheyfgmUWV+hlQunTxwGBOa+Qf
         i9xRcfAhazyMkzeWzFLzhZ5uUrxe1Au/Fh5rpUsodcnupBInUb7/jewxaO4/KWHMXthu
         M62Y7g0WhDyG6BHYAkygS6qTL5bLYc6x1doUXFX6Vw1IfZgtSEaBPNCvNdkOtvLa/wB5
         yAi2W9yrrBImkKJk/9LQJcLQvK2/qh3n7V0lxWQkpZdhqbyIoym4AbiczPM7UdezZUqy
         h6NQ==
X-Gm-Message-State: APjAAAWSNAuIkdLCK0btiT1Au1PtgoNKvFnzbkegGlEHYQ3Qmaqw4ORw
        BmLfca3QO4I4ZplhLcLwNbs=
X-Google-Smtp-Source: APXvYqyXeQqJ7RT1D+Sl1ilUP24lFuVIODYGVL4QNseqeCGV72i6jF8Qc0eGYSNZhQo8KVsbqYHMSA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr3274981wrv.77.1575911032440;
        Mon, 09 Dec 2019 09:03:52 -0800 (PST)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id j12sm78312wrw.54.2019.12.09.09.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:03:51 -0800 (PST)
Subject: Re: [PATCH v3] floppy: hide invalid floppy disk types
To:     =?UTF-8?Q?Moritz_M=c3=bcller?= <moritzm.mueller@posteo.de>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Cc:     "Philip K ." <philip@warpmail.net>
References: <d3f0613c-6c3a-8efc-1c27-a6b75c34972f@gmail.com>
 <20191209093258.14319-1-moritzm.mueller@posteo.de>
Reply-To: efremov@linux.com
From:   Denis Efremov <efremov@linux.com>
Message-ID: <6e2c358c-6cfb-88cd-7bc8-3d4c87bb85be@linux.com>
Date:   Mon, 9 Dec 2019 20:03:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209093258.14319-1-moritzm.mueller@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 12/9/19 12:32 PM, Moritz Müller wrote:
> In some cases floppy disks are being indexed, even though no actual
> device exists. In our case this was caused by the CMOS-RAM having a few
> peculiar bits. This caused a non-existent floppy disk of the type 13 (in
> our case) to be registered as an possibly mountable device, even though
> it could not be mounted by any user.
> 
> We believe this to be an instance of this bug:
> 
>  https://bugzilla.kernel.org/show_bug.cgi?id=13486
>  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/384579
> 
> This patch adds the option FLOPPY_ALLOW_UNKNOWN_TYPES to prevent the
> additional check that fixed the issue on our reference system, and
> increases the startup time of affected systems by over a minute.
> 
> Co-developed-by: Philip K. <philip@warpmail.net>
> Signed-off-by: Philip K. <philip@warpmail.net>
> Signed-off-by: Moritz Müller <moritzm.mueller@posteo.de>

Thank you for the patch!

Have you tested your patch with FLOPPY_ALLOW_UNKNOWN_TYPES and without
FLOPPY_ALLOW_UNKNOWN_TYPES?

I will answer about motivation for this change in V2 branch of the patch.

> ---
>  drivers/block/Kconfig  | 10 ++++++++++
>  drivers/block/floppy.c |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 1bb8ec575352..9e6b32c50b67 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -72,6 +72,16 @@ config AMIGA_Z2RAM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called z2ram.
>  
> +config FLOPPY_ALLOW_UNKNOWN_TYPES
> +	bool "Allow floppy disks of unknown type to be registered."
> +	default n
> +	help
> +	  Select this option if you want the Kernel to register floppy
> +	  disks of an unknown type.
> +
> +	  This should usually not be enabled, because of cases where the
> +	  system falsely recognizes a non-existent floppy disk as mountable.
> +
>  config CDROM
>  	tristate
>  	select BLK_SCSI_REQUEST
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 485865fd0412..9439444d46d0 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3949,7 +3949,11 @@ static void __init config_types(void)
>  			} else
>  				allowed_drive_mask &= ~(1 << drive);
>  		} else {
> +#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
>  			params = &default_drive_params[0].params;
> +#else
> + 			params = UDP;
> +#endif
>  			snprintf(temparea, sizeof(temparea),
>  				 "unknown type %d (usb?)", type);
>  			name = temparea;

Maybe just skip the else branch completely here? This will omit
snprintf, following if (name) block and UDP update.

+#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
                        params = &default_drive_params[0].params;
                        snprintf(temparea, sizeof(temparea),
                                 "unknown type %d (usb?)", type);
                        name = temparea;
+#else
+                       continue;
+#endif


> @@ -4518,7 +4520,10 @@ static bool floppy_available(int drive)
>  		return false;
>  	if (fdc_state[FDC(drive)].version == FDC_NONE)
>  		return false;
> +#ifndef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
> +	if (UDP->cmos >= ARRAY_SIZE(default_drive_params))
> +		return false;
> +#endif
>  	return true;
>  }
>  
> 

Thanks,
Denis
