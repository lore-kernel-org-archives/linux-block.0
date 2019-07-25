Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54266C7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6F22BEF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XooNXO47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbfGYIS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:18:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389223AbfGYIS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 04:18:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P8EP4I015635;
        Thu, 25 Jul 2019 08:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=BVAnIvWTNuv/VK4hMt2Od/ptOyDNGJmz7VbFsuDg0+o=;
 b=XooNXO47YHbgxtwDL5yqTyKBxQbI49D6TXAuRLO1glEYxa75fNM1XsU8xoVUJ8lzYS8Q
 OKTyu0cozr3hKzpm+bJCGNLRNvGxYiWh2DXiKYrkKahHTnV7DCwp1JVcrwHT9ZizDC+w
 PTLNPMc3vmpN0HjqxMBUp7xJOR0Casdc2u9rgluWRPYtHQWmKVHh/1ak9d8KkFT8C4Q8
 83Sc4VO41VTxRZrgtvZDp44bsWSGcGEc+Gy9JXSUasqHok5OLGbe7UgFO4DYDFVCz2k6
 JgJlxgCkATOVD1EuiPt7hoMrAGwHMBUlCHcBKhOzD6I564j2izAwzAa1+/4Cow7fX2/R Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tx61c2907-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 08:18:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P8HtG6188644;
        Thu, 25 Jul 2019 08:18:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tx60ysfmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 08:18:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6P8Ihq3010739;
        Thu, 25 Jul 2019 08:18:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 01:18:41 -0700
Date:   Thu, 25 Jul 2019 11:18:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dhowells@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] vfs: Convert ceph to use the new mount API
Message-ID: <20190725081813.GA14034@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=849
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=893 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250098
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello David Howells,

The patch 108f95bfaa56: "vfs: Convert ceph to use the new mount API"
from Mar 25, 2019, leads to the following static checker warning:

	drivers/block/rbd.c:7141 do_rbd_add()
	warn: passing freed memory 'ctx.opt'

drivers/block/rbd.c
  7046          /* parse add command */
  7047          rc = rbd_add_parse_args(buf, &ctx);
  7048          if (rc < 0)
  7049                  goto out;
  7050  
  7051          rbdc = rbd_get_client(ctx.opt);

This looks like it frees ctx.opt if rbd_client_find() returns non-NULL.

  7052          if (IS_ERR(rbdc)) {
  7053                  rc = PTR_ERR(rbdc);
  7054                  goto err_out_args;
  7055          }
  7056  
  7057          /* pick the pool */
  7058          rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap,
  7059                                      ctx.rbd_spec->pool_name);
  7060          if (rc < 0) {
  7061                  if (rc == -ENOENT)
  7062                          pr_info("pool %s does not exist\n", ctx.rbd_spec->pool_name);
  7063                  goto err_out_client;
  7064          }

[ snip ]

  7125  out:
  7126          module_put(THIS_MODULE);
  7127          return rc;
  7128  
  7129  err_out_image_lock:
  7130          rbd_dev_image_unlock(rbd_dev);
  7131          rbd_dev_device_release(rbd_dev);
  7132  err_out_image_probe:
  7133          rbd_dev_image_release(rbd_dev);
  7134  err_out_rbd_dev:
  7135          rbd_dev_destroy(rbd_dev);
  7136  err_out_client:
  7137          rbd_put_client(rbdc);
  7138  err_out_args:
  7139          rbd_spec_put(ctx.rbd_spec);
  7140          kfree(ctx.rbd_opts);
  7141          ceph_destroy_options(ctx.opt);
                                     ^^^^^^^
Double free.

  7142          goto out;
  7143  }


regards,
dan carpenter
