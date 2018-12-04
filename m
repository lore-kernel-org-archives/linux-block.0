Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF9EC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 21:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746E120672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 21:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746E120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLDVqe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:46:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:62564 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDVqe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 16:46:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="116049876"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2018 13:46:33 -0800
Date:   Tue, 4 Dec 2018 14:43:49 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181204214349.GD16751@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
 <20181204174806.GA16751@localhost.localdomain>
 <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>
 <20181204212117.GC16751@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204212117.GC16751@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 02:21:17PM -0700, Keith Busch wrote:
> On Tue, Dec 04, 2018 at 11:33:33AM -0800, James Smart wrote:
> > On 12/4/2018 9:48 AM, Keith Busch wrote:
> > > Once quiesced, the proposed iterator can handle the final termination
> > > of the request, perform failover, or some other lld specific action
> > > depending on your situation.
> > 
> > I don't believe they can remain frozen, definitely not for the admin queue.
> > -- james
> 
> Quiesced and frozen carry different semantics.
> 
> My understanding of the nvme-fc implementation is that it returns
> BLK_STS_RESOURCE in the scenario you've described where the admin
> command can't be executed at the moment. That just has the block layer
> requeue it for later resubmission 3 milliseconds later, which will
> continue to return the same status code until you're really ready for
> it.
> 
> What I'm proposing is that instead of using that return code, you may
> have nvme-fc control when to dispatch those queued requests by utilizing
> the blk-mq quiesce on/off states. Is there a reason that wouldn't work?

BTW, this is digressing from this patch's use case. The proposed iteration
doesn't come into play for the above scenario, which can be handled with
existing interfaces.
