Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89066C4360D
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DC4216C8
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSwNbOTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfIICXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:23:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36394 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732582AbfIICXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Sep 2019 22:23:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892ELu8057518;
        Mon, 9 Sep 2019 02:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=XXVt1NnzXfnxrwj5J+uXLqP0KDcdt2wtFr4yiRvxo4o=;
 b=SSwNbOTPDcm/VgfsFTi+ebqgQzyLmIbvbTwIeOxkcvZxJdTgM4Bd7+E9jlW/gRQJwaon
 p4pnuB5Jz5WegUGsYz0Kbj8woIddSX8YT8jP5cfXyqGgfe6HgZNVM0wvDhT5viFPaIvV
 xgRPcsmqM2+TlR7AWGjMErrNxrTj1JQoan4XTIvpBD6/CMB/peMxj/mxM3yoYdqkRMbP
 7GbpoACYrpxfQEkWlXpqcWuUjxHrM4dieSej2i50sdFcDfyOQ2LjxJRXDOLxwf+SLXkW
 Ri0XC3eUBp540wqj9oyYKjwlG5sTNQT4LCKfsWJfncVNUCTq5yvO9IsjNpMrtavw0neg oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uw1jxs79m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Sep 2019 02:22:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892JCl2183534;
        Mon, 9 Sep 2019 02:22:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2uv3wkw2rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Sep 2019 02:22:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x892Mrdm014431;
        Mon, 9 Sep 2019 02:22:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Sep 2019 19:22:53 -0700
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
        <1567956405-5585-2-git-send-email-maxg@mellanox.com>
Date:   Sun, 08 Sep 2019 22:22:50 -0400
In-Reply-To: <1567956405-5585-2-git-send-email-maxg@mellanox.com> (Max
        Gurtovoy's message of "Sun, 8 Sep 2019 18:26:44 +0300")
Message-ID: <yq1ftl6i4xx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909090023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909090023
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Max,

> Only type 1 and type 2 have a reference tag by definition.

DIX Type 0 needs remapping so this assertion is not correct.

-- 
Martin K. Petersen	Oracle Linux Engineering
