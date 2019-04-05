Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8CC4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E2B21871
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfDELgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:36:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELgC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 07:36:02 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCN8I-0007w7-74; Fri, 05 Apr 2019 13:35:42 +0200
Date:   Fri, 5 Apr 2019 13:35:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Keith Busch <kbusch@kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        fin4478 fin4478 <fin4478@hotmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: A kernel warning when entering suspend
In-Reply-To: <20190404225014.GB31281@ming.t460p>
Message-ID: <alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com> <20190404085524.GA24927@ming.t460p> <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com> <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p> <20190404222955.GA25081@localhost.localdomain> <20190404225014.GB31281@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 5 Apr 2019, Ming Lei wrote:
> On Thu, Apr 04, 2019 at 04:29:56PM -0600, Keith Busch wrote:
> > On Fri, Apr 05, 2019 at 06:19:50AM +0800, Ming Lei wrote:
> > > Also in current blk-mq implementation, one irq may become shutdown
> > > because of CPU hotplug even though when there is in-flight request
> > > on the queue served by the irq. Then we depend on timeout handler to
> > > cover this case, and this irq may be enabled in the timeout handler too,
> > > please see nvme_poll_irqdisable().
> > 
> > Right, but when the last CPU mapped to an hctx is taken offline, we really
> > ought to have blk-mq wait for that hctx to reap all outstanding requests
> > before letting the notifier continue with offlining that CPU. We just
> > don't have the infrastructure to freeze an individual hctx yet.
> 
> Looks this issue isn't unique for storage device, anyone knows how other
> device drivers deal with this situation? For example, one network packet is
> submitted to NIC controller and not got completed, then the interrupt
> may become down because of CPU hotplug.

If the interrupt is managed yes.

That was the constraint of managed interrupts from the very beginning:

  The driver/subsystem has to quiesce the interrupt line and the associated
  queue _before_ it gets shutdown in CPU unplug and not fiddle with it
  until it's restarted by the core when the CPU is plugged in again.

Thanks,

	tglx
