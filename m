Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC885C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF7E61BD2
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhKQIKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232071AbhKQIKH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 03:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637136428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nilW13qTD/48ImqC9DdVhzc/yeDogF+YeNeQ4Gj89IE=;
        b=Yx0GeIPs+iKM7DMkCgbN07usx3SBJb/XeZDn4wAgGZV9Z3TqnPE/zc/Hq8TGXFy8KujrkI
        RkY0foGs0tk3fOaihGsOWD09sWcMgAN+M+6Z8aEprqX3fW/+Hj3SsdQty28RFO8bAUhT28
        4uJ4ArOc57QBe4Plzcg3jooYJsNrL58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-P6Z69iaeNAiUp-WUxpRxFA-1; Wed, 17 Nov 2021 03:07:04 -0500
X-MC-Unique: P6Z69iaeNAiUp-WUxpRxFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B101923761;
        Wed, 17 Nov 2021 08:07:02 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B86F5BAE5;
        Wed, 17 Nov 2021 08:06:50 +0000 (UTC)
Date:   Wed, 17 Nov 2021 16:06:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     damien.lemoal@wdc.com, axboe@kernel.dk, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, yi.zhang@huawei.com,
        yebin10@huawei.com, houtao1@huawei.com
Subject: Re: [QUESTION] blk_mq_freeze_queue in elevator_init_mq
Message-ID: <YZS4FYxtxYAXjtFJ@T590>
References: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 11:37:13AM +0800, yangerkun wrote:
> Nowdays we meet the boot regression while enable lots of mtdblock

What is your boot regression? Any dmesg log?

> compare with 4.4. The main reason was that the blk_mq_freeze_queue in
> elevator_init_mq will wait a RCU gap which want to make sure no IO will
> happen while blk_mq_init_sched.

There isn't RCU grace period implied in the blk_mq_freeze_queue() called
from elevator_init_mq(), because the .q_usage_counter works at atomic mode
at that time.

> 
> Other module like loop meets this problem too and has been fix with

Again, what is the problem?

> follow patches:
> 
>  2112f5c1330a loop: Select I/O scheduler 'none' from inside add_disk()
>  90b7198001f2 blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
> 
> They change the default IO scheduler for loop to 'none'. So no need to
> call blk_mq_freeze_queue and blk_mq_init_sched. But it seems not
> appropriate for mtdblocks. Mtdblocks can use 'mq-deadline' to help
> optimize the random write with the help of mtdblock's cache. Once change
> to 'none', we may meet the regression for random write.
> 
> commit 737eb78e82d52d35df166d29af32bf61992de71d
> Author: Damien Le Moal <damien.lemoal@wdc.com>
> Date:   Thu Sep 5 18:51:33 2019 +0900
> 
>     block: Delay default elevator initialization
> 
>     ...
> 
>     Additionally, to make sure that the elevator initialization is never
>     done while requests are in-flight (there should be none when the device
>     driver calls device_add_disk()), freeze and quiesce the device request
>     queue before calling blk_mq_init_sched() in elevator_init_mq().
>     ...
> 
> This commit add blk_mq_freeze_queue in elevator_init_mq which try to
> make sure no in-flight request while we go through blk_mq_init_sched.
> But does there any drivers can leave IO alive while we go through
> elevator_init_mq？ And if no, maybe we can just remove this logical to
> fix the regression...

SCSI should have passthrough requests at that moment.



Thanks,
Ming

