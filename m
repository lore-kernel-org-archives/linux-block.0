Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CFEC83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EF42087E
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJGlrjHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD2LvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgD2LvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 07:51:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D06C03C1AD;
        Wed, 29 Apr 2020 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oyKgLniimkAmkE+J7+Br+5E6UcxfwNH8Z24K+8PaK5c=; b=QJGlrjHM05z9QK4nTK+XwpPppJ
        GLY2OhtPISa/RpLK6Wv9WXV/bv6Yy+0F2LXB37cmdyFZi1jYeEMpDQ+2BnZxirZIz0ngTZh/WLv9j
        vc+02DgtYeqYh3eAaQGHL9371APsQdkvpvGtwWV1QkSWF4hVTwOfiRChb3wowVBtT0HxKz0R35BCi
        Xk7wP/DGxnKi37qyAZV9t1uo/kzsPVZ15kJ3l3smn6trZJ8kBotwf/BXXtYU48cLcRmUgj7SSBKDU
        yPfAQtxpgWut6HGiAsim95APwJ91HyBiKwaNoWba2upaqUZccOXGp1uCgAYNZ4dLwIdpIpdhc1ZCO
        wWrCT5tQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTlEp-0001cW-5p; Wed, 29 Apr 2020 11:50:51 +0000
Date:   Wed, 29 Apr 2020 04:50:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429115051.GA27378@infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429114542.GJ11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 11:45:42AM +0000, Luis Chamberlain wrote:
> On Wed, Apr 29, 2020 at 04:26:37AM -0700, Christoph Hellwig wrote:
> > I can't say I'm a fan of all these long backtraces in commit logs..
> > 
> > > +static struct dentry *blk_debugfs_dir_register(const char *name)
> > > +{
> > > +	return debugfs_create_dir(name, blk_debugfs_root);
> > > +}
> > 
> > I don't think we really need this helper.
> 
> We don't export blk_debugfs_root, didn't think we'd want to, and
> since only a few scew funky drivers would use the struct gendisk
> and also support BLKTRACE, I didn't think we'd want to export it
> now.
> 
> A new block private symbol namespace alright?

Err, that function is static and has two callers.

> > This could be simplified down to:
> > 
> > 	if (bdev && bdev != bdev->bd_contains)
> > 		return bdev->bd_part->debugfs_dir;
> > 	return q->debugfs_dir;
> >
> > Given that bd_part is in __blkdev_get very near bd_contains.
> 
> Ah neat.
> 
> > Also given that this patch completely rewrites blk_trace_debugfs_dir is
> > there any point in the previous patch?
> 
> Still think it helps with making this patch easier to read, but I don't
> care, lemme know if I should just fold it.

In fact I'm not even sure we need the helper.  Modulo the comment
this just becomes a:

	if (bdev && bdev != bdev->bd_contains)
 		dir = bdev->bd_part->debugfs_dir;
	else
	 	dir = q->debugfs_dir;

in do_blk_trace_setup.
