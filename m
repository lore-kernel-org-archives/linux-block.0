Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E2C32771
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 02:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE65E2084D
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 02:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dh8HrAEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAPCh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:37:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgAPCh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 21:37:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G2X7qR053960;
        Thu, 16 Jan 2020 02:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=cJepd6v+kl5qHCKEO45UOzAzvpDaxTiztFRQXj/u8kI=;
 b=dh8HrAEdbZW6kjXg80LSIt/t94zPF2iwgAvUUSNgNS7dVjwMzaBUBqm3SUNrC5hFfR4+
 c/xxMldk6Nf+m6471V+L8YEc12g3R8UOsMtLq/K4y1gWhAA4mC5pUaPSFggSz7jkqhs+
 EBUIqFazRy2tx/ivevZYN6YKN9WjCGn0sqyvP9Okrs2QPyRP6I7/zpBbK/r9u154YgN2
 7zuWSWV0iLzhecFNV5+utsyh8GENdhpnRsYd1WK1DWl3jTkU6hRxP1+rS/P3/t6QOote
 5jJAx5xByuzIgv4QzzSZVVI9cgmznA9swmkse1TYd3xaOjUkpbOb3mMTgpL4Wb1FqKFk xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xf73tyrkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 02:37:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G2YDQv121487;
        Thu, 16 Jan 2020 02:37:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xj1ashykm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 02:37:53 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00G2bqeo025161;
        Thu, 16 Jan 2020 02:37:52 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 18:37:52 -0800
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC 0/2] Fixes for fio io_uring polled mode test failures
Date:   Wed, 15 Jan 2020 18:37:44 -0800
Message-Id: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=800
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=856 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches address the crash and list corruption errors when running
the fio test below.

[global]
filename=/dev/nvme0n1
rw=randread
bs=4k
direct=1
time_based=1
randrepeat=1
gtod_reduce=1
[fiotest]


fio nvme.fio --readonly --ioengine=io_uring --iodepth 1024 --fixedbufs 
--hipri --numjobs=$1 --runtime=$2

Bijan Mottahedeh (2):
  io_uring: clear req->result always before issuing a read/write request
  io_uring: acquire ctx->uring_lock before calling io_issue_sqe()

 fs/io_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.8.3.1

