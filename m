Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D7C433C1
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E436197B
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCSUHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSUHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:07:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED1C06175F;
        Fri, 19 Mar 2021 13:07:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c3so4243798qkc.5;
        Fri, 19 Mar 2021 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lzVlh3C5bytcisxFPBLRdWX8JE0Mw5vGOf2LjCg569M=;
        b=qdkITpaAeFMVEDCYWl1wULINhMbjfY6AjCczAZHIyA2GOhqRdCAi3h4gFVwupkYcEy
         SM/2im7/OHR9qezMrj6En15EBA3Pjdv+aAvIHHckykLkwACc1vss3SWoQUsYugDYt2kO
         qI3Sy4bSMmpImk9tWAR2Y2P8Y2qSnsO3SlGHwrXJBo+v7ss79WjOzMeOFptK4js077+S
         Dpal240xSN3K3U5pr+4jxZ/jkPvv57k5OZKL1pSofgk3Wd5aY8oNZoSajRaqd0Ikni4Q
         zqdRuIBcWbrTi8XoCPlPh8Ce6/UNLco9ktJ+tfzoshzkBSiS2jLzPbYnvqYYdUqg9SJ9
         PTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lzVlh3C5bytcisxFPBLRdWX8JE0Mw5vGOf2LjCg569M=;
        b=PXeJsLHUT/xIUnUafN45NkS6IN7DIDo362i7jPtRVYA0p3bSlL/+uhBPAv+eyg1rs3
         X++H7enAKwon3Mq9BafU9WcoQxbol/oSEJrkDdWD6YdubVBreTqXHrQZyHEPwrN5FUQK
         9G4nM7DQuDDUKMpgmhLxItolthWZtkerT3Lv99L8PWjCRQ61rGF/fp4QYooodtntXE+T
         NBrhNFOyJveBrffxWa3bosdcMdu/pag93iHY57jviHqJ+Ud46t9vpNBGeXtAk0FFQaj1
         0+ShB3A1yTzqyTUE3Te7AhT+qgvTYgRtVuGXnmhfQBwVSGeUnDCjqzNb9MN+V2v3RGde
         tGvg==
X-Gm-Message-State: AOAM533vrnC8Rcx6tIWdrkfGHj0I1yOe4o2G8NjBTgtR8Wea6Sof6hfB
        HWZetHyo5VEfBiEhvK+nw9w=
X-Google-Smtp-Source: ABdhPJwwWBMv245Jo5nXuhLBsMxpyAHNURAJBFnl6/NLEXbd/3BmRuqaVNVxiC6BmPdAG5F5dUGSSA==
X-Received: by 2002:ae9:e80b:: with SMTP id a11mr315595qkg.65.1616184461059;
        Fri, 19 Mar 2021 13:07:41 -0700 (PDT)
Received: from Gentoo ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id k28sm5301128qki.101.2021.03.19.13.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:07:39 -0700 (PDT)
Date:   Sat, 20 Mar 2021 01:37:29 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@bombadil.infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Trivial typo fix and sentence construction for better
 readability
Message-ID: <YFUEgeN+oR9n8uoN@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@bombadil.infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319195451.32456-1-unixbhaskar@gmail.com>
 <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p1zRvpYwqApr4iAW"
Content-Disposition: inline
In-Reply-To: <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--p1zRvpYwqApr4iAW
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:03 Fri 19 Mar 2021, Randy Dunlap wrote:
>
>Hm, needs some spacing fixes IMO. See below.
>
>
>On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:
>
>>
>> s/funtion/functions/
>>
>> Plus the sentence reconstructed for better readability.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>> Changes from V1:
>>  Randy's suggestions incorporated.
>>
>> block/blk-mq-tag.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 9c92053e704d..c2bef283db63 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>> }
>>
>> /**
>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>> - * complete funtion is run
>> + * blk_mq_tagset_wait_completed_request - wait until all the  req's
>
>                                                             the req's
>
>> + *  functions completed their run
>
>and more indentation + wording on that line above:
>  *        functions have completed their run
>
Apology...my bad ...fixing ...V3 ...in quick time ...

>>  * @tagset:	Tag set to drain completed request
>>  *
>>  * Note: This function has to be run after all IO queues are shutdown
>> --
>
>Thanks.

--p1zRvpYwqApr4iAW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBVBH0ACgkQsjqdtxFL
KRU0pggAlHM63BsI87wwDDPLYU/jJxq9QNowUe9DjIuijmkn/sW61aFhFECzaT34
2dp3Sk0nAM9JfDJaF0dhA1sczUyLIkuvqUSP+/jnkUz+ZEvOf3JgOH44dn0ayydo
WZAM2nTYPMSxB5H1fP5wjraqvLWC6FhXptl2FLZa6EI2qkwfXZi/rihS6Ia7yau9
UEmJuG/WAl9tV2llsz6TM8pIN9ASLiNjO5ykC6tv7uYVAwZtSWoZquZJw3SMCc8i
Y0TIVowsqagc1mx0xw6K4oRjCcttPqrkZURUoQh7uXRXOenToV9wdpPE6WsdmlHl
IOpJ87xVuCe7SiDRMYIBjG4jdA3dNg==
=U7B5
-----END PGP SIGNATURE-----

--p1zRvpYwqApr4iAW--
