Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58732 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbdISPCY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 11:02:24 -0400
Date: Tue, 19 Sep 2017 11:07:22 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Message-ID: <20170919150721.GA6180@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com>
 <20170918223900.GA4671@localhost.localdomain>
 <1505775191.12701.20.camel@wdc.com>
 <20170918230803.GB4671@localhost.localdomain>
 <CACVXFVO4joG1zzipABWK4bc5Rwo9bDa4by4_mFOTx10nQPAUpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVO4joG1zzipABWK4bc5Rwo9bDa4by4_mFOTx10nQPAUpQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 19, 2017 at 12:16:31PM +0800, Ming Lei wrote:
> On Tue, Sep 19, 2017 at 7:08 AM, Keith Busch <keith.busch@intel.com> wrote:
> >
> > Indeed that prevents .complete from running concurrently with the
> > timeout handler, but scsi_mq_done and nvme_handle_cqe are not .complete
> > callbacks. These are the LLD functions that call blk_mq_complete_request
> > well before .complete. If the driver calls blk_mq_complete_request on
> > a request that blk-mq is timing out, the request is lost because blk-mq
> > already called blk_mark_rq_complete. Nothing prevents these LLD functions
> 
> That shouldn't happen because only one blk_mark_rq_complete() can win
> and it is the winner's responsibility to complete the request, so
> there shouldn't
> be request lost. Especially in your case, it is the responsibility of timeout
> to complete the rq really.

Hm, either I'm explaining this poorly, or I'm missing something that's
obvious to everyone else.

The driver's IRQ handler has no idea it's racing with the blk-mq timeout
handler, and there's nothing indicating it lost the race. The IRQ handler
just calls blk_mq_complete_request. As far as the driver is concerned,
it has done its part to complete the request at that point.

The problem is when blk-mq's timeout handler prevents the request from
completing, and doesn't leave any indication the driver requested to
complete it. Who is responsible for completing that request now?
