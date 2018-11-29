Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3599C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DFE21019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DFE21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeK3HcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:32:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:47782 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeK3HcV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 02:32:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 12:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="98043804"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2018 12:25:42 -0800
Date:   Thu, 29 Nov 2018 13:22:47 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/13] nvme-pci: cleanup SQ allocation a bit
Message-ID: <20181129202247.GD9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129191310.9795-4-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 08:13:00PM +0100, Christoph Hellwig wrote:
> Use a bit flag to mark if the SQ was allocated from the CMB, and clean
> up the surrounding code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
