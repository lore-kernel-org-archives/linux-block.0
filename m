Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C139DC4727D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5799C20791
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WqZWfU25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIWQeZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:34:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgIWQeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 12:34:25 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NGW4Z7064492;
        Wed, 23 Sep 2020 12:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=T2hK+A1Fazqs6wl5OECDrIIGlGFLIAuIJI+HUwFSPas=;
 b=WqZWfU25NkjRHHxuu/TGK2eXtBV46E5uWdPQWctA1qwZRDfS1nvazJzH3KV8bF3mclMa
 HioL3corBLHQ+lATuxIHgkhFhWU38ujQjsEwC7z6hu+G/SOj6tYmdNPPmbu27j+Uz2BC
 DFZigD7JWVRoVwcdS6YA8zrPmHE5+3yW9N5vNtaKerTxboIJCvGbFYJExQd2026KxCk+
 Ar4BMdUtSdQsnUZWnkSfcF6jR3wfSneUCafbwfXpwUdfZZMzfBS3uV+yz5gVsIlE5OjE
 bfSVDGHrUieEoxYx/H6h+MHhIc7wJRhjMLY986ss8uhAo1tExgGrV88E49TbtvKfTGXg cg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33r97ssevy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 12:34:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08NGQrPe032397;
        Wed, 23 Sep 2020 16:34:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 33payub3s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 16:34:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08NGWbTD33030556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 16:32:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A246542045;
        Wed, 23 Sep 2020 16:34:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 636B842047;
        Wed, 23 Sep 2020 16:34:12 +0000 (GMT)
Received: from marcibm (unknown [9.145.64.218])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 16:34:12 +0000 (GMT)
From:   Marc Hartmayer <mhartmay@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     mhartmay@linux.ibm.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix bmd->is_null_mapped initialization
In-Reply-To: <20200923150713.416286-1-hch@lst.de>
References: <20200923150713.416286-1-hch@lst.de>
Date:   Wed, 23 Sep 2020 18:34:11 +0200
Message-ID: <87r1qs8nb0.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_12:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230126
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 23, 2020 at 05:07 PM +0200, Christoph Hellwig <hch@lst.de> wrote:
> bmd is allocated using kmalloc in bio_alloc_map_data, so make sure
> is_null_mapped is properly initialized to false for the !null_mapped
> case.
>
> Fixes: f3256075ba49 ("block: remove the BIO_NULL_MAPPED flag")
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-map.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/block/blk-map.c b/block/blk-map.c
> index be118926ccf4e3..21630dccac628c 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -148,6 +148,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
>  	 * shortlived one.
>  	 */
>  	bmd->is_our_pages = !map_data;
> +	bmd->is_null_mapped = (map_data && map_data->null_mapped);
>  
>  	nr_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
>  	if (nr_pages > BIO_MAX_PAGES)
> @@ -218,8 +219,6 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
>  	}
>  
>  	bio->bi_private = bmd;
> -	if (map_data && map_data->null_mapped)
> -		bmd->is_null_mapped = true;
>  
>  	bounce_bio = bio;
>  	ret = blk_rq_append_bio(rq, &bounce_bio);
> -- 
> 2.28.0

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
