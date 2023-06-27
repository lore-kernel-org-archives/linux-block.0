Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B1EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 09:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF0JDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF0JDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 05:03:34 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EFEF7
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 02:03:33 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5702116762fso45776977b3.3
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687856613; x=1690448613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JRXqOPDxr4QzRMMDLYJq0XKW1q8XBXCSaZThNRBCew=;
        b=mE5jFny6UV9jwzFH2kdgzn+kA8tg+0ObEk8GMgbgX1aKuaf4uvcd01zZP4G5n4RNjd
         90gmFzEXmdZIdrY1w7ItMQhnFcs9a3F3EP/n5doFq6BQhj9N6ZI+z9X1K7p2GUO4EGQE
         H+I1VY672DsAwq+FNkhA0xy/1Lhu5oD3DR9vfJM6UGS02MNyPHb9k6GyDUB4OYaRF1+D
         EPbVjgxcPLYSpk2pmujrC20GQYV0QonH8+ZxquJ0bhcekXGOFzwlpM4dqL1hIXuI89Kk
         h1GMIHsQoPzbxh/3Jlaj8QMjHGSaIedtggBGcoume+3Zj0vc/yJuZn57lGOEUVSY4ZOx
         fYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687856613; x=1690448613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JRXqOPDxr4QzRMMDLYJq0XKW1q8XBXCSaZThNRBCew=;
        b=MJxhl5Bb9hKnRMn+MQ0LxurCRHuWlwkD8emLPtibhE5ub4ryF+9PHCLE2WOvVtgibW
         /BBNFA1dljcsRkA/kSl4PozCbZYXUm/eu6ISh4HCQFb+ILpdM7PgFoc8Z7FAFlfr6rRk
         3p5LuBMKfAJN6OCPy+pd6ozkz+okpVKAXuf18w7b3L+vXwm/SBwc8HVEHVRv6YojST3I
         k+9k3pb+xaU+Bgqr4SBc9d3QAjDhY5jc/EuOVSoNEI3MQc/YaHI0ok610jDc154FE1u5
         V9fyN0AGNi0mToXWkRieKgRgAIYbBmF3EYQ6XBKj06zjqaQRZi+mw+/2NOA1gtLGYNHs
         m5tg==
X-Gm-Message-State: AC+VfDwKpKpHWJKVnK0SFsQ4M10u99ymhZtKhSYX3djEyVrsk/RU2/Q2
        jx4QPrKZA89/Lxt/1zhosH2HLU99rgK3DbC4TUI=
X-Google-Smtp-Source: ACHHUZ52xbjPsIYXfu8+enac29eP8hqzEgDNDTsDHFkBPFfW/h07pg0eSEKwcFbhJDVFhgRyKvuTHSazwi3qPVgHwCI=
X-Received: by 2002:a25:b325:0:b0:bfe:ade3:e59c with SMTP id
 l37-20020a25b325000000b00bfeade3e59cmr17387287ybj.64.1687856612790; Tue, 27
 Jun 2023 02:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZJL3+E5P+Yw5jDKy@infradead.org> <20230625022633.2753877-1-houtao@huaweicloud.com>
In-Reply-To: <20230625022633.2753877-1-houtao@huaweicloud.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 27 Jun 2023 11:03:21 +0200
Message-ID: <CAM9Jb+hrspvxXi87buwkUmhHczaC6qian36OxcMkXx=6pseOrQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> From: Hou Tao <houtao1@huawei.com>
>
> When doing mkfs.xfs on a pmem device, the following warning was
> reported and :
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 384 at block/blk-core.c:751 submit_bio_noacct
>  Modules linked in:
>  CPU: 2 PID: 384 Comm: mkfs.xfs Not tainted 6.4.0-rc7+ #154
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  RIP: 0010:submit_bio_noacct+0x340/0x520
>  ......
>  Call Trace:
>   <TASK>
>   ? asm_exc_invalid_op+0x1b/0x20
>   ? submit_bio_noacct+0x340/0x520
>   ? submit_bio_noacct+0xd5/0x520
>   submit_bio+0x37/0x60
>   async_pmem_flush+0x79/0xa0
>   nvdimm_flush+0x17/0x40
>   pmem_submit_bio+0x370/0x390
>   __submit_bio+0xbc/0x190
>   submit_bio_noacct_nocheck+0x14d/0x370
>   submit_bio_noacct+0x1ef/0x520
>   submit_bio+0x55/0x60
>   submit_bio_wait+0x5a/0xc0
>   blkdev_issue_flush+0x44/0x60
>
> The root cause is that submit_bio_noacct() needs bio_op() is either
> WRITE or ZONE_APPEND for flush bio and async_pmem_flush() doesn't assign
> REQ_OP_WRITE when allocating flush bio, so submit_bio_noacct just fail
> the flush bio.
>
> Simply fix it by adding the missing REQ_OP_WRITE for flush bio. And we
> could fix the flush order issue and do flush optimization later.
>
> Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

With 6.3+ stable Cc, Feel free to add:

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>

Thanks,
Pankaj
