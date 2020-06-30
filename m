Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1948C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B707620774
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 02:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSI//ADR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgF3CY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:24:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbgF3CY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 22:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593483868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TWyZocOqNjxyoYFpZJksKLsna3WVmADoegX+tbw8h/s=;
        b=dSI//ADRj7q6e8vjolcMIUUQyifUKm6FZdP8kgk7A1zCl/nX+4s6MUvgZfVwXYby2lo0f9
        pbbFp6p1UiN1MXBUsOJCxyTtXZq99tLaYD513qnxS+qjsOgRroc1NobXjcFNry9/KC4CPt
        04Mlf15IxGEBZBbTecB4Q064fGJjf+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-DugFSL7jPu--mc7u4-7Ngw-1; Mon, 29 Jun 2020 22:24:08 -0400
X-MC-Unique: DugFSL7jPu--mc7u4-7Ngw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 480AD464;
        Tue, 30 Jun 2020 02:24:07 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D144D7166E;
        Tue, 30 Jun 2020 02:24:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/3] blk-mq: driver tag related cleanup
Date:   Tue, 30 Jun 2020 10:23:53 +0800
Message-Id: <20200630022356.2149607-1-ming.lei@redhat.com>
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

Ming Lei (3):
  blk-mq: move blk_mq_get_driver_tag into blk-mq.c
  blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
  blk-mq: centralise related handling into blk_mq_get_driver_tag

 block/blk-flush.c  | 13 +++------
 block/blk-mq-tag.c | 58 --------------------------------------
 block/blk-mq-tag.h | 41 +++++++++++++++++----------
 block/blk-mq.c     | 69 ++++++++++++++++++++++++++++++++++++++--------
 block/blk-mq.h     | 20 --------------
 block/blk.h        |  5 ----
 6 files changed, 88 insertions(+), 118 deletions(-)

Cc: Christoph Hellwig <hch@infradead.org>

-- 
2.25.2

