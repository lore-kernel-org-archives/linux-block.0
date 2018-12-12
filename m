Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A8C67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BB920849
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BB920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbeLLQbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:31:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:38492 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeLLQbY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:31:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 08:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="98219348"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2018 08:31:23 -0800
Date:   Wed, 12 Dec 2018 09:28:55 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: provide fallback for discard alloc failure
Message-ID: <20181212162855.GA10895@localhost.localdomain>
References: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 09:18:11AM -0700, Jens Axboe wrote:
> When boxes are run near (or to) OOM, we have a problem with the discard
> page allocation in nvme. If we fail allocating the special page, we
> return busy, and it'll get retried. But since ordering is honored for
> dispatch requests, we can keep retrying this same IO and failing. Behind
> that IO could be requests that want to free memory, but they never get
> the chance.
> 
> Allocate a fixed discard page per controller for a safe fallback, and use
> that if the initial allocation fails.

Do we need to allocate this per controller? One page for the whole driver
may be sufficient to make forward progress, right?
