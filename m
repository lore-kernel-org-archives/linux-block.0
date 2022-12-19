Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A5AC4332F
	for <linux-block@archiver.kernel.org>; Mon, 19 Dec 2022 07:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiLSHRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Dec 2022 02:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiLSHRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 02:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065AA95A6
        for <linux-block@vger.kernel.org>; Sun, 18 Dec 2022 23:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671434185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=xSMvHf+auy2UcRRNDEcD1HPUFs/NEV4PX4QkZ5TGRiM=;
        b=VOOfhTXauhVf9XZMJGAjmzdRlVR4yfvyK4jXNo1hn48K14YiiOdJFoboeI1D3O5k9HqbfL
        hn8zOci729VHApyP1LU3sCJUJCs3CR9sG+OGNiN4ntAW4YnFotGdVOcsqWSy9VI2U0knm2
        PPmaRUWwakhICRoKvpYPQMp+zomzFl4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-wWtEKw_EOZaxKUv-0zQivg-1; Mon, 19 Dec 2022 02:16:23 -0500
X-MC-Unique: wWtEKw_EOZaxKUv-0zQivg-1
Received: by mail-pj1-f71.google.com with SMTP id x8-20020a17090a1f8800b0022153149290so3106644pja.5
        for <linux-block@vger.kernel.org>; Sun, 18 Dec 2022 23:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSMvHf+auy2UcRRNDEcD1HPUFs/NEV4PX4QkZ5TGRiM=;
        b=Vh9NTLZ5Y1PIT0y/AgRl4hhk+sHxRvfFVjmikCn1zWGASFRGQ1Doa5q8CtTaNco0aR
         fOVCdQ+AGrdUgB149FiVfO2LuLjXg2sAoDi1orz+EddTQOIGnI6fvPdgiahoRd2/I1Tn
         vjceIL05gPUKFZHW0DWgbPsbcE9NjTdtYxwUwL+NEgJLtaFcRX9wxS0ZERvo4FSOcu7k
         Ep+iaPfk5krxejiZAysJQEd7JE77bnWnJ3sEcXJXVkqBZWMBX/+Gm27dWBGE9pG1xbDi
         C+rLdzuGNBP6WaClVm9pkAJmKTgAKp+81InandnXgGcqq3CAJJwIdDfeeNGQoi9KMI9p
         fErQ==
X-Gm-Message-State: AFqh2kpfC0L8vu1h1gQAEJlV23RZTxtwNBn3gBQlMuC7X2io4J9FojK6
        yQhSuWyxzmoBMEF3PoQ419/h0OVtcUzIcrZZat8TZfFTTvQUhWQMVtGE8rYo5biFXbscztecM9+
        VCyS7ut1FPMQFFch90ffOx/kno59ILXn0cdGUAsY=
X-Received: by 2002:a17:90a:9744:b0:219:8464:84e3 with SMTP id i4-20020a17090a974400b00219846484e3mr1616792pjw.232.1671434182053;
        Sun, 18 Dec 2022 23:16:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvY8NPOpjTb7PI7aCDZ8bIWyUdEdYChfIZ1WVIZwXL+kuzCUzCrr0Y2xBrxun7s7uESyX0qfl9M9Z64uJm38V4=
X-Received: by 2002:a17:90a:9744:b0:219:8464:84e3 with SMTP id
 i4-20020a17090a974400b00219846484e3mr1616790pjw.232.1671434181590; Sun, 18
 Dec 2022 23:16:21 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 19 Dec 2022 15:16:10 +0800
Message-ID: <CAHj4cs-MzFV6WTfveRXTARsik9wTGgado2U4vnT8oH6vmfFjzQ@mail.gmail.com>
Subject: [bug report]BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
Below issue was triggered during blktests nvme-tcp with for-next
(6.1.0, block, 2280cbf6), pls help check it

[  782.395936] run blktests nvme/013 at 2022-12-18 07:32:09
[  782.425739] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  782.435780] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  782.446357] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0042-3910-8039-c6c04f544833.
[  782.460744] nvme nvme0: creating 32 I/O queues.
[  782.466760] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[  782.479615] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[  783.612793] XFS (nvme0n1): Mounting V5 Filesystem
[  783.650705] XFS (nvme0n1): Ending clean mount
[  799.653271] ==================================================================
[  799.660496] BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
[  799.669117] Use-after-free read at 0x000000008c692c21 (in kfence-#11):
[  799.675647]  bfq_exit_icq_bfqq+0x132/0x270
[  799.679753]  bfq_exit_icq+0x5b/0x80
[  799.683255]  exit_io_context+0x81/0xb0
[  799.687015]  do_exit+0x74b/0xaf0
[  799.690256]  kthread_exit+0x25/0x30
[  799.693758]  kthread+0xc8/0x110
[  799.696904]  ret_from_fork+0x1f/0x30
[  799.701991] kfence-#11: 0x00000000f1839eaa-0x0000000011c747a1,
size=568, cache=bfq_queue
[  799.711549] allocated by task 19533 on cpu 9 at 499.180335s:
[  799.717218]  bfq_get_queue+0xe0/0x530
[  799.720884]  bfq_get_bfqq_handle_split+0x75/0x120
[  799.725592]  bfq_insert_requests+0x1d15/0x2710
[  799.730045]  blk_mq_sched_insert_requests+0x5c/0x170
[  799.735021]  blk_mq_flush_plug_list+0x115/0x2e0
[  799.739551]  __blk_flush_plug+0xf2/0x130
[  799.743479]  blk_finish_plug+0x25/0x40
[  799.747231]  __iomap_dio_rw+0x520/0x7b0
[  799.751070]  btrfs_dio_write+0x42/0x50
[  799.754832]  btrfs_do_write_iter+0x2f4/0x5d0
[  799.759112]  nvmet_file_submit_bvec+0xa6/0xe0 [nvmet]
[  799.764193]  nvmet_file_execute_io+0x1a4/0x250 [nvmet]
[  799.769349]  process_one_work+0x1c4/0x380
[  799.773361]  worker_thread+0x4d/0x380
[  799.777028]  kthread+0xe6/0x110
[  799.780174]  ret_from_fork+0x1f/0x30
[  799.785252] freed by task 19533 on cpu 9 at 799.653250s:
[  799.790584]  bfq_put_queue+0x183/0x2c0
[  799.794344]  bfq_exit_icq_bfqq+0x129/0x270
[  799.798442]  bfq_exit_icq+0x5b/0x80
[  799.801934]  exit_io_context+0x81/0xb0
[  799.805687]  do_exit+0x74b/0xaf0
[  799.808920]  kthread_exit+0x25/0x30
[  799.812413]  kthread+0xc8/0x110
[  799.815561]  ret_from_fork+0x1f/0x30
[  799.820648] CPU: 9 PID: 19533 Comm: kworker/dying Not tainted 6.1.0 #1
[  799.827181] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
2.15.1 06/15/2022
[  799.834746] ==================================================================
[  823.081364] XFS (nvme0n1): Unmounting Filesystem
[  823.159994] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"


--
Best Regards,
  Yi Zhang

