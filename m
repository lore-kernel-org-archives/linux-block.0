Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4DC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 04:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A0B64ED3
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 04:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhBBE2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 23:28:35 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:39076 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBBE2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 23:28:35 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210202042751epoutp0285a17e5b5ecc4104963a240b4cef0cb2~f082CNqIk2307323073epoutp02c
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 04:27:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210202042751epoutp0285a17e5b5ecc4104963a240b4cef0cb2~f082CNqIk2307323073epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612240071;
        bh=FWTAxGClif/41PKmBWQeMaTVnLqMQzKg8jByey6k0Bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wgjk+3HkWQ7qQwGh1eZNFKFhEsLDFX65c5T6sCLBIBsIEQr/1rnoo4N/CDjt05VlS
         Ua6qNe3rqzZi/xiP3LSvim66JHZsYAKtvuGHY8YHFP/Yj+MggRD8gqObKNzctw5dx1
         AVBuTm+cU//kNvfOCIKo5+g5LEKUgaK/AblRr+RE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210202042750epcas1p1dd6d883c6e1d42106f3cf116f2268ae1~f081GKvQ42053420534epcas1p1l;
        Tue,  2 Feb 2021 04:27:50 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DVBch51Dyz4x9Q8; Tue,  2 Feb
        2021 04:27:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.55.10463.4C4D8106; Tue,  2 Feb 2021 13:27:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210202042747epcas1p2054df120098b3130cb104cf8e4731797~f08zA_e6B0070300703epcas1p2e;
        Tue,  2 Feb 2021 04:27:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210202042747epsmtrp235802df38edd0cc43be1b3a2cc14c049~f08y--VYu3109931099epsmtrp2K;
        Tue,  2 Feb 2021 04:27:47 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-2b-6018d4c4e23b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.2E.13470.3C4D8106; Tue,  2 Feb 2021 13:27:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210202042747epsmtip2ec1f1ba8c5f2d5c36f927d0a3bfb12d2~f08yuUNyx1571815718epsmtip2Z;
        Tue,  2 Feb 2021 04:27:47 +0000 (GMT)
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
Date:   Tue,  2 Feb 2021 13:12:04 +0900
Message-Id: <20210202041204.28995-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210201071413.GC9481@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjm3NveFma3a0E4VuK6ClmoAu1K4YigGD5yyRaDA/8QsHRwpbDS
        1rbMwRbXjQFa2ICh0xWQWZqBFYcBhkAsuLIv2FggDGeIY6BjX5FvmSBibLkQ+fe8532e93nf
        95zDxfm/EgJujsZI6zVKtYjwYnX0BYUGX7kDMyRjF19BtfYOgL69V0Gg4tJnGLpZacVQ+YMT
        bLRmHsfQ0qQBOcZeRSPdtQRyVhdh6Iu2Whz9fP8WB/WNj7LQpK0KR7f7F9joq99j0N+NVwGa
        Xb7LQQOd1ThqcawQMT5UVdEMh+qy3ONQbU1iamQwn2q1f0pQsz2jBHW63Q6oxdaXqdKfyrAk
        z1R1lIpWZtF6Ia3J1GblaLKjRXuTFbEKebhEGix9HUWIhBplHh0tituXFJyQo3aNJRIeUqrz
        XUdJSoNBFPpmlF6bb6SFKq3BGC2idVlqnVSiCzEo8wz5muyQTG1epFQi2SN3MTPUqrWGEkw3
        jg63WatxE6gWmoEnF5JhsLSsnGMGXlw+2Qng6lwH253gkwsAOpreZxLPALRMmFibiidDxwGT
        cABYMX2GzQSLAFonltdZBPkaPD09RrixD+kHi212zAy4XJwcwWFNght6kzL4ebO/m8EiA2HP
        L6c4bswj34CVDdc4jNdOOHWqEXdjTzII/tn/Nc5wnof95x6sO+EuTtGlGtzdAiQnuLD9rysY
        I46Dl84+ZjPYGz693r5RVAAXZxwEIygDsKikHjBBJYC2Rxc21DK4sLgImKaDYEt3KHO8C3at
        1gHGeTucWSpnuymQ5MFPSvgMJQDeOnkf3/R69F3XRkUKmhy9HGa7R+GPJ61EJRBatsxj2TKP
        5X/j8wC3A19aZ8jLpg1SXdjWC24F689cjDpB3fRciBNgXOAEkIuLfHgDZ3wz+LwsZUEhrdcq
        9Plq2uAEcte2q3DBC5la1z/RGBVS+R6ZTIbCwiPC5TKRH++AZELBJ7OVRvogTeto/aYO43oK
        TFhZRGzi5bdY++KnrMQ8NSQevvZP8Mg7n9mOfTD7wxFsuCNQ9b1nzdt1pvj0lf1Lqqwd9uRt
        vd38nvcCYo41X8yUq+fLrJTlHK89JSBe3Odr8zmrt3SlmTJGPyyu393oJ08PXLV3b4fX/a9S
        /nG8iYO7bzxN8Ut5bnCkwtd34d/JVvPAaEt1LGjK9UhKFYQ6dR8/zDV6eO0o+OPAS98kN5nf
        na+nWP03ClOj2ogLuQ9Ndd6SmISuZmHh7eAXG78ctnUq+vbuOrrWG73/hPhIYEHCk513Ltvm
        Ils+uukc2iZOnuqRnNfBquXIhvy7g4fSDq8kpvOPC+qcjz3i0yJ1iWu/tZhFLINKKRXjeoPy
        P5gvXhVvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvO7hKxIJBstXGVvMWbWN0WL13X42
        i9b2b0wWpycsYrLoedLEavG36x6TxdeHxRZ7b2lbXN41h83i0ORmJovpm+cwW1y7f4bd4vC9
        qywWD5dMZLY4d/ITq8W8xw4Wv5YfZbR4/+M6u8WpHZOZLdbv/cnmIOIxsfkdu8fOWXfZPTav
        0PK4fLbUY9OqTjaP9/uusnn0bVnF6PF5k5xH+4FupgDOKC6blNSczLLUIn27BK6Mv4vbmAru
        WVRsXjSZuYFxskIXIyeHhICJxMsLjYxdjFwcQgK7GSVW/57GDpGQkjh+4i1rFyMHkC0scfhw
        MUTNR0aJUzPXMYHUsAnoSPS9vcUGYosIiEu0LlnFBFLELPCaWWL1y32MIM3CAsYSU9fIgNSw
        CKhK7LvRCzafV8BaYsLiY1C75CWe9i5nBrE5BTQlvpxcCGYLCWhINM+9wAZRLyhxcuYTFhCb
        Gai+eets5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcdVqa
        Oxi3r/qgd4iRiYPxEKMEB7OSCO+pSWIJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTDNTr+X/Tz+idmTzIv9Xjnqol2WM+P6/vcuiUllesjZ8YhZ7eqk
        G2JpzHOz/uz+MatCPExh0umJOoKJd1QnGd9blXLpgnPLmX2zBDZmym6Yd+mkjYU5s4VZwyfl
        OzXJ8pt3LHr+SSlwqvcuwW3SLd2LHlT+9VhcYng55lZsoGnHlXVmyg9V3lffzst7YLRgzjOO
        yKUSb6Y4b8zkmcaVE+OmpyPWrF2ZxLmHVSZljuQskQWqCoy2Lk5S1ZsXTDwjyNbwM8X2+c3t
        M658tjLR+FY+tTKmb8rWxCeuKtYaZg4bL1kwF5fGyzt6+p+0zqpONt5Q21us8qDgyfPKY0fc
        0pZsrj986uPbyKMpc0LyuZRYijMSDbWYi4oTAeyNmYIpAwAA
X-CMS-MailID: 20210202042747epcas1p2054df120098b3130cb104cf8e4731797
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210202042747epcas1p2054df120098b3130cb104cf8e4731797
References: <20210201071413.GC9481@T590>
        <CGME20210202042747epcas1p2054df120098b3130cb104cf8e4731797@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Mon, Feb 01, 2021 at 11:52:48AM +0900, Changheun Lee wrote:
> > > On Fri, Jan 29, 2021 at 12:49:08PM +0900, Changheun Lee wrote:
> > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > but sometimes it would lead to inefficient behaviors.
> > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > physical addresses are contiguous. it makes some delay to submit
> > > > until merge complete. bio max size should be limited to a proper size.
> > > > 
> > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > kernel behavior is below now. it's timeline.
> > > > 
> > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > >  | total elapsed time is over 2ms.
> > > >  |------------------ ... ----------------------->|
> > > >                                                  | 8,192 pages merged a bio.
> > > >                                                  | at this time, first bio submit is done.
> > > >                                                  | 1 bio is split to 32 read request and issue.
> > > >                                                  |--------------->
> > > >                                                   |--------------->
> > > >                                                    |--------------->
> > > >                                                               ......
> > > >                                                                    |--------------->
> > > >                                                                     |--------------->|
> > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > 
> > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > 
> bio_iov_iter_get_pages> > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > >  | total 32 bio will be made.
> > > >  | total elapsed time is over 2ms. it's same.
> > > >  | but, first bio submit timing is fast. about 100us.
> > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > >       | 256 pages merged a bio.
> > > >       | at this time, first bio submit is done.
> > > >       | and 1 read request is issued for 1 bio.
> > > >       |--------------->
> > > >            |--------------->
> > > >                 |--------------->
> > > >                                       ......
> > > >                                                  |--------------->
> > > >                                                   |--------------->|
> > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > 
> > > Can you share us if enabling THP in your application can avoid this issue? BTW, you
> > > need to make the 32MB buffer aligned with huge page size. IMO, THP perfectly fits
> > > your case.
> > > 
> > 
> > THP is enabled already like as below in my environment. It has no effect.
> > 
> > cat /sys/kernel/mm/transparent_hugepage/enabled
> > [always] madvise never
> 
> The 32MB user buffer needs to be huge page size aligned. If your system
> supports bcc/bpftrace, it is quite easy to check if the buffer is
> aligned.
> 
> > 
> > This issue was reported from performance benchmark application in open market.
> > I can't control application's working in open market.
> > It's not only my own case. This issue might be occured in many mobile environment.
> > At least, I checked this problem in exynos, and qualcomm chipset.
> 
> You just said it takes 2ms for building 32MB bio, but you never investigate the
> reason. I guess it is from get_user_pages_fast(), but maybe others. Can you dig
> further for the reason? Maybe it is one arm64 specific issue.
> 
> BTW, bio_iov_iter_get_pages() just takes ~200us on one x86_64 VM with THP, which is
> observed via bcc/funclatency when running the following workload:
> 

I think you focused on bio_iov_iter_get_pages() because I just commented page
merge delay only. Sorry about that. I missed details of this issue.
Actually there are many operations during while-loop in do_direct_IO().
Page merge operation is just one among them. Page merge operation is called
by dio_send_cur_page() in while-loop. Below is call stack.

__bio_try_merge_page+0x4c/0x614
bio_add_page+0x40/0x12c
dio_send_cur_page+0x13c/0x374
submit_page_section+0xb4/0x304
do_direct_IO+0x3d4/0x854
do_blockdev_direct_IO+0x488/0xa18
__blockdev_direct_IO+0x30/0x3c
f2fs_direct_IO+0x6d0/0xb80
generic_file_read_iter+0x284/0x45c
f2fs_file_read_iter+0x3c/0xac
__vfs_read+0x19c/0x204
vfs_read+0xa4/0x144

2ms delay is not only caused by page merge operation. it inculdes many the
other operations too. But those many operations included page merge should
be executed more if bio size is grow up.

> [root@ktest-01 test]# cat fio.job
> [global]
> bs=32768k
> rw=randread
> iodepth=1
> ioengine=psync
> direct=1
> runtime=20
> time_based
> 
> group_reporting=0
> ramp_time=5
> 
> [diotest]
> filename=/dev/sde
> 
> 
> [root@ktest-01 func]# /usr/share/bcc/tools/funclatency bio_iov_iter_get_pages
> Tracing 1 functions for "bio_iov_iter_get_pages"... Hit Ctrl-C to end.
> ^C
> nsecs               : count     distribution
> 0 -> 1          : 0        |                                        |
> 2 -> 3          : 0        |                                        |
> 4 -> 7          : 0        |                                        |
> 8 -> 15         : 0        |                                        |
> 16 -> 31         : 0        |                                        |
> 32 -> 63         : 0        |                                        |
> 64 -> 127        : 0        |                                        |
> 128 -> 255        : 0        |                                        |
> 256 -> 511        : 0        |                                        |
> 512 -> 1023       : 0        |                                        |
> 1024 -> 2047       : 0        |                                        |
> 2048 -> 4095       : 0        |                                        |
> 4096 -> 8191       : 0        |                                        |
> 8192 -> 16383      : 0        |                                        |
> 16384 -> 32767      : 0        |                                        |
> 32768 -> 65535      : 0        |                                        |
> 65536 -> 131071     : 0        |                                        |
> 131072 -> 262143     : 1842     |****************************************|
> 262144 -> 524287     : 125      |**                                      |
> 524288 -> 1048575    : 6        |                                        |
> 1048576 -> 2097151    : 0        |                                        |
> 2097152 -> 4194303    : 1        |                                        |
> 4194304 -> 8388607    : 0        |                                        |
> 8388608 -> 16777215   : 1        |                                        |
> Detaching...
> 
> 
> 
> -- 
> Ming
> 

---
Changheun Lee
Samsung Electronics
