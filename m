Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C86C2BA17
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2696620748
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 18:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9KMtPWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDFSa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:30:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 14:30:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036IS4bN002929
        for <linux-block@vger.kernel.org>; Mon, 6 Apr 2020 18:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=57K5xmz6sd2lROjVApwMvKbYlN8xBm2V4bbuesPUcs8=;
 b=i9KMtPWY4KDwLkN5T5MMRIwZcURkBBhe0Q1+cNYfizNAKvefeM0c0vCkzXdJtDn5+HPa
 2gYBa55/3u5XDRA/rNdY4kbM5ircqnOqEjiRn5U9R+f5yZSmPYq9D/zBBYRb9kuFZKoi
 ooG7JFMAQVbIZoL8EThfiDWeldzBJ05KAPYtrmL0Jv+PLTV8k3uyVrs4w0IyeygoMdQG
 BD/NNRONQWprukt7vlqoCMIVM8LpkMwkL4Cdq6TjklA4sNo4xYCoQiDgQp13sRM4qqYh
 cbjyh9rvXJznrRsbmOQDOsMXJSj8N81L84sUXhopEik6rKxJeH/xp3Ji9fmPNhfE9Anm Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 306j6m8krj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2020 18:30:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036IRflu194766
        for <linux-block@vger.kernel.org>; Mon, 6 Apr 2020 18:30:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30741bb7rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2020 18:30:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036IUQqf016283
        for <linux-block@vger.kernel.org>; Mon, 6 Apr 2020 18:30:26 GMT
Received: from [10.154.104.53] (/10.154.104.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 11:30:26 -0700
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: BLK_QC_T_NONE and polled I/O
Message-ID: <44e755b7-df5c-add6-900e-25e3df63b2c6@oracle.com>
Date:   Mon, 6 Apr 2020 11:30:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200405-0, 04/05/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=834
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=881 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060144
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have a question BLK_QC_T_NONE interaction with polled I/O.

Given that blk_poll() returns immediately in case of 
blk_qc_t_valid(cookie), the following cases return BLK_QC_T_NONE which 
seem like they would be problematic with polling:

generic_make_request()
...
         if (current->bio_list) {
                 bio_list_add(&current->bio_list[0], bio);
                 goto out;     >>> this will return BLK_QC_T_NONE
         }

In this case the request is deferred but should get a cookie 
eventually.  How would the submitter poll for this request?

__blk_mq_issue_directly()
...
         case BLK_STS_RESOURCE:
         case BLK_STS_DEV_RESOURCE:
                 blk_mq_update_dispatch_busy(hctx, true);
                 __blk_mq_requeue_request(rq);
                 break;

In this case, cookie is not updated and would keep its default 
BLK_QC_T_NONE value from blk_mq_make_request().  However, 
__blk_mq_requeue_request() will release the original cookie and this 
request will eventually be resubmitted, so how would the submitter poll 
for the completion of this request?

blk_mq_try_issue_directly()
...
         ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
         if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
                 blk_mq_request_bypass_insert(rq, false, true);


Incidentally, I don't see BLK_QC_T_EAGAIN used anywhere, should it be?

Thanks.

--bijan
