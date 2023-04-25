Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A6FC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjDYJzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDYJzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 05:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100585BBA
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682416463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQPavGMXm4ldeRohBma2CnLIbYX/ZIAzG7+DRb/+j3Y=;
        b=BUcRn/BrXM15HfITc9ICCSIQnrKpz6e9vuCMHILJ+MRXZDdbRQ60wl3hci4Gil7Iln/g26
        LqMaPIefLPFomUFjcgKjnSL0FBNK4HIs3kDcvPtV4pjthtMIdw1rteE7KwARO/VjW5rO4W
        XiR8naHCwzHI9ElnBcnJxBP2pwyWuaM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-XxLrXuy0OJW0dWeZP8uF6Q-1; Tue, 25 Apr 2023 05:54:21 -0400
X-MC-Unique: XxLrXuy0OJW0dWeZP8uF6Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63d30b08700so29255156b3a.1
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 02:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682416460; x=1685008460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQPavGMXm4ldeRohBma2CnLIbYX/ZIAzG7+DRb/+j3Y=;
        b=CzzNxu3U3PiSKnFebuktHnIAEtatjT0pfbSdKVD4rqLNGj6R7HiGRJtVaJdl2vO3TO
         9Sf78h1LZsT6aKjx7Ba5f+MYtFcMbfG2BRoy98ZmMOMTVfUYi+Y0h5+5/qumjdtY+vfi
         f3g0n8ZbC6gnmlC2WBwl5PV70dvXiw0eY2GoTYpKeETmpbF01o85iJDdyfptbjUc8iV7
         j95SYN8q51DtVH8dOLBy0BaW5tFjrH7H8WfqxWNDIZvTqn8JiKB9v2tcZ/TFpCq+g0l+
         MaQtihQcU5SwH3jg5DWcVbHTxfsqFdVgJbKmGSwNrqjIRIuLF70H4O4XlJuyY8dFRg5x
         Wo0w==
X-Gm-Message-State: AAQBX9fyFm87lduXHRHaKSYnvBa4+aQNf4Kr+t9/fymjEzawaL+sLcfT
        a/wwbBUorTkos+ubgknNnER5TbSP7hiJRyv7Xx2Zr2G13TItuzeSOoNTc068GhLka5X8ey5PkRJ
        bIDeA+eOClJXOyDOQjQQVQ1SfvlnzNL95hFfj+r4=
X-Received: by 2002:a17:90b:1906:b0:23d:54e8:3bb7 with SMTP id mp6-20020a17090b190600b0023d54e83bb7mr19997961pjb.17.1682416459653;
        Tue, 25 Apr 2023 02:54:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZPHkaXLHpLyIkFQ1+t9KgPo9wcC1aoWyUrNN8iZeKHcFKB37OmKfMJkwC6se6EFGBNaBG4pwNUvJpe1+vIScw=
X-Received: by 2002:a17:90b:1906:b0:23d:54e8:3bb7 with SMTP id
 mp6-20020a17090b190600b0023d54e83bb7mr19997948pjb.17.1682416459307; Tue, 25
 Apr 2023 02:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
In-Reply-To: <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 25 Apr 2023 17:54:06 +0800
Message-ID: <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 23, 2023 at 10:15=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> w=
rote:
>
>
> > Hello
> >
> > Below kmemleak observed after blktests nvme-tcp, pls help check it, tha=
nks.
> >
> > commit: linux-block/for-next
> > aaf9cff31abe (origin/for-next) Merge branch 'for-6.4/io_uring' into for=
-next
>
> Hey Yi,
>
> Is this a regression?
I'm not sure, but both can be reproduced on 6.2.0

> And can you correlate to specific tests that trigger this?
>

Yes, just run blktests nvme-tcp nvme/044 nvme/045 could trigger them:

nvme/044
unreferenced object 0xffff8881911f7800 (size 512):
  comm "nvme", pid 8233, jiffies 4295443413 (age 157.206s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 60 70 79 9b ff ff ff ff  ........`py.....
  backtrace:
    [<ffffffff93767af7>] kmalloc_trace+0x27/0xe0
    [<ffffffff94568e85>] device_add+0x645/0x12f0
    [<ffffffff939c6fa3>] cdev_device_add+0xf3/0x230
    [<ffffffffc0a697c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
    [<ffffffffc1f6ce0c>] 0xffffffffc1f6ce0c
    [<ffffffffc1f4d177>] 0xffffffffc1f4d177
    [<ffffffffc1f4d613>] 0xffffffffc1f4d613
    [<ffffffff939b8716>] vfs_write+0x216/0xc60
    [<ffffffff939b99a9>] ksys_write+0xf9/0x1d0
    [<ffffffff95378c4c>] do_syscall_64+0x5c/0x90
    [<ffffffff954000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8882297fc780 (size 96):
  comm "nvme", pid 8233, jiffies 4295443414 (age 157.205s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff93767af7>] kmalloc_trace+0x27/0xe0
    [<ffffffff94599560>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x20=
0
    [<ffffffffc0a6983c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
    [<ffffffffc1f6ce0c>] 0xffffffffc1f6ce0c
    [<ffffffffc1f4d177>] 0xffffffffc1f4d177
    [<ffffffffc1f4d613>] 0xffffffffc1f4d613
    [<ffffffff939b8716>] vfs_write+0x216/0xc60
    [<ffffffff939b99a9>] ksys_write+0xf9/0x1d0
    [<ffffffff95378c4c>] do_syscall_64+0x5c/0x90
    [<ffffffff954000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

nvme/045
unreferenced object 0xffff8881e3b32200 (size 64):
  comm "check", pid 8335, jiffies 4295703407 (age 177.101s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 77 59 5a 2f 37 4f  DHHC-1:00:wYZ/7O
    4f 33 2b 71 34 74 6c 38 45 6c 73 71 59 68 55 41  O3+q4tl8ElsqYhUA
  backtrace:
    [<ffffffff937683fb>] __kmalloc+0x4b/0x190
    [<ffffffffc0a77830>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_co=
re]
    [<ffffffff93bd1708>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff939b8d02>] vfs_write+0x802/0xc60
    [<ffffffff939b99a9>] ksys_write+0xf9/0x1d0
    [<ffffffff95378c4c>] do_syscall_64+0x5c/0x90
    [<ffffffff954000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8881e3b32100 (size 64):
  comm "check", pid 8335, jiffies 4295703468 (age 177.040s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 77 59 5a 2f 37 4f  DHHC-1:00:wYZ/7O
    4f 33 2b 71 34 74 6c 38 45 6c 73 71 59 68 55 41  O3+q4tl8ElsqYhUA
  backtrace:
    [<ffffffff937683fb>] __kmalloc+0x4b/0x190
    [<ffffffffc0a77830>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_co=
re]
    [<ffffffff93bd1708>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff939b8d02>] vfs_write+0x802/0xc60
    [<ffffffff939b99a9>] ksys_write+0xf9/0x1d0
    [<ffffffff95378c4c>] do_syscall_64+0x5c/0x90
    [<ffffffff954000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

> >
> > unreferenced object 0xffff88821f0cc880 (size 32):
> >    comm "kworker/1:2H", pid 3067, jiffies 4295825061 (age 12918.254s)
> >    hex dump (first 32 bytes):
> >      82 0c 38 08 00 ea ff ff 00 00 00 00 00 10 00 00  ..8.............
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
> >      [<ffffffff8776d0bf>] sgl_alloc_order+0x7f/0x360
> >      [<ffffffffc0ba9875>] 0xffffffffc0ba9875
> >      [<ffffffffc0bb068f>] 0xffffffffc0bb068f
> >      [<ffffffffc0bb2038>] 0xffffffffc0bb2038
> >      [<ffffffffc0bb257c>] 0xffffffffc0bb257c
> >      [<ffffffffc0bb2de3>] 0xffffffffc0bb2de3
> >      [<ffffffff86897f49>] process_one_work+0x8b9/0x1550
> >      [<ffffffff8689919c>] worker_thread+0x5ac/0xed0
> >      [<ffffffff868b2222>] kthread+0x2a2/0x340
> >      [<ffffffff866063ac>] ret_from_fork+0x2c/0x50
> > unreferenced object 0xffff88823abb7c00 (size 512):
> >    comm "nvme", pid 6312, jiffies 4295856007 (age 12887.309s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> >      ff ff ff ff ff ff ff ff a0 53 5f 8e ff ff ff ff  .........S_.....
> >    backtrace:
> >      [<ffffffff86f63da7>] kmalloc_trace+0x27/0xe0
> >      [<ffffffff87d61205>] device_add+0x645/0x12f0
> >      [<ffffffff871c2a73>] cdev_device_add+0xf3/0x230
> >      [<ffffffffc09ed7c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
> >      [<ffffffffc0b54e0c>] 0xffffffffc0b54e0c
> >      [<ffffffffc086b177>] 0xffffffffc086b177
> >      [<ffffffffc086b613>] 0xffffffffc086b613
> >      [<ffffffff871b41e6>] vfs_write+0x216/0xc60
> >      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
> >      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff88810ccc9b80 (size 96):
> >    comm "nvme", pid 6312, jiffies 4295856008 (age 12887.308s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<ffffffff86f63da7>] kmalloc_trace+0x27/0xe0
> >      [<ffffffff87d918e0>] dev_pm_qos_update_user_latency_tolerance+0xe0=
/0x200
> >      [<ffffffffc09ed83c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
> >      [<ffffffffc0b54e0c>] 0xffffffffc0b54e0c
> >      [<ffffffffc086b177>] 0xffffffffc086b177
> >      [<ffffffffc086b613>] 0xffffffffc086b613
> >      [<ffffffff871b41e6>] vfs_write+0x216/0xc60
> >      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
> >      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff8881d1fdb780 (size 64):
> >    comm "check", pid 6358, jiffies 4295859851 (age 12883.466s)
> >    hex dump (first 32 bytes):
> >      44 48 48 43 2d 31 3a 30 30 3a 4e 46 76 44 6d 75  DHHC-1:00:NFvDmu
> >      52 58 77 79 54 79 62 57 78 70 43 4a 45 4a 68 36  RXwyTybWxpCJEJh6
> >    backtrace:
> >      [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
> >      [<ffffffffc09fb710>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nv=
me_core]
> >      [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
> >      [<ffffffff871b47d2>] vfs_write+0x802/0xc60
> >      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
> >      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff8881d1fdb600 (size 64):
> >    comm "check", pid 6358, jiffies 4295859908 (age 12883.409s)
> >    hex dump (first 32 bytes):
> >      44 48 48 43 2d 31 3a 30 30 3a 4e 46 76 44 6d 75  DHHC-1:00:NFvDmu
> >      52 58 77 79 54 79 62 57 78 70 43 4a 45 4a 68 36  RXwyTybWxpCJEJh6
> >    backtrace:
> >      [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
> >      [<ffffffffc09fb710>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nv=
me_core]
> >      [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
> >      [<ffffffff871b47d2>] vfs_write+0x802/0xc60
> >      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
> >      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > --
> > Best Regards,
> >    Yi Zhang
> >
>


--=20
Best Regards,
  Yi Zhang

