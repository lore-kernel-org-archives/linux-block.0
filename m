Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB5CC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 07:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D51020873
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 07:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D51020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeK0Scl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:32:41 -0500
Received: from verein.lst.de ([213.95.11.211]:57059 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbeK0Scl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 13:32:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 62AF368BDB; Tue, 27 Nov 2018 08:35:42 +0100 (CET)
Date:   Tue, 27 Nov 2018 08:35:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Fix PCIe surprise removal scenario
Message-ID: <20181127073542.GA29997@lst.de>
References: <20181123155810.60246-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123155810.60246-1-igor.j.konopko@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-4.20 with slight tweaks to the changelog.
