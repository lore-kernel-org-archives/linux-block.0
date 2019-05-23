Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56716C282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272FB20B1F
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558618772;
	bh=ceT5vDTFeNeZOzVLwPXKto9s0jE6GzE6bEENhgnEQEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sNEKyKOQ1nWavW7ZRkBGSTdwWVYNVPK3A+JgdreURPTap6LyuIYfvM2ly/Hv2s+Ho
	 1HqTFkY2vT4dmvy5igUJAPvlvSaPQnDxQqkIdnIan1nUKlctmQFym8+C/Xo5tK5ckU
	 JYaG4XkwK4/o6VE17QgyZ37a9HL9xoietV6rGkWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfEWNjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 09:39:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:39988 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfEWNjb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 09:39:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 06:39:31 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 23 May 2019 06:39:30 -0700
Date:   Thu, 23 May 2019 07:34:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvme: reset request timeouts during fw activation
Message-ID: <20190523133428.GC14049@localhost.localdomain>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190522174812.5597-3-keith.busch@intel.com>
 <20190523101953.GA18805@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523101953.GA18805@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 03:19:54AM -0700, Ming Lei wrote:
> On Wed, May 22, 2019 at 11:48:12AM -0600, Keith Busch wrote:
> > @@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
> >  				msecs_to_jiffies(admin_timeout * 1000);
> >  
> >  	nvme_stop_queues(ctrl);
> > +	nvme_sync_queues(ctrl);
> > +
> > +	blk_mq_quiesce_queue(ctrl->admin_q);
> > +	blk_sync_queue(ctrl->admin_q);
> 
> blk_sync_queue() may not halt timeout detection completely since the
> timeout work may reset timer again.

Doh! Didn't hit that in testing, but point taken.
 
> Also reset still may come during activating FW, is that a problem?

IO timeout and user initiated resets should be avoided. A state machine
addition may be useful here.
