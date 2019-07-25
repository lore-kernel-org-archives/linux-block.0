Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F5C76190
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C791229F3
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fce7whCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGYR6g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:58:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGYR6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 13:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XQ6rI4d7gxBNj6SNlmzuGaSaA8CuaLNKV7YKP78h+Cc=; b=Fce7whCGz/V/DBAMhW7HcJDlK
        hsk1SqJTkIq8akKJSz8MfOzYVgM62isRP3FAAyJ8ha68W6y08DNv4jdLNi14uNUgu2qLXe/0XLzO1
        wTiABPnQYx/qD4NyVm0SnpQYdPhRj2Zhg+5m0JhHFr1U36CMI6AB0yTT1tlD2/ZAazHFfobvyoQUU
        +0dAMO8k5Q+PqJTwUiJILur+fLkMJp5XZbWNfqEW0Kvo/EgBuYuhv2PiDLLv0uylGsTozlXrN5SXN
        OWleTSJSPsOFaaptcq92Wti/80HwUuUrV5vxt8qXqsu0JBPnGBHZNY4Qv3V/u7Xt4hMiDt0elbHEr
        6ZBjuBohw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqi0g-0004X8-K9; Thu, 25 Jul 2019 17:58:34 +0000
Date:   Thu, 25 Jul 2019 10:58:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725175834.GB30641@bombadil.infradead.org>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 25, 2019 at 11:53:20AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> > On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
> >> cdev_get_by_path() attempts to retrieve a struct cdev from
> >> a path name. It is analagous to blkdev_get_by_path().
> >>
> >> This will be necessary to create a nvme_ctrl_get_by_path()to
> >> support NVMe-OF passthru.
> > 
> > Ick, why?  Why would a cdev have a "pathname"?
> 
> So we can go from "/dev/nvme0" (which points to a char device) to its
> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
> allows supporting symlinks that might be created by udev rules.

But you're not really trying to go from a string to a chardev.  You're
trying to go from a nvmet_subsys to a chardev.  Isn't there a better
way to link the two somewhere else?

(I must confess that once I would have known the answer to this, but
the NVMe subsystem has grown ridiculously complex and I can no longer
fit it in my head)
