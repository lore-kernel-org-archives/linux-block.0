Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86328C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F3720661
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfCHSNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:13:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:20110 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfCHSNW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 13:13:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 10:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="140329850"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2019 10:13:21 -0800
Date:   Fri, 8 Mar 2019 11:13:54 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/5] blk-mq: Export iterating queue requests
Message-ID: <20190308181353.GA5214@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-2-keith.busch@intel.com>
 <1552068527.45180.25.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552068527.45180.25.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 10:08:47AM -0800, Bart Van Assche wrote:
> On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
> > A driver may need to iterate a particular queue's tagged request rather
> > than the whole tagset.
> 
> Since iterating over requests triggers race conditions with request execution
> please explain what use case(s) you have in mind and what your plan is to handle
> such race conditions.

That race isn't new. You should only iterate when your queues are quieced
to ensure the request sent to a callback is stable.
