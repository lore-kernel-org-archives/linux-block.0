Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC77C4332F
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 01:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiK1BWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Nov 2022 20:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiK1BWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Nov 2022 20:22:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D6611168;
        Sun, 27 Nov 2022 17:22:09 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NL73G4r4nzRpQQ;
        Mon, 28 Nov 2022 09:21:30 +0800 (CST)
Received: from huawei.com (10.67.175.21) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 09:22:06 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <axboe@kernel.dk>, <kraxel@redhat.com>,
        <david@redhat.com>, <ericvh@gmail.com>, <lucho@ionkov.net>,
        <asmadeus@codewreck.org>, <linux_oss@crudebyte.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rusty@rustcorp.com.au>
CC:     <lizetao1@huawei.com>, <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>, <netdev@vger.kernel.org>
Subject: [PATCH 0/4] Fix probe failed when modprobe modules
Date:   Mon, 28 Nov 2022 10:10:01 +0800
Message-ID: <20221128021005.232105-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.21]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset fixes similar issue, the root cause of the
problem is that the virtqueues are not stopped on error
handling path.

Li Zetao (4):
  9p: Fix probe failed when modprobe 9pnet_virtio
  virtio-mem: Fix probe failed when modprobe virtio_mem
  virtio-input: Fix probe failed when modprobe virtio_input
  virtio-blk: Fix probe failed when modprobe virtio_blk

 drivers/block/virtio_blk.c    | 1 +
 drivers/virtio/virtio_input.c | 1 +
 drivers/virtio/virtio_mem.c   | 1 +
 net/9p/trans_virtio.c         | 1 +
 4 files changed, 4 insertions(+)

-- 
2.25.1

