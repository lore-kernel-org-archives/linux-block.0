Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E80DC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0754E20855
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCHVOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:14:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:31275 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfCHVOA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 16:14:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 13:13:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="130038080"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2019 13:13:59 -0800
Date:   Fri, 8 Mar 2019 14:14:32 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     t@localhost.localdomain, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
Message-ID: <20190308211431.GA5438@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <1552068443.45180.24.camel@acm.org>
 <20190308181551.GB5214@localhost.localdomain>
 <1552070537.45180.38.camel@acm.org>
 <20190308191954.GC5232@localhost.localdomain>
 <1552078030.45180.88.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552078030.45180.88.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 12:47:10PM -0800, Bart Van Assche wrote:
> Thanks for the clarification. Are you aware of any mechanism in the NVMe spec
> that causes all outstanding requests to fail? With RDMA this is easy - all
> one has to do is to change the queue pair state into IB_QPS_ERR. See also
> ib_drain_qp() in the RDMA core.

Well, we can't always rely on hardware to provide completions. The
driver must be able to make forward progress if the device decides to
stop responding, or maybe it was disconnected, asserts, or experiences
an unsafe shutdown/powerloss.

> If no such mechanism has been defined in the NVMe spec: have you considered
> to cancel all outstanding requests instead of calling blk_mq_end_request() for
> all outstanding requests?

Isn't this cancelling requests? Is there an existing block interface
that accomplishes this?
