Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D7C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 05:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206ED610A8
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 05:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhJVF5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 01:57:36 -0400
Received: from verein.lst.de ([213.95.11.211]:49096 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhJVF5g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 01:57:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53E8368BEB; Fri, 22 Oct 2021 07:55:16 +0200 (CEST)
Date:   Fri, 22 Oct 2021 07:55:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] memremap: remove support for external pgmap
 refcounts
Message-ID: <20211022055515.GA21767@lst.de>
References: <20211019073641.2323410-1-hch@lst.de> <20211019073641.2323410-3-hch@lst.de> <YXFtwcAC0WyxIWIC@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXFtwcAC0WyxIWIC@angband.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21, 2021 at 03:40:17PM +0200, Adam Borowski wrote:
> This breaks at least drivers/pci/p2pdma.c:222

Indeed.  I've updated this patch, but the fix we need to urgently
get into 5.15-rc is the first one only anyway.

nvdimm maintainers, can you please act on it ASAP?
