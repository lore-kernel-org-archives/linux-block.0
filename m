Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D62C74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 01:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCQBio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCQBin (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 21:38:43 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8ACDE7
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 18:38:39 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id p2so2437232uap.1
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 18:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679017119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZiMCDMIqB6OVa8oI0SbxOaqsvPFfiDjO4dIGyuTuIg=;
        b=ypwhZFcEyECXNJLrPmBrQBRxwV+y3VDSUZRidDldPrMlkddN8UY8Sd09RHpaiqdiJL
         T7ZnlEx7oQHOvemcAeJimox6CqBwQt5mA6I5dl4zxVDLl84vlluYmnsW3XrJAq59rLmm
         WEPR9GDZf3CMjIEeQ1ImdBuXtn3KtyXxGhGeEnmEZS0j2sqwdmlAlzOwUzK6i/XefAY5
         7Y1tBOyhxN8wEoGSg6Y+f7V7aOput026rhrRVSliNNxcqNUPXZI8t7s/BGDZ4fpJznF2
         a4wY+SXlfzZfwhEPy83h/v6w/SWGnfBLCXxitQ0B/IYAlEUQxW78axaN7PPFkDGCimfx
         W+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679017119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZiMCDMIqB6OVa8oI0SbxOaqsvPFfiDjO4dIGyuTuIg=;
        b=XFWLE9voEP5uB3C+BIgTF4ysVBGtLZDRBDqK/qe4dHJrTtYKV0/4mDKWHFBhk/CNeX
         gkucqKd4K6ErgETJhbiZhJ1mu8oeMugW1fTkeXp7wjiJ3P9vZVGs66pdrBNj9swIqPp6
         v0Jy/azy7BYUvrdC4gLGltQID+zVMoXojh+v/C+iNtY1mOvhu+xEGMuRai2NWNPKS9Ct
         OypkKfHU0L2CFxJSC3A/JaXPIdlJh/m0UN7ybsDibKSDISqvkPPmPDoFUPjQ7q8VLYy0
         VHtUglwmHhbJyW44UsV9PAXLL97hupWqDwiKIArE+orMzGZ6RRNXyZAdFQOKFE5RFqUi
         adjQ==
X-Gm-Message-State: AO0yUKU4qJnUuFFPNbLF81JCbTDFrFmdhu6qH+JbtsymrTsIjzYazFNs
        4TynhD0+puFa/32OJdVFMjKkB+1oYBSZuLF20TpIlA==
X-Google-Smtp-Source: AK7set+/q/KOu9X2oqklAu82mx0ZTERuPycsI3lxx4LB0u576R4uCrwSrRzaoqbLzoyXIBsLOflo4MZ1GqF/8zksvhU=
X-Received: by 2002:a1f:b292:0:b0:42d:18f9:d0b6 with SMTP id
 b140-20020a1fb292000000b0042d18f9d0b6mr18388753vkf.2.1679017118886; Thu, 16
 Mar 2023 18:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230314230004.961993-1-alexey.klimov@linaro.org> <c98a3741-273b-8a69-016d-5f3e79f8a71e@acm.org>
In-Reply-To: <c98a3741-273b-8a69-016d-5f3e79f8a71e@acm.org>
From:   Alexey Klimov <alexey.klimov@linaro.org>
Date:   Fri, 17 Mar 2023 01:38:27 +0000
Message-ID: <CANgGJDqhimVZ7Pfes0sT8S2VHo_gTLBYkGFNcfbT5CV5VJz51Q@mail.gmail.com>
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     peterz@infradead.org, draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, klimova@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 14 Mar 2023 at 23:21, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/14/23 16:00, Alexey Klimov wrote:
> > The delay is found to be in device's ->shutdown() methods called from kernel_restart():
> > void kernel_restart_prepare(char *cmd)
> > {
> >       blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> >       system_state = SYSTEM_RESTART;
> >       usermodehelper_disable();
> >       device_shutdown();      <---- here

[..]

>
> Please let me know if you want me to resubmit patch "scsi: ufs: Remove
> the LUN quiescing code from ufshcd_wl_shutdown()"
> (https://lore.kernel.org/linux-scsi/20220331223424.1054715-14-bvanassche@acm.org/).

This indeed works and helps to reduce reboot time. Thanks!
If you decide to resubmit, feel free to ping me to test it.
However I have no knowledge how comments from Adrian can be addressed.

With that patch the reboot time decreases from 60-100 seconds to
~10-20 seconds. The next
"slow" thing is wlan driver which callback is called from
blocking_notifier_call_chain(&reboot_notifier_list, ...) but obviously
it is not a part of ufs code.

Best regards,
Alexey
