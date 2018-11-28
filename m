Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D2C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D420B2082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D420B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeK1SBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:01:54 -0500
Received: from verein.lst.de ([213.95.11.211]:35080 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeK1SBy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:01:54 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D0C0E68BE5; Wed, 28 Nov 2018 08:01:16 +0100 (CET)
Date:   Wed, 28 Nov 2018 08:01:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
Message-ID: <20181128070116.GB20369@lst.de>
References: <20181127231615.9446-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What is the plan ahead here?  I think the nvme code looks pretty
reasonable now (I'll do another pass at nitpicking), but we need the
networking stuff sorted out with at least ACKs, or a merge through
the networking tree and then a shared branch we can pull in.
