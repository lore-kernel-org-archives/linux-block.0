Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdJFL7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 07:59:30 -0400
Date: Fri, 6 Oct 2017 04:59:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: Christoph Hellwig <hch@infradead.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
Subject: Re: Why removing REQ_FAILFAST_DRIVER in LightNVM?
Message-ID: <20171006115927.GA12530@infradead.org>
References: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 06, 2017 at 11:19:09AM +0200, Javier Gonz�lez wrote:
> on the lightnvm I/O path and that has propagated through the code as we
> added more functionality. Can you explain why this is necessary? If I
> can just remove it, it is much easier to do the cleanup.
> 
> I have tested on or HW and all works fine without it.

nvme_alloc_request always sets REQ_FAILFAST_DRIVER and that srops
it to stick to the previous behavior.

If you actually want all your lightnvm requests to fail fast you can
remove it.
