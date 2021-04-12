Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C15CC433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B6E6103D
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhDLDQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:16:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:17173 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhDLDQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 23:16:39 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210412031619epoutp0144996a084e0c01d80edb1f5ecf90c129~0-fF4xPOf3055630556epoutp01X
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:16:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210412031619epoutp0144996a084e0c01d80edb1f5ecf90c129~0-fF4xPOf3055630556epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618197379;
        bh=vrHRdUoCX7NtgXm2snZq+dUwQmYhXUg3ITk+yU5Iqf8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eF8gHtuO5xIRMtsp4pr/ydtG/kcrbqX9qAQa/IuFVCvsuNbozswle1Zumxa3+LscT
         JhaswFiXhI1nujAhNFs6dF9kyngizm/84ocZVatbVl6qfTdt732UudbAhUw0+8dASj
         DeH7m0hvw+Lnh4qebCy9zZsB0rdOuqIO5p2SpExM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210412031618epcas1p3ab36b11e41f2325c8fe877699800062f~0-fE1RR8S1533515335epcas1p3F;
        Mon, 12 Apr 2021 03:16:18 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FJYmH4pC2z4x9Q6; Mon, 12 Apr
        2021 03:16:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.0E.22618.F7BB3706; Mon, 12 Apr 2021 12:16:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210412031614epcas1p3fd234ea94ae348f8b8d2e3e179e195db~0-fBLydqs1287712877epcas1p3b;
        Mon, 12 Apr 2021 03:16:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210412031614epsmtrp15cfb02b4b95db12bf8a7f2ee25f833ae~0-fBKgUq80525705257epsmtrp1y;
        Mon, 12 Apr 2021 03:16:14 +0000 (GMT)
X-AuditID: b6c32a38-e4dff7000001585a-d8-6073bb7f76e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.74.33967.E7BB3706; Mon, 12 Apr 2021 12:16:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210412031614epsmtip101f3f4d3f7420afdd556089ebed864c0~0-fAzNJAu2610126101epsmtip1H;
        Mon, 12 Apr 2021 03:16:14 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v6 0/3] limit bio max size
Date:   Mon, 12 Apr 2021 11:58:28 +0900
Message-Id: <20210412025831.31498-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxjt3Q27kRa6jRbuUEdwR1seEhIgcEWgzsjo2tQZhvpgOmMhhi0E
        Q5Jmk7bwR2woWqA8pIggoEMRIdahBqQ8SlsDFhG0nfIatIA8ChZEKAyIVaZNWGz5953znbPn
        ++69K8RFDwk3oUpjYPUahZomHAX1rV4S3xPNXKxkKWMLKjHXA3RlMIdAZ+ee4ujzU0sYMn1d
        Q6DO3HIMZY1/5oBWMoYwtDjCoZZ7Pqi7qYRA1nwThgprS3DUN9xFotahXgEaqcjD0d2OeQdU
        NrYb/X35JkCzy/0kut2Qj6OalqfEbhemu0fO5Jkek0xj8SDJ1FZ5M913jIzF/AXB/Fj6DcnM
        /tBLMNl1ZsAsWLYwp37KxCJffl8dmsAq4li9B6tRauNUmvgwWv5ezJ4YWZBE6ivdiYJpD40i
        iQ2jI96N9N2rUts2pT0+VqiNNipSwXG0X3ioXms0sB4JWs4QRrO6OLVOKtGJOUUSZ9TEi5Xa
        pBCpROIvsylj1QkX7g9guj7i07mKi2QquCHIABuEkAqEs+eq8AzgKBRRDQA2PmnBeDAPYO1k
        NcmDJQALckf/s1xNfyTgGy0Aroz1r6kWAJzovkHYVQS1A2bP3CPsjU1UBwaXr3QCO8CpMQB7
        OtJXVRspb5g/2o7bawG1HRbWN5P22onaBUfHvgJ8njt8PpyF8/xrsKNofHUO3Mabrp9fHR1S
        40LYVt6A84YIeK6kE+PrjXCqvY7kazf4Z046yRsyATSlXwA8yAWwYrJyzREA5xcWbA2hLcIL
        1jT58fRW2PisFPDJzvDxYpaDXQIpJ3g6XcRLtsGutGH8Rdbk1ca1LzLw4dSj1RlE1FE4N9UF
        coF78bp9itftU/x/8EWAm4ELq+OS4llOqgtcf7MWsPrkvVEDKJ2ZE1sBJgRWAIU4vcnpWDIX
        K3KKUySnsHptjN6oZjkrkNlOOA93e12ptf0zGkOMVOYfEBCAAoOCg2QBtKvTMcmDGBEVrzCw
        x1lWx+pf+DDhBrdUTGq+Jli8O+fT+n3anZROqzM+ed/Vs6KlYOXX3/bsd6xOVR8lDx9iSrxC
        9VjGpeChGa5xWkWX/5JzOeSv08GVURL3zW1FmQfro+VpH+x3PDHRLP5welh0wKh6Yq133bX1
        ZwfPIxFlD5JXDs/T0TMjIc8vSSQJnxSMmCxhYeFVqeM7md4B5/LjA7q+xENjb06E5C9P949H
        qGehMvpIolyFZMK30RmlocaSfWt2QJkycLNt37bvot4q+7bH9MpLJ8uj/ikePNk0crswe6ha
        UyvTf1QqfpXYPmH025z4xo6DqWnyurOd4eddnnkq8d+pAzOCW5X7cq6jM91/qMXXiqLf8Wn/
        0p8WcAkKqTeu5xT/Ap3xmqZ7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnG7d7uIEg1PbJS3mrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBnzb99kKrjGVvFhyQL2BsaDLF2MnBwSAiYSa9veANlcHEICuxkllt/r
        YoZISEkcP/GWtYuRA8gWljh8uBii5iOjxJdbbYwgNWwCOhJ9b2+xgSREBG4zSVzachRsErPA
        a0aJrseLwFYIC2hJTH50HGwqi4CqxPRtu9lBbF4Ba4lHj6cwQmyTl/hzv4cZIi4ocXLmE7Be
        ZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM43rQ0
        dzBuX/VB7xAjEwfjIUYJDmYlEd6kyuIEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmk
        J5akZqemFqQWwWSZODilGphiH9RFZLEFZ29OdnkYUnozWMBsXrnJufVVv+bbOh/6qVYou+zB
        g9qkfCsphzN3ufIago+a9Yucuil72nh204X15aeOH1KRVzlwYor7iXyJvEsp/+xeTTttKFh/
        eW61w4Fps9iaTndrCsh3npu5ZdFxdtHgNV11x3dxuMpu6W4RELyWWPK2Ztup6fb+fgtyT+oE
        RzELH7u4pSb4nZH7+mkHP7NkL/x3TT7264dglX1/NZVr49YVzeFYd37qv8MLFXcXe++8ZhBc
        pL6vUe/H11WuIXvXNy+1fKKzcmqQ/NXGvcGzTt508E21WVMqcu3A49V/Fs47f3yRLQ//vtcc
        y3O7tT5KfGJeyiuxOfd045FXSizFGYmGWsxFxYkA1Q3TVCYDAAA=
X-CMS-MailID: 20210412031614epcas1p3fd234ea94ae348f8b8d2e3e179e195db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210412031614epcas1p3fd234ea94ae348f8b8d2e3e179e195db
References: <CGME20210412031614epcas1p3fd234ea94ae348f8b8d2e3e179e195db@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I found a inefficient behavior from multipage bvec. Large chunk DIO
scenario is that. This patch series could be a solution to improve it.

Changheun Lee (3):
  bio: limit bio max size
  ufs: set QUEUE_FLAG_LIMIT_BIO_SIZE
  bio: add limit_bio_size sysfs

 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 Documentation/block/queue-sysfs.rst   |  7 +++++++
 block/bio.c                           | 13 ++++++++++++-
 block/blk-settings.c                  | 17 +++++++++++++++++
 block/blk-sysfs.c                     |  3 +++
 drivers/scsi/scsi_lib.c               |  2 ++
 drivers/scsi/ufs/ufshcd.c             |  1 +
 include/linux/bio.h                   |  2 +-
 include/linux/blkdev.h                |  4 ++++
 include/scsi/scsi_host.h              |  2 ++
 10 files changed, 59 insertions(+), 2 deletions(-)

-- 
2.29.0

