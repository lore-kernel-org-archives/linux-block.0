Return-Path: <SRS0=syOM=DM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C45C4727D
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 07:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C2E20756
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 07:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJEHNG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:13:06 -0400
Received: from verein.lst.de ([213.95.11.211]:57893 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHNG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D829867373; Mon,  5 Oct 2020 09:13:03 +0200 (CEST)
Date:   Mon, 5 Oct 2020 09:13:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: Re: remove bdget() as a public API
Message-ID: <20201005071303.GA12639@lst.de>
References: <20200925160618.1481450-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925160618.1481450-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Fri, Sep 25, 2020 at 06:06:16PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up the somewhat odd size handling in
> drbd, and then kill off bdget() as a public API.
---end quoted text---
