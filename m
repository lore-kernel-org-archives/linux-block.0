Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BCC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC71C6054F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJYJta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232756AbhJYJra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NBxeL6lXA+i9ah1gythSV4TcmYBq3NrYEHG409swYuU=;
        b=McxUXIuS+rtHJuUtq+4zCS6UxNQZtgluoQGTXEfeJbq+KXFAoT1mG40ZVFIA62Rc2AGN7r
        2Q9tjAPQXdTPB1DJcA68XokGVoNJ5B8QnYCTwrSVxpGhtGuZXq+N8aW/9sEQO9ZJyHt4SM
        ohmAK6rhfJ57tmY4mpB6ODQF26lyEu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-6fNWlIBOMmq-yAlaJUgMrg-1; Mon, 25 Oct 2021 05:45:03 -0400
X-MC-Unique: 6fNWlIBOMmq-yAlaJUgMrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5311D10059AB;
        Mon, 25 Oct 2021 09:44:46 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76D25100238C;
        Mon, 25 Oct 2021 09:44:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] loop: improve dio on backing file
Date:   Mon, 25 Oct 2021 17:44:29 +0800
Message-Id: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Improve dio on backing file:

1) cover simple read/write via aio style(lo_rw_aio)

2) fallback to buffered io in case of dio failure

3) relax dio use condition and not check if lo->lo_offset & loop queue's
bs is aligned with backing queue

4) enable backing dio at default(RFC)


Ming Lei (8):
  loop: move flush_dcache_page to ->complete of request
  loop: remove always true check
  loop: add one helper for submitting IO on backing file
  loop: cover simple read/write via lo_rw_aio()
  loop: fallback to buffered IO in case of dio submission
  loop: relax loop dio use condition
  loop: remove lo->use_dio
  loop: use backing dio at default

 drivers/block/loop.c | 182 +++++++++++++------------------------------
 drivers/block/loop.h |   2 +-
 2 files changed, 57 insertions(+), 127 deletions(-)

-- 
2.31.1

