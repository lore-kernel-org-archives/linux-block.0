Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B7FA373F
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 15:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiJYP6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiJYP6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 11:58:25 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27AF18D814
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 08:58:23 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id l14so14626828wrw.2
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 08:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fsX7yeTxe0eS/CHtm1mqvfMaztxd0YeRoUzAz0/1Fk=;
        b=1Rq159JY8+LBKxtpSFb/HwgMf9u062jv7ImtlsPMmP2KV1s1o9ERfdYcYSwHLl5AEZ
         I1g3MVm7/7JWz6XqWdBCZxvvGWRio5LxfStUnSfAJO0/eJj/YvwWcCubsYAFhYRnh8OI
         sODJ20LLPz9P967EC6jphdyFACBiutA0cJzkUgz/23YXXsSSC+TofPYpNEx2yW+tioP4
         Qqan8dUU6tgperyyr5AkbB4fH7TxGxCGwS4QGe/EpG5Z6+ncdoAoZ6wnGJ0Ggw+96Eq0
         Q3LkBunoEVyQbQEj9ASfCRIhPIQ9XRSMvbf3xFyREZRJLokieuJ4jLTfEaGur6oDVehO
         L4yA==
X-Gm-Message-State: ACrzQf2Hib2UaF85i0RU6z7fRp/hYf70aeBhZDQ+mQBQ2Eo+OjT0ce0r
        kY+CEiYTXjtMg83WpmsUxB0=
X-Google-Smtp-Source: AMsMyM7h/2f9UtfzUPGAIoF08HGRI2i6G6TS3dsNSYWjix/jEmKoUIPLwg1SsZBvhyWiUp1Fcvz20Q==
X-Received: by 2002:a05:6000:61c:b0:22e:5e08:43e7 with SMTP id bn28-20020a056000061c00b0022e5e0843e7mr26348915wrb.176.1666713502380;
        Tue, 25 Oct 2022 08:58:22 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id e12-20020adfdbcc000000b002258235bda3sm2981299wrj.61.2022.10.25.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:58:21 -0700 (PDT)
Message-ID: <f214dff7-9562-5f32-38b3-51bfc1216e98@grimberg.me>
Date:   Tue, 25 Oct 2022 18:58:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
 <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
 <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
 <20221025153017.GA24137@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025153017.GA24137@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> make up the multipath device. Only the low-level driver can do that right now,
>>> so perhaps either call into the driver to get all the block_device parts, or
>>> the gendisk needs to maintain a list of those parts itself.
>>
>> I definitely don't think we want to propagate the device relationship to
>> blk-mq. But a callback to the driver also seems very niche to nvme
>> multipath and is also kinda messy to combine calculations like
>> iops/bw/latency accurately which depends on the submission distribution
>> to the bottom devices which we would need to track now.
>>
>> I'm leaning towards just moving forward with this, take the relatively
>> small hit, and if people absolutely care about the extra latency, then
>> they can disable it altogether (upper and/or bottom devices).
> 
> So looking at the patches I'm really not a big fan of the extra
> accounting calls, and especially the start_time field in the
> nvme_request

Don't love it either.

> and even more so the special start/end calls in all
> the transport drivers.

The end is centralized and the start part has not sprinkled to
the drivers. I don't think its bad.

> the stats sysfs attributes already have the entirely separate
> blk-mq vs bio based code pathes.  So I think having a block_device
> operation that replaces part_stat_read_all which allows nvme to
> iterate over all pathes and collect the numbers would seem
> a lot nicer.  There might be some caveats like having to stash
> away the numbers for disappearing paths, though.

You think this is better? really? I don't agree with you, I think its
better to pay a small cost than doing this very specialized thing that
will only ever be used for nvme-mpath.
