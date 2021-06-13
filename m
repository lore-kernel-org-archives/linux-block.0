Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB1C48BDF
	for <linux-block@archiver.kernel.org>; Sun, 13 Jun 2021 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6902461042
	for <linux-block@archiver.kernel.org>; Sun, 13 Jun 2021 15:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhFMPwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Jun 2021 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhFMPwA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Jun 2021 11:52:00 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855AC061574
        for <linux-block@vger.kernel.org>; Sun, 13 Jun 2021 08:49:59 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so11739860oiv.1
        for <linux-block@vger.kernel.org>; Sun, 13 Jun 2021 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VRpIuQi6itY+4oiswvWH2P7h6UmvCn0Jr1erFbjYwzw=;
        b=lCo4AFKINPbQ1vG8jvPTBqRiXZ+oWN/n9vBqMFXghaVOj1d+VgX/+rHyPXG+B0pwUb
         jAxo6S1nUFCe0p5r1zhJKktqadj6U+nHBXFf0lfW/jT9XFnR8X2axtlRR5XIugbKHlNo
         bGJayYeJzaRk/vMGeoIgKYDsh6nZgzJOzT6YCIjSwCMu+zeaPgz9wJb83ZlSlOlIbv+s
         p9GXf0kVwcGYakCha8wUcOZ3dtYliGcrF7bKYRnVk5KIuCXb2eMhOV3xn6hPuiHYy+zy
         KlVLDeidSOMMpImXLemU3yilBYmaAaaO9iuKalH32CQhyhWJFfhX7maay4W7krEY5i0a
         /8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VRpIuQi6itY+4oiswvWH2P7h6UmvCn0Jr1erFbjYwzw=;
        b=NLLrdFmtmpwDdPBULSbyiNyd3iCM+8NDtQPj0IWhVzjHOY7BLLk+o8AM/G2c3H0Ggn
         AmcjjSNmaMr2HLQQpnPP/cO2dxX1n4QqKDfALiMQChgQNZ7/Q2pyZ9tZQk2LR6auPOZO
         //QGb00C4kyAgbc55GiGrMJjDwHhogmTb8Cx7kN8dzgJ7T9j7JilToLy4wdpesWcOwSw
         Edo11T0LzjheyXmgb6SjkFlVv6tchFTuShMNZzQiDeiW09x3y3ftUozyew+glujgw+DL
         HimmhcAHCuIEkMXpa1CEq052IxkA2Lg9j3RzFazNhjpjE5M5vYeOrR+ZR9eikkdlfWgE
         BSRw==
X-Gm-Message-State: AOAM530gewMmDNG2fov2kxSeMUc8g4dp6qYOGhWTlrMLCFtGNDjqp69a
        0+hRxzFKYC4bPBgZ0sAARyEelYuq0EXGtsq59VquQtyanzw=
X-Google-Smtp-Source: ABdhPJxg+FzBFg0dDZt8p8S0enBxjdW+EwalNCVflrPN+LLtLIaPNDeAHVaOj+P93UBX04+L23+S7gmJshB7lm+Wafc=
X-Received: by 2002:a05:6808:11a:: with SMTP id b26mr8267951oie.77.1623599398492;
 Sun, 13 Jun 2021 08:49:58 -0700 (PDT)
MIME-Version: 1.0
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Sun, 13 Jun 2021 08:49:47 -0700
Message-ID: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
Subject: Deadlock in wbt / rq-qos
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi there,

I appear to have stumbled upon a deadlock in wbt or rq-qos.

My journal of a lot of data points is over here:

https://github.com/openzfs/zfs/issues/12204

I initially deadlocked on RHEL 8.4's 4.18.0-305.3.1.el8_4.x86_64
kernel, but the code in blk-wbt.c / blk-rq-qos.c is functionally
identical to 5.13.0-rc5, so I tried that and I'm able to deadlock that
as well. I believe the same code exists all the way back to 5.0.1.

The Something Weird (tm) about this is that it possibly only happens
on AMD EPYC CPUs. I just don't have the necessary setup to confirm
that either way, but it's a hunch because I can't reproduce it on an
Ice Lake VM (but the Ice Lake VM also has more storage bandwidth so
that could be the thing, and I can't decrease that storage bandwidth,
so I can't do a like-for-like test.)

I "instrumented" wbt / rq-qos with a bunch of printk's which you can
see with this patch:

https://gist.github.com/omarkilani/2ad526c3546b40537b546450c8f685dc

I then ran my repro workload to cause the deadlock, here's the dmesg
output just before the deadlock and then the backtraces with my printk
patch applied:

https://gist.githubusercontent.com/omarkilani/ff0a96d872e09b4fb648272d104e0053/raw/d3da3974162f8aa87b7309317af80929fadf250f/dmesg.wbt.deadlock.log

Happy to apply whatever / run whatever to get more data.

Thanks!

Regards,
Omar
