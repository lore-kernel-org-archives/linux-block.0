Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0102DC433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 05:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F772070A
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 05:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhA0Fxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:53:34 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12264 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbhA0FjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 00:39:14 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210127053830epoutp032ea9d606693df68e50d16b73dd191cfb~eAC0_GezO0160601606epoutp03N
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 05:38:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210127053830epoutp032ea9d606693df68e50d16b73dd191cfb~eAC0_GezO0160601606epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611725911;
        bh=Q7c7nswS1ltBmlscGeDNtGS45xJh4M+Aq8tqkniFyBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaJDptNxgup57YiGCoewW7/af+tOtfWG7wfi7XzsSyB1EknfgjdN/2njTvlpRmuWT
         OJIDE0prHlWfmetzHZ3lZMZB/8plS7/vudEh/EsFO9a8rsBEm1rpj7cmEAywJiR8nS
         42K6wBuGe3Yva9BOaqxLXmtNuTbApfreG0aKgMG8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210127053829epcas1p40724852a01d56dbbd4bbeeb887a4c617~eAC0CO8z30725007250epcas1p42;
        Wed, 27 Jan 2021 05:38:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DQXT03KPBz4x9Ps; Wed, 27 Jan
        2021 05:38:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.1B.09582.45CF0106; Wed, 27 Jan 2021 14:38:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210127053827epcas1p1e0cda00cdbfdacd5a3ede69c788d6710~eACxs5L7e2375923759epcas1p1B;
        Wed, 27 Jan 2021 05:38:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210127053827epsmtrp1a89f6c7f0f1c3f1c7e1f21e5a30a81d6~eACxqxLcr2906229062epsmtrp1L;
        Wed, 27 Jan 2021 05:38:27 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-c4-6010fc54a7a2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.5E.08745.35CF0106; Wed, 27 Jan 2021 14:38:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210127053827epsmtip191803422311aa3bd75635387cece71c1~eACxbG4Bb0590505905epsmtip1d;
        Wed, 27 Jan 2021 05:38:27 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Date:   Wed, 27 Jan 2021 14:22:57 +0900
Message-Id: <20210127052257.13186-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <BL0PR04MB6514D7392DB2F6B9069A4B7FE7BB9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH+z7P9uwZNXtiJF8pYw2wWIKbY+ybQmdk3HOHdtzKu5IZm/Ac
        I8e29mz047zLYwg2FOG4dMxpZgTdLEFAgxWcB5YiVCiQyB0IIRpcQI1AoqQ2Hij+e3++n9f7
        +77P9weJh94kIshck42xmvRGKRHCu9geK4977W9KJ/eViZHHexGgs4NHCXSweA5Dh+8U8NED
        5xCGZkdY1DLwHOrxeQjUVuHA0PEGD45+ut0lQO1DfTw0UlWOox86/Hx0anQbWqj5FqDp+ZsC
        dK2pAke1LX8S28R0uWNKQDe7BwV0z/d2ut77IUFPt/YRdGmjF9Az9U/RxZdKsHRytzHJwOiz
        GauEMWWZs3NNOcnStFczX8pUJcoVcYrnkVoqMenzmGTp9h3pcam5xsA0Ukm+3mgPLKXrWVa6
        6YUkq9luYyQGM2tLljKWbKNFIbfEs/o81m7Kic8y521RyOWbVQFSZzRU9kVZGte8O3XrPH4A
        9D3sBEISUglwsKpb4AQhZCjVBKCroGi58APYPHIa44oZABfLy/grlp7qQT7X8AFYebUE/Ee5
        G6aWKILaCEsnB4igDqPWwWvjfxBBCKdacehvvLsEiSkl/LHEwQtqHhUDHb87QVCLqK3w8vgp
        nIuLhGNHapa0kNoDhzwNBMc8Bjsq7yx58QDjuHACDwZAqpeEC/PdPM68HfqLnBinxXDiSqOA
        0xFw/Cg3KaRKAHQUfQy4ogzAqnvVyw4l9M/MBBpkICIW1vo2cctPw+a/TgIueQ2cmj3MDyKQ
        EsFDRaEcEg27Cm/jK1n3vmxe3pGG1YvdBHdcdQD6is8RZUDiXjWQe9VA7v+TTwPcC9YyFjYv
        h2EVFuXqS64HSy9cpm4CxyZ/i28DGAnaACRxaZhoOorShYqy9e+9z1jNmVa7kWHbgCpw3OV4
        xONZ5sAXMdkyFarNSqUSJSSqE1VKabhor3w4M5TK0duYfQxjYawrPowURhzAUrBU9cu/hiXd
        KHz9rQZx7/zYrjdNrt4CIqxr16Pa8z8L8+kjss4G6kzqfbPPwLp/cXwjE9zt1Ah2fprnSqzr
        wDUa7X2an/FQWniKX906XzEs2GCMecKj7NHODXUuOntSHplc913tBwlpvq7YYd0exdlpXboT
        jr7TGJkfGT5346Pq6ZYoht0qcrW3CUykXC7xf6a9pXlmIGu9a/ezD7z9Q5F9GSGTlw+GX9CW
        Cpvr+v958ureL6LRxLGKz2uOn/tkobKm9GR0xiv7Y1yzwokTO972JBdqrvjGStZ3jW6QXfr6
        jZ1fKbdMumd6y5xet+T6oX01Z3QxMlX/8NhGz9rr+7EXpTzWoFfIcCur/xdvVwtyagQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTjf4j0CCwf0/QhZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBkzryoXbOGreHdzI3MD41Xu
        LkZODgkBE4nLy+6ydjFycQgJ7GCU+LHxJxtEQkri+Im3QAkOIFtY4vDhYpCwkMBHRolN151A
        bDYBHYm+t7fAykUEJCVOvfzCBjKHWeAKs8TmjzMZQRLCAsYS57ubWUBsFgFVieaPXWBxXgFr
        iSMv5zFD7JKXeNq7HMzmFIiVuDdnMxvEshiJdRcb2CHqBSVOznwCNocZqL5562zmCYwCs5Ck
        ZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxhWlo7GPes+qB3iJGJg/EQ
        owQHs5II73tlgQQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4
        OKUamFZfiZCJ/ibqX7Jjx4uphcpTz3SwMUat+K/Omsv5NTkjJbPoS4XVPrf5NVYCvd+s1/1w
        NjW9dmbLiz/Wv5besXw6/8v92vSQQxkWvce9k897x+p8r/c8M3Fm1ZnS2C9bOON6nu0Xvlgh
        9+rN5CMr7xrPCMo4Osnz0sMkReHFbJ93NGxwucb/xHET1/xJL8Km987vfs5/5sNLmXrXNdOi
        rX703r7x1PmJxArtkA9BXnxTbm61ruTf/OrxjM+3UgRc0/5W5UXEHWo/KBx24bXkq5+rV5dc
        /9TYpmnr8/j0xgxer+8vOVkuvn8w++iehl9zb+wIrnzKFngiLPj70UkZp9J3O3zYF+R/Y6nD
        369rDsyUVWIpzkg01GIuKk4EACvMYxsfAwAA
X-CMS-MailID: 20210127053827epcas1p1e0cda00cdbfdacd5a3ede69c788d6710
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210127053827epcas1p1e0cda00cdbfdacd5a3ede69c788d6710
References: <BL0PR04MB6514D7392DB2F6B9069A4B7FE7BB9@BL0PR04MB6514.namprd04.prod.outlook.com>
        <CGME20210127053827epcas1p1e0cda00cdbfdacd5a3ede69c788d6710@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 2021/01/27 9:36, Changheun Lee wrote:
> >>> +
> >>>  /**
> >>>   * bio_reset - reinitialize a bio
> >>>   * @bio:	bio to reset
> >>> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> >>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> >>>  
> >>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> >>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> >>> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> >>>  				*same_page = false;
> >>>  				return false;
> >>>  			}
> >>> diff --git a/include/linux/bio.h b/include/linux/bio.h
> >>> index 1edda614f7ce..cdb134ca7bf5 100644
> >>> --- a/include/linux/bio.h
> >>> +++ b/include/linux/bio.h
> >>> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)
> >>>  	return NULL;
> >>>  }
> >>>  
> >>> +extern unsigned int bio_max_size(struct bio *);
> >>
> >> No need for extern.
> > 
> > It's just for compile warning in my test environment.
> > I'll remove it too. But I think compile warning could be in the other
> > .c file which includes bio.h. Is it OK?
> 
> Hmmm... not having extern should not generate a compilation warning. There are
> tons of functions declared without extern in header files in the kernel. What
> compiler are you using ?
> 

Compiler imformation is below.

CROSS_COMPILE: android/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CC: android/prebuilts/clang/host/linux-x86/clang-r383902/bin/clang
CLANG_TRIPLE: android/prebuilts/clang/host/linux-x86/clang-r383902/bin/aarch64-linux-gnu-
CROSS_COMPILE_COMPAT: android/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-


> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

---
Changheun Lee
Samsung Electronics
