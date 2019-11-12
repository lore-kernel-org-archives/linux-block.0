Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADECC43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 08:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4F5206A3
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 08:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfKLIbd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:31:33 -0500
Received: from verein.lst.de ([213.95.11.211]:54437 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfKLIbd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 03:31:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA5B68AFE; Tue, 12 Nov 2019 09:31:30 +0100 (CET)
Date:   Tue, 12 Nov 2019 09:31:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: check bi_size overflow before merge
Message-ID: <20191112083130.GA4514@lst.de>
References: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
