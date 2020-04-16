Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF43AC2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDAD21D91
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501943AbgDPP3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:29:51 -0400
Received: from verein.lst.de ([213.95.11.211]:52669 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395180AbgDPP3u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 11:29:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F038268BEB; Thu, 16 Apr 2020 17:29:46 +0200 (CEST)
Date:   Thu, 16 Apr 2020 17:29:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, yuyufen@huawei.com, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev)
Message-ID: <20200416152946.GA10845@lst.de>
References: <20200416071519.807660-1-hch@lst.de> <874d57cb-90f1-db09-8f9d-29527451e241@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874d57cb-90f1-db09-8f9d-29527451e241@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 16, 2020 at 09:29:13AM -0600, Jens Axboe wrote:
> On 4/16/20 1:15 AM, Christoph Hellwig wrote:
> > Hi all,
> > 
> > the first three patches are my take on the proposal from Yufen Yu
> > to fix the use after free of the device name of the bdi device.
> > 
> > The rest is vaguely related cleanups.
> 
> Applied, thanks.

Please hold back, we still have a major issues with it.  I will resend
a fixed version tomorrow.
