Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24ADC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 02:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706A564F6A
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 02:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBCCig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:38:36 -0500
Received: from mail.wangsu.com ([123.103.51.227]:57804 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231862AbhBCCif (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 21:38:35 -0500
Received: from [10.8.148.37] (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewA3uew7DBpgKJEEAA--.1274S2;
        Wed, 03 Feb 2021 10:36:44 +0800 (CST)
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     paolo.valente@linaro.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210129111808.45796-1-linf@wangsu.com>
 <20210202122836.GC17147@quack2.suse.cz>
 <f92a55b4-0743-a700-8296-e739f4fcf093@kernel.dk>
From:   Lin Feng <linf@wangsu.com>
Message-ID: <9747bada-05f8-b08a-ced6-f14874b89024@wangsu.com>
Date:   Wed, 3 Feb 2021 10:36:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <f92a55b4-0743-a700-8296-e739f4fcf093@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 4zNnewA3uew7DBpgKJEEAA--.1274S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW8Zw4fJw47uryDCry7trb_yoW8WF45pa
        yxt3WfKr48tw1jkr1DZ3yDXFZ5Xa9Yy3y3XFyrXw15urZ8XFna9r1S9FZ09FnxCrWxAFWj
        vFWFqrySv3yUXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8GwAv
        7VCY1x0262k0Y48FwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxAIw28I
        cVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUe0fO7UUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

On 2/2/21 22:20, Jens Axboe wrote:
> On 2/2/21 5:28 AM, Jan Kara wrote:
>> Hello!
>>
>> On Fri 29-01-21 19:18:08, Lin Feng wrote:
>>> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
>>>
>>> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap core
>>> sbitmap_get_shallow, which uses just the number to limit the scan depth of
>>> each bitmap word, formula:
>>> scan_percentage_for_each_word = shallow_depth / (1 << sbimap->shift) * 100%
>>
>> Looking at sbitmap_get_shallow() again more carefully, I agree that I
>> misunderstood how shallow_depth argument gets used and the original code
>> was correct and I broke it. Thanks for spotting this!
>>
>> What I didn't notice is that shallow_depth indeed gets used for each bitmap
>> word separately and not for bitmap as a whole. I'd say this could use some
>> more documentation but that's unrelated to your revert. So feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I don't have the original patch (neither directly nor in the archive), so
> I had to hand-apply it. In any case, applied for 5.11, thanks.
> 

Take a look at linux-block.git tree, the hand-applied commit for this patch
is broken, the following changing line is left out:
-	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
+	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);

Sorry for making troubles to you, I will resend this patch with tiny commit
log typo fix(sbimap -> sbitmap) and attaching Jan's Reviewed-by, also thanks
his time for reviewing.

Hope this time lkml server will not block my patch.

Thanks,
linfeng

