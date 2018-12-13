Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12CFC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD8620811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD8620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLMI16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:27:58 -0500
Received: from verein.lst.de ([213.95.11.211]:39330 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbeLMI15 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 03:27:57 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5862968D8D; Thu, 13 Dec 2018 09:27:56 +0100 (CET)
Date:   Thu, 13 Dec 2018 09:27:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/6] nvme-fabrics: allow nvmf_connect_io_queue to
 poll
Message-ID: <20181213082756.GC869@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me> <20181213063819.13614-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213063819.13614-4-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:15PM -0800, Sagi Grimberg wrote:
> Preparation for polling support for fabrics. Polling support
> means that our completion queues are not generating any interrupts
> which means we need to poll for the nvmf io queue connect as well.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
