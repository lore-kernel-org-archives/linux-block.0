Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7583C6FD1C
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 09:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCNJ7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 05:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCNJ7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 05:59:44 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801732A6C6
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 02:59:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230314095939euoutp012075266810e21c7122649e98c69d8326~MQMXvEmEv3143531435euoutp01r
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 09:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230314095939euoutp012075266810e21c7122649e98c69d8326~MQMXvEmEv3143531435euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678787980;
        bh=H6IXMO/+LNT5IcpUXf3VCYZYIWQLBbG+ouX5TzGRQb4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=q0bgCcUHll3Exr+aEShCJGQ1+Y6h/WndKfTedp6KVVeHH3jEncsVJgYijr35Z/Fp/
         ZccqsxgQsjth83qlBBVmh/zIhdgp+r4tYcSfsPut9y4KCgR0mUAKVJkLtnYm9ToA5N
         n21OpoQ2KrT5itOXKlE6NNi6l6cLL0LpSQ+hTgJg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230314095939eucas1p1820ed618f21421022952a96d18daed67~MQMXpoFZ12755427554eucas1p1n;
        Tue, 14 Mar 2023 09:59:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 83.36.10014.B8540146; Tue, 14
        Mar 2023 09:59:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230314095939eucas1p2d128eebb31dc3aef51dfec489c018dfd~MQMXU1hoZ2428024280eucas1p28;
        Tue, 14 Mar 2023 09:59:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230314095939eusmtrp1a67bfb40ae12aa9dfeff35d9f4e909af~MQMXUVFdU1643516435eusmtrp1k;
        Tue, 14 Mar 2023 09:59:39 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-7a-6410458b1c4d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.24.09583.B8540146; Tue, 14
        Mar 2023 09:59:39 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230314095939eusmtip1933a56d5aa4535a0e2770dd71a06dd0c~MQMXJvN9V1819418194eusmtip1b;
        Tue, 14 Mar 2023 09:59:39 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 14 Mar 2023 09:59:38 +0000
Date:   Tue, 14 Mar 2023 10:51:22 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 2/2] block: null_blk: cleanup null_queue_rq()
Message-ID: <20230314095122.jrfkyvdy2yyhupwp@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230314041106.19173-3-damien.lemoal@opensource.wdc.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87rdrgIpBi/XGVm8OtDBaLH6bj+b
        xe+z55kt9t7SdmDx2DnrLrvH5bOlHjtb77N6fN4kF8ASxWWTkpqTWZZapG+XwJWxfmJ0wUaW
        ij//ExoYLzN3MXJySAiYSCw7MI0RxBYSWMEosfytcRcjF5D9hVHi5tpzbBDOZ0aJbWvfssF0
        vOw6wQKRWM4ocfjrF3a4qgkTNrFCOFsYJZZ9WMsC0sIioCpxefM8IJuDg01AS6Kxkx0kLCJg
        KvG2pxWshFkgQ2LysfdgtrCAo0TjwUmsIDYv0LbW67sZIWxBiZMzn0DV60gs2P2JDWQks4C0
        xPJ/HCBhTgE3iXeTZzFCHKok0bD5DAuEXStxasstJgj7AIfEoV0cELaLRN+ly+wQtrDEq+Nb
        oGwZidOTe6B6qyWe3vjNDPKWhEALo0T/zvVgeyUErCX6zuRA1DhKvJ7fwQgR5pO48VYQ4ko+
        iUnbpjNDhHklOtqEIKrVJHY0bWWcwKg8C8lfs5D8NQvhrwWMzKsYxVNLi3PTU4uN81LL9YoT
        c4tL89L1kvNzNzEC08bpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIrzhLAIpQrwpiZVVqUX58UWl
        OanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGphUo1+EbtXbeflkvk2wncm7ufcW
        z1Bklvf+vSRLKnrWhrSzE3wvHDCdccO01iFeLMSLrfGekXjYabaZbL+udrWfV2/jfVB5vuji
        O4ed75XLN8gyntCu9mIsf3HZwKhv9VP/FaWT7a8/En3rcJD7iPHDNMboy6oXD4o8P7fk9wv9
        BbcuvV/frTp7h51TdOn5iW1pXLGdofxJjhs3LzD5+NftW+5LTzHnrvdyYTrdZ077bvojWzPB
        49wSx49Hzt4OsZlcHNuyKqG65cj73yIOv9NuLDtxIH3lfIHy/XtP8s1offk3++qOsDuXbcX2
        zcs325o7M0l6Yrq3G0v02qmXX21qtvPZUJjSNmdhjnWG988sJZbijERDLeai4kQAENCoJooD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7rdrgIpBgs7pS1eHehgtFh9t5/N
        4vfZ88wWe29pO7B47Jx1l93j8tlSj52t91k9Pm+SC2CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0
        tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtYPzG6YCNLxZ//CQ2Ml5m7GDk5JARMJF52
        nWDpYuTiEBJYyiixYeMpNoiEjMSnKx/ZIWxhiT/XusDiQgIfGSXW3jKBsLcwSnSs4gexWQRU
        JS5vngc0iIODTUBLorETrFVEwFTibU8rC4jNLJAh8fj0CbC9wgKOEo0HJ7GC2LxAN7Re380I
        cUMjo8T2I3/YIRKCEidnPoFq1pFYsPsTG8h8ZgFpieX/OEDCnAJuEu8mz2KEOFNJomHzGRYI
        u1bi899njBMYhWchmTQLyaRZCJMWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyfbcd+
        btnBuPLVR71DjEwcjIcYJTiYlUR4w1kEUoR4UxIrq1KL8uOLSnNSiw8xmgJDYiKzlGhyPjCC
        80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamNRu9T9/11DLMSv0
        9eTbi29bHC4WSpyU3mnwV0s6s3kS+9b5z1cFzb6yxO7E9GzVH9kdLiYd901kE6O3Ctw85s1W
        /1T6/jXLlSuntbVZzDWf9b1+9dlJG2serWv9vXh6teNGjviII1brJS/zM+xnNm871/lWaYee
        x9EnEef87+fd4Xp1q/lM3nSmjF932dfZPPH52jrVJErxmh33vp7DZY9mVYn/CBJf/atd8+7E
        1dH5D2z0uU1il6Ru36AxnX+j38/3a3ZIT5A1OLtYOub/xUs8flMD0io9nWa+N82Kjgts3O7/
        y0L8ZMfCf0qLjeLmLOVUvCEcGHHQOOzkxjk8pg93OIvGdD23bC3UPVn2rFqJpTgj0VCLuag4
        EQCdGzR7KAMAAA==
X-CMS-MailID: 20230314095939eucas1p2d128eebb31dc3aef51dfec489c018dfd
X-Msg-Generator: CA
X-RootMTR: 20230314095939eucas1p2d128eebb31dc3aef51dfec489c018dfd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230314095939eucas1p2d128eebb31dc3aef51dfec489c018dfd
References: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
        <20230314041106.19173-3-damien.lemoal@opensource.wdc.com>
        <CGME20230314095939eucas1p2d128eebb31dc3aef51dfec489c018dfd@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 14, 2023 at 01:11:06PM +0900, Damien Le Moal wrote:
> Use a local struct request pointer variable to avoid having to
> dereference struct blk_mq_queue_data multiple times. While at it, also
> fix the function argument indentation and remove a useless "else" after
> a return.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/block/null_blk/main.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
