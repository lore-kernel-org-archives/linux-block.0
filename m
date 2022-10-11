Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB765C433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJKRMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJKRMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 13:12:00 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978AFAA353
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 10:11:58 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id c20so4228708plc.5
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 10:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGBOU35K+KpU1OIUsCpGC0zFYG1/rNmqHGx7R/WIKhk=;
        b=yPpWmuYL4vHiYNORVR2KKXH1Br1WAMz54BOKcKmmxoxGGHWB52mX5B0oyv+5Lanv4/
         EUAS76eZVgOFBH6Tto09yrudlEOLqtLXLLcez3HeBrQYH62o0GuegcsdMdWYdwB3i0Js
         U2Va9p/Rgu2NHdC2y6bNhHl6L/F2/YsjFIbaeJ5FWsvqhHcYwRtH67veysg2guTUOqJ7
         aiNeIloJU7rSgRuhYDmr19f+KGemF0tyRF8hd3D4N7igy58jIcYDiqGtXWemFyvZgHZF
         qmy+Otc/YBaAdDETAUyReE3qVBWHrJX9JYQ7St45Ctp8kAZnvIQff7BcQUZdf5HFnO3C
         tkuA==
X-Gm-Message-State: ACrzQf3flML2C0IxULqU+BcgL/DjlwaXErUJ9RgfU39glj5r4+6xaXrg
        2UtajHQuv2gQ+sIcYRZqP28=
X-Google-Smtp-Source: AMsMyM4/i4Tq2e5dnGcCHubgr/jwsL0SEP1TPXXvOOMmOx8E+n4Q8HGaUcGsXsVndIXVwiifbhgAew==
X-Received: by 2002:a17:90b:4a50:b0:203:1204:5bc4 with SMTP id lb16-20020a17090b4a5000b0020312045bc4mr118096pjb.79.1665508317940;
        Tue, 11 Oct 2022 10:11:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9f77:abf2:346f:9b6e? ([2620:15c:211:201:9f77:abf2:346f:9b6e])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00172e19c2fa9sm9031399plh.9.2022.10.11.10.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 10:11:57 -0700 (PDT)
Message-ID: <a9c60d24-7479-e32d-29a3-9f0dbcec767a@acm.org>
Date:   Tue, 11 Oct 2022 10:11:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
 <CAOSXXT7RVg8rNWP4cDwV6Ywtu1_DSZ=XhAyMkKrqS1uCi5UFKA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAOSXXT7RVg8rNWP4cDwV6Ywtu1_DSZ=XhAyMkKrqS1uCi5UFKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/22 06:31, Keith Busch wrote:
> On Fri, Oct 7, 2022 at 10:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 10/3/22 08:28, Keith Busch wrote:
>>> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
>>>>
>>>> BTW, I came up to another question during code read. I found nvme_reset_work()
>>>> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
>>>> controller is already disabled when the reset work calls nvme_sync_queues().
>>>
>>> Right, everything previously outstanding has been reclaimed, and the queues are
>>> quiesced at this point. There's nothing for timeout work to wait for, and the
>>> sync is just ensuring every timeout work has returned.
>>>
>>> It looks like a timeout is required in order to hit this reported deadlock, but
>>> the driver ensures there's nothing to timeout prior to syncing the queues. I
>>> don't think lockdep could reasonably know that, though.
>>
>> Hi Keith,
>>
>> Commit b2a0eb1a0ac7 ("nvme-pci: Remove watchdog timer") introduced the
>> nvme_dev_disable() and nvme_reset_ctrl() calls in the nvme_timeout()
>> function. Has it been considered to invoke these two calls asynchronously
>> instead of synchronously from the NVMe timeout handler (queue_work())?
>> Although it may require some work to make sure that this approach does not
>> trigger any race conditions, do you agree that this should be sufficient to
>> make lockdep happy?
> 
> We still have to sync whatever work does the reset, so that would just
> shift which work the lockdep splat indicates.

Hi Keith,

It seems like my email was not clear enough? What I meant is to queue
asynchronous work from inside the timeout handler and to wait for the
completion of that work from *outside* the timeout handler. This is not a
new approach. As an example, the SCSI core queues abort work from inside the
timeout handler and only allows new SCSI commands to be queued after error
handling has finished. I'm not claiming that this approach should be followed
by the NVMe driver - I'm only mentioning this as an example.

Thanks,

Bart.
