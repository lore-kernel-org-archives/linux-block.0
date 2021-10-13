Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF52EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8C8601FC
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhJMLPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 07:15:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24309 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhJMLPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTqXJ6V8HzQj9m;
        Wed, 13 Oct 2021 19:08:32 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 19:13:01 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 13
 Oct 2021 19:13:00 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 0/2] optimize the bfq queue idle judgment
Date:   Wed, 13 Oct 2021 19:25:32 +0800
Message-ID: <20211013112534.3073296-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes in V3:
 - Instead of tracking each queue in root group, tracking root group
 directly just like non-root group does.
 - remove patch 3,4 from these series.

Chagnes in V2:
 - as suggested by Paolo, add support to track if root_group have any
 pending requests, and use that to handle the situation when only one
 group is activated while root group doesn't have any pending requests.
 - modify commit message in patch 2

Yu Kuai (2):
  block, bfq: counted root group into 'num_groups_with_pending_reqs'
  block, bfq: do not idle if only one cgroup is activated

 block/bfq-iosched.c | 40 ++++++++++++++++++++++++++++--------
 block/bfq-wf2q.c    | 50 +++++++++++++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 21 deletions(-)

-- 
2.31.1

