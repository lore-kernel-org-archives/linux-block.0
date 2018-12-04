Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E09FC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BC206B7
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6BC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLDPsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:48:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:59968 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDPsq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:48:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 07:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="280857668"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2018 07:48:45 -0800
Date:   Tue, 4 Dec 2018 08:46:00 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181204154559.GJ14775@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 05:33:06PM -0800, Sagi Grimberg wrote:
> >>
> > Yes, I'm very much in favour of this, too.
> > We always have this IMO slightly weird notion of stopping the queue, set 
> > some error flags in the driver, then _restarting_ the queue, just so 
> > that the driver then sees the error flag and terminates the requests.
> > Which I always found quite counter-intuitive.
> 
> What about requests that come in after the iteration runs? how are those
> terminated?

If we've reached a dead state, I think you'd want to start a queue freeze
before running the terminating iterator.
