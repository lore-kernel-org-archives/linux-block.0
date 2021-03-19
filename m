Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC38C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D6F6197B
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSUk3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSUkA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:40:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97655C06175F;
        Fri, 19 Mar 2021 13:40:00 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h7so7813825qtx.3;
        Fri, 19 Mar 2021 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xKUYZv/0JLdH76GL87FPqo0pCWIkG0WsH5j5Ikbt1/c=;
        b=LTLagd+4IRSSjjPkiSr6UBFj652XkOUXsWVpR3Kcj302mJsqpKd4uyY1m8CIiJMdlJ
         hf8I79iWcgLb4Es1XCPIGwx9R1hkoYZSv+LAwkMVrP757/DoKjO+xbwZh/d9uNAfzG9h
         c8++2cSP7G6tHdfmQh1oLfvy2ghiV9kfelKo3wwSbQnAtWxnYX6SdY4utCPcBN1p7n2b
         0Lpo0uQfF8qjrvol25vN4hhw298yCIjHgUtd3UPW5eSE+y+k2vSw/n4je1pZ+kNc2L8q
         bAxgc+W4wYmB/O04n0uxoSIcX5q5VrTsXDTikWV/Z8hkU8Di/w+UTMJ2hfzJiC1VaNDy
         567w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xKUYZv/0JLdH76GL87FPqo0pCWIkG0WsH5j5Ikbt1/c=;
        b=oRruDGLxmwaYoPQBJaPZrtLRgvmPnv0FBv471OWMey+pIUwgkdSx36weKfaMak1tVE
         GF34EzrjdDgYewtdFkPv7WNaKoq9GES7pE8BYPXpuQVpOGBf4rHPbIpJ4p2205Fs8xwW
         GqudqGAuK8ZWctwXMiiu+CZQNSZI6KbVk8gDuMuNt9OsyXHbyau+ai+xrh2jtMCRveR/
         yfPQpAY66dL7Vzbb6mdbjsW6pYv9PU8FkczeFZZWR/I/3iQe5Qd9kApEt9BvqlL86MYC
         gcG3oF142k5iszv8k3y41OvmneK7mLOm2RONK/kb+koayiaeAZX3NeFYyIlyUCKK44ey
         9eng==
X-Gm-Message-State: AOAM530j0ORUiAjdlpW6WPOxCj9Fo5FtmhEMW8HcfzSaivYhiBcmrwH8
        NaVqEBPkt28Qx9qHa6Vd3/Y=
X-Google-Smtp-Source: ABdhPJwirxb3BjXd3lqFwkyYoiAUg+VMXnIrIpVWVm8E0Og81HnPKXnCW4jHsu6w1ewuq2pnZMO5xQ==
X-Received: by 2002:ac8:688c:: with SMTP id m12mr511436qtq.74.1616186399873;
        Fri, 19 Mar 2021 13:39:59 -0700 (PDT)
Received: from Gentoo ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id q15sm4553296qti.9.2021.03.19.13.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:39:59 -0700 (PDT)
Date:   Sat, 20 Mar 2021 02:09:48 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V3] blk-mq: Trivial typo fix and sentence construction
 for better readability
Message-ID: <YFUMFBB8iuoSULxL@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210319202359.8893-1-unixbhaskar@gmail.com>
 <771aa286-5270-9642-7d6d-9cdb2f7014f8@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fIlBsr3N95rsti4G"
Content-Disposition: inline
In-Reply-To: <771aa286-5270-9642-7d6d-9cdb2f7014f8@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--fIlBsr3N95rsti4G
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:27 Fri 19 Mar 2021, Jens Axboe wrote:
>On 3/19/21 2:23 PM, Bhaskar Chowdhury wrote:
>>
>> A typo fix and sentence reconstruction for better readability.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>   Changes from V2:
>>   Thanks, Randy and Tom for the suggestion,mould it.
>>   Missed the subject line prefix of pattern,so added back
>>
>>  block/blk-mq-tag.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 9c92053e704d..9da426d20f12 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>  }
>>
>>  /**
>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>> - * complete funtion is run
>> + * blk_mq_tagset_wait_completed_request - wait until all the req's
>> + * functions completed their run
>
>This is still nonsense, see reply to previous version.
>
Well, I was just trying get a sense of your sense...so ...it's all yours
fella,take on ...
>--
>Jens Axboe
>

--fIlBsr3N95rsti4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBVDBAACgkQsjqdtxFL
KRWU8QgAnUepVAMKC8CA6PDCXPQciGVNFoIqkcuTgHaempJMqXs3cRcFtu1mG/So
kEcXal8R44J8vriU0FNEEU+lyEx7D44Hfkar1qa7cJSy5DxxHwg8rNel5mmhRgkA
3qtAEPPXanYlDT8TzpHttaI3Oe9iUqFC1BRWyZMiZzThXXx33on6MID46PfmsAv+
8v0zslvlfGV26ML0Yy6647pqZpljkiiPUiDB4PWNSKSTnQrcf11QdT/1GLPAckbO
bM501n+pZ3NantmpT2RkESgHHGTdS3M77KQ1qAKp1veILo2YWR2i+ffpkVtkpiks
xBUMMiFSBdfi37nd/gqK0T0Kd9cs4g==
=5gIa
-----END PGP SIGNATURE-----

--fIlBsr3N95rsti4G--
