Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDAC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 04:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DDD208D6
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 04:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCHsgM38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgEHEoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 00:44:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59641 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725681AbgEHEoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 00:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588913064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5jIUHnxAmjhVmnh2Gxp3AcEsj2n88K0mdJyQ8c7fkOE=;
        b=BCHsgM38Hv56aygrhl/LrAwFJvDsGBAc8fbkSmohpxGwK+DtTgnfiwDTqFcL4WHshC5ngy
        RAPBGczO7EygoX4OjV2sPHx0WjFm3ls9Qa2HXBdU4TLAHnNfctG5zsAv3jLvtgltbw0/LQ
        oq2tdDMdTwRASSJaWkcXycKOgVY0JTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-X_DJS15vOgSw67Eazp3RTw-1; Fri, 08 May 2020 00:44:21 -0400
X-MC-Unique: X_DJS15vOgSw67Eazp3RTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF64473;
        Fri,  8 May 2020 04:44:20 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7106614C0;
        Fri,  8 May 2020 04:44:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V2 0/4] block: fix partition use-after-free and optimization
Date:   Fri,  8 May 2020 12:44:03 +0800
Message-Id: <20200508044407.1371907-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one use-after-free on cached last_lookup partition.

The other 3 patches optimizes partition uses in IO path.

V2:
	- add comment, use part_to_disk() to retrieve disk instead of
	adding one field to hd_struct
	- don't put part in blk_account_io_merge


Ming Lei (4):
  block: fix use-after-free on cached last_lookup partition
  block: only define 'nr_sects_seq' in hd_part for 32bit SMP
  block: re-organize fields of 'struct hd_part'
  block: don't hold part0's refcount in IO path

 block/blk-core.c        | 15 ++-------------
 block/blk-merge.c       |  3 ++-
 block/genhd.c           | 17 +++++++++++++----
 block/partitions/core.c | 14 ++++++++++++--
 include/linux/genhd.h   | 24 +++++++++++++++++-------
 5 files changed, 46 insertions(+), 27 deletions(-)

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
-- 
2.25.2

