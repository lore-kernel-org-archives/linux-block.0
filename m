Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84763C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540A920835
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552919991;
	bh=Ew/TQOH/rmdXnJQksHSHOBdA0kAWKJn9+PjlLWA1ORk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZqxCzi1vJQxwfg5eI40WGRF1vc61eMgTZqxke9w8n6b+6CElhWvAW+UUilyFimV9F
	 AB6iurUbNW5GSEg6A9mLCfYy0945dFfJiqYTvbmkKR41o8WmEvuy0SDNTumKRLwgw/
	 xmnQm3RLUr/rezZrc/AD4qAg+cO0AjeKVWMFz0rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCROju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:39:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:24028 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfCROju (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:39:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP; 18 Mar 2019 07:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="135023381"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2019 07:39:49 -0700
Date:   Mon, 18 Mar 2019 08:40:42 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190318144042.GA23473@localhost.localdomain>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 17, 2019 at 09:09:09PM -0700, Bart Van Assche wrote:
> On 3/17/19 8:29 PM, Ming Lei wrote:
> > In NVMe's error handler, follows the typical steps for tearing down
> > hardware:
> > 
> > 1) stop blk_mq hw queues
> > 2) stop the real hw queues
> > 3) cancel in-flight requests via
> > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > cancel_request():
> > 	mark the request as abort
> > 	blk_mq_complete_request(req);
> > 4) destroy real hw queues
> > 
> > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > actually completes the request asynchronously.
> > 
> > This patch introduces blk_mq_complete_request_sync() for fixing the
> > above race.
> 
> Other block drivers wait until outstanding requests have completed by
> calling blk_cleanup_queue() before hardware queues are destroyed. Why can't
> the NVMe driver follow that approach?

You can't just wait for an outstanding request indefinitely. We have to
safely make forward progress when we've determined it's not going to be
completed.
