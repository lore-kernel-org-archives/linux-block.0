Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdCFVfy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2017 16:35:54 -0500
Date: Mon, 6 Mar 2017 12:18:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jens Axboe <axboe@fb.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hannes Reinecke <hare@suse.de>, <yizhan@redhat.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-Id: <20170306121840.aaa0525d3dbdeb82aad3c284@linux-foundation.org>
In-Reply-To: <96ed9003-6299-b303-a901-d040a8cfe03f@fb.com>
References: <20170306102335.9180-1-jthumshirn@suse.de>
        <96ed9003-6299-b303-a901-d040a8cfe03f@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 6 Mar 2017 08:21:11 -0700 Jens Axboe <axboe@fb.com> wrote:

> On 03/06/2017 03:23 AM, Johannes Thumshirn wrote:
> > zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> > the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> > pages attached to the bio's bvec this results in a kernel panic because of
> > array out of bounds accesses in zram_decompress_page().
> 
> Applied, thanks.

With an added cc:stable, hopefully?
