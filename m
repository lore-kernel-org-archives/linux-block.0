Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60730C48BE0
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D401613DE
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 15:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFKPPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:15:22 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:42604 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKPPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 11:15:21 -0400
Received: by mail-ej1-f47.google.com with SMTP id k25so5052142eja.9
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mn6jzUsVPHH3R0oXLF1/xAS/lFbxM8x4AAoXhzQmxh4=;
        b=mcOavaBbARncM2CA6iUipG1isTlgMCbqkMxDfVHQAT/6hHdx/+/hbwO11L/L+E+v7j
         L72GTk8PEtTS2xJCRkVhoUiN5/ZXZrCWR9+TfXGEN18NyUbM4wRmWCNAz6eG4iA7cZYi
         wf4oI6H84TxUmw0IPj+oVa8VC7vCUddT4a6m9MuJVfjHpBoB/3jrM1qxBjbB1hGxbdy4
         nt57TGcaRr4GqrPSejNKRrq8vVJgHxiVl574pXtgN5T+PKQFl3xW2+VJKeBL0pHDQ9al
         LHUt9kOQfGt1P2Z9YLVo2fZqsaCDm5rEjkPz1rKwjXuRApQ806mBdz/stgjqqHVz5KzO
         /WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mn6jzUsVPHH3R0oXLF1/xAS/lFbxM8x4AAoXhzQmxh4=;
        b=ajMLuXbzJTmv3Ac0MD22v/dnpBi6RfqWeDm8sfhcMG1FxIx+JrikOzSUTFXBxA1iLV
         OTLZfiBB93090ZOrI2Oom9Qg+WRmZ2knFJDv7r82WTOqa183/mV4T3FYDzCHtETLJIKs
         hTPScf7aBqqhog4TsNFaYc3qX6Alq/kZAVCLj5JRDxutUP3aVCYOKvOTUqj6DYvozm1U
         BDP3nvddhxYDNICFmeRrMSFSLluBz6uVvOQjulztwE++ekanp/ADBhOd7DHa97wSIUyG
         oQbGPi8pVK/NIt0jXzpNyhF775iZ/6mEnimuMoC2tbpw2U6yC/1NbEkzcs5BXXLK52k+
         j4PQ==
X-Gm-Message-State: AOAM533Sg3M3ewS4lcHgdE2vg5Ybc9FmrheF/9qipW4gJXE27k1otSj/
        BqSScCYXlKaHZmxdEKALVe2H3OmSHkz1ikn2MMmFtA==
X-Google-Smtp-Source: ABdhPJzNE4G469QuiQdFpOpyQD/QeTCYcSWLVr648fmxf26KsPpQElHY212dh4rmJvzFvzkzdBhDcscYNnrfqQveEt4=
X-Received: by 2002:a17:906:490:: with SMTP id f16mr4200567eja.541.1623424330299;
 Fri, 11 Jun 2021 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae236f05bfde0678@google.com> <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia> <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
In-Reply-To: <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 11 Jun 2021 11:11:34 -0400
Message-ID: <CA+CK2bDWb2=bsoacY-eqZExObBpXuZE0a3Mr18_FXmGZTC5GnQ@mail.gmail.com>
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

On Fri, Jun 11, 2021 at 10:47 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/06/10 1:46, Tyler Hicks wrote:
> > Thanks for doing this. I haven't had a chance to retry this commit with
> > lockdep but I did re-review it and didn't think that it would be the
> > cause of this lockdep report since it strictly reduced the usage of the
> > loop_ctl_mutex.
>
> Well, I made commit 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")
> because per device lock was not sufficient. Did commit 6cc8e7430801fa23 ("loop: scale loop
> device by introducing per device lock") take this problem into account?

This was my intention when I wrote 6cc8e7430801fa23 ("loop: scale loop
device by introducing per device lock"). This is why this change does
not simply revert 310ca162d779efee ("block/loop: Use global lock for
ioctl() operation."), but keeps loop_ctl_mutex to protect the global
accesses.  loop_control_ioctl() is still locked by global
loop_ctl_mutex.
