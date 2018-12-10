Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5287CC5CFFE
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6AA2086D
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6AA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeLJPPV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:15:21 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:59901 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeLJPPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 10:15:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,338,1539648000"; 
   d="scan'208";a="83056576"
Date:   Mon, 10 Dec 2018 16:14:47 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] xen/blkback: rework connect_ring() to avoid
 inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20181210151447.jezcmwn6lzyq5xzd@mac>
References: <1544156284-7756-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544156284-7756-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 07, 2018 at 12:18:04PM +0800, Dongli Zhang wrote:
> The xenstore 'ring-page-order' is used globally for each blkback queue and
> therefore should be read from xenstore only once. However, it is obtained
> in read_per_ring_refs() which might be called multiple times during the
> initialization of each blkback queue.
> 
> If the blkfront is malicious and the 'ring-page-order' is set in different
> value by blkfront every time before blkback reads it, this may end up at
> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> xen_blkif_disconnect() when frontend is destroyed.
> 
> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> once.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/block/xen-blkback/xenbus.c | 49 ++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4bc74e..4a8ce20 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -919,14 +919,15 @@ static void connect(struct backend_info *be)
>  /*
>   * Each ring may have multi pages, depends on "ring-page-order".
>   */
> -static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> +static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir,
> +			      bool use_ring_page_order)

Why not change the order of read_per_ring_refs so that it tries to
fetch the grant references from "ring-refXX" first and then fallback
to reading the legacy grant reference if nr_ring_pages == 1?

This will avoid having to pass an extra parameter to it.

>  {
>  	unsigned int ring_ref[XENBUS_MAX_RING_GRANTS];
>  	struct pending_req *req, *n;
>  	int err, i, j;
>  	struct xen_blkif *blkif = ring->blkif;
>  	struct xenbus_device *dev = blkif->be->dev;
> -	unsigned int ring_page_order, nr_grefs, evtchn;
> +	unsigned int nr_grefs, evtchn;
>  
>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>  			  &evtchn);
> @@ -936,28 +937,18 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  		return err;
>  	}
>  
> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> -			  &ring_page_order);
> -	if (err != 1) {
> +	nr_grefs = blkif->nr_ring_pages;
> +
> +	if (!use_ring_page_order) {
>  		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
>  		if (err != 1) {
>  			err = -EINVAL;
>  			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
>  			return err;
>  		}
> -		nr_grefs = 1;
>  	} else {
>  		unsigned int i;
>  
> -		if (ring_page_order > xen_blkif_max_ring_order) {
> -			err = -EINVAL;
> -			xenbus_dev_fatal(dev, err, "%s/request %d ring page order exceed max:%d",
> -					 dir, ring_page_order,
> -					 xen_blkif_max_ring_order);
> -			return err;
> -		}
> -
> -		nr_grefs = 1 << ring_page_order;
>  		for (i = 0; i < nr_grefs; i++) {
>  			char ring_ref_name[RINGREF_NAME_LEN];
>  
> @@ -972,7 +963,6 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  			}
>  		}
>  	}
> -	blkif->nr_ring_pages = nr_grefs;
>  
>  	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
>  		req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -1030,6 +1020,8 @@ static int connect_ring(struct backend_info *be)
>  	size_t xspathsize;
>  	const size_t xenstore_path_ext_size = 11; /* sufficient for "/queue-NNN" */
>  	unsigned int requested_num_queues = 0;
> +	bool use_ring_page_order = false;
> +	unsigned int ring_page_order;
>  
>  	pr_debug("%s %s\n", __func__, dev->otherend);
>  
> @@ -1075,8 +1067,28 @@ static int connect_ring(struct backend_info *be)
>  		 be->blkif->nr_rings, be->blkif->blk_protocol, protocol,
>  		 pers_grants ? "persistent grants" : "");
>  
> +	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> +			   &ring_page_order);

You can use xenbus_read_unsigned IMO, which will simplify the logic
below a little bit.

Thanks, Roger.
