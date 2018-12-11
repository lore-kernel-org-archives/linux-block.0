Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D1C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E423920811
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E423920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLKNfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:35:37 -0500
Received: from verein.lst.de ([213.95.11.211]:55376 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKNfh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 08:35:37 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E25768DD2; Tue, 11 Dec 2018 14:35:36 +0100 (CET)
Date:   Tue, 11 Dec 2018 14:35:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] nvme-fabrics: allow user to set nr_write_queues
 for separate queue maps
Message-ID: <20181211133536.GC20614@lst.de>
References: <20181211104936.25333-1-sagi@grimberg.me> <20181211104936.25333-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211104936.25333-4-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 02:49:33AM -0800, Sagi Grimberg wrote:
> This argument will specify how many I/O queues will be connected
> in create_ctrl in addition to nr_io_queues. With this configuration,
> I/O that carries payload from the host to the target, will use
> the default hctx queue map, and I/O that involves target to host
> transfers will use the read hctx queue map.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
