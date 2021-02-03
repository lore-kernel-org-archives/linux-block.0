Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B4BC433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 05:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A35D64F61
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 05:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhBCFqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:46:30 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:45883 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBCFq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 00:46:29 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210203054545epoutp04fc15136912b43d1ff699c262a181958c~gJqKASSBR2637226372epoutp04_
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 05:45:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210203054545epoutp04fc15136912b43d1ff699c262a181958c~gJqKASSBR2637226372epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612331146;
        bh=MbBOs5BpvXDA1a6a53r0LijwPcL/qgWqrHQkhMY88aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dguxC1EirYJi1aIXCf4sDmjcj5D0vOfOTskemKipQMbtQROpL1EZsuUr/NIjjXEit
         VNE9O6rSDkQssgUhWy/uSHUfvpRO58bzalZINPI+VsrVoEurnoILJHmiUqpO0pET6D
         rjhZ2A1fL+Dm1WAKfoGT5dH54ggTv39iCX5r5yYI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210203054545epcas1p1d57c795ec58dec541a476b49c1ae931d~gJqJHyLPA0501205012epcas1p1s;
        Wed,  3 Feb 2021 05:45:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DVrJ756w4z4x9Q4; Wed,  3 Feb
        2021 05:45:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.30.63458.7883A106; Wed,  3 Feb 2021 14:45:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210203054543epcas1p454a7520710a1ae066237375691db90fd~gJqHaednj1540215402epcas1p4E;
        Wed,  3 Feb 2021 05:45:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210203054543epsmtrp1716b45cfe6a69c43b11c8335b18be021~gJqHZeKg32943129431epsmtrp1T;
        Wed,  3 Feb 2021 05:45:43 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-24-601a3887079e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.BC.13470.6883A106; Wed,  3 Feb 2021 14:45:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210203054542epsmtip2c40afbd91fb1e47dcbb731ff84f4cc01~gJqHJmiaL2923529235epsmtip2n;
        Wed,  3 Feb 2021 05:45:42 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     ming.lei@redhat.com
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v4 1/2] bio: limit bio max size
Date:   Wed,  3 Feb 2021 14:30:01 +0900
Message-Id: <20210203053001.26083-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210203034031.GC948998@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxT3vldeH4a6Z6lyU8yoL84NFGip4GXAYiYxdXMZG8m+nCkPeAFc
        v9bXOjCADZ8DkfIRJAJzm8GxlQ0MIlICbIEsgIpxMtz4KrAqCARwEJhzE9fyJOO/3zn39zu/
        c869l8TFw4SUTNGZWKOO0dDEVkFLt788MB9J4+TFc3tRja0FoPoxK4Fy81cxdLPkEoaK7md5
        oKeFDgytTHKoY3gfGmirIVBXeTaGKq/W4Oje+C0h6nYMCtBkbSmObvcteaCLzkPoSd3PAC0+
        /k2IbrSW46ix42/ikERVmr0gVNmrxoSqq98GqAb6zaomWwGhWuwcJFTFzTagWm56UZX/01ks
        xvMjTWQyyySyRhmrS9AnpuiSoug3Y9WH1aFhckWgIhwdpGU6RstG0dHHYgKPpGhcY9GyU4zG
        7ErFMBxHB78WadSbTawsWc+ZomjWkKgxKOSGII7RcmZdUlCCXvuqQi4PCXUx4zTJd4eLBIaZ
        oNQ7Aw24BfT6FQJPElIHoMW+CArBVlJMtQI4al/F3AdiagnAopF4Hq8COJkl3xDk9cwTvKAD
        wJu/V+F8sAxgZZeTcLMIaj8snh9exxLKB+bW2lxVSRKnBnBYfcQNvSklrPh+l5shoF6C3/2V
        I3CnRVQEvLLyLm/lBx+cq8Pd2JPaBy39QwI3FlHbYd+F++sYd3Gyr1WvdwCpCRKONl4S8OJo
        eOGhBeOxN5ztaRbyWApnrHlCXnAWwOy8LwEflABYO/3Nc4USLi0vA75nf9jYFsynd0P7P18A
        3nkbXFgp8nBTICWCn+eJecoeeCtnHN/wmv7B/ryiCg71ZRP8PjPh4LkCrATIqjbNU7Vpnqr/
        jb8CuA3sZA2cNonlFIaQzdfbBNYfeUBYKyibfxTUBTASdAFI4rREdKNsZ5xYlMiknWaNerXR
        rGG5LhDqWnYpLt2RoHf9Ep1JrQgNUSqV6EDYwbBQJe0jYuQTajGVxJjYT1jWwBo3dBjpKbVg
        msi6vvEWam+yZK4uOOvDzmbp+zGpfq//+cK01tFuNT08vvq2fWhXpPdY+Ht51xwRJ6a0f/yY
        KbvThK06dZaO7sfawx6vdDTHepQWino/daaNPK2uM1ypeON6Q2ysf7fa3HcbXT9WIR7+dar0
        l5n49ohHc3um4jq9Tsm3FTh9lbbxXpY8ucU/ADzrNDWUnIlf6g+osPYM7pCo88ndT8rSTzdd
        HrjX5pUpSJcsjVoXRpyfpc46Lq4VFtQfX8uhM6gF33cEZ74+6rPlhO+o/37irVYrrJ+9/PHa
        B5OVjMOzoBvkJqS+PH5XndYuAuUZfg+CosPPn/eaIIsX/n2GZ5zs355OC7hkRhGAGznmP0gx
        TT5tBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvG67hVSCwZIuZos5q7YxWqy+289m
        0dr+jcni9IRFTBY9T5pYLf523WOy+Pqw2GLvLW2Ly7vmsFkcmtzMZDF98xxmi2v3z7BbHL53
        lcXi4ZKJzBbnTn5itZj32MHi1/KjjBbvf1xntzi1YzKzxfq9P9kcRDwmNr9j99g56y67x+YV
        Wh6Xz5Z6bFrVyebxft9VNo++LasYPT5vkvNoP9DNFMAZxWWTkpqTWZZapG+XwJVx6VYPS8FL
        vYoLl9cxNzCekO9i5OSQEDCRaDv+lg3EFhLYzShx+GQ0RFxK4viJt6xdjBxAtrDE4cPFECUf
        GSVeXlQEsdkEdCT63t4CaxUREJdoXbKKqYuRi4NZ4DWzxOqX+xhBeoUFjCWmrpEBqWERUJVY
        +b2FBSTMK2AtseFrEMQmeYmnvcuZQWxOAW2JhrM3WSBWaUlc+3yfEcTmFRCUODnzCVicGai+
        eets5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcb1qaOxi3
        r/qgd4iRiYPxEKMEB7OSCO+pSWIJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJ
        zU5NLUgtgskycXBKNTDNEA94kKj043reJLenNlu/uwReCZlytOljv+3HwnlbzneozM85rbDp
        k5dlYPRRRlabBVfjmg06F/59lRV5NsRuub/1h8SuWO8pVje2nXM8NLnvdPMdSS3jHu/YjkX6
        jr+T2GW1WeU+pET4hWxuN846YyKgerLJc1dV7ObLq5RuTf4ilP3tpMGU42f96v0WT/XxaJiv
        ctyNl3fPtVd91mvlCsRLp7k/KOrnOvmD+WfWpUr+KZrO7tqLXf9pSHNd91bIv+J4nfuQYJen
        VMfyWV8Srh4/sm9XRm3pB7sTq29H7J3A/JfvKlvYDUPOKrvNvLIXf6yridPMWPCv/Pr3paLL
        z1217LA5z16h6K5txKXEUpyRaKjFXFScCACwUX6wJgMAAA==
X-CMS-MailID: 20210203054543epcas1p454a7520710a1ae066237375691db90fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210203054543epcas1p454a7520710a1ae066237375691db90fd
References: <20210203034031.GC948998@T590>
        <CGME20210203054543epcas1p454a7520710a1ae066237375691db90fd@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Feb 02, 2021 at 01:12:04PM +0900, Changheun Lee wrote:
> > > On Mon, Feb 01, 2021 at 11:52:48AM +0900, Changheun Lee wrote:
> > > > > On Fri, Jan 29, 2021 at 12:49:08PM +0900, Changheun Lee wrote:
> > > > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > > > but sometimes it would lead to inefficient behaviors.
> > > > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > > > physical addresses are contiguous. it makes some delay to submit
> > > > > > until merge complete. bio max size should be limited to a proper size.
> > > > > > 
> > > > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > > > kernel behavior is below now. it's timeline.
> > > > > > 
> > > > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > > > >  | total elapsed time is over 2ms.
> > > > > >  |------------------ ... ----------------------->|
> > > > > >                                                  | 8,192 pages merged a bio.
> > > > > >                                                  | at this time, first bio submit is done.
> > > > > >                                                  | 1 bio is split to 32 read request and issue.
> > > > > >                                                  |--------------->
> > > > > >                                                   |--------------->
> > > > > >                                                    |--------------->
> > > > > >                                                               ......
> > > > > >                                                                    |--------------->
> > > > > >                                                                     |--------------->|
> > > > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > > > 
> > > > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > > > 
> > > bio_iov_iter_get_pages> > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > > > >  | total 32 bio will be made.
> > > > > >  | total elapsed time is over 2ms. it's same.
> > > > > >  | but, first bio submit timing is fast. about 100us.
> > > > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > > > >       | 256 pages merged a bio.
> > > > > >       | at this time, first bio submit is done.
> > > > > >       | and 1 read request is issued for 1 bio.
> > > > > >       |--------------->
> > > > > >            |--------------->
> > > > > >                 |--------------->
> > > > > >                                       ......
> > > > > >                                                  |--------------->
> > > > > >                                                   |--------------->|
> > > > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > > 
> > > > > Can you share us if enabling THP in your application can avoid this issue? BTW, you
> > > > > need to make the 32MB buffer aligned with huge page size. IMO, THP perfectly fits
> > > > > your case.
> > > > > 
> > > > 
> > > > THP is enabled already like as below in my environment. It has no effect.
> > > > 
> > > > cat /sys/kernel/mm/transparent_hugepage/enabled
> > > > [always] madvise never
> > > 
> > > The 32MB user buffer needs to be huge page size aligned. If your system
> > > supports bcc/bpftrace, it is quite easy to check if the buffer is
> > > aligned.
> > > 
> > > > 
> > > > This issue was reported from performance benchmark application in open market.
> > > > I can't control application's working in open market.
> > > > It's not only my own case. This issue might be occured in many mobile environment.
> > > > At least, I checked this problem in exynos, and qualcomm chipset.
> > > 
> > > You just said it takes 2ms for building 32MB bio, but you never investigate the
> > > reason. I guess it is from get_user_pages_fast(), but maybe others. Can you dig
> > > further for the reason? Maybe it is one arm64 specific issue.
> > > 
> > > BTW, bio_iov_iter_get_pages() just takes ~200us on one x86_64 VM with THP, which is
> > > observed via bcc/funclatency when running the following workload:
> > > 
> > 
> > I think you focused on bio_iov_iter_get_pages() because I just commented page
> > merge delay only. Sorry about that. I missed details of this issue.
> > Actually there are many operations during while-loop in do_direct_IO().
> > Page merge operation is just one among them. Page merge operation is called
> > by dio_send_cur_page() in while-loop. Below is call stack.
> > 
> > __bio_try_merge_page+0x4c/0x614
> > bio_add_page+0x40/0x12c
> > dio_send_cur_page+0x13c/0x374
> > submit_page_section+0xb4/0x304
> > do_direct_IO+0x3d4/0x854
> > do_blockdev_direct_IO+0x488/0xa18
> > __blockdev_direct_IO+0x30/0x3c
> > f2fs_direct_IO+0x6d0/0xb80
> > generic_file_read_iter+0x284/0x45c
> > f2fs_file_read_iter+0x3c/0xac
> > __vfs_read+0x19c/0x204
> > vfs_read+0xa4/0x144
> > 
> > 2ms delay is not only caused by page merge operation. it inculdes many the
> > other operations too. But those many operations included page merge should
> > be executed more if bio size is grow up.
> 
> OK, got it.
> 
> Then I think you can just limit bio size in dio_bio_add_page() instead of
> doing it for all.

Root cause is increasing of bio size after multipage bvec applying.
So I think basic solution is limitation of bio size.
Similar problem might be occurred in various scenario too. becasue bio merge
function is called from many case in kernel. And bio max size was 1MB before
applying of multipage bvec. So I think limitation of bio is reasonable.
I think this solution is not bad for all. Becasue it just only activated by
queue flag case by case.

> 
> -- 
> Ming
> 
> 
---
Changheun Lee
Samsung Electronics
