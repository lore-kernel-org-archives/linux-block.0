Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A3C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BD72133F
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 08:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLRIJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:09:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRIJ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 03:09:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 727C07FD42;
        Tue, 18 Dec 2018 08:09:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27DEF5D9CD;
        Tue, 18 Dec 2018 08:09:23 +0000 (UTC)
Date:   Tue, 18 Dec 2018 16:09:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] blk-mq: enable IO poll if .nr_queues of type poll > 0
Message-ID: <20181218080918.GA28587@ming.t460p>
References: <20181218041529.27787-1-ming.lei@redhat.com>
 <95d4e41f-24a7-bdb5-e014-994e021f901a@kernel.dk>
 <20181218064739.GA1219@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218064739.GA1219@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Dec 2018 08:09:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 07:47:39AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 17, 2018 at 09:34:55PM -0700, Jens Axboe wrote:
> > On 12/17/18 9:15 PM, Ming Lei wrote:
> > > The queue mapping of type poll only exists when set->map[HCTX_TYPE_POLL].nr_queues
> > > is bigger than zero, so enhance the constraint by checking .nr_queues of type poll
> > > before enabling IO poll.
> > > 
> > > Otherwise IO race & timeout can be observed when running block/007.
> > 
> > Looks good to me, but we might consider having a helper for this, since
> > we have this check in 3 places now. But for now this is good, thanks
> > Ming.
> 
> Jens, if you want this I can drop the nvme patch to set nr_maps to 2
> as it wouldn't be needed.  Not sure which one is more elegant, but
> I guess Mings version is a little more fool proof.

For READ queue type, its .nr_maps can be 3 and .nr_queues is zero, so
if check on the two queue type is kept as consistent, we may get good
code readability, IMO.

As Jens mentioned, we may introduce blk_mq_queue_type_supported() helper
to cover both.

Thanks,
Ming
