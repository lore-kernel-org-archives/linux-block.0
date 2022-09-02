Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA1ECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 00:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiIBARf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiIBARe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 20:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9F73937
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662077852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=;
        b=d+JfhFC+L4OOkN5yOGaHQGmF+sruV0cOneiuAoz5z+3m8v4EOjlD2K37IGLxgKU+iIeI1J
        zdaT1c7l2CtXCX+gLv2Fq73DVM9Jy3Z8GqQvKAMtZgPk765TV/4YatByHhW5yrR1ox/zVI
        RVMHAaB1gBV1N8dhdSVcsJZwnEdh7E8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-zYlc-kzcPvCC5oEfbq-1Hw-1; Thu, 01 Sep 2022 20:17:31 -0400
X-MC-Unique: zYlc-kzcPvCC5oEfbq-1Hw-1
Received: by mail-qv1-f71.google.com with SMTP id oo7-20020a056214450700b00499144ac01dso289115qvb.13
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 17:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=;
        b=YMMSne2WYpVxTLhsD+eNdO8jzuaQvI1q8lMt+4OPTfP5BMMg37gTZ271uXYFmJXYts
         Ev7RgZA6wc9TfEouS751Wj5qLZnKvyq3RlUsUZ5t9nTFXQZsgPg5qzqOtetgcngzXI3F
         rtwGXc3xPvGUSeYhuwDt5h6BOp8Qt3Ip1XszunKJbSlo+udPyA2TeGzWqWq+uA/PS04F
         BJVtl+j75wRL3EJ8KDaOevurugRbc6KW5TilzXw/ny9hYIQe8UGarDoxZCaR1epfklBf
         9w4dz0p/Z962/YtN9Jx+YOsmp4Xp09W7bfopmw2jCCjbHI4A3ohyyEBfxfP/haFXhooN
         LyBg==
X-Gm-Message-State: ACgBeo1Zjd0gnNmRfyQNuwE0gg1vOT3Uohg2RCCjC14k/1aGfreEDL8u
        N29RDEmDBKIDwQnNRXyl4fZKYqeFMXaoJy55m2v78Kpp8rplBDqUq/oy/LA9wkQjMm9++MI7nMY
        OOYc6BkoE7SrCjorz1zimNQ==
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr21623971qkb.539.1662077850972;
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5l1Y1wPC9cb0WfGk58FA5BvETyt3RQ0Hl5DfpLwLcYUCBnnMhNzZcJHR6wWE4FxqLZfiIC3A==
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr21623953qkb.539.1662077850790;
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a290700b006b9593e2f68sm345562qkp.4.2022.09.01.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:17:29 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
        pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Message-ID: <YxFLmZ1KUwQ9LLDK@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea@eucas1p1.samsung.com>
 <20220823121859.163903-11-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-11-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

