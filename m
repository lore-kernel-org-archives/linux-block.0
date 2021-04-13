Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA18C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 04:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409EA613A9
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 04:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhDMEzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 00:55:43 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:45664 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhDMEzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 00:55:42 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210413045520epoutp030d4b07c811e3a376ae9641032e2a1468~1Ue1ZTMqF0748107481epoutp03U
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 04:55:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210413045520epoutp030d4b07c811e3a376ae9641032e2a1468~1Ue1ZTMqF0748107481epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618289720;
        bh=pYgBxRxmSvBxR/0n2Xafx8ZOywwSjUViktKFLcpcdMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkS/HyiIndjWl/dQAbqxEfvKrtLme9tYd4Q+xbIn6dp/G0QK3OSz4tkZwOZIyhPhT
         B+1wPlUzhcGD0epOzSBJalwrtZ3E1tGmnYnzxiBQIG5Qqkc+i31eh5cPb+4YsU9GDS
         3AUxeMM9YmaNZK4/Ql/ZJNEmwE+YYjT47selqL+g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210413045519epcas1p4ab5f821a65db43bdc4ddc6315883518d~1Ue0coiQH0199001990epcas1p4H;
        Tue, 13 Apr 2021 04:55:19 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FKCw63J63z4x9Q5; Tue, 13 Apr
        2021 04:55:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.91.22618.63425706; Tue, 13 Apr 2021 13:55:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210413045517epcas1p32b058646dd795e59389401ca997c4cac~1Ueyhw8kY1481214812epcas1p3n;
        Tue, 13 Apr 2021 04:55:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210413045517epsmtrp2e0f9c4b8f0948f8aa93e75a8276f4fe9~1UeygePuG2055520555epsmtrp2r;
        Tue, 13 Apr 2021 04:55:17 +0000 (GMT)
X-AuditID: b6c32a38-3f2a8a800001585a-e4-60752436a4fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.BF.33967.53425706; Tue, 13 Apr 2021 13:55:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210413045517epsmtip112161bdeeb0edfe88b5d1351b16309f5~1UeyMTm5_1472214722epsmtip1x;
        Tue, 13 Apr 2021 04:55:17 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     ming.lei@redhat.com
Cc:     Damien.LeMoal@wdc.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
Date:   Tue, 13 Apr 2021 13:37:33 +0900
Message-Id: <20210413043733.28880-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YHO9LQUt1e0J6+l9@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmrq6ZSmmCQct9MYs5q7YxWqy+289m
        Me3DT2aL1vZvTBbNi9ezWZyesIjJoudJE6vF3657TBZfHxZb7L2lbXF51xw2i0OTm5kspm+e
        w2xx7f4ZdovD966yWDxcMpHZ4tzJT6wW8x47WPxafpTR4v2P6+wWp3ZMZrZYv/cnm4OYx+Ur
        3h4Tm9+xe+ycdZfdY/MKLY/LZ0s9Nq3qZPPYP3cNu8f7fVfZPPq2rGL0+LxJzqP9QDdTAHdU
        jk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0KdKCmWJ
        OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAJDgwK94sTc4tK8dL3k/FwrQwMDI1OgyoSc
        jObnd5gKTglXXLk2kamBcSN/FyMHh4SAicSlU4xdjJwcQgI7GCXmL6nvYuQCsj8xSnS/fcgM
        4XxjlPh0pYUNpAqkofHiDFaIxF5GiaObu6DaPzNK/G9KB7HZBHQk+t7eAmsQERCXaF2yignE
        ZhZoZZFom8sGslkYaNDJ/ywgYRYBVYk9046BlfAKWEtsuv8Oape8xJ/7PcwgNqeAisTe5g1s
        EDWCEidnPmGBGCkv0bx1NtihEgL/OSS2XLvEAtHsAvTBRShbWOLV8S3sELaUxOd3e9kgGroZ
        JZrb5jNCOBMYJZY8X8YEUWUs8enzZ0aQS5kFNCXW79KHCCtK7Pw9lxFiM5/Eu689rJBg5JXo
        aBOCKFGRONNynxlm1/O1O5kgSjwkXl5whgRVucTzR6tZJjAqzELyziwk78xC2LuAkXkVo1hq
        QXFuemqxYYEJcvRuYgSney2LHYxz337QO8TIxMF4iFGCg1lJhNdtSkmCEG9KYmVValF+fFFp
        TmrxIUZTYGBPZJYSTc4HZpy8knhDUyNjY2MLEzNzM1NjJXHeJIMH8UIC6YklqdmpqQWpRTB9
        TBycUg1M/gve9DWKHD11YXeDAn9vuaF7gDmH4J74jhPft2Rcd9yhpSHYlGEc4+QlwvLDtrBb
        V3HfI6df5ZsyL+fNsC9MuvElaf8+jo3VzRu3/+XdI/878dkrvx2vhcQz89doyOhFP74RfNLi
        rW2j3qJi9vkLv0cJma4JaYwwyfvo+8vs2vNi37RnsjwK95rY/J8sDLgza8o/hv7XjpOcls37
        GzqLfZH8R/nSeIF7p1WELzdt+Pxuwp73721VPQ2v1tzZnHf4w7HDxxRuf/aPsLZx+H5Wa+52
        +TMMOdJVTWtPf9k498CZlXx1j1ls1Z42RSiVhUs8m/v77p+YGTUbLU3FvmgucZJjsfw26ZAb
        +46bb1uFlFiKMxINtZiLihMBA+T6Z4AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnK6pSmmCwZf3mhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsErozm53eYCk4JV1y5NpGpgXEjfxcjJ4eEgIlE48UZrF2MXBxCArsZJX5s
        2sgIkZCSOH7iLVCCA8gWljh8uBii5iOjxJFTB9lAatgEdCT63t4Cs0UExCVal6xiAiliFpjP
        InHn+WFGkGZhoA0n/7OA1LAIqErsmXaMCcTmFbCW2HT/HRvELnmJP/d7mEFsTgEVib3NG8Di
        QgLKEkuf72aEqBeUODnzCdgcZqD65q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5
        XnFibnFpXrpecn7uJkZwbGpp7mDcvuqD3iFGJg7GQ4wSHMxKIrxuU0oShHhTEiurUovy44tK
        c1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBauLlxmTQXo/KR9Y+qprX+jHzy
        8+D+5NcFvMmizWlne9yCuyd4zD8js/h20wrLTCafkIk3GU6e443TVpKROTP5+fogrerX03Nz
        WubOPLSrana/m/PzIwJyO3vmWnDfilu1zVpUidtXPfnPijSv0r8PUtyZprm9bfH/GfTGoX4Z
        Q+cO6+qLF8xMExIcrl+sUnIO/brj0kpm9lXJbBfcS4QPTGyasUbH1VH6wpGPwixLpmxUfe73
        PNmwdcbZ2ZumTAlNX/vgdXfmjxV9ob0b1lUtmSXt/kJFLNvBdMOlyT92/39u+cDPZf5uqflH
        2ptNv6ueZ6hc8yBSINXsUCrHwlNadnvnb/t+ZUf1XcHnISrflViKMxINtZiLihMBaKtVKzwD
        AAA=
X-CMS-MailID: 20210413045517epcas1p32b058646dd795e59389401ca997c4cac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413045517epcas1p32b058646dd795e59389401ca997c4cac
References: <YHO9LQUt1e0J6+l9@T590>
        <CGME20210413045517epcas1p32b058646dd795e59389401ca997c4cac@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Sun, Apr 11, 2021 at 10:13:01PM +0000, Damien Le Moal wrote:
> > On 2021/04/09 23:47, Bart Van Assche wrote:
> > > On 4/7/21 3:27 AM, Damien Le Moal wrote:
> > >> On 2021/04/07 18:46, Changheun Lee wrote:
> > >>> I'll prepare new patch as you recommand. It will be added setting of
> > >>> limit_bio_size automatically when queue max sectors is determined.
> > >>
> > >> Please do that in the driver for the HW that benefits from it. Do not do this
> > >> for all block devices.
> > > 
> > > Hmm ... is it ever useful to build a bio with a size that exceeds 
> > > max_hw_sectors when submitting a bio directly to a block device, or in 
> > > other words, if no stacked block driver sits between the submitter and 
> > > the block device? Am I perhaps missing something?
> > 
> > Device performance wise, the benefits are certainly not obvious to me either.
> > But for very fast block devices, I think the CPU overhead of building more
> > smaller BIOs may be significant compared to splitting a large BIO into multiple
> > requests. Though it may be good to revisit this with some benchmark numbers.
> 
> This patch tries to address issue[1] in do_direct_IO() in which
> Changheun observed that other operations takes time between adding page
> to bio.
> 
> However, do_direct_IO() just does following except for adding bio and
> submitting bio:
> 
> - retrieves pages at batch(pin 64 pages each time from VM) and 
> 
> - retrieve block mapping(get_more_blocks), which is still done usually
> very less times for 32MB; for new mapping, clean_bdev_aliases() may
> take a bit time.
> 
> If there isn't system memory pressure, pin 64 pages won't be slow, but
> get_more_blocks() may take a bit time.
> 
> Changheun, can you check if multiple get_more_blocks() is called for submitting
> 32MB in your test?

almost one time called.

> 
> In my 32MB sync dio f2fs test on x86_64 VM, one buffer_head mapping can
> hold 32MB, but it is one freshly new f2fs.
> 
> I'd suggest to understand the issue completely before figuring out one
> solution.

Thank you for your advice. I'll analyze more about your point later. :)
But I think it's different from finding main time spend point in
do_direct_IO(). I think excessive loop should be controlled.
8,192 loops in do_direct_IO() - for 32MB - to submit one bio is too much
on 4KB page system. I want to apply a optional solution to avoid
excessive loop casued by multipage bvec.

Thanks,

Changheun Lee
