Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956FAC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9F20857
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pl87DyKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfA1NUh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:20:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37156 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1NUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:20:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SDIvIE065946;
        Mon, 28 Jan 2019 13:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MXXw0PChLTceT0pE6PjReEUk17vPg2HubCB+RKdTamI=;
 b=Pl87DyKqeXWO17SnB97WpLAs3T0EFiDDmC26VPiHZMhEHdP8YcRICEPy24VVPmQFs7jF
 2esS6U9FCKR8hFpqUinyi4AQZRYehTpJj6ajlwFr4970a1vcq/ig74jHEk7NJc9tA44q
 C94uRqE09zO/fR927FWKc2hONSPClSZF0v4zeJVdum/WYHCz0HPsneskrSLeGKofF4Nd
 1YQev3CH6aJEF+ZxR0XDhoM3Jpwj77O0w23Ce4FRC8V/hCg0uZhnBPO8kC2q6/Bljy/O
 l7pmHpQouw3ku4VKy8PmXQmnDHSsA+BMj2I20dhHQtgf+rCXL3lSdrSxSRLPLHkguLn+ 7Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q8d2dx73u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 13:19:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0SDJpRm003845
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 13:19:51 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0SDJoS0029471;
        Mon, 28 Jan 2019 13:19:51 GMT
Received: from kadam (/197.157.34.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 05:19:50 -0800
Date:   Mon, 28 Jan 2019 16:19:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] floppy: check_events callback should not return a
 negative number
Message-ID: <20190128131942.GH1795@kadam>
References: <20190128090646.44747-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128090646.44747-1-yuyufen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 05:06:46PM +0800, Yufen Yu wrote:
> Since .check_events interface return an unsigned int value,
> floppy_check_events() should not return a negative error number.
> Otherwise, disk_check_events() may process wiht an unexpected path.
> 
> fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/block/floppy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 6f2856c6d0f2..55481b40df9a 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4075,7 +4075,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
>  
>  	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
>  		if (lock_fdc(drive))
> -			return -EINTR;
> +			return 0;

The patch is correct, but I wish the commit message had said what the
run time impact of the patch is.  Or sometimes it's hard to say what the
run time impact is, but it could have at least said why returning zero
is correct.  Say something like:

  floppy_check_events() is supposed to return bit flags to say which
  events occured.  We should return zero to say that no event flags are
  set.  Only BIT(0) and BIT(1) are used in the caller.  This code
  returns -4u  here so both BIT(0) and BIT(1) are clear.  So this patch
  shouldn't affect runtime, but it obviously is still worth fixing.

regards,
dan carpenter
