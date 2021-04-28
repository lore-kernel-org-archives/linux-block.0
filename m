Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D5C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 07:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501DD613FA
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 07:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhD1HkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:40:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:18076 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbhD1HkM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 03:40:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210428073925epoutp0141eea46d489f71d128375b40510f03c9~59ZXmzVM60244202442epoutp01U
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 07:39:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210428073925epoutp0141eea46d489f71d128375b40510f03c9~59ZXmzVM60244202442epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619595565;
        bh=iFM6Dwx1CMc33eDLPWgavRep4Oc9OM1v/W86z0HSfpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJUhIwSsC+W1RLCNu+FkDecSvAKDxIg2EYNWupHx5CIbgKdnb5winpqnEreAkW4Ay
         4rWDDXNNvXZ0F1N8k+whCmfj58g9h/Z/0ylOj8jsG9MwfChpq5HT68JlSPW4kPFJqM
         91ZPTht+rTa1L+eUROjjAUaalC2lO2Kg8RtbLW/U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210428073924epcas1p1ebbcc37c8f03f2a351da491f340079e5~59ZXFhkUK2201522015epcas1p1Y;
        Wed, 28 Apr 2021 07:39:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FVVrW2bnQz4x9Pr; Wed, 28 Apr
        2021 07:39:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.D1.10258.A2119806; Wed, 28 Apr 2021 16:39:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210428073921epcas1p2b161b5ccc9d7ec61c1200155da95c5b9~59ZUosvfp2212122121epcas1p2Q;
        Wed, 28 Apr 2021 07:39:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210428073921epsmtrp1c9a22191134d9ec4f4559cbe07c4fc41~59ZUnYLe92111421114epsmtrp1I;
        Wed, 28 Apr 2021 07:39:21 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-7c-6089112a221c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.E8.08637.92119806; Wed, 28 Apr 2021 16:39:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210428073921epsmtip2de0ad497b0bb40465ff792fed199fad8~59ZUYuk-W0132501325epsmtip2a;
        Wed, 28 Apr 2021 07:39:21 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, nanich.lee@samsung.com, yi.zhang@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Wed, 28 Apr 2021 16:21:23 +0900
Message-Id: <20210428072123.3155-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <c5f47617-f06a-d598-1794-118447e8e2b0@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmvq6WYGeCwYZ/4har7/azWey6OJ/R
        YtqHn8wWK1cfZbJ4sn4Ws8XeW9oWhyY3M1lcu3+G3eL6uWlsDpwel694e1w+W+qxaVUnm8fu
        mw1sHu/3XWXz6NuyitHj8ya5APaoHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
        JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6
        xYm5xaV56XrJ+blWhgYGRqZAlQk5Gc83b2MpOMdZseXpY8YGxpvsXYycHBICJhJtPxYD2Vwc
        QgI7GCWmX9zBBJIQEvjEKNH/zAAi8Y1RYua6kywwHf/O3YQq2ssosXGXEkTRZ0aJKdP3sYIk
        2AR0JPre3mIDsUUExCQuf/nGCFLELLCaUaL15nawhLCAjcTyl7vA7mARUJXYM20rWJxXwEpi
        +evZrBDb5CX+3O9h7mLk4OAUsJY41h0GUSIocXLmE7CDmIFKmrfOZoYob+SQWLxaDMJ2kfi3
        6wdUXFji1fEtUC9LSbzsbwN7WUKgm1GiuW0+I4QzgVFiyfNlTBBVxhKfPn9mBFnMLKApsX6X
        PkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGRONNynxlm1/O1O6EmekjseHWMDRJYfYwS
        T5cuZJ/AqDALyT+zkPwzC2HzAkbmVYxiqQXFuempxYYFJsgxvIkRnFC1LHYwzn37Qe8QIxMH
        4yFGCQ5mJRFetl2tCUK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5jS80riDU2NjI2NLUzM
        zM1MjZXEedOdqxOEBNITS1KzU1MLUotg+pg4OKUamBj6Pm85kufevpDtu2gNe3d14Pv3H48k
        3TYO9FhpfW6WvOHMBcITBLn7E1VqfrObl4e4s58154v5X9TpIbRiBevud7H/uTkuGwmKlLz+
        mNx6Z03nxx8vq+y0Tk3buOPz1LOGUYHmOqV/7Z4vtPZNezd7U14pw5Wnu92mBNxmcs3Ni7x6
        6tKP7Gn+0a/239Bw45N5rv9fN2hrVV/pnbPRup9ll8c+lP1ae1Z28eYp51zuh8QnhTnL5v4u
        6L8zN1sg9kqz+mu35t+/jDojHf/Evkmx8Px8RXGr5MUuJb2ZP77bvOzl9yt6uC9ohsoxHSP5
        jTc/HroQ7XVK8JerRVLF0q7/ujdE+m16Xf7H/Lj6X4mlOCPRUIu5qDgRAPk2qdIxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvK6mYGeCwbluU4vVd/vZLHZdnM9o
        Me3DT2aLlauPMlk8WT+L2WLvLW2LQ5ObmSyu3T/DbnH93DQ2B06Py1e8PS6fLfXYtKqTzWP3
        zQY2j/f7rrJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bzzdtYCs5xVmx5+pixgfEmexcj
        J4eEgInEv3M3mUBsIYHdjBL3V9pDxKUkjp94y9rFyAFkC0scPlwMUfKRUeLiWW8Qm01AR6Lv
        7S02EFtEQEzi8pdvjF2MXBzMAlsZJd7+W8oIkhAWsJFY/nIX2C4WAVWJPdO2gjXwClhJLH89
        mxVil7zEn/s9zCC7OAWsJY51h0HsspLY0drPCFEuKHFy5hMWEJsZqLx562zmCYwCs5CkZiFJ
        LWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzyWpo7GLev+qB3iJGJg/EQowQH
        s5IIL9uu1gQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUa
        mKSyTbzEg1ZJ/LxeufjUpRm5uX3Wm03tvx1wlZu/2ZRne6fNQ//YTZ23Au+9+8z2IGHJt9Ws
        sw3OiBUqSrVv9dpqOXfDvb1F6guuKmhafVYwvu47pdlIwiXs8seuKbOfKT+yWGGzTXZ55NzJ
        Jt8XnNFV+Ry0dFbLvpbErusFHr+v1YW8lzXOrFbbpSfOxOPOnOTHtNPs2MGVv69cz1/lphC0
        YOF+faZqTtHnjU4LLALVM2X83648fW7GJ24bhSZ9oxvF6Tz9Bg83WlVZ7LqfW1P/aV5gbYnM
        O9tvrxXs6zVYHooLqsX+2vGyrWq/dkaW7a930/8cMnNSTzh9fdtN1e0dMvXVZa7PWlUaLn5a
        psRSnJFoqMVcVJwIAHb0ciToAgAA
X-CMS-MailID: 20210428073921epcas1p2b161b5ccc9d7ec61c1200155da95c5b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210428073921epcas1p2b161b5ccc9d7ec61c1200155da95c5b9
References: <c5f47617-f06a-d598-1794-118447e8e2b0@acm.org>
        <CGME20210428073921epcas1p2b161b5ccc9d7ec61c1200155da95c5b9@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/26/21 9:12 PM, Changheun Lee wrote:
> > Actually I checked "bio->bi_disk" at first as below. It works well.
> 
> Agreed that the bi_disk pointer needs to be checked.
> 
> > I think "bi_bdev->bd_disk" checking might be needed too.
> 
> bio_max_size() occurs in the hot path. Since if-tests have a runtime
> cost I'd like to keep the number of if-tests inside bio_max_size() to a
> minimum.
> 
> I only found one bd_disk assignment in the kernel tree, namely inside
> bdev_alloc(). The two bdev_alloc() calls I found inside the kernel tree
> pass a valid disk pointer to bdev_alloc(). So I think it is not
> necessary to check the disk pointer inside bio_max_size().
> 
> Thanks,
> 
> Bart.

I think bio->bi_bdev should be null in bio_copy_kern(), or bio_map_kern()
logically. Because it is simple buffer mapping in driver layer. Actually
bio->bi_bdev is null in my test environment. So bio->bi_bdev check only is
enough as Bart's patch.

Actually I don't know why NULL pointer dereference is occurred with Bart's
patch in blk_rq_map_kern(). And same problem have not occured yet in my
test environment with Bart's patch.
Maybe I missed something, or missunderstood?

Thanks,

Changheun Lee.
