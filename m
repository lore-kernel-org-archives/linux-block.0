Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C9C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 10:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDLKe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLKe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 06:34:58 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A092D48
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 03:34:56 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230412103454epoutp03046f1962dbda7f3eea88a14f91ad4e5a~VKYahYtz51179511795epoutp03Z
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 10:34:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230412103454epoutp03046f1962dbda7f3eea88a14f91ad4e5a~VKYahYtz51179511795epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681295694;
        bh=Yn7yeXy86GFUgJ7re4bt9hFWl0Jn2pN7XmA2oyMgGJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Odk67QQoBzzSylbjc35bPgLa2/dt9D0CmBKmo8SEQr+YxSG6dMxzOB+/o9IA3YHcR
         Z+jEP7y4MBBAt+Kj+fSoE+I4p603agR4xrAg3EyajuvcBTyCq6dCD8szJoi0vo+6OI
         PCHBmMqlGHpM4QWf3Qq+q9q2ieTAN95I0tvAUyJY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230412103453epcas5p115c811bf1776fe46b10a849cf301f053~VKYaSiskB2889228892epcas5p1J;
        Wed, 12 Apr 2023 10:34:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PxJxS4dRFz4x9Pv; Wed, 12 Apr
        2023 10:34:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.08.09961.C4986346; Wed, 12 Apr 2023 19:34:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230412103025epcas5p383fbbe4036022d0e5a3d51495400a3ce~VKUgwqnMA0675206752epcas5p30;
        Wed, 12 Apr 2023 10:30:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230412103025epsmtrp2f195f4a9c6a11662ea92e7ab0883058c~VKUgv6LRx2219822198epsmtrp2H;
        Wed, 12 Apr 2023 10:30:25 +0000 (GMT)
X-AuditID: b6c32a49-52dfd700000026e9-80-6436894c5c76
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.1C.08609.14886346; Wed, 12 Apr 2023 19:30:25 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230412103023epsmtip2fd46eed87b913212d824f29f9623a6fa~VKUesMhx83131131311epsmtip2X;
        Wed, 12 Apr 2023 10:30:23 +0000 (GMT)
Date:   Wed, 12 Apr 2023 15:59:39 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, shinichiro.kawasaki@wdc.com,
        error27@gmail.com
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
Message-ID: <20230412102939.ysbw7lhgrnrxgc6n@green5>
MIME-Version: 1.0
In-Reply-To: <8e239f96-8578-c40c-f6b1-b62cff102eb0@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmuq5Pp1mKwdE/ihar7/azWUz78JPZ
        4sF+e4tHy/ws/nbdY7J4enUWk8XeW9oW+2Z5Wjzu7mB04PS4fMXbY+esu+wel8+Wemxa1cnm
        0dv8js2jb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gBdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQ
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzrh7r5uloI+jYmFHE3MD4yu2LkZODgkBE4mLJ68wdzFy
        cQgJ7GaU2NKwigkkISTwiVGi91cSROIzo8S87g6WLkYOsI5Vp2Qg4rsYJSb0HILqfsIoMeXb
        B3aQbhYBVYmVTSeZQRrYBLQlTv/nAAmLCKhLTJ28hxGknlngIqPEm8VHwc4QFnCQWNn+CGwz
        L9CCt4cg4rwCghInZz5hAbE5BewkFn9aygpiiwrISMxY+hVssYTATA6Jh/+nQ/3jIrGuZT07
        hC0s8er4FihbSuLzu71QNeUSK6esYINobmGUmHV9FiNEwl6i9VQ/2NXMAukS7yZGQIRlJaae
        Wgd2HLMAn0Tv7ydMEHFeiR3zYGxliTXrF0DNl5S49r2RDRJaHhJH/llDQvQpo8TSXdITGOVn
        IXltFsKyWWALrCQ6PzSxQoSlJZb/44AwNSXW79JfwMi6ilEytaA4Nz212LTAMC+1HB7byfm5
        mxjBqVbLcwfj3Qcf9A4xMnEwHmKU4GBWEuH94WKaIsSbklhZlVqUH19UmpNafIjRFBhTE5ml
        RJPzgck+ryTe0MTSwMTMzMzE0tjMUEmcV932ZLKQQHpiSWp2ampBahFMHxMHp1QDE8Pdy21B
        h9uPJu6Prc2eaiXifnihUs8Oi03bv2wV2/5lrsU8jUnHNcys5ucts37znK1Y+FX8lWD/w6fC
        f0ootugumG9WXKfHYXT359wqx2n2/paC1+tVjmskhLkLqxmbvzr3yaBB9OxPt1Mz/4Tw17Zu
        X8yy8Ey2+Z8ytzTPKZcfFdvmno46uyXn+Y4fL5l3Loi5v7020CI6g+XwzvN3b97Vb73yJK5N
        dB6L5merzVbhp5W92ZUSjiULh+TuU15x3FZ75l8u4cPfPOROnCiarG+UWlhW+3FfqOCkTya1
        rrs8fM7/mcknOnP/uSqn7fZS5885zMz3Lpzpdu1mR+rW+3lap9sOuK66srx7e5S7jxJLcUai
        oRZzUXEiACO+DF4+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK5jh1mKwdsPBhar7/azWUz78JPZ
        4sF+e4tHy/ws/nbdY7J4enUWk8XeW9oW+2Z5Wjzu7mB04PS4fMXbY+esu+wel8+Wemxa1cnm
        0dv8js2jb8sqRo/Pm+Q82g90MwVwRHHZpKTmZJalFunbJXBl9E2JKjjMWvGyvZWlgXEnSxcj
        B4eEgInEqlMyXYxcHEICOxglJlzZyNjFyAkUl5RY9vcIM4QtLLHy33N2iKJHjBKb1p9nAUmw
        CKhKrGw6yQwyiE1AW+L0fw6QsIiAusTUyXsYQeqZBS4zSnxq/gI2SFjAQWJl+yMmEJsXaPHb
        Q0fZIIY+ZZS48v8PVEJQ4uTMJ2ALmAXMJOZtfgi2gFlAWmL5P7AFnAJ2Eos/LWUFsUUFZCRm
        LP3KPIFRcBaS7llIumchdC9gZF7FKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcJ1pa
        Oxj3rPqgd4iRiYPxEKMEB7OSCO8PF9MUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmk
        J5akZqemFqQWwWSZODilGpg0HHdPMjKZv4g1TGvq0c17XY9vEeLbzBm05cLs2RITX6Z6sc2u
        Nt4uuVS35FX9aivnIykp4fJzphjvOdB8Q2DPnQmvts+01o6P6v43m1lwywlD/WCGVLeUFvbd
        j51DTi78XqZRwOS89/aChD6tR5u/VC6udTFgXj2vfybztW9C+5Q1d2/4/kjHUPYA66tvlxbo
        HxDlYnV5csHM9URuQFDYKeYtrVrz9F+4+LxLjn7rNuNLxIbwBc0OX7JK8xnY6kzS/7254jal
        xTWn3yub2+9C0K+fYWuNl3zn458g8m1ulaOb6AeT2DTf91vZ395uUjH5/jjWRmfKy5iT0y4W
        lFfdO2as4iDKPSMjuMj+UIgSS3FGoqEWc1FxIgDJSDq7AgMAAA==
X-CMS-MailID: 20230412103025epcas5p383fbbe4036022d0e5a3d51495400a3ce
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_f670_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412091807epcas5p10b99767a999ded5789cb8ffce2189394
References: <20230412040827.8082-1-kch@nvidia.com>
        <CGME20230412091807epcas5p10b99767a999ded5789cb8ffce2189394@epcas5p1.samsung.com>
        <20230412091716.unhpznj4gzjjfehj@green5>
        <8e239f96-8578-c40c-f6b1-b62cff102eb0@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_f670_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/04/12 06:43PM, Damien Le Moal wrote:
>On 4/12/23 18:17, Nitesh Shetty wrote:
>> On 23/04/11 09:08PM, Chaitanya Kulkarni wrote:
>>> Make sure to check device queue mode in the null_validate_conf()
>>> and return error for NULL_Q_RQ as we don't allow legacy I/O path,
>>
>> Can't we do away with NULL_Q_RQ defination itself ?
>> I mean, since I see in code we are not using NULL_Q_RQ anywhere,
>> if we can remove NULL_Q_RQ defination from enum in null_blk.h,
>> we can remove your suggested check, as well as check in null_init.
>
>I think it is being kept around to avoid reusing this value to not confuse old
>scripts.
>
got it.

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>


------DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_f670_
Content-Type: text/plain; charset="utf-8"


------DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_f670_--
