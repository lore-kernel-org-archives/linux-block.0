Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CC8C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3896A2085A
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552924355;
	bh=adkHIhy0hpLzBOMxL2+tiQhQ+2V6H1aflwiY1TLMXTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TGReQVw74CHgL8l3Kl2evFF+HAXi+yOX4Ro4CcpGKx6D/cRMGHtRKxEhb84aAgyZf
	 dW0MtKKR5FsCwLQMNx/qq4pwU39piX9dVxRV0SYtLTx27ne52OSQCr2j+EUg18U0ZM
	 M58aBuuAvPXpzxQ5Zz0BTU2MdvaAw9DD1BJ5rTAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCRPwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:52:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:18026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfCRPwe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 08:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="141703258"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2019 08:52:33 -0700
Date:   Mon, 18 Mar 2019 09:53:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jsmart2021@gmail.com" <jsmart2021@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "hare@suse.de" <hare@suse.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/8] blk-mq: change the method of iterating busy tags of
 a request_queue
Message-ID: <20190318155326.GB23533@localhost.localdomain>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
 <20190315161608.GB15153@localhost.localdomain>
 <CACVXFVM=r-jS_GnkAuARiiXLr3bQeWV5Gix3+F03B5oYbmdULw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVM=r-jS_GnkAuARiiXLr3bQeWV5Gix3+F03B5oYbmdULw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 16, 2019 at 11:50:27PM -0700, Ming Lei wrote:
> On Sat, Mar 16, 2019 at 12:15 AM Keith Busch <kbusch@kernel.org> wrote:
> > On Fri, Mar 15, 2019 at 01:57:38AM -0700, Jianchao Wang wrote:
> > > +     if (rq && rq->q == hctx->queue &&
> > > +         rq->mq_hctx == hctx &&
> > > +         (!iter_data->inflight ||
> > > +          blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> > > +             return iter_data->fn(rq, iter_data->data, reserved);
> >
> > There is still a window where the check may succeed, but the request is
> > being assigned to a completely different request_queue. The callback
> > then operates on a request it doesn't own.
> 
> The situation above is only related with 'none' io scheduler.
> 
> However, this patch doesn't change behavior for none given .rq[tag] is same with
> .static_rq[tag], so I guess your concern may not be related with this patch.

Right, it's not new, but queue iteration wasn't exported for drivers
before this.
