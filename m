Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B3C433E9
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE5064F3D
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCBXfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379153AbhCBBMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 20:12:40 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD5C061788
        for <linux-block@vger.kernel.org>; Mon,  1 Mar 2021 17:11:58 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t26so12790176pgv.3
        for <linux-block@vger.kernel.org>; Mon, 01 Mar 2021 17:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tQRylwC7FAvN0F/bBIP0t+688gl4yvy+odRc0feyS9Y=;
        b=ubLOcq546XToAmmbIzobC3s9/PaSLx+F7qRU09TugZmKZvcIYC7K3xN9r4kFDnUyct
         RjO+Bqoa4QbBXm7E4yKECn9DKgCSICZMx2Pa9Sty9pXQObB0TbXbZy98vpn/h8xcqSqU
         FDcqVnFN4mDN2CtGWQCdJbIa8vOfQbBHiNhra1Epi0723A9ihUA+qqtl2IqYpuMhCMYt
         ISeJkppdLOgosn/udWRTBGvGBrMKQ2QCERUbrRP5QJGxUcBJZ2gzu//ZeA4DNLp7XSn0
         BWlEc6K2Y4XkdHRfW5FI72B8bNIFwum+qfMhG3sSsCZH29n3jHTp723nQ5Tge+2SKZJc
         mVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQRylwC7FAvN0F/bBIP0t+688gl4yvy+odRc0feyS9Y=;
        b=RrUDnnfhPkoQD8mJBhumV8ls6Rwxj4HfBe4S8vswpOLcsQDWjkGATQaOl9g0xrkuiv
         TjST6Cc/UsYZC/hPry/zJqQwEjoNd8stjJdVLwvFEAok6t4xTj/2q77/wcAuEQr7xV5D
         V7Ny7aQrzgHBThTPOOygg5EmkfLxMp7OtaMziOqwbA7P2mrS3gfC1nhAQAVTiQvZx41P
         RctqhNF5lC+78tJR6M6C4TfNkoTJJdzHustNHZiJfauuaMOCoBx+hJ+5PbY1lpieCZgU
         781Sem7s/ERFuwJ9od6fcOHnmFIz5taTd4LpESivDbp8rWcaZJcHDW7HsnIf+czM+DqB
         jN9w==
X-Gm-Message-State: AOAM533LzjLqEqCA8IfMQqQgclZhcXfWVT9nZaCt366hXvzyVYR9B+xp
        6ihr66HZAk146e9ONxQw0/ZFRIZTA+tNww==
X-Google-Smtp-Source: ABdhPJz8pXTcLwjj9y4NqTFdKoDduP1GxO11UXuy+b7zDcI+ZpzXGmVr/eIR2Ef/gxi2a5qjaz2AMg==
X-Received: by 2002:a62:43:0:b029:1cd:2de2:5a24 with SMTP id 64-20020a6200430000b02901cd2de25a24mr1066069pfa.27.1614647517023;
        Mon, 01 Mar 2021 17:11:57 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t6sm17740991pgp.57.2021.03.01.17.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 17:11:56 -0800 (PST)
Subject: Re: 5.12-rc1 regression: freezing iou-mgr/wrk failed
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <1614646241.av51lk2de4.none.ref@localhost>
 <1614646241.av51lk2de4.none@localhost>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad672889-2757-142b-9259-3e0aee6d8078@kernel.dk>
Date:   Mon, 1 Mar 2021 18:11:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614646241.av51lk2de4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/21 5:57 PM, Alex Xu (Hello71) wrote:
> Hi,
> 
> On Linux 5.12-rc1, I am unable to suspend to RAM. The system freezes for 
> about 40 seconds and then continues operation. The following messages 
> are printed to the kernel log:
> 
> [  240.650300] PM: suspend entry (deep)
> [  240.650748] Filesystems sync: 0.000 seconds
> [  240.725605] Freezing user space processes ...
> [  260.739483] Freezing of tasks failed after 20.013 seconds (3 tasks refusing to freeze, wq_busy=0):
> [  260.739497] task:iou-mgr-446     state:S stack:    0 pid:  516 ppid:   439 flags:0x00004224
> [  260.739504] Call Trace:
> [  260.739507]  ? sysvec_apic_timer_interrupt+0xb/0x81
> [  260.739515]  ? pick_next_task_fair+0x197/0x1cde
> [  260.739519]  ? sysvec_reschedule_ipi+0x2f/0x6a
> [  260.739522]  ? asm_sysvec_reschedule_ipi+0x12/0x20
> [  260.739525]  ? __schedule+0x57/0x6d6
> [  260.739529]  ? del_timer_sync+0xb9/0x115
> [  260.739533]  ? schedule+0x63/0xd5
> [  260.739536]  ? schedule_timeout+0x219/0x356
> [  260.739540]  ? __next_timer_interrupt+0xf1/0xf1
> [  260.739544]  ? io_wq_manager+0x73/0xb1
> [  260.739549]  ? io_wq_create+0x262/0x262
> [  260.739553]  ? ret_from_fork+0x22/0x30
> [  260.739557] task:iou-mgr-517     state:S stack:    0 pid:  522 ppid:   439 flags:0x00004224
> [  260.739561] Call Trace:
> [  260.739563]  ? sysvec_apic_timer_interrupt+0xb/0x81
> [  260.739566]  ? pick_next_task_fair+0x16f/0x1cde
> [  260.739569]  ? sysvec_apic_timer_interrupt+0xb/0x81
> [  260.739571]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  260.739574]  ? __schedule+0x5b7/0x6d6
> [  260.739578]  ? del_timer_sync+0x70/0x115
> [  260.739581]  ? schedule_timeout+0x211/0x356
> [  260.739585]  ? __next_timer_interrupt+0xf1/0xf1
> [  260.739588]  ? io_wq_check_workers+0x15/0x11f
> [  260.739592]  ? io_wq_manager+0x69/0xb1
> [  260.739596]  ? io_wq_create+0x262/0x262
> [  260.739600]  ? ret_from_fork+0x22/0x30
> [  260.739603] task:iou-wrk-517     state:S stack:    0 pid:  523 ppid:   439 flags:0x00004224
> [  260.739607] Call Trace:
> [  260.739609]  ? __schedule+0x5b7/0x6d6
> [  260.739614]  ? schedule+0x63/0xd5
> [  260.739617]  ? schedule_timeout+0x219/0x356
> [  260.739621]  ? __next_timer_interrupt+0xf1/0xf1
> [  260.739624]  ? task_thread.isra.0+0x148/0x3af
> [  260.739628]  ? task_thread_unbound+0xa/0xa
> [  260.739632]  ? task_thread_bound+0x7/0x7
> [  260.739636]  ? ret_from_fork+0x22/0x30
> [  260.739647] OOM killer enabled.
> [  260.739648] Restarting tasks ... done.
> [  260.740077] PM: suspend exit
> 
> and then a set of similar messages except with s2idle instead of deep.
> 
> Reverting 5695e51619 ("Merge tag 'io_uring-worker.v3-2021-02-25' of 
> git://git.kernel.dk/linux-block") appears to resolve the issue. I have 
> not yet bisected further. Let me know which troubleshooting steps I 
> should perform next.

Can you try and pull in:

git://git.kernel.dk/linux-block io_uring-5.12

and see if that resolves it? I usually always run -git on my laptop as
well, but something broke it in the merge window so I need to figure
out what that is first...

What distro are you running?

-- 
Jens Axboe

