Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10224C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AC620760
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZxzID+TC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgGANBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:01:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57271 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgGANBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 09:01:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200701130104euoutp02cdea5f41e1be3eda55a9be249f951f9f~donSdFEYF0981509815euoutp02U
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 13:01:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200701130104euoutp02cdea5f41e1be3eda55a9be249f951f9f~donSdFEYF0981509815euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593608464;
        bh=r/E1oU7RIun0yg59DioVeLS5x/0E3FPvydGtzqbYN1A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZxzID+TC3k5dJ7pN5OBfnfO/qUalnXOxnoJlf/eDLfvVrj0Dh5N5MJcPIL0nFbpbk
         tv2AR1NWdSh1M7cYQAzNbMjErBNDzdy9ONlO5EH5lbLP+z2VbbSr4tLMA24gPvqA6z
         wiStFCombW/UmS/J6AIjvL5rcuZW60ohARzIy8H0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200701130104eucas1p2dc7082bf46a607cb0dcc03a7e9c3d0ce~donSPYP0o1720317203eucas1p2-;
        Wed,  1 Jul 2020 13:01:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 09.1C.06318.0198CFE5; Wed,  1
        Jul 2020 14:01:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e~donR3tdKg0178401784eucas1p1P;
        Wed,  1 Jul 2020 13:01:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200701130104eusmtrp268f07dbd360a11e2865f077fa21344cb~donR3H41z2228722287eusmtrp2A;
        Wed,  1 Jul 2020 13:01:04 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-54-5efc8910336c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.67.06314.0198CFE5; Wed,  1
        Jul 2020 14:01:04 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200701130103eusmtip25c8aff9e6009f7a2ff120c948b219248~donRjKXxU2188521885eusmtip2M;
        Wed,  1 Jul 2020 13:01:03 +0000 (GMT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
Date:   Wed, 1 Jul 2020 15:01:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629094759.2002708-1-ming.lei@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87oCnX/iDB5/U7FYfbefzWLjjPWs
        FitXH2Wy2HtL2+LQ5GYmB1aPy2dLPXbfbGDzeL/vKptH35ZVjB6fN8kFsEZx2aSk5mSWpRbp
        2yVwZXy4vZy14Bx7xbTOr2wNjB1sXYycHBICJhLr1q4Csrk4hARWMErMmLkNyvnCKLH09BN2
        COczo8SVtheMMC0rJ75lhUgsZ5Q4uO8SC0hCSOA9o8TzXXEgtrCAl8SiQz/A4iICDhLr3neA
        NTMLlEu86H8BFmcTMJToetsFdgevgJ3Ew4MXwGwWARWJI3+ng9WICsRK9C1dAFUjKHFy5hOg
        OAcHp4C1xMr7WRAj5SW2v53DDGGLS9x6Mp8J5DYJgXnsEmvPNbBAHO0isfvMMSYIW1ji1fEt
        7BC2jMT/nTANzYwSD8+tZYdwehglLjfNgHrZWuLOuV9sIJuZBTQl1u/Shwg7SjR9PcYIEpYQ
        4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJGYdXwe39uCFS8wTGJVmIflsFpJ3ZiF5ZxbC3gWM
        LKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU83pf8e/7mDc9yfpEKMAB6MSD29GxZ84
        IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7
        NbUgtQgmy8TBKdXAOHPbtu+ZeWcexq87sekjQ803NrfLtdnN6s9N7C4+3mPgLWz99vicCuem
        CPmAfTtcTj6123l/kvhnplPit0LPnlbXjvAXfJVeHNHapfPg492JfhHsrHszYppXev/fKr3F
        f97DPV2fn+9W8utc9uDtKTaN5Zu2HBH417Vm2ZlJ67Ufi+zorfngq6LEUpyRaKjFXFScCAA1
        MydsMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7oCnX/iDD5s47NYfbefzWLjjPWs
        FitXH2Wy2HtL2+LQ5GYmB1aPy2dLPXbfbGDzeL/vKptH35ZVjB6fN8kFsEbp2RTll5akKmTk
        F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXy4vZy14Bx7xbTOr2wN
        jB1sXYycHBICJhIrJ75lBbGFBJYySkx8mQ8Rl5E4Oa2BFcIWlvhzrQuonguo5i2jxMZ1v9lB
        EsICXhKLDv1gAbFFBBwk1r3vYOxi5OBgFiiXWNDvADHTSuLnjyawOWwChhJdb7vA9vIK2Ek8
        PHgBzGYRUJE48nc62BhRgViJb/e2QNUISpyc+YQFZCSngLXEyvtZIGFmATOJeZsfMkPY8hLb
        386BssUlbj2ZzzSBUWgWku5ZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxN
        jMC42nbs5+YdjJc2Bh9iFOBgVOLhzaj4EyfEmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8
        +KLSnNTiQ4ymQL9NZJYSTc4HxnxeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILU
        Ipg+Jg5OqQZGlRvRTEEHpVoWWvSUCXNf3VRvL/tqu+IKF++Qu12FLBzF0jf2s5sIzBbKK1y+
        4Kve0nsPVI23Te162fidbfLLoNMr+H0Y1bqFd0X5WakL62evd9qfJT1db+HlHVUSWQ9zf643
        WVwfdvfsV/VExq6j020XRcUpR1xd8fBh8UGr2NsPUycz1vkqsRRnJBpqMRcVJwIA69y7ssEC
        AAA=
X-CMS-MailID: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
References: <20200629094759.2002708-1-ming.lei@redhat.com>
        <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

On 29.06.2020 11:47, Ming Lei wrote:
> It is natural to release driver tag when this request is completed by
> LLD or device since its purpose is for LLD use.
>
> One big benefit is that the released tag can be re-used quicker since
> bio_endio() may take too long.
>
> Meantime we don't need to release driver tag for flush request.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

This patch landed recently in linux-next as commit 36a3df5a4574. Sadly 
it causes a regression on one of my test systems (ARM 32bit, Samsung 
Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine 
and then after a few seconds every executed command hangs. No 
panic/ops/any other message. I will try to provide more information asap 
I find something to share. Simple reverting it in linux-next is not 
possible due to dependencies.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

