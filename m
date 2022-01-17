Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8510C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiAQIKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiAQIKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:10:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1EC061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 00:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HwejvMnBoA1j7w5QJl/HIDS2zwmP3MBVuNCKgWAC3kI=; b=W1cixaVR+ivKkScvZyMEOzK3Wr
        gjM3FdkDiR+gFcJP4coW1EGd+rd46dITN5MhsxprtX6U5IQMX122B8Ecm6/sreWp+zFo9Ttt9qbiS
        KVzcwWEsOZfSVoZQPo8m4xWVtEJbWazlAHPSBLV34RpVd3DWgKpNe3fXbN4INXZ2LIX5TEPBsR6ZL
        +QZYSjJieo6HqYDXz3lWbrs7ih81+GHSqvOI2XLVSBYh5MZpQdeAvOigLT7nPFZvFaoXNaGQh+hyu
        OGz1huxtupLKMH4sBH/NoBCh1ZpLeMq1MB6v2FY210Um3wwM+u0ykHaYyMlgz/gfnO86CWy4ncgiX
        +IGBsxsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9N5g-00E22J-6w; Mon, 17 Jan 2022 08:10:12 +0000
Date:   Mon, 17 Jan 2022 00:10:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [dm-devel] [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING
 for dm-rq
Message-ID: <YeUkZGw4vLqdB17p@infradead.org>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
 <YcuB4K8P2d9WFb83@redhat.com>
 <Yd1BFpYTBlQSPReW@infradead.org>
 <x49ee5ejfly.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49ee5ejfly.fsf@segfault.boston.devel.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 01:23:53PM -0500, Jeff Moyer wrote:
> Maybe I have bad taste, but the patches didn't look like cruft to me.
> :)

They do to me.  The extend the corner case of request on request
stacking that already is a bit of mess even more by adding yet another
special case in the block layer.

> 
> I'm not sure why we'd prevent users from using dm-mpath on nvmeof.  I
> think there's agreement that the nvme native multipath implementation is
> the preferred way (that's the default in rhel9, even), but I don't think
> that's a reason to nack this patch set.
> 
> Or have I missed your point entirely?

No you have not missed the point.  nvme-multipath exists longer than
the nvme-tcp driver and is the only supported one for it upstream for
a good reason.  If RedHat wants to do their own weirdo setups they can
patch their kernels, but please leave the upstrem code alone.
