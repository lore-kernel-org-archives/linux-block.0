Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6784C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 12:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8C207D8
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a3vCr1Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgESMEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 08:04:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESMED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 08:04:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JC1lWV037335;
        Tue, 19 May 2020 12:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5Dh6Kmbkk88WlGxBnrORL6ipiVsjzGGG0ld8Cmr/oEo=;
 b=a3vCr1Qssr/Fsd8D+n7WkYPUngrf5ETstMC+iQqlmXSoTGiwYDMf8ZgBPRG9OBQhVAD4
 1uExhBaIvTiCoGVx35LUSfcVLEc8F6cEgJMrQrEx3ooMFns9WfxjWfe2Zu/a8CodXpkv
 BN0wKfQGdw69PBIW3doicKCBwvfD30EJ9/MR3IsUOTU1xa2mmROQKhAXDMZfuMdWJjBd
 +60flxBPivF+IMbeWQ/GWeVdnwxA16AaP/hdUbMVnXTV3keb0m5ZXzh7QS4qsXtYPi0R
 cIv4Z185OevARFYzHwPLuGW+MQKyrBrEK+67ANbHYuFU6O2ZH0t+iZ1z1NFCNB61orRk JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31284kvwgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 12:03:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JC32cL065970;
        Tue, 19 May 2020 12:03:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 312t343b34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 12:03:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JC3sGQ018978;
        Tue, 19 May 2020 12:03:55 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 05:03:54 -0700
Date:   Tue, 19 May 2020 15:03:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] block/rnbd: Fix an IS_ERR() vs NULL check in
 find_or_create_sess()
Message-ID: <20200519120347.GD42765@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005190109
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The alloc_sess() function returns error pointers, it never returns NULL.

Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/rnbd/rnbd-clt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 55bff3b1be71..a033247281da 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -923,13 +923,12 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 	sess = __find_and_get_sess(sessname);
 	if (!sess) {
 		sess = alloc_sess(sessname);
-		if (sess) {
-			list_add(&sess->list, &sess_list);
-			*first = true;
-		} else {
+		if (IS_ERR(sess)) {
 			mutex_unlock(&sess_lock);
-			return ERR_PTR(-ENOMEM);
+			return sess;
 		}
+		list_add(&sess->list, &sess_list);
+		*first = true;
 	} else
 		*first = false;
 	mutex_unlock(&sess_lock);
-- 
2.26.2

