Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D2EC54EEB
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E82C20714
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QbzsNR/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCWQyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:54:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCWQyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AMzhmgMWtZqKvKfflYcGRTOAHelA1X8S5X3Al3rNozc=; b=QbzsNR/pMqu10bCj4s0FN1i5fX
        sB1ionDc8kwhAcCr2ndQ1N3xZDrsvg8CloWAIa0qceYtVuW7t8ocqLFls4Yrh0NR6P2QId1IX54Qb
        lOhQbau20SgVrmPNYrkDG51dF9VpHc/5FswlKaLIqeXnEsXvEG7Kdgjh0/wK0F7rIgq3MeXu4wqnx
        Z3H1ffgofaq4OaBySk1ydvd9DN2sLoOMuhXWMs3c93z6ez5Q/Y+qZvJGqnK4O4tJQ5w/RmUdR2oqM
        E6okzHu7f2Abh2iAcCO/Br6l9t34UGKdnSDoJVVkctAx3BP1uu9Pe9KkppDdqt17saBg8zPoQ8k4U
        tFLU8uqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGQLU-0001kS-8g; Mon, 23 Mar 2020 16:54:36 +0000
Date:   Mon, 23 Mar 2020 09:54:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 3/4] bdi: replace bdi_dev_name() with
 bdi_get_dev_name()
Message-ID: <20200323165436.GC4982@infradead.org>
References: <20200323132254.47157-1-yuyufen@huawei.com>
 <20200323132254.47157-4-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323132254.47157-4-yuyufen@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 23, 2020 at 09:22:53PM +0800, Yufen Yu wrote:
> Since kobj->name can be freed by bdi_unregister(), we try to copy
> the name into buffer rather than return name pointer. This patch
> is prepare for following patch to fix use-after-free for bdi->dev.

Well, most of these should have a bdi reference, because if they didn't
you couldn't copy out anyway.  I think you want to audit the callsites
and see who "leaks" the pointer and only copy in those cases.  And then
preferably send one patch per broken caller.  I'm also not really sure
if we need the new helper.
