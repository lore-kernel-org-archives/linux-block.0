Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40633 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdJFMGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 08:06:10 -0400
Date: Fri, 6 Oct 2017 05:06:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: Christoph Hellwig <hch@infradead.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
Subject: Re: Why removing REQ_FAILFAST_DRIVER in LightNVM?
Message-ID: <20171006120609.GA27720@infradead.org>
References: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
 <20171006115927.GA12530@infradead.org>
 <6D7E3697-713C-4FBD-86EA-20AB1DC72742@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6D7E3697-713C-4FBD-86EA-20AB1DC72742@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 06, 2017 at 02:01:46PM +0200, Javier Gonz�lez wrote:
> I think it is good to fail fast as any other nvme I/O command and then
> recover in pblk if necessary.

Note that we only do it for other nvme _passthrough_ commands - the
actual I/O commands dot not get the failfast flag.
