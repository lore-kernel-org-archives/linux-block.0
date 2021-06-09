Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7DFC4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 01:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF4761287
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 01:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFICAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 22:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233277AbhFICAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 22:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623203917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6zmqsfPY6wG03La3cZsPHv0Do5L7TUEifn99iN90JsI=;
        b=LfBDnft04ex872z7mENxKiXwQ/WB/RRi/vUXkgxQxv+3PoDM+fk6F1DH5c8+oqECoAkFND
        nZ47eO0CzHetvqll1p427Mco/jfR4sDB6Vy76hgvbP66VWLIpNX1u76eOBvekORfsgsVB5
        /+gWSAknKyRQJMncVkClTna3+3+qyRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-juqJNryFPaqW3bAT-fXa6w-1; Tue, 08 Jun 2021 21:58:36 -0400
X-MC-Unique: juqJNryFPaqW3bAT-fXa6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08F6D100945F;
        Wed,  9 Jun 2021 01:58:35 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD685C1BB;
        Wed,  9 Jun 2021 01:58:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 0/2] block: fix race between adding wbt and normal IO 
Date:   Wed,  9 Jun 2021 09:58:20 +0800
Message-Id: <20210609015822.103433-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Yi reported several kernel panics on:

[16687.001777] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
...
[16687.163549] pc : __rq_qos_track+0x38/0x60

or

[  997.690455] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
...
[  997.850347] pc : __rq_qos_done+0x2c/0x50

Turns out it is caused by race between adding wbt and normal IO.

Fix the issue by freezing request queue when adding/deleting rq qos.

V3:
	- use ->queue_lock for protecting concurrent adding/deleting rqos on
	  same queue

V2:
	- switch to the approach of freezing queue, which is more generic
	  than V1.



Ming Lei (2):
  block: fix race between adding/removing rq qos and normal IO
  block: mark queue init done at the end of blk_register_queue

 block/blk-rq-qos.h | 24 ++++++++++++++++++++++++
 block/blk-sysfs.c  | 29 +++++++++++++++--------------
 2 files changed, 39 insertions(+), 14 deletions(-)

Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
-- 
2.31.1

