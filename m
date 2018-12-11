Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87858C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 07:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CFC2081B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 07:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CFC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLKHI4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:08:56 -0500
Received: from verein.lst.de ([213.95.11.211]:53493 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeLKHI4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 02:08:56 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4F0B668DD2; Tue, 11 Dec 2018 08:08:55 +0100 (CET)
Date:   Tue, 11 Dec 2018 08:08:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme: fix irq vs io_queue calculations
Message-ID: <20181211070855.GA13999@lst.de>
References: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +		if (!(result < 0 || irq_queues == 1))
> +			irq_queues = irq_sets[0] + irq_sets[1] + 1;

Maybe its just me, but I hate this style of conditions, why not:

		if (result >= 0 && irq_queues > 1)
			irq_queues = irq_sets[0] + irq_sets[1] + 1;

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
