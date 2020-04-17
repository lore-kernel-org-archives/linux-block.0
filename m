Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C0C38A2B
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FCD2087E
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 13:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgDQNBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:01:46 -0400
Received: from verein.lst.de ([213.95.11.211]:57536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbgDQNBq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 09:01:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E27068D37; Fri, 17 Apr 2020 15:01:37 +0200 (CEST)
Date:   Fri, 17 Apr 2020 15:01:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200417130135.GB5053@lst.de>
References: <20200416165453.1080463-1-hch@lst.de> <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417085909.GA12234@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 17, 2020 at 10:59:09AM +0200, Jan Kara wrote:
> > -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
> > +	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
> > +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
> >  	if (IS_ERR(dev))
> >  		return PTR_ERR(dev);
> >  
> 
> This can have a sideeffect not only bdi->dev_name will be truncated to 64
> chars (which generally doesn't matter) but possibly also kobject name will
> be truncated in the same way.  Which may have user visible effects. E.g.
> for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
> other way around - i.e., let device_create_vargs() create the device name
> and then copy to bdi->dev_name whatever fits?

I think having them mismatch is worse, as the kobject name is what
people look for.  Hans, do you know what fc->source typicall contains
and if there is much of a problem if it gets truncated/  Can we switch
to something else that is guranteed to be 64 charaters or less for the
bdi name?
