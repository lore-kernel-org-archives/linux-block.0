Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF5C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 11:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF072087F
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 11:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oIP/HWXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFL6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:58:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42880 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfDFL6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 07:58:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x36Bs2Ao043143;
        Sat, 6 Apr 2019 11:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SC0JvW4UoGWj5niDNT4giRq+dqu/pZRB0R3bhevvWnw=;
 b=oIP/HWXa4lOB6Pvx6stWmVWESubR9E2JcDaTAdnkSVFD3saEztsQ7GhaT99tTy9B0ufR
 xUbj0k1rMoTlflK43EA0oMAaMsrq4H8UTEr0j6gANGk9bSKpujeFZxnFTAm1OR4fH/fS
 0wz/MDGprwjuJRmxVaRLoANOV6T5WbgZp28IqStjct+c8ib8ziTeHbrK3l5GPCcaD77k
 Io14n9snbav2dsV4sby6XTi9d4wwyxMA8ffrQxMT2Y/RFNQ6RXjyBRR61lBWgNL0/WAL
 kLi4AiY6CYNjbRSzGJtdilwt+KiV4o7N/k43TDFR2ziPoh2ireTOBjUPC1jcztMpz85W cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rpkhsgqy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Apr 2019 11:58:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x36BvKSt137782;
        Sat, 6 Apr 2019 11:58:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2rph7rdchy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Apr 2019 11:58:14 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x36BwCFt031806;
        Sat, 6 Apr 2019 11:58:13 GMT
Received: from [192.168.2.8] (/106.39.150.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 06 Apr 2019 04:58:12 -0700
Subject: Re: [PATCH] blk-mq: set plug->rq_count 0 after sort in
 blk_mq_flush_plug_list
To:     Shenghui Wang <shhuiw@foxmail.com>
References: <20190406015440.30233-1-shhuiw@foxmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <503d819e-f0de-f01b-a6f2-dcf065919d13@oracle.com>
Date:   Sat, 6 Apr 2019 19:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190406015440.30233-1-shhuiw@foxmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904060070
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904060070
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04/06/2019 09:54 AM, Shenghui Wang wrote:
> Set plug->rq_count 0 earlier can skip possible sort.
> Move the 0-value set after sort.

The same fix already exists at:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=bcc816dfe51ab86ca94663c7b225f2d6eb0fddb9

Dongli Zhang

> 
> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f3b0d33bdf88..e5d32f186e81 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1711,10 +1711,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	unsigned int depth;
>  
>  	list_splice_init(&plug->mq_list, &list);
> -	plug->rq_count = 0;
>  
>  	if (plug->rq_count > 2 && plug->multiple_queues)
>  		list_sort(NULL, &list, plug_rq_cmp);
> +	plug->rq_count = 0;
>  
>  	this_q = NULL;
>  	this_hctx = NULL;
> 
