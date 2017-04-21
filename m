Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032755AbdDUK4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 06:56:20 -0400
Date: Fri, 21 Apr 2017 03:56:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Bates <sbates@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        libc-alpha@sourceware.org
Subject: Re: Status of pwritev2/preadv2 in glibc?
Message-ID: <20170421105618.GB31499@infradead.org>
References: <ECD1C373-3464-4AEF-8E73-3130C5BFAF87@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ECD1C373-3464-4AEF-8E73-3130C5BFAF87@raithlin.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It would probably help to add the glibc list as the glibc developers
might know better..

On Sat, Apr 15, 2017 at 04:24:29PM +0000, Stephen  Bates wrote:
> Hi
> 
> Does anyone know the status of support for the pwritev2/preadv2 system calls in glibc? I am doing some more IO polling testing and realized that the support is not in 2.25 and does not seem to be staged for later release?
> 
> Right now I am using the FIO_HAVE_PWRITEV2 support that fio provides but it’d be nice to be able to write/adapt other user-space programs to test this capability…
> 
> Stephen 
> 
> 
---end quoted text---
