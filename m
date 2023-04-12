Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439F7C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 09:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDLJTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLJTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 05:19:07 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6472AE
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 02:19:05 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230412091903epoutp04f0033359f52a54853761570cddb0d62f~VJWL-cd9g1026210262epoutp04P
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 09:19:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230412091903epoutp04f0033359f52a54853761570cddb0d62f~VJWL-cd9g1026210262epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681291143;
        bh=hfVWTHc1u5tpka5GeJp7k3uPokqPgaMdV9GjoEg7PJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmN+WBE1Esny7kHuGTbS47PaMTEMVrh8S6BVxQoxXB7+rJPQpmitPfLHp2YUwpede
         HDizQIB1xdZ7flkWu1iQYVsw/JT0vHA37yDSqq1TzvceHxpU+THu+hSgCf6CxNyPsq
         g+nd9/OLi5Y8XO1fJNhfjJ1+WN0Ki7outdO9F6U4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230412091902epcas5p1538da73f153f23502f45f12309707a08~VJWLldY5U0275402754epcas5p16;
        Wed, 12 Apr 2023 09:19:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PxHFx1bwHz4x9Pt; Wed, 12 Apr
        2023 09:19:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.75.09961.48776346; Wed, 12 Apr 2023 18:19:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230412091807epcas5p10b99767a999ded5789cb8ffce2189394~VJVYDjjT70272202722epcas5p1Q;
        Wed, 12 Apr 2023 09:18:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230412091807epsmtrp29a5439d60f979985ae3ddf317b52c079~VJVYC4ef01082310823epsmtrp2f;
        Wed, 12 Apr 2023 09:18:07 +0000 (GMT)
X-AuditID: b6c32a49-2c1ff700000026e9-5c-6436778429a9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.03.08279.F4776346; Wed, 12 Apr 2023 18:18:07 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230412091805epsmtip2005a1fa690319c52b6b1602dd323f771~VJVWYKoYL2647926479epsmtip2W;
        Wed, 12 Apr 2023 09:18:05 +0000 (GMT)
Date:   Wed, 12 Apr 2023 14:47:16 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, dlemoal@kernel.org,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, shinichiro.kawasaki@wdc.com,
        error27@gmail.com
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
Message-ID: <20230412091716.unhpznj4gzjjfehj@green5>
MIME-Version: 1.0
In-Reply-To: <20230412040827.8082-1-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmpm5LuVmKwcIlphar7/azWUz78JPZ
        4sF+e4tHy/ws/nbdY7J4enUWk8XeW9oW+2Z5Wjzu7mB04PS4fMXbY+esu+wel8+Wemxa1cnm
        0dv8js2jb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gBdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQ
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzjgzbQp7wSS2ip0HExoYF7F2MXJySAiYSJxf/Ja5i5GL
        Q0hgN6PEmiNzoJxPjBIfr9xmhHC+MUqcuNDOAtMy+dgjqKq9jBKL5u1ng3CeMErM2buJEaSK
        RUBV4tv7a0BVHBxsAtoSp/9zgIRFBNQlph7oYQWpZxY4wCix+eUnNpCEsICDxMr2R0wgNi/Q
        ho5zx1khbEGJkzOfgG3mFDCWuPRoBVi9qICMxIylX8GukBCYyiFx/fZaqI9cJPq+LmCCsIUl
        Xh3fwg5hS0l8freXDcIul1g5ZQUbRHMLo8Ss67MYIRL2Eq2n+plBbGaBdImbB5dANctKTD21
        jgkizifR+/sJ1AJeiR3zYGxliTXrF0AtkJS49r2RDeR7CQEPiSP/rCEh1MYosXNJA+sERvlZ
        SJ6bhWQdhG0l0fmhiXUWUDuzgLTE8n8cEKamxPpd+gsYWVcxSqYWFOempxabFhjmpZbDYzw5
        P3cTIzjlannuYLz74IPeIUYmDsZDjBIczEoivD9cTFOEeFMSK6tSi/Lji0pzUosPMZoCI2si
        s5Rocj4w6eeVxBuaWBqYmJmZmVgamxkqifOq255MFhJITyxJzU5NLUgtgulj4uCUamCSbOUz
        //u+b4f8tOhKK6Xf8vMOFDTIPJaJsjrKz2l9cirjqrvXtLz2TDE4ySLKe3B39QfL9unNPVOv
        ZyRfSJ1hGfrvdJgOV/gTGZ9TS1WmcHopa4j+CBHJUvjdULH57B+tyLMsDl98m1yNFmmKB+QZ
        Lq5yC7XNuOeSfSX+0s4T+7m2MKuv/bxp6puDP25Nbunf/9QsMX7xwVkJG/7FPF+/IPhh6EPR
        K00f2hnlbeYuXHDOqivxnX38pYznP8+p/3h4K3pB1Kfk80vuGJ7W8l/tKuCgH21syyHwYTuX
        dInimVUKvD4be288X9WWENTUv17vq26K9XaVnSXXSp8qiygzHt1ddEjKOPs8z/UJDspKLMUZ
        iYZazEXFiQChDMDgQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvK5/uVmKwZ33XBar7/azWUz78JPZ
        4sF+e4tHy/ws/nbdY7J4enUWk8XeW9oW+2Z5Wjzu7mB04PS4fMXbY+esu+wel8+Wemxa1cnm
        0dv8js2jb8sqRo/Pm+Q82g90MwVwRHHZpKTmZJalFunbJXBlNP9+ylxwnLlixaNGxgbGj0xd
        jJwcEgImEpOPPWLuYuTiEBLYzSixe/sZZoiEpMSyv0egbGGJlf+es0MUPWKUWPB7EgtIgkVA
        VeLb+2tARRwcbALaEqf/c4CERQTUJaYe6GEFqWcWOMQosa6zjxUkISzgILGy/RHYZl6gzR3n
        joPFhQSMJG7t7GKDiAtKnJz5BGw+s4CZxLzND8HmMwtISyz/BzafU8BY4tKjFWDlogIyEjOW
        fmWewCg4C0n3LCTdsxC6FzAyr2KUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4ULc0d
        jNtXfdA7xMjEwQh0PgezkgjvDxfTFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYombpzkxLCPz39cGNF3Picv9UGEx6IFfp2bhmp0nMnV0vmqdWBNmu
        jjcImv3/0d+sB69fT9vaFDSjMOHxZ+X3O6a8Mp+olP79w48aI6uTEdMnsHI/yUpLYfCbFv2B
        /eKm+W/s1nPLlksGvtwz227eO7bApyckg+69nTCt3IBvZs+sC4UO8o9+VPQvLfpWz79vl0tW
        66+FQgtebbIL0ouY/ffAc+kG7UfJ5251Tt37omLaVLVpx1+/N/LPDDJjSvm3Ss0llqOCjzVO
        0Tqwanez7P2DfPutfnbcf/yHm+WgcrvOBmm+a+s/FXOrHgl4JaSQLlAhwsvmbDE7vOQfjwiD
        kkP/0w27+L7v+xZdxTzlmBJLcUaioRZzUXEiAF47+hkDAwAA
X-CMS-MailID: 20230412091807epcas5p10b99767a999ded5789cb8ffce2189394
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_f32b_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412091807epcas5p10b99767a999ded5789cb8ffce2189394
References: <20230412040827.8082-1-kch@nvidia.com>
        <CGME20230412091807epcas5p10b99767a999ded5789cb8ffce2189394@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_f32b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/04/11 09:08PM, Chaitanya Kulkarni wrote:
>Make sure to check device queue mode in the null_validate_conf()
>and return error for NULL_Q_RQ as we don't allow legacy I/O path,

Can't we do away with NULL_Q_RQ defination itself ?
I mean, since I see in code we are not using NULL_Q_RQ anywhere,
if we can remove NULL_Q_RQ defination from enum in null_blk.h,
we can remove your suggested check, as well as check in null_init.

--Nitesh Shetty

------w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_f32b_
Content-Type: text/plain; charset="utf-8"


------w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_f32b_--
