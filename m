Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F7BC433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A48060F93
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhJ2JcI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:32:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13989 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhJ2JcI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 05:32:08 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HgcXW0rfVzZcMy;
        Fri, 29 Oct 2021 17:27:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Fri, 29
 Oct 2021 17:29:36 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v3 0/2] Fix hungtask when nbd_config_put
Date:   Fri, 29 Oct 2021 17:42:26 +0800
Message-ID: <20211029094228.1853434-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

