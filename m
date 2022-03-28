Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3FEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 02:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiC1CWi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 22:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiC1CWh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 22:22:37 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CB4F440
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 19:20:58 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id t2so11285928pfj.10
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 19:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sjzETM1undze0DHFGkhA+dRjIpx+s+rd3uhWaCxxYwk=;
        b=enrpn49BXL1ZRMJVIkh0hj3F9HCc1NZIZDwUmbc4skxMXK0cljts2RP9BWq1EfgS9h
         GBEIDdSyFLg4IqP5OHPK2KQhaLf4Izar7DYx6Fv6oCH/86SNSAjcDRchk1Ea4HCxQvow
         Hko67WzmY//j5mLDWgbV4TaYz+N8R8oHIyjhEW9BAgQ++ZFaKKVuoONvNNsXey+undTh
         /fVNwMRIY/8rnsoeTbgwb5ZJcwiB+16xtxOiecQllUIWU5o0yU83cH1Ph5H3u2Y1Vt15
         mkURvzuFxYtnXygEnQouCL4qVmrq7t1Cs+oM6AZ1i9QBz4qgSuCqZQ6Rcm5HwusqdjZL
         HeIA==
X-Gm-Message-State: AOAM533k2UWZV2YoJWrM9qMGgcBGH7LcvaCU4pb6ivKPwyVBYiv3ejqY
        EYA25GCNIhsrKP9S+jgSqe8=
X-Google-Smtp-Source: ABdhPJyecxdteBvDdNsLxHAnmBVc0bhu8mN69fqm5+Rg1G0StbxJL1RcaVK49e4rW1qrrQJRqbJ8EA==
X-Received: by 2002:a05:6a00:2289:b0:4fb:1686:acd with SMTP id f9-20020a056a00228900b004fb16860acdmr13670922pfe.17.1648434057358;
        Sun, 27 Mar 2022 19:20:57 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k15-20020a63ab4f000000b00381eef69bfbsm11239676pgp.3.2022.03.27.19.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 19:20:56 -0700 (PDT)
Message-ID: <844fdda0-37d2-4335-d755-1348482201a9@acm.org>
Date:   Sun, 27 Mar 2022 19:20:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
 <Yj22kLrsw+z7sj7R@pengutronix.de>
 <180dc22b-4fee-93c2-9813-1b4f109b5dc7@acm.org>
 <20220326085755.GB27264@pengutronix.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220326085755.GB27264@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/22 01:57, Oleksij Rempel wrote:
> On Fri, Mar 25, 2022 at 10:05:43AM -0700, Bart Van Assche wrote:
>> On 3/25/22 05:33, Oleksij Rempel wrote:
>>> I have regression on iMX6 + USB storage device with this patch.
>>> After plugging USB Flash driver (in my case USB3 Intenso 32GB) and
>>> running mount /dev/sda1 /mnt, the command will never exit.
>>>
>>> Reverting this patchs (322cff70d46) on top of v5.17 solves it for me.
>>>
>>> How can I help you to debug this issue?
>>
>> That is unexpected. Is there perhaps something special about the USB
>> stick for which the hang occurs, e.g. the queue depth it supports is
>> low? Can you please share the output of the following commands after
>> having inserted the USB stick that triggers the hang?
>>
>> (cd /sys/class && grep -aH . scsi_host/*/can_queue scsi_device/*/device/{blacklist,inquiry,model,queue*,vendor}) | sort
> 
> Here it is:
> root@test:/sys/class cat scsi_host/*/can_queue
> 1
> root@test:/sys/class cat scsi_device/*/device/blacklist
> root@test:/sys/class cat scsi_device/*/device/inquiry
> Intenso Speed Line      1.00
> root@test:/sys/class cat scsi_device/*/device/model
> Speed Line
> root@test:/sys/class cat scsi_device/*/device/queue*
> 1
> none
> root@test:/sys/class cat scsi_device/*/device/vendor
> Intenso
> 
> I do not know, if there is something special about it. If needed, i can
> take it apart to see what controller is used.

Thanks, this helps a lot. can_queue = 1 as I was suspecting. In a quick
test I noticed that I/O is about 10x slower for queue depth 1 and the
v5.17 mq-deadline scheduler. I will take a closer look at this tomorrow.

Bart.
