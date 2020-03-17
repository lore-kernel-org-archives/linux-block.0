Return-Path: <SRS0=EH6z=5C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2812C10F29
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 09:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D4B20663
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 09:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tpu3aAm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCQJLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:11:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36416 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgCQJLw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 05:11:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02H99CJH033825;
        Tue, 17 Mar 2020 09:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=D0Nse6OEnmBoGQpQRc+I7bvmxnx6X5/DlmZPhu5OKHk=;
 b=tpu3aAm8iD4MgpOobL1j7amysTqOB9yZNH5o5rzPomdSXra2K8n0uF6KunG+usYSWKMZ
 CQvYyAMMQ6NpcLME+7VHKOVaQpr49yiqmVJZGFrPyo4+U7edNAMhHg2wYTMY0O6KvHzG
 J1tVZe2ITkA9Ok1Xi8orCLbdEES34OduBK3zxB7A47ZAf04yK/i2Pl7t5Agc02XLo9+w
 MEOXKBvJ0eOGs8VWQ98buN9V3e1eXf5FTgfjVhr3yTsuFYUy2WtOVUaBafoub4PZnswR
 xe5cASCUHaA6RuMyPGxAmWHLT513qzk89XDj1i9Ci082Rg0Vwd1LU72E8gnvz2Z0YvE7 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yrppr3rm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 09:11:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02H9BnXi166892;
        Tue, 17 Mar 2020 09:11:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ys92ccn44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 09:11:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02H9Bl2J026574;
        Tue, 17 Mar 2020 09:11:48 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Mar 2020 02:11:47 -0700
Date:   Tue, 17 Mar 2020 12:11:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     houpu.main@gmail.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] nbd: requeue command if the soecket is changed
Message-ID: <20200317091142.GA17584@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=3
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=3 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170040
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Hou Pu,

This is a semi-automatic email about new static checker warnings.

The patch 2c272542baee: "nbd: requeue command if the soecket is
changed" from Feb 28, 2020, leads to the following Smatch complaint:

    drivers/block/nbd.c:437 nbd_xmit_timeout()
    error: we previously assumed 'config->socks' could be null (see line 410)

drivers/block/nbd.c
   409			 */
   410			if (config->socks) {
                            ^^^^^^^^^^^^^
Check for NULL.

   411				if (cmd->index < config->num_connections) {
   412					struct nbd_sock *nsock =
   413						config->socks[cmd->index];
   414					mutex_lock(&nsock->tx_lock);
   415					/* We can have multiple outstanding requests, so
   416					 * we don't want to mark the nsock dead if we've
   417					 * already reconnected with a new socket, so
   418					 * only mark it dead if its the same socket we
   419					 * were sent out on.
   420					 */
   421					if (cmd->cookie == nsock->cookie)
   422						nbd_mark_nsock_dead(nbd, nsock, 1);
   423					mutex_unlock(&nsock->tx_lock);
   424				}
   425				mutex_unlock(&cmd->lock);
   426				nbd_requeue_cmd(cmd);
   427				nbd_config_put(nbd);
   428				return BLK_EH_DONE;
   429			}
   430		}
   431	
   432		if (!nbd->tag_set.timeout) {
   433			/*
   434			 * Userspace sets timeout=0 to disable socket disconnection,
   435			 * so just warn and reset the timer.
   436			 */
   437			struct nbd_sock *nsock = config->socks[cmd->index];
                                                 ^^^^^^^^^^^^^
New unchecked dereference.

Also on the other path, we check that "cmd->index" is within bounds but
here we just assume that it is.

   438			cmd->retries++;
   439			dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",

regards,
dan carpenter
