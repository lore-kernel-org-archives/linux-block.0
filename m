Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F32C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 21:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjAaVug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAaVuf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 16:50:35 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2045FCE
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 13:50:34 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d3so16467393plr.10
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 13:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKD1L0WCvHn1Wu1fu9GE06Ee8ifVmPB55bUaTrUQqkc=;
        b=dvm9d+tebqNxkgdZyJDCQzwi14TLfVwQEGpFfyT90na9BV7u5sJSk9tApwLIg61Hq2
         7b7DtXHmmMN/TVM5Jd/Taewr7X35bTaaHzgx48K33MmTtgCy8RH2QX+5+OqWkKsIqP1z
         RcBAw3kfFiccWXsRSM+IuGmo3J8ffV2iC5mauykSzguASRcxXr15/5eres2S/CFO1NVi
         f1TD89hcvfDIiHhtwVg+k6kLxZHozmgOb71zbdiZWNNbeUrcpQmZPK2ow+ghUU+VvKxL
         OXiANy9rXIJRAr5l+yBfVYzc+A+gIy5BuYDyRnNbvys8U0+tJmR3FH81n6VflN1tTC9J
         2Oew==
X-Gm-Message-State: AO0yUKUzWbrle3/sMg94KStaG6DTB0exZX7hm1Q5d8D6ZlUHApCqqOHt
        4D4pUKHyU3a5a1j3rMGBzrK7r746LSo=
X-Google-Smtp-Source: AK7set8rfcN3OeTt5jD1Hcf9Ylk+lnbtRxISojlGHaox8owIwmUGM7/OquJXk3WUutPG3TjHKOXAeA==
X-Received: by 2002:a17:902:c40d:b0:196:82a0:4177 with SMTP id k13-20020a170902c40d00b0019682a04177mr507239plk.39.1675201834207;
        Tue, 31 Jan 2023 13:50:34 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7e97:ee02:2248:2471? ([2620:15c:211:201:7e97:ee02:2248:2471])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b001932a9e4f2csm5821911plt.255.2023.01.31.13.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 13:50:33 -0800 (PST)
Message-ID: <5f5db20c-e66c-5295-0bbe-d71ad730dce2@acm.org>
Date:   Tue, 31 Jan 2023 13:50:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
 <8bd89413-bdef-7fe0-9e19-4419e9280f4e@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8bd89413-bdef-7fe0-9e19-4419e9280f4e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 13:43, Chaitanya Kulkarni wrote:
> On 1/27/23 16:59, Bart Van Assche wrote:
>> Add support for configuring the maximum segment size.
>>
>> Add support for segments smaller than the page size.
>>
>> This patch enables testing segments smaller than the page size with a
>> driver that does not call blk_rq_map_sg().
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Chaitanya Kulkarni <kch@nvidia.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Bart, if you can send a blktest for this it will be great.

Hi Chaitanya,

This patch has been resent as patch 7/7 of the following series: "[PATCH 
v4 0/7] Add support for limits below the page size" 
(https://lore.kernel.org/linux-block/20230130212656.876311-1-bvanassche@acm.org/T/#t).

blktests for that patch series are available here: 
https://github.com/bvanassche/blktests/commits/master. Do you prefer 
that I send a pull request for these blktests now or do you perhaps 
prefer that I wait until the kernel patch series has been merged?

Thanks,

Bart.
