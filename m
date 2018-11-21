Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68DCC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881F7214DB
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881F7214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbeKUXkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:40:04 -0500
Received: from verein.lst.de ([213.95.11.211]:51240 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeKUXkE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 18:40:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1FE1768C1D; Wed, 21 Nov 2018 14:05:45 +0100 (CET)
Date:   Wed, 21 Nov 2018 14:05:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 09/14] nvmet: allow configfs tcp trtype configuration
Message-ID: <20181121130545.GD1373@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me> <20181120030019.31738-11-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120030019.31738-11-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 07:00:11PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi@lightbitslabs.com>
> 
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
