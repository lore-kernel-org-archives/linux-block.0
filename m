Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C02C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586B72084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586B72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeLLQiB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:38:01 -0500
Received: from linode.aoot.com ([69.164.194.13]:40422 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbeLLQiB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:38:01 -0500
Received: from stevoacer (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net [47.221.137.213])
        by linode.aoot.com (Postfix) with ESMTP id C6DF48285;
        Wed, 12 Dec 2018 10:38:00 -0600 (CST)
From:   "Steve Wise" <swise@opengridcomputing.com>
To:     "'Sagi Grimberg'" <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc:     <linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Keith Busch'" <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
Subject: RE: [PATCH RFC 0/4] restore polling to nvme-rdma
Date:   Wed, 12 Dec 2018 10:37:59 -0600
Message-ID: <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEbJkp2FK6IJZkEqzZVYGFa+MjfAKbuJODw
Content-Language: en-us
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Sagi,

> Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
> 
> Add an additional queue mapping for polling queues that will
> host polling for latency critical I/O.
> 
> One caveat is that we don't want these queues to be pure polling
> as we don't want to bother with polling for the initial nvmf connect
> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
> context from SOFTIRQ to DIRECT. Note that this function is not safe
> with inflight I/O so the caller must make sure not to call it without
> having all I/O quiesced (we also relax the ib_cq_completion_direct warning
> as we have a scenario that this can happen).

Is there no way to handle this in the core?  Maybe have the polling context
transition to DIRECT when the queue becomes empty and before re-arming the
CQ?  So ib_change_cq_ctx() would be called to indicate the change should
happen when it is safe to do so.  

Just a thought..


