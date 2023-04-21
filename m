Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A94C7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 00:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDUAiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 20:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDUAiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 20:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D61C4EED
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682037448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xtTSOUac3kURN73axxeyk2EO2Etq2XUZGphvjz6bVkE=;
        b=DSJpdMvRNjiu+R0fln7+WjZXXjr2QNnoDSwcu6SoR63ZSnq3uq8ZsIMfh70f52Vy7FTfDg
        Lc+T6dBKK/degkxvyBFBH54vXLdFQlitk/EfwHEZ+k8bCHcSQG+UA/eOrH2zzxuKvdlrtu
        RXr3lTATBPPUGvEndO2wYbDrQ0sGPNU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Y5AgSROrOUaFI5jEFh-08w-1; Thu, 20 Apr 2023 20:37:26 -0400
X-MC-Unique: Y5AgSROrOUaFI5jEFh-08w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1a681ad22c8so10450645ad.2
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 17:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682037445; x=1684629445;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtTSOUac3kURN73axxeyk2EO2Etq2XUZGphvjz6bVkE=;
        b=UOSuRPpMwRxRR5nekv0JAIA2UgynzDZ17If6AdRExj2HxgLVkx6s+jpnXCJucDLGkT
         XJzpeckLPlfwN31ejs/n7afqNY9mWzgkqnFf/HuMKF6OQofBxp3OhUHEMhPEQeFRMQ6E
         6IB42pWLjY/0rrbcR6xQPl3N/rs2yER8/Y3wRcbLh97RoTaI39WKcypXUMQcBMS5GRRK
         wjQjqP4LK3K3N3JSHO6AhXx87Gqkzvw4vh2nWmhGlnAavgcLD+/HtKFIklGigWG7vI8o
         SGM64PfFZgrL8I/Fjj7hAv9Gl4UDshafDHlcmXP5UAT6zmxr3A7+MJUyOqi40OrPl2c9
         8ASA==
X-Gm-Message-State: AAQBX9cr2yq76NS+tZo4AkDkU5wY8aYsrVyfUH5aQRx/UuG73GN/3tH0
        BzPAAyxGt2vYIvUcAup8xLeYI5J/thcVaa+gNPimyAarG0JsaO30D+GZ4qdwFQhoYxyvEKPL3Gz
        a/CvnkDLua7omMDAUzRs8XUaRBKOVTdNzdUsWccIS5X4ihMevqlwT
X-Received: by 2002:a17:903:41ca:b0:1a4:fca9:7f44 with SMTP id u10-20020a17090341ca00b001a4fca97f44mr3972060ple.56.1682037445395;
        Thu, 20 Apr 2023 17:37:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmg9kOpRdodDz0e6pUCkhTFuNUm4NdfOAr2pmDQLjKJaZkHz3mrlH4YnTDS70fAzUC+LGhjHpTvqiKMdD2QnA=
X-Received: by 2002:a17:903:41ca:b0:1a4:fca9:7f44 with SMTP id
 u10-20020a17090341ca00b001a4fca97f44mr3972037ple.56.1682037445037; Thu, 20
 Apr 2023 17:37:25 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 21 Apr 2023 08:37:13 +0800
Message-ID: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
Subject: [bug report] kmemleak observed during blktests nvme-tcp
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Below kmemleak observed after blktests nvme-tcp, pls help check it, thanks.

commit: linux-block/for-next
aaf9cff31abe (origin/for-next) Merge branch 'for-6.4/io_uring' into for-next

unreferenced object 0xffff88821f0cc880 (size 32):
  comm "kworker/1:2H", pid 3067, jiffies 4295825061 (age 12918.254s)
  hex dump (first 32 bytes):
    82 0c 38 08 00 ea ff ff 00 00 00 00 00 10 00 00  ..8.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
    [<ffffffff8776d0bf>] sgl_alloc_order+0x7f/0x360
    [<ffffffffc0ba9875>] 0xffffffffc0ba9875
    [<ffffffffc0bb068f>] 0xffffffffc0bb068f
    [<ffffffffc0bb2038>] 0xffffffffc0bb2038
    [<ffffffffc0bb257c>] 0xffffffffc0bb257c
    [<ffffffffc0bb2de3>] 0xffffffffc0bb2de3
    [<ffffffff86897f49>] process_one_work+0x8b9/0x1550
    [<ffffffff8689919c>] worker_thread+0x5ac/0xed0
    [<ffffffff868b2222>] kthread+0x2a2/0x340
    [<ffffffff866063ac>] ret_from_fork+0x2c/0x50
unreferenced object 0xffff88823abb7c00 (size 512):
  comm "nvme", pid 6312, jiffies 4295856007 (age 12887.309s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff a0 53 5f 8e ff ff ff ff  .........S_.....
  backtrace:
    [<ffffffff86f63da7>] kmalloc_trace+0x27/0xe0
    [<ffffffff87d61205>] device_add+0x645/0x12f0
    [<ffffffff871c2a73>] cdev_device_add+0xf3/0x230
    [<ffffffffc09ed7c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
    [<ffffffffc0b54e0c>] 0xffffffffc0b54e0c
    [<ffffffffc086b177>] 0xffffffffc086b177
    [<ffffffffc086b613>] 0xffffffffc086b613
    [<ffffffff871b41e6>] vfs_write+0x216/0xc60
    [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
    [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
    [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff88810ccc9b80 (size 96):
  comm "nvme", pid 6312, jiffies 4295856008 (age 12887.308s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff86f63da7>] kmalloc_trace+0x27/0xe0
    [<ffffffff87d918e0>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x200
    [<ffffffffc09ed83c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
    [<ffffffffc0b54e0c>] 0xffffffffc0b54e0c
    [<ffffffffc086b177>] 0xffffffffc086b177
    [<ffffffffc086b613>] 0xffffffffc086b613
    [<ffffffff871b41e6>] vfs_write+0x216/0xc60
    [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
    [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
    [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8881d1fdb780 (size 64):
  comm "check", pid 6358, jiffies 4295859851 (age 12883.466s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 4e 46 76 44 6d 75  DHHC-1:00:NFvDmu
    52 58 77 79 54 79 62 57 78 70 43 4a 45 4a 68 36  RXwyTybWxpCJEJh6
  backtrace:
    [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
    [<ffffffffc09fb710>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_core]
    [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff871b47d2>] vfs_write+0x802/0xc60
    [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
    [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
    [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8881d1fdb600 (size 64):
  comm "check", pid 6358, jiffies 4295859908 (age 12883.409s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 4e 46 76 44 6d 75  DHHC-1:00:NFvDmu
    52 58 77 79 54 79 62 57 78 70 43 4a 45 4a 68 36  RXwyTybWxpCJEJh6
  backtrace:
    [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
    [<ffffffffc09fb710>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_core]
    [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff871b47d2>] vfs_write+0x802/0xc60
    [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
    [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
    [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

--
Best Regards,
  Yi Zhang

