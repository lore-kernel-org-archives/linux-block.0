Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB8C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E21720882
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PC/PqDNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbgFPP7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:59:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731485AbgFPP7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 11:59:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GFpOlF114954;
        Tue, 16 Jun 2020 15:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=GAmgeSG8/BtZuwbDR2PlP3ksAuRRmqymC2N1cO2MVn8=;
 b=PC/PqDNoCmpY/GhYBuwjnPAXyzPdsvP8Sgd4X2a5jUZ33zz/qH4yARx+tVP7QnkEGK39
 8YjFrnEx34d+WvkdlJ4vw7O5U189HI8D2c4kB38BS+K4F8zSCi5IEaBbicDVo9NhfTXN
 kK7hq4uur3hafIkwv5rCqMa1aVsLhbWv45W6F2GpXvugmMYu637SANCkLzz5IiBQexRO
 MlRe4AprZVeKQQNf2ZrfXJhy9n0xUj3UzflggWFBDys0O5iqHbQoKl8wv5monOzzrL9p
 +PSco9smmsFbFWfbXy/iWt8c/juKqK3uSZs/yP6Vf/GsH3VsoV4FEQNA7r99yFG+hGuZ /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31p6e5yp6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 15:59:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GFr4PH019972;
        Tue, 16 Jun 2020 15:59:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31p6dh00pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 15:59:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05GFx1AT030995;
        Tue, 16 Jun 2020 15:59:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 08:59:01 -0700
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
        <20200615233424.13458-4-keith.busch@wdc.com>
Date:   Tue, 16 Jun 2020 11:58:59 -0400
In-Reply-To: <20200615233424.13458-4-keith.busch@wdc.com> (Keith Busch's
        message of "Tue, 16 Jun 2020 08:34:22 +0900")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 suspectscore=1 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> @@ -1113,8 +1126,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>  	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
>  				      NVME_IDENTIFY_DATA_SIZE);
>  	if (status) {
> -		dev_warn(ctrl->device,
> -			"Identify Descriptors failed (%d)\n", status);
> +		if (ctrl->vs >= NVME_VS(1, 3, 0))
> +			dev_warn(ctrl->device,
> +				"Identify Descriptors failed (%d)\n", status);

Not a biggie but maybe this should be a separate patch?

> @@ -1808,7 +1828,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
>  {
>  	return uuid_equal(&a->uuid, &b->uuid) &&
>  		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
> -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0;
> +		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
> +		a->csi == b->csi;
>  }

No objection to defensive programming. But wouldn't this be a broken
device?

Otherwise LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
