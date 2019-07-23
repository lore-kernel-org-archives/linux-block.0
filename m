Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8823C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A16C2199C
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfGWBGc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731384AbfGWBGc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 21:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5130308421A;
        Tue, 23 Jul 2019 01:06:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E56760603;
        Tue, 23 Jul 2019 01:06:22 +0000 (UTC)
Date:   Tue, 23 Jul 2019 09:06:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
Message-ID: <20190723010616.GC30776@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
 <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Jul 2019 01:06:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 22, 2019 at 08:25:07AM -0700, Bart Van Assche wrote:
> On 7/21/19 10:39 PM, Ming Lei wrote:
> > blk-mq may schedule to call queue's complete function on remote CPU via
> > IPI, but doesn't provide any way to synchronize the request's complete
> > fn.
> > 
> > In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> > re-allocated. If the completed request's complete fn is run finally after the
> > hardware queue's resource is released, kernel crash will be triggered.
> > 
> > Prepare for fixing this kind of issue by introducing
> > blk_mq_tagset_wait_completed_request().
> 
> An explanation is missing of why the block layer is modified to fix this
> instead of the NVMe driver.

The above commit log has explained that there isn't sync mechanism in
blk-mq wrt. request completion, and there might be similar issue in other
future drivers.


Thanks,
Ming
