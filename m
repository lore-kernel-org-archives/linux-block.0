Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24777C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 16:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiF1Qee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiF1Qds (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 12:33:48 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015A1D32C
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:30:12 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id a15so12450654pfv.13
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ynywLuw90zzbGdhd9IUrdjwm5DzAuPKieCJqzeedLTQ=;
        b=lN20+2O6LEhn5YiZw8wqnhQo+M9TJ2cDQmd0dC8DDc4Zcp0JyTuEqNqOQsruV+Qq5R
         uoQkbZgHmNLPkZ/lmw1y0+McJggZa5qk0bAzkQNboKb9Z9CPQxpecO/YROWMtRsG62Cf
         NwTef528j3BeutUvNo9atWLDeKqKcMQQUWv+wXb29oYbqR2KyZHkxHSEQ0W082Div72q
         AySUvCB5CO8Ex1gz5AI3OPP6Dpc9lSGGnKcIYWpf7LngwRtbv9D6PrcHYJ+zd7Iy1tt1
         /VIxzbn7i8nJ+rIljvhnXGbYqoTSGK/gCii+SrEV6euNILi9g0OjgSzF5Yw9N2x9bCGP
         jWhw==
X-Gm-Message-State: AJIora9XEpUyl2DgamK0QloUZ+A3sFE88D1uhaLpXZlC1zqf1//2UQb4
        t/nJSBmer3BS+o8Vak6dFoU=
X-Google-Smtp-Source: AGRyM1upP6jt9GZmJwIiUbEWHgktkI943AcAPFdcZY2qjAcr1nYTqU3NTJVklj0P0IEWdOdVE6OBjQ==
X-Received: by 2002:a05:6a00:2395:b0:525:8980:5dc7 with SMTP id f21-20020a056a00239500b0052589805dc7mr5678230pfc.8.1656433811363;
        Tue, 28 Jun 2022 09:30:11 -0700 (PDT)
Received: from [100.125.51.173] ([104.129.198.222])
        by smtp.gmail.com with ESMTPSA id ha24-20020a17090af3d800b001eee31fe496sm24528pjb.29.2022.06.28.09.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 09:30:10 -0700 (PDT)
Message-ID: <858f5f5c-720a-d054-a409-b41c3cfb9717@acm.org>
Date:   Tue, 28 Jun 2022 09:30:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-9-bvanassche@acm.org> <20220628044939.GA22504@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220628044939.GA22504@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 21:49, Christoph Hellwig wrote:
> On Mon, Jun 27, 2022 at 04:43:35PM -0700, Bart Van Assche wrote:
>> Enabling pipelining for zoned writes. Increase the number of retries
>> for zoned writes to the maximum number of outstanding commands per hardware
>> queue.
> 
> How is this supposed to work?  NVMe controllers are completely free
> to reorder.  It also doesn't make sense as all zoned writes in Linux
> either use zone append or block layer based zone locking.

Agreed that the NVMe specification allows to reorder outstanding 
commands. Are there any NVMe controllers that do this if multiple zoned 
write commands are outstanding for a single zone? I do not expect that 
an NVMe controller would reorder write commands in such a way that an 
I/O error is introduced.

Regarding zoned writes in Linux, Android devices use F2FS. F2FS submits 
regular writes (REQ_OP_WRITE) to zoned devices. Patch 4/8 from this 
patch series disables zone locking in the mq-deadline scheduler if the 
block driver has set the QUEUE_FLAG_PIPELINE_ZONED_WRITES flag.

Thanks,

Bart.
