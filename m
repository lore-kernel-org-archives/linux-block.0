Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0AEC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E57F208CB
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFTJmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:42:54 -0400
Received: from verein.lst.de ([213.95.11.211]:59071 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbfFTJmw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 99CD768BFE; Thu, 20 Jun 2019 11:42:21 +0200 (CEST)
Date:   Thu, 20 Jun 2019 11:42:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: blk-cgroup cleanups
Message-ID: <20190620094220.GA24189@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Thu, Jun 06, 2019 at 12:26:18PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> below are a couple of cleanups I came up with when trying to understand
> the blk-cgroup code.
---end quoted text---
