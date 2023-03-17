Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E98C6FD1F
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 02:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCQCLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 22:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCQCLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 22:11:44 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6A61A84
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 19:11:37 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 89so2481409uao.0
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 19:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679019097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JxQj7WluLVe1utYWev437/yUjq6IqDIGFQM7ipfQjY=;
        b=Fnh/gZEoRLlCqe/YSuzknLNhcS1/RvxTuZGJImyoVV4U5lNvgJBa1e9HEdrj/1yZZD
         AoDX5slmdN1Go4l12FENChIOYoV1spNJgemua8mknNQwxFbd+fRlU5+qYL1KHGa3iTXi
         Qc5lj6GQ72AnnFLXniPU9wsPxa11f4G2nMk7yyvQcbX3Ibn4tCSeAPfmUSO41QKHRz2i
         HZL7o9FkkRT3i3rhx/1E2ctjM5sT5WuCLrhu+2/IUqa+3o/1mS5ozQ9LLKfnZjbp7f7x
         U0EBRkaZyXo++0P88L3pUnjyFG7hQkN2VhP6Tpq6+kK174z+JSrZea0YJ7QYRPjBKwNb
         +AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679019097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JxQj7WluLVe1utYWev437/yUjq6IqDIGFQM7ipfQjY=;
        b=43X/8MvcGQNUg6O9i5ZLTFaPJM1RzSrcGUI7+EOh31mZv2gK3YY055PdrqRC/ijh+U
         ZXNxxA7LJXkg95xN9HSaKsEWDwCRBPYv46z5MRBaKwJnP3R1QeOAKS0+DjzmZ9sxiTtl
         srlhwm/vFEKAbPPp4/isRwcu8O0DT+0gF1984ePI2LhlqCNjcqpErI3GaXLNswj3St8d
         jEeDcDAonX3ONuT/LZTnwpioRDHKzaKOP2WA6Ux+805QxaNJvjzkku/7sRytnEK7npb1
         YLrQ4N9Wn/IP900mr10JO1z75D+pelnxsLd25fd9e9jkXPdfxTbA9tnixDv8nKA1hxOn
         0lEQ==
X-Gm-Message-State: AO0yUKWrQhAgRJHtLSrVuS4kGy/t9PCtgz2vEb4zke/Yywb9urj8hQTt
        phekLaWI3CTvTl/uNWl3KtvVJ5V08XOtixTTMN8RjQ==
X-Google-Smtp-Source: AK7set9QFQFcvmYsn+NMPP21EqO+rBKdsdhCS5M9oyU4h+UJ6THIVBH8NTiMyC0iQd4khHnUmNtlXxcBh+ysScdsepo=
X-Received: by 2002:ab0:5a01:0:b0:73f:f15b:d9e3 with SMTP id
 l1-20020ab05a01000000b0073ff15bd9e3mr854761uad.0.1679019097044; Thu, 16 Mar
 2023 19:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230314230004.961993-1-alexey.klimov@linaro.org> <20230315111606.GB2006103@hirez.programming.kicks-ass.net>
In-Reply-To: <20230315111606.GB2006103@hirez.programming.kicks-ass.net>
From:   Alexey Klimov <alexey.klimov@linaro.org>
Date:   Fri, 17 Mar 2023 02:11:25 +0000
Message-ID: <CANgGJDpd4Gm5HhQW__oMAv1yUqSPZ7FSGoQLYTmug=TUk4cn4g@mail.gmail.com>
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Mar 2023 at 11:16, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> (could you wrap your email please)

Ouch. Sorry.

> On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:
> > #regzbot introduced: 0c5ffc3d7b15 #regzbot title:
> > CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck
> > reboots
> >
> > The upstream changes are being merged into android-mainline repo and
> > at some point we started to observe kernel panics on reboot or long
> > reboot times.
>
> On what hardware? I find it somewhat hard to follow this DT code :/

Pixel 6.

> > Looks like adding CPUIDLE_FLAG_RCU_IDLE flag to idle driver caused
> > this behaviour.  The minimal change that is required for this system
> > to avoid the regression would be one liner that removes the flag
> > (below).
> >
> > But if it is a real regression, then other idle drivers if used will
> > likely cause this regression too withe same ufshcd driver. There is
> > also a suspicion that CPUIDLE_FLAG_RCU_IDLE just revealed or uncovered
> > some other problem.
> >
> > Any thoughts on this?
>
> So ARM has a weird 'rule' in that idle state 0 (wfi) should not have
> RCU_IDLE set, while others should have.
>
> Of the dt_init_idle_driver() users:
>
>  - cpuidle-arm: arm_enter_idle_state()
>  - cpuidle-big_little: bl_enter_powerdown() does ct_cpuidle_{enter,exit}()
>  - cpuidle-psci: psci_enter_idle_state() uses CPU_PM_CPU_IDLE_ENTER_PARAM_RCU()
>  - cpuidle-qcom-spm: spm_enter_idle_state() uses CPU_PM_CPU_IDLE_ENTER_PARAM()
>  - cpuidle-riscv-sbi: sbi_cpuidle_enter_state() uses CPU_PM_CPU_IDLE_ENTER_*_PARAM()
>
> All of them start on index 1 and hence should have RCU_IDLE set, but at
> least the arm, qcom-spm and riscv-sbi don't actually appear to abide by
> the rules.
>
> Fixing that gives me the below; does that help?

Double-checked and it seems, unfortunately, the patch doesn't change
the behaviour at all.
The first problematic driver is ufshcd that slows down the reboot the most.
The another one is wlan bcm driver which callback is called from
blocking_notifier_call_chain(...).
Backtraces from it, when it is stuck/slow, involve pci and net
subsystems but I didn't yet narrow it
down to exact function or specific flow.
The patch from Bart helps with ufshcd driver but still reboot times
are 10-20 seconds.
The removing of RCU IDLE flag helps with both drivers.

Is there any debug data I can collect to help with this or any other
patches to test please?

Thanks,
Alexey
