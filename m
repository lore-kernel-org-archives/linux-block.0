Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD866C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A65B208D5
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSk06hWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbgFPPvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:51:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgFPPvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 11:51:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GFlQoi096494;
        Tue, 16 Jun 2020 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=N5l4wDbmgac4f88EhtC4WEsFQL7EXPzsJ8qMW8Jz1rI=;
 b=WSk06hWgcB7AGlPiRM8Bk1AhUtInrPuc+VrA7M6BozNZThnya2z61OhKztVIGH0IlB07
 FSt/Ijp+fq7TkCMqNkxVzu3HmT2IKfuJF6hAGBQbDG3zKR4ifSsYtDT+jCn0SH83s7t0
 LTRfdJIwdC6XgojyXjb2HJN26JnqK5wJmrIcmvQHi1R7m/pm6kEKApBdPfcKWDrgAYIH
 5Lkx/gOoLRyXUU2y0wz3lotgdUVXgJEjlxvOgFnIsmIMCfEHSveIqzIk4KRyFmBGQq7W
 EyJ06gD3NdYQ+sai3XdadIZrhjP0TsVWygive9CJY6hBKvbMZZ5ocV6PPtNWWF0oyT/U 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31p6e5ymjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 15:50:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GFlVgE080301;
        Tue, 16 Jun 2020 15:48:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31p6ddd7bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 15:48:50 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05GFmnLt001574;
        Tue, 16 Jun 2020 15:48:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 08:48:48 -0700
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <aravind.ramesh@wdc.com>
Subject: Re: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mu53m2zb.fsf@ca-mkp.ca.oracle.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
        <20200615233424.13458-3-keith.busch@wdc.com>
Date:   Tue, 16 Jun 2020 11:48:46 -0400
In-Reply-To: <20200615233424.13458-3-keith.busch@wdc.com> (Keith Busch's
        message of "Tue, 16 Jun 2020 08:34:21 +0900")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 suspectscore=1 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160111
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 624aac09b005..b05832eb21b2 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -28,7 +28,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  		return -EINVAL;
>  	}
>  
> +	if (!dev->zone_capacity)
> +		dev->zone_capacity = dev->zone_size;
> +
> +	if (dev->zone_capacity > dev->zone_size) {
> +		pr_err("null_blk: zone capacity %lu more than its size %lu\n",
> +					dev->zone_capacity, dev->zone_size);
> +		return -EINVAL;
> +	}

Minor nit. I found the the error message hard to grok. Maybe something
like:

"null_blk: zone capacity (%lu MB) larger than zone size (%lu MB)\n"

Otherwise this looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
