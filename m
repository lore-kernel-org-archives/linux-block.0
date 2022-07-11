Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B88FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 02:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGKC3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKC3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jul 2022 22:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3570E6363
        for <linux-block@vger.kernel.org>; Sun, 10 Jul 2022 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657506562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vz1GK9BX/gFWrmQP642bPgzY3Nvglr3NVgRq93Im89w=;
        b=f019XGULGnW31ctgHxDCos+PMckk39IiWenXaEmNbF86Yb9iJHZFdEaT6GzYiL1m51zwMO
        EYnBZBdbnATiwbQ8DD+xx8ieK5Dz6ARoSM+fgNaeSg6oPFxQhF6iec/iSUYQAEY2ZFPo3C
        dKC2190TxQd2B6gYMeb5cAtE0fW272U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-uu9Qu8LaNlyZedILrsx2Gw-1; Sun, 10 Jul 2022 22:29:19 -0400
X-MC-Unique: uu9Qu8LaNlyZedILrsx2Gw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-31c8c7138ebso34795697b3.17
        for <linux-block@vger.kernel.org>; Sun, 10 Jul 2022 19:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz1GK9BX/gFWrmQP642bPgzY3Nvglr3NVgRq93Im89w=;
        b=E6phfOVr06IigSGqeOZMdw6jrOo7iWeAM1sUImJEOrCVewjjpr6JrXaaOpCl5HqM41
         1UFWwhrmCdfy4CG80hn+YNM2HKHBO142CnkyRz5oQcQO4w24q2ygts/Xf6YirXiq9zXU
         st3t594x0oDsRcjjNvHxeQcDfHB+r0ghCBbnT2iEdOVQke079NU29kGOkLQoiRjS+Lwc
         89P8F+SBBx5LUeXG6uT1N0gMKeZWXsh3MYvl+9Vq9OejmvxRx6oIVHzBNKmDiIKWI2OD
         D3Ix3GStI1iYc5s9OCxiwLWyrmzS0U5qAb9kZ8UkQ0XKrPAlBa2fDxSUkOqTLrxTrDx/
         8j/g==
X-Gm-Message-State: AJIora/QNCc3eNRihuFLrXpm9WCDn4uedYM25ovkZxGrv2yfa37uNw9P
        bK4CfmE6cwD58+vFMp6pIO8RGHAYw0YfjTvgYsKuhcRURJZNJzZ8O604oUSX09JWJS4L1uFTGT9
        Oj78ptUeEPlBWMbMZky5lshn37Pce5FCWFK4g7VI=
X-Received: by 2002:a25:3a81:0:b0:66a:645f:fe99 with SMTP id h123-20020a253a81000000b0066a645ffe99mr14836579yba.489.1657506558827;
        Sun, 10 Jul 2022 19:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqb00OL/S1ZQjGqe7y+O8w1oRX078Ot3LxIDI/LAz0Qo3pnFgAsc+9LkWNbW0R7S/zmsYzgDDbhqhxqw1uYNM=
X-Received: by 2002:a25:3a81:0:b0:66a:645f:fe99 with SMTP id
 h123-20020a253a81000000b0066a645ffe99mr14836571yba.489.1657506558645; Sun, 10
 Jul 2022 19:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220706125942.528533-1-ming.lei@redhat.com>
In-Reply-To: <20220706125942.528533-1-ming.lei@redhat.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Mon, 11 Jul 2022 10:29:07 +0800
Message-ID: <CAFj5m9JEtVY4WBwYPPmaJHXamozUXLZ2Pzk_2+ZNN7o6x7CYFQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid: clear READ queue map's nr_queues
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        sumit.saxena@broadcom.com, chandrakanth.patil@broadcom.com,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Guangwu Zhang <guazhang@redhat.com>,
        Ming Lei <minlei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

On Wed, Jul 6, 2022 at 8:59 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> megaraid scsi driver sets set->nr_maps as 3 if poll_queues is > 0, and
> blk-mq actually initializes each map's nr_queues as nr_hw_queues, so
> megaraid driver has to clear READ queue map's nr_queues, otherwise queue
> map becomes broken if poll_queues is set as non-zero.
>
> Fixes: 9e4bec5b2a23 ("scsi: megaraid_sas: mq_poll support")

Ping...

Without this fix, it is easy to observe fio hang when running cpu hotplug
test in case of 'poll_queues > 0'.

Thanks,
Ming

