Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A4C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E26207D0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 09:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fh3v6xc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgFEJo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:44:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34252 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgFEJo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 05:44:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559WPAR020418;
        Fri, 5 Jun 2020 09:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qqApPwaVsfD9KsWb9ZyJEdEVujKUGkYoa9MNEy7rOgw=;
 b=fh3v6xc2K8PcQ+zXUCdybeuP5xdRJxcdvjETG0pvaclDVmio2zsBTIhjDulrOz1XZFYQ
 iaak6lheEb0bDsEeuQ7ADjnNOjJghIwmPKzdkGPe10v+SWOWWPqj0w8au8drGUvyzpGp
 BLgNIidDGZxdbrT5PYpw594bqmF0hTxkegqXF2Nve/qe5bPDaCoY04/gAZUskchs+TMV
 38FHKd53dX8M+3htO5XiRqOdwrsLQyGIQgfncrPVoEn0IBNhmTCc0Ip2FFWcrcdx4AB1
 cOMI564TFkm33GTZXtsr5mQTQoHwX2k1H0GwHbm8GmQNzffno9NpjpJHIWJLabqSteaF AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31f926227d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 09:44:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559YLqa146838;
        Fri, 5 Jun 2020 09:44:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31f926y236-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 09:44:08 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0559i3Ee022645;
        Fri, 5 Jun 2020 09:44:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 02:44:02 -0700
Date:   Fri, 5 Jun 2020 12:43:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Yan <yanaijie@huawei.com>, Jan Kara <jack@suse.cz>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hulkci@huawei.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
Message-ID: <20200605094353.GS30374@kadam>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=2 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=2 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050074
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A lot of maintainers have blocked Markus and asked him to stop trying
to help people write commit message.  Saying "bdev" instead of "block
device" is more clear so your original message was better.

The Fixes tag is a good idea though:

Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")

It broke last July.  Before that, we used to check if __blkdev_get()
failed before dereferencing "bdev".

I wonder if maybe the best fix is to re-add the "if (!res) " check back
to blkdev_get().  The __blkdev_get() looks like it can also free "whole"
though if it calls itself recursively and I don't really know this code
so I can't say for sure...

regards,
dan carpenter

