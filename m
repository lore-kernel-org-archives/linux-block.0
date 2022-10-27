Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77522ECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 11:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiJ0LAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiJ0LAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 07:00:41 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C497EF3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 04:00:36 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221027110034epoutp040d4ebb1a06e628a370c0892e4280539b~h6AJkE55j1839218392epoutp04T
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 11:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221027110034epoutp040d4ebb1a06e628a370c0892e4280539b~h6AJkE55j1839218392epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666868434;
        bh=8JifMc2LpponSbJQ/9epsSZkS2RUfjwrISWplcQgxoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FxoxW0FpKkrp0LSOhOhOSfm87fKLUCsu5p4ufSKMg8yPySmecEGEG+8D75jJbaQNi
         /x9fc4i2596Vsm45XM5c//xIFvb7f3pCV9NCasiZ2RcD04CFyoX4qEg5PRAOaNTPet
         olfCE64BNorHKALcDqhdBS7KIIo2jMEtv2gIu5vs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221027110033epcas5p22bb9c81d4b4f7d0cc9513bf9892da851~h6AJYaQcI2413924139epcas5p28;
        Thu, 27 Oct 2022 11:00:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MyjQ66YlSz4x9Pw; Thu, 27 Oct
        2022 11:00:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.A6.01710.AC46A536; Thu, 27 Oct 2022 20:00:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221027110026epcas5p4a0d217c800a6c7201bb834046538fc4e~h6ACXCJF40408304083epcas5p4e;
        Thu, 27 Oct 2022 11:00:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221027110026epsmtrp17a5a63b2d3ff0f12518b506980e3b27a~h6ACWZvp51388113881epsmtrp1W;
        Thu, 27 Oct 2022 11:00:26 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-c6-635a64ca3067
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.FE.14392.AC46A536; Thu, 27 Oct 2022 20:00:26 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221027110025epsmtip16f4dcc45e5645eca64186b9a20c49b84~h6ABqPCh12537425374epsmtip1u;
        Thu, 27 Oct 2022 11:00:25 +0000 (GMT)
Date:   Thu, 27 Oct 2022 16:19:10 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
Message-ID: <20221027104910.GA22546@test-zns>
MIME-Version: 1.0
In-Reply-To: <b7c3d003-d808-a57f-c645-48cfc06d7a52@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmpu7plKhkg1XmFnNWbWO0WH23n81i
        7y1tB2aPnbPusntcPlvq8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWF
        uZJCXmJuqq2Si0+ArltmDtAWJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFe
        cWJucWleul5eaomVoYGBkSlQYUJ2xpwF2xgLropUHP35iL2B8aRgFyMnh4SAiUTH1RVsXYxc
        HEICuxklzn1cxwThfGKU6H+7hx3C+cYocf1VOwtMy7mfT1ggEnsZJT7OPgrlPGOUaDrXCNTC
        wcEioCrxubsUxGQT0JS4MLkUpFdEQFvi9fVD7CA2s4CBxOMHf5lASoQFHCU6P6iChHkFdCXW
        rTjMDGELSpyc+QRsLaeArcS6qU1MILaogLLEgW3HwQ6VEDjHLnGn7QIbxG0uEmcmP2eCsIUl
        Xh3fwg5hS0m87G+DspMlLs08B1VTIvF4z0Eo216i9VQ/M8RtGRKnnzeyQdh8Er2/n4DdKSHA
        K9HRJgRRrihxb9JTVghbXOLhjCVQtofEwR07WSEhso9R4vOkIywTGOVmIflnFpIVELYV0PtN
        rLOAVjALSEss/8cBYWpKrN+lv4CRdRWjZGpBcW56arFpgWFeajk8ipPzczcxgpOdlucOxrsP
        PugdYmTiYDzEKMHBrCTCe/ZGeLIQb0piZVVqUX58UWlOavEhRlNg5ExklhJNzgem27ySeEMT
        SwMTMzMzE0tjM0Mlcd7FM7SShQTSE0tSs1NTC1KLYPqYODilGph6tDp2ivqnic8qjvn5OzTy
        vvFCYa14D8fiJHUW7/0R7A226iFHH+Uab66RK9V1STjwlCurd/Npjjb9tIbz9VVhJquevzFI
        iqvMkrmdVWD4P4RfROkCf0DYIdupXMIHdPi5Zx0PmT15f2zM4aW86opHI6OL3rvsN5fU2v06
        xIdVQlZGNeSLx9LZun6B7DM9Zj4T1pW4dfj+6hdlDx89v5Z7QNhJ3nVdepJviuC87DjFhf0b
        Lfn1r07cenWy2IZ/10T2mJoKV7p1rPfX/Wlyymt1+zL1d4Y/p/FecJh0S+ThrZWTtP5ZHhbb
        wrXsurSWmeEay/3CeouKJ767zusnZGUjcNFa3l7Fca/7ZSV/JZbijERDLeai4kQADjp19v8D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO6plKhkgwdf+C3mrNrGaLH6bj+b
        xd5b2g7MHjtn3WX3uHy21OPzJrkA5igum5TUnMyy1CJ9uwSujD9XLrMUtAtVPNu9mLWBcSp/
        FyMnh4SAicS5n09Yuhi5OIQEdjNKdN84xQyREJdovvaDHcIWllj57zk7RNETRomt5+YDFXFw
        sAioSnzuLgUx2QQ0JS5MLgUpFxHQlnh9/RBYK7OAgcTjB3+ZQEqEBRwlOj+ogoR5BXQl1q04
        zAwxcR+jxLaJVxkhEoISJ2eC3APSayYxb/NDsE3MAtISy/9xgIQ5BWwl1k1tYgKxRQWUJQ5s
        O840gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERy+Wpo7
        GLev+qB3iJGJg/EQowQHs5II79kb4clCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MBXmzm/iN8njcJn3tlOoRsMu+4Z0/uVwftm76yTOWd/bdrDrpurS
        Aw/23vV6Mt9zqoPAmSn37he8Mpj37LnorQX7eWRjNaKrTKw74pl+Z+eeidK5uvrG78kqc+z9
        tz6K+RTuaVH8pWjCvO496+afEv4Y+bzZ1oljWt1669nLzpvZ1BU/mJ5+az7npyUlcb5WC+QL
        g1u/dlbGSO4XnbS+W17QrOn+w+TKllOFfpd0/9hqKIgfU9q4OvXMrRe7DtTH/2ncpGS5w4Qp
        iT/iwaq1Z6SPH5PMXdvkcOTB1BJTry/1bPuNZixrKXj0sojJ/q3B0tVl7EevVJ5ZGh5cepVP
        2euzynT2L4rOmSz9y40fHFViKc5INNRiLipOBADXAMAezgIAAA==
X-CMS-MailID: 20221027110026epcas5p4a0d217c800a6c7201bb834046538fc4e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9b06f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
        <20221027100410.3891-1-joshi.k@samsung.com>
        <b7c3d003-d808-a57f-c645-48cfc06d7a52@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9b06f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Oct 27, 2022 at 11:38:50AM +0100, Pavel Begunkov wrote:
>On 10/27/22 11:04, Kanchan Joshi wrote:
>>If cache does not have any entry, make sure to detect that and return
>>failure. Otherwise this leads to null pointer dereference.
>
>Damn, it was done right in v2
>
>https://lore.kernel.org/all/9fd04486d972c1f3ef273fa26b4b6bf51a5e4270.1666122465.git.asml.silence@gmail.com/
>
>Perhaps I based v3 on a wrong version. Thanks
>
>
>>Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
>>Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>---
>>Can be reproduced by:
>>fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block
>>
>>BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
>>Read of size 8 at addr 0000000000000000 by task fio/1835
>>
>>CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
>>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
>>Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x34/0x48
>>  print_report+0x490/0x4a1
>>  ? __virt_addr_valid+0x28/0x140
>>  ? bio_alloc_bioset.cold+0x2a/0x16a
>>  kasan_report+0xb3/0x130
>>  ? bio_alloc_bioset.cold+0x2a/0x16a
>>  bio_alloc_bioset.cold+0x2a/0x16a
>>  ? bvec_alloc+0xf0/0xf0
>>  ? iov_iter_is_aligned+0x130/0x2c0
>>  blkdev_direct_IO.part.0+0x16a/0x8d0
>>
>>  block/bio.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>>diff --git a/block/bio.c b/block/bio.c
>>index 8f624ffaf3d0..66f088bb3736 100644
>>--- a/block/bio.c
>>+++ b/block/bio.c
>>@@ -439,13 +439,14 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
>>  	cache = per_cpu_ptr(bs->cache, get_cpu());
>>  	if (!cache->free_list &&
>>-	    READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD) {
>>+	    READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD)
>>  		bio_alloc_irq_cache_splice(cache);
>>-		if (!cache->free_list) {
>>-			put_cpu();
>>-			return NULL;
>>-		}
>>+
>>+	if (!cache->free_list) {
>
>Let's nest it under the other "if (!cache->free_list)"

Not sure if I got you. It was under that if condition earlier, and that
part causes trouble.
What you wrote in v2 is another way, but there also we have two checks
on cache->free_list.

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9b06f_
Content-Type: text/plain; charset="utf-8"


------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9b06f_--
