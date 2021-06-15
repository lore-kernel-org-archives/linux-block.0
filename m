Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2912C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 05:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC23613F1
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhFOFdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 01:33:17 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39632 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOFdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 01:33:17 -0400
Received: by mail-io1-f69.google.com with SMTP id n1-20020a6b8b010000b02904be419d64eeso16267635iod.6
        for <linux-block@vger.kernel.org>; Mon, 14 Jun 2021 22:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=csg99I4rGWEo3pYB7lIZft+yDOx1idwhkdQGhawX648=;
        b=HnrY67dw6jHkdnUdNxjS6V8eforTIZBG8yxr67gL5SB7ZVohhcBbHYedaAEBJMBWgW
         tLIp+q+AJLh/o5C8OvqKT/edh5x4loS+gjvLDPYRMI1M5RZpVyNulzcErRMvSDOOsvQM
         ZH275aWeNcJ8FUs93nOEQABeCwF9FLvY5Gl4zJ9L7she4lyzzg96/GXUy4gi5MVR4PmY
         hhRtXN4Mn3fERWcrX16bDq7aPj9IOuPVyfEMfpMpxFzfR28JqHN7zzrM6JH09YjVokiP
         Fcce6mfSx4XogzMqSzrHs+5h7H8iDfX4rs9wUcdHUHChYoZNmUjNi2oZeyS1q5YJGgSm
         IPMA==
X-Gm-Message-State: AOAM5322ggbgelGtjZKN3V8jk7p0njBr8tve5+u0LjAzTg2RNeKb0L1/
        XCW1A414COCcu5CPahK5Q1Nid0FDoWPSfNKpK3mGqZbcO8xL
X-Google-Smtp-Source: ABdhPJx3Ege/CFWiS55CcJYYIYBsoauRErYJr5BTZoDieeD9sYS1pJNKndUAGUWmkN4gV+ng6khvfSlrC0gzDh1F6ROt8Vpep58t
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:: with SMTP id l15mr16791685iln.153.1623735073079;
 Mon, 14 Jun 2021 22:31:13 -0700 (PDT)
Date:   Mon, 14 Jun 2021 22:31:13 -0700
In-Reply-To: <2af74b56-5f25-5f07-df48-86b341ad8c2a@i-love.sakura.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d865905c4c748c4@google.com>
Subject: Re: [PATCH] loop: drop loop_ctl_mutex around del_gendisk() in loop_remove()
From:   syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     axboe@kernel.dk, hch@lst.de, hoeppner@linux.ibm.com, jack@suse.cz,
        linux-block@vger.kernel.org, pasha.tatashin@soleen.com,
        penguin-kernel@i-love.sakura.ne.jp, pvorel@suse.cz,
        sth@linux.ibm.com, tj@kernel.org, tyhicks@linux.microsoft.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Found that commit 990e78116d38059c ("block: loop: fix deadlock between open and remove") went to 5.13-rc6.
>
> #syz fix: block: loop: fix deadlock between open and remove

Your 'fix:' command is accepted, but please keep syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as a history of what happened with each bug report. Thank you.

>
> Now syzbot is reporting
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(nbd_index_mutex);
>                                lock(&bdev->bd_mutex);
>                                lock(nbd_index_mutex);
>   lock(&bdev->bd_mutex);
>
> at https://syzkaller.appspot.com/text?tag=CrashReport&x=11b8a5bbd00000 .
>
