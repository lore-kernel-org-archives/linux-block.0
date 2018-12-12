Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C390DC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594D520851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594D520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLHFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:05:11 -0500
Received: from verein.lst.de ([213.95.11.211]:60225 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeLLHFL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:05:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4EE2868D8D; Wed, 12 Dec 2018 08:05:10 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:05:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 4/5] nvme-tcp: support separate queue maps for read
 and write
Message-ID: <20181212070510.GA28461@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me> <20181211233519.9350-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211233519.9350-5-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	queue->io_cpu = (qid == 0) ? 0 : qid - 1;
> +	n = (qid ? qid - 1 : 0) % num_online_cpus();
> +	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);

Nitpick: can you use an if/else here?  The ? : construct just looks
like obsfucation.

If nothing else pops up I can fix that up when applying.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
