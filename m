Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA53C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAEA60EBD
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhHTKCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:02:43 -0400
Received: from verein.lst.de ([213.95.11.211]:40428 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237139AbhHTKCm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 06:02:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 446A26736F; Fri, 20 Aug 2021 12:02:03 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:02:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARNING: possible circular locking dependency detected in nbd
Message-ID: <20210820100202.GB9872@lst.de>
References: <yt9dsfz7xm6e.fsf@linux.ibm.com> <20210819072938.3839-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819072938.3839-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 03:29:38PM +0800, Hillf Danton wrote:
> On Wed, 18 Aug 2021 09:10:49 +0200 Sven Schnelle wrote:
> > Hi,
> > 
> > i'm seeing the lockdep splat below in CI. I think this is because
> 
> Thanks for reporting it.
> 
> > nbd_open is called with disk->open_mutex held, and acquires
> > nbd_index_mutex. However, nbd_put() first takes the nbd_index_lock,
> > and calls del_gendisk, which locks disk->open_mutex, so the order is
> > reversed.
> 
> Right. See diff attached.

This is already fixed in linux-next.
