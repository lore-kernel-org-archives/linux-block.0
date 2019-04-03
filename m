Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4055EC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54620882
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 06:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lkcQCvw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfDCGPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:15:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43478 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCGPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 02:15:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3363dfh020161;
        Wed, 3 Apr 2019 06:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=FXWGszBwk+zJdu+WCpXoCjQuCfGIl2iMj82QTScq6wU=;
 b=lkcQCvw8m1/taxzOyf5eJpYnX6odJswgMNuGMeXdu0HZyJbMF/ywRTtQRcRSZM91Tcin
 8U228GwJOPNUlwin9QP9EW+my3+6HwWYBubIMTJzTs5WAHCHy5ql/ytKr0NtaFHtM4O3
 6eeoU7GcdB/UBso0wQP3B904XW87Cd2Dl5Urh26M0D6lWlSWVhyq0u3np1Hkv9S5JjZ3
 uHK78oMlet+nVidPi0Ju+yuXpk+AQcxi76C6Q2jJRUL7MI0WQLRBWHh57Y3HFRfPVSvc
 pvzeYoHLFsn0rUIKk81FHPqzpO2gsL4rBo3JeRfgyUPyXGNoFLZeu31l5P8QyR1t0+HD rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2rj0dnp2nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 06:15:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x336Dt8Z152433;
        Wed, 3 Apr 2019 06:15:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f4wra7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 06:15:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x336FJTv029986;
        Wed, 3 Apr 2019 06:15:20 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 23:15:19 -0700
Date:   Wed, 3 Apr 2019 09:15:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
Subject: [bug report] block, bfq: update blkio stats outside the scheduler
 lock
Message-ID: <20190403061512.GA1618@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030041
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=754 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030041
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Paolo Valente,

This is a semi-automatic email about new static checker warnings.

The patch 24bfd19bb789: "block, bfq: update blkio stats outside the 
scheduler lock" from Nov 13, 2017, leads to the following Smatch 
complaint:

    block/bfq-iosched.c:5013 __bfq_insert_request()
    error: we previously assumed 'bfqq' could be null (see line 5008)

block/bfq-iosched.c
  5007	
  5008		waiting = bfqq && bfq_bfqq_wait_request(bfqq);
                          ^^^^
The patch adds a NULL check here.  Hopefully it's not required because

  5009		bfq_add_request(rq);
  5010		idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);
  5011	
  5012		rq->fifo_time = ktime_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
  5013		list_add_tail(&rq->queuelist, &bfqq->fifo);
                                              ^^^^^^^^^^^
the existing code assumes "bfqq" is valid.

  5014	
  5015		bfq_rq_enqueued(bfqd, bfqq, rq);

regards,
dan carpenter
