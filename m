Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3231BC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0BF208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0BF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeLFTP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:15:29 -0500
Received: from verein.lst.de ([213.95.11.211]:59032 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFTP3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 14:15:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 80BF568AA6; Thu,  6 Dec 2018 20:15:27 +0100 (CET)
Date:   Thu, 6 Dec 2018 20:15:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 03/26] block: wire up block device iopoll method
Message-ID: <20181206191527.GA30806@lst.de>
References: <20181204233729.26776-1-axboe@kernel.dk> <20181204233729.26776-4-axboe@kernel.dk> <x49a7lih3n4.fsf@segfault.boston.devel.redhat.com> <72b6acc7-5017-a72c-3fb0-90e5ad95ebb7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b6acc7-5017-a72c-3fb0-90e5ad95ebb7@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 12:14:29PM -0700, Jens Axboe wrote:
> On 12/6/18 12:11 PM, Jeff Moyer wrote:
> > Jens Axboe <axboe@kernel.dk> writes:
> > 
> >> From: Christoph Hellwig <hch@lst.de>
> >>
> >> Just call blk_poll on the iocb cookie, we can derive the block device
> >> from the inode trivially.
> > 
> > Does this work for multi-device file systems?
> 
> It should, that's the whole purpose of having fops->iopoll. You should
> be able to derive it from inode + cookie.

It still assumes the whole I/O will got to a single device.  For
XFS this is always tree, but for btrfs this might mean I/O could
need splitting if ->iopoll was to be supported there.
