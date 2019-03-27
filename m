Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5554C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C0120811
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553653965;
	bh=38CsVGEYGwjTvocJDUQvOsZSVyRYDE4Ydm1/Ydy5uaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o7iHOrAAQvon0i0OY5yAK3j0osH/VUYnZW3/WcbMuoHESfSdXmIuLb6ac13Ip4wIJ
	 m5AbPk251UINMGXTt3s9K0T2OIXAXecS31350XnzIByg3boHy11u0DkM+nh/8t1YHO
	 3z4LEWDcpK5f/rSydUzdfTWfMqqlhzfGCc+gXc/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfC0Ccp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:32:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:2191 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbfC0Cco (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 22:32:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 19:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="135096858"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2019 19:32:43 -0700
Date:   Tue, 26 Mar 2019 20:33:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Busch, Keith" <keith.busch@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
Message-ID: <20190327023354.GB7389@localhost.localdomain>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
 <20190327021521.GA7389@localhost.localdomain>
 <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 10:27:57AM +0800, jianchao.wang wrote:
> As the comment above, the stable request maybe something that has been freed due to following case,
> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
> 2. a removed io scheduler's sched request
> and this freed request could be allocated by others which may change the field of request->state.

You're not explaing how that request->state is changed. I understand the
request can be reallocated, but what is changing its state?
