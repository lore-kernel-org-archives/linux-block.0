Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F89C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D400F208C3
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 07:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bpG6DOfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfEMHeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 03:34:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35660 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfEMHeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 03:34:07 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190513073403epoutp0382354c9a0d50f1f7c961c28a6c7394c9~eLcSrTgDf3127831278epoutp031
        for <linux-block@vger.kernel.org>; Mon, 13 May 2019 07:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190513073403epoutp0382354c9a0d50f1f7c961c28a6c7394c9~eLcSrTgDf3127831278epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557732843;
        bh=kQz0DogA4qraBOcJHvSDzZ0YSMMfavN8vJ/KCEb+dUE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=bpG6DOfMlZ4KVUpUCWWqSbSDMaDbhqS644iM5neFKpu6wztjMNvUm+R4cC7YH0Lz3
         yWHI4jP+xYyO24XwlXLsN0tUOneM0Y1aznx/psdVbLN3AfeTwEFec5W9dhwdROWYku
         vPoOLl8HPkSO+xzeksa4AClBrWcJ8keMXkhdwGPs=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190513073401epcas2p297beb0696eae2dbdd4a33549845e0064~eLcQjbz0B1285212852epcas2p2e;
        Mon, 13 May 2019 07:34:01 +0000 (GMT)
X-AuditID: b6c32a48-689ff7000000106f-30-5cd91de87f95
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.0C.04207.8ED19DC5; Mon, 13 May 2019 16:34:00 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 05/10] block: initialize the write priority in
 blk_rq_bio_prep
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        Minwoo Im <minwoo.im@samsung.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190513063754.1520-6-hch@lst.de>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190513073400epcms2p6669154b6e63b88e58a34996dec71205a@epcms2p6>
Date:   Mon, 13 May 2019 16:34:00 +0900
X-CMS-MailID: 20190513073400epcms2p6669154b6e63b88e58a34996dec71205a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUYRSG+XbGcbQmxnWrk5FtExEZq7vmblNkRUZMaCVdIETaBp3Wrb21
        s9oFoq2tNrbITIRQSyHR0rIwyyVLZL1UdI8UNZR+ZJm3kqLsYrXj2OXfw8s57/ud8x0SU+YS
        UaTZ5hKcNt7CEOH4zaYFek3frM507eebkeyv260Ee6mqRcHe6VrIXqxrxtlAvkfBvnnQiK0k
        uDzPcCh3om0UcfWdboJ739BGcKdqKxH3sSY6lUizLMsS+EzBqRZsGfZMs82UyCRvMiYZ9Qat
        TqNbwi5m1DbeKiQyq1NSNWvMluArGHUOb8kOSqm8KDJxy5c57dkuQZ1lF12JjODItDh0Okes
        yFvFbJspNsNuXarTauP1wcrtlqwbd8sIRwva62v+jrtRjg+RJNAJ4H4V4UPhpJL2Izh5oRuX
        dIqOgDF/pA+FkZH0ZmhsPUVIspKeDaP9WlleAMP1D0MkJuj54C7oH+9U0TvgXYdKcsToMwge
        fvFgUg3QFJz19uIyz4S6ihtI4jA6DvoCuaGyPhU6q4b+8vvWEiSzCo72PJrwiYBXX+uR/HqA
        nuHlMh6E2ousFAv0EQQdg1cmWuPg0NuR8ViKXgcfhisVEuP0PPiZXzRhuRpa330aj8WCE9YN
        FWOSJxYc8eqtONl+LjR34XLFFDjeNBb6Zyj/+dcKmefCSCAw4TgDKp4PEDJzkPv0WYi84yIE
        Xx+VEqeRuvDfmgv/Cy78F1yKsEo0TXCIVpMgxjsS/v/XGjR+jDGcHzU+TgkgmkTMZMr/uiNd
        GcLniPusAQQkxqiotDlBicrk9+0XnHajM9siiAGkD86fh0VNzbAHT9vmMur08QaDdome1Rvi
        WWY6VTOpM11Jm3iXsEsQHILzT5+CDItyo5Lqb1UbryY9bT+3qstQPNht+JnfTlX8wD2LbimK
        k19683xh3g2Okq27m6tNPdULX5zdqTt8zOxq8PRHdKd5MWOZQRN6YG/BtW33168s4O61lZcH
        nmhUT7yXB0Yqy6ii69wWTin2RqfO+rBCXBtdNTY5adDS8nhP32iT9dhBvtzM4GIWr4vBnCL/
        G75vtouiAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190513063855epcas5p33ef8c4c0a0055bd0b66eadc859796f0f
References: <20190513063754.1520-6-hch@lst.de>
        <20190513063754.1520-1-hch@lst.de>
        <CGME20190513063855epcas5p33ef8c4c0a0055bd0b66eadc859796f0f@epcms2p6>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The priority fiel also make sense for passthrough requests, so
                           ^^^^
                       `s/fiel/field`
I think it's trivial so that it can be done with merging.
