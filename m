Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC6C43444
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D73A218FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545954125;
	bh=k6p7gJ05xPVEAlLpXeuRETqv2Lu6OouHV4sFMd/s5k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gon7T/Z9xP0q0NhgShXbc057H8TgiGjhBlKS80bjdkNwmlktb5RKHeKNoKFEsLKc7
	 lWvZ36RiC+SMMj2JnxPulyDlVnZ+m0zzJTPpvAYuJYrXZ3pVjD9reG9b2pipJyrmPj
	 WZGuhgC9AKgwmEBJ+LH8AKjxGC9tPj3ezXvB8whA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbeL0Xlu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:41:50 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40510 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbeL0Xlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 18:41:50 -0500
Received: by mail-yb1-f196.google.com with SMTP id x201so4030458ybg.7;
        Thu, 27 Dec 2018 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXBTIXHVAax3PJVgWEmGAt722IyPRVkq/7ftu76zskQ=;
        b=nHfNQX9WXbd4v1mYIWQy9AJqEYEykYb6VEtomgVx398VGjNDSzl1QME1bez7OOt2Vw
         wSqtfmtGl2Gc9HatZWi/yVq3upLi8AJolttyrb0KzXCS+OGY+dsUPieA7cy199UNekp4
         pPzQcLgMIGp1H+wAlId3XaC5phb2GrqvWxY1ZIOjP23OxnhDaIA9C1IPYlXkYoNBwQar
         u97YBGsc2chKeilI6xnMZ2oVYWXKbWOi3ucrHJkfmRlc/JnJHq8WVIyDoQwGTM3iGhbM
         Q5PIgAeFdI4adTRai6O64MmXbIFRr0EhhZ06navKwHiU5mFIpXG+ofq4TJkz89aleImg
         XvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXBTIXHVAax3PJVgWEmGAt722IyPRVkq/7ftu76zskQ=;
        b=nqcIdhueK6hjdrT6g/ts6tPodjw7mu1CWs8PYNjm2RJUZGAlOUgXgvb46sLWtNkuu6
         Xt+t3W+/2JBFkRV4VrGbTpBpWPBdxGAVxUbN+L//4aE8DMkWn+/WaC+zBtgt5bhOtJuZ
         kzeI8qcMvZOqRFdYmJ4JbPJmmEyLXeDW8VP7v06dh2VR4l07tHsQl0Y+YAFeef5oAeUN
         /8rV0Tkb0N3rCegV33Se/vr1DmfUhH/0aqalGxR04Ny9NHcdws9M/SlY97KQGlRa4ZLs
         zlRocP0yQ60vXyvUplzwGA4xq5dpQV6rVQRJJJg2o7l0dcFvW3+teAI2/8SMXQuniR6A
         1nlQ==
X-Gm-Message-State: AJcUukf1IyJbM/FHIPP6Qa3QM+bInzbtfzKjhN2rfIhtgvtyT52C529p
        fsnCE0HAavJKt3mHvBSEdFg=
X-Google-Smtp-Source: AFSGD/VzIZXeDLBlBNwHflUwXYh0UgkX4wlTAZfzxQkH57xCRgOFqGov3CIUJ2Go8/Y5FqpPwM9LCA==
X-Received: by 2002:a25:15c1:: with SMTP id 184-v6mr25095796ybv.332.1545954108520;
        Thu, 27 Dec 2018 15:41:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:7729])
        by smtp.gmail.com with ESMTPSA id z186sm21072531ywd.107.2018.12.27.15.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 15:41:47 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:41:44 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     bfq-iosched@googlegroups.com,
        Angelo Ruocco <angelo.ruocco.90@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
Message-ID: <20181227234144.GE2509588@devbig004.ftw2.facebook.com>
References: <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
 <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
 <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
 <20181218164126.GX2509588@devbig004.ftw2.facebook.com>
 <EC4F9B54-2352-4D85-B56C-5800CFEBCCB8@linaro.org>
 <A360EBDC-B297-4754-AF5C-0A6C30D725B4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A360EBDC-B297-4754-AF5C-0A6C30D725B4@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Sun, Dec 23, 2018 at 12:00:14PM +0100, Paolo Valente wrote:
> 4.21 is coming ...  and the legacy proportional share interface will
> be gone with cfq.  This will break legacy code using the
> proportional-share interface on top of bfq.  This code may just fail
> when trying to use interface files that don't exist any longer.

Sounds like inheriting .cfq namespace would be the easiest.  Would
that work?

Thanks.

-- 
tejun
