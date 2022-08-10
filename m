Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF811C25B06
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 12:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiHJMiI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiHJMiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 08:38:07 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192F7756F
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 05:38:06 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id v3so17678811wrp.0
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=zLFg+POvWnClRkoYnadehBlI+460BlYfkD1pkGIx514=;
        b=amAwqE/X5LvKRutujzEVn/u/N+xeVeaxczX2VWAbSjqn5AUYPgOC+m9LLWWzvN99tf
         hBghiyC04tfBXiz0u8+6dqlJdSG3OMGpp88SIGLzkxPYDa+m1r9l969kJX9AMnVv81gW
         nAFCLnb91PFxWzJpiZUiM4BIf1Xi5b86roUVApmK3eVWN1tkrxkzZMwYNygdcCbxImFy
         hgrD7t3zy4HinEzhNEZFRZT0eCaAufNpVuUtkgDAaLr1b1diuq45gu1glMbk1KZibbqk
         BmK+bA9KFGCYdXc7NS28oZOEAR5ipkfbHuLpXo8urf5sPGE1bizu2DtFn6KC8pIQtvyE
         0GgQ==
X-Gm-Message-State: ACgBeo1RmcEyshHx9+bSGfLLJYa0USCRCMSIolwxMtO2h80xEhxiULe8
        Z6Qol7+UAlpOtTGQ82YRMSg=
X-Google-Smtp-Source: AA6agR5PankQ0X0Qx2/HFiC/2d1JqVngHg+CQMw5wda9I1PrGoYvS82d+oiGng7LiLcj1PiRuWUg0A==
X-Received: by 2002:a5d:654b:0:b0:221:6cf1:104c with SMTP id z11-20020a5d654b000000b002216cf1104cmr14945511wrv.251.1660135084621;
        Wed, 10 Aug 2022 05:38:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:360b:9754:2e3a:c344])
        by smtp.gmail.com with ESMTPSA id n128-20020a1c2786000000b003a302fb9df7sm2338292wmn.21.2022.08.10.05.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 05:38:04 -0700 (PDT)
Message-ID: <ac34e9ecae8fd7af9da7f2d593265950459b6f2c.camel@debian.org>
Subject: Re: [PATCH v4] block: sed-opal: Add ioctl to return device status
From:   Luca Boccassi <bluca@debian.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        sbauer@plzdonthack.me, Jonathan.Derrick@solidigmtechnology.com,
        dougmill@linux.vnet.ibm.com, gmazyland@gmail.com
Date:   Wed, 10 Aug 2022 13:38:03 +0100
In-Reply-To: <20220809130220.64a5npyiaa6zahd5@wittgenstein>
References: <20220805225522.124199-1-luca.boccassi@gmail.com>
         <20220809130220.64a5npyiaa6zahd5@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2022-08-09 at 15:02 +0200, Christian Brauner wrote:
> On Fri, Aug 05, 2022 at 11:55:22PM +0100, luca.boccassi@gmail.com wrote:
> > From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> > 
> > Provide a mechanism to retrieve basic status information about
> > the device, including the "supported" flag indicating whether
> > SED-OPAL is supported. The information returned is from the various
> > feature descriptors received during the discovery0 step, and so
> > this ioctl does nothing more than perform the discovery0 step
> > and then save the information received. See "struct opal_status"
> > and OPAL_FL_* bits for the status information currently returned.
> > 
> > Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > ---
> 
> No expert in this area but I think this looks straightforward overall.
> But could you expand on the use-case a bit in the commit message.
> I have a tiny suggestion/questions below other than that seems like
> useful info to expose.

Thank you for your review, updated in v6 (sent v5 with the struct
update but forgot to update this too).

> > 
> > +struct opal_status {
> > +	__u32 flags;
> > +};
> 
> You expect this struct to reasonably grow additional members? If not you
> might just pass a single __u64?
> 
> In case that the struct makes more sense: I don't know what's common in
> this subsystem but for other parts of the kernel we try to align all
> structs to 64 bits. So it wouldn't hurt to do that here too. Either by
> turning that into __u64 flags or by adding a __u32 reserved member.

I believe it is a good idea to be able to expand in the future, since
this is driven by a hardware protocol. Added '__u32 reserved' as
suggested in v6.

-- 
Kind regards,
Luca Boccassi
