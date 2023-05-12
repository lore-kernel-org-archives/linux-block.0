Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E2C7EE23
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbjELPJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbjELPJk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:09:40 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A157EF5
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c56d0e265so30998839f.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683904177; x=1686496177;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riXTmuNkJrjrsvyRkNF1e8x869qaj/USgi5320Q7l+g=;
        b=h2oPKcRg9uC/F8FTvzVhPWPEx5YSFwUyN/2DYVdmmybfqCpepVYWfRcZvKaBTgYOt+
         smloatahTL07Fm0M+GdtlQMfS3zuWAqtLwkGVuqSuHJ0JKmoYBry4Ti7cnlC9fOPWdtD
         bmf+e/gnFWbn6tIDZXWLfDbdbOmoemdmAT8RG9ULA1lu6r4LEtaULEfDbahF1h0lIUBd
         TBNI/+HViieSjrIVUaFK60VOtbuQr2ado/RV4rKGozkb1yVWy3DwFRlyorgB5zq910rc
         RHmLV1C3S8UmCmraje5ubXDbcja6puaokNmt4pvwTcx9RLmLuSdfAlasieJ2wxJAaPyO
         r1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904177; x=1686496177;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riXTmuNkJrjrsvyRkNF1e8x869qaj/USgi5320Q7l+g=;
        b=eRWgEdQFgKF6iA6kpaTnwozHQTwMqYjx/DRQoogeX0gzXwXRpn1f7qfFwoWutP31Id
         BNMTP809ujOBDQstJWPboD/3iJ8zlnDnt4abAgjc7iotNPqxDn16CYGtr4HMTEoVXgFK
         xmWPnhWfa/Ltu65WrqX+7RNRsem+PSmHAh0DvgkAKJR8BkR+lhCfP92y3AmSmV2gTDwL
         TLxyt3hcInkNdIKFSRYwztDtjwppkZqs9UipFUVAqgpa18QkWwNA+XzUIyacxQjAUnno
         CksrbFXp3s28s78HbLTrv8IsN/dQERkmiq1frQO41n/wpFBO87maXjviI4YoK4sWhSeL
         xIxA==
X-Gm-Message-State: AC+VfDyVrwLsAQujCEbJakW6bDMChxbOl90+zX7kn+FFvXoqjNkokOev
        yyDlNBryeMptGngbeHGTPVTZRhZSRUPuPx2siDc=
X-Google-Smtp-Source: ACHHUZ7JhgzizkRLjYVy1vXRRHxMeMFQ7/CmFD/u09Sdicu1srYWmzNWziJ3y0Up9wtoy2VA8nbA9A==
X-Received: by 2002:a6b:c842:0:b0:76c:58d8:ff14 with SMTP id y63-20020a6bc842000000b0076c58d8ff14mr6446186iof.2.1683904177222;
        Fri, 12 May 2023 08:09:37 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a6be315000000b0076c6f5b8db5sm1685542ioc.16.2023.05.12.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 08:09:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     hch@infradead.org, linux-block@vger.kernel.org
In-Reply-To: <20230512034631.28686-1-guoqing.jiang@linux.dev>
References: <20230512034631.28686-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Message-Id: <168390417558.869582.12806498816427316733.b4-ty@kernel.dk>
Date:   Fri, 12 May 2023 09:09:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 12 May 2023 11:46:31 +0800, Guoqing Jiang wrote:
> Since flush bios are implemented as writes with no data and
> the preflush flag per Christoph's comment [1].
> 
> And we need to change it in rnbd accordingly. Otherwise, I
> got splatting when create fs from rnbd client.
> 
> [  464.028545] ------------[ cut here ]------------
> [  464.028553] WARNING: CPU: 0 PID: 65 at block/blk-core.c:751 submit_bio_noacct+0x32c/0x5d0
> [ ... ]
> [  464.028668] CPU: 0 PID: 65 Comm: kworker/0:1H Tainted: G           OE      6.4.0-rc1 #9
> [  464.028671] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [  464.028673] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [  464.028717] RIP: 0010:submit_bio_noacct+0x32c/0x5d0
> [  464.028720] Code: 03 0f 85 51 fe ff ff 48 8b 43 18 8b 88 04 03 00 00 85 c9 0f 85 3f fe ff ff e9 be fd ff ff 0f b6 d0 3c 0d 74 26 83 fa 01 74 21 <0f> 0b b8 0a 00 00 00 e9 56 fd ff ff 4c 89 e7 e8 70 a1 03 00 84 c0
> [  464.028722] RSP: 0018:ffffaf3680b57c68 EFLAGS: 00010202
> [  464.028724] RAX: 0000000000060802 RBX: ffffa09dcc18bf00 RCX: 0000000000000000
> [  464.028726] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffa09dde081d00
> [  464.028727] RBP: ffffaf3680b57c98 R08: ffffa09dde081d00 R09: ffffa09e38327200
> [  464.028729] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa09dde081d00
> [  464.028730] R13: ffffa09dcb06e1e8 R14: 0000000000000000 R15: 0000000000200000
> [  464.028733] FS:  0000000000000000(0000) GS:ffffa09e3bc00000(0000) knlGS:0000000000000000
> [  464.028735] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  464.028736] CR2: 000055a4e8206c40 CR3: 0000000119f06000 CR4: 00000000003506f0
> [  464.028738] Call Trace:
> [  464.028740]  <TASK>
> [  464.028746]  submit_bio+0x1b/0x80
> [  464.028748]  rnbd_srv_rdma_ev+0x50d/0x10c0 [rnbd_server]
> [  464.028754]  ? percpu_ref_get_many.constprop.0+0x55/0x140 [rtrs_server]
> [  464.028760]  ? __this_cpu_preempt_check+0x13/0x20
> [  464.028769]  process_io_req+0x1dc/0x450 [rtrs_server]
> [  464.028775]  rtrs_srv_inv_rkey_done+0x67/0xb0 [rtrs_server]
> [  464.028780]  __ib_process_cq+0xbc/0x1f0 [ib_core]
> [  464.028793]  ib_cq_poll_work+0x2b/0xa0 [ib_core]
> [  464.028804]  process_one_work+0x2a9/0x580
> 
> [...]

Applied, thanks!

[1/1] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
      commit: 5e6e08087a4acb4ee3574cea32dbff0f63c7f608

Best regards,
-- 
Jens Axboe



