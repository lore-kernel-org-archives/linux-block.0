Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5FC2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 10:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E558E2076E
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 10:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N7hBLQ7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgKIKZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:25:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 05:25:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9AOEiG026777
        for <linux-block@vger.kernel.org>; Mon, 9 Nov 2020 10:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mXt0u+bKWSg7ZtzA12xi/tKKD10GhMkK9eqIg/7z2G8=;
 b=N7hBLQ7vKMAeajynL0+zdMI55xH3AZqWbZFYtW+2q4kutUibbfQvkmmGYgQsCc3YAwub
 7gWCSez734qks60Gga5uED05T6OUy5dKjXVGJPOMmaDXSdCJgbvT00WSjj1tkKW2iXYC
 3lpZIgg/RrFe+UIgpOI8nO9sOFgffi9cdh4lOvbKz/IXC/U9JTLutgjqKikY6MqBZA4M
 R4/DzHVWomkdlna7hVNeDHD/raSJ3zO96buWa81Ud67ErXtztp1i12SwMETBqsCUsJRG
 viitRMH45K3Cm/pRdkP/UN5LWIPeO89b3l8tLZYvS3wD0ZAwZ9XZX5sTeW/wHmXFnztw UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3andm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 10:25:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9AP8UN025806
        for <linux-block@vger.kernel.org>; Mon, 9 Nov 2020 10:25:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55ksc1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 10:25:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9AOuIp001437
        for <linux-block@vger.kernel.org>; Mon, 9 Nov 2020 10:24:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 02:24:55 -0800
Date:   Mon, 9 Nov 2020 13:24:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     konrad.wilk@oracle.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] xen/blkback: Prefix 'vbd' with 'xen' in structs and
 functions.
Message-ID: <20201109102449.GA2454565@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=512 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=10
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=10
 mlxlogscore=523 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090067
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[ This is an ancient bug and it's too old to know who to blame.  But
  what I know is that it probably has nothing to do with changing the
  prefix from vbd_ to xen_ so my blame scripts are likely wrong. - dan ]

Hello Konrad Rzeszutek Wilk,

This is a semi-automatic email about new static checker warnings.

The patch 3d814731ba67: "xen/blkback: Prefix 'vbd' with 'xen' in
structs and functions." from May 12, 2011, leads to the following
Smatch complaint:

    drivers/block/xen-blkback/xenbus.c:510 xen_vbd_create()
    error: we previously assumed 'vbd->bdev->bd_disk' could be null (see line 507)

drivers/block/xen-blkback/xenbus.c
   506		vbd->bdev = bdev;
   507		if (vbd->bdev->bd_disk == NULL) {
                    ^^^^^^^^^^^^^^^^^^
If vbd->bdev->bd_disk is NULL then we are toasted.

   508			pr_warn("xen_vbd_create: device %08x doesn't exist\n",
   509				vbd->pdevice);
   510			xen_vbd_free(vbd);

The disk_flush_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE); call in
blkdev_put() will Oops.

   511			return -ENOENT;
   512		}

regards,
dan carpenter
