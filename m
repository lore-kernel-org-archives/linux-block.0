Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D1C3F2CD
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC8520848
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 12:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BRR/oVK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCEMnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:43:16 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:37547 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEMnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 07:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1583412195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wATOkHyHfw1nttogMmLbBkJtCs3d5j9hHSTAkJY4KmE=;
  b=BRR/oVK+Ltl2W4wq7qyebZWggBTMUx92tLo6DwpaRDe8a7dpSZmP6xwN
   VRdv6L+m8+7o+qt7yhzQ7hVkyD/QVDtsDWpVhVvh+8qBe3Ew9RNBkckrX
   eYGhfpaBePvoVJP+JcgX+b9D+FBlYyjqVruA/aM1oNmK9spWAjv8JTfbl
   c=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: iR1cwtc6wIxZHy2095D3SobXiBpJi1pHjnR4cTvwIX4HwAo3C1DNnED/QdKE4qoxNmS2nAl6jV
 dbJIfWoZdXEkP183BBYzQ6TbB8GAIJFJsQHT5i05dmAWRfPp9TMq78jYy6zAhB5tY8PZ+Q7C35
 eA/Mk5kAW7Vl1HUChfFa3m08+pqPatmh5F6H00J2FJ3RrXlA6MT4yoduIrrON+HcCXhgi/Wx1X
 VozdPrV+m5W8VHG95mKIH53r6u455YK/zwGOBAEcLqVjoFxNkKJ+9EpJ1DfbZb+f6uwBMlnkjs
 NjI=
X-SBRS: 2.7
X-MesageID: 13885325
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,518,1574139600"; 
   d="scan'208";a="13885325"
Date:   Thu, 5 Mar 2020 13:42:55 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] xen/blkfront: fix ring info addressing
Message-ID: <20200305124255.GW24458@Air-de-Roger.citrite.net>
References: <20200305114044.20235-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305114044.20235-1-jgross@suse.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 05, 2020 at 12:40:44PM +0100, Juergen Gross wrote:
> Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
> actual use case") made struct blkfront_ring_info size dynamic. This is
> fine when running with only one queue, but with multiple queues the
> addressing of the single queues has to be adapted as the structs are
> allocated in an array.
> 
> Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - get rid of rinfo_ptr() helper
> - use proper parenthesis in for_each_rinfo()
> - rename rinfo parameter of for_each_rinfo()
> ---
>  drivers/block/xen-blkfront.c | 79 +++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index e2ad6bba2281..8e844da826db 100644
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
> @@ -259,6 +260,18 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
>  static void blkfront_gather_backend_features(struct blkfront_info *info);
>  static int negotiate_mq(struct blkfront_info *info);
>  
> +#define for_each_rinfo(info, ptr, idx)				\
> +	for ((ptr) = (info)->rinfo, (idx) = 0;			\
> +	     (idx) < (info)->nr_rings;				\
> +	     (idx)++, (ptr) = (void *)(ptr) + (info)->rinfo_size)
> +
> +static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,

I still think inline should be added here, but I don't have such a
strong opinion to block the patch on it.

Also, info should be constified AFAICT.

With at least info constified:

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Can you queue this through the Xen tree?

Thanks, Roger.
