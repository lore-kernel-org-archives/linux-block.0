Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B107C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21B206C1
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 08:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YVkwg8NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfHLI4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:56:25 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:54120 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfHLI4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 04:56:25 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Aug 2019 04:56:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1565600184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9ddt8p1x9c7vbOfw0mclslg4q+Z34NYzRueRbs1+UkU=;
  b=YVkwg8NI9+t+ReHutfbmazeG181+gj/lsAwsSEzC5bIejq93nrYeCNiP
   14sySFdkxsPWNsUlK5M7SYz58IVtnxbjlXb83WmFxXEIu12RaqAXuIh8P
   LC6y2kEYaxlqRcf+6bb6kYZvdDy3m1Hm2N94dqOmHndxTHLoG+AO20E8S
   8=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 2kSHKHm5HwQ9K+9+aCk8H5O3gYMiB2IUfZLmVfHUKEptE9LIH9+OD6maCgO3ZiIGmrovCFmIK5
 PPeWKiBOqhF0O/FrUB6VJ0+d8fp+b2oLRON5ZckGESvAhEYkr9vuBubfJWJkF87dciK4evAC+x
 HJPSsQxzctuHbmqJt2P99g3jzEhL0WiVbvl0+lITjxXj/DG5Bwn5DWFT09XV29Bzjpsy9EwPpn
 ME/Yn4nYCbmyAeRNxKHa6rDy3eSVyYgc/276W+IMiylV9BKrrc0qF7K3N5d44K8TW+aoF9BhZ1
 C4I=
X-SBRS: 2.7
X-MesageID: 4341947
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,376,1559534400"; 
   d="scan'208";a="4341947"
Date:   Mon, 12 Aug 2019 10:49:11 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "moderated list:XEN BLOCK SUBSYSTEM" <xen-devel@lists.xenproject.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/blkback: fix memory leaks
Message-ID: <20190812084911.25vfz6zu5omgtqqe@Air-de-Roger>
References: <1565544202-3927-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565544202-3927-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 11, 2019 at 12:23:22PM -0500, Wenwen Wang wrote:
> In read_per_ring_refs(), after 'req' and related memory regions are
> allocated, xen_blkif_map() is invoked to map the shared frame, irq, and
> etc. However, if this mapping process fails, no cleanup is performed,
> leading to memory leaks. To fix this issue, invoke the cleanup before
> returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Thanks!

> ---
>  drivers/block/xen-blkback/xenbus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index 3ac6a5d..b90dbcd 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -965,6 +965,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  		}
>  	}
>  
> +	err = -ENOMEM;
>  	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
>  		req = kzalloc(sizeof(*req), GFP_KERNEL);
>  		if (!req)
> @@ -987,7 +988,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  	err = xen_blkif_map(ring, ring_ref, nr_grefs, evtchn);

You could also move the xen_blkif_map cal before the allocation loop,
since there's nothing in xen_blkif_map that uses the memory allocated
AFAICT, but I'm fine either way.

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Roger.
