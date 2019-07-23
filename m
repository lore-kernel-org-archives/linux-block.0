Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5846FC7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290E921955
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGWBK5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfGWBK5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 21:10:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3568385539;
        Tue, 23 Jul 2019 01:10:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 450D71017E3B;
        Tue, 23 Jul 2019 01:10:48 +0000 (UTC)
Date:   Tue, 23 Jul 2019 09:10:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] blk-mq: wait until completed req's complete fn is run
Message-ID: <20190723011040.GE30776@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <a22e7266-98cb-875d-aa89-f37dd6c34ad5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22e7266-98cb-875d-aa89-f37dd6c34ad5@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 23 Jul 2019 01:10:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 07:27:00AM +0800, Bob Liu wrote:
> On 7/22/19 1:39 PM, Ming Lei wrote:
> > Hi,
> > 
> > blk-mq may schedule to call queue's complete function on remote CPU via
> > IPI, but never provide any way to synchronize the request's complete
> > fn.
> > 
> > In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> > re-allocated. If the completed request's complete fn is run finally after the
> > hardware queue's resource is released, kernel crash will be triggered.
> > 
> 
> Have you seen the crash? Anyway to emulate/verify this bug..

The crash is reported on nvme-rdma by one RH partner, and the approach
of this patchset has been verified already.

Thanks,
Ming
