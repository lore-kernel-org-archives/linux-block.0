Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F0C7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CEB2199C
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUgjbkKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfGVXvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:51:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37666 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbfGVXvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 19:51:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNikq2011913;
        Mon, 22 Jul 2019 23:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ovE6K7lxivhCfH9LRjGsrr23JzVy9SPekmo6Fjy51g8=;
 b=cUgjbkKyVdRpvx2tHG2zrFgR+9AW8gnBau68E1hJds8h8ymnYlgHsks+r/9kWjEdf6jt
 U3NWEI8fYjqOgCmOkf6kFWNoFjVw4zw9SFq1JUu/Va2fuGdJF5qTrOsUUPzwxX0OJo6Q
 MuakUM9yQqEDLHhw3MAtBXajfcxRPuUNOcsBQZRA0wM1MC9IX2SeznwmmdDaRQdSy8ke
 4l69y3As1t+2EjR54fFT0nnLMvy2THQYOeVckczkSdf8Ek5dFwEsgknrTE1VSt2efOOM
 JHNivp76NIpmx9cY9AFLOeh9PDwU05B9m/FIHphrz/I1gEZOHmhkcY6jR95ejCobIwsu nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tutwpafs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:51:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNhEEQ124720;
        Mon, 22 Jul 2019 23:51:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tut9mma0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:51:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MNpi1t011900;
        Mon, 22 Jul 2019 23:51:44 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 16:51:44 -0700
Subject: Re: [PATCH 1/4] block: elevator.c: Remove now unused elevator=
 argument
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
 <20190714053453.1655-2-marcos.souza.org@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <e428794d-f02d-d47a-4e2a-12c99028cb7d@oracle.com>
Date:   Tue, 23 Jul 2019 07:51:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190714053453.1655-2-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220251
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220251
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 1:34 PM, Marcos Paulo de Souza wrote:
> Since the inclusion of blk-mq, elevator argument was not being
> considered anymore, and it's utility died long with the legacy IO path,
> now removed too.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  block/elevator.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 2f17d66d0e61..f56d9c7d5cbc 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -135,20 +135,6 @@ static struct elevator_type *elevator_get(struct request_queue *q,
>  	return e;
>  }
>  
> -static char chosen_elevator[ELV_NAME_MAX];
> -
> -static int __init elevator_setup(char *str)
> -{
> -	/*
> -	 * Be backwards-compatible with previous kernels, so users
> -	 * won't get the wrong elevator.
> -	 */
> -	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
> -	return 1;
> -}
> -
> -__setup("elevator=", elevator_setup);
> -
>  static struct kobj_type elv_ktype;
>  
>  struct elevator_queue *elevator_alloc(struct request_queue *q,
> 

Reviewed-by: Bob Liu <bob.liu@oracle.com>

