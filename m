Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9AAC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458CA2075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfC0OQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:16:43 -0400
Received: from verein.lst.de ([213.95.11.211]:42010 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfC0OQn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 10:16:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4B8CA68C4E; Wed, 27 Mar 2019 15:16:33 +0100 (CET)
Date:   Wed, 27 Mar 2019 15:16:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/15] block: add a req_bvec helper
Message-ID: <20190327141633.GA26200@lst.de>
References: <20190321231037.25104-1-hch@lst.de> <20190321231037.25104-2-hch@lst.de> <SN6PR04MB4527D352D115DFAB042B18D2865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4527D352D115DFAB042B18D2865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 05:07:44AM +0000, Chaitanya Kulkarni wrote:
> > +static inline struct bio_vec req_bvec(struct request *rq)
> > +{
> > +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
> > +		return rq->special_vec;
> Quick question here mostly for my understanding, do we also have to 
> check here for nr_phys_segments for the operations such as write-zeroes ? OR
> 
> this may never get called in write-zeroes context ? OR
> not applicable ?

We assume the caller checks that we have nr_phys_segments.  I'll
add a commen to document that.
