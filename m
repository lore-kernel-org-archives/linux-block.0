Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA04C433EF
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 23:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB68461059
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 23:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347973AbhIHXxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 19:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347582AbhIHXxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Sep 2021 19:53:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28908C061575
        for <linux-block@vger.kernel.org>; Wed,  8 Sep 2021 16:52:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g74so37125wmg.5
        for <linux-block@vger.kernel.org>; Wed, 08 Sep 2021 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A/rM2O5/A2FhXHXESU/Q8d+5ciP9HhcOB/wYb8/CKq0=;
        b=JchQVN3cbM6z5ETIE1AwPdpZoU34ewvXRUVlqGT1bGnJRjhVWjjfKTzoKi2Kva6rDk
         N7U+DNiGrqVMu+i5iWJfllv0TssMGWBHFln7oek3uTI45znIiSIMW4Kgtbk6+4UTFKiR
         Q5gBD8CaIfxk86K8BC/dPYo/1m6wz8xFAQAri7Mmy4b9ea7jIfzNdxVVops0OW+ijtjE
         VROhg0Z2Ed80LydJSWuosvK9A+84xUPHgS+fUKjFW+x8di5snAZr9Z9ulPVe2bC/XAqt
         QEN3TtGKGqCYKPIOI03cJJZzy99TR9hP2877Y/8GLgLoXAo3mr1NKIEkVVEboRdobG+x
         OqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/rM2O5/A2FhXHXESU/Q8d+5ciP9HhcOB/wYb8/CKq0=;
        b=WAlw+2+LG3gato//Do8W1jPu5CLO3y4p7V94TH5GNnj+e+6/6i2W/wRxC8jYIbzvdB
         4kQDWVCGvBtLZd4pCIgAiUxUg5WxYJtgkM9tWxpQpFBrAiJfCWGHJ3OOLCFtl/bOlLoI
         tKF9FDy2AYr9pZFEOsH4ZHGDjER6X+g9pOqQ2dMhW9ns6RUUT91UJauGDbej8zQtG5AZ
         7GKO4OyThdsXf6ZKa2Fq7gDt70VFvwqnxAp+uHI8oRmtHw4ARvgrtG/IRxhibVHsgd17
         CNK3IrWk4rNNYYXMlwOaC/kTMPxBNTApBsbnUTmQGwmn8wCFXPvjdi9NMRjWGabKUGy0
         rJ6g==
X-Gm-Message-State: AOAM5302jXDcHcjbs7OHWm2x8YtbBYcuvPVj3nknqz3/cLgUXEHQH147
        dciOXPhF3+Jd3k8har3+dq1K1Q==
X-Google-Smtp-Source: ABdhPJwOZj3wbCg4e9yTSUqAduGz7nIJu4UwbrKoGVyP6dherJWk+rHMG/N09yVixLe5ptXnh1hX/Q==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr23818wmr.89.1631145121680;
        Wed, 08 Sep 2021 16:52:01 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id v12sm91305wrm.7.2021.09.08.16.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:52:00 -0700 (PDT)
Date:   Thu, 9 Sep 2021 00:51:58 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Lukas Prediger <lumip@lumip.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTlMnjyIMHHIGiPe@equinox>
References: <20210829143735.512146-1-lumip@lumip.de>
 <65bf6d1a-f65d-910c-60c7-0a4911a52e9a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bf6d1a-f65d-910c-60c7-0a4911a52e9a@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 02:11:31PM -0600, Jens Axboe wrote:
> On 8/29/21 8:37 AM, Lukas Prediger wrote:
> > The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> > global state, meaning that only one process can detect a disc change
> > while the ioctl call will return 0 for other calling processes afterwards
> > (see bug 213267 ).
> > 
> > This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
> > works by maintaining a timestamp of the last detected disc change instead
> > of a boolean flag: Processes calling this ioctl command can provide
> > a timestamp of the last disc change known to them and receive
> > an indication whether the disc was changed since then and the updated
> > timestamp.
> > 
> > I considered fixing the buggy behavior in the original
> > CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
> > for each calling process in the kernel, which seems like a worse
> > solution than introducing this new ioctl.
> 
> This looks pretty good to me now. Adding Phillip to the CC, he's the new
> CDROM maintainer. Leaving the rest of the message below intact because
> of that.
> 
> 
> > Signed-off-by: Lukas Prediger <lumip@lumip.de>
> > ---
> > Second version based on your feedback for the first
> > attempt. Please let me know if further changes are required.
> > ---
> >  Documentation/cdrom/cdrom-standard.rst      | 11 ++++
> >  Documentation/userspace-api/ioctl/cdrom.rst |  3 ++
> >  drivers/cdrom/cdrom.c                       | 56 +++++++++++++++++++--
> >  include/linux/cdrom.h                       |  1 +
> >  include/uapi/linux/cdrom.h                  | 15 ++++++
> >  5 files changed, 82 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
> > index 5845960ca382..52ea7b6b2fe8 100644
> > --- a/Documentation/cdrom/cdrom-standard.rst
> > +++ b/Documentation/cdrom/cdrom-standard.rst
> > @@ -907,6 +907,17 @@ commands can be identified by the underscores in their names.
> >  	specifies the slot for which the information is given. The special
> >  	value *CDSL_CURRENT* requests that information about the currently
> >  	selected slot be returned.
> > +`CDROM_TIMED_MEDIA_CHANGE`
> > +	Checks whether the disc has been changed since a user supplied time
> > +	and returns the time of the last disc change.
> > +
> > +	*arg* is a pointer to a *cdrom_timed_media_change_info* struct.
> > +	*arg->last_media_change* may be set by calling code to signal
> > +	the timestamp of the last known media change (by the caller).
> > +	Upon successful return, this ioctl call will set
> > +	*arg->last_media_change* to the latest media change timestamp (in ms)
> > +	known by the kernel/driver and set *arg->has_changed* to 1 if
> > +	that timestamp is more recent than the timestamp set by the caller.
> >  `CDROM_DRIVE_STATUS`
> >  	Returns the status of the drive by a call to
> >  	*drive_status()*. Return values are defined in cdrom_drive_status_.
> > diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> > index 3b4c0506de46..bac5bbf93ca0 100644
> > --- a/Documentation/userspace-api/ioctl/cdrom.rst
> > +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> > @@ -54,6 +54,9 @@ are as follows:
> >  	CDROM_SELECT_SPEED	Set the CD-ROM speed
> >  	CDROM_SELECT_DISC	Select disc (for juke-boxes)
> >  	CDROM_MEDIA_CHANGED	Check is media changed
> > +	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
> > +					since given time
> > +					(struct cdrom_timed_media_change_info)
> >  	CDROM_DRIVE_STATUS	Get tray position, etc.
> >  	CDROM_DISC_STATUS	Get disc type, etc.
> >  	CDROM_CHANGER_NSLOTS	Get number of slots
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index feb827eefd1a..a040a867f6a2 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -344,6 +344,12 @@ static void cdrom_sysctl_register(void);
> >  
> >  static LIST_HEAD(cdrom_list);
> >  
> > +static void signal_media_change(struct cdrom_device_info *cdi)
> > +{
> > +	cdi->mc_flags = 0x3; /* set media changed bits, on both queues */
> > +	cdi->last_media_change_ms = ktime_to_ms(ktime_get());
> > +}
> > +
> >  int cdrom_dummy_generic_packet(struct cdrom_device_info *cdi,
> >  			       struct packet_command *cgc)
> >  {
> > @@ -616,6 +622,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
> >  	ENSURE(cdo, generic_packet, CDC_GENERIC_PACKET);
> >  	cdi->mc_flags = 0;
> >  	cdi->options = CDO_USE_FFLAGS;
> > +	cdi->last_media_change_ms = ktime_to_ms(ktime_get());
> >  
> >  	if (autoclose == 1 && CDROM_CAN(CDC_CLOSE_TRAY))
> >  		cdi->options |= (int) CDO_AUTO_CLOSE;
> > @@ -1421,8 +1428,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
> >  		cdi->ops->check_events(cdi, 0, slot);
> >  
> >  	if (slot == CDSL_NONE) {
> > -		/* set media changed bits, on both queues */
> > -		cdi->mc_flags = 0x3;
> > +		signal_media_change(cdi);
> >  		return cdrom_load_unload(cdi, -1);
> >  	}
> >  
> > @@ -1455,7 +1461,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
> >  		slot = curslot;
> >  
> >  	/* set media changed bits on both queues */
> > -	cdi->mc_flags = 0x3;
> > +	signal_media_change(cdi);
> >  	if ((ret = cdrom_load_unload(cdi, slot)))
> >  		return ret;
> >  
> > @@ -1521,7 +1527,7 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
> >  	cdi->ioctl_events = 0;
> >  
> >  	if (changed) {
> > -		cdi->mc_flags = 0x3;    /* set bit on both queues */
> > +		signal_media_change(cdi);
> >  		ret |= 1;
> >  		cdi->media_written = 0;
> >  	}
> > @@ -2391,6 +2397,46 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Media change detection with timing information.
> > + *
> > + * arg is a pointer to a cdrom_timed_media_change_info struct.
> > + * arg->last_media_change may be set by calling code to signal
> > + * the timestamp (in ms) of the last known media change (by the caller).
> > + * Upon successful return, ioctl call will set arg->last_media_change
> > + * to the latest media change timestamp known by the kernel/driver
> > + * and set arg->has_changed to 1 if that timestamp is more recent
> > + * than the timestamp set by the caller.
> > + */
> > +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
> > +		unsigned long arg)
> > +{
> > +	int ret;
> > +	struct cdrom_timed_media_change_info __user *info;
> > +	struct cdrom_timed_media_change_info tmp_info;
> > +
> > +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
> > +		return -ENOSYS;
> > +
> > +	info = (struct cdrom_timed_media_change_info __user *)arg;
> > +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
> > +
> > +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
> > +		return -EFAULT;
> > +
> > +	tmp_info.has_changed = ((tmp_info.last_media_change - cdi->last_media_change_ms) < 0);
> > +	tmp_info.last_media_change = cdi->last_media_change_ms;
> > +
> > +	if (copy_to_user(info, &tmp_info, sizeof(*info)) != 0)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
> >  		unsigned long arg)
> >  {
> > @@ -3375,6 +3421,8 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
> >  		return cdrom_ioctl_eject_sw(cdi, arg);
> >  	case CDROM_MEDIA_CHANGED:
> >  		return cdrom_ioctl_media_changed(cdi, arg);
> > +	case CDROM_TIMED_MEDIA_CHANGE:
> > +		return cdrom_ioctl_timed_media_change(cdi, arg);
> >  	case CDROM_SET_OPTIONS:
> >  		return cdrom_ioctl_set_options(cdi, arg);
> >  	case CDROM_CLEAR_OPTIONS:
> > diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> > index f48d0a31deae..7c10b564db29 100644
> > --- a/include/linux/cdrom.h
> > +++ b/include/linux/cdrom.h
> > @@ -64,6 +64,7 @@ struct cdrom_device_info {
> >  	int for_data;
> >  	int (*exit)(struct cdrom_device_info *);
> >  	int mrw_mode_page;
> > +	__s64 last_media_change_ms;
> >  };
> >  
> >  struct cdrom_device_ops {
> > diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
> > index 6c34f6e2f1f7..9b17868667ed 100644
> > --- a/include/uapi/linux/cdrom.h
> > +++ b/include/uapi/linux/cdrom.h
> > @@ -147,6 +147,8 @@
> >  #define CDROM_NEXT_WRITABLE	0x5394	/* get next writable block */
> >  #define CDROM_LAST_WRITTEN	0x5395	/* get last block written on disc */
> >  
> > +#define CDROM_TIMED_MEDIA_CHANGE   0x5396  /* get the timestamp of the last media change */
> > +
> >  /*******************************************************
> >   * CDROM IOCTL structures
> >   *******************************************************/
> > @@ -295,6 +297,19 @@ struct cdrom_generic_command
> >  	};
> >  };
> >  
> > +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
> > +struct cdrom_timed_media_change_info
> > +{
> > +	__s64	last_media_change;	/* Timestamp of the last detected media
> > +					 * change in ms. May be set by caller, updated
> > +					 * upon successful return of ioctl.
> > +					 */
> > +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
> > +					 * change was more recent than
> > +					 * last_media_change set by caller.
> > +					 */
> > +};
> > +
> >  /*
> >   * A CD-ROM physical sector size is 2048, 2052, 2056, 2324, 2332, 2336, 
> >   * 2340, or 2352 bytes long.  
> > 
> 
> 
> -- 
> Jens Axboe
> 

Dear Lukas,

I've now tested your patch, and it works perfectly for me. Also, I have
reviewed the code in more detail and it seems very good. For that
reason, I'm happy to send on to Jens for merging, provided the
previously mentioned struct bracket issue is sorted - as it is so
minor, I can do this for you when I send it on if you're happy with
that, to save you resubmitting? Let me know.

Many thanks for your work on this, much appreciated.

Regards,
Phil
