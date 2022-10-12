Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C03AC433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 02:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJLCGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 22:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLCGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 22:06:02 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE84F664
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 19:06:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MnGCg31dmz6R5GT
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 10:03:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXl8kFIUZjSsqJAA--.41237S3;
        Wed, 12 Oct 2022 10:05:58 +0800 (CST)
Subject: Re: again? - Write I/O queue hangup at random on recent Linus'
 kernels
To:     Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Cc:     Igor Raits <igor.raits@gooddata.com>,
        Daniel Secik <daniel.secik@gooddata.com>,
        David Krupicka <david.krupicka@gooddata.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
 <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
 <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
 <acac67a6-3331-75dd-840a-40b509ada0c1@acm.org>
 <CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <72f58c85-904b-9e21-c2f5-0d585386ec4f@huaweicloud.com>
Date:   Wed, 12 Oct 2022 10:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXl8kFIUZjSsqJAA--.41237S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47Jr4ktryrWFy8CryrXrb_yoW8CF4fpa
        yxtFWSkF4kW3W0v3W29a48Ca9YqanrGF98Zr1DGry09as8CF12yFyxtFs09F9xtr1UC342
        qrWDAw109a1j9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2022/10/11 23:15, Jaroslav Pulchart 写道:
> Hello,
> 
> we disabled the wbt, issue is happening much sooner. The logs are attached
> 1/ "dmesg-20221011.log" form kernel messages
> 2/ "command.logs" from execution of
>      (cd /sys/kernel/debug/block/vdc && find . -type f -exec grep -aH . {} \;)
> 
In the log, I found that many requests are stuck in the driver, for
example:

./hctx24/busy:00000000e790f153 {.op=WRITE, .cmd_flags=SYNC|NOMERGE, 
.rq_flags=IO_STAT|STATS, .state=in_flight, .tag=234, .internal_tag=-1}

state=in_flight means the rq is issued to driver, and in_flight is set
in blk_mq_start_request().

Can you have a check when the problem triggered, the log in 'hctx*/busy'
stays the same so that we can be sure io is stuck in driver?

Thanks,
Kuai
> Best regards,
> Jaroslav Pulchart
> 
> čt 6. 10. 2022 v 18:57 odesílatel Bart Van Assche <bvanassche@acm.org> napsal:
>>
>> On 10/6/22 05:36, Jaroslav Pulchart wrote:
>>> I apply the
>>> echo 0 > /sys/block/vdc/queue/wbt_lat_usec
>>> at the production servers. I expect it will disable wbt. Could you
>>> please confirm that my expectation is correct?
>>
>> Hi Jaroslav,
>>
>> I have no experience with WBT. But what I found in the documentation seems
>> to confirm that the above command is sufficient to disable WBT:
>>
>>    What:         /sys/block/<disk>/queue/wbt_lat_usec
>> Date:           November 2016
>> Contact:        linux-block@vger.kernel.org
>> Description:
>>                  [RW] If the device is registered for writeback throttling, then
>>                  this file shows the target minimum read latency. If this latency
>>                  is exceeded in a given window of time (see wb_window_usec), then
>>                  the writeback throttling will start scaling back writes. Writing
>>                  a value of '0' to this file disables the feature. Writing a
>>                  value of '-1' to this file resets the value to the default
>>                  setting.
>>
>>
>> Best regards,
>>
>> Bart.

