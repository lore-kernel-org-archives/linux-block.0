Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806BC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3310206BA
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfDYHf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfDYHf5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:35:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B0A523E6D8;
        Thu, 25 Apr 2019 07:35:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0EBC5D9C5;
        Thu, 25 Apr 2019 07:35:48 +0000 (UTC)
Date:   Thu, 25 Apr 2019 15:35:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
Message-ID: <20190425073542.GA28630@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-2-ming.lei@redhat.com>
 <20190424161834.GA23854@lst.de>
 <20190425005332.GB22636@ming.t460p>
 <20190425053234.GA7166@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425053234.GA7166@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 25 Apr 2019 07:35:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 07:32:34AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 08:53:34AM +0800, Ming Lei wrote:
> > It isn't in other callers of blk_mq_sched_insert_requests(), it is just
> > needed in some corner case like flush plug context.
> > 
> > For other callers of blk_mq_sched_insert_requests(), it is guaranteed
> > that request queue's ref is held.
> 
> In both Linus' tree and Jens' for-5.2 tree I only see these two
> callers of blk_mq_sched_insert_requests.  What am I missing?

OK, what I meant is that the issue is flush plug context specific.
And I didn't notice that this function is only called by
blk_mq_flush_plug_list().

Then it is fine to move the percpu_ref_get()/percpu_ref_put() into
the function, better with comment on this issue.

Thanks, 
Ming
