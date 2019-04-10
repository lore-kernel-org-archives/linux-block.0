Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F039C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 06:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52620850
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 06:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZLaKjTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfDJGZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:25:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48782 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfDJGZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 02:25:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A6Nd7J082572;
        Wed, 10 Apr 2019 06:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lQprHHD2H5e3ZVHvU52qIVqUjvC1Qu8Ru3mGNZcmsZc=;
 b=lZLaKjTDU367ZvxtQeaIDFpm6Id5QLnP54UgjC7iOL3KXECAWTf0gasChizKXQ30mNhO
 L6fBAlAd3C/IuOnTdvVJSgoiqtKp79u2tmSajmgsVjRFZIdtB6oQFEjyJyIVoJkcyOma
 TtWstA92cjT5+6IwIXlVWJvXC54JqctrZ+s6Gv6boRlWKZD0aozDj7CkXht6b2ing3r0
 P5dubreswAqhbou+moWXIlZfboGZweTNViMs6IGfpHP81wjHOMFSHbSgH/o4GPSfrgdz
 E74IT+iybHI3Y9hYb1fSMc9ihRW+fzc0s9L2KZ6jWKto1W6JAY09QU/BTtNx4CSYU33a og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrq8xt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:25:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A6OTU7131502;
        Wed, 10 Apr 2019 06:25:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2rph7t14yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:25:26 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A6PPdE007433;
        Wed, 10 Apr 2019 06:25:25 GMT
Received: from [10.182.69.255] (/10.182.69.255)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 23:25:25 -0700
Subject: Re: [PATCH] io_uring: fix ifnullfree.cocci warnings
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
References: <alpine.DEB.2.21.1904100815270.2799@hadrien>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <65985b3e-d846-89b9-13d4-8756b58f6e47@oracle.com>
Date:   Wed, 10 Apr 2019 14:25:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904100815270.2799@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100046
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100046
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/10/19 2:16 PM, Julia Lawall wrote:
> From: kbuild test robot <lkp@intel.com>
> 
> NULL check before kfree is not needed.
> 
> Generated by: scripts/coccinelle/free/ifnullfree.cocci
> 
> Fixes: b905f31ee046 ("io_uring: introduce inline reqs for IORING_SETUP_IOPOLL")
> CC: Jianchao Wang <jianchao.w.wang@oracle.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> ---
> 
> url:    https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux_commits_Jianchao-2DWang_io-5Furing-2Dintroduce-2Dinline-2Dreqs-2Dfor-2DIORING-5FSETUP-5FIOPOLL_20190409-2D194746&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=JhagBidUFU8krcGWek4GwnU4uoqS09eboyA8kslpNts&s=fcK4IjSBbR0XznBh7lL6V47NyfxmdixfO3QXiWWVuX0&e=
> :::::: branch date: 17 hours ago
> :::::: commit date: 17 hours ago
> 
>  io_uring.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2597,8 +2597,7 @@ static void io_ring_ctx_free(struct io_r
>  		sock_release(ctx->ring_sock);
>  #endif
> 
> -	if (ctx->inline_req_array)
> -		kfree(ctx->inline_req_array);
> +	kfree(ctx->inline_req_array);

Yes, indeed. kfree can tolerate NULL pointer.
Will change it in latter version.

Thanks
Jianchao

> 
>  	io_mem_free(ctx->sq_ring);
>  	io_mem_free(ctx->sq_sqes);
> 
