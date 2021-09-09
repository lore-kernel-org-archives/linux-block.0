Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91998C433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799626105A
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 18:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhIISPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:15:47 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:7528 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhIISPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 14:15:47 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 14:15:47 EDT
Received: from [87.92.210.171] (helo=lumip-notebook.fritz.box)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lumip@lumip.de>)
        id 1mOOPx-0004df-UV; Thu, 09 Sep 2021 20:04:58 +0200
From:   Lukas Prediger <lumip@lumip.de>
To:     phil@philpotter.co.uk
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change detection
Date:   Thu,  9 Sep 2021 21:04:28 +0300
Message-Id: <20210909180427.8100-1-lumip@lumip.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YTlMnjyIMHHIGiPe@equinox>
References: <YTlMnjyIMHHIGiPe@equinox>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Phil,

thanks for taking the time to look at this and give feedback.

> Dear Lukas,
>
> Thank you for the patch, much appreciated and looks great. One very
> minor thing though has jumped out at me after running checkpatch though:
>
> > --- a/include/uapi/linux/cdrom.h
> > +++ b/include/uapi/linux/cdrom.h
> > @@ -147,6 +147,8 @@
> >  #define CDROM_NEXT_WRITABLE  0x5394  /* get next writable block */
> >  #define CDROM_LAST_WRITTEN   0x5395  /* get last block written on disc */
> >
> > +#define CDROM_TIMED_MEDIA_CHANGE   0x5396  /* get the timestamp of the last media change */
> > +
> >  /*******************************************************
> >   * CDROM IOCTL structures
> >   *******************************************************/
> > @@ -295,6 +297,19 @@ struct cdrom_generic_command
> >       };
> >  };
> >
> > +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
> > +struct cdrom_timed_media_change_info
> > +{
>
> This opening brace should be on the same line as the struct definition
> as per current style rules.

I also noted that checkpatch reported this and that it is technically a style breach,
however I kept the brace in the newline to be consistent with all the other
cdrom ioctl structs defined above this in the same file for consistency.
I have no strong feelings about this, though, so we could change this.

> I also got a checkpatch warning about ENOSYS being used as an error
> value, but I can see this usage is standard in the driver and not a
> problem so no issue with that.
> 
> I will review and test properly after work tomorrow (being new to the
> role I'd like to make sure I'm taking the proper time), but I have no
> doubt it will work fine. Assuming it does I will be happy to accept the
> patch with the above brace change. Thanks again.
> Regards,
> Phil

Best regards,
Lukas
