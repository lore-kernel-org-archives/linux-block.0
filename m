Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A3C77B6E
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDMNML (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDMNMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 09:12:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A1AAF11
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:11:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63243b0e85aso533462b3a.1
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681391487; x=1683983487;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j7Htpm8UoV0PWEokgdSWz4aWONGj1Ju1iipPf5HTjk=;
        b=KS8DOQChwGI8qhCsmrfKwapMiMj77xvUrDPVEy6KzssGyh2Ut2QsU2SwMRb0o5ClIp
         6DfsuSLQPGZWBaw/34CaX0yejjhOCHMBM522YWh6Qw25ncewbpYGMjr3el1X+kb7Hed3
         F2Xnljy1DSWQf9VLyRT00H5DOYSUlmMYrC23s3zjqGXHXFEQGHW4um5ZmYqQ9kIFbko+
         q8PZ2uSeGzNWAAjLk0xaX1l6ojKzSfIWcKK3yES+/TssbiDAe9q9rDd8UVIYt/NJQqWh
         E/NPC+semw4uY3kkJ9NUKS+nstZrHLYe5MEq4vRpZXTtNaqGDRYA27yYM0nmiiSoxoye
         qcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391487; x=1683983487;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j7Htpm8UoV0PWEokgdSWz4aWONGj1Ju1iipPf5HTjk=;
        b=Giu76ggrS0KJuXo58UrbaJbw9Op/oUZKFvZcnteNDQVh5zila5veEPJprBKq5BbU7k
         C73xpJL1pHUG3+QSzmzaeSgbM0L9P4Hf9VMDpoSjJWSU/DJN9jX2CSIGwD6DoSlE8k8G
         TLah5iNadUXXOi1F2TD3yBingPeJmYogjPTFa9clXkg28zhVcIpMkrVKx2tsG+VvhkKC
         lIC+QRb+N3Ua40DkMXdVUHFz1mFl8S3anlwyLumqvbwbmrLzPVbPpfWveJeVY6ca6f4V
         l6cuQahkYlqzWiCFMi3F0TEeAA6hGU7NowvtFEV77FFKoZ1birS6OrjnXpICzrnzqjfb
         aC7A==
X-Gm-Message-State: AAQBX9fw5HOW7ZHH1x9Kvr20PwHDHOcV9RfDt+2PCJQpGn0lIoUiEPcJ
        EfEuGN/Poa3BtB3FqcNUbnlwteYYGHXr8xzoqoI=
X-Google-Smtp-Source: AKy350ZdayUl/38EVoeEtiEZ+ccaTlxOympD4GhbwPXe/PLdeXBjmqoZmZLqskCWYTAcFtP2QF/dlg==
X-Received: by 2002:a05:6a00:418e:b0:634:c6b9:92e4 with SMTP id ca14-20020a056a00418e00b00634c6b992e4mr2865016pfb.0.1681391487472;
        Thu, 13 Apr 2023 06:11:27 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s18-20020a62e712000000b0062dee0221b2sm1387575pfh.21.2023.04.13.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:11:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
Subject: Re: cleanup request insertation parameters v3
Message-Id: <168139148674.18684.3205092880375599716.b4-ty@kernel.dk>
Date:   Thu, 13 Apr 2023 07:11:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 13 Apr 2023 08:40:37 +0200, Christoph Hellwig wrote:
> in context of his latest series Bart commented that it's too hard
> to find all spots that do a head insertation into the blk-mq dispatch
> queues.  This series collapses various far too deep callchains, drop
> two of the three bools and then replaced the final once with a greppable
> constant.
> 
> This will create some rebased work for Bart of top of the other comments
> he got, but I think this will allow us to sort out some of the request
> order issues much better while also making the code a lot more readable.
> 
> [...]

Applied, thanks!

[01/20] blk-mq: don't plug for head insertions in blk_execute_rq_nowait
        commit: 50947d7fe9fa6abe3ddc40769dfb02a51c58edb6
[02/20] blk-mq: remove blk-mq-tag.h
        commit: bebe84ebeec4d030aa65af58376305749762e5a0
[03/20] blk-mq: include <linux/blk-mq.h> in block/blk-mq.h
        commit: 90110e04f265b95f59fbae09c228c5920b8a302f
[04/20] blk-mq: move more logic into blk_mq_insert_requests
        commit: 94aa228c2a2f6edc8e9b7c4745942ea4c5978977
[05/20] blk-mq: fold blk_mq_sched_insert_requests into blk_mq_dispatch_plug_list
        commit: 05a93117703e7b2e40fa9193e622079b30395bcc
[06/20] blk-mq: move blk_mq_sched_insert_request to blk-mq.c
        commit: 2bd215df791b5d36ca1d20c07683100b48310cc2
[07/20] blk-mq: fold __blk_mq_insert_request into blk_mq_insert_request
        commit: a88db1e0003eda8adbe3c499b81f736d8065b952
[08/20] blk-mq: fold __blk_mq_insert_req_list into blk_mq_insert_request
        commit: 4ec5c0553c33e42f2d650785309de17d4cb8f5ba
[09/20] blk-mq: remove blk_flush_queue_rq
        commit: a4fa57ffb7671c2df4ce597d03ef9f7d6d905a60
[10/20] blk-mq: refactor passthrough vs flush handling in blk_mq_insert_request
        commit: 53548d2a945eb2c277332c66f57505881392e5a9
[11/20] blk-mq: refactor the DONTPREP/SOFTBARRIER andling in blk_mq_requeue_work
        commit: a1e948b81ad21d635b99c1284f945423cb02b4c4
[12/20] blk-mq: factor out a blk_mq_get_budget_and_tag helper
        commit: 2b71b8770710f2913e29053f01b6c7df1a5c7f75
[13/20] blk-mq: fold __blk_mq_try_issue_directly into its two callers
        commit: e1f44ac0d7f48ec44a1eacfe637e545c408ede40
[14/20] blk-mq: don't run the hw_queue from blk_mq_insert_request
        commit: f0dbe6e88e1bf4003ef778527b975ff60dbdd35a
[15/20] blk-mq: don't run the hw_queue from blk_mq_request_bypass_insert
        commit: 2394395cd598f6404c57ae0b63afb5d37e94924d
[16/20] blk-mq: don't kick the requeue_list in blk_mq_add_to_requeue_list
        commit: 214a441805b8cc090930fb00193125e22466a95a
[17/20] blk-mq: pass a flags argument to blk_mq_insert_request
        commit: 710fa3789ed94ceee9675f8e189aaf3e7525269a
[18/20] blk-mq: pass a flags argument to blk_mq_request_bypass_insert
        commit: 2b5976134bfbc753dec6281da0890c5f194c00c9
[19/20] blk-mq: pass a flags argument to elevator_type->insert_requests
        commit: 93fffe16f7ee18600f15838e2e8b5cf353f245c8
[20/20] blk-mq: pass a flags argument to blk_mq_add_to_requeue_list
        commit: b12e5c6c755ae8bec44723f77f037873e3d08021

Best regards,
-- 
Jens Axboe



