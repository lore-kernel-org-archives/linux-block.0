Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6BC4332F
	for <linux-block@archiver.kernel.org>; Fri,  6 May 2022 01:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388172AbiEFBps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 May 2022 21:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388101AbiEFBpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 May 2022 21:45:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AAF62129;
        Thu,  5 May 2022 18:41:27 -0700 (PDT)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvYB84Mk6zGpVF;
        Fri,  6 May 2022 09:38:40 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:41:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:41:22 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <akpm@linux-foundation.org>, <logang@deltatee.com>,
        <martin.oliveira@eideticom.com>, <thunder.leizhen@huawei.com>,
        <axboe@kernel.dk>, <kch@nvidia.com>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <mcgrof@kernel.org>,
        <jiangguoqing@kylinos.cn>, <jpittman@redhat.com>,
        <dave@stgolabs.net>, <liupeng256@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: [PATCH 0/2] null_blk: fix wrong use of nr_online_nodes
Date:   Fri, 6 May 2022 01:57:59 +0000
Message-ID: <20220506015801.757918-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Helper node_available is introduced to judge whether a node can be
used, and it is used to fix the wrong use of nr_online_nodes when
numa node is sparse.

Peng Liu (2):
  include/linux/nodemask.h: create node_available() helper
  null_blk: fix wrong use of nr_online_nodes

 arch/ia64/hp/common/sba_iommu.c |  2 +-
 arch/x86/pci/acpi.c             |  2 +-
 drivers/acpi/arm64/iort.c       |  2 +-
 drivers/block/null_blk/main.c   | 45 ++++++++++++++++++++-------------
 drivers/pci/pci-sysfs.c         |  2 +-
 include/linux/nodemask.h        |  3 +++
 mm/mempolicy.c                  |  2 +-
 7 files changed, 36 insertions(+), 22 deletions(-)

-- 
2.25.1

