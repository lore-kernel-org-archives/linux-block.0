Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E040C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2AA206BA
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHVA4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:56:32 -0400
Received: from verein.lst.de ([213.95.11.211]:42338 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfHVA4c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 20:56:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AFD568BFE; Thu, 22 Aug 2019 02:56:30 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:56:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V3 4/6] null_blk: create a helper for mem-backed ops
Message-ID: <20190822005629.GE10938@lst.de>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com> <20190821061314.3262-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821061314.3262-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 11:13:12PM -0700, Chaitanya Kulkarni wrote:
> This patch creates a helper for handling requests when null_blk is
> memory backed in the null_handle_cmd(). Although the helper is very
> simple right now, it makes the code flow consistent with the rest of
> code in the null_handle_cmd() and provides a uniform code structure
> for future code.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
