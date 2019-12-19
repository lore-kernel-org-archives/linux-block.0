Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A350CC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7661321D7D
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QgUq9dro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSI1I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:27:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55418 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfLSI1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 03:27:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ8QqGT118484;
        Thu, 19 Dec 2019 08:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=FfWf1XuNQRK4VrisC30ZLg6lfGkDRUu4LVNVjw8wVFQ=;
 b=QgUq9droixRqWByU5ezI3p2bGfJAXyuICaognT+xlUme3i9OwumsNZoUqxagL49bRGkP
 v5yhaJ4qWAjQaDpxXJs61hcXOmOW9X0Uqvxq5Ikdjj82BcjJy3nDllzhzPrMTcE1uHjR
 CgPSXQv1PopH8GkEFuBeb9pX6gll6PCwVC2k4fhhOkPpPQtvVocoDwT73dOBkpg2Evsx
 gGL0GwUXvvntkgWSutf7yIq/80p2fohlb+sF69NeJlUPWVa6gh4c6wAgMbXDM9l0AwyH
 JD0QrI3cZKLPsY3gtGm6LE80Z+LHRVTm16txYFQP+MqfSbGPfSoUXA9r3kMQKBNIQQ7v jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2x01knh87w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:27:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ8IW6i136130;
        Thu, 19 Dec 2019 08:27:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wyut50cts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:27:04 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBJ8R4DK011853;
        Thu, 19 Dec 2019 08:27:04 GMT
Received: from [10.191.9.152] (/10.191.9.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 00:27:04 -0800
Subject: Re: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     damien.lamoal@wdc.com, axboe@kernel.dk,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <66dae123-4bb3-3280-53cd-6b338f6959f1@oracle.com>
Date:   Thu, 19 Dec 2019 16:27:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/19 2:14 PM, Chaitanya Kulkarni wrote:
> This patch marks the zone-mgmt bios with REQ_SYNC flag.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---

Reviewed-by: Bob Liu <bob.liu@oracle.com>

>  block/blk-zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index d00fcfd71dfe..05741c6f618b 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -198,7 +198,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  			break;
>  		}
>  
> -		bio->bi_opf = op;
> +		bio->bi_opf = op | REQ_SYNC;
>  		bio->bi_iter.bi_sector = sector;
>  		sector += zone_sectors;
>  
> 

