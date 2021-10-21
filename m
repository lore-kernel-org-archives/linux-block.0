Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBCC433FE
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81717610EA
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUPCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhJUPCW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 11:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634828401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q2qOMSfIFqUiZ+ePNeCoYlwUrPYIxajO27n8adsQHro=;
        b=L54RrXPofYaP6NgYoM0lrMh9g5POqE9aNSZt/7UAUQ54HyGU5gd22eOCiQ/imulb05sZiG
        6VzRxxAjyjh1P5H4iYi5RGEYJz9tX3E3HzdgGq08U2tJumSxo2dtlI4/kVMM4Bbz4xi2Kz
        Cw8MEwm39zdCDsXQN/PlEeHdGl5Y4tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-J7xXmxMGP6e13_bXcMJVZg-1; Thu, 21 Oct 2021 10:59:59 -0400
X-MC-Unique: J7xXmxMGP6e13_bXcMJVZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 068DA19200C5;
        Thu, 21 Oct 2021 14:59:58 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 385ED6788F;
        Thu, 21 Oct 2021 14:59:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] block: keep quiesce & unquiesce balanced for scsi/dm
Date:   Thu, 21 Oct 2021 22:59:15 +0800
Message-Id: <20211021145918.2691762-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

Recently we merge the patch of e70feb8b3e68 ("blk-mq: support concurrent queue
quiesce/unquiesce") for fixing race between driver and block layer wrt.
queue quiesce.

Yi reported that srp/002 is broken with this patch, turns out scsi and
dm don't keep the two balanced actually.

So fix dm and scsi and make srp/002 pass again.


Ming Lei (3):
  scsi: avoid to quiesce sdev->request_queue two times
  scsi: make sure that request queue queiesce and unquiesce balanced
  dm: don't stop request queue after the dm device is suspended

 drivers/md/dm.c            | 10 ------
 drivers/scsi/scsi_lib.c    | 70 ++++++++++++++++++++++++++------------
 include/scsi/scsi_device.h |  1 +
 3 files changed, 49 insertions(+), 32 deletions(-)

-- 
2.31.1

