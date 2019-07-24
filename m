Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10CEC76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA5229EC
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 02:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfGXCFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbfGXCFR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 22:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E45183F51;
        Wed, 24 Jul 2019 02:05:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7FA5C225;
        Wed, 24 Jul 2019 02:05:08 +0000 (UTC)
Date:   Wed, 24 Jul 2019 10:05:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
Message-ID: <20190724020500.GE22421@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
 <8d6268ac-42cb-d14a-d4c3-c8c285fca6b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6268ac-42cb-d14a-d4c3-c8c285fca6b5@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 24 Jul 2019 02:05:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 24, 2019 at 12:14:24AM +0800, Dongli Zhang wrote:
> Hi Ming,
> 
> On 07/22/2019 01:39 PM, Ming Lei wrote:
> > When aborting in-flight request for recoverying controller, we have
> 
> recovering
> 
> > maken sure that queue's complete function is called on completed
> > request before moving one. For example, the warning of
> > WARN_ON_ONCE(qp->mrs_used > 0) in ib_destroy_qp_user() may be triggered.
> > 
> > Fix this issue by using blk_mq_tagset_drain_completed_request.
> > 
> 
> Should be blk_mq_tagset_wait_completed_request but not
> blk_mq_tagset_drain_completed_request?

Will fix the two in V2.

Thanks,
Ming
