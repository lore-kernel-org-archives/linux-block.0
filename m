Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D07EC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC872082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC872082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLDPEu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:04:50 -0500
Received: from verein.lst.de ([213.95.11.211]:44336 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLDPEu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:04:50 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3806568BDF; Tue,  4 Dec 2018 16:04:49 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:04:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
Message-ID: <20181204150449.GB3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de> <20181202164628.1116-6-hch@lst.de> <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 04:58:25PM -0800, Sagi Grimberg wrote:
>
>> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
>
> Do we still need to carry the tag around?

Yes, the timeout handler polls for a specific tag.
