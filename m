Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831A4C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1E22147C
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552333036;
	bh=CUlgwwIm4kq8w9qJaEKEyLSBl+mUUeAtFhNclSfFOLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MV4sJkNRQHEkgfYLiulQgZPKsX5zTO5Cluo2VYEC9c2STy4jephaqVN0sHZRnCTUz
	 fcH5VKbJYdV3TT+IiVkIJ7Be65VbpKSPEKH1jbRqWeNPoJs9UisNBgNk8Y/7L5eLyx
	 O45ykmq7nsVHmlO2TtOIcbDOX3YYnnE1aN1JTdQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCKThP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:37:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:12657 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfCKThP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 15:37:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 12:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="141095537"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 12:37:14 -0700
Date:   Mon, 11 Mar 2019 13:37:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
Message-ID: <20190311193753.GE10411@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
 <20190311184031.GA11707@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311184031.GA11707@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 07:40:31PM +0100, Christoph Hellwig wrote:
> From a quick look the code seems reasonably sensible here,
> but any chance we could have this in common code?
> 
> > +static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
> > +{
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	struct nvme_queue *nvmeq = iod->nvmeq;
> > +
> > +	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))
> > +		blk_mq_end_request(req, BLK_STS_IOERR);
> > +	return true;
> > +}
> 
> The only thing not purely block layer here is the enabled flag.
> So if we had a per-hctx enabled flag we could lift this out of nvme,
> and hopefully start reusing it in other drivers.

Okay, I may even be able to drop the new block exports if we do request
termination in generic block layer. That's probably the right thing
anyway since that layer is in a better position to check the necessary
conditions that make tag iteration safe. Bart did point out that is
generally not safe for drives to do, so it'd be good to safegaurd against
incorrect usage.
