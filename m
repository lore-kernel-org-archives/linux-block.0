Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC8C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2A1205ED
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 15:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DclcB8tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEFPcS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 11:32:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36169 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfEFPcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 11:32:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id y8so11245831ljd.3
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhC7MbDWhdXqVGNsnx/nM6qv+8XRBf3nIJVwF+Zb68E=;
        b=DclcB8tBLwBNnEm2Y6G2rmljpZK5waw9Q9n0wedeq+7SejBp2LiBVTomNRZmhsRyAf
         k8HF5G5r87WIYlwu4mky6vY2DRJL4W1noWtMCoSH8hcDmiNy/XnR4mk+dddgE2mKFXuC
         TmxMIPPYdgCKLrBr7RzURj0Ysfvkapvfx14sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhC7MbDWhdXqVGNsnx/nM6qv+8XRBf3nIJVwF+Zb68E=;
        b=d9rPEmtH1OHGr3l4r+zi+HEVuXANzmXPvcUpw2RxkoBBUS75oA9mKAPTcBs9ekQyAX
         s2JsweEgqLBL3lxM0qn6tssKTcnhpeQySd6DeNsOlK5HpUtvK3R95RGy4KhMFR/XJ1rM
         4jZ1bNn8tSRb1g25jC631kX7XGWWfrKuopplv3gnya3RFR5kSU1wIrQEfb3kFoww4GcA
         H9nlAJccUn9rvcVGBVaWFQaZgXR9xj4T0+wo5ODHGgc7wvRUoEWbR7zUD77Y+DAsOxFt
         uAVLHksYAb1flwWj+2dQolveGHgGiUyKh9r1wgr95hyaHTrQa1TmqfboAwzi7We5k9Fa
         I+mA==
X-Gm-Message-State: APjAAAVB/mRxSpkDKJ6TM5lQGqq8UCwa8Cpu8zxpgkwFTw98LJ85S+G9
        OEcbneB6DJ6YVPUILKrQP9MpUDGiWD8=
X-Google-Smtp-Source: APXvYqzqpMC+2Uki6BNLfKB7T2jjW9JOH/+PD8bzJwetEH+4jkIHMI0yXR+V4YbmFY8M/buuD0sYDw==
X-Received: by 2002:a2e:9999:: with SMTP id w25mr1248578lji.121.1557156736372;
        Mon, 06 May 2019 08:32:16 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u26sm2064271lje.56.2019.05.06.08.32.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:32:15 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id n134so7647200lfn.11
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 08:32:15 -0700 (PDT)
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr12709717lfd.101.1557156734917;
 Mon, 06 May 2019 08:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=gft4irmMAapAj3O0hWr53PnyRUmcX2AJB+p_PqCJHT0rvNg@mail.gmail.com>
 <ca507480-0b06-5e4d-ebe6-464302d3af92@acm.org>
In-Reply-To: <ca507480-0b06-5e4d-ebe6-464302d3af92@acm.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 6 May 2019 08:31:37 -0700
X-Gmail-Original-Message-ID: <CAE=gft58X0o+_=J81F1F8F5_N58mK+Nqs1zrsmtPC8JDj_Z1LA@mail.gmail.com>
Message-ID: <CAE=gft58X0o+_=J81F1F8F5_N58mK+Nqs1zrsmtPC8JDj_Z1LA@mail.gmail.com>
Subject: Re: blkdev_get deadlock
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 3, 2019 at 6:15 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 5/3/19 10:47 AM, Evan Green wrote:
> > Hey blockies,
>   ^^^^^^^^^^^^
>
> That's the weirdest greeting I have encountered so far on the
> linux-block mailing list.

Heh, achievement unlocked.

>
> > I'm seeing a hung task in the kernel, and I wanted to share it in case
> > it's a known issue. I'm still trying to wrap my head around the stacks
> > myself. This is our Chrome OS 4.19 kernel, which is admittedly not
> > 100% vanilla mainline master, but we try to keep it pretty close.
> >
> > I can reproduce this reliably within our chrome OS installer, where
> > it's trying to dd from my system disk (NVMe) to a loop device backed
> > by a removable UFS card (4kb sectors) in a USB dongle.
>
> Although this is not the only possible cause such hangs are often caused
> by a block driver or SCSI LLD not completing a request. A list of
> pending requests can be obtained e.g. by running the attached script.

Thanks for the script. I'll try a few different combinations of dd
involving the UFS card to see if I can at least remove the system disk
from the equation. Hopefully the system will still be responsive
enough to run the script if I keep it in the right place and maybe
pre-warm it up. I also might try an older kernel, since if it's a
misbehaving block device as you suggest then all kernel versions
should lock up.

>
> Bart.
