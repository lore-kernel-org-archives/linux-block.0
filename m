Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578EBC433F5
	for <linux-block@archiver.kernel.org>; Thu,  7 Oct 2021 23:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E166135E
	for <linux-block@archiver.kernel.org>; Thu,  7 Oct 2021 23:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhJGXG5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Oct 2021 19:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhJGXG4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Oct 2021 19:06:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C31C061755
        for <linux-block@vger.kernel.org>; Thu,  7 Oct 2021 16:05:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so23743413wrc.10
        for <linux-block@vger.kernel.org>; Thu, 07 Oct 2021 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYQMWLLbu4oAeC9vWdtr95CG6fnYY9mz2J/L0vi71cM=;
        b=AUwYbpgNqT4cwYjyKzu/7Ew6CwM9L/Pmrv57z24yxHmZ6yu/abf7ATX0pRIDQcDeRV
         VHPQaQ9l+73am/TpokQUOyZNW4swT0ovKgbxUuomZ8w3vlcitN2X180iWy7me5qGT5WX
         fCnEi5RjOpy6gDIs6wvzkh6XuWZFy/7ffWtV2MPC3ooAUMyEKmoQPkGgjquBNVvuMdxp
         wYEj3ktCmDRZF8M2vtYJT2YbVPWtg+Ua5ukxJtxl7aQmm+0wISPHR6qv5jVyaN66Ceqn
         V4q4ZHwdneVkgzNomhDvXwy7vdaqnM+wsVFFc/CfUWLsnA/24gx6JOWo84HNCORwhTuI
         l23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYQMWLLbu4oAeC9vWdtr95CG6fnYY9mz2J/L0vi71cM=;
        b=r9cTEKwoCMs1b8nVN9CkxhC448sUE68FDNM5lHHF2T9FZ4+2HQtwe8OtlY+DuL5BXS
         gj+yl4TzKU/TbcLEPSYPtVQC65P9KIR9rX4LeJeb78xLc+JFIqO1PC2fpKgNSWzKJN47
         0zRKQ2HMWtZI7wRIdRou8BXUrkQm4AmqxXzrWZNvwXS4k019rt3TGjdNfILo+XZdPZNA
         NskawdEkOnYpetklRJKkTjcHKBbmhuReilSaZu60sRjNddVHkJM9HrfilZNDp8EUQNe/
         OfWXUhx+qpcqddAJcIyUHj9MXM3xil3MbMOZFawBVihPRFXv+smh4TPt+gxFW5m/d3HN
         Faew==
X-Gm-Message-State: AOAM531Ljr+cpGqT09lX7FtVWoad8gvuU9hZTJTxR5Y8yVrFtIPyB45f
        Sjg5dBz8NeSSXO8LrRFxIypeYQ==
X-Google-Smtp-Source: ABdhPJzXWDSN4tZQ5R4ID5njTcxHUIsRt5nqG+rUxTVCuAV+xTWjfh9+vrQa1i3ZAW3jxKeT5mxnyQ==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr7448068wmk.143.1633647900215;
        Thu, 07 Oct 2021 16:05:00 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h17sm636754wrx.55.2021.10.07.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 16:04:59 -0700 (PDT)
Date:   Fri, 8 Oct 2021 00:04:57 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Prediger <lumip@lumip.de>
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YV99GcLzSuWFQFl0@equinox>
References: <YT5BO7bUMMkwNCTh@equinox>
 <20210912191207.74449-1-lumip@lumip.de>
 <42492b83-8741-786d-1b6e-cdd122576ae3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42492b83-8741-786d-1b6e-cdd122576ae3@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 06, 2021 at 01:52:44PM -0700, Randy Dunlap wrote:
> On 9/12/21 12:12 PM, Lukas Prediger wrote:
> > diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> > index 3b4c0506de46..bac5bbf93ca0 100644
> > --- a/Documentation/userspace-api/ioctl/cdrom.rst
> > +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> > @@ -54,6 +54,9 @@ are as follows:
> >   	CDROM_SELECT_SPEED	Set the CD-ROM speed
> >   	CDROM_SELECT_DISC	Select disc (for juke-boxes)
> >   	CDROM_MEDIA_CHANGED	Check is media changed
> > +	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
> > +					since given time
> > +					(struct cdrom_timed_media_change_info)
> >   	CDROM_DRIVE_STATUS	Get tray position, etc.
> >   	CDROM_DISC_STATUS	Get disc type, etc.
> >   	CDROM_CHANGER_NSLOTS	Get number of slots
> 
> Hi Lukas, Phil,
> 
> This doc change causes a documentation build warning:
> 
> Documentation/userspace-api/ioctl/cdrom.rst:57: WARNING: Malformed table.
> Text in column margin in table line 42.
> 
> The "=====" lines describe the table columns and they cannot be
> exceeded without a warning. The table needs to be reformatted.
> 
> Lukas, will you handle that?
> thanks.
> 
> 
> ======================  ===============================================
> CDROMPAUSE              Pause Audio Operation
> CDROMRESUME             Resume paused Audio Operation
> CDROMPLAYMSF            Play Audio MSF (struct cdrom_msf)
> CDROMPLAYTRKIND         Play Audio Track/index (struct cdrom_ti)
> CDROMREADTOCHDR         Read TOC header (struct cdrom_tochdr)
> CDROMREADTOCENTRY       Read TOC entry (struct cdrom_tocentry)
> CDROMSTOP               Stop the cdrom drive
> CDROMSTART              Start the cdrom drive
> CDROMEJECT              Ejects the cdrom media
> CDROMVOLCTRL            Control output volume (struct cdrom_volctrl)
> CDROMSUBCHNL            Read subchannel data (struct cdrom_subchnl)
> CDROMREADMODE2          Read CDROM mode 2 data (2336 Bytes)
>                         (struct cdrom_read)
> CDROMREADMODE1          Read CDROM mode 1 data (2048 Bytes)
>                         (struct cdrom_read)
> CDROMREADAUDIO          (struct cdrom_read_audio)
> CDROMEJECT_SW           enable(1)/disable(0) auto-ejecting
> CDROMMULTISESSION       Obtain the start-of-last-session
>                         address of multi session disks
>                         (struct cdrom_multisession)
> CDROM_GET_MCN           Obtain the "Universal Product Code"
>                         if available (struct cdrom_mcn)
> CDROM_GET_UPC           Deprecated, use CDROM_GET_MCN instead.
> CDROMRESET              hard-reset the drive
> CDROMVOLREAD            Get the drive's volume setting
>                         (struct cdrom_volctrl)
> CDROMREADRAW            read data in raw mode (2352 Bytes)
>                         (struct cdrom_read)
> CDROMREADCOOKED         read data in cooked mode
> CDROMSEEK               seek msf address
> CDROMPLAYBLK            scsi-cd only, (struct cdrom_blk)
> CDROMREADALL            read all 2646 bytes
> CDROMGETSPINDOWN        return 4-bit spindown value
> CDROMSETSPINDOWN        set 4-bit spindown value
> CDROMCLOSETRAY          pendant of CDROMEJECT
> CDROM_SET_OPTIONS       Set behavior options
> CDROM_CLEAR_OPTIONS     Clear behavior options
> CDROM_SELECT_SPEED      Set the CD-ROM speed
> CDROM_SELECT_DISC       Select disc (for juke-boxes)
> CDROM_MEDIA_CHANGED     Check is media changed
> CDROM_TIMED_MEDIA_CHANGE        Check if media changed
>                                 since given time
>                                 (struct cdrom_timed_media_change_info)
> CDROM_DRIVE_STATUS      Get tray position, etc.
> CDROM_DISC_STATUS       Get disc type, etc.
> CDROM_CHANGER_NSLOTS    Get number of slots
> CDROM_LOCKDOOR          lock or unlock door
> CDROM_DEBUG             Turn debug messages on/off
> CDROM_GET_CAPABILITY    get capabilities
> CDROMAUDIOBUFSIZ        set the audio buffer size
> DVD_READ_STRUCT         Read structure
> DVD_WRITE_STRUCT        Write structure
> DVD_AUTH                Authentication
> CDROM_SEND_PACKET       send a packet to the drive
> CDROM_NEXT_WRITABLE     get next writable block
> CDROM_LAST_WRITTEN      get last block written on disc
> ======================  ===============================================
> 
> 
> -- 
> ~Randy

Hi Randy,

Thanks for heads up. I've prepared a patch to reformat the table which
I'll send shortly.

Regards,
Phil
