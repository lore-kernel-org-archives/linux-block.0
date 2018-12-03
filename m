Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF29C04EBF
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92126208A3
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 18:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92126208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbeLCSZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:25:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:47108 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeLCSZR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Dec 2018 13:25:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 10:25:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115687380"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 10:25:16 -0800
Date:   Mon, 3 Dec 2018 11:22:29 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 10/13] nvme-mpath: remove I/O polling support
Message-ID: <20181203182229.GG14775@localhost.localdomain>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202164628.1116-11-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 02, 2018 at 08:46:25AM -0800, Christoph Hellwig wrote:
> The ->poll_fn has been stale for a while, as a lot of places check for mq
> ops.  But there is no real point in it anyway, as we don't even use
> the multipath code for subsystems without multiple ports, which is usually
> what we do high performance I/O to.  If it really becomes an issue we
> should rework the nvme code to also skip the multipath code for any
> private namespace, even if that could mean some trouble when rescanning.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This was a bit flawed anyway since the head's current path could change,
and you end up polling the wrong request_queue. Not really harmful other
than some wasted CPU cycles, but might be worth thinking about if we
want to bring mpath polling back.

Reviewed-by: Keith Busch <keith.busch@intel.com>
