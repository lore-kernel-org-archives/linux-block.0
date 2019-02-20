Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BFC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 14:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608820880
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 14:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBTORD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:17:03 -0500
Received: from verein.lst.de ([213.95.11.211]:58386 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfBTORD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 09:17:03 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D147468CEB; Wed, 20 Feb 2019 15:17:01 +0100 (CET)
Date:   Wed, 20 Feb 2019 15:17:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Message-ID: <20190220141701.GA26537@lst.de>
References: <20190220031122.GA17298@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220031122.GA17298@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We shouldn't be allocating a scatterlist for a command that doesn't
have a payload.

The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to
prevent that.

Chaitanya, can you try to debug why this is not working?  I'm on
vacation and don't have much time right now unfortunately.
