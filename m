Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A7C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 05:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3568420840
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 05:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfFIF4o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 01:56:44 -0400
Received: from smtp7.tech.numericable.fr ([82.216.111.43]:59536 "EHLO
        smtp7.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIF4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 01:56:44 -0400
Received: from pierre.juhen (89-156-43-137.rev.numericable.fr [89.156.43.137])
        by smtp7.tech.numericable.fr (Postfix) with ESMTPS id 2056261310;
        Sun,  9 Jun 2019 07:56:41 +0200 (CEST)
Subject: Re: [RFC PATCH] bcache: fix stack corruption by PRECEDING_KEY()
To:     Coly Li <colyli@suse.de>, Rolf Fokkens <rolf@rolffokkens.nl>
Cc:     Nix <nix@esperi.org.uk>, linux-block@vger.kernel.org
References: <20190608102204.60126-1-colyli@suse.de>
 <8855017f-729e-9719-236d-e98710702564@rolffokkens.nl>
 <777da4cb-2d11-9bcc-b56f-e59265b8c76d@suse.de>
From:   Pierre JUHEN <pierre.juhen@orange.fr>
Message-ID: <bf1ccdb8-2a32-e69b-f52e-0b4fa45fe18f@orange.fr>
Date:   Sun, 9 Jun 2019 07:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <777da4cb-2d11-9bcc-b56f-e59265b8c76d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-FR
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegledgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecupfgfoffgtffkveetuefngfdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheprfhivghrrhgvucflfgfjgffpuceophhivghrrhgvrdhjuhhhvghnsehorhgrnhhgvgdrfhhrqeenucfrrghrrghmpehmohguvgepshhmthhpohhuthenucevlhhushhtvghrufhiiigvpedt
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Le 09/06/2019 à 02:59, Coly Li a écrit :
> On 2019/6/9 2:50 上午, Rolf Fokkens wrote:
>> On 6/8/19 12:22 PM, Coly Li wrote:
>>> +static inline void preceding_key(struct bkey *k, struct bkey
>>> *preceding_key_p)
>>> +{
>>> +    if (KEY_INODE(k) || KEY_OFFSET(k)) {
>>> +        *preceding_key_p = KEY(KEY_INODE(k), KEY_OFFSET(k), 0);
>>> +        if (!preceding_key_p->low)
>>> +            preceding_key_p->high--;
>>> +        preceding_key_p->low--;
>>> +    } else {
>>> +        preceding_key_p = NULL;
>> If I'm correct, the line above has no net effect, it just changes a
>> local variable (parameter) with no effect elsewhere. So the else part
>> may be left out, or do you mean this?
>>
>> *preceding_key_p = ZERO_KEY;
>>
> Hi Rolf and Pierre,
>
> Setting preceding_key_p to NULL is for the following
> bch_btree_iter_init(). See the call chains
>
> bch_btree_insert_key()->bch_btree_iter_init()->
> __bch_btree_iter_init()->bch_bset_search()
>
> preceding_key_p is parameter 'search' in bch_bset_search().
> If it is NULL, t->data->start returns directly; if it is not NULL,
> __bch_bset_search() is called.
>
> Indeed *preceding_key_p = ZERO_KEY is unnecessary, just makes me
> comfortable. The problem is PRECEDING_KEY() allocates an on-stack
> variable, and this one is overlapped with stackframe of
> bch_btree_iter_init(), and overwritten. Because this anonymous on-stack
> variable is allocated inside PRECEDING_KEY(), not (and should not be)
> protected by compiler.
>
> So I add the new local variable preceding_key (and make preceding_key_p
> points to it) explicitly on stack frame of bch_btree_insert_key(), which
> will never be overlapped with stackframe of bch_btree_iter_init().
>
> Thanks.

HI,


so the right line should be :

*preceding_key_p = NULL;

because Rolf is right

preceding_key_p = NULL;

does change only the value of the calling parameter and exits, not the 
value of the preceding key in the stack.



