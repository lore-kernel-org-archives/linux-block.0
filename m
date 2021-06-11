Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9042CC48BE0
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7549F613DE
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 15:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFKPVk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFKPVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 11:21:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B42C061574
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 08:19:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g8so5141082ejx.1
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzBwm6BcOcBNT24VOJHJbvOnYSHRmkZhCSr/+qUOPcQ=;
        b=GKcGKvWT9AHv9071ESHcI9FjsjFn/v5MlNcrlI9YVZBfdJqQi3m9fkkD1THXervqF/
         hxlgtzsfGwzTyecULcNNVPlS0xlsdizFOOzv7vfecdm8/pAirmu+XrEd6EfNikiuvRR7
         TTE6/MMaww0tuunyzolamvnDTr76EjXRHMtW4iExgmQ1rzn+DC86QEsprFh3LHqtglcY
         nfNQIN2ePJzuyQCPN3IyB080Mow4J6cKJAlpPazs3OXJIEC6eXeUzK3LMmPae9Kz7HI6
         ptTU5oPCEFfhW3l1Y67SDj2+gI3ECRWTXARviEggBWPaCLvGEJdQMQGgzepNMH9daNb/
         oD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzBwm6BcOcBNT24VOJHJbvOnYSHRmkZhCSr/+qUOPcQ=;
        b=hcsmxzR+LScDC6CzVBoMOD70Dz8G2weJu6NEKifA1+IRbTFl0SBToKUMdEzsylN1eU
         DSPpNSekl3E/VJBYZFjI+Hz0BcsciMKIjVT3XmiJk1jU/sRmSkaiVyu6unehomhEdNrP
         X2PBFCszpPHWBg3NlB6vxoKHnGk4AKkW4ms8QBID/NSh/pHjXcFKAIqHABVdZCCbno0F
         y60EoYJLcghe7RxKWlSlsEYjN5We28Z+3IbW+eXh4w1H3fQrSyaAazuKVfE81iRbaoK9
         Ar1PQmHxErue6u7k3LVnt6hOwZDPQN1vHcp+BTm9WAf2TuCdxoAtWJ1gExfQd0s/HyrJ
         4XnQ==
X-Gm-Message-State: AOAM530/rH+lpHzoaST0uzoCIiBikGXfC+8jSvHZh5D7/3pAAmtVrWL1
        0bivmxkt+7X5jB33L4IJMdYVdX/LGm9QRczT7kpWrg==
X-Google-Smtp-Source: ABdhPJyqdFK6ZKoQ6XvqRzbeYWkcjfkvQFfkJBhaRUKZUlADFkS1whCeC7Mn6IrS0cgg1V9xUpZIl+YZLGmAKc4qiYQ=
X-Received: by 2002:a17:906:488a:: with SMTP id v10mr4049531ejq.383.1623424766348;
 Fri, 11 Jun 2021 08:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae236f05bfde0678@google.com> <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia> <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
 <CA+CK2bDWb2=bsoacY-eqZExObBpXuZE0a3Mr18_FXmGZTC5GnQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDWb2=bsoacY-eqZExObBpXuZE0a3Mr18_FXmGZTC5GnQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 11 Jun 2021 11:18:50 -0400
Message-ID: <CA+CK2bBe5muuGbHgfK7JjbzRE5ogf1oeD1iYeY6eJB046p9_ZQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in del_gendisk
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 11, 2021 at 11:11 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, Jun 11, 2021 at 10:47 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2021/06/10 1:46, Tyler Hicks wrote:
> > > Thanks for doing this. I haven't had a chance to retry this commit with
> > > lockdep but I did re-review it and didn't think that it would be the
> > > cause of this lockdep report since it strictly reduced the usage of the
> > > loop_ctl_mutex.
> >
> > Well, I made commit 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")
> > because per device lock was not sufficient. Did commit 6cc8e7430801fa23 ("loop: scale loop
> > device by introducing per device lock") take this problem into account?
>
> This was my intention when I wrote 6cc8e7430801fa23 ("loop: scale loop
> device by introducing per device lock"). This is why this change does
> not simply revert 310ca162d779efee ("block/loop: Use global lock for
> ioctl() operation."), but keeps loop_ctl_mutex to protect the global
> accesses.  loop_control_ioctl() is still locked by global
> loop_ctl_mutex.

From commit log of:
 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")

    Since ioctl() request on loop devices is not frequent operation, we don't
    need fine grained locking. Let's use global lock in order to allow safe
    traversal at loop_validate_file().

Unfortunately using a global lock is not scalable here. At Microsoft
we had a slow startup issue because we have several loop devices per
every container. Also, this report:
https://lore.kernel.org/lkml/20210217145629.GA4503@xsang-OptiPlex-9020/

Pasha
