Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4DC54E76
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjAQRer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjAQRaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 12:30:35 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E016AE2
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:28:18 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230117172815euoutp0255d291e15d4ac338ddc809c4d2c66ab8~7KMDjNbma0070600706euoutp02F
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 17:28:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230117172815euoutp0255d291e15d4ac338ddc809c4d2c66ab8~7KMDjNbma0070600706euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673976495;
        bh=ppgbS9otra+l3yNgfUZn3vLxr94OaomCYTi/AzlB998=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=LeQcHs3Q65bVO+Phv/o2O8SvWrz3UPM0KDzAPTud+xJHaLH1QuGBiLdrWdN7yVH6n
         TGHHXdzPnYBLlfqb9Qw95WC9o/MB7So7aH/UBsbrO8clqckNg52C3EsHrwOT4o3aXd
         f5KKmIbBpnSBP4gjGXSa8jNB0Mt76ktGAPDIRxFY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230117172815eucas1p2f208a8baf5de0337668c3c8217c690cf~7KMDOnh6x0536905369eucas1p2V;
        Tue, 17 Jan 2023 17:28:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 38.31.61936.EAAD6C36; Tue, 17
        Jan 2023 17:28:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230117172814eucas1p2b1f69afa48bb56b8e8a3edb0a3bc75e0~7KMC7glhB0536905369eucas1p2U;
        Tue, 17 Jan 2023 17:28:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230117172814eusmtrp2e04e3912e6676c0532a5bfadc4b18786~7KMC6_DSm0072400724eusmtrp2D;
        Tue, 17 Jan 2023 17:28:14 +0000 (GMT)
X-AuditID: cbfec7f4-a43ff7000002f1f0-60-63c6daaeeafc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.EE.23420.EAAD6C36; Tue, 17
        Jan 2023 17:28:14 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230117172814eusmtip22e8c59fdbfd7cc75bceec47210399095~7KMCv38ns0222802228eusmtip2J;
        Tue, 17 Jan 2023 17:28:14 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.178) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 17 Jan 2023 17:28:13 +0000
Message-ID: <eac2263f-43b0-f6f5-2a75-33e571075dc8@samsung.com>
Date:   Tue, 17 Jan 2023 18:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] block zoned cleanups
Content-Language: en-US
To:     <axboe@kernel.dk>
CC:     <linux-nvme@lists.infradead.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <gost.dev@samsung.com>,
        <snitzer@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.178]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7rrbh1LNrjcYG2x+m4/m8W0Dz+Z
        LX6fPc9ssXL1USaLvbe0LeYve8puceKWtAO7x+Ur3h6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vv
        s3p83iQXwB7FZZOSmpNZllqkb5fAlXH+3ln2ghdcFYc/KzYwHuPoYuTkkBAwkdix4SULiC0k
        sIJRYuNsAwj7C6PEtgWyXYxcQPZnRokj5z+ywzRcuriADaJoOaPE8atKcEXtVzvZIZzdjBLN
        TdtZuxg5OHgF7CTWvZIBaWARUJVYOGk72DZeAUGJkzOfgNmiAlESTRd+gtnCAgYS93fcZQax
        mQXEJW49mc8EMkZEQFRizqJKkPHMAnsZJTY9esQIEmcT0JJo7AS7jVPASuLCxN+MEK2aEq3b
        f7ND2PIS29/OYYa4X1nix4bTbBB2rcTaY2fATpYQ6OeU6Gp+DJVwkdiwcCZUg7DEq+NboJ6X
        kfi/E+QeELta4umN38wQzS2MEv0717OBHCQhYC3RdyYHwnSU6L+rCGHySdx4KwhxDp/EpG3T
        mScwqs5CCohZSB6eheSDWUg+WMDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwDZ3+
        d/zLDsblrz7qHWJk4mA8xCjBwawkwuu363CyEG9KYmVValF+fFFpTmrxIUZpDhYlcd4ZW+cn
        CwmkJ5akZqemFqQWwWSZODilGpgm9K/1if8yq4ahfLoXe3t+xY0c+1cpe2ViXK62dwkVWS4V
        ePBEY3LSMY5lzz64lt0rctnAvv9K/5IGl/hau032DZsO7dH6Nf2SXcTbtZPSr3pMzdm929Fw
        5kHNywcygoJZ3s19eY/3yDKZJaVbNe1tj0QfVrlwufSEiMG/zw+3uzk39e6plguQ/PdG4bhC
        z0wHldIT7os3Sd8XDC22OPI7wOrqw1NcDyadqPj6YPmcF8mG9s+rn7i2VrgH+f2TZuJ4JCsk
        +UbSZIFa9AHrw2tbN5boz8hYvNvF8tyvlqZ8lbI3T7XLVsZ9LhI6dkM2YvVkUc2Epu83oyPf
        RW2pLLJY2OA35ewztfU6P/cu2TJBiaU4I9FQi7moOBEAoTzzHrIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7rrbh1LNjj6T91i9d1+NotpH34y
        W/w+e57ZYuXqo0wWe29pW8xf9pTd4sQtaQd2j8tXvD0uny312LSqk81j85J6j903G9g8drbe
        Z/X4vEkugD1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
        3y5BL+P8vbPsBS+4Kg5/VmxgPMbRxcjJISFgInHp4gK2LkYuDiGBpYwS228vZIVIyEh8uvKR
        HcIWlvhzrQuq6COjRM/jQ4wQzm5Giamn7jB3MXJw8ArYSax7JQPSwCKgKrFw0nYWEJtXQFDi
        5MwnYLaoQJTEzfMPmUBsYQEDifs77jKD2MwC4hK3nsxnAhkjIiAqMWdRJch4ZoG9jBKbHj2C
        2tXLKPHzfx8jSBGbgJZEYyfYcZwCVhIXJv5mhJijKdG6/Tc7hC0vsf3tHGaIB5Qlfmw4zQZh
        10q8ur+bcQKj6Cwk581CcsYsJKNmIRm1gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAU
        bzv2c/MOxnmvPuodYmTiYDzEKMHBrCTC67frcLIQb0piZVVqUX58UWlOavEhRlNgGE1klhJN
        zgemkbySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqY4109N7BX3
        RB96Fc+e98Vis+br32mRy5+u9Oq6Xz/t6Vr+K9ufWt9oborKvlnWv27yPqfnkryWxzR4bmlZ
        LlnVeu3S/aAv1ydrOrSLqVwX8nn6Q2Dh0SkX9Z/MDHlYfj5bzqtw6uPSiqs2X04afcvfz55Z
        6uIV/u78o9Pnm1bbZ+zwnnXj6qyg/9L7tbTkYlctaerM+HeLMeBG0XR11nkfBdUmt3+aq/HF
        QOmtxrf/XvvmvnY2XrmQW+3l8hwh81snHsjk99St/3Dih5b//Ijo+VWX7dpmrzlfIfLneHDP
        zfJulx/zde6VmfpWHrnxJvaQyuqr5j/DBH9IBXtJP3+48fnVNdYhmb/X8lgG/6/VVWIpzkg0
        1GIuKk4EAD5sMiprAwAA
X-CMS-MailID: 20230117172814eucas1p2b1f69afa48bb56b8e8a3edb0a3bc75e0
X-Msg-Generator: CA
X-RootMTR: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
        <20230110143635.77300-1-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
  There is a Reviewed-by tag by different reviewers in all the patches.
Could we queue this up for the next release?

Regards,
Pankaj

On 2023-01-10 15:36, Pankaj Raghav wrote:
> Hi Jens,
>   It is still unclear whether the support for non-po2 zone size devices
>   will be added anytime soon [1]. I have extracted out the cleanup
>   patches that doesn't do any functional change but improves the
>   readability by adding helpers. This also helps a bit to
>   maintain off-tree support as there is an interest to have this feature
>   in some companies.
> 
> [1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/
> 
> Changes since v1:
> - Remove blk_is_zoned() check in bdev_{is_zone_start, offset_from_zone_start} (Damien)
> - Minor spelling and variable name changes (Bart and Johannes)
> - Remove zonefs patch for now (Damien)
> - Send dm patches separately(Christoph)
> 
> Pankaj Raghav (3):
>   block: remove superfluous check for request queue in bdev_is_zoned()
>   block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
>   block: introduce bdev_zone_no helper
> 
>  block/blk-core.c          |  2 +-
>  block/blk-zoned.c         |  4 ++--
>  drivers/nvme/target/zns.c |  3 +--
>  include/linux/blkdev.h    | 22 +++++++++++++++++-----
>  4 files changed, 21 insertions(+), 10 deletions(-)
> 
