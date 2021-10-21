Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0E46121E
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhJUMls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:41:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26108 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJUMlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 08:41:47 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HZn7T4QFnz1DHnZ;
        Thu, 21 Oct 2021 20:37:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Thu, 21
 Oct 2021 20:39:29 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2 0/2] Fix hungtask when nbd_config_put
Date:   Thu, 21 Oct 2021 20:52:29 +0800
Message-ID: <20211021125231.916081-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ye Bin (2):
  nbd: Fix incorrect error handle when first_minor big than '0xff' in
    nbd_dev_add
  nbd: Fix hungtask when nbd_config_put

 drivers/block/nbd.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

-- 
2.31.1

