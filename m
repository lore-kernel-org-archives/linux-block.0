Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF68C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6664A206B7
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfI0HZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfI0HZB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 03:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 608E530821AE;
        Fri, 27 Sep 2019 07:25:01 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C83F5C220;
        Fri, 27 Sep 2019 07:24:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 0/2] blk-mq: two improvemens on slow MQ devices
Date:   Fri, 27 Sep 2019 15:24:29 +0800
Message-Id: <20190927072431.23901-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 27 Sep 2019 07:25:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch always applies io scheduler path if 'none' isn't used,
so that sequential IO performance can be improved on slow MQ device.
Also write order for zone device can be maintained becasue zone device
requires mq-dealine to do that.

The 2nd patch applies normal plugging for MQ HDD. 


Ming Lei (2):
  blk-mq: respect io scheduler
  blk-mq: apply normal plugging for HDD

 block/blk-mq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Dave Chinner <dchinner@redhat.com>

-- 
2.20.1

