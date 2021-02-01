Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F8CC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 03:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF75864E15
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 03:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBADJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 22:09:20 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:14912 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhBADJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 22:09:18 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210201030834epoutp02f9fb68ad78835f6663ff7d00ea6df011~fgOVRV6WG2116521165epoutp02E
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 03:08:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210201030834epoutp02f9fb68ad78835f6663ff7d00ea6df011~fgOVRV6WG2116521165epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612148914;
        bh=2X6s6Byp5hGoC3Vt4J+psoY5PnmWgorBVJRav6oy12E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOqDjLHu9bblVzRyh5Ac/Ub3U5VoAO6CTtxTRHnPYKrzbmj1xs11ME+SNKTdSO7zH
         6Ad4e+4Gh6axDyr6zbZ9F+RFZwQIEA9phXgvyL/lCHdFqzK97M6oAD9SbFk/t3B0Aw
         x3UQaVxgSzciCySihrFFymcxjZnx6zPhMAr+q4xE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210201030832epcas1p13a1f5b96e69bac616d8d3a3dd3f09e7e~fgOTzbyGx2198121981epcas1p1I;
        Mon,  1 Feb 2021 03:08:32 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DTXvg1Qr3z4x9QB; Mon,  1 Feb
        2021 03:08:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.61.09582.FA077106; Mon,  1 Feb 2021 12:08:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210201030830epcas1p402e8a088fb16af9fbbb130b152e097f1~fgORpGm0N3073530735epcas1p4D;
        Mon,  1 Feb 2021 03:08:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210201030830epsmtrp140704a88c563377cd6648c9378e6adca~fgORoF3fW0576405764epsmtrp1W;
        Mon,  1 Feb 2021 03:08:30 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-5e-601770af2ebc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.18.13470.DA077106; Mon,  1 Feb 2021 12:08:29 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210201030829epsmtip1e5aec054bd398f857b218e3dbba4d7ca~fgOQrn5j00058900589epsmtip1Y;
        Mon,  1 Feb 2021 03:08:29 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     nanich.lee@samsung.com
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v4 1/2] bio: limit bio max size
Date:   Mon,  1 Feb 2021 11:52:48 +0900
Message-Id: <20210201025248.17679-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210129034909.18785-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmru76AvEEg01zWS3mrNrGaLH6bj+b
        RWv7NyaL0xMWMVn0PGlitfjbdY/J4uvDYou9t7QtLu+aw2ZxaHIzk8X0zXOYLa7dP8Nucfje
        VRaLh0smMlucO/mJ1WLeYweLX8uPMlq8/3Gd3eLUjsnMFuv3/mRzEPGY2PyO3WPnrLvsHptX
        aHlcPlvqsWlVJ5vH+31X2Tz6tqxi9Pi8Sc6j/UA3UwBnVI5NRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBbSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
        4hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIy1794xFXyVqLj/7SlbA2M7fxcj
        B4eEgInEqeOGXYxcHEICOxglJhx+w9rFyAnkfGKUWLZVGyLxjVGisX8iWAKkYee8BcwQib2M
        EicPPGSCcD4zSqy9s5kdpIpNQEei7+0tNhBbREBKYsvjlywgRcwCF5glDk28xwiyW1jAWGLq
        GhkQk0VAVWLG1xCQcl4Ba4m1u/5DLZOXeNq7nBnE5hSwkbi5YB4jRI2gxMmZT1hAbGagmuat
        s8EOkhB4wCGxsP0OG0Szi8SjRWugBglLvDq+hR3ClpJ42d/GDtHQzSjR3DafEcKZwCix5Pky
        JogqY4lPnz+DHcosoCmxfpc+RFhRYufvuYwQm/kk3n3tYYWEI69ER5sQRImKxJmW+8wwu56v
        3Qk10UPizMKzjJDA6meUWHjrDeMERoVZSB6aheShWQibFzAyr2IUSy0ozk1PLTYsMEaO4U2M
        4HSuZb6DcdrbD3qHGJk4GA8xSnAwK4nwnpokliDEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST
        84EZJa8k3tDUyNjY2MLEzNzM1FhJnDfJ4EG8kEB6YklqdmpqQWoRTB8TB6dUA9OjC8kGW0X4
        tA5p/JbOS5Mx2rKz1f609z2DdZrrfzFunMfyf4Nd4ay5G6TPsH0/1CJzyM3XQ3OxnA2PZsaP
        RZ3rma8dEBZlXiI4SY9P1snWNjz9hvTBzJYZ3zk2b7SerLX6sCvHkyNrLpyo+lEyQ7vlzYW2
        ijdxDJ5nTrplR+7fJN8zR232BkfN/xtcmbtFPJ8Xx+1duiKk/IPJsfrz5y5/1PGf1vi+iTfE
        PWnfZUnepTM0blpM4P57ykJM1HfW/q5+7a7VgWrrGqu3CjbmhGxh31/LfmVaZqniAXnJJVoW
        k12vztXPS91cKn2E70te4FH2zFqjSymhwj2r3m8LN34+defH4PJwoQw5ThOF80osxRmJhlrM
        RcWJAI9ZTU1wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO7aAvEEg7sH+SzmrNrGaLH6bj+b
        RWv7NyaL0xMWMVn0PGlitfjbdY/J4uvDYou9t7QtLu+aw2ZxaHIzk8X0zXOYLa7dP8Nucfje
        VRaLh0smMlucO/mJ1WLeYweLX8uPMlq8/3Gd3eLUjsnMFuv3/mRzEPGY2PyO3WPnrLvsHptX
        aHlcPlvqsWlVJ5vH+31X2Tz6tqxi9Pi8Sc6j/UA3UwBnFJdNSmpOZllqkb5dAlfG2nfvmAq+
        SlTc//aUrYGxnb+LkZNDQsBEYue8BcxdjFwcQgK7GSUWXZvCDpGQkjh+4i1rFyMHkC0scfhw
        MUTNR0aJR/d62UBq2AR0JPre3gKzRYDqtzx+yQJSxCzwglnixfcbzCDNwgLGElPXyICYLAKq
        EjO+hoCU8wpYS6zd9Z8VYpW8xNPe5cwgNqeAjcTNBfMYQcqFgGq+PdKCKBeUODnzCQuIzQxU
        3rx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjjgtzR2M
        21d90DvEyMTBeIhRgoNZSYT31CSxBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYVD3Tgpi1nxdUG0VwTQr+s2aNc9eD5W1OBd9+P7rxb6/w3KmqMxv8
        fpx0YHz0V+YS6xXG7x3ZvmXHNaeFp8lw9AetnSmuMmPmqsAXF17pmXKu+sR791eb1p5U24lr
        HwWIzd4QvCq3/Z3Azye5IgXnruspz1Rnep1eOHmT0LzNRoETXQ7ar0k8WtC0eGnZ51xuJe9f
        v80r7nd/CbY3nyqgdGjfMqO9tzVWKScsFG5cm6u285vNdJVciV1TMnpyg9vytE8qXKsofbXh
        mOmNa9u3CcXxfK45Ijk/XOva5BuswXuCNlc+mnzzY0lXaJ3MI4PbU/tlawIrDBZlT5e6wuGd
        46P8Pl+WR2ft5Y77P7PklViKMxINtZiLihMB1sDmxCcDAAA=
X-CMS-MailID: 20210201030830epcas1p402e8a088fb16af9fbbb130b152e097f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210201030830epcas1p402e8a088fb16af9fbbb130b152e097f1
References: <20210129034909.18785-1-nanich.lee@samsung.com>
        <CGME20210201030830epcas1p402e8a088fb16af9fbbb130b152e097f1@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Fri, Jan 29, 2021 at 12:49:08PM +0900, Changheun Lee wrote:
> > bio size can grow up to 4GB when muli-page bvec is enabled.
> > but sometimes it would lead to inefficient behaviors.
> > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > all pages for 32MB would be merged to a bio structure if the pages
> > physical addresses are contiguous. it makes some delay to submit
> > until merge complete. bio max size should be limited to a proper size.
> > 
> > When 32MB chunk read with direct I/O option is coming from userspace,
> > kernel behavior is below now. it's timeline.
> > 
> >  | bio merge for 32MB. total 8,192 pages are merged.
> >  | total elapsed time is over 2ms.
> >  |------------------ ... ----------------------->|
> >                                                  | 8,192 pages merged a bio.
> >                                                  | at this time, first bio submit is done.
> >                                                  | 1 bio is split to 32 read request and issue.
> >                                                  |--------------->
> >                                                   |--------------->
> >                                                    |--------------->
> >                                                               ......
> >                                                                    |--------------->
> >                                                                     |--------------->|
> >                           total 19ms elapsed to complete 32MB read done from device. |
> > 
> > If bio max size is limited with 1MB, behavior is changed below.
> > 
> >  | bio merge for 1MB. 256 pages are merged for each bio.
> >  | total 32 bio will be made.
> >  | total elapsed time is over 2ms. it's same.
> >  | but, first bio submit timing is fast. about 100us.
> >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> >       | 256 pages merged a bio.
> >       | at this time, first bio submit is done.
> >       | and 1 read request is issued for 1 bio.
> >       |--------------->
> >            |--------------->
> >                 |--------------->
> >                                       ......
> >                                                  |--------------->
> >                                                   |--------------->|
> >         total 17ms elapsed to complete 32MB read done from device. |
> 
> Can you share us if enabling THP in your application can avoid this issue? BTW, you
> need to make the 32MB buffer aligned with huge page size. IMO, THP perfectly fits
> your case.
> 

THP is enabled already like as below in my environment. It has no effect.

cat /sys/kernel/mm/transparent_hugepage/enabled
[always] madvise never

This issue was reported from performance benchmark application in open market.
I can't control application's working in open market.
It's not only my own case. This issue might be occured in many mobile environment.
At least, I checked this problem in exynos, and qualcomm chipset.

> 
> Thanks,
> Ming
> 
> 

---
Changheun Lee
Samsung Electronics.
