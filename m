Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E9C3F2D7
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657E4208C3
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 10:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="QhyhVYCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgCEK4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:56:52 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:40468 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgCEK4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 05:56:52 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 05:56:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1583405811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fiq5TS2rlNJ42Y85HoM0ccjXqRxqSGHUjMll3s1okX8=;
  b=QhyhVYCPxjIiCGz7yuSr87oij+PunddrxTnSKAgPiIXrFQxmXu5Jh+SI
   dexJ0zERx7lRe5vFUDE1761+3FJ2VycBWjjBAUFQdEL+QO2qCRp8uWyvA
   oUuLUcFe76mkP9qJHbhOIIZI6XK/EwAJ1Ji2LQvr+pu2aiDGr84CjPqGh
   U=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: iO84YcsxxS335XjMZn+9MjGhNsbK+YU+eCuQfCy4OEwl49wy+VHz976hS/9bOaohiwTjSrivnO
 x3TfegmAg/7LogMve+gRCSAg+BG0Emc27M6MVGXQAWC6bVPlhU4NnJfpNGO82JGPZW5IFLtKzx
 3jV3y7PA+z1QZuPwup0i0yZpHKHNKqkOPFAYV47AHDo8PZoQ/CZmMTQHpqMip//8P9os3BAmk+
 hIOnXJ0iVA6feNh2XdiceeL2Yf/FF9FnoC+F1X21XKfRKSZrmSIbnjsvdAGyQ+Y8Fjq8Y7vfyy
 4zo=
X-SBRS: 2.7
X-MesageID: 13795980
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,517,1574139600"; 
   d="scan'208";a="13795980"
Date:   Thu, 5 Mar 2020 11:49:35 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] xen/blkfront: fix ring info addressing
Message-ID: <20200305104935.GU24458@Air-de-Roger.citrite.net>
References: <20200305100331.16790-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200305100331.16790-1-jgross@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 05, 2020 at 11:03:31AM +0100, Juergen Gross wrote:
> Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
> actual use case") made struct blkfront_ring_info size dynamic. This is
> fine when running with only one queue, but with multiple queues the
> addressing of the single queues has to be adapted as the structs are
> allocated in an array.

Thanks, and sorry for not catching this during review.

> 
> Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/block/xen-blkfront.c | 82 ++++++++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index e2ad6bba2281..a8d4a3838e5d 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -213,6 +213,7 @@ struct blkfront_info
>  	struct blk_mq_tag_set tag_set;
>  	struct blkfront_ring_info *rinfo;
>  	unsigned int nr_rings;
> +	unsigned int rinfo_size;
>  	/* Save uncomplete reqs and bios for migration. */
>  	struct list_head requests;
>  	struct bio_list bio_list;
> @@ -259,6 +260,21 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
>  static void blkfront_gather_backend_features(struct blkfront_info *info);
>  static int negotiate_mq(struct blkfront_info *info);
>  
> +#define rinfo_ptr(rinfo, off) \
> +	(struct blkfront_ring_info *)((unsigned long)(rinfo) + (off))
                                      ^ void * would seem more natural IMO.

Also if you use void * you don't need the extra (struct
blkfront_ring_info *) cast I think?

I however think this macro is kind of weird, since it's just doing an
addition. I would rather have that calculation in get_rinfo and code
for_each_rinfo on top of that.

I agree this might be a question of taste, so I'm not going to insist
but that would reduce the number of helpers from 3 to 2.

> +
> +#define for_each_rinfo(info, rinfo, idx)				\
> +	for (rinfo = info->rinfo, idx = 0;				\
> +	     idx < info->nr_rings;					\
> +	     idx++, rinfo = rinfo_ptr(rinfo, info->rinfo_size))

I think the above is missing proper parentheses around macro
parameters.

> +
> +static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,
> +					    unsigned int i)

inline attribute might be appropriate here.

Thanks, Roger.
