Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD0BC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E5B206BA
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbeLQBHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLQBHA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 20:07:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 246D5C049582;
        Mon, 17 Dec 2018 01:07:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD39619C7F;
        Mon, 17 Dec 2018 01:06:52 +0000 (UTC)
Date:   Mon, 17 Dec 2018 09:06:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 4/4] blk-mq-debugfs: export hctx->type
Message-ID: <20181217010646.GC1223@ming.t460p>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-5-ming.lei@redhat.com>
 <20181216161744.GE9957@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216161744.GE9957@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 01:07:00 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 05:17:44PM +0100, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 10:25:17AM +0800, Ming Lei wrote:
> > Now we only export hctx->type via sysfs, and there isn't such info
> > in hctx entry under debugfs. We often use debugfs only to diagnose
> > queue mapping issue, so add the support in debugfs.
> > 
> > Queue mapping becomes a bit more complicated after multiple queue
> > mapping is supported, we may write blktest to verify if queue mapping
> > is valid based on blk-mq-debug.
> 
> I'll let Jens decide if we really want to double export information
> like this (or maybe even move it to debugfs only?)

It is pretty friendly to export all in one place, given users may
collect log just by one single command or familiar way.

> 
> > +static int hctx_type_show(void *data, struct seq_file *m)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = data;
> > +
> > +	seq_printf(m, "%u\n", hctx->type);
> > +	return 0;
> 
> But if we export it we should probably export it as a text, just
> like we do for sysfs now.

OK.


Thanks,
Ming
