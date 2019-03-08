Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE7C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FE720652
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCHVbS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:31:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:37858 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfCHVbS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 16:31:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 13:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="326889913"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2019 13:31:17 -0800
Date:   Fri, 8 Mar 2019 14:31:51 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
Message-ID: <20190308213150.GB5438@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <1552068443.45180.24.camel@acm.org>
 <20190308181551.GB5214@localhost.localdomain>
 <1552070537.45180.38.camel@acm.org>
 <20190308191954.GC5232@localhost.localdomain>
 <1552078030.45180.88.camel@acm.org>
 <20190308211431.GA5438@localhost.localdomain>
 <1552080316.138960.11.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552080316.138960.11.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 01:25:16PM -0800, Bart Van Assche wrote:
> On Fri, 2019-03-08 at 14:14 -0700, Keith Busch wrote:
> > On Fri, Mar 08, 2019 at 12:47:10PM -0800, Bart Van Assche wrote:
> > > If no such mechanism has been defined in the NVMe spec: have you considered
> > > to cancel all outstanding requests instead of calling blk_mq_end_request() for
> > > all outstanding requests?
> > 
> > Isn't this cancelling requests? Is there an existing block interface
> > that accomplishes this?
> 
> Hi Keith,
> 
> Sorry if I was unclear. With "canceling outstanding requests" I was referring to
> the NVMe abort command. I think aborting outstanding requests has the advantage
> that no new explicit call to blk_mq_end_request() call has to be added.

Ah, gotchya. NVMe abort usage is different than what this series wants to
do: we've determined the device is no longer usable, we need to terminate
all requests that are queued in software, but haven't been dispatched
to hardware.
