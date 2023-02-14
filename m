Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B1AC61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjBNOtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 09:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjBNOtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 09:49:07 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82B24489
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 06:49:04 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230214144901euoutp0175512f85d45b2ef0e722d1dc22e922b6~DuFBCXrit1621916219euoutp01V
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 14:49:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230214144901euoutp0175512f85d45b2ef0e722d1dc22e922b6~DuFBCXrit1621916219euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676386141;
        bh=DAmnKmrJCyPJTKRLgPAbdTMzEBg/hV1XPlk1mxRm8/I=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Mx6raSFUi/zm6fz6XCP3gvhNBwlUBtZ/JrbjBaFuJLp9y8yW4TILdHbJrBoCPK/4B
         cvHEJulDGUHnBAtvmjPLI+x3vX6ikIP6Cg+UlLBWARPWyu8MaZkecD6Hj+FM6953az
         CgEn3z2/xiYTKZdu446Fq1JZbYbDAFG7CRCQqJVE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230214144900eucas1p26b1ec2a261157abd808a34b8a223b578~DuFAZApW63024930249eucas1p2R;
        Tue, 14 Feb 2023 14:49:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D1.B0.13597.C5F9BE36; Tue, 14
        Feb 2023 14:49:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230214144900eucas1p2269885f56ba7690207e0ea0300838f64~DuE-_-pu30518105181eucas1p24;
        Tue, 14 Feb 2023 14:49:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214144900eusmtrp27b4f4529361ddad7bfbe4e3efc5a4364~DuE-9mq8k1543215432eusmtrp2S;
        Tue, 14 Feb 2023 14:49:00 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-ca-63eb9f5c0583
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.99.02722.B5F9BE36; Tue, 14
        Feb 2023 14:48:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214144859eusmtip1d1416ec2cb6baef5258647150c99bf7b~DuE-0u1Qe1743817438eusmtip1Z;
        Tue, 14 Feb 2023 14:48:59 +0000 (GMT)
Received: from [192.168.1.19] (106.210.248.118) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 14 Feb 2023 14:48:57 +0000
Message-ID: <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
Date:   Tue, 14 Feb 2023 20:18:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.7.1
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <mcgrof@kernel.org>,
        <gost.dev@samsung.com>, <linux-block@vger.kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <Y+nwh7V5xehxMWDR@T590>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.118]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7ox818nG8zYL2Kx+m4/m8XK1UeZ
        LPbe0ra4MeEpo8Whyc1MDqwel8+Wemxa1cnmsftmA5vH+31X2Tw+b5ILYI3isklJzcksSy3S
        t0vgyjj3+g5LwXrJiiVrP7M2MK4U6mLk5JAQMJFY2LiTvYuRi0NIYAWjxKYre5khnC+MEjM6
        7rJCOJ8ZJR5fu8MC03L79hUwW0hgOaPE55VqcEWtE9ewQTi7GCVW9mwAq+IVsJPYseI2I4jN
        IqAq8f3VK6i4oMTJmU/AbFGBKIlTP18zgdjCAjYS6+bsYwaxRQSUJO7eXc0OYjMLFEqcWXcD
        yhaXuPVkPlA9BwebgJZEYydYmFNARWLJ9qdQJZoSrdt/Q9nyEtvfzmGGeEBZ4tSTB6wQdq3E
        qS23mEBulhB4wSExYXMHVJGLxL6W+4wQtrDEq+Nb2CFsGYn/O+czQdjVEk9v/GaGaG5hlOjf
        uZ4N5CAJAWuJvjM5EDWOEo3nnrBChPkkbrwVhLiHT2LStunMExhVZyGFxCwkn81C8sIsJC8s
        YGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZhuTv87/mUH4/JXH/UOMTJxMB5ilOBg
        VhLhFX76IlmINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QD
        E7cj94Vfchki0uY9xyatDG17kxN+qdpI/Adfq+B+cbnCcyf3nFdtzE9q3+ItVrfuTu8Osd2b
        dvJ3l7+Udnc86/7KKn2f0dJLWhrVuyeGneq5Yyavtzn5XILGMbf13RmiS8OrLY+XxPaum3d+
        1cbK9pXSzSW57iG2PJdnnost5u5Iqu2dsjePY+mv/yyTfjBH+jtnT1pXWXp4QhZH8flCVYua
        Wt4CJeb39ZzL6k/Pycqqr152pUni1hcN3ucb3/uv9H+V1mNqojdllf+6X0elRX5rLGyo+vov
        N8v5qtstr718St+iVl7hl+SZdGx2VgC7puDX/h6rckeJPWfaf5V/fx+eWPWs557Sz/st3auV
        WIozEg21mIuKEwH7HqlApgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7rR818nG7x+bmWx+m4/m8XK1UeZ
        LPbe0ra4MeEpo8Whyc1MDqwel8+Wemxa1cnmsftmA5vH+31X2Tw+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzj3+g5LwXrJiiVrP7M2
        MK4U6mLk5JAQMJG4ffsKSxcjF4eQwFJGiVXty5khEjISn658ZIewhSX+XOtiA7GFBD4ySvQv
        UoFo2MUosfXdFLAiXgE7iR0rbjOC2CwCqhLfX71igYgLSpyc+QTMFhWIkji9ch1YvbCAjcS6
        OfvAlokIKEncvbsaLM4sUChxZt0NdogFnxgl3rzfywKREJe49WQ+UxcjBwebgJZEYydYPaeA
        isSS7U+hejUlWrf/hrLlJba/nQP1jLLEqScPWCHsWonPf58xTmAUnYXkvFlINsxCMmoWklEL
        GFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbptmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8
        wk9fJAvxpiRWVqUW5ccXleakFh9iNAWG0URmKdHkfGCayCuJNzQzMDU0MbM0MLU0M1YS5/Us
        6EgUEkhPLEnNTk0tSC2C6WPi4JRqYNp2r3GmaUGhQ7hF7qkZp6/mp7xiOiT9M+e3s+Bfm6cS
        zU+V5eNle482fl1/t0hyQ+LswO3GmkHbbhXbhoievj49VPy82Ds763maSXLWRw/sa1OKmLLk
        +4W4HxPD+yNv+awQT2g29Sy5otpsrivLlvXYjVNQmcNopuiLx9tuPossct2zWHyn+f99N6r3
        216XTVDcXn9806V7wbZTlyp/e9kxTYHf2Xptd8Pl1Sy7fh1axesuITbn+uUzdX61iU2WlbbP
        Ck+vcDipfT+gy0/5617uo66zmXMSS31SP580fqP9pj/tdHC3ypRHVYZ8HE0rd7XYJvr72Jax
        Frg9CE7YqCY9+1LtOvXmVRLzxS5tUWIpzkg01GIuKk4EAEke+rNbAwAA
X-CMS-MailID: 20230214144900eucas1p2269885f56ba7690207e0ea0300838f64
X-Msg-Generator: CA
X-RootMTR: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
        <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
        <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 2023-02-13 13:40, Ming Lei wrote:
>>>
>>> Can you share perf data on other non-io_uring engine often used? The
>>> thing is that we still have lots of non-io_uring workloads, which can't
>>> be hurt now.
>>>
>> Sounds good. Does psync and libaio along with io_uring suffice?
> 
> Yeah, it should be enough.
>

Performance regression is noticed for libaio and psync. I did the same
tests on null_blk with bio and blk-mq backends, and noticed a similar pattern.

Should we add a module parameter to switch between bio and blk-mq back-end
in brd, similar to null_blk? The default option would be bio to avoid
regression on existing workloads.

There is a clear performance gain for some workloads with blk-mq support in
brd. Let me know your thoughts. See below the performance results.

Results for brd with --direct enabled:

+-----------+-----------+--------+--------+


| io_uring  | bio(base) | blk-mq | delta  |

+-----------+-----------+--------+--------+

|   read    |    189    |  449   | 137.57 |

| randread  |    182    |  419   | 130.22 |

|   write   |    442    |  425   | -3.85  |

| randwrite |    377    |  384   |  1.86  |

+-----------+-----------+--------+--------+

+-----------+-----------+--------+--------+

|  libaio   | bio(base) | blk-mq | delta  |

+-----------+-----------+--------+--------+

|   read    |    415    |  339   | -18.31 |

| randread  |    392    |  325   | -17.09 |

|   write   |    410    |  340   | -17.07 |

| randwrite |    371    |  318   | -14.29 |

+-----------+-----------+--------+--------+

+-----------+-----------+--------+--------+

|   psync   | bio(base) | blk-mq | delta  |

+-----------+-----------+--------+--------+

|   read    |    700    |  554   | -20.86 |

| randread  |    633    |  497   | -21.48 |

|   write   |    705    |  181   | -74.33 |

| randwrite |    598    |  169   | -71.74 |

+-----------+-----------+--------+--------+

Both libaio and psync results in performance regression with blk-mq based brd.

Results for memory-backed null_blk device with --direct enabled:

+-----------+-----------+--------+--------+
| io_uring  | bio(base) | blk-mq | delta  |
+-----------+-----------+--------+--------+
|   read    |    189    |  433   | 129.1  |
| randread  |    196    |  408   | 108.16 |
|   write   |    457    |  414   | -9.41  |
| randwrite |    356    |  350   | -1.69  |
+-----------+-----------+--------+--------+

+-----------+-----------+--------+--------+
|  libaio   | bio(base) | blk-mq | delta  |
+-----------+-----------+--------+--------+
|   read    |    406    |  341   | -16.01 |
| randread  |    378    |  320   | -15.34 |
|   write   |    404    |  331   | -18.07 |
| randwrite |    359    |  309   | -13.93 |
+-----------+-----------+--------+--------+

+-----------+-----------+--------+--------+
|   psync   | bio(base) | blk-mq | delta  |
+-----------+-----------+--------+--------+
|   read    |    684    |  522   | -23.68 |
| randread  |    605    |  470   | -22.31 |
|   write   |    676    |  139   | -79.44 |
| randwrite |    558    |  135   | -75.81 |
+-----------+-----------+--------+--------+

Regards,
Pankaj
