Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C9C4363D
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8B20708
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6+ZDP0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbgJBM5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:57:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50426 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBM5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Oct 2020 08:57:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092CeFiN068695;
        Fri, 2 Oct 2020 12:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Yz+Q6OE1DXZBCUdtHcDuHW69uia55WS2ndwEbX+ut20=;
 b=N6+ZDP0R6cAyerDaiKg41K5byE5nc4auXRnESlnhLPd2osbRrAE7QflgU+Clbl0q2N9E
 WjdEbHhSqp6IX/KxluBzL8LMYL9hrHRLfzUw7i7B9oKA4xdeFZ1ohpwlEAJ72qlwSmvh
 oBFk1mGosAaJZWF2Jep8NElDM8D+YyHxg5ytInqnkweRSfYSnqKItdvCgh2dh6arqUE4
 8jTadlvtxsT0zNDrap93w8lVKg2KpqNvjMqs0Uc2nRZkv3kKz0+H3XHIv0/jjQcrXII2
 jFaYPU+sHYhOEt0op8QEDux6s3EEq+4okEIs6uw7d0Oyv8NHqMy3MCrkn+/bpNL8jRoG cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33wupg1q61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 12:57:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092CuZbI176214;
        Fri, 2 Oct 2020 12:57:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33tfj3226b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 12:57:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 092CvCuS027221;
        Fri, 2 Oct 2020 12:57:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 05:57:11 -0700
To:     Coly Li <colyli@suse.de>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: core: don't set limits.discard_granularity as 0
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pn60g5r4.fsf@ca-mkp.ca.oracle.com>
References: <20201002013852.51968-1-colyli@suse.de>
Date:   Fri, 02 Oct 2020 08:57:09 -0400
In-Reply-To: <20201002013852.51968-1-colyli@suse.de> (Coly Li's message of
        "Fri, 2 Oct 2020 09:38:52 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020099
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Coly,

> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 6c022ef0f84d..350d0cc4ee62 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>  	q->limits.discard_granularity = card->pref_erase << 9;
>  	/* granularity must not be greater than max. discard */
>  	if (card->pref_erase > max_discard)
> -		q->limits.discard_granularity = 0;
> +		q->limits.discard_granularity = SECTOR_SIZE;
>  	if (mmc_can_secure_erase_trim(card))
>  		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }

The granularity should probably be set to the logical block size instead
of SECTOR_SIZE. However, looking at mmc_setup_queue() it doesn't appear
the logical block size is read from the CSD until after discard has been
configured. So that will require a bit of code shuffling.

-- 
Martin K. Petersen	Oracle Linux Engineering
