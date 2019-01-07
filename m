Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE3C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3755C2089F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 09:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfAGJLu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:11:50 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:40516 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfAGJLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 04:11:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539648000"; 
   d="scan'208";a="84216627"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     'Dongli Zhang' <dongli.zhang@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH v4 1/2] xen/blkback: add stack variable 'blkif' in
 connect_ring()
Thread-Topic: [PATCH v4 1/2] xen/blkback: add stack variable 'blkif' in
 connect_ring()
Thread-Index: AQHUpkp5vrBK4NjhGEeMyY1dcgdul6WjhUsw
Date:   Mon, 7 Jan 2019 09:11:44 +0000
Message-ID: <1962950ce556421e9630ef561600f4f3@AMSPEX02CL03.citrite.net>
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
In-Reply-To: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Dongli Zhang [mailto:dongli.zhang@oracle.com]
> Sent: 07 January 2019 05:36
> To: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: konrad.wilk@oracle.com; Roger Pau Monne <roger.pau@citrix.com>;
> axboe@kernel.dk; Paul Durrant <Paul.Durrant@citrix.com>
> Subject: [PATCH v4 1/2] xen/blkback: add stack variable 'blkif' in
> connect_ring()
> 
> As 'be->blkif' is used for many times in connect_ring(), the stack
> variable
> 'blkif' is added to substitute 'be-blkif'.
> 
> Suggested-by: Paul Durrant <paul.durrant@citrix.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

That looks better :-)

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  drivers/block/xen-blkback/xenbus.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
> blkback/xenbus.c
> index a4bc74e..a4aadac 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -1023,6 +1023,7 @@ static int read_per_ring_refs(struct xen_blkif_ring
> *ring, const char *dir)
>  static int connect_ring(struct backend_info *be)
>  {
>  	struct xenbus_device *dev = be->dev;
> +	struct xen_blkif *blkif = be->blkif;
>  	unsigned int pers_grants;
>  	char protocol[64] = "";
>  	int err, i;
> @@ -1033,25 +1034,25 @@ static int connect_ring(struct backend_info *be)
> 
>  	pr_debug("%s %s\n", __func__, dev->otherend);
> 
> -	be->blkif->blk_protocol = BLKIF_PROTOCOL_DEFAULT;
> +	blkif->blk_protocol = BLKIF_PROTOCOL_DEFAULT;
>  	err = xenbus_scanf(XBT_NIL, dev->otherend, "protocol",
>  			   "%63s", protocol);
>  	if (err <= 0)
>  		strcpy(protocol, "unspecified, assuming default");
>  	else if (0 == strcmp(protocol, XEN_IO_PROTO_ABI_NATIVE))
> -		be->blkif->blk_protocol = BLKIF_PROTOCOL_NATIVE;
> +		blkif->blk_protocol = BLKIF_PROTOCOL_NATIVE;
>  	else if (0 == strcmp(protocol, XEN_IO_PROTO_ABI_X86_32))
> -		be->blkif->blk_protocol = BLKIF_PROTOCOL_X86_32;
> +		blkif->blk_protocol = BLKIF_PROTOCOL_X86_32;
>  	else if (0 == strcmp(protocol, XEN_IO_PROTO_ABI_X86_64))
> -		be->blkif->blk_protocol = BLKIF_PROTOCOL_X86_64;
> +		blkif->blk_protocol = BLKIF_PROTOCOL_X86_64;
>  	else {
>  		xenbus_dev_fatal(dev, err, "unknown fe protocol %s",
> protocol);
>  		return -ENOSYS;
>  	}
>  	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-
> persistent",
>  					   0);
> -	be->blkif->vbd.feature_gnt_persistent = pers_grants;
> -	be->blkif->vbd.overflow_max_grants = 0;
> +	blkif->vbd.feature_gnt_persistent = pers_grants;
> +	blkif->vbd.overflow_max_grants = 0;
> 
>  	/*
>  	 * Read the number of hardware queues from frontend.
> @@ -1067,16 +1068,16 @@ static int connect_ring(struct backend_info *be)
>  				requested_num_queues, xenblk_max_queues);
>  		return -ENOSYS;
>  	}
> -	be->blkif->nr_rings = requested_num_queues;
> -	if (xen_blkif_alloc_rings(be->blkif))
> +	blkif->nr_rings = requested_num_queues;
> +	if (xen_blkif_alloc_rings(blkif))
>  		return -ENOMEM;
> 
>  	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
> -		 be->blkif->nr_rings, be->blkif->blk_protocol, protocol,
> +		 blkif->nr_rings, blkif->blk_protocol, protocol,
>  		 pers_grants ? "persistent grants" : "");
> 
> -	if (be->blkif->nr_rings == 1)
> -		return read_per_ring_refs(&be->blkif->rings[0], dev-
> >otherend);
> +	if (blkif->nr_rings == 1)
> +		return read_per_ring_refs(&blkif->rings[0], dev->otherend);
>  	else {
>  		xspathsize = strlen(dev->otherend) + xenstore_path_ext_size;
>  		xspath = kmalloc(xspathsize, GFP_KERNEL);
> @@ -1085,10 +1086,10 @@ static int connect_ring(struct backend_info *be)
>  			return -ENOMEM;
>  		}
> 
> -		for (i = 0; i < be->blkif->nr_rings; i++) {
> +		for (i = 0; i < blkif->nr_rings; i++) {
>  			memset(xspath, 0, xspathsize);
>  			snprintf(xspath, xspathsize, "%s/queue-%u", dev-
> >otherend, i);
> -			err = read_per_ring_refs(&be->blkif->rings[i], xspath);
> +			err = read_per_ring_refs(&blkif->rings[i], xspath);
>  			if (err) {
>  				kfree(xspath);
>  				return err;
> --
> 2.7.4

