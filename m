Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B572C282DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458E820861
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfAUIre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:47:34 -0500
Received: from verein.lst.de ([213.95.11.211]:57021 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfAUIre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 03:47:34 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5C68F68DD2; Mon, 21 Jan 2019 09:47:32 +0100 (CET)
Date:   Mon, 21 Jan 2019 09:47:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
Message-ID: <20190121084732.GE18680@lst.de>
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 04:30:51PM +0200, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.

This seems to miss a "lightnvm" in the subject line.

>  static inline void pblk_setup_uuid(struct pblk *pblk)
>  {
> +	guid_gen((guid_t *)&pblk->instance_uuid);
>  }

I think we can just kill this wrapper.

But more importantly the instance_uuid fied, and the header.uuid one
it is copied from should be turned into an actual guid_t, the memcpys
and memcmps should also be replaced with the proper UUID API.
