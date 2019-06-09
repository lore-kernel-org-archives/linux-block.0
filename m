Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63FC28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44762083D
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfFIIX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 04:23:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbfFIIXz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Jun 2019 04:23:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A056FAC0C;
        Sun,  9 Jun 2019 08:23:54 +0000 (UTC)
Subject: Re: [RFC PATCH] bcache: fix stack corruption by PRECEDING_KEY()
To:     Pierre JUHEN <pierre.juhen@orange.fr>,
        Rolf Fokkens <rolf@rolffokkens.nl>
Cc:     Nix <nix@esperi.org.uk>, linux-block@vger.kernel.org
References: <20190608102204.60126-1-colyli@suse.de>
 <8855017f-729e-9719-236d-e98710702564@rolffokkens.nl>
 <777da4cb-2d11-9bcc-b56f-e59265b8c76d@suse.de>
 <bf1ccdb8-2a32-e69b-f52e-0b4fa45fe18f@orange.fr>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <c8acd15e-41e5-8c39-2c71-db809f2e0cce@suse.de>
Date:   Sun, 9 Jun 2019 16:23:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bf1ccdb8-2a32-e69b-f52e-0b4fa45fe18f@orange.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/6/9 1:56 下午, Pierre JUHEN wrote:
> Le 09/06/2019 à 02:59, Coly Li a écrit :
>> On 2019/6/9 2:50 上午, Rolf Fokkens wrote:
>>> On 6/8/19 12:22 PM, Coly Li wrote:
>>>> +static inline void preceding_key(struct bkey *k, struct bkey
>>>> *preceding_key_p)
>>>> +{
>>>> +    if (KEY_INODE(k) || KEY_OFFSET(k)) {
>>>> +        *preceding_key_p = KEY(KEY_INODE(k), KEY_OFFSET(k), 0);
>>>> +        if (!preceding_key_p->low)
>>>> +            preceding_key_p->high--;
>>>> +        preceding_key_p->low--;
>>>> +    } else {
>>>> +        preceding_key_p = NULL;
>>> If I'm correct, the line above has no net effect, it just changes a
>>> local variable (parameter) with no effect elsewhere. So the else part
>>> may be left out, or do you mean this?
>>>
>>> *preceding_key_p = ZERO_KEY;
>>>
>> Hi Rolf and Pierre,
>>
>> Setting preceding_key_p to NULL is for the following
>> bch_btree_iter_init(). See the call chains
>>
>> bch_btree_insert_key()->bch_btree_iter_init()->
>> __bch_btree_iter_init()->bch_bset_search()
>>
>> preceding_key_p is parameter 'search' in bch_bset_search().
>> If it is NULL, t->data->start returns directly; if it is not NULL,
>> __bch_bset_search() is called.
>>
>> Indeed *preceding_key_p = ZERO_KEY is unnecessary, just makes me
>> comfortable. The problem is PRECEDING_KEY() allocates an on-stack
>> variable, and this one is overlapped with stackframe of
>> bch_btree_iter_init(), and overwritten. Because this anonymous on-stack
>> variable is allocated inside PRECEDING_KEY(), not (and should not be)
>> protected by compiler.
>>
>> So I add the new local variable preceding_key (and make preceding_key_p
>> points to it) explicitly on stack frame of bch_btree_insert_key(), which
>> will never be overlapped with stackframe of bch_btree_iter_init().
>>
>> Thanks.
> 
> HI,
> 
> 
> so the right line should be :
> 
> *preceding_key_p = NULL;
> 
> because Rolf is right
> 
> preceding_key_p = NULL;
> 
> does change only the value of the calling parameter and exits, not the
> value of the preceding key in the stack.

Hmm, can you talk more specific to the code ? I don't catch what you
mean ....  Thanks.

Coly Li


-- 

Coly Li
