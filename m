Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C93C2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34502240B
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 21:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hjCAAPiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKTVin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:38:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgKTVim (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 16:38:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKLc9ED004163;
        Fri, 20 Nov 2020 21:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vdgWyMqTZ/KgANno+C5rCsxsLffEg7/4wEFhdg4BzwI=;
 b=hjCAAPiQuGKgg9PQlmF2CEhfXgsK4V3IL0TBllq3pwdLW2cAsCBNqTQ4ThGfPvnQoh9+
 V7EbbfgvR6mElEDy6mt+/BayXJ+D9umRbQoMUux/U76sqn2bBS0eFkGWVhKyhmvo+iOW
 pOZGAsOecys9/DjyqOootIsFGCbj54uTsMShNy2TgH7R72HHP4isQNzlEyT35/1CmhDI
 JCsQZTzIA37BdmeXrTiRI13i2DeCcMcrOP56wP6TIXdMpjjWdE4ef5e6oK3KN5BTnDFc
 Ak9rAB4fR9ngZI1whbbshi5ybA/yEtPOObnfChfOccclqBnRcR5YseEhI/aYwHBhJ2g3 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76mcr2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 21:38:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKLVUlF003267;
        Fri, 20 Nov 2020 21:36:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umd3yqg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 21:36:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AKLaREe006534;
        Fri, 20 Nov 2020 21:36:28 GMT
Received: from [10.74.102.87] (/10.74.102.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 13:36:27 -0800
Subject: Re: [PATCH 058/141] xen-blkfront: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <33057688012c34dd60315ad765ff63f070e98c0c.1605896059.git.gustavoars@kernel.org>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <e8d67ea1-3d0d-509a-a2f1-cf1758bb373f@oracle.com>
Date:   Fri, 20 Nov 2020 16:36:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <33057688012c34dd60315ad765ff63f070e98c0c.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200143
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/20/20 1:32 PM, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/block/xen-blkfront.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 48629d3433b4..34b028be78ab 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2462,6 +2462,7 @@ static void blkback_changed(struct xenbus_device *dev,
>  			break;
>  		if (talk_to_blkback(dev, info))
>  			break;
> +		break;
>  	case XenbusStateInitialising:
>  	case XenbusStateInitialised:
>  	case XenbusStateReconfiguring:


Reviewed-by Boris Ostrovsky <boris.ostrovsky@oracle.com>


(for patch 138 as well)


Although I thought using 'fallthrough' attribute was the more common approach.


-boris

