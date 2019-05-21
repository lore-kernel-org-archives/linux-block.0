Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAFEC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DC621773
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEUM6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:58:00 -0400
Received: from verein.lst.de ([213.95.11.211]:60130 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfEUM6A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:58:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 05F3968AFE; Tue, 21 May 2019 14:57:38 +0200 (CEST)
Date:   Tue, 21 May 2019 14:57:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/3] block: don't protect generic_make_request_checks
 with blk_queue_enter
Message-ID: <20190521125737.GB4577@lst.de>
References: <20190515030310.20393-1-ming.lei@redhat.com> <20190515030310.20393-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515030310.20393-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
