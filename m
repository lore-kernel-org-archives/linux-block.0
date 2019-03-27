Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE38AC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAB0206B7
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553652854;
	bh=VvHZ5vGJk7HrBd2fmAGJZqonihBIEkH9NHMMoNjL9Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XCkvsWih41uAOx1AVid+dlNe5L91B2B6AKOiXW2UA3QtjfCYKsQ5A06mzEnCv317j
	 JFE3Yzgz+S7YsDV9iURxeSteZQPQxo28b66wB0XwOHGR+oKIpGI64oQXYX60ZC4THL
	 hKTEba+zVFJMlx5PgDnCcaJjdcbRkbLwCwhnS5L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfC0COO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:14:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:2329 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfC0COO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 22:14:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 19:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="130476793"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2019 19:14:11 -0700
Date:   Tue, 26 Mar 2019 20:15:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
Message-ID: <20190327021521.GA7389@localhost.localdomain>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 10:03:26AM +0800, jianchao.wang wrote:
> Hi Keith
> 
> On 3/27/19 7:57 AM, Keith Busch wrote:
> > On Mon, Mar 25, 2019 at 08:05:53PM -0700, jianchao.wang wrote:
> >> What if there used to be a io scheduler and leave some stale requests of sched tags ?
> >> Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?
> > 
> > Requests internally queued in scheduler or block layer are not eligible
> > for the nvme driver's iterator callback. We only use it to reclaim
> > dispatched requests that the target can't return, which only applies to
> > requests that must have a valid rq->tag value from hctx->tags.
> >  
> >> The stable request could be some tings freed and used
> >> by others and the state field happen to be overwritten to non-zero...
> > 
> > I am not sure I follow what this means. At least for nvme, every queue
> > sharing the same tagset is quiesced and frozen, there should be no
> > request state in flux at the time we iterate.
> > 
> 
> In nvme_dev_disable, when we try to reclaim the in-flight requests with blk_mq_tagset_busy_iter,
> the request_queues are quiesced but just start-freeze.
> We will try to _drain_ the in-flight requests for the _shutdown_ case when controller is not dead.
> For the reset case, there still could be someone escapes the checking of queue freezing and enters
> blk_mq_make_request and tries to allocate tag, then we may get,
> 
> generic_make_request        nvme_dev_disable
>  -> blk_queue_enter              
>                               -> nvme_start_freeze (just start freeze, no drain)
>                               -> nvme_stop_queues
>  -> blk_mq_make_request
>   - > blk_mq_get_request      -> blk_mq_tagset_busy_iter
>      -> blk_mq_get_tag
>                       　　        -> bt_tags_for_each
>                          　　　       -> bt_tags_iter
>                               　　       -> rq = tags->rqs[] ---> [1]
>      -> blk_mq_rq_ctx_init
>        -> data->hctx->tags->rqs[rq->tag] = rq;
> 
> The rq got on position [1] could be a stale request that has been freed due to,
> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
> 2. a removed io scheduler's sched request
> 
> And this stale request may have been used by others and the request->state is changed to a non-zero
> value and passes the checking of blk_mq_request_started and then it will be handled by nvme_cancel_request.

How is that request state going to be anyting other than IDLE? A freed
request state is IDLE, and continues to be IDLE until dispatched. But
dispatch is blocked for the entire tagset, so request states can't be
started during an nvme reset.
