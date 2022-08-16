Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F3C25B0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 14:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiHPOIs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiHPOIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 10:08:48 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCB6F575
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 07:08:45 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id p10so12775584wru.8
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 07:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=Kz5m260J7G6brahKBeCpkOlSs+F/k752gOK56lwoX8g=;
        b=B7xbm0834zjoEqqbDh+tahpxhkAHllfYmLBbB4/EHNoEKjXzqmBhdGWYi9GQvRZbW+
         HJVfq7KYc+bU6r5li9nROzR9N5nAneWYZjfW8+E0cl1eXeSD0tv7DdXBfuCcQ/9KLUNy
         Ltr2cGg5uGD3yQkIsNS9qk7cal1jPoSoKaTdCyJIK3ehIDu5BZfWVQBPwXcVkRANVa2M
         WWMKRRrLFedcwl+3EXMTsuuyXPci2BVdOvYuLnF+U8Rmd0kuB3LL6e0oIyabeVmMH9TI
         KZnllf/n52ohIMEACKOXxr1Uzg7DkQ2HW6LJcFhMu38kA+KIWk5n6V+1KmeFS545mK1G
         KcOA==
X-Gm-Message-State: ACgBeo0NvhDI2jyTzgDyJcbytnbk/bhzhMx7m9tGHwZLwmGB+Dqe8A2P
        iPT4O0dCMQsvdjqRCvM0d+E=
X-Google-Smtp-Source: AA6agR7OobdcC2Jt709k5bnvxygcoyCJCqkpuaks1snTZllqCqvbgFR0WgDNjGUPGQbWiBjsUWr6lA==
X-Received: by 2002:a5d:54c7:0:b0:21e:f007:e67 with SMTP id x7-20020a5d54c7000000b0021ef0070e67mr12078162wrv.382.1660658923813;
        Tue, 16 Aug 2022 07:08:43 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id p185-20020a1c29c2000000b003a4f1385f0asm13761790wmp.24.2022.08.16.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 07:08:43 -0700 (PDT)
Message-ID: <610adab44a94f493b0d125a0bbd9f252406dcb14.camel@debian.org>
Subject: Re: [PATCH v6] block: sed-opal: Add ioctl to return device status
From:   Luca Boccassi <bluca@debian.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        sbauer@plzdonthack.me, Jonathan.Derrick@solidigmtechnology.com,
        dougmill@linux.vnet.ibm.com, gmazyland@gmail.com
Date:   Tue, 16 Aug 2022 15:08:42 +0100
In-Reply-To: <20220816103739.t6xg6ssw4comzew2@wittgenstein>
References: <20220810123551.18268-1-luca.boccassi@gmail.com>
         <20220816103739.t6xg6ssw4comzew2@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2022-08-16 at 12:37 +0200, Christian Brauner wrote:
> On Wed, Aug 10, 2022 at 01:35:51PM +0100, luca.boccassi@gmail.com wrote:
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
> > This is necessary to be able to check whether a device is OPAL
> > enabled, set up, locked or unlocked from userspace programs
> > like systemd-cryptsetup and libcryptsetup. Right now we just
> > have to assume the user 'knows' or blindly attempt setup/lock/unlock
> > operations.
> > 
> > Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > ---
> 
> Seems good to me (One nit below.),
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> > v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> > v3: resend on request, after rebasing and testing on my machine
> >     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
> > v4: it's been more than 7 months and no alternative approach has appeared.
> >     we really need to be able to identify and query the status of a sed-opal
> >     device, so rebased and resending.
> > v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
> >     bits and to reserve space for future expansion
> > v6: as requested by reviewer, update commit message with use case
> > 
> >  block/opal_proto.h            |  5 ++
> >  block/sed-opal.c              | 90 ++++++++++++++++++++++++++++++-----
> >  include/linux/sed-opal.h      |  1 +
> >  include/uapi/linux/sed-opal.h | 13 +++++
> >  4 files changed, 97 insertions(+), 12 deletions(-)
> > 
> > 
> > +static int opal_get_status(struct opal_dev *dev, void __user *data)
> > +{
> > +	struct opal_status sts = {0};
> > +
> > +	/*
> > +	 * check_opal_support() error is not fatal,
> > +	 * !dev->supported is a valid condition
> > +	 */
> > +	if (!check_opal_support(dev)) {
> > +		sts.flags = dev->flags;
> > +	}
> 
> nit: We generally don't do {} around single-line if.

Thank you, fixed in v7.

-- 
Kind regards,
Luca Boccassi
