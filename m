Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E404C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29222081C
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD3Q0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:26:31 -0400
Received: from foss.arm.com ([217.140.101.70]:49836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3Q0b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:26:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B78D374;
        Tue, 30 Apr 2019 09:26:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4949C3F5C1;
        Tue, 30 Apr 2019 09:26:29 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:26:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.or
Subject: Re: [PATCH] io_uring: free allocated io_memory once
Message-ID: <20190430162626.GC8314@lakrids.cambridge.arm.com>
References: <20190430162018.40040-1-mark.rutland@arm.com>
 <89bc35e4-ae74-a15f-03fd-9f766c86315a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89bc35e4-ae74-a15f-03fd-9f766c86315a@kernel.dk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 30, 2019 at 10:22:23AM -0600, Jens Axboe wrote:
> On 4/30/19 10:20 AM, Mark Rutland wrote:
> > -	io_mem_free(ctx->sq_ring);
> > -	io_mem_free(ctx->sq_sqes);
> > -	io_mem_free(ctx->cq_ring);
> > +	if (ctx->sq_ring)
> > +		io_mem_free(ctx->sq_ring);
> > +	if (ctx->sq_sqes)
> > +		io_mem_free(ctx->sq_sqes);
> > +	if (ctx->cq_ring)
> > +		io_mem_free(ctx->cq_ring);
> 
> Please just make io_mem_free() handle a NULL pointer so we don't need
> these checks.

Sure; I'll spin a v2 momentarily.

Thanks,
Mark.
