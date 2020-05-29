Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D1C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9958120721
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFBif/W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgE2Wqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 18:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgE2Wqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 18:46:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE09C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 15:46:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l26so5375632wme.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVXUitJITFccJCM10GuKFypOdjqH8aeTMtgcNm00y3o=;
        b=HFBif/W8QyHkVLj2V1yHKV5ap3qTym0gJBcRJ9kNUjHKGNefzXkxHkWkOU9eMojCVM
         yzqfQS8b5zmxr8e2U6fhswwCgz06LAbc6GrGNoWJbwG5rXXsXV8GalydGjFwBxfkuTot
         282rsZnFffVzWfT1xih7nBTQ0Pv9Pl9L+pUa77mVaD6aHl0+cTuvHGO75OQzlyImxWjF
         dmJPuFLErxVdIP7BL5lttrmD+vgw1ta0gfIElkBFRRmmXJmEc/s+DIbt0SOrhhUF01b+
         6FI0pEphMQoQ3KvYk8idr4/PBEVUX8nOkllQOhlyNTffDI8xscRD8OuHLSjWaMXMY8m9
         akUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVXUitJITFccJCM10GuKFypOdjqH8aeTMtgcNm00y3o=;
        b=awg4W4YtpunMmWrvgagkw6O9TOMf0oxnnUStUhfu8w4Hw3oGG3DwycB+0wxQduyMle
         J4ZF4y76RdzNqP8HcwChLSnGHKnJKVkdpaocn/5C75b000WeN11CUeY5Elt1aYOLQFiD
         1urLC1zpxt1hUnNh0fFIOSOsRrDoxu/Fy7nT9KdziBArrER4j5y/slp2kDmGpPnPW1D5
         ip4nyolicFGnIX4SVuJb9VGppZrGgH/xWs6WOSCjdgevgwsp8YgVZoXxG2cVmePyJf1s
         PRkJYqhZMLQwtYwbcTv14Oi+xsuDqANiggUjP0mJahKkND6C17beM5xsCQ1AcVxHpSem
         gDaQ==
X-Gm-Message-State: AOAM5327YkwbOAfu4Ffkgtc+BuO/JMH2mv3qFe+Qg7qW/Hw9+G91KWEA
        urF/RodEOkuBmHyjyAVbdbh3jExBPlXpFpTcv+e5QkhezrU=
X-Google-Smtp-Source: ABdhPJxQCftEUyIIBWUVszZjLIxqhPYhFPMu+HZntrN9eDF8czsGxdYWW6epWn6zjAKfJvLQL9c+EptPM1OykUalLlk=
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr10044827wmg.115.1590792396852;
 Fri, 29 May 2020 15:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200528153441.3501777-1-kbusch@kernel.org> <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com> <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
 <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com> <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
 <20200529132217.GB3506625@dhcp-10-100-145-180.wdl.wdc.com>
 <CACVXFVMithaukPF45qFzTgzqQ2g2mhLbUD+-AyaNwVwZo7+CyA@mail.gmail.com> <20200529223256.GA3564047@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200529223256.GA3564047@dhcp-10-100-145-180.wdl.wdc.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 30 May 2020 06:46:25 +0800
Message-ID: <CACVXFVOxoO8HAsVK=PkKW6hTFaNTzukuYKhfqoGR2q9SFjn6ug@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To:     Keith Busch <kbusch@kernel.org>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 30, 2020 at 6:32 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, May 30, 2020 at 06:23:08AM +0800, Ming Lei wrote:
> > On Fri, May 29, 2020 at 9:22 PM Keith Busch <kbusch@kernel.org> wrote:
> > > seconds. Your series will reset that broken controller indefinitely.
> > > Which of those options is better?
> >
> > Removing controller is very horrible, because it becomes a brick
> > basically, together
> > with data loss. And we should retry enough before killing the controller.
> >
> > Mys series doesn't reset indefinitely since every request is just
> > retried limited
> > times(default is 5), at least chance should be provided to retry
> > claimed times for IO
> > requests.
>
> Once the 5th retry is abandoned for all IO in the scheduled scan_work,
> the reset will succeed and schedule scan_work, which will revalidate
> disks, which will send new IO, which will timeout, then reset and
> repeat...

Firstly, we can recoganize this situation easily during reset, and give up
after we have retried claimed times, will do that in V2.

Secondly, not sure revalidate will send new IO since all previous IOs have
been failed.

Thanks,
Ming Lei
