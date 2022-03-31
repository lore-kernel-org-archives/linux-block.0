Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76579C433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 09:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiCaJRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiCaJRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 05:17:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901B10781A
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NmduW1iwmBwQuxt8u8E9I4xdRNInpTYlPZnwFbf13L8=; b=0YqOVjVHUA/pWE6flu0hEhJgNR
        c6NDxH/8dHAlQvnDfD5MqguDJ77zoOmYDT4CfEhozthfCGQpaZLtPvel4WkmsELC0NrJFRIFvecrX
        8n4oO0g7MBMmv3k2/n8e1TdRMvtG16J6b5kGsEzWwptmYmHYSOA9RN+yj/d03gfnZIRq+KKfKd0Z/
        DTdLRWwksfvKyrQoO1qFWfhJWls/XOUkZnd02XvDqZDn9wbZF4/9KYcCkfSmqNMKf5NE+YtSxfHX3
        GfNQPmnbljnHlxSF/9s3I90RgnHsS+iUxGVXHNUaUFfYU9mROhgy2GcalIhDOZoRQgLIish2tNuF1
        Gbd6loEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZqto-001ROG-Gh; Thu, 31 Mar 2022 09:15:24 +0000
Date:   Thu, 31 Mar 2022 02:15:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@kernel.org>, tj@kernel.org,
        axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YkVxLN9p0t6DI5ie@infradead.org>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkVBjUy9GeSMbh5Q@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 10:52:13PM -0700, Dennis Zhou wrote:
> I took a quick look. It seems with the new interface,
> bio_clone_blkg_association() is unnecessary given the correct
> association should be derived from the bio_alloc*() calls with the
> passed in bdev. Also, blkcg_bio_issue_init() in clone seems wrong.

Yes, I think you are right.

> Maybe the right thing to do here for md-linear and btrfs (what I've
> looked at) is to delay cloning until the map occurs and the right device
> is already in hand?

That would in general be the preferred option where possible.
