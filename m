Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA61C04AB5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 01:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73B026029
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 01:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFDBAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 21:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfFDBAS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Jun 2019 21:00:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE0398666C;
        Tue,  4 Jun 2019 01:00:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5708067C8B;
        Tue,  4 Jun 2019 01:00:08 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:00:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for
 sg list
Message-ID: <20190604010002.GA24432@ming.t460p>
References: <20190428073932.9898-1-ming.lei@redhat.com>
 <20190428073932.9898-4-ming.lei@redhat.com>
 <20190603204422.GA7240@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603204422.GA7240@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 04 Jun 2019 01:00:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 03, 2019 at 01:44:22PM -0700, Guenter Roeck wrote:
> On Sun, Apr 28, 2019 at 03:39:32PM +0800, Ming Lei wrote:
> > Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
> > and the buffer size is scsi_mq_sgl_size() which depends on smaller
> > value between shost->sg_tablesize and SG_CHUNK_SIZE.
> > 
> > Modern HBA's DMA is often capable of deadling with very big segment
> > number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
> > of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.
> > 
> > Then if one HBA has lots of queues, and each hw queue's depth is
> > high, pre-allocation for sg list can consume huge memory.
> > For example of lpfc, nr_hw_queues can be 70, each queue's depth
> > can be 3781, so the pre-allocation for data sg list is 70*3781*2k
> > =517MB for single HBA.
> > 
> > There is Red Hat internal report that scsi_debug based tests can't
> > be run any more since legacy io path is killed because too big
> > pre-allocation.
> > 
> > So switch to runtime allocation for sg list, meantime pre-allocate 2
> > inline sg entries. This way has been applied to NVMe PCI for a while,
> > so it should be fine for SCSI too. Also runtime sg entries allocation
> > has verified and run always in the original legacy io path.
> > 
> > Not see performance effect in my big BS test on scsi_debug.
> > 
> 
> This patch causes a variety of boot failures in -next. Typical failure
> pattern is scsi hangs or failure to find a root file system. For example,
> on alpha, trying to boot from usb:

I guess it is because alpha doesn't support sg chaining, and
CONFIG_ARCH_NO_SG_CHAIN is enabled. ARCHs not supporting sg chaining
can only be arm, alpha and parisc.

Please test the following patch and see if it makes a difference:

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6e81258471fa..9ef632963740 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -44,9 +44,13 @@
  * Size of integrity metadata is usually small, 1 inline sg should
  * cover normal cases.
  */
+#ifndef CONFIG_ARCH_NO_SG_CHAIN
 #define  SCSI_INLINE_PROT_SG_CNT  1
-
 #define  SCSI_INLINE_SG_CNT  2
+#else
+#define  SCSI_INLINE_PROT_SG_CNT  0
+#define  SCSI_INLINE_SG_CNT  0
+#endif
 
 static struct kmem_cache *scsi_sdb_cache;
 static struct kmem_cache *scsi_sense_cache;


Thanks,
Ming
