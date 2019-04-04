Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38581C10F08
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0756020882
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDDVoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfDDVoB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 17:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AE0D30FE5CB;
        Thu,  4 Apr 2019 21:44:01 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 441495C28F;
        Thu,  4 Apr 2019 21:43:51 +0000 (UTC)
Date:   Fri, 5 Apr 2019 05:43:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
Message-ID: <20190404214344.GA30656@ming.t460p>
References: <20190404170843.83517-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404170843.83517-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 04 Apr 2019 21:44:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
> blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for requests that
> have been queued. If that happens when blk_mq_try_issue_directly() is called
> by the dm-mpath driver then dm-mpath will try to resubmit a request that is
> already queued and a kernel crash follows. Since it is nontrivial to fix
> blk_mq_request_issue_directly(), revert the blk_mq_request_issue_directly()
> changes that went into kernel v5.0.
> 
> This patch reverts the following commits:
> * d6a51a97c0b2 ("blk-mq: replace and kill blk_mq_request_issue_directly") # v5.0.
> * 5b7a6f128aad ("blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests") # v5.0.
> * 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.

I am fine to revert them now.

However, could you revert them one by one so that they can be reviewed
easily?

Thanks,
Ming
