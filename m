Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA22C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5102214DA
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5102214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeKVALN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:11:13 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:33052 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbeKVALN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 19:11:13 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id BF0A178006E;
        Wed, 21 Nov 2018 13:36:46 +0000 (UTC)
Received: from linux-m89u (62.102.148.162) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 21 Nov
 2018 13:36:40 +0000
References: <20181120030019.31738-1-sagi@grimberg.me> <20181120030019.31738-16-sagi@grimberg.me>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Keith Busch" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
Date:   Wed, 21 Nov 2018 15:01:11 +0300
Message-ID: <8736rufxmg.fsf@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.102.148.162]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24236.003
X-TM-AS-Result: No-11.419500-8.000000-10
X-TMASE-MatchedRID: nVQUmLJJeyZ73HU3OUveQeKXavbHY/C1HnCRYlUUdYLDTXM3VzSaIt/A
        2XRvDsLVFEhTN3erGRmZ5rXmZbU9pWGw7OE0EQC5F6z9HGHKwNvDHSNFHFxB8+Rmz46Q29bDPMQ
        prE95Gc4Q8GxH7zew7pMyLtyjfN9WQkD0qM3R8dmeAiCmPx4NwGmRqNBHmBvexq9PbUOwsP9QSF
        bL1bvQAcK21zBg2KlfFEAkLaTcFno79EuaPMkTixIeAH5KNby9yl9CVBqarcmcyao4bUPu1A==
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.419500-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24236.003
X-MDID: 1542807407-e1oU1SKMDV5V
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> writes:
 > +static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req)
 > +{
 > +	struct nvme_tcp_queue *queue = req->queue;
 > +
 > +	spin_lock_bh(&queue->lock);
 > +	list_add_tail(&req->entry, &queue->send_list);
 > +	spin_unlock_bh(&queue->lock);
 > +
 > +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 > +}

May be I missing something, but why bother with bottom half version of
locking?

There are few places where this lock could be accessed:

 (1) From ->queue_rq() call;
 (2) From submitting new AEN request;
 (3) From receiving new R2T;

Which one if these originates from bottom half? Not 100% about queue_rq
data path, but (2) and (3) looks perfectly safe for me.

Possibly just a relic of some previous iterations of experimenting?

Mikhail Skorzhinskii
