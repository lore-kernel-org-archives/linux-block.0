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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB4C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8674461988
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCSWzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSWzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 18:55:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E3C061760;
        Fri, 19 Mar 2021 15:55:19 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f12so8080654qtq.4;
        Fri, 19 Mar 2021 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+UtR9KFCPCJ9j7+dtObkv9dpVo3W7fquQZ/ci+zCfI=;
        b=bgWSNWEZMIk+vpr8aG54UaGcstMfzfS36qKK8lLyC1u2qcEgoGeHUTZ5OuVe3gIEzm
         VaMHXv72+Hv8Ls9+zHSbadDqL0mfGb6GlvVl0gDwzB2V+w7/AeMOlyIi6BI5XjI5cC1t
         sRxUWX1GtF0khDnab8DKMY5DyuViJbaxN4BoQHg1chQ2rk4PZTrrz0BZpaKRXfXJfOOM
         GdYMxCko/iIyBdRm2DQt6Fip4iXpwk+C7ovxJCBeydvIv1nlkfbm2Er4KuqNkxhIAxWj
         U59IefpR8U2OM75aPabwWRKIcgV0YGuAB6slm2xJmcP0p9Bpes8NNQxkq6loD4OrLRMc
         AffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=t+UtR9KFCPCJ9j7+dtObkv9dpVo3W7fquQZ/ci+zCfI=;
        b=c5mouGs2XgI+obxgYkjigePF/tRYjv4FNwTsd7vn5lnMWmnjq+/0NYVk6jPcf62/p4
         hIKxw1+fNFsdWOEvdZs6IxNMKNs5KM0a9BNkCJBLbxM8bpWCpoPPalcEhqAIaj+dmF36
         WbY0Zqzp7jFI/MlNUa9UoAT4B6AxPIrvf2m0bNWRMLYfSrgrjnlZRmUPARF7fmFiJ/ZC
         MRKUz0ubYXjrWleFkqT6Htl+feqTQqZaEDgBOL+IEhXAM7+rTIMqTfqqboKxppP13nj8
         AVOhkUj8nBfB7m+rsNBGsFEo/3W39gu0G+WJtJIJBNmQkSA7/LjJWXClCvpjSyz3FAFJ
         hW9A==
X-Gm-Message-State: AOAM530lU7i5gx6Magrni/cI4pp1rSU/F9/dWAJa+wLuMM4KIfHYUYQe
        ZjIwMCBC21qwOmAF04s0cwyA5ROyl3qN3Pmk
X-Google-Smtp-Source: ABdhPJxuRi8usmWfzO8EWrYO8FZ5XabN65v/GrLEz/vInZttu8vNigjd7VbAuVxBNTftES7pEvFVAQ==
X-Received: by 2002:ac8:6913:: with SMTP id e19mr966506qtr.78.1616194518505;
        Fri, 19 Mar 2021 15:55:18 -0700 (PDT)
Received: from Gentoo ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id a19sm5581443qkl.126.2021.03.19.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:55:17 -0700 (PDT)
Date:   Sat, 20 Mar 2021 04:25:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V3] blk-mq: Trivial typo fix and sentence construction
 for better readability
Message-ID: <YFUryzVjSQU0RqCv@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210319202359.8893-1-unixbhaskar@gmail.com>
 <771aa286-5270-9642-7d6d-9cdb2f7014f8@kernel.dk>
 <YFUMFBB8iuoSULxL@Gentoo>
 <080d3720-3174-e47f-95a1-ad7640a64051@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="00nTzOg3dPAwtGnD"
Content-Disposition: inline
In-Reply-To: <080d3720-3174-e47f-95a1-ad7640a64051@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--00nTzOg3dPAwtGnD
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 16:19 Fri 19 Mar 2021, Jens Axboe wrote:
>On 3/19/21 2:39 PM, Bhaskar Chowdhury wrote:
>> On 14:27 Fri 19 Mar 2021, Jens Axboe wrote:
>>> On 3/19/21 2:23 PM, Bhaskar Chowdhury wrote:
>>>>
>>>> A typo fix and sentence reconstruction for better readability.
>>>>
>>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>>> ---
>>>>   Changes from V2:
>>>>   Thanks, Randy and Tom for the suggestion,mould it.
>>>>   Missed the subject line prefix of pattern,so added back
>>>>
>>>>  block/blk-mq-tag.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>> index 9c92053e704d..9da426d20f12 100644
>>>> --- a/block/blk-mq-tag.c
>>>> +++ b/block/blk-mq-tag.c
>>>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>>>  }
>>>>
>>>>  /**
>>>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>>>> - * complete funtion is run
>>>> + * blk_mq_tagset_wait_completed_request - wait until all the req's
>>>> + * functions completed their run
>>>
>>> This is still nonsense, see reply to previous version.
>>>
>> Well, I was just trying get a sense of your sense...so ...it's all yours
>> fella,take on ...
>
>It's not my sense, I didn't write that function or comment. Just seems
>pointless to me to update it and not get it actually legible and
>correct, which is why I sent you a suggestion to what should be. From
>that point of view, the suggested change actually makes it _worse_,
>because "requests functions completed their run" doesn't mean anything.
>At least the current one is kind of legible, since the "complete
>function" refers to the IPI completion function, which is what we're
>waiting for here.
>
>In any case, what I replied in v2 should be generally readable, and
>avoids the weird req's thing too which I really dislike. Just uses
>requests, that's correct and avoids a nonsensical possessive.
>
>So do send a v4 if you want with that wording.
>
I am apologetic about the pain I caused you to take this long route. I shall be
  prudent in the future. Thanks for standing, Jens.
>--
>Jens Axboe
>

--00nTzOg3dPAwtGnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBVK8cACgkQsjqdtxFL
KRU1wAf/RigYG1gSpJD1uoY8pn3ybEdGx9EHEIJQSRvWQEdkFWgxsDvSYvFpE4b+
iy002TkSh1F/e4OXsJMau2NtfQkl2tCtmb1QVNUVNYqv8JUxiQaShiNYMnNA5ERn
yjHCLnhn0kYoiQHVpQsb12/m6KsXaJDWbIPPlgcGkwZTccEyzb1S9KJxGQztQYTn
pyUL4hg2tZfrUZMQZA1U1Bp8nGQPkW4FHvPyFzH4mHGlbfoHP4v/7/vn2e4/NAsI
2kNoJPmyE8PnuKJYl8eHQl6Zzc5b3xFDvQt1FzR3HwXkWnoK1BdFL0lLLf/x7IFG
dYcZ/EN9ju7q/z1u4qYMn9oKsej21w==
=pJyG
-----END PGP SIGNATURE-----

--00nTzOg3dPAwtGnD--
