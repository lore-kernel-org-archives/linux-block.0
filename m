Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A6C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBBA20883
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554736887;
	bh=Y9TuAUedHVwsi2vRrjX3deZVQ3snQuenj06KoonGPgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1XcMxm9EgfYtMB1tKrLm8BhDbo9fsUd2ZPHka3XjKaVY/0CRpkd67lcU1Td3rDbEu
	 rJN/eUzqM+jpf1ACUL/pxMXUleNtDhisVmUDjG4K+em+mRSBvt85/KvwsOcKP8rra8
	 X7gBdfB+5+75ZM0XCl6EmlIA9/yUfa/nG5R2k3+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfDHPV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:21:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:49262 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbfDHPV1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 11:21:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 08:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="140975132"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2019 08:21:25 -0700
Date:   Mon, 8 Apr 2019 09:23:02 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "Busch, Keith" <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190408152302.GE32498@localhost.localdomain>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
 <20190407075123.GA22003@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407075123.GA22003@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 07, 2019 at 12:51:23AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 05, 2019 at 05:36:32PM -0600, Keith Busch wrote:
> > On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> > > Looking at current peak testing, I've got around 1.2% in queue enter
> > > and exit. It's definitely not free, hence my question. Probably safe
> > > to assume that we'll double that cycle counter, per IO.
> > 
> > Okay, that's not negligible at all. I don't know of a faster reference
> > than the percpu_ref, but that much overhead would have to rule out
> > having a per hctx counter.
> 
> Can we just replace queue_enter/exit with the per-hctx reference
> entirely?

I don't think that we can readily do that. We still need to protect a
request_queue access prior to selecting the hctx.
