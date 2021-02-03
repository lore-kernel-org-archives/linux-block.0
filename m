Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D5C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709BB64F61
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBCD4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:56:12 -0500
Received: from mail.wangsu.com ([123.103.51.227]:45240 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231320AbhBCD4M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 22:56:12 -0500
Received: from [10.8.148.37] (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewBX2eyQHhpgMqwEAA--.1333S2;
        Wed, 03 Feb 2021 11:54:56 +0800 (CST)
Subject: Re: [PATCH] Fix Revert "bfq: Fix computation of shallow depth" in
 linux-block.git
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20210203033113.100260-1-linf@wangsu.com>
 <b992f657-11ec-ddc0-9461-30abd46522f3@kernel.dk>
From:   Lin Feng <linf@wangsu.com>
Message-ID: <37eac3ba-fa28-f0e0-ac83-5ac11bf29e6e@wangsu.com>
Date:   Wed, 3 Feb 2021 11:54:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b992f657-11ec-ddc0-9461-30abd46522f3@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 4zNnewBX2eyQHhpgMqwEAA--.1333S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw43GryxtF1xGr45Wr1fXrb_yoWxKrg_WF
        40krWUGw1rJr4a9anrGrWa9F9Iq3yUXw47tr1rt343Zry3Ja98Jw4xKw1kAwnxJ3ySyF1D
        AFsYvr4ktw1YvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8GwAv
        7VCY1x0262k0Y48FwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxAIw28I
        cVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07U6rWrUUUUU=
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/3/21 11:37, Jens Axboe wrote:
> On 2/2/21 8:31 PM, Lin Feng wrote:
>> Hi Jens,
>>
>> Not yet got your mail, but per https://lkml.org/lkml/2021/2/2/1901, this patch
>>   is the incremental. Codes based on:
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/patch/?id=8a483b42b1b3cef7e72564cdcdde62a373bd2f01
>>
>> Notes: After checking previous hand-applied patch in block-5.11 broken 2 lines
>> in original patch, the incremental covers all.
> 
> Thanks, folded in. Please check the resulting patch:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.11&id=388c705b95f23f317fa43e6abf9ff07b583b721a
> 

Yes, it's correct :)

Thanks,
linfeng

