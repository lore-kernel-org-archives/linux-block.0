Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F50C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C7220879
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfDACI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfDACI1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 22:08:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6478730715CA;
        Mon,  1 Apr 2019 02:08:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5832360C8A;
        Mon,  1 Apr 2019 02:08:19 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:08:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 4/5] block: don't drain in-progress dispatch in
 blk_cleanup_queue()
Message-ID: <20190401020814.GD30776@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <20190331030954.22320-5-ming.lei@redhat.com>
 <658802bd-99a5-6446-5059-8536febba05e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658802bd-99a5-6446-5059-8536febba05e@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 01 Apr 2019 02:08:27 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 09:50:12AM +0800, Dongli Zhang wrote:
> 
> 
> On 3/31/19 11:09 AM, Ming Lei wrote:
> > Now freeing dispatch resource is moved to queue's release handler,
> > we don't need to worry about the race between blk_cleanup_queue and
> > run queue any more.
> > 
> > So don't drain in-progress dispatch in blk_cleanup_queue().
> 
> Unless this direction is not followed, how about we mention that this is revert
> of prior two fixes (which are not required any longer) so that people working on
> backport would feel much more easier to track the issue.
> 
> c2856ae2f315 ("blk-mq: quiesce queue before freeing queue")
> 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")

OK, will mention that in V2.

Thanks,
Ming
