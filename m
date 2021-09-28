Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664D6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2B611C3
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 17:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbhI1Rgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:36:44 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:35393 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbhI1Rgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 13:36:44 -0400
Received: by mail-pg1-f178.google.com with SMTP id e7so21992176pgk.2
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 10:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ErmMaFtp4fwvgya9Fg2QmqHyqGiYMR3llJ+taMAcWo=;
        b=wMxWkJ9m3+9pm6D2iiQzCv68sHF5LkViPQMYV+822kUFB+czlSIuPDJwiYjM0Ivsrz
         tICNm5pb8bymR2Z+nIyO/W/M4cgQQR6AmmXBcl57BtEQy4rEHtFZQjGGeooWt7h2Kf5a
         Z2Nnex0/WjC0OVmo+8T7+K6xxaeaDLKyaKoiWPJnbXFoDLPOTetcezQijocAkPLJXekU
         ONrqWJN2b+P0ysEb018iG44sDOyWh/PV/JztQOSkM7aWNO9DGHisknx+oYlXUHjrOR9J
         4QakkRGSHKMFPBHQ37LTBwadlOQzFtJPYk/DfAyr1KejthQgAPpKH9mqcvK7MlPhgJhr
         HU+A==
X-Gm-Message-State: AOAM533IIQUMxkw5n1KpFBspieK0D9BbLyzDmTrQiDR/np9LqRU4Ov/u
        yZa8jFL//KAmc2b+/89J3ek=
X-Google-Smtp-Source: ABdhPJz/yqukUVN9Id2X2c73S+3+8N9S9e/8GVTyuk8RxLbHv/eRGaf3FHe/x6b8vPOVsqF68/wHcg==
X-Received: by 2002:a62:144f:0:b0:447:c2d8:f381 with SMTP id 76-20020a62144f000000b00447c2d8f381mr6596202pfu.83.1632850504503;
        Tue, 28 Sep 2021 10:35:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e98:6842:383d:b5b2])
        by smtp.gmail.com with ESMTPSA id w14sm22313818pge.40.2021.09.28.10.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 10:35:03 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] block/mq-deadline: Stop using per-CPU counters
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-4-bvanassche@acm.org>
 <cbe915e8-3e46-0a0e-5b80-156483dfef0e@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <40ecb6aa-3f32-bf09-f1b1-4fd308eb13e4@acm.org>
Date:   Tue, 28 Sep 2021 10:35:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cbe915e8-3e46-0a0e-5b80-156483dfef0e@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 10:51 PM, Hannes Reinecke wrote:
> On 9/28/21 12:03 AM, Bart Van Assche wrote:
>> +    dd->per_prio[prio].stats.merged++;
> 
> Why don't you convert the macro 'dd_count()' to work with the new structure?

Hi Hannes,

The dd_count() macro would look as follows if it would have been kept:

#define dd_count(dd, event_type, prio) (dd)->per_prio[(prio)].stats.event_type++

I prefer to open-code such a macro since I think that the open-coded version
is as easy to read as when the dd_count() macro would have been converted.

Thanks,

Bart.
