Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC0C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254BD2085A
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfENObX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 10:31:23 -0400
Received: from verein.lst.de ([213.95.11.211]:46144 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfENObX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 10:31:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D2E9268B05; Tue, 14 May 2019 16:31:02 +0200 (CEST)
Date:   Tue, 14 May 2019 16:31:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514143102.GA14401@lst.de>
References: <20190513063754.1520-1-hch@lst.de> <20190513063754.1520-2-hch@lst.de> <20190513094544.GA30381@ming.t460p> <20190513120344.GA22993@lst.de> <20190514043642.GB10824@ming.t460p> <20190514051441.GA6294@lst.de> <20190514090544.GC20468@ming.t460p> <20190514135141.GA13683@lst.de> <20190514142716.GB25519@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514142716.GB25519@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 14, 2019 at 10:27:17PM +0800, Ming Lei wrote:
> I am wondering if it can be done easily, given mkfs is userspace
> which only calls write syscall on block device. Or could you share
> something about how to fix the stupid things?

mkfs.ext4 at least uses buffered I/O on the block device.  And the
block device uses the really old buffer head based address_space ops,
which will submit one bio per buffer_head, that is per logic block.
mkfs probably writes much larger sizes than that..

> > nr_phys_segments that mirrors what is in the request, fixing bugs
> > in a few drivers, and allowing for follow on patches that significantly
> > simplify our I/O path.
> 
> non-gap device still has max segment size limit, and I guess it still
> needs to be respected.

It is still respected.  It might just disallow some merges we could
theoretically allow.
