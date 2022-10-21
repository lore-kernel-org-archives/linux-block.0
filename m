Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D82CC4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 00:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJUAjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUAjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 20:39:32 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E3513DE8
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 17:39:29 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so1345148pjl.0
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 17:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/6Bhj/yQ2MZH/RG7O4IkDiuaWrfnrM6CXvFReO2eOo=;
        b=nnOo7+uBr+iVY5RT0toRrDKW/I/OUDn/dVUwL/8dGk4x6CODn1DmROc49KZUfASCKm
         25fM1uLPrlHNb98/VPI2wmMDCsBRg87f0rQO1Cm1ud3bRwriNZCywexnMI084+7/kpj5
         eG+1Gl4nWF4Wx5UbBbPflK6OAo2b9/CZbdN//1rBUuCrJjx2ll6ffLYrM55v+jOMBuvz
         PfOBtyW1MlBlg0JoUTTJEBEMQKjazp7B/8KAGZjUT04oVPJeaGZOjQTwZYE6aBUDt1uz
         SMUBvJbBDytI4m9AzCYYdHb5UUJ0D9J+6VpqoQz+pyJkCCjl7XsnFXIdLcNBmCZzz8sT
         6iFw==
X-Gm-Message-State: ACrzQf1rR0mVIkyPnTEw7Qvh6OjMhSEuZBjR6Kbcs5gVPhltXsGESPiR
        CHHLUfFSpvtKzahfmXSMgxs=
X-Google-Smtp-Source: AMsMyM7DH81w9afHBTvVb2PBOeSG/tSbixZc7JLgT6r8bLPPIr8sFxRQgXb7KO86L7wiB8qlGHw5pA==
X-Received: by 2002:a17:902:d48f:b0:180:c712:c664 with SMTP id c15-20020a170902d48f00b00180c712c664mr16763308plg.132.1666312769241;
        Thu, 20 Oct 2022 17:39:29 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z189-20020a6365c6000000b00429c5270710sm12080361pgb.1.2022.10.20.17.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 17:39:28 -0700 (PDT)
Message-ID: <74c6e9ae-513c-2fc9-ed85-24d75b8354e7@acm.org>
Date:   Thu, 20 Oct 2022 17:39:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 10/10] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai3@huawei.com>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-11-bvanassche@acm.org>
 <6a72dd3a-2b84-9345-9782-1ef2fe9caa07@opensource.wdc.com>
 <5856bd90-9a7f-09c1-3749-2c98c42bfcde@acm.org>
 <9dcee00a-90f6-c814-0e4e-51adc025b49f@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9dcee00a-90f6-c814-0e4e-51adc025b49f@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 16:39, Damien Le Moal wrote:
> Please always send full patch series. Hard to review a patch without the
> context for it :)

Hi Damien,

Does this link help? 
https://lore.kernel.org/linux-block/20221019222324.362705-1-bvanassche@acm.org/

Thanks,

Bart.
