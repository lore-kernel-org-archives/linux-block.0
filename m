Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A44C38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3B72073A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hocqav+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGIw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 04:52:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgEGIw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588841575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q0hCbFHrs7YJ0hANwdeDczLX2FXwG9CyECY2+fCMqqg=;
        b=Hocqav+Y7x291HB8x4EDP8RRfh0LjKVXwhzawLINOEA4Y+JA/wtJaxZx9BiSXAsheZDo1C
        urMBARKyXzf3ek4k7XPlkcTnI4ylNB2Fruk3w3L3KTif73wmN45NK2RyNqQa7dYCz/k2kY
        iwT6pgTL7F6nR6+n9YtKdZXYwoZJnkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-WCGKp174O0iCJafuMH4yxA-1; Thu, 07 May 2020 04:52:51 -0400
X-MC-Unique: WCGKp174O0iCJafuMH4yxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4134F100CCC0;
        Thu,  7 May 2020 08:52:50 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46C3A341E0;
        Thu,  7 May 2020 08:52:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 0/4] block: fix partition use-after-free and optimization
Date:   Thu,  7 May 2020 16:52:35 +0800
Message-Id: <20200507085239.1354854-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one use-after-free on cached last_lookup partition.

The other 3 patches optimizes partition uses in IO path.



Ming Lei (4):
  block: fix use-after-free on cached last_lookup partition
  block: only define 'nr_sects_seq' in hd_part for 32bit SMP
  block: re-organize fields of 'struct hd_part'
  block: don't hold part0's refcount in IO path

 block/blk-core.c        | 15 ++-------------
 block/genhd.c           |  7 +++++--
 block/partitions/core.c | 14 ++++++++++++--
 include/linux/genhd.h   | 25 ++++++++++++++++++-------
 4 files changed, 37 insertions(+), 24 deletions(-)

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
-- 
2.25.2

