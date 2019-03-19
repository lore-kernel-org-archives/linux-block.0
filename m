Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDFC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 01:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED1720989
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 01:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCSBby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfCSBby (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 21:31:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB645308213A;
        Tue, 19 Mar 2019 01:31:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 756585D704;
        Tue, 19 Mar 2019 01:31:47 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:31:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190319013142.GB22459@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 19 Mar 2019 01:31:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 10:37:08AM -0700, James Smart wrote:
> 
> 
> On 3/17/2019 8:29 PM, Ming Lei wrote:
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
> > 
> 
> This won't help FC at all. Inherently, the "completion" has to be
> asynchronous as line traffic may be required.
> 
> e.g. FC doesn't use nvme_complete_request() in the iterator routine.
> 

Looks FC has done the sync already, see nvme_fc_delete_association():

		...
        /* wait for all io that had to be aborted */
        spin_lock_irq(&ctrl->lock);
        wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
        ctrl->flags &= ~FCCTRL_TERMIO;
        spin_unlock_irq(&ctrl->lock);

Thanks,
Ming
