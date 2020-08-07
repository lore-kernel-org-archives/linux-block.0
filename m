Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB94C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 15:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A69A22CA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 15:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGPbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGPbj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 11:31:39 -0400
X-Greylist: delayed 115149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Aug 2020 08:31:38 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45292C061756;
        Fri,  7 Aug 2020 08:31:38 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 07D48E806C9;
        Fri,  7 Aug 2020 17:31:35 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 75A67160D5D; Fri,  7 Aug 2020 17:31:34 +0200 (CEST)
Date:   Fri, 7 Aug 2020 17:31:34 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Martijn Coenen <maco@android.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: Re: [PATCH] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
Message-ID: <20200807153134.GA222272@gardel-login>
References: <20200806073221.GA219724@gardel-login>
 <CAB0TPYEsRPxiVLS7ieBLJprje_avAo49n7QWExpovuLBJHkOGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYEsRPxiVLS7ieBLJprje_avAo49n7QWExpovuLBJHkOGw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fr, 07.08.20 10:53, Martijn Coenen (maco@android.com) wrote:

> Hi Lennart,
>
> Thanks again for the patch, I tested it and it looks good to me. I'll
> also add a test case to LTP for this. Two minor nits on the patch:
>
> On Thu, Aug 6, 2020 at 9:32 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
> > Let's correct that and propagate the flag in LOOP_SETSTATUS too.
>
> Think you meant LOOP_CONFIGURE.

True!

> Also, could you add a "Fixes" tag, like:
>
> Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")

Thanks for the review. I'll fix this up and send a v2. Are you OK with
me adding your Ack to the patch? And also should this geta cc for
stable?

Thanks,

Lennart

--
Lennart Poettering, Berlin
