Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C84CC10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BDB206B6
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfDPQrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:47:12 -0400
Received: from verein.lst.de ([213.95.11.211]:36620 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbfDPQrM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 12:47:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D227568AFE; Tue, 16 Apr 2019 18:46:58 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:46:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] block: make sure that bvec length can't be overflowed
Message-ID: <20190416164658.GA4030@lst.de>
References: <20190416153847.8173-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416153847.8173-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/overflowed/overflow/ in the subject.

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although this will create yet another conflict between Linus' tree
and the 5.2 block tree.

Although maybe Jens still reset the tree and move the merge past this..
