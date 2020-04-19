Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C4C2BA2B
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 07:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4F021974
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 07:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDSH6N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 03:58:13 -0400
Received: from verein.lst.de ([213.95.11.211]:35672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSH6N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 03:58:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5BA3768BEB; Sun, 19 Apr 2020 09:58:09 +0200 (CEST)
Date:   Sun, 19 Apr 2020 09:58:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200419075809.GA12222@lst.de>
References: <20200416165453.1080463-1-hch@lst.de> <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz> <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 08:40:20AM -0700, Bart Van Assche wrote:
> > This can have a sideeffect not only bdi->dev_name will be truncated to 64
> > chars (which generally doesn't matter) but possibly also kobject name will
> > be truncated in the same way.  Which may have user visible effects. E.g.
> > for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
> > other way around - i.e., let device_create_vargs() create the device name
> > and then copy to bdi->dev_name whatever fits?
> 
> How about using kvasprintf() instead of vsnprintf()?

That is what v1 did, see the thread in response to that on why it isn't
a good idea.
