Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E31C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD8C2081A
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLmLKoJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgESPhb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgESPhb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:37:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60289C08C5C0;
        Tue, 19 May 2020 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6xgTObkLhE+yJInjtnnn6HwlNCqVGeDL4BjvcKIYvZE=; b=TLmLKoJb6jq2HLOx5oAajDP2K+
        8mel6/LpLiE/q57PrNwkTft1dEmthHiT/iILTuIZguzJmM597hhDdDrfSfNSRy6sXrPCjzJr389Xp
        lUbZGuJvFQ16X9+RVlohxSMywkEQVIqbmaMkJCt48dnXJ1Di9Wg2duy2ZLl2EbWOluxINnW61ZoCI
        KHXH3Gg1j4eztu4lTADqb40N8Pt6/FYgw57tuvMJFsb5QNgT8iak+OrU3AeHwUj788V30pxjPiZGg
        HKwewgmdEhBusHmwMqvjV9FMaeD1cuW0Y7tbVHntpbqrewpuHa55f7SNHNenkT1J+2AU24JECFNGe
        pcpiT8zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb4Iu-0000e1-M9; Tue, 19 May 2020 15:37:16 +0000
Date:   Tue, 19 May 2020 08:37:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200519153716.GC21875@infradead.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516031956.2605-7-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 03:19:55AM +0000, Luis Chamberlain wrote:
> We use one blktrace per request_queue, that means one per the entire
> disk.  So we cannot run one blktrace on say /dev/vda and then /dev/vda1,
> or just two calls on /dev/vda.
> 
> We check for concurrent setup only at the very end of the blktrace setup though.

Too long line in the changelog.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
