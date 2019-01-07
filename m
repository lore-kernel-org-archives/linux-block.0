Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C1C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99047206B7
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 09:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAGJSF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:18:05 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:54564 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGJSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 04:18:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539648000"; 
   d="scan'208";a="84216836"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     'Dongli Zhang' <dongli.zhang@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH v4 2/2] xen/blkback: rework connect_ring() to avoid
 inconsistent xenstore 'ring-page-order' set by malicious blkfront
Thread-Topic: [PATCH v4 2/2] xen/blkback: rework connect_ring() to avoid
 inconsistent xenstore 'ring-page-order' set by malicious blkfront
Thread-Index: AQHUpkp4N6gRL6Twe0ia3bzTqyP18qWjhddQ
Date:   Mon, 7 Jan 2019 09:18:01 +0000
Message-ID: <df8d9a4f2b474d90814c32b60dd3a7d7@AMSPEX02CL03.citrite.net>
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
 <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
In-Reply-To: <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
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
> Subject: [PATCH v4 2/2] xen/blkback: rework connect_ring() to avoid
> inconsistent xenstore 'ring-page-order' set by malicious blkfront
> 
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
> Changed since v1:
>   * change the order of xenstore read in read_per_ring_refs
>   * use xenbus_read_unsigned() in connect_ring()
> 
> Changed since v2:
>   * simplify the condition check as "(err != 1 && nr_grefs > 1)"
>   * avoid setting err as -EINVAL to remove extra one line of code
> 
> Changed since v3:
>   * exit at the beginning if !nr_grefs
>   * change the if statements to avoid test (err != 1) twice
>   * initialize a 'blkif' stack variable (refer to PATCH 1/2)
> 
>  drivers/block/xen-blkback/xenbus.c | 76 +++++++++++++++++++++------------
> -----
>  1 file changed, 43 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
> blkback/xenbus.c
> index a4aadac..a2acbc9 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring
> *ring, const char *dir)
>  	int err, i, j;
>  	struct xen_blkif *blkif = ring->blkif;
>  	struct xenbus_device *dev = blkif->be->dev;
> -	unsigned int ring_page_order, nr_grefs, evtchn;
> +	unsigned int nr_grefs, evtchn;
> 
>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>  			  &evtchn);
> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring
> *ring, const char *dir)
>  		return err;
>  	}
> 
> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> -			  &ring_page_order);
> -	if (err != 1) {
> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
> &ring_ref[0]);
> +	nr_grefs = blkif->nr_ring_pages;
> +
> +	if (unlikely(!nr_grefs))
> +		return -EINVAL;
> +
> +	for (i = 0; i < nr_grefs; i++) {
> +		char ring_ref_name[RINGREF_NAME_LEN];
> +
> +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> +				   "%u", &ring_ref[i]);
> +
>  		if (err != 1) {
> -			err = -EINVAL;
> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
> -			return err;
> -		}
> -		nr_grefs = 1;
> -	} else {
> -		unsigned int i;
> -
> -		if (ring_page_order > xen_blkif_max_ring_order) {
> -			err = -EINVAL;
> -			xenbus_dev_fatal(dev, err, "%s/request %d ring page
> order exceed max:%d",
> -					 dir, ring_page_order,
> -					 xen_blkif_max_ring_order);
> -			return err;
> +			if (nr_grefs == 1)
> +				break;
> +
> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
> +					 dir, ring_ref_name);

This patch looks much better, but I guess you don't want to be using 'err' in the above call as it will still be set to whatever xenbus_scanf() returned. Probably neatest to just leave the "err = -EINVAL" and "return err" alone.

> +			return -EINVAL;
>  		}
> +	}
> 
> -		nr_grefs = 1 << ring_page_order;
> -		for (i = 0; i < nr_grefs; i++) {
> -			char ring_ref_name[RINGREF_NAME_LEN];
> -
> -			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u",
> i);
> -			err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> -					   "%u", &ring_ref[i]);
> -			if (err != 1) {
> -				err = -EINVAL;
> -				xenbus_dev_fatal(dev, err, "reading %s/%s",
> -						 dir, ring_ref_name);
> -				return err;
> -			}
> +	if (err != 1) {
> +		WARN_ON(nr_grefs != 1);
> +
> +		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
> +				   &ring_ref[0]);
> +		if (err != 1) {
> +			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);

Same here. Set err to -EINVAL above the call to xenbus_dev_fatal() and return it below...

> +			return -EINVAL;
>  		}
>  	}
> -	blkif->nr_ring_pages = nr_grefs;
> 
>  	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
>  		req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -1031,6 +1026,7 @@ static int connect_ring(struct backend_info *be)
>  	size_t xspathsize;
>  	const size_t xenstore_path_ext_size = 11; /* sufficient for "/queue-
> NNN" */
>  	unsigned int requested_num_queues = 0;
> +	unsigned int ring_page_order;
> 
>  	pr_debug("%s %s\n", __func__, dev->otherend);
> 
> @@ -1076,6 +1072,20 @@ static int connect_ring(struct backend_info *be)
>  		 blkif->nr_rings, blkif->blk_protocol, protocol,
>  		 pers_grants ? "persistent grants" : "");
> 
> +	ring_page_order = xenbus_read_unsigned(dev->otherend,
> +					       "ring-page-order", 0);
> +
> +	if (ring_page_order > xen_blkif_max_ring_order) {
> +		err = -EINVAL;
> +		xenbus_dev_fatal(dev, err,
> +				 "requested ring page order %d exceed max:%d",
> +				 ring_page_order,
> +				 xen_blkif_max_ring_order);
> +		return err;

... just like here :-)

  Paul

> +	}
> +
> +	blkif->nr_ring_pages = 1 << ring_page_order;
> +
>  	if (blkif->nr_rings == 1)
>  		return read_per_ring_refs(&blkif->rings[0], dev->otherend);
>  	else {
> --
> 2.7.4

