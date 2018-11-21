Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91BC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E135214C4
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E135214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeKUXiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:38:52 -0500
Received: from verein.lst.de ([213.95.11.211]:51228 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeKUXiv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 18:38:51 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 86D3768C19; Wed, 21 Nov 2018 14:04:32 +0100 (CET)
Date:   Wed, 21 Nov 2018 14:04:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 07/14] nvme-core: add work elements to struct
 nvme_ctrl
Message-ID: <20181121130432.GB1373@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me> <20181120030019.31738-9-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120030019.31738-9-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 07:00:09PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi@lightbitslabs.com>
> 
> connect_work and err_work will be reused by nvme-tcp so
> share those in nvme_ctrl for rdma and fc to share.

As said before when you sent this invididually:  I'd rather not move
struct members to the common struture until we actually start using
it there.  So for now please add it to the containing TCP-specific
structure, although I'm looking forward to actually see code around
it consolidated eventually.
