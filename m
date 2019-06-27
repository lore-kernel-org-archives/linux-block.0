Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF8BC48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86D52084B
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5RH7jFCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0IDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:03:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52460 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfF0IDK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:03:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R7xHWw007350;
        Thu, 27 Jun 2019 08:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=GsmIzbpJCR32uz6v68Z3n8bE1+sN3I+SX9uhWf2C4rw=;
 b=5RH7jFCQhCzzqN021F/sI9y/Z/Akmn+OY365RKJHZlq/uO3N4J5EinezpJV+nbqSn4xw
 8oOmjxTRVdGwns5jF1FjEfKohfFeAhbPH5n3VfS5ezuZlS5X+pU3jxG9SH3d2g1iO0sM
 EDGgZgO+q22iLL5JmlXurzMeEGjOG0zNg+wRi1+1F1utE2nouTIDbi32t4BTjN9L82wu
 YL6ZPnel6cCZHNREzX+7fDjFj3nlKwYdk3qiRrGfM9+E352TZxzIPVCJXGUMyO5E3V4O
 ykYs+XcEql+AlcZcZdc5sD7SWsnBLT6RIOrLcNVbnk7k5DXu9HX4U9vapfa7YjD9LXHP 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pxpkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:03:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R82xps144488;
        Thu, 27 Jun 2019 08:03:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7d7ysb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:03:08 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R837T5010986;
        Thu, 27 Jun 2019 08:03:07 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 01:03:06 -0700
Date:   Thu, 27 Jun 2019 11:03:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
Subject: [bug report] block, bfq: bring forward seek&think time update
Message-ID: <20190627080300.GA28276@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=650
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=706 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Paolo Valente,

This is a semi-automatic email about new static checker warnings.

The patch a3f9bce3697a: "block, bfq: bring forward seek&think time 
update" from Jun 25, 2019, leads to the following Smatch complaint:

    block/bfq-iosched.c:5353 __bfq_insert_request()
    warn: variable dereferenced before check 'bfqq' (see line 5349)

block/bfq-iosched.c
  5348	
  5349		bfq_update_io_thinktime(bfqd, bfqq);
                                              ^^^^
The patch introduces a new dereference (inside the function)

  5350		bfq_update_has_short_ttime(bfqd, bfqq, RQ_BIC(rq));
  5351		bfq_update_io_seektime(bfqd, bfqq, rq);
  5352	
  5353		waiting = bfqq && bfq_bfqq_wait_request(bfqq);
                          ^^^^
but the old code assumed "bfqq" could be NULL.

  5354		bfq_add_request(rq);
  5355		idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);

regards,
dan carpenter
