Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15EC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B16206D5
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqP1ZkOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHISP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 04:18:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55159 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726746AbgEHISO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 04:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588925893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xokrS0AC1KM6vhqL66Ue+rw6dWaPDWdGK1afSubH4Ik=;
        b=iqP1ZkOqFPPEqLIqJIsQ+ul6mj+1sDsuDO58kb+H/NMjUbxbLdQkOds1JySje4/R56q307
        zPCq56Y20J/GUC4Vz3inwzDt4w3aJLUB5/H8yRQoJgG9DKtTilq+Ft4i5zD+3YxXxr/utR
        bK09xETXeqw1qhwA0dirzYymy6QIAm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-X0zOJu9hM-mG_JsUnLoF4Q-1; Fri, 08 May 2020 04:18:11 -0400
X-MC-Unique: X0zOJu9hM-mG_JsUnLoF4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 681E61005510;
        Fri,  8 May 2020 08:18:10 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BA3410013BD;
        Fri,  8 May 2020 08:18:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V3 0/4] block: fix partition use-after-free and optimization
Date:   Fri,  8 May 2020 16:17:54 +0800
Message-Id: <20200508081758.1380673-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one use-after-free on cached last_lookup partition.

The other 3 patches optimizes partition uses in IO path.

V3:
	- add reviewed-by tag
	- centralize partno check in the helper(4/4)

V2:
	- add comment, use part_to_disk() to retrieve disk instead of
	adding one field to hd_struct
	- don't put part in blk_account_io_merge


Ming Lei (4):
  block: fix use-after-free on cached last_lookup partition
  block: only define 'nr_sects_seq' in hd_part for 32bit SMP
  block: re-organize fields of 'struct hd_part'
  block: don't hold part0's refcount in IO path

 block/blk-core.c        | 12 ------------
 block/blk.h             | 13 ++++++-------
 block/genhd.c           | 17 +++++++++++++----
 block/partitions/core.c | 14 ++++++++++++--
 include/linux/genhd.h   | 24 +++++++++++++++++-------
 5 files changed, 48 insertions(+), 32 deletions(-)

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
-- 
2.25.2

