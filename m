Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94909C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F0B20665
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQzfz6Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfAHIWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:22:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53234 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfAHIWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 03:22:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x088Iq8v074290;
        Tue, 8 Jan 2019 08:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bukR5O++t4PtDOG8l2y85xS76OnoCjkQVLylX5e+pp4=;
 b=lQzfz6Zknp6XNwuE5WW3CWmmB/uegrqUjFEAeTqpIhw9g+0pU6zzkZWPTt+R+11pGyt7
 ADzAVZXr8CGM/7GXF4ltsGmikoDcY+h5ycrp4I9KiEbHfBYebm3JEbjY4iaCkOZbamEV
 iSMdp/vDjY2blZrCWf7EcEVRpoRttG2ZMZHGKiqwijo6sy6RRjsYuKJZlvS53Hf+enEN
 YapYDlMtvX7/zKNdzZT4wv+JF/xaGrQ2ERt+6XzTbYs/wnlohXTMJlEujVV4ZfxBY+CV
 2Agxrdxg0E8n0s0E5HnAiz2MSaFNQbDBTtaS83/BD21G8O7g6BvYQyEwo+k33tSxYk42 yQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3dt6kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 08:22:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x088MAIW003863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 08:22:10 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x088M9v2001885;
        Tue, 8 Jan 2019 08:22:10 GMT
Received: from [10.182.71.41] (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 00:22:09 -0800
Subject: Re: [Xen-devel] [PATCH v5 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, roger.pau@citrix.com, paul.durrant@citrix.com,
        konrad.wilk@oracle.com
References: <1546935350-20957-1-git-send-email-dongli.zhang@oracle.com>
 <1546935350-20957-2-git-send-email-dongli.zhang@oracle.com>
Message-ID: <5c3760a1-4f45-a67b-3b70-80fa68ee4358@oracle.com>
Date:   Tue, 8 Jan 2019 16:24:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546935350-20957-2-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080069
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

oops. Please ignore this v5 patch.

I just realized Linus suggested in an old email not use BUG()/BUG_ON() in the code.

I will switch to the WARN() solution and resend again.

Sorry for the junk email.

Dongli Zhang

On 2019/1/8 下午4:15, Dongli Zhang wrote:
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
> Changed since v4:
>   * use BUG_ON() when (nr_grefs == 0) to reminder the developer
>   * set err = -EINVAL before xenbus_dev_fatal()
> 
>  drivers/block/xen-blkback/xenbus.c | 69 ++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4aadac..f6146cd 100644
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
> @@ -936,43 +936,39 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>  		return err;
>  	}
>  
> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> -			  &ring_page_order);
> -	if (err != 1) {
> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
> +	nr_grefs = blkif->nr_ring_pages;
> +
> +	BUG_ON(!nr_grefs);
> +
> +	for (i = 0; i < nr_grefs; i++) {
> +		char ring_ref_name[RINGREF_NAME_LEN];
> +
> +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> +				   "%u", &ring_ref[i]);
> +
>  		if (err != 1) {
> +			if (nr_grefs == 1)
> +				break;
> +
>  			err = -EINVAL;
> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
> +					 dir, ring_ref_name);
>  			return err;
>  		}
> -		nr_grefs = 1;
> -	} else {
> -		unsigned int i;
> +	}
>  
> -		if (ring_page_order > xen_blkif_max_ring_order) {
> +	if (err != 1) {
> +		WARN_ON(nr_grefs != 1);
> +
> +		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
> +				   &ring_ref[0]);
> +		if (err != 1) {
>  			err = -EINVAL;
> -			xenbus_dev_fatal(dev, err, "%s/request %d ring page order exceed max:%d",
> -					 dir, ring_page_order,
> -					 xen_blkif_max_ring_order);
> +			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
>  			return err;
>  		}
> -
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
> -		}
>  	}
> -	blkif->nr_ring_pages = nr_grefs;
>  
>  	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
>  		req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -1031,6 +1027,7 @@ static int connect_ring(struct backend_info *be)
>  	size_t xspathsize;
>  	const size_t xenstore_path_ext_size = 11; /* sufficient for "/queue-NNN" */
>  	unsigned int requested_num_queues = 0;
> +	unsigned int ring_page_order;
>  
>  	pr_debug("%s %s\n", __func__, dev->otherend);
>  
> @@ -1076,6 +1073,20 @@ static int connect_ring(struct backend_info *be)
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
> +	}
> +
> +	blkif->nr_ring_pages = 1 << ring_page_order;
> +
>  	if (blkif->nr_rings == 1)
>  		return read_per_ring_refs(&blkif->rings[0], dev->otherend);
>  	else {
> 
