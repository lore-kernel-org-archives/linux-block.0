Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68417C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779682075C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfC0IaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:30:20 -0400
Received: from verein.lst.de ([213.95.11.211]:40539 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0IaU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:30:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5E7A368B05; Wed, 27 Mar 2019 09:30:11 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:30:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190327083010.GO20525@lst.de>
References: <20190318032950.17770-1-ming.lei@redhat.com> <20190318032950.17770-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318032950.17770-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please make this an EXPORT_SYMBOL_GPL as for all new low-level blk-mq
exports.  Otherwise looks fine modolo any minor documentatio nitpicks
that I might have seen in the thread:

Reviewed-by: Christoph Hellwig <hch@lst.de>
