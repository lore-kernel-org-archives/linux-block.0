Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C249C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D16D214D9
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16D214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeKUXka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:40:30 -0500
Received: from verein.lst.de ([213.95.11.211]:51246 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbeKUXka (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 18:40:30 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2F4BF68C19; Wed, 21 Nov 2018 14:06:11 +0100 (CET)
Date:   Wed, 21 Nov 2018 14:06:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/14] nvme-fabrics: allow user passing header digest
Message-ID: <20181121130611.GE1373@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me> <20181120030019.31738-12-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120030019.31738-12-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 07:00:12PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi@lightbitslabs.com>
> 
> Header digest is a nvme-tcp specific feature, but nothing prevents other
> transports reusing the concept so do not associate with tcp transport
> solely.
> 
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
