Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbiDOSCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbiDOSCL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 14:02:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1FF457B9
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IL/YFRXP4EfIheg9ThTlHkA3sXF1nKN+0GTzx2wXjkk=; b=fxieV7OqvYbct8hT5Ql4D3eGiQ
        UFVXgBesfBJWLXuSu8cR7gDMABpRlTFum9TYrplbFExNWI0P+AMB/LJJFy5aGsCbXCooYqWYRh9Kd
        F6EnGnyfQzaGepv428v4s+RyLzdBReUFCoQyP2DPe+y317JHOk+0sWXkgtDzkFCZGhP6K5mRIBpTD
        zkW9EkWkDngxKMUFGRQuGpE3LePraSrcLb7hOMDHt3TgzP8C/evv7mrCEexDGCmsrVsX9PKKkP+IN
        +V0NwGDZv3TZHjDt0FTm8NxjKSNw9UYV78U9ikEgR4Ypf57P2kAMwopdQxcn9BPkgk1aIAtNcgwQP
        qOj51XVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfQEL-00B2ef-Sd; Fri, 15 Apr 2022 17:59:37 +0000
Date:   Fri, 15 Apr 2022 10:59:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 15, 2022 at 05:58:16AM +0000, Chaitanya Kulkarni wrote:
> On 4/14/22 22:20, Christoph Hellwig wrote:
> > On Wed, Apr 13, 2022 at 03:46:16PM -0700, Bart Van Assche wrote:
> >> I'm not sure whether the nvme-mp tests test any code that is not yet tested by
> >> any nvme or srp test. How about removing these tests since these tests make
> >> it harder than necessary to run blktests?
> > 
> > I haven't looked at the details recently, but if these tests still are
> > basically a copy and paste of the srp mpath tests I'm all for removing
> > them!
> 
> If it doesn't add a new test coverage in the blktest framework
> then please remove.

That's about 3 block folks not being sure whether or not it helps. And
the complexities of it, to test it, requiring a different kernel seems
just stupid. So I'm going to drop the tests from kdevops and not bother
with them.

With regards to srp tests there seems to be two modules to use. Do we
want to prioritize both just as much? If so then I'll just create two
guests for srp tests.

  Luis
