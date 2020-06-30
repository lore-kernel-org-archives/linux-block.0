Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D330C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D077B2073E
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHIfDKm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgF3HLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:11:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730636AbgF3HLW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 03:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593501081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P7/X1K7n5Pn/CYJzyxqFJFg3TIPfP7eFfFCCgrV2Xqk=;
        b=EHIfDKm/0yxoMtFrhEf05nQmFGlnlOOaLHlJaKNqwtXlpRSr3ODgXvDMId3k5ved2/S4Sl
        smeXs/Th+27vnmtzCXpisYFHxzz/xJeJbDSumKoTzQZ9MdNa+tiA5gxNau0Z7dXNQq8vFP
        m7IDaAMkkypoQkB6P2chk1GQistGiNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-TLEQEyH9NjSs65q3NK21Og-1; Tue, 30 Jun 2020 03:11:19 -0400
X-MC-Unique: TLEQEyH9NjSs65q3NK21Og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E1810059A0;
        Tue, 30 Jun 2020 07:11:18 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2A8074193;
        Tue, 30 Jun 2020 07:11:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2 0/3] blk-mq: driver tag related cleanup
Date:   Tue, 30 Jun 2020 15:11:05 +0800
Message-Id: <20200630071108.2192017-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The 1st & 2nd patch moves get/put driver tag helpers into blk-mq.c, and
the 3rd patch centralise related handling into blk_mq_get_driver_tag,
so both flush & blk-mq code get simplified.

V2:
	- add reviewed-by tag
	- don't put blk_mq_tag_busy() into blk_mq_get_driver_tag
	- use BLK_MQ_NO_TAG in blk-flush.c

Ming Lei (3):
  blk-mq: move blk_mq_get_driver_tag into blk-mq.c
  blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
  blk-mq: centralise related handling into blk_mq_get_driver_tag

 block/blk-flush.c  | 17 +++++-------
 block/blk-mq-tag.c | 58 ----------------------------------------
 block/blk-mq-tag.h | 41 +++++++++++++++++-----------
 block/blk-mq.c     | 66 +++++++++++++++++++++++++++++++++++++++++-----
 block/blk-mq.h     | 20 --------------
 block/blk.h        |  5 ----
 6 files changed, 91 insertions(+), 116 deletions(-)

Cc: Christoph Hellwig <hch@infradead.org>
-- 
2.25.2

