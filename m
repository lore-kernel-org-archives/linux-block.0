Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701FCC46460
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337082173C
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558557190;
	bh=rxXoUM+jrWzLARo7p0qsj0QyHP/xt/UnSxert5sNGsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NCZ9ghh/8muKGw8YRsyN9NBRepdzVFzkp18CNxPYwVkwQ6UzaJtewqo1DMMmZ2yB/
	 xcQrMJlcmIaV1zYEi1megZvpjV/mk1WXGjV7v/yJj3NpLWxo5bHyyicZz/8EfuzvF7
	 yytalS4lY7uTjKytOdKjxUxnQWf6/BYF0Qf4yAmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfEVUdJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 16:33:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:16565 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEVUdJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 16:33:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 13:33:08 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2019 13:33:08 -0700
Date:   Wed, 22 May 2019 14:28:05 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
Message-ID: <20190522202805.GA5781@localhost.localdomain>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 22, 2019 at 10:20:45PM +0200, Bart Van Assche wrote:
> On 5/22/19 7:48 PM, Keith Busch wrote:
> > Hardware may temporarily stop processing commands that have
> > been dispatched to it while activating new firmware. Some target
> > implementation's paused state time exceeds the default request expiry,
> > so any request dispatched before the driver could quiesce for the
> > hardware's paused state will time out, and handling this may interrupt
> > the firmware activation.
> > 
> > This two-part series provides a way for drivers to reset dispatched
> > requests' timeout deadline, then uses this new mechanism from the nvme
> > driver's fw activation work.
> 
> Hi Keith,
> 
> Is it essential to modify the block layer to implement this behavior
> change? Would it be possible to implement this behavior change by
> modifying the NVMe driver only, e.g. by modifying the nvme_timeout()
> function and by making that function return BLK_EH_RESET_TIMER while new
> firmware is being activated?

Good question.

We can't just do this from nvme_timeout(), though. That introduces races
between timeout_work and fw_act_work if that fw work clears the
condition that timeout needs to observe to return RESET_TIMER.

Even if we avoid that race, the rq->deadline needs to be adjusted to
the current time after the h/w unpause because the time accumulated while
h/w halted itself should not be counted against the request.
