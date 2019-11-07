Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2561AC5DF61
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 07:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D7222C5
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 07:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OpLiqukL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbfKGHtG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:49:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKGHtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 02:49:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA77mfvP072483;
        Thu, 7 Nov 2019 07:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=jWR+TnPhSA14NeH1OOvS+/rjTxIzSqL1OgNwBLErpNw=;
 b=OpLiqukL6/T+yKTuQ2BDkARL+NLCwAQ005TcrCbsaeEimafivol+/8UPC7zPUuu1nv54
 epaUzQ/riizqshB2w1fLfOpyEPJ1Lv/lV9lsDZOnsHltol3tUKdLXpLhFiUY1xpo6u6y
 KMFG/268J0JS5hXTzOLsrzxAioakoHt4BTX0FDEOWDoNAlziOll2fk/hkZjIu56YCp2A
 d58tqd3Pwuj7gKxFo0c5DtHdu97WLfzPw9MgcZhPa3PtNuFypeztKLXBIB/NckOsXv1o
 8iiWleLFY4oRDMEkvw+GZrAcoPLou5hIpM8z3p+hztdaG8Jp5LyO7liAsO5959Kt525g /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w41w145fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 07:49:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA77mqQA008876;
        Thu, 7 Nov 2019 07:49:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w41w93xu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 07:48:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA77mt2T019768;
        Thu, 7 Nov 2019 07:48:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 23:48:55 -0800
Date:   Thu, 7 Nov 2019 10:48:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@tron.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] block: drbd: remove a stay unlock in __drbd_send_protocol()
Message-ID: <20191107074847.GA11695@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070078
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are two callers of this function and they both unlock the mutex so
this ends up being a double unlock.

Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for tconn->net_conf")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analisys.  Not tested.  There is a comment about the lock next to
the caller in drbd_nl.c that I didn't understand:

drivers/block/drbd/drbd_nl.c
  2509          crypto_free_shash(connection->integrity_tfm);
  2510          connection->integrity_tfm = crypto.integrity_tfm;
  2511          if (connection->cstate >= C_WF_REPORT_PARAMS && connection->agreed_pro_version >= 100)
  2512                  /* Do this without trying to take connection->data.mutex again.  */
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
What does this mean?  We're already holding that lock.  We took it near
the start of the function.

  2513                  __drbd_send_protocol(connection, P_PROTOCOL_UPDATE);
  2514  
  2515          crypto_free_shash(connection->cram_hmac_tfm);
  2516          connection->cram_hmac_tfm = crypto.cram_hmac_tfm;
  2517  
  2518          mutex_unlock(&connection->resource->conf_update);
  2519          mutex_unlock(&connection->data.mutex);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unlocked here.

 drivers/block/drbd/drbd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5b248763a672..a18155cdce41 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -786,7 +786,6 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 
 	if (nc->tentative && connection->agreed_pro_version < 92) {
 		rcu_read_unlock();
-		mutex_unlock(&sock->mutex);
 		drbd_err(connection, "--dry-run is not supported by peer");
 		return -EOPNOTSUPP;
 	}
-- 
2.20.1

