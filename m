Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDFFC47092
	for <linux-block@archiver.kernel.org>; Sun, 30 May 2021 14:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B8A610A0
	for <linux-block@archiver.kernel.org>; Sun, 30 May 2021 14:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE3OCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 May 2021 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3OCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 May 2021 10:02:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F2C061574
        for <linux-block@vger.kernel.org>; Sun, 30 May 2021 07:00:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so10352615edc.7
        for <linux-block@vger.kernel.org>; Sun, 30 May 2021 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UOXo/D+0DW6Op7jTS8BMGmF/4b/OmLRyWstRV2akTfk=;
        b=oMr6g0S6P9N0hzi3jcFs7kEdScznXFGeNNrHsoMN/kSSNV5uS7P22V1KdfgehtjaB/
         PxS8f+KYc+d9JU5KvO3HSggvUJO6kEqeMUdkK8XG7A59fXCOvZPplDnicw4gHR7YXTOW
         oiK1NIDo2oa/z0p/MhJ/y3lJyyIs4xBJCDFog257wXRCHl4kfudWBR0WuJ4UClwn9smN
         ld+2FPUiSDB42fFdc+7hve1Vv7beRJod6lC8eIrPlZw4Dn1fYbuJFCD8s5gsj+yIDAxk
         3ylM0xt/S8cj+BHnwZAHCo+/Pyn2OyH/74ibAqYMicSZIe6INuGnXChDacDR+dLLgqUo
         yFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UOXo/D+0DW6Op7jTS8BMGmF/4b/OmLRyWstRV2akTfk=;
        b=PAviECSVJMThfUWQX+ka9hBv+Lk8Bh8PQZxJQL43ap/kFu3fE9bMp6vzFrJq2wbve+
         CVapPalhqvv+MPWcml+8nI7+imOkLX9VbSoRvjPKIv085FXgqaRnUHghvOnCy9s0r8vL
         PWnfrO0Q8qOVv+RXjn95bpUBBse9DZZilWCmqwf86e3mJMvJi/Oe5ZBVqVKGk0y+qurs
         9CU0jCmyEVk0A3gmGyjy2aR5I+9Ype2xHrWVrQo7pZ+C/jLyMLGJQbZoqP4JvAvMrWJ2
         IBgn4GdT/I+tTxEoIG+8yi0knebKFxgkU/vPZdwUihfk81jV22pGxrpIAU9T4i+ncdA1
         bmkQ==
X-Gm-Message-State: AOAM530ogkfNQJ01LQNf4qAD7eTLODEEb1SFDnrrJBeFhyScFgCOYOPR
        MK0AhVAmHklNFLPZdfnYBxbcvAdbPizj8bAOFUn9wJClHgJOFw==
X-Google-Smtp-Source: ABdhPJx9L1fAR4jz4mPoCwnb3rulxg16Fid4PMvAL8bYEcB2nBTs8QCQTefXfLSGsoOFPO7sqoaUHZGqM48FXs51K+Q=
X-Received: by 2002:aa7:cd19:: with SMTP id b25mr18458380edw.84.1622383253284;
 Sun, 30 May 2021 07:00:53 -0700 (PDT)
MIME-Version: 1.0
From:   tianyu zhou <tyjoe.linux@gmail.com>
Date:   Sun, 30 May 2021 22:00:43 +0800
Message-ID: <CAM6ytZouD03NroHa1Bk8wFAenWL4TZxxLuuKqN2z7cxMT9=xDg@mail.gmail.com>
Subject: Redundant check for CAP_SYS_NICE in block/ioprio.c
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, I found that there are checks for CAP_SYS_NICE both in
ioprio_check_cap and set_task_ioprio. In the syscall ioprio_set, it
first calls ioprio_check_cap() to check ioprio, then in each case
inside the switch block, it will call set_task_ioprio() to set
priority for the process. (just like below)
-------------------------------------
SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
{
    ...
    ret = ioprio_check_cap(ioprio);  // check CAP_SYS_NICE
    ...
    switch (which) {
        case IOPRIO_WHO_PROCESS:
            ...
                ret = set_task_ioprio(p, ioprio);   // check CAP_SYS_NICE
        case IOPRIO_WHO_PGRP:
            ...
                ret = set_task_ioprio(p, ioprio);   // check CAP_SYS_NICE
        case IOPRIO_WHO_USER:
            ...
                ret = set_task_ioprio(p, ioprio);   // check CAP_SYS_NICE
        ...
    }
    ...
}
-------------------------------------
Is it possible to remove the check for CAP_SYS_NICE inside
ioprio_check_cap? (for set_task_ioprio will check it later) Or, it's
better to keep these two checks for some special reason?

Thanks!

Best regards,
Tianyu
