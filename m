Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D211C2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1223F21841
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gTHbDrqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgDQAUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:20:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52518 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgDQAUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 20:20:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03H0IDh2021419;
        Fri, 17 Apr 2020 00:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=K9MOq6ZxygloWsJ569a0ipg1ZFAP2IW36vqiTiicjhI=;
 b=gTHbDrqZH8as0eosDqMUXPAo/v0sifPxwJStm0ngTqC5Ax/pgAZgFJRFuFCx0O4mww9P
 5DFk5w0rxUUqummHzxDmee5bY4m7BWxl0O6OH3H362VloRgRp/0sT4hx9g5RmJio6w97
 vo9Zqzg3YB/zjWwzeEc6U5Mpk8gPUCUF5bS84koSJdWhgddKv07L4xzbjoC70Z/TWylW
 4tAf9NSdwhVpclVS6gE/1aa1PV3KeIzaoB7ljehqXQ5Z2tuv3KhusH6h00CPZUu8MeNe
 JNy9fbkq2azwaTJhShr1IKH9gtiUD0DBXEuvvO4sU434QXrK22MGfzt/XNn9WLAS++Jw Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30emejm813-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 00:20:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03H0C93L101585;
        Fri, 17 Apr 2020 00:20:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30dn9h64uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 00:20:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03H0JwWw013982;
        Fri, 17 Apr 2020 00:20:00 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 17:19:57 -0700
Subject: Re: [PATCH] loop: Call loop_config_discard() only after new config is
 applied.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de
Cc:     ming.lei@redhat.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20200331114116.21642-1-maco@android.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <fcdeb6a5-5da0-6759-3568-f5fa517e1c5d@oracle.com>
Date:   Fri, 17 Apr 2020 08:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331114116.21642-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170000
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/20 7:41 PM, Martijn Coenen wrote:
> loop_set_status() calls loop_config_discard() to configure discard for
> the loop device; however, the discard configuration depends on whether
> the loop device uses encryption, and when we call it the encryption
> configuration has not been updated yet. Move the call down so we apply
> the correct discard configuration based on the new configuration.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks fine to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 739b372a5112..7c9dcb6007a6 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1312,8 +1312,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  		}
>  	}
>  
> -	loop_config_discard(lo);
> -
>  	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>  	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
>  	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
> @@ -1337,6 +1335,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  		lo->lo_key_owner = uid;
>  	}
>  
> +	loop_config_discard(lo);
> +
>  	/* update dio if lo_offset or transfer is changed */
>  	__loop_update_dio(lo, lo->use_dio);
>  
> 

