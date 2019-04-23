Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA47C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9F2214AE
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfDWKcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWKcy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 06:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F10EF319937C;
        Tue, 23 Apr 2019 10:32:53 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEF7F608A4;
        Tue, 23 Apr 2019 10:32:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 0/2] scis: core: avoid big pre-allocation for sg list
Date:   Tue, 23 Apr 2019 18:32:38 +0800
Message-Id: <20190423103240.29864-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Apr 2019 10:32:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since supporting to blk-mq, big pre-allocation for sg list is
introduced, this way is very unfriendly wrt. memory consumption.

There were Red Hat internal reports that some scsi_debug based tests
can't be run because of too big pre-allocation.

Also lpfc users commplained that 1GB+ ram is pre-allocatd for single
HBA.

The two patches try to address this issue by allocating sg list runtime,
meantime pre-allocating one or two inline sg entries for small IO. This
ways follows NVMe's approach wrt. sg list allocation.


Ming Lei (2):
  scsi: core: avoid to pre-allocate big chunk for protection meta data
  scsi: core: avoid to pre-allocate big chunk for sg list

 drivers/scsi/scsi_lib.c | 60 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 14 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>

-- 
2.9.5

