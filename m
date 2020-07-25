Return-Path: <SRS0=mT+h=BE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E1C433E0
	for <linux-block@archiver.kernel.org>; Sat, 25 Jul 2020 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757A8206D7
	for <linux-block@archiver.kernel.org>; Sat, 25 Jul 2020 11:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Tmj0rhVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgGYLgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:36:08 -0400
Received: from mout.web.de ([212.227.15.3]:52021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgGYLgH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 07:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595676956;
        bh=tL632JoesBjA1nIjOOtilNQQx0JJmdlSdql+Vgh01R0=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=Tmj0rhVYBtMO2v9NcBxUwh20IPVhwePRmDQ2SlW0arpOGmt/QPfvxfqRSXLEmMEYB
         en3ENpj2301lVsU7k/flndv6r5ZFWtHYEqwbsf24Nq0v5m1t00wpEL6CPOv/wZT1+p
         LgbIP9Z96eprRoigXcyA6ek4xENWwsazjtZkUHi4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.94.55]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLK6-1kZBW53gva-00Zu6Q; Sat, 25
 Jul 2020 13:35:56 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
Subject: Re: [PATCH] block: Fix reference count leak in blk_integrity_add
To:     Yi Wang <wang.yi59@zte.com.cn>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-block@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6301315e-1613-0970-ce9b-019d18458819@web.de>
Date:   Sat, 25 Jul 2020 13:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XfHm/7x7X87q7ow25EkeuukmVKR88tw1SDzdqxDdDUzGIDzOEXy
 zQdV32f2j+uMjFN/E7kkeh7D2TASJ4MVIDDWqjjHTU4ry4B2DM+hxB7B7cQij2Ws33nvviH
 vFmMrkEvxYptoQGr7mWUu3aJ4EGJyeoyRReyNQkojWYcZd55quXovnKoGaDCD611u+D5igm
 u5k6A5hmu0VPUTDvIzchg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DyzV1VLVpu4=:Fm6QWsnHUAFGLZmmcBBdO/
 2T4uTzLG02bzVkUXhSAnWw7toP5bz3RluDB626xSYnhAFu6700ytrmgBFbBxERkbFmQGDiCLl
 5uxzcIFXVtSd9zpPoMHtlQ1wX0Y/cieSHi2n3Ep1u6alsLF0Bg5+t+kWss8AKT5czF0Rf9Jf2
 ddkgOGfseSERmaJje8mv/IyiXXaUm6nLtZ3IDzsuWjReCWShDwNqJR3kcWpIOocaoO9+LYFbu
 mmSaEMcN6hFMZ61EJoVe5FbilfhEQIqWzVK7O7E7BvHZF4EovcP8s5N3h+iSBI/DYngnFpoO2
 QeM7ZvJLeFVVCjCho+cBNoXUHCbo6WVdrihtkgGwnzPY4ug5lzsGZxXF9NtXEBtr7S44lrA9e
 NaTSgtIYKvYOQI+pX0f3TQO4Ns7PRpGmNXMk/+aj9bN6dcDNvzyXgAzufcBgrqxsJcKxAzbp2
 VopnYbUkiMufyaoYBpHo5MlF7i7s/7OQsW6+lKZkEIHk5zPUbjJ0P3W+AVYPX1BOMkiX1d1Ki
 YRrMbhSv1LzqUVFz3GkjXXn2ITmh3ZBYHFGeTHlAyPVkocNJrtgJrOBsAOcJlINW9pAQtttul
 tJJz6EVIRF2r0gkxmflFKYIHgR1WfPtuUOOPkvlAIXF/8SsxgfXBRVRx1KJgYh5PVHtu9IXfk
 LLzkfIbmtnUnJDcBk9qmU9pwWSRWNZnefNM9yZBPdOIcXcXTEpSuHzVOJ16apdNzJ3IBNDCmZ
 W1tBDpN3xd3U9PgeY8lZ5uK+Jqy8MIzW8eTbksLGYFvwoapDy5dt+my3M88zDoV4GTr2tECNL
 ph+xGa/ZibeVGp5ov0ZWzYNa8x/5lnDN18nevow01hb06qlTIJocOS9AlK8EXceYn8mCOx1H4
 VZiXgXhe3irmFVyNtQZRsu/TQKfZAf7vm4UhY9LONEoBpEEIcC6XO9eUpK+CG/SjrvuDO0MsD
 E5k/S1jW5Yjf1KjPlzEyeXRV0bzCNhVN9oPLB4gp3RNddUBaVOeXKRr8WLB/lljTa804Bah68
 XvIm3cX324iFrtnN4Y1M8d7PoPrfaLhDdVBuSNS20tUC+xiqmNnCVAUioXvSE9SnKmtG7PYl0
 th/USxeOeRewandQjYsm1Jd339FbqrCJU2cTWpIxsp1EVdDzbKnFQ6BOxgcnwlert636FKIm4
 4raof7AQTIj3Pc5iuGYhvHiG+mQShtF50gqnrTq/KE/Oe+vfuV58nyYbMvXRfF6oLue6lbpOU
 LGXIm5F6KYktApoBfobFOLad6amBrHBJTFqgIww==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> kobject_init_and_add() takes reference even when it fails. If this
> function returns an error, kobject_put() must be called to properly
> clean up the memory associated with the object.

* An imperative wording can be preferred for the change description,
  can't it?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mess=
age?

Regards,
Markus
