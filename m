Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEB5C433E3
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88C62073E
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGZPMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:12:42 -0400
Received: from verein.lst.de ([213.95.11.211]:40668 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGZPMl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 11:12:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6A7A68B05; Sun, 26 Jul 2020 17:12:38 +0200 (CEST)
Date:   Sun, 26 Jul 2020 17:12:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: bdi cleanups v3
Message-ID: <20200726151238.GA23460@lst.de>
References: <20200726150333.305527-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726150333.305527-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 26, 2020 at 05:03:19PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of different BDI cleanups.  The biggest item
> is to isolate block drivers from the BDI in preparation of changing the
> lifetime of the block device BDI in a follow up series.

Ooops, sorry for reposting this - it is exactly the same v3 I already
posted.
