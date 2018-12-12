Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0437C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFE020811
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFE020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLLHF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:05:29 -0500
Received: from verein.lst.de ([213.95.11.211]:60230 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLHF3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:05:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F0D4468DD2; Wed, 12 Dec 2018 08:05:27 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:05:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 5/5] nvme-rdma: support separate queue maps for read
 and write
Message-ID: <20181212070527.GB28461@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me> <20181211233519.9350-6-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211233519.9350-6-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
