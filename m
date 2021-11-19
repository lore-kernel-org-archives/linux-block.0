Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 16:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAF0610D0
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhKSQ7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:59:34 -0500
Received: from verein.lst.de ([213.95.11.211]:51820 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236167AbhKSQ7d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 11:59:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2199968AFE; Fri, 19 Nov 2021 17:56:28 +0100 (CET)
Date:   Fri, 19 Nov 2021 17:56:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tim Walker <tim.t.walker@seagate.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Message-ID: <20211119165627.GA15266@lst.de>
References: <20211118153041.2163228-1-ming.lei@redhat.com> <163732851304.44181.8545954410705439362.b4-ty@kernel.dk> <BFC93946-13B3-43EC-9E30-8A980CD5234F@seagate.com> <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Direct reply without a quote a the formatting of your mail is completely
messed up.  We don't treat a FUA a a flush.  If the device supports
FUA is is just passed on.  But if the device does not support FUA it
is sequenced into doing the write first and then a flush before returning
completion to the caller to guarantee the FUA semantics.  Because of that
the command needs special treatment and be handed over to the flush
state machine, but it won't do anything interesting if FUA is actually
natively supported.
