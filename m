Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2EC433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 00:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C4613B0
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 00:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhD0Arn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 20:47:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49076 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0Arm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 20:47:42 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210427004657epoutp015fa5e7f4803528ff9e37403bc68935cb~5kH9tg0kl3097430974epoutp01f
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 00:46:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210427004657epoutp015fa5e7f4803528ff9e37403bc68935cb~5kH9tg0kl3097430974epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619484418;
        bh=NjuDzIdfAuMuHKLAMPMS+ABy6+7SNPP0KjG3H0dvvW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWFD6tsadYUU9YtkdGZNZI94NMyHQYYgZ+cTgXibo1Wy+paYYDi8iw9IQRe2K97TN
         u3fuk3IAkOKVEAVqeu/QdEzGkbxuR/kbg71hIhqcJAAzINAutYMaa25lcNvm0yQphY
         KRbUyGTexZV8Q903Inj9+qdkT/mOqYWFGv45Mk28=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210427004657epcas1p2e9dd3f2c703bf650db073a972d28f9ba~5kH9RHto53142431424epcas1p2D;
        Tue, 27 Apr 2021 00:46:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FTjl3684yz4x9Pw; Tue, 27 Apr
        2021 00:46:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.9A.09578.FFE57806; Tue, 27 Apr 2021 09:46:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210427004655epcas1p15cc4b2be6312c4762272474908607722~5kH7Y3RJQ0377203772epcas1p1g;
        Tue, 27 Apr 2021 00:46:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210427004655epsmtrp26600d46d9e39b236c39531417fba29d6~5kH7YA2RR3022130221epsmtrp2k;
        Tue, 27 Apr 2021 00:46:55 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-80-60875effa2f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.CE.08163.FFE57806; Tue, 27 Apr 2021 09:46:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210427004655epsmtip1efc88fae084edca9407108dbdde37d6d~5kH7KyS4N1960419604epsmtip1b;
        Tue, 27 Apr 2021 00:46:55 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, nanich.lee@samsung.com, yi.zhang@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Tue, 27 Apr 2021 09:28:57 +0900
Message-Id: <20210427002857.8038-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <34286266-1c03-35bc-94e8-08bd0ac3400a@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmnu7/uPYEgy9LDCxW3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4dv8Mu8X1c9PYHDg9Ll/x9rh8ttRj06pONo/d
        NxvYPN7vu8rm0bdlFaPH501yAexROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQr0
        ihNzi0vz0vWS83OtDA0MjEyBKhNyMh5eesNWsIW9ov9nO2MD4y/WLkZODgkBE4nL+54C2Vwc
        QgI7GCVeb1vEDOF8YpS49PYklPOZUeJew0RmuJZpz6BadjFKHN+ygxGuasa5V4wgVWwCOhJ9
        b2+xgdgiAmISl798AytiFljNKNF6cztYQljARmL5y13sIDaLgKrE3rn3wJp5BawkWjqns0Cs
        k5f4c78HbDWngLXEzXM7mSFqBCVOznwCVsMMVNO8dTbYrRICjRwS29v7od5zkeiZ/JURwhaW
        eHV8CzuELSXx+d1eNoiGbkaJ5rb5jBDOBEaJJc+XMUFUGUt8+vwZKMEBtEJTYv0ufYiwosTO
        33MZITbzSbz72sMKUiIhwCvR0SYEUaIicablPjPMrudrd0JN9JBYd/YmNFD7GCUunOhimsCo
        MAvJQ7OQPDQLYfMCRuZVjGKpBcW56anFhgWGyLG8iRGcWLVMdzBOfPtB7xAjEwfjIUYJDmYl
        EV62Xa0JQrwpiZVVqUX58UWlOanFhxhNgcE9kVlKNDkfmNrzSuINTY2MjY0tTMzMzUyNlcR5
        052rE4QE0hNLUrNTUwtSi2D6mDg4pRqYvJkXy31sj1ng3aP885HMjyUrZ0lPdb9x4ycn96ra
        +QbzV/G5L48w/5/454p28KUjD6++PhH4o+D5dFeVG7v02uq05Vi/RF5q3jtP6GGro8qie1cM
        b1z8vyj2mWXRy87lazat582MqfmX/P+Gyqrgf+K83k8bSnREHpVGdroqBTxsmHloporD36+a
        ATO3xT69oZc6lXXrXTvjm69Drjb9jo/bmpuTrMv2/cAxl5PfMlZLxrRNTp5us/Wjh3ty3IE7
        AiEvHuznDWid2y3lNlvt5Km8r8XFbbN/BHV7feKMWTr780PFmRqyvBo/l8zi8f47qy2nwYrH
        cvMKM/P1N01Z96RMX9/gEzF7m/GN0Lp9mUosxRmJhlrMRcWJAEQTnZY1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnO7/uPYEg4adEhar7/azWey6OJ/R
        YtqHn8wWK1cfZbJ4sn4Ws8XeW9oWhyY3M1lcu3+G3eL6uWlsDpwel694e1w+W+qxaVUnm8fu
        mw1sHu/3XWXz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroyHl96wFWxhr+j/2c7YwPiLtYuR
        k0NCwETi8rRnQDYXh5DADkaJ86v3sEEkpCSOn3gLlOAAsoUlDh8uhqj5yCjx8+EDsBo2AR2J
        vre3wGwRATGJy1++MYIUMQtsZZR4+28pI0hCWMBGYvnLXewgNouAqsTeuffA4rwCVhItndNZ
        IJbJS/y538MMYnMKWEvcPLcTzBYCqrnbM5MFol5Q4uTMJ2A2M1B989bZzBMYBWYhSc1CklrA
        yLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM48LW0djDuWfVB7xAjEwfjIUYJDmYl
        EV62Xa0JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAF
        7dZjX1XKdk99CeOHhvu7pRiqtkdfjBLYq9nKa/bxVczFwx/6LkVPTM9MZZbQS3e9wRm8L3PD
        lkur5+xc4RllNiuC+6Dhtj2NUUVs17Y9L7XeOSdpi4J+dmHx9m//mNmlYu/fcp91LeBmMEPg
        68UHz+vG7ZQ+tet59opTn+xaiyfyLTA/dvJPd/qnpZmcszrNjU8++swYVnGj34r3WOLCxqIX
        THMez28vbjuS2rPwyyf2rl3Nfwqn2bhptmav3vTosk5dhX1wQdKBX+1pNwr3yE7jqWL4m/5B
        bRq76/mNB2ZY2yVfkJre1VVWejLfmTNf/MrjQ2WW1auye2pdeSe+X5F3ZNmpVvnYbCe5M7uU
        WIozEg21mIuKEwEEC09X6wIAAA==
X-CMS-MailID: 20210427004655epcas1p15cc4b2be6312c4762272474908607722
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210427004655epcas1p15cc4b2be6312c4762272474908607722
References: <34286266-1c03-35bc-94e8-08bd0ac3400a@acm.org>
        <CGME20210427004655epcas1p15cc4b2be6312c4762272474908607722@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/26/21 1:34 AM, Changheun Lee wrote:
> > Should we check queue point in bio_max_size()?
> > __device_add_disk() can be called with "register_queue=false" like as
> > device_add_disk_no_queue_reg(). How about below?
> > 
> > unsigned int bio_max_size(struct bio *bio)
> > {
> > 	struct request_queue *q;
> > 
> > 	q = (bio->bi_bdev) ? bio->bi_bdev->bd_disk->queue : NULL;
> > 	return q ? q->limits.bio_max_bytes : UINT_MAX;
> > }
> 
> How could bio_max_size() get called from inside __device_add_disk() if
> no request queue is registered? Did I perhaps miss something?
> 
> Thanks,
> 
> Bart.

__device_add_disk() do not call bio_max_size(). I just imagined bio
operation on disk without request queue. Disk can be added without queue via
device_add_disk_no_queue_reg(). It might be my miss-understood about it.
I didn't check bio operation is possible on disk without request queue yet. 

Thanks,

Changheun Lee.
