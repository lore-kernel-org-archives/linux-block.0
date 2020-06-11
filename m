Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168CDC433E1
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 05:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D172075F
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 05:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFKFkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:40:51 -0400
Received: from verein.lst.de ([213.95.11.211]:49298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgFKFkv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 01:40:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9715068B05; Thu, 11 Jun 2020 07:40:48 +0200 (CEST)
Date:   Thu, 11 Jun 2020 07:40:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs/fs-writeback.c: don't WARN on unregistered BDI
Message-ID: <20200611054048.GA3518@lst.de>
References: <20200611024417.462479-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611024417.462479-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 10:44:17AM +0800, Ming Lei wrote:
> BDI is unregistered from del_gendisk() which is usually done in device's
> release handler from device hotplug or error handling context, so BDI
> can be unregistered anytime.

True.

> It should be normal for __mark_inode_dirty to see un-registered BDI,
> so replace the WARN() with pr_debug() just for debug purpose.

I'd kill it entirely while we're at it..
