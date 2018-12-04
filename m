Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3DC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512DB20672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512DB20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeLDRuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:50:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:31629 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeLDRuw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 12:50:52 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 09:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="115919834"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 04 Dec 2018 09:50:51 -0800
Date:   Tue, 4 Dec 2018 10:48:06 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181204174806.GA16751@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 09:38:29AM -0800, Sagi Grimberg wrote:
> 
> > > > Yes, I'm very much in favour of this, too.
> > > > We always have this IMO slightly weird notion of stopping the queue, set
> > > > some error flags in the driver, then _restarting_ the queue, just so
> > > > that the driver then sees the error flag and terminates the requests.
> > > > Which I always found quite counter-intuitive.
> > > 
> > > What about requests that come in after the iteration runs? how are those
> > > terminated?
> > 
> > If we've reached a dead state, I think you'd want to start a queue freeze
> > before running the terminating iterator.
> 
> Its not necessarily dead, in fabrics we need to handle disconnections
> that last for a while before we are able to reconnect (for a variety of
> reasons) and we need a way to fail I/O for failover (or requeue, or
> block its up to the upper layer). Its less of a "last resort" action
> like in the pci case.
> 
> Does this guarantee that after freeze+iter we won't get queued with any
> other request? If not then we still need to unfreeze and fail at
> queue_rq.

It sounds like there are different scenarios to consider.

For the dead controller, we call blk_cleanup_queue() at the end which
ends callers who blocked on entering.

If you're doing a failover, you'd replace the freeze with a current path
update in order to prevent new requests from entering.

In either case, you don't need checks in queue_rq. The queue_rq check
is redundant with the quiesce state that blk-mq already provides.

Once quiesced, the proposed iterator can handle the final termination
of the request, perform failover, or some other lld specific action
depending on your situation.
