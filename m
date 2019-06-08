Return-Path: <SRS0=tJY/=UH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35333C28CC5
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02270214C6
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 23:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfFHXLA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jun 2019 19:11:00 -0400
Received: from smtp1.tech.numericable.fr ([82.216.111.37]:49376 "EHLO
        smtp1.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFHXLA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Jun 2019 19:11:00 -0400
X-Greylist: delayed 2400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Jun 2019 19:10:59 EDT
Received: from pierre.juhen (89-156-43-137.rev.numericable.fr [89.156.43.137])
        by smtp1.tech.numericable.fr (Postfix) with ESMTPS id E478B142E55;
        Sat,  8 Jun 2019 23:52:15 +0200 (CEST)
Subject: Re: [RFC PATCH] bcache: fix stack corruption by PRECEDING_KEY()
To:     Rolf Fokkens <rolf@rolffokkens.nl>, Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>, linux-block@vger.kernel.org
References: <20190608102204.60126-1-colyli@suse.de>
 <8855017f-729e-9719-236d-e98710702564@rolffokkens.nl>
From:   Pierre JUHEN <pierre.juhen@orange.fr>
Message-ID: <3b43c881-f505-3436-7ac7-d711b70b13e2@orange.fr>
Date:   Sat, 8 Jun 2019 23:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8855017f-729e-9719-236d-e98710702564@rolffokkens.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-FR
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegkedgudeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfpfgfogfftkfevteeunffgpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefrihgvrhhrvgculfgfjffgpfcuoehpihgvrhhrvgdrjhhuhhgvnhesohhrrghnghgvrdhfrheqnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Coly, Rolf,

I think Rolf is right, with his second option (*preceding_key_p = ZERO_KEY;)

Regards,

Le 08/06/2019 à 20:50, Rolf Fokkens a écrit :
> On 6/8/19 12:22 PM, Coly Li wrote:
>> +static inline void preceding_key(struct bkey *k, struct bkey 
>> *preceding_key_p)
>> +{
>> +    if (KEY_INODE(k) || KEY_OFFSET(k)) {
>> +        *preceding_key_p = KEY(KEY_INODE(k), KEY_OFFSET(k), 0);
>> +        if (!preceding_key_p->low)
>> +            preceding_key_p->high--;
>> +        preceding_key_p->low--;
>> +    } else {
>> +        preceding_key_p = NULL;
>
> If I'm correct, the line above has no net effect, it just changes a 
> local variable (parameter) with no effect elsewhere. So the else part 
> may be left out, or do you mean this?
>
> *preceding_key_p = ZERO_KEY;
>
>> +    }
>> +}
>>     static inline bool bch_ptr_invalid(struct btree_keys *b, const 
>> struct bkey *k)
>>   {
>
>
>

