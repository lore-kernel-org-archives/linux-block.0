Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F2C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 12:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE120665
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 12:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfAGMHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:07:47 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:64211 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGMHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 07:07:47 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539648000"; 
   d="scan'208";a="84222505"
Date:   Mon, 7 Jan 2019 13:01:07 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>, <Paul.Durrant@citrix.com>
Subject: Re: [PATCH v4 2/2] xen/blkback: rework connect_ring() to avoid
 inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20190107120107.euf7mrq7gk6bmibz@mac>
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
 <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 07, 2019 at 01:35:59PM +0800, Dongli Zhang wrote:
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
>  drivers/block/xen-blkback/xenbus.c | 76 +++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4aadac..a2acbc9 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  	int err, i, j;
>  	struct xen_blkif *blkif = ring->blkif;
>  	struct xenbus_device *dev = blkif->be->dev;
> -	unsigned int ring_page_order, nr_grefs, evtchn;
> +	unsigned int nr_grefs, evtchn;
>  
>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>  			  &evtchn);
> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  		return err;
>  	}
>  
> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> -			  &ring_page_order);
> -	if (err != 1) {
> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
> +	nr_grefs = blkif->nr_ring_pages;
> +
> +	if (unlikely(!nr_grefs))
> +		return -EINVAL;

Is this even possible? AFAICT read_per_ring_refs will always be called
with blkif->nr_ring_pages != 0?

If so, I would consider turning this into a BUG_ON/WARN_ON.

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
> -			xenbus_dev_fatal(dev, err, "%s/request %d ring page order exceed max:%d",
> -					 dir, ring_page_order,
> -					 xen_blkif_max_ring_order);
> -			return err;
> +			if (nr_grefs == 1)
> +				break;
> +

You need to either set err to EINVAL before calling xenbus_dev_fatal,
or call xenbus_dev_fatal with EINVAL as the second parameter.

> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
> +					 dir, ring_ref_name);
> +			return -EINVAL;
>  		}
> +	}
>  
> -		nr_grefs = 1 << ring_page_order;
> -		for (i = 0; i < nr_grefs; i++) {
> -			char ring_ref_name[RINGREF_NAME_LEN];
> -
> -			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
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

Second parameter should be EINVAL, or err should be set to EINVAL
before calling xenbus_dev_fatal.

Thanks, Roger.
