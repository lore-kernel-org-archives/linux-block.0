Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9D5C49EA2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FCE6109E
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUHzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:55:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:13633 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUHzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 03:55:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210621075324euoutp026a9deac458043b08f7e63cc0f73efb44~KibAOx7Uf1466314663euoutp02j
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 07:53:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210621075324euoutp026a9deac458043b08f7e63cc0f73efb44~KibAOx7Uf1466314663euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624262004;
        bh=VSR7K0RRZ8RbDr9M8SBlNLEos5sDTrZb1jBw6Dk1JOs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XwuQgrAsk9aGIPmXoyQ/UGbI0qRqURSJ1R60P+RfzsOXvrguWVxZaAzlBX/R1Qn9Z
         C/QH9bxrZF4SbO+yOGT9/HQ10Ft4FRJJWtM3DdNLwVrEuk987X/82Rr/Irc2N1tkcJ
         ZRZS9t6VmNT2jkcaLlziC/xQd920l5Id45HEc8IU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210621075324eucas1p100f0c95d27708462522256edaceba3c8~Kia-6u4SM1827418274eucas1p1H;
        Mon, 21 Jun 2021 07:53:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CF.6C.45756.47540D06; Mon, 21
        Jun 2021 08:53:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210621075323eucas1p25b296e9b9a162e9cf892ac5ae892c16c~Kia-TRlvP2616526165eucas1p2D;
        Mon, 21 Jun 2021 07:53:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210621075323eusmtrp26a347340278b8a41c9e307f715d0ea5c~Kia-ShcOd3089130891eusmtrp29;
        Mon, 21 Jun 2021 07:53:23 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-bf-60d045749a57
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 57.D0.20981.37540D06; Mon, 21
        Jun 2021 08:53:23 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210621075323eusmtip2daae8a02e77750d22298646078bda7d9~Kia_4Pc6_2310723107eusmtip2J;
        Mon, 21 Jun 2021 07:53:23 +0000 (GMT)
Subject: Re: [PATCH 2/2] mmc: switch to blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <57e981f2-8a72-72c4-495e-1188f7b32f92@samsung.com>
Date:   Mon, 21 Jun 2021 09:53:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621065904.GA6198@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd0S1wsJBh1rZC1Wrj7KZLH3lrbF
        kf/9jBbH14Y7sHjcubaHzWP3zQY2j8+b5AKYo7hsUlJzMstSi/TtErgyWt9uZyk4zVVx5+s2
        pgbGJxxdjJwcEgImEk/eHGDvYuTiEBJYwSixs/8DlPOFUeLTpR1sEM5nRokNq1YywbQ8XvUR
        qmo5o8SjGYvAEkICHxklWnplQWxhAUuJSedaWUBsEQEliaevzjKC2MwCSRLfvx5lBrHZBAwl
        ut52sYHYvAJ2EhPOvgezWQRUJbZufMcOYosKJEu8nzeDFaJGUOLkzCdgMzkFtCUezZnMDDFT
        XmL72zlQtrjErSfzmUCOkxBYyyHx9T3I1RxAjovEm2lWEA8IS7w6voUdwpaR+L8Tpr6ZUeLh
        ubXsEE4Po8TlphmMEFXWEnfO/WIDGcQsoCmxfpc+xExHid/biiBMPokbbwUhTuCTmLRtOjNE
        mFeio00IYoaaxKzj6+C2HrxwiXkCo9IsJI/NQvLMLCTPzEJYu4CRZRWjeGppcW56arFhXmq5
        XnFibnFpXrpecn7uJkZgKjn97/inHYxzX33UO8TIxMF4iFGCg1lJhJcz80yCEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd5Vs9fECwmkJ5akZqemFqQWwWSZODilGpj0nWU7XzielfuxxbflZcMi
        lVVZcQ/eqDxaHP3It7ZctSq9a0vsjXNfAxducuboK7G0e3rQ4+DX5ITGqEWpPdIpfS7PeDk/
        egsbeoQmKzsay9cFuDV3nO/y99rTFnuo9sYrl01z2aQVJqnevfg8Lj9UfbuFcI9exqdTx9dd
        L92wWNHsZZyB7ekTRkqlGsuq3/luOrJxLf/Ddu+/LqZL0lPDnPma/n+fEG7eMVPDf47ut+dn
        3k2fu7V7Rmpx0xRJfp4nPHeNv/zj5j52ga+D2T12jVF+x4v59rONts5bJsiVPDdmm/MBjpmu
        j5gWFDwpCohsrjrLM6m7lOXD36zFxy3OXWbI0rB4VFdyyUPulRJLcUaioRZzUXEiAEJEaeqU
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7rFrhcSDCbN1rdYufook8XeW9oW
        R/73M1ocXxvuwOJx59oeNo/dNxvYPD5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLaH27naXgNFfFna/bmBoYn3B0MXJySAiYSDxe9ZG9
        i5GLQ0hgKaPEoY+r2SESMhInpzWwQtjCEn+udbFBFL1nlDiw6DMLSEJYwFJi0rlWMFtEQEni
        6auzjCA2s0CSxJGDBxghGhqZJPqm3wObyiZgKNH1FmQSJwevgJ3EhLPvwWwWAVWJrRvfgdWI
        CiRL/FzfDlUjKHFy5hOwBZwC2hKP5kxmhlhgJjFv80MoW15i+9s5ULa4xK0n85kmMArNQtI+
        C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYQduO/dyyg3Hlq496hxiZ
        OBgPMUpwMCuJ8HJmnkkQ4k1JrKxKLcqPLyrNSS0+xGgK9M9EZinR5HxgDOeVxBuaGZgamphZ
        GphamhkrifOaHFkTLySQnliSmp2aWpBaBNPHxMEp1cDUz/Gfb8Fs36fqBnaPtjQq/hYtman+
        f8fMieKv+r4+NTtU+WXZqb92nrUf+1aFzAqfpurrx7mH61KP8Mu/Z4r+5+aXqudFx/bsTTLT
        KT9zIaNJrInv/Zz81C2XN3I/vjdv/ZMzh2vPP1r6RqRc6U7LzpIt3irRE1QKJWos/7WJxh9S
        WLnt0ENuT9HylIB5l1nm+YntYp95XVXX+5cSj8yKv192uF9f7WZ6/i5vnXF8QN5h14MXnH2f
        ngtTKJLWKzix6It8xLS9F6VPbTw45yGjp8ITqVNChiuv/j37sijy3GSX1EIF3ahHWtqGuUuW
        q98T5fgqnn614vepZ/3TTlz6/Lr/5mIei+UbeK9PnaSmo8RSnJFoqMVcVJwIAHCY3IApAwAA
X-CMS-MailID: 20210621075323eucas1p25b296e9b9a162e9cf892ac5ae892c16c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753
References: <20210616053934.880951-1-hch@lst.de>
        <20210616053934.880951-3-hch@lst.de>
        <CGME20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753@eucas1p2.samsung.com>
        <1c5b5018-f7ca-609b-b607-827cedc161e6@samsung.com>
        <20210621065904.GA6198@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On 21.06.2021 08:59, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 08:22:07AM +0200, Marek Szyprowski wrote:
>> On 16.06.2021 07:39, Christoph Hellwig wrote:
>>> Use the blk_mq_alloc_disk to allocate the request_queue and gendisk
>>> together.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> This patch landed recently in linux-next as commit 281ea6a5bfdc ("mmc:
>> switch to blk_mq_alloc_disk"). It triggers the following warning during
>> boot on all my systems with MMC devices:
> Please try this, I lost this hunk in the final cleanup, sorry:

No problem. Right, it fixes the issue. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e7f89cbf9232..9890a1532cb0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2331,6 +2331,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   	md->queue.blkdata = md;
>   
>   	md->disk->major	= MMC_BLOCK_MAJOR;
> +	md->disk->minors = perdev_minors;
>   	md->disk->first_minor = devidx * perdev_minors;
>   	md->disk->fops = &mmc_bdops;
>   	md->disk->private_data = md;
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

