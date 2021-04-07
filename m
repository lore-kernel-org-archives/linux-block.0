Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7835C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 01:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D48D613B7
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 01:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhDGBjH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:39:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63027 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbhDGBjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 21:39:07 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210407013855epoutp032788db460fba077d8accfa2ce6509c11~zb7n9V3QW2024220242epoutp03Q
        for <linux-block@vger.kernel.org>; Wed,  7 Apr 2021 01:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210407013855epoutp032788db460fba077d8accfa2ce6509c11~zb7n9V3QW2024220242epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617759535;
        bh=/IatyjDjYBtgiMtNZkl+IbeRKfFDmHQeIeY3Cf+rcb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHkWLGibQZx7O1cy4BJ53kZWFwtL1H/hiaLLLhKjKEDxze1nbKck7gj8WaKHGYtaA
         gjVq1NN1vKglnyPgYHkwvEQfc0Nt0moPa54TPMLQ6Wb5CE0e7vQBk92mgtjBgPd5xm
         mMAB16HRAoVcKDr2Aux9Va5kC6QBC3nb3zAcVYiw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210407013854epcas1p2d954138f2ce91b2d10cba77a2f489aba~zb7nL81eV0994509945epcas1p2D;
        Wed,  7 Apr 2021 01:38:54 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FFRrC4Lqkz4x9Px; Wed,  7 Apr
        2021 01:38:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.90.07927.B2D0D606; Wed,  7 Apr 2021 10:38:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210407013850epcas1p2d305f138c9fa1431abba1ec44a382de9~zb7jdf21L0345603456epcas1p2_;
        Wed,  7 Apr 2021 01:38:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210407013850epsmtrp1ad9ace988d6ccbcbb5b99af50a640628~zb7jcYBhD3224532245epsmtrp1G;
        Wed,  7 Apr 2021 01:38:50 +0000 (GMT)
X-AuditID: b6c32a35-9bbff70000011ef7-ed-606d0d2bba2c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.4F.33967.A2D0D606; Wed,  7 Apr 2021 10:38:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210407013850epsmtip2d159c3adfda11c8f0222b518b8b598ec~zb7jMao0u2078720787epsmtip2R;
        Wed,  7 Apr 2021 01:38:50 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [RESEND PATCH v5 2/2] bio: add limit_bio_size sysfs
Date:   Wed,  7 Apr 2021 10:21:17 +0900
Message-Id: <20210407012117.21122-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <7c8d9787-f0eb-9ef1-6ebf-f383c27b599a@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPfe2txewenkIJ8VIV4cTGNBSyo5aDGaL3IUlVOcw4gxUuAGk
        r/VS4kjmyIqMMcYgqHMMGNkYmA7TpQMsIA7bMEDZlCEwIeOhm/UFbCCPTcgsvRD57/f4/M43
        3985h8T95gkRmaPLY4w6tUZCePPanGHRkRFCbbq0oV2EaixtAF2+c5pAn91/iKOPjy9hyHzR
        SqDvKy5gqOzuMT5aK53A0OI0i7rGItBQRw2BHFVmDJ25WoOjkckBAXJODPPQdEMljm72z/NR
        3a8J6FFTD0BzK6MC9J29CkfWrodEQiA99FMSXWmeFdDt1XcE9NUvwumhGybaZjlB0NdqmwX0
        3DfDBF3eYgH0gu05+nj3SUzlk6pRZjPqTMYoZnQZ+swcXVa8JGl/2u40RZxUFil7Ce2SiHVq
        LRMv2bNPFfl6jsbtVCLOV2tM7pJKzbKS6FeVRr0pjxFn69m8eAljyNQYZFJDFKvWsiZdVlSG
        XvuyTCqNUbjJdE12WWMj3zAX8uGD/l5QCMpFpcCLhFQsHHBNEKXAm/Sj7ADe7Jvlcck8gFes
        LRvJEoCda928zZHx6ycEXKMLQOdKHeCSBQAnmhz4OkVQO2H5zBixHgdQgXDonyUPhFPFPDhW
        NOJp+FMJcO1Sm2eAR4XCxcs2T11IvQJPltZvyIXA1ckyD+Plrve3OPkc4wv7z971MLibMbee
        wzn+MQk/cam4eA+cqnVunOMP/+xtEXCxCP5xuthjAVInATQXnwdcUgFgg6sR4yg5nF9YcDdI
        t0IYtHZEc+VtsP3fWsAJPwVnF8v46wikhLCk2I9DtsOBokl8U8v1ZTvGITT83CXhllUO4Oq1
        K6ACiKu32KneYqf6f+F6gFtAIGNgtVkMKzPItt6xDXgef7jCDipn7kc5AEYCB4AkLgkQ2k/l
        pvsJM9WHCxijPs1o0jCsAyjcy67ERc9k6N2/R5eXJlPEyOVyFBu3K04hlwQJ35dOpflRWeo8
        JpdhDIxxcw4jvUSF2MHRS8Nrdc9L8x3KwrjXfJffHsltqNWtFYwWBE+/9+Nq8qfdZ4uW6irI
        MPk+OUoxHVoZO9JKawcfVGlMQYS1z+ElfGM89UbnEz3vJq5GNoNhKxP8VvO5F7qSQ/aHHghd
        +WDHcm5sqlK3m/yLZJRFnfe+zSnpONTnvK0ctNh+7/rtTET93ikf9GJVAsZcaG2Kf2d7kC3Z
        fluags3k5HerdgzeEh49Ii65lR4zyMYkPVoOOuCK+fr806co5PMDH477+v89mdKiPGy+J0oK
        SGz8JTE47LHu4vWU5GOdQT0fLR4c+dk+N9P65LL3zp43eXsrJ3D1s0r/bEtCLygu+gqojo4t
        SHhstloWjhtZ9X92Mj1XhQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvK4Wb26CweEDhhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsEroyeZctYC97LV3w8eZyxgbFPqouRk0NCwETi9rFO9i5GLg4hgd2MEtu3
        LGOBSEhJHD/xlrWLkQPIFpY4fLgYouYjo8TKg6+ZQGrYBHQk+t7eYgOxRQTEJC5/+cYIUsQs
        sIBF4uDOE+wgCWEBB4m/S7cxg9gsAqoSX1dvAmvgFbCW6O5aALVMXuLP/R6wGk6g+Mkth1lB
        bCEBK4n+7g8sEPWCEidnPgGzmYHqm7fOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgWGeanl
        esWJucWleel6yfm5mxjB0amluYNx+6oPeocYmTgYDzFKcDArifDu6M1OEOJNSaysSi3Kjy8q
        zUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHJSlo+xEAnb92VW9lvdxz4tyHE
        eNrG/28u/O6ZtuTDimIVvRlym73Lj8dwyf/W2nMr+UKr8apn3sce38xwD34fEFZ7q9TdVewe
        h1/DsakaCTMTz0yy7F0UXLGmjjP4TNbNi9Onz7HXejf3vuE6Rb8jGqZXyn0f/2720lbc2PR5
        WRv3QlOLK/uXfZujVata9fVrctXch0eTxO1rJ/rMnCM6pyynYNondkuJ9puGgaJySxMdzl70
        22DqOVezcWnTt70vw8qTNzFPlX63d86iG4aybp+vflrVK3rYx/v4at3XyspHN24P8Fvo/mva
        0tZLxeLz9m99wHRHf8X13ueX5z02ZT6oymrMvHcDF1/6e7U7jkosxRmJhlrMRcWJAGe86XY9
        AwAA
X-CMS-MailID: 20210407013850epcas1p2d305f138c9fa1431abba1ec44a382de9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210407013850epcas1p2d305f138c9fa1431abba1ec44a382de9
References: <7c8d9787-f0eb-9ef1-6ebf-f383c27b599a@acm.org>
        <CGME20210407013850epcas1p2d305f138c9fa1431abba1ec44a382de9@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 3/16/21 12:44 AM, Changheun Lee wrote:
> > Add limit_bio_size block sysfs node to limit bio size.
> > Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
> > And bio max size will be limited by queue max sectors via
> > QUEUE_FLAG_LIMIT_BIO_SIZE set.
> > 
> > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > ---
> >  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
> >  Documentation/block/queue-sysfs.rst   |  7 +++++++
> >  block/blk-sysfs.c                     |  3 +++
> >  3 files changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> > index e34cdeeeb9d4..86a7b15410cf 100644
> > --- a/Documentation/ABI/testing/sysfs-block
> > +++ b/Documentation/ABI/testing/sysfs-block
> > @@ -316,3 +316,13 @@ Description:
> >  		does not complete in this time then the block driver timeout
> >  		handler is invoked. That timeout handler can decide to retry
> >  		the request, to fail it or to start a device recovery strategy.
> > +
> > +What:		/sys/block/<disk>/queue/limit_bio_size
> > +Date:		Feb, 2021
> > +Contact:	Changheun Lee <nanich.lee@samsung.com>
> > +Description:
> > +		(RW) Toggle for set/clear QUEUE_FLAG_LIMIT_BIO_SIZE queue flag.
> > +		Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size
> > +		is set. And bio max size will be limited by queue max sectors.
> > +		QUEUE_FLAG_LIMIT_BIO_SIZE will be cleared if limit_bio_size is
> > +		cleard. And limit of bio max size will be cleard.
> > diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> > index 2638d3446b79..cd371a821855 100644
> > --- a/Documentation/block/queue-sysfs.rst
> > +++ b/Documentation/block/queue-sysfs.rst
> > @@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
> >  do not support zone commands, they will be treated as regular block devices
> >  and zoned will report "none".
> >  
> > +limit_bio_size (RW)
> > +-------------------
> > +This indicates QUEUE_FLAG_LIMIT_BIO_SIZE queue flag value. And
> > +QUEUE_FLAG_LIMIT_BIO_SIZE can be changed via set(1)/clear(0) this node.
> > +bio max size will be limited by queue max sectors via set this node. And
> > +limit of bio max size will be cleard via clear this node.
> > +
> >  Jens Axboe <jens.axboe@oracle.com>, February 2009
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index b513f1683af0..840d97f427e6 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -288,6 +288,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
> >  QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
> >  QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
> >  QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
> > +QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
> >  #undef QUEUE_SYSFS_BIT_FNS
> >  
> >  static ssize_t queue_zoned_show(struct request_queue *q, char *page)
> > @@ -615,6 +616,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
> >  QUEUE_RW_ENTRY(queue_iostats, "iostats");
> >  QUEUE_RW_ENTRY(queue_random, "add_random");
> >  QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
> > +QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
> >  
> >  static struct attribute *queue_attrs[] = {
> >  	&queue_requests_entry.attr,
> > @@ -648,6 +650,7 @@ static struct attribute *queue_attrs[] = {
> >  	&queue_rq_affinity_entry.attr,
> >  	&queue_iostats_entry.attr,
> >  	&queue_stable_writes_entry.attr,
> > +	&queue_limit_bio_size_entry.attr,
> >  	&queue_random_entry.attr,
> >  	&queue_poll_entry.attr,
> >  	&queue_wc_entry.attr,
> 
> Has it been considered to introduce a function to set the BIO size limit
> instead of introducing a new sysfs attribute? See also
> blk_queue_max_hw_sectors().

A function to set has been not considered yet.
But sysfs attribute should be supported I think. Because it can be
different depending on each system environment including policy.

> 
> Thanks,
> 
> Bart.

Thanks,

Changheun Lee
