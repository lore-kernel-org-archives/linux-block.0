Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42563 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdERGhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2017 02:37:05 -0400
Date: Wed, 17 May 2017 23:37:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Richard Narron <comet.berkeley@gmail.com>
Cc: linux-block@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>
Subject: Re: [Patch 1/1] partitions/msdos: FreeBSD UFS2 file systems are not
 recognized
Message-ID: <20170518063703.GA27178@infradead.org>
References: <alpine.LNX.2.21.1705171824100.2450@joy.test>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.21.1705171824100.2450@joy.test>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks Richard,

this looks good to me.

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Wed, May 17, 2017 at 06:28:53PM -0700, Richard Narron wrote:
> The code in block/partitions/msdos.c recognizes FreeBSD, OpenBSD
> and NetBSD partitions and does a reasonable job picking out OpenBSD
> and NetBSD UFS subpartitions.
> 
> But for FreeBSD the subpartitions are always "bad".
> 
>     Kernel: <bsd:bad subpartition - ignored
> 
> Though all 3 of these BSD systems use UFS as a file system, only
> FreeBSD uses relative start addresses in the subpartition
> declarations.
> 
> The following patch fixes this for FreeBSD partitions and leaves
> the code for OpenBSD and NetBSD intact:
> 
> Signed-off-by: Richard Narron <comet.berkeley@gmail.com>
> ---
>  block/partitions/msdos.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/block/partitions/msdos.c  2015-12-27 18:17:37.000000000 -0800
> +++ b/block/partitions/msdos.c  2015-12-29 10:44:25.813773357 -0800
> @@ -300,6 +300,8 @@ static void parse_bsd(struct parsed_part
>                         continue;
>                 bsd_start = le32_to_cpu(p->p_offset);
>                 bsd_size = le32_to_cpu(p->p_size);
> +               if (memcmp(flavour, "bsd\0", 4) == 0)
> +                       bsd_start = bsd_start + offset;

this could be +=, but I don't think it really matters.
