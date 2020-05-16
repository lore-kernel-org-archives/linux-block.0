Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99260C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807D220727
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgEPMl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 08:41:58 -0400
Received: from verein.lst.de ([213.95.11.211]:60432 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPMl6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 08:41:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30FA568B05; Sat, 16 May 2020 14:41:57 +0200 (CEST)
Date:   Sat, 16 May 2020 14:41:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] block: Fix type of first compat_put_{,u}long()
 argument
Message-ID: <20200516124157.GA13544@lst.de>
References: <20200516001914.17138-1-bvanassche@acm.org> <20200516001914.17138-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516001914.17138-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 05:19:10PM -0700, Bart Van Assche wrote:
> This patch fixes the following sparse warnings:

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
