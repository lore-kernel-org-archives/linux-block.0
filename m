Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69494C6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D5720892
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D5720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbeLNMjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:39:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730651AbeLNMFO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE328C20477D3;
        Fri, 14 Dec 2018 20:05:07 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Dec 2018
 20:04:59 +0800
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Subject: Question on t10_pi_ref_tag()
Message-ID: <0336fcc8-cfc5-ab51-b2cd-3ad6b971cc8a@huawei.com>
Date:   Fri, 14 Dec 2018 12:04:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I have a question on this function in the $subject.

In https://marc.info/?l=linux-kernel&m=154466776014573&w=2, Martin 
recommended using this function.

However, for our driver, we find it returns 0 always, as 
rq->q->integrity.interval_exp = 0.

Our host is advertised DIF capable only. I assume that interval_exp 
would be set somehow from 
sd_dif_config_host()->blk_integrity_register(), but we don't follow this 
path for !DIX.

What would we be missing that this is unset?

Thanks,
John

