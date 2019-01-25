Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D136C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCED218D0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 14:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="wU2d/P+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfAYOfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:35:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33373 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYOfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 09:35:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so8584318ljd.0
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 06:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lneYey9flaIRGUm1fscHIEdxW0Gk/yJ5N0GhCS0FBOM=;
        b=wU2d/P+jENkTHSKy1Vmeaq3iX+Dt6oT1y9RnzNOJlQtEfcgPPVvkiCXbN4pzVBmf0C
         qmLOq5GFt2mdOUhkp64Fl9rP5BOZoRI4EFKQOK5m37vjyCGHTBAWkBbApP/JwrxoiaI7
         RES+XjKWJMRLaCIg/ddHxoUgRwlVvLT870QkkV9Wzu4PYeEJZedMg5+wo3S3viac8CYk
         ULlDmaCbPTXEgZWZtRKivg6Vmb+euE9ofQtkUiKQR1DuEOAvgWKx3YI9DC10l/zm90ja
         wnuU7OpiDmKzAgmqta9xOvqZ2mwlxOi04ncyfwOYc+n/5u8V/K+1YcPlEMfimX8INn5R
         Ym9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lneYey9flaIRGUm1fscHIEdxW0Gk/yJ5N0GhCS0FBOM=;
        b=FLcqYntJpKcAKiauDLL/Vpc+fwtz4loVoWXhXq+8ntJOXmhGTAXXXkvh45fA91wZTi
         +vDte1kvwhXsSIubK7KX8NE8PYNOtpHwWXZvhNVR5iyOf7LowL22lam91Ij+yj4G/ZFE
         KkrfNOTzqOa4vh1Hx+fIaeQ/utqD1v2zluo5bwSzjmbxuHlOhhFuJrlMMYhOFamVxM1z
         w/Z2VI9onrNlq33X6gDAhUcBMFauo+6poC2mBZzff7hR1qBglLKjTAjIINNFSyDS0J1/
         tQ+ypOoZNuwf0Eb0UoOBOMP7cHXZwvVN7YfRHXNxNp2YDrUzlE9glS6Q0cXC81mFxy+q
         /rBw==
X-Gm-Message-State: AJcUukfPq5meFA0yGhrzMcP+OFWtashv/OlVUsA67ipaSdg0Ie4m6Ysi
        VlG4+QNGpE15BMI3m3et7rtapg==
X-Google-Smtp-Source: ALg8bN7Ws6MnyeGgo+Dqj3uzlze5A9J1Z8FKtSy2sVqeMjgLvLxtEKbH7zYC7cEqYOQCEDqKnlseyA==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr9908098ljk.109.1548426918940;
        Fri, 25 Jan 2019 06:35:18 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id o25sm1485254lfd.29.2019.01.25.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 06:35:18 -0800 (PST)
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for
 pblk_line_wp_is_unbalanced
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        hongd@marvell.com
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
 <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com>
 <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
 <8C200D38-729F-407B-B2F8-48AEA7F0FF08@javigon.com>
 <CANr-nt1aS1DxfC42bX2DfVg3xo5Kkc_YJOe_CBK9k-NATh3ezQ@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <089cd48a-37f0-59e1-ac5f-78dd9cebba05@lightnvm.io>
Date:   Fri, 25 Jan 2019 15:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt1aS1DxfC42bX2DfVg3xo5Kkc_YJOe_CBK9k-NATh3ezQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/19 3:21 PM, Hans Holmberg wrote:
> On Fri, Jan 25, 2019 at 2:33 PM Javier González <javier@javigon.com> wrote:
>>
>>
>>> On 25 Jan 2019, at 13.59, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>>
>>> On Fri, Jan 25, 2019 at 10:41 AM Javier González <javier@javigon.com> wrote:
>>>>> On 25 Jan 2019, at 09.47, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>>>>
>>>>> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrote:
>>>>>> The write pointer of the bad block could be 0 or undefined, ignore
>>>>>> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
>>>>>> avoid fake warning.
>>>>>
>>>>> fake -> spurious?
>>>>>
>>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>>>>>> ---
>>>>>> v3: return in case bit >= lm->blk_per_line.
>>>>>> v2: changed according to Javier's comments.
>>>>>>
>>>>>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
>>>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>>>>>> index 6761d2a..02d466e 100644
>>>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>>>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
>>>>>>        struct nvm_chk_meta *chunk;
>>>>>>        struct ppa_addr ppa;
>>>>>>        u64 line_wp;
>>>>>> -       int pos, i;
>>>>>> +       int pos, i, bit;
>>>>>
>>>>> We don't need both bit and i, one of them is enough.
>>>>>
>>>>>> -       rlun = &pblk->luns[0];
>>>>>> +       bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
>>>>>> +       if (bit >= lm->blk_per_line)
>>>>>> +               return 0;
>>>>>
>>>>> If there is only one non-offline chunk in the line, the wp can't be unbalanced,
>>>>> so it should be safe to return 0 here if bit >= lm->blk_per_line - 1
>>>>>
>>>>> If you change this please document why using a comment, as it might
>>>>> not be obvious
>>>>>
>>>>>> +       rlun = &pblk->luns[bit];
>>>>>>        ppa = rlun->bppa;
>>>>>>        pos = pblk_ppa_to_pos(geo, ppa);
>>>>>>        chunk = &line->chks[pos];
>>>>>
>>>>>>        line_wp = chunk->wp;
>>>>>>
>>>>>> -       for (i = 1; i < lm->blk_per_line; i++) {
>>>>>> +       for (i = bit + 1; i < lm->blk_per_line; i++) {
>>>>>
>>>>>>                rlun = &pblk->luns[i];
>>>>>>                ppa = rlun->bppa;
>>>>>>                pos = pblk_ppa_to_pos(geo, ppa);
>>>>>>                chunk = &line->chks[pos];
>>>>>
>>>>> This code is a copy of the code above, it'd be nice to refactor it
>>>>> into a helper function or just do the chunk lookups in one place.
>>>>>
>>>>>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
>>>>>> +                       continue;
>>>>>> +
>>>>>
>>>>> Since we rely on the block bitmap anyway, we might as well just
>>>>> iterate over the zeroes in the block bitmap using find_next_zero_bit
>>>>> instead.
>>>>> We do this in lots of other places, see: git grep -n
>>>>> find_next_zero_bit -- drivers/lightnvm
>>>>
>>>> Hans, I proposed him to use the chunk->state instead. I think it is way
>>>> more robust. We introduced the block bitmap for OCSSD 1.2, because there
>>>> was no state. Now that we have state, it is better to use it instead. In
>>>> fact, we should remove the bock bitmap as we have to check for the state
>>>> either way - note that this aligns also very well with you patches
>>>> removing the other bitmaps.
>>>
>>> These are just nitpicks.
>>>
>>> Relying on two data structures(chunks, block bitmap) to be in sync in
>>> this function in stead of one does not make it more robust imho.
>>> Either or (checking chunks or the block bitmap) is fine by me.
>>> Searching the bitmap is more efficient, so that is what I proposed.
>>
>> chunk log page is the ground truth, so it is more robust.
>>
>> Also, pblk has a long way to start seeing bitmap search vs. integer
>> comparisons in profiling.
> 
> Hehe, yeah, but it does not hurt to use the better alternative when available.
> 
>>>
>>> If we want to remove the block bitmap, we can do that as a separate patch(set)
>>> I do agree, having two copies of the chunk state is something worth
>>> getting rid of :)
>>>
>>
>> A good start is not adding code using what we want to remove.
> 
> Well, I think it's very confusing to use both copies in the same function.
> 
> Now we're nitpicking nitpicks :)
> 

I look forward to a patch. Will one of you volunteer a patch?
