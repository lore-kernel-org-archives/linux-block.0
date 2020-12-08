Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D073C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11F02396F
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgLHMQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:16:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43348 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgLHMQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 07:16:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8C9Jjf166546;
        Tue, 8 Dec 2020 12:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=7UliRlHRElbCGREYLJ0M2IuFH73D5+kCQPf6Ud1B5zg=;
 b=0NByU4WlYbyNSbz2n+uxdWTUnLzPDXCpvetnmUIfpJQLumjOiesJy+gNCck5tpgMP39O
 ZA7h+KGBNKKuGZ+k6EPjTptIwQ/szpZ9k0aQl1qqSG3eoWOxqLq4Onv0zFD9szaKVOSS
 XTtMxR7q00/FnbqbQn2T0nq/OZwiih6Ez5Xho7c/D2KnCBy3P+EKjCUaoZlgjHSIXyMW
 O5Pvhmg5XjbENLxGHKZQpL8Jp7APTj/p+I5lGAy9O1oHSLhijnCjuYhcBMOtYpEvu54Q
 lB1vrkougtw8ZnfGpHSApr6vME0Waz4WkgjA5u/U0VHVdWYSkIOxaCAyz90McHoL0R56 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35825m2eyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 12:15:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8CAmrM045592;
        Tue, 8 Dec 2020 12:15:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 358ksnfwuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 12:15:39 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8CFcjS010018;
        Tue, 8 Dec 2020 12:15:38 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 04:15:37 -0800
Date:   Tue, 8 Dec 2020 15:15:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     haris.iqbal@cloud.ionos.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] block/rnbd-clt: Dynamically alloc buffer for pathname &
 blk_symlink_name
Message-ID: <X89uUXoVbUFMg27k@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=877 suspectscore=3
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=868 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080078
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Md Haris Iqbal,

This is a semi-automatic email about new static checker warnings.

The patch 64e8a6ece1a5: "block/rnbd-clt: Dynamically alloc buffer for
pathname & blk_symlink_name" from Nov 26, 2020, leads to the
following Smatch complaint:

    drivers/block/rnbd/rnbd-clt-sysfs.c:525 rnbd_clt_add_dev_symlink()
    error: uninitialized symbol 'ret'.

    drivers/block/rnbd/rnbd-clt-sysfs.c:524 rnbd_clt_add_dev_symlink()
    error: we previously assumed 'dev->blk_symlink_name' could be null (see line 500)

drivers/block/rnbd/rnbd-clt-sysfs.c
   493  static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
   494  {
   495          struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
   496          int ret, len;
   497  
   498          len = strlen(dev->pathname) + strlen(dev->sess->sessname) + 2;
   499		dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
   500		if (!dev->blk_symlink_name) {
   501			rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
   502			goto out_err;

ret = -ENOMEM; here

   503		}
   504	
   505		ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
   506					      len);
   507		if (ret) {
   508			rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
   509				      ret);
   510			goto out_err;
   511		}
   512	
   513		ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
   514					dev->blk_symlink_name);
   515		if (ret) {
   516			rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
   517				      ret);
   518			goto out_err;
   519		}
   520	
   521		return 0;
   522	
   523	out_err:
   524		dev->blk_symlink_name[0] = '\0';
                ^^^^^^^^^^^^^^^^^^^^^^^^
This will oops if the kzalloc() fails.

   525		return ret;
   526	}

regards,
dan carpenter
