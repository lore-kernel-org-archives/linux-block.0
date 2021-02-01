Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EDC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 07:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C804164E31
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 07:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhBAHef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:34:35 -0500
Received: from mail.wangsu.com ([123.103.51.227]:51174 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229736AbhBAHed (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Feb 2021 02:34:33 -0500
Received: from [10.8.148.37] (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewCXP++NrhdgcaYBAA--.753S2;
        Mon, 01 Feb 2021 15:32:29 +0800 (CST)
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
To:     axboe@kernel.dk, paolo.valente@linaro.org, jack@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210129111808.45796-1-linf@wangsu.com>
From:   Lin Feng <linf@wangsu.com>
Message-ID: <749df7e1-98b5-a575-506d-a7c7c4d96a6f@wangsu.com>
Date:   Mon, 1 Feb 2021 15:32:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210129111808.45796-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 4zNnewCXP++NrhdgcaYBAA--.753S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43uw1DJry8KFW8JFW7CFg_yoW5ArWUp3
        W3Kr13Kr4xtF429r1UAryxWryF9wn5JrySgF1aqw18CrW8XFn7XF95KFnYvFnrurs7AF40
        vry5Wr98W3ZYqFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8GwAv
        7VCY1x0262k0Y48FwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxAIw28I
        cVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUe3Ef5UUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, it seems that this patch was blocked by linux mailist servers, so ping again.

Based on https://patchwork.kernel.org/project/linux-block/patch/20201210094433.25491-1-jack@suse.cz/,
it looks like we have made a consensus about bfqd->word_depths[2][2]'s changing, so now the
computation codes for bfq's word_depths array are not necessary and one variable is enough.

But IMHO async depth limitation for slow drivers is essential, which is what we always did in cfq age.

On 1/29/21 19:18, Lin Feng wrote:
> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
> 
> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap core
> sbitmap_get_shallow, which uses just the number to limit the scan depth of
> each bitmap word, formula:
> scan_percentage_for_each_word = shallow_depth / (1 << sbimap->shift) * 100%
> 
> That means the comments's percentiles 50%, 75%, 18%, 37% of bfq are correct.
> But after commit patch 'bfq: Fix computation of shallow depth', we use
> sbitmap.depth instead, as a example in following case:
> 
> sbitmap.depth = 256, map_nr = 4, shift = 6; sbitmap_word.depth = 64.
> The resulsts of computed bfqd->word_depths[] are {128, 192, 48, 96}, and
> three of the numbers exceed core dirver's 'sbitmap_word.depth=64' limit
> nothing. Do we really don't want limit depth for such workloads, or we
> just want to bump up the percentiles to 100%?
> 
> Please correct me if I miss something, thanks.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>   block/bfq-iosched.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e4eb0fc1c16..9e81d1052091 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6332,13 +6332,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>   	 * limit 'something'.
>   	 */
>   	/* no more than 50% of tags for async I/O */
> -	bfqd->word_depths[0][0] = max(bt->sb.depth >> 1, 1U);
> +	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
>   	/*
>   	 * no more than 75% of tags for sync writes (25% extra tags
>   	 * w.r.t. async I/O, to prevent async I/O from starving sync
>   	 * writes)
>   	 */
> -	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
> +	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
>   
>   	/*
>   	 * In-word depths in case some bfq_queue is being weight-
> @@ -6348,9 +6348,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>   	 * shortage.
>   	 */
>   	/* no more than ~18% of tags for async I/O */
> -	bfqd->word_depths[1][0] = max((bt->sb.depth * 3) >> 4, 1U);
> +	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
>   	/* no more than ~37% of tags for sync writes (~20% extra tags) */
> -	bfqd->word_depths[1][1] = max((bt->sb.depth * 6) >> 4, 1U);
> +	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
>   
>   	for (i = 0; i < 2; i++)
>   		for (j = 0; j < 2; j++)
> 

