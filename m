Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C3AC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7547F613F9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEYIK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232069AbhEYIJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6lFZWfeQzl0yIedwLiNq8NX80owQeoZW56S/uR3EMJA=;
        b=Nyu8cWjRPDqKUQEtYHnTYaKObmLKnDnjSdT9cKyV8LB2ZSAEtZu0XQzx8IfhZkLVNa/gs7
        oyDBaWoFLi2qkCpR1J0tND62IFYYH6MCTEbaIcLWBbbCk5XaaOlzkPeYk+m2z6qGHD2ltG
        nriWIuPwccywG8H0Fy8TOnXVp6PHtPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-W-1icp9XOAKHrcz1O3vkKg-1; Tue, 25 May 2021 04:04:57 -0400
X-MC-Unique: W-1icp9XOAKHrcz1O3vkKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119B5180FD66;
        Tue, 25 May 2021 08:04:56 +0000 (UTC)
Received: from localhost (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 683F478620;
        Tue, 25 May 2021 08:04:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 0/4] block: fix race between adding wbt and normal IO 
Date:   Tue, 25 May 2021 16:04:38 +0800
Message-Id: <20210525080442.1896417-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Fix the issue by moving wbt allocation/addition into blk_alloc_queue().


Ming Lei (4):
  block: split wbt_init() into two parts
  block: move wbt allocation into blk_alloc_queue
  block: reuse wbt_set_min_lat for setting wbt->min_lat_nsec
  block: mark queue init done at the end of blk_register_queue

 block/blk-core.c       |  6 +++++
 block/blk-mq-debugfs.c |  3 +++
 block/blk-sysfs.c      | 53 ++++++++++++++----------------------------
 block/blk-wbt.c        | 42 +++++++++++++++++++++++----------
 block/blk-wbt.h        | 14 +++++++----
 5 files changed, 66 insertions(+), 52 deletions(-)

Cc: Yi Zhang <yi.zhang@redhat.com>

-- 
2.29.2

