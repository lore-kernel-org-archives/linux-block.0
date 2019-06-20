Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5906AC4646C
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3920E2084A
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfFTJpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:45:05 -0400
Received: from verein.lst.de ([213.95.11.211]:59089 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfFTJpF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:45:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2F52868B05; Thu, 20 Jun 2019 11:44:35 +0200 (CEST)
Date:   Thu, 20 Jun 2019 11:44:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: remove bi_phys_segments and related cleanups
Message-ID: <20190620094434.GA24225@lst.de>
References: <20190606102904.4024-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606102904.4024-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Thu, Jun 06, 2019 at 12:28:58PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the bi_phys_segments member in struct bio
> and cleans up various areas around it.
---end quoted text---
