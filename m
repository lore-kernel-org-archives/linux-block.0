Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABAC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC8F64FAD
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 21:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCJVVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:21:44 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38938 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCJVVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 16:21:30 -0500
Received: by mail-pl1-f178.google.com with SMTP id j6so9128062plx.6;
        Wed, 10 Mar 2021 13:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nx7DyCkQIr9THs33CM8Ho+zFue/EmVe3T9nz06hnrv4=;
        b=dA2brjRzSOzUfqKGkJ3J4Q7y2jHabfCiJSMWaY8L08g2IgRYBov6Qg5gpB6cCtcm4o
         zJyAWGFjR9FCI0jwv9QHGg+O9CH7C5TUpGjAJ1rQ/WcEAsQK6CLIFEd/XgUGHlQRTRmH
         acMlKyMCxML3uWZxI2BWE+PgF5NZxPeLVZV1BZnHJis6AeFhsBK1DHoD8sDvI5VqC9rD
         PXb6Cws7uCWS2oh08bFhGxmUdcZyaWDfk3WOfIZ1dVp/b/+CxREphKo9YFgNRth45Axx
         VlSGl8F15MB95zTQItOeV8g7sbx9omVrPQ7MELrslOnoB7KYa0/POQXVcgnizVzEk/US
         CvEA==
X-Gm-Message-State: AOAM533OYqnK4Jk03dlPCn/bWx8W20BC3ZHc7VbL6DfwsVr3NKG9C6mZ
        J+A8cX95rTIfdJHZgIGLDLw=
X-Google-Smtp-Source: ABdhPJwqLduXpvIPSDt2uBaV5hqyTjGPcFiJ4ac3zg00L7BDR+V6K1CUX/NmFdDrCcihniTEruHL0w==
X-Received: by 2002:a17:90a:8c84:: with SMTP id b4mr5369914pjo.21.1615411290037;
        Wed, 10 Mar 2021 13:21:30 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m7sm251819pjc.54.2021.03.10.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:21:29 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 15DC24024E; Wed, 10 Mar 2021 21:21:28 +0000 (UTC)
Date:   Wed, 10 Mar 2021 21:21:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210310212128.GR4332@42.do-not-panic.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEbjom8FIclEgRYv@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> If I understand correctly, bugs you found were related to module
> unloading race while the zram are still working.

No, that is a simplifcation of the issue. The issue consists of
two separate issues:

 a) race against module unloading in light of incorrect racty use of
    cpu hotplug multistate support
 b) module unload race with sysfs attribute race on *any* driver which
    has sysfs attributes which also shares the same lock as used during
    module unload

It is important to realize that issue b) is actually a generic kernel
issue, it would be present on *any* driver which shares a lock used on
a sysfs attribute and module unload. I looked to implement a generic
solution on kernfs, however we don't yet have semantics to enable this
generically, and so for now each driver needs to deal with those races
on their own. That sysfs race is dealt with in the second patch.

The first patch only deals with the cpu hotplug races exposed at module
unloading.

  Luis
