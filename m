Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0265FC87FDC
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 22:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbjFFW4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 18:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbjFFW4l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 18:56:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C21717
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 15:56:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso27280985e9.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jun 2023 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686092198; x=1688684198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxnH2bKFZYPbzBbkbYN/M0Q5lBbTzYSqgYP+SCcXSJI=;
        b=3Xvtk1P3rsuJwoQYdcNaIrVJbuVBsdvl8atd55hWaIz1KQGhnj3eu105ZBz04fe5o0
         bJBqSEdvv1cc1VTWGGz/fO6McIZaD29H2QTcZZowwJNcGQZ7t/UnfWNV4E7DFYs4JTZC
         JK8jOTDJZZkq3qXW+Rs6tHs8IFdoI//zMHB4kkQDJHBNiZ2aebLc012u3kSvYvcS3kJj
         2em5+3gUb2wOluV1JIZAmCMI9jEnW/0Z6RoKMgYKJVg730jOYRHsWmCAjO2NMqKy2EKb
         Pqk0NlLR8E1RenDJro9UPHBYgGqvnqPI3VYXLnLHUgMcg7uSMr3Px2KzI0+WFOK3XnFx
         r+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686092198; x=1688684198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxnH2bKFZYPbzBbkbYN/M0Q5lBbTzYSqgYP+SCcXSJI=;
        b=GvkwCRWELOSLllZNjMrxqYaU9UD+REl9BPOBIw1pFBUWZypC5abgTyoCa+Gfukn1TZ
         1/u85qpi7zVBNX63JxGqNMpA6yJ/yo1Uc6U76UYoQ/6XUTiCjkGrYRHIMIzYWpXbOtPY
         3/4/+sAnsrzhvOtFpOmmnfoMQeAwMxKmH1DcQ2EbKF5HSKTWJL8GtufKm9yZCvfc+fHz
         3KEcRsqLFSa9i5gNWYySo8F5klIMK8dGeKV6WqSaP4Ozi5opPNRjgCDFbuOAMUYza7ww
         KvCEsFB5Rw4TN9AqN2MJLRZ07CO0oxa5UNlaJGzNU1qRxk6Dz3W+bZOg1RqFFOK5myxj
         gP5g==
X-Gm-Message-State: AC+VfDxL3aG4N4jUcJRekZvdDLHT1p/jbHDe72wcHNGxh8M5ig/BxGTO
        HJWYyTsx+MwXmLv6HI+8y0ikbA==
X-Google-Smtp-Source: ACHHUZ5pQzUTLLtnHvgmo1ol8cE04EwQ5GBQgMMp4jQLTMwchBoXo98AWKbZj6A4D3QlrXQs6Z+F2A==
X-Received: by 2002:a5d:4711:0:b0:309:4e06:ff0b with SMTP id y17-20020a5d4711000000b003094e06ff0bmr2933775wrq.27.1686092198322;
        Tue, 06 Jun 2023 15:56:38 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d62ce000000b0030af54c5f33sm13658638wrv.113.2023.06.06.15.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:56:37 -0700 (PDT)
Date:   Tue, 6 Jun 2023 23:56:35 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/31] cdrom: remove the unused cdrom_close_write release
 code
Message-ID: <ZH+5oxuJzPnIlVxZ@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:23AM +0200, Christoph Hellwig wrote:
> cdrom_close_write is empty, and the for_data flag it is keyed off is
> never set.  Remove all this clutter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/cdrom/cdrom.c | 15 ---------------
>  include/linux/cdrom.h |  1 -
>  2 files changed, 16 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 245e5bbb05d41c..08abf1ffede002 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -978,15 +978,6 @@ static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
>  	cdi->media_written = 0;
>  }
>  
> -static int cdrom_close_write(struct cdrom_device_info *cdi)
> -{
> -#if 0
> -	return cdrom_flush_cache(cdi);
> -#else
> -	return 0;
> -#endif
> -}
> -
>  /* badly broken, I know. Is due for a fixup anytime. */
>  static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
>  {
> @@ -1282,12 +1273,6 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>  	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
>  		!(mode & FMODE_NDELAY);
>  
> -	/*
> -	 * flush cache on last write release
> -	 */
> -	if (CDROM_CAN(CDC_RAM) && !cdi->use_count && cdi->for_data)
> -		cdrom_close_write(cdi);
> -
>  	cdo->release(cdi);
>  	if (cdi->use_count == 0) {      /* last process that closes dev*/
>  		if (opened_for_data &&
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 4aea8c82d16971..0a5db0b0c958a1 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -61,7 +61,6 @@ struct cdrom_device_info {
>  	__u8 last_sense;
>  	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
>  	unsigned short mmc3_profile;	/* current MMC3 profile */
> -	int for_data;
>  	int (*exit)(struct cdrom_device_info *);
>  	int mrw_mode_page;
>  	__s64 last_media_change_ms;
> -- 
> 2.39.2
> 

All good, many thanks.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
