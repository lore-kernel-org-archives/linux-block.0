Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41900 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbeCOP7H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:59:07 -0400
Date: Thu, 15 Mar 2018 16:59:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 16/16] bcache: Fix endianness annotations
Message-ID: <20180315155906.GB20994@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com> <20180315150814.9412-17-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315150814.9412-17-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 15, 2018 at 08:08:14AM -0700, Bart Van Assche wrote:
> This patch avoids that sparse complains about using integer types
> incorrectly (u32, __le32, __be32, ...) by splitting struct cache_sb
> into two different structures:
> - struct cache_sb in which all integer members except csum have
>   CPU endianness.
> - struct cache_sb_le in which all integer members except csum are
>   declared as little endian.

Can you call this cache_sb_disk to name it after the purpose instead
of the implementation?

Except for that this looks like the right fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>
