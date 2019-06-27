Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E1CC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDCB2063F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 07:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfF0HcE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:32:04 -0400
Received: from verein.lst.de ([213.95.11.211]:50216 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfF0HcE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 03:32:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E808768B20; Thu, 27 Jun 2019 09:31:32 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:31:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Remove unused code
Message-ID: <20190627073132.GA10007@lst.de>
References: <20190627025941.32262-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627025941.32262-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

The function has been unused going back to at least Linux 3.15.
