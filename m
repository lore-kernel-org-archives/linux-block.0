Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8908F6120F
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhJUMSv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:18:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25306 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUMSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 08:18:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HZmYp60hszbdPV;
        Thu, 21 Oct 2021 20:11:58 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 20:16:33 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Thu, 21
 Oct 2021 20:16:32 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <paskripkin@gmail.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <luomeng12@huawei.com>
Subject: [PATCH 0/2] nbd: fix sanity check for first_minor
Date:   Thu, 21 Oct 2021 20:29:34 +0800
Message-ID: <20211021122936.758221-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yu Kuai (2):
  nbd: fix max value for 'first_minor'
  nbd: fix possible overflow for 'first_minor' in nbd_dev_add()

 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.31.1

