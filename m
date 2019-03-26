Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9424C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979792087E
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553644579;
	bh=2rdmD6MnZE+u+bUnH6U7enpAMI60HCBl6jmqAVXYBjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ztl1n9iMJATn8CbNZkKPmsodQZWEa0J5/R5sXtRByJuxgCM4RA23WODNOOYbzA75K
	 pADUcQWE0P8YP/pkZzCr7vj2Pg0RWxWoQg1NTsbEib9SXdU81iHGtGfF4o/kJX09uH
	 xgWWExC8oHa0T8cKBgdjwWjOPP2sHSTu5t5J6ty4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfCZX4S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:56:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:29770 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731666AbfCZX4S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 19:56:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 16:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="137533192"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2019 16:56:16 -0700
Date:   Tue, 26 Mar 2019 17:57:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "Busch, Keith" <keith.busch@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
Message-ID: <20190326235726.GC4328@localhost.localdomain>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 08:05:53PM -0700, jianchao.wang wrote:
> What if there used to be a io scheduler and leave some stale requests of sched tags ?
> Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?

Requests internally queued in scheduler or block layer are not eligible
for the nvme driver's iterator callback. We only use it to reclaim
dispatched requests that the target can't return, which only applies to
requests that must have a valid rq->tag value from hctx->tags.
 
> The stable request could be some tings freed and used
> by others and the state field happen to be overwritten to non-zero...

I am not sure I follow what this means. At least for nvme, every queue
sharing the same tagset is quiesced and frozen, there should be no
request state in flux at the time we iterate.
