Return-Path: <SRS0=Zleb=OR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8973C04EB8
	for <linux-block@archiver.kernel.org>; Sat,  8 Dec 2018 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803A72081C
	for <linux-block@archiver.kernel.org>; Sat,  8 Dec 2018 17:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803A72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLHRAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:00:07 -0500
Received: from verein.lst.de ([213.95.11.211]:40779 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeLHRAH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Dec 2018 12:00:07 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2072268AA6; Sat,  8 Dec 2018 18:00:06 +0100 (CET)
Date:   Sat, 8 Dec 2018 18:00:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 00/13] TCP transport binding for NVMe over Fabrics
Message-ID: <20181208170006.GA15020@lst.de>
References: <20181204015217.16613-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204015217.16613-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-4.21.
