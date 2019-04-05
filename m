Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D629BC10F0F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 06:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB0B206DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 06:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfDEGGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:06:25 -0400
Received: from verein.lst.de ([213.95.11.211]:52161 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEGGZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 02:06:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A1C4768B02; Fri,  5 Apr 2019 08:06:12 +0200 (CEST)
Date:   Fri, 5 Apr 2019 08:06:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
Message-ID: <20190405060612.GA32144@lst.de>
References: <20190404170843.83517-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404170843.83517-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

And what are we going to do about 5.1+?
