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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB65C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442961987
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSTvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSTuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 15:50:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD4C06175F;
        Fri, 19 Mar 2021 12:50:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x9so7698399qto.8;
        Fri, 19 Mar 2021 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXxjdXdZ8LP/Gkdqlq0XEa8RbhH5KkcN4OGdks0dwe4=;
        b=p9uivg2EJlTyyxbrsg6mnv2KI/27j2nx0KCVtl0ZM6xrcjdYLmyKqvbyd7gDWLfDmy
         uL+p+1bCZ0gphWqJhGSu449AmTXaA4PhruNuYHu/r1nCBg1wmhLsz9lrpAlh+CLrojjP
         QmaR50Q63CwOwiZ0FI5OTXUXKTG4f4/s/smAtbnx8hkltgsTkmhXnNDFmv/pMNIDkd5A
         8QTOCYga9npnsfwBHGFyw1MX8pEAaKIq47TUT8ZSEckrE02/zIR88jjkqNDvU1BxHpxh
         V4jV+bsczGHQ2al0/mb+nx2cryo6sKDt0iwwxwTTfUgv1/A4lCLinrSUMRWhx1E/reBW
         ilMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=oXxjdXdZ8LP/Gkdqlq0XEa8RbhH5KkcN4OGdks0dwe4=;
        b=kcgarFb18LCvmb+HnWAL2Wl5SDIIGttfQ4Um1BxRwHe2gPAMwRDxOTmv4mKLKXro9T
         A60wrzlbFqIjrcWcnSA4/WnmsVxBz8ChpYH80Eb+H4RHkmL9OFKhkl5CYNThaWTcalLt
         7+abx3U2MGQ94HINeFIC5Ak5cLVCjQgrh5i8fdBoDEXUjjwlHZq2n1ga471to97V5KE5
         ClI7VTspWfe+925kdfuOkZLj1BOBrxe5vXo7jsSbVIzUKJ02n4KrhBsqKbXNw7YsxPQC
         WQ+YksUN0QECMq+Pg9YrHFJL/66JbQoRQwH/QkHNz5VriVsjLuXZCJjeXeKy9zMAeAeH
         m0zg==
X-Gm-Message-State: AOAM533bnNwk4hFtHko22WFNJV9Jk0hPlIu0aq1hktrYqdlxwKwZJVxk
        P1ZHhBs5CQ8q765rl0ZmPi/7uJi9mKbigL36
X-Google-Smtp-Source: ABdhPJyIqInwUekEA8Q+BP/v+BagviInSUKgZEyZcihaHiIoJEJn/2ti5HV43MdT9DK8AhfjhnSkEg==
X-Received: by 2002:ac8:e81:: with SMTP id v1mr261240qti.23.1616183453736;
        Fri, 19 Mar 2021 12:50:53 -0700 (PDT)
Received: from Gentoo ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id p8sm4547273qtu.8.2021.03.19.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:50:52 -0700 (PDT)
Date:   Sat, 20 Mar 2021 01:20:42 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@bombadil.infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Trivial typo fix
Message-ID: <YFUAklTZAmBkGfQd@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@bombadil.infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319012419.16778-1-unixbhaskar@gmail.com>
 <d390c9d5-a72-7c88-48b6-5994ef26fe0@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4cEM49ycfNoedRSh"
Content-Disposition: inline
In-Reply-To: <d390c9d5-a72-7c88-48b6-5994ef26fe0@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--4cEM49ycfNoedRSh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:58 Fri 19 Mar 2021, Randy Dunlap wrote:
>
>
>On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:
>
>> s/funtion/function/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>The change is correct, but it doesn't help me when I try to read
>that function description.  :(
>
I have reconstructed that sentence for better readability and send a V2 for
your perusal.Changes the subject line accordingly too.

>Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>> ---
>> block/blk-mq-tag.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 9c92053e704d..ad91e98dbc43 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -374,7 +374,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>
>> /**
>>  * blk_mq_tagset_wait_completed_request - wait until all completed req's
>> - * complete funtion is run
>> + * complete function is run
>>  * @tagset:	Tag set to drain completed request
>>  *
>>  * Note: This function has to be run after all IO queues are shutdown
>> --
>> 2.26.2
>>
>>

--4cEM49ycfNoedRSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBVAJIACgkQsjqdtxFL
KRXWngf9HN5HemUuoBXOKjYCp0ddkQvTu3lvCVO8DGgJ66JtY/AvIZX9aqDKIhcX
NY0jXdFMAfM/pcqb+vsaWzQKmRY3Sj1bkjsVFep0zADe8/OROKFE/+2AlQ2KMYUS
nrxoIonHk+3EuK/MyWE7XqZwoani7NxNlY933BMnsIiONqKR97jeY/TATFrooT5Z
kWpo13+KGn28cCvy/f43RGmgX/EoLftilZEytxVtYz/qMzEdybLRn/jlqJG27kOb
MCOCR1wvM/zownIhZMlEITyXDmpLdDb7Tue2QizILV47pjjhtDBsPeX4vkczpe9/
eJY6Vv255on3ZqojXJh1qyHC4oyt8A==
=RJvC
-----END PGP SIGNATURE-----

--4cEM49ycfNoedRSh--
