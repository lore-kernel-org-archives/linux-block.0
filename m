Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E75C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 17:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14898206BA
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 17:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfFIRwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:52:31 -0400
Received: from smtp1.tech.numericable.fr ([82.216.111.37]:43868 "EHLO
        smtp1.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfFIRwb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 13:52:31 -0400
Received: from pierre.juhen (89-156-43-137.rev.numericable.fr [89.156.43.137])
        by smtp1.tech.numericable.fr (Postfix) with ESMTPS id 4CE07143A7D;
        Sun,  9 Jun 2019 19:52:28 +0200 (CEST)
Subject: Re: [PATCH V2] bcache: fix stack corruption by PRECEDING_KEY()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        Rolf Fokkens <rolf@rolffokkens.nl>
Cc:     linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>
References: <20190609152400.18887-1-colyli@suse.de>
 <58eef1e0-b5d7-a3f7-8d59-4ef5117ce5fe@suse.de>
From:   Pierre JUHEN <pierre.juhen@orange.fr>
Message-ID: <2968c6b5-9f14-73ff-0571-5d9710a023d0@orange.fr>
Date:   Sun, 9 Jun 2019 19:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <58eef1e0-b5d7-a3f7-8d59-4ef5117ce5fe@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-FR
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehtddguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfpfgfogfftkfevteeunffgpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefrihgvrhhrvgculfgfjffgpfcuoehpihgvrhhrvgdrjhhuhhgvnhesohhrrghnghgvrdhfrheqnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I tested a patched  bcache module. OK for me.

Le 09/06/2019 à 17:28, Coly Li a écrit :
> On 2019/6/9 11:24 下午, Coly Li wrote:
>> Recently people report bcache code compiled with gcc9 is broken, one of
>> the buggy behavior I observe is that two adjacent 4KB I/Os should merge
>> into one but they don't. Finally it turns out to be a stack corruption
>> caused by macro PRECEDING_KEY().
>>
>> See how PRECEDING_KEY() is defined in bset.h,
>> 437 #define PRECEDING_KEY(_k)                                       \
>> 438 ({                                                              \
>> 439         struct bkey *_ret = NULL;                               \
>> 440                                                                 \
>> 441         if (KEY_INODE(_k) || KEY_OFFSET(_k)) {                  \
>> 442                 _ret = &KEY(KEY_INODE(_k), KEY_OFFSET(_k), 0);  \
>> 443                                                                 \
>> 444                 if (!_ret->low)                                 \
>> 445                         _ret->high--;                           \
>> 446                 _ret->low--;                                    \
>> 447         }                                                       \
>> 448                                                                 \
>> 449         _ret;                                                   \
>> 450 })
>>
>> At line 442, _ret points to address of a on-stack variable combined by
>> KEY(), the life range of this on-stack variable is in line 442-446,
>> once _ret is returned to bch_btree_insert_key(), the returned address
>> points to an invalid stack address and this address is overwritten in
>> the following called bch_btree_iter_init(). Then argument 'search' of
>> bch_btree_iter_init() points to some address inside stackframe of
>> bch_btree_iter_init(), exact address depends on how the compiler
>> allocates stack space. Now the stack is corrupted.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Reviewed-by: Rolf Fokkens <rolf@rolffokkens.nl>
>> Reviewed-by: Pierre JUHEN <pierre.juhen@orange.fr>
> Hi Rolf and Pierre,
>
> Oops, I am a little bit too hurry, just realize you don't offer
> Reviewed-by: yet.
>
> Could you like to offer a Reviewed-by: to this patch, then I may submit
> to Jens in this run ASAP.
>
> Many thanks of your code review and help !
>
> Coly Li
>
>
>> Tested-by: Shenghui Wang <shhuiw@foxmail.com>
>> Cc: Kent Overstreet <kent.overstreet@gmail.com>
>> Cc: Nix <nix@esperi.org.uk>
>> ---
>> Changlog:
>> V2: Fix a pointer assignment problem in preceding_key(), which is
>>      pointed by Rolf Fokkens and Pierre JUHEN.
>> V1: Initial RFC patch for review and comment.
>>
>>   drivers/md/bcache/bset.c | 16 +++++++++++++---
>>   drivers/md/bcache/bset.h | 34 ++++++++++++++++++++--------------
>>   2 files changed, 33 insertions(+), 17 deletions(-)
> [snipped]
>

