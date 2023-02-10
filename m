Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC97C05027
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 11:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjBJLN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBJLN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 06:13:56 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2E72DDA
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 03:13:20 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230210111245epoutp01005e2e7242f112aaf914722bb27e8f22~CcjC-y5jk2119621196epoutp01h
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 11:12:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230210111245epoutp01005e2e7242f112aaf914722bb27e8f22~CcjC-y5jk2119621196epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676027565;
        bh=t6bvHlN4nbiLV9YJIWp/6zdRxLV7CVNUvL+00278CqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rNAF+UmchDxqmFiiZfCCWppXRdxFg0sy2JLQfaQh78D0jp6rINrcasIwMwIbe4Qob
         1rEp2oEI8ygos2BaB0TX91exakUqMYIplbKGmLUyUOOmKq+GEbs/cV1NYYfd/9FxPH
         zTne1CjvsATXRitEtyPdAMna3L4oNCwQ3o9LeY2M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230210111244epcas5p20db5468dcc1f9e2a3d7a4c675232c573~CcjCLrcMP3180031800epcas5p2m;
        Fri, 10 Feb 2023 11:12:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PCrgG46b6z4x9Pr; Fri, 10 Feb
        2023 11:12:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.7D.55678.AA626E36; Fri, 10 Feb 2023 20:12:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230210111242epcas5p4093904df8eca07029b7fa66bd3787d18~CcjANDHlH0200802008epcas5p4J;
        Fri, 10 Feb 2023 11:12:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230210111242epsmtrp203325759ec30575367a52658eb4370bf~CcjAMcUVS2647926479epsmtrp2a;
        Fri, 10 Feb 2023 11:12:42 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-f0-63e626aa93d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.FA.05839.9A626E36; Fri, 10 Feb 2023 20:12:41 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230210111241epsmtip2788fdbb8dc9b81b5fb9c30c51009a2e8~Cci-aOHjP2975629756epsmtip2i;
        Fri, 10 Feb 2023 11:12:41 +0000 (GMT)
Date:   Fri, 10 Feb 2023 16:42:12 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged
 passthrough
Message-ID: <20230210111212.GA17396@green5>
MIME-Version: 1.0
In-Reply-To: <20230210020114.zzmazatkxeomowxq@shindev>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmuu4qtWfJBj8nylmsXH2UyWLvLW2L
        +cueslvsm+XpwOKxeUm9x+6bDWwenzfJebQf6GYKYInKtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2qekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM74/XEyS8FPvoq5h0UaGPfwdDFycEgI
        mEhcOKPZxcjFISSwm1Hi+eoWFgjnE6PEm4WbWSGcb4wSrZsWM3YxcoJ1HNx1ghkisZdRYu33
        x1AtTxgl1tzqZgKpYhFQlZjx8TI7yA42AU2JC5NLQcIiAqYST7ZsYQKpZxZYyCgxa9oUVpCE
        sIC/xNJLO9hAbF4BbYm+g/dZIGxBiZMzn4DZnAJmEq+W/GAHsUUFlCUObDsONkhC4Bq7xI55
        L1khznORuDrrBjuELSzx6vgWKFtK4vO7vWwQdrLEpZnnmCDsEonHew5C2fYSraf6mUFsZoEM
        iQd/trFC2HwSvb+fMEECjFeio00IolxR4t6kp1BrxSUezlgCZXtI9LX8YoQEyk5GiYn7frBN
        YJSbheSfWUhWQNhWEp0fmoBsDiBbWmL5Pw4IU1Ni/S79BYysqxglUwuKc9NTi00LjPJSy+Fx
        nJyfu4kRnAK1vHYwPnzwQe8QIxMH4yFGCQ5mJRHe8rtPk4V4UxIrq1KL8uOLSnNSiw8xmgLj
        ZyKzlGhyPjAJ55XEG5pYGpiYmZmZWBqbGSqJ86rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYJq+
        6l7BwWWWFXxHF9hnLkhq7lipetyz6OXW23nHzrzg9GE58u2SvWG/hN0BheJfc63em0xZER+q
        IyGxLSP+xf6wjPfqP4243ypct7oguHqpzzrGkxaC+hwbeZp10nLjgsoa13L9ezTxsfrJGLP1
        uw+55d15/VvM7I7mgai/wcli54XWrHplMeOR2OXtGdKPzL+3OTF9Yj94bOux/UfMK1xPufh1
        l72/vjffPLq8QzTm+IF9gjNb/6+cvGVzz+SJ0uvWzfyf2uTTrr2FXz7r5KtHSy+dfid9ep2b
        GpPTb/WJn0vKZ7EeT/GMSXl3JSD92q8nzWyqPHvlP0VdP3Cv3rLiU+qtX8nuj5tkfKJtmPYo
        sRRnJBpqMRcVJwIAs5CJ2woEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvO5KtWfJBptXWVusXH2UyWLvLW2L
        +cueslvsm+XpwOKxeUm9x+6bDWwenzfJebQf6GYKYInisklJzcksSy3St0vgyth9Wa5gNU/F
        8lfZDYwdXF2MnBwSAiYSB3edYAaxhQR2M0qs7E6AiItLNF/7wQ5hC0us/PccyOYCqnnEKNFx
        ZDkLSIJFQFVixsfLQAkODjYBTYkLk0tBwiICphJPtmxhAqlnFljIKPHn+mE2kISwgK/Ej84L
        jCA2r4C2RN/B+ywQQ3cySvzuWAaVEJQ4OfMJ2AJmATOJeZsfMoMsYBaQllj+jwMkzAkUfrUE
        4jhRAWWJA9uOM01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEB7SW5g7G7as+6B1iZOJgPMQowcGsJMJbfvdpshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        C10n44UE0hNLUrNTUwtSi2CyTBycUg1MyxWeciad+Lfo26+M8ynLmjde22BULPdDdn+3b4Fp
        85MFiVWh79ojKy90TtbQn78zvCEqu7w/WHiCStAsjUP85mdvPv7ak2/D4vk6lWejVM/PGblx
        eyZPsFNs/ehYsDNuU4obi4H22/rMFY53I5yq7vZ9F0z0aG7ce+KM+XaFKobtFxN+bhHZdD8k
        Sd8mk7UrwOhZ+I4fWrkh5dYO/dw3/tk5xpvtO3bnq4Rb9bRrc2b2pV82S4g4NfXl559bsmeG
        Zs7e+CLuZ8zKZbeLMiQPsH9c+sHO9z7X6c2Ff9wnbbn5VL/l7xe9aUr7vkbdVRL/7OFh1TE9
        7+Byxcd/ZCaVPLOtEOg677U3i+OhVamWEktxRqKhFnNRcSIAwadm49cCAAA=
X-CMS-MailID: 20230210111242epcas5p4093904df8eca07029b7fa66bd3787d18
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_53b04_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230209094631epcas5p436d4f54caa91ff6d258928bba76206de
References: <CGME20230209094631epcas5p436d4f54caa91ff6d258928bba76206de@epcas5p4.samsung.com>
        <20230209094541.248729-1-joshi.k@samsung.com>
        <20230210020114.zzmazatkxeomowxq@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_53b04_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Feb 10, 2023 at 02:01:14AM +0000, Shinichiro Kawasaki wrote:
>On Feb 09, 2023 / 15:15, Kanchan Joshi wrote:
>> Ths creates a non-root user "blktest46", alters permissions for
>> char-device node (/dev/ngX) and runs few passthrough commands.
>> At the end of the test, user is deleted and permissions are reverted.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>
>Thanks for the patch. I guess this test case exercises nvme_cmd_allowed() in
>drivers/nvme/host/ioctl.c.

Yes. Thanks for review.
>The test contents look valid and good.
>
>This test case adds and deletes a user. For every test case run, it creates and
>removes the user home directory and touches /etc files. It does not sound right
>for me. It changes system set up, and sudden test case stop will leave the user.
>
>I suggest to ask blktests users to prepare the normal user and specify it to a
>config file variable (it can be named NORMAL_USER or something). I also suggest
>to add two new helper functions: _require_user() will check that the specified
>user is valid, and _run_user() will wrap the "su $NORMAL_USER -c" command line.

I was trying to make this automatic for blktests users.
Script attempts cleanup always (regardless of test-failure).
But yes, if any command gets stuck, cleanup won't happen.
So what you mentioned - sounds fine to me.

>If you don't mind, I can create another patch for further discussion based on
>the suggestion above, and modify your patch to use the new helper functions.
Sure. Please remove "_have_fio" line also in v2.

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_53b04_
Content-Type: text/plain; charset="utf-8"


------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_53b04_--
