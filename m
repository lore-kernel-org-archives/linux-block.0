Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D510CC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 22:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18B3217D4
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 22:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfDDWu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:50:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfDDWu2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 18:50:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0280F74B7;
        Thu,  4 Apr 2019 22:50:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DFDA7EFB1;
        Thu,  4 Apr 2019 22:50:20 +0000 (UTC)
Date:   Fri, 5 Apr 2019 06:50:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        fin4478 fin4478 <fin4478@hotmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: A kernel warning when entering suspend
Message-ID: <20190404225014.GB31281@ming.t460p>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>
 <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p>
 <20190404222955.GA25081@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404222955.GA25081@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Apr 2019 22:50:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 04, 2019 at 04:29:56PM -0600, Keith Busch wrote:
> On Fri, Apr 05, 2019 at 06:19:50AM +0800, Ming Lei wrote:
> > Also in current blk-mq implementation, one irq may become shutdown
> > because of CPU hotplug even though when there is in-flight request
> > on the queue served by the irq. Then we depend on timeout handler to
> > cover this case, and this irq may be enabled in the timeout handler too,
> > please see nvme_poll_irqdisable().
> 
> Right, but when the last CPU mapped to an hctx is taken offline, we really
> ought to have blk-mq wait for that hctx to reap all outstanding requests
> before letting the notifier continue with offlining that CPU. We just
> don't have the infrastructure to freeze an individual hctx yet.

Looks this issue isn't unique for storage device, anyone knows how other
device drivers deal with this situation? For example, one network packet is
submitted to NIC controller and not got completed, then the interrupt
may become down because of CPU hotplug.

Thanks,
Ming
