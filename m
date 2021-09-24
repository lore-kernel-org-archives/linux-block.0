Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6181B61212
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhIXP76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:59:58 -0400
Received: from verein.lst.de ([213.95.11.211]:40216 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233624AbhIXP76 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 11:59:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E074067373; Fri, 24 Sep 2021 17:58:22 +0200 (CEST)
Date:   Fri, 24 Sep 2021 17:58:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: don't print warnings if the underlying
 filesystem doesn't support discard
Message-ID: <20210924155822.GA10064@lst.de>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 03:48:27PM -0400, Mikulas Patocka wrote:
> Hi
> 
> When running the lvm testsuite, we get a lot of warnings 
> "blk_update_request: operation not supported error, dev loop0, sector 0 op 
> 0x9:(WRITE_ZEROES) flags 0x800800 phys_seg 0 prio class 0". The lvm 
> testsuite puts the loop device on tmpfs and the reason for the warning is 
> that tmpfs supports fallocate, but doesn't support FALLOC_FL_ZERO_RANGE.
> 
> I've created this patch to silence the warnings.
> 
> Mikulas
> 
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> The loop driver checks for the fallocate method and if it is present, it
> assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and
> FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or
> tmpfs) have the fallocate method, but lack the capability to do
> FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.
> 
> This results in syslog warnings "blk_update_request: operation not
> supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800
> phys_seg 0 prio class 0"
> 
> This patch sets RQF_QUIET to silence the warnings.

Doesn't this just paper over the problem?  I think we need an
unsigned int with flag in the file_operations for the supported
operations for this kind of use.
