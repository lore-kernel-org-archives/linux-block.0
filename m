Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A83BECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 14:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiITOR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiITORF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 10:17:05 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF219C1F
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:14:40 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h194so2351523iof.4
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/yot0ov3usmKB3Zy+wkJUKPk22BQTuylnVUMZmxsCR4=;
        b=lIXZTwlaHIbQQ9hNPvRV7HuGvm5RDJYX8qcUeX22OX83N0tkw9Xt13KdlC/anWINwm
         GSdQCjuqFlnjXmK6d3quFgRZ7vkpgfhPiFdng2KG0u9ylgvfBvqMepItjYQ2ivjERQGp
         8lbIhTvYiKoy9hpyPK3TjnPUEnO2JyjF2hhVOdKkuSRa0+4ZtVIZ0cplD7cmpKuDl69T
         uqT78PPAKOllkkBpBIUzKAmALjQnSnksHUYVyAn5ydOljMtwsZEGwWrugEhmfOR/ZRxs
         gaLDLph39qi7lQQj9HHR0xjlCHEUwJZ+rHe2pgOisLfuPgHb7r7OhEJ2DUDpVDTh2sgy
         kqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/yot0ov3usmKB3Zy+wkJUKPk22BQTuylnVUMZmxsCR4=;
        b=0h2jc647z5xyOII2RKzn07ySmYrppWwdQZ4fmUuk+P4JJGrmgP3G6pDPJbUSUTZFf/
         TzHqdyOGtSpg516bMlH3z2acRRF9pi5yEeNll1kkreE+EpQjT0rBxlPtI7OSQe1IrBM/
         E/je42wJy7y7FD30+2kM2znF3uGhbK2opjUVpPCWBWBuj4YIeCftUQxX++uHWhc6GP4J
         /o7iz+oe+RV+CYBikl5qxXTWuqRgs4RicwS+Z8d0dEBuIgoQ4oYzBDiwMrefPqjCdpdA
         vYno9rAzjY0gej5sVDBDnN5zQU7zpSBKSu1mAs31HFULT0EDfcgHEQ1VA0rwyRNlWHO4
         XieA==
X-Gm-Message-State: ACrzQf2n4cq55Zv8ee/BjaCb6UEo6Iurdm9kVDeGqk6O1t4anqMgTyBk
        oieHKTCh8t4XXyItqho2DcWaVQ==
X-Google-Smtp-Source: AMsMyM4Fm0kTiShfxuAAb97HY9gCdOOBLEjpM6ZrfDeefAteWrULruA4zXYQ/fIChp4JLiLJB3BlqQ==
X-Received: by 2002:a5d:9902:0:b0:6a2:f72d:4b21 with SMTP id x2-20020a5d9902000000b006a2f72d4b21mr5956574iol.113.1663683273188;
        Tue, 20 Sep 2022 07:14:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w16-20020a056e0213f000b002f5cd533b31sm125125ilj.0.2022.09.20.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:14:32 -0700 (PDT)
Message-ID: <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
Date:   Tue, 20 Sep 2022 08:14:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Dusty Mabe <dusty@dustymabe.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220920141217.GA12560@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/22 8:12 AM, Christoph Hellwig wrote:
> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
>> Christoph and I discussed this one last week, and he has a plan to try
>> a flag approach. Christoph, did you get a chance to bang that out? Would
>> be nice to get this one wrapped up.
> 
> I gave up on that as it will be far too much change so late in
> the cycle and sent you the revert yesterday.

Gotcha, haven't made it all the way through the emails of the morning yet.
I'll queue it up.

-- 
Jens Axboe


