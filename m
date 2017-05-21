Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34175 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdEUHEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2017 03:04:33 -0400
Date: Sun, 21 May 2017 00:04:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel-team <kernel-team@lge.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, jlayton@redhat.com,
        tytso@mit.edu
Subject: Re: [PATCH 2/2] zram: do not count duplicated pages as compressed
Message-ID: <20170521070427.GB10453@infradead.org>
References: <20170516073616.GB767@jagdpanzerIV.localdomain>
 <20170517083212.GA25750@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517083212.GA25750@bbox>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 17, 2017 at 05:32:12PM +0900, Minchan Kim wrote:
> Is block device(esp, zram which is compressed ram block device) okay to
> return garbage when ongoing overwrite IO fails?
> 
> O_DIRECT write 4 block "aaa.." -> success
> read  4 block "aaa.." -> success
> O_DIRECT write 4 block "bbb.." -> fail
> read  4 block "000..' -> it is okay?
> 
> Hope to get an answer form experts. :)

It's "okay" as it's what existing real block devices do (at least on a
sector boundary).  It's not "nice" though, so if you can avoid it,
please do.
