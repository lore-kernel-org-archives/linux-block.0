Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38A0C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9412A214C4
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9412A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeKUXlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:41:32 -0500
Received: from verein.lst.de ([213.95.11.211]:51262 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730838AbeKUXlc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 18:41:32 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7A2DB68C19; Wed, 21 Nov 2018 14:07:12 +0100 (CET)
Date:   Wed, 21 Nov 2018 14:07:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 13/14] nvmet-tcp: add NVMe over TCP target driver
Message-ID: <20181121130712.GG1373@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me> <20181120030019.31738-15-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120030019.31738-15-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index 33c8afaf63bd..685780d1ed04 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -11,6 +11,7 @@
>  
>  #define NVME_TCP_DISC_PORT	8009
>  #define NVME_TCP_ADMIN_CCSZ	SZ_8K
> +#define NVME_TCP_DIGEST_LENGTH	4

This should go into the previous patch.
