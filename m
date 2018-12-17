Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE5C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5ED206BA
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeLQBqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:46:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeLQBqJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 20:46:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B2B385546;
        Mon, 17 Dec 2018 01:46:09 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75235D717;
        Mon, 17 Dec 2018 01:46:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH V2 0/2] block: support debugfs on rq_qos & wbt
Date:   Mon, 17 Dec 2018 09:45:59 +0800
Message-Id: <20181217014601.11823-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 17 Dec 2018 01:46:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch provides debugfs support on rq_qos.

The 2nd patch exports blk-wbt's internal states via debugfs.

V2:
	- use 'const char *'
	- fix one comipile failure in case of !CONFIG_BLK_DEBUG_FS
	- don't output 'ns' in several attributes


Ming Lei (2):
  blk-mq-debugfs: support rq_qos
  blk-wbt: export internal state via debugfs

 block/blk-mq-debugfs.c | 54 ++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h | 17 ++++++++++
 block/blk-rq-qos.c     |  2 ++
 block/blk-rq-qos.h     | 24 +++++++++++++
 block/blk-wbt.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 6 files changed, 189 insertions(+)

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>

-- 
2.9.5

