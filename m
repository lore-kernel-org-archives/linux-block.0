Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B4C4CEC5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27C5208C2
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbete2sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbfIMWU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:20:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58370 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404021AbfIMWU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:20:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DM3pqS146692;
        Fri, 13 Sep 2019 22:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=I7MG1IhMgHYPqdXB/W6w8aJgPGeRPrEsbTf678ZbsSs=;
 b=bbete2snAIuAEXVRzrpa5LJ4U25cuYg4PsS+prUAPraZy2nAdsALqmxwPIMrkrVqHULD
 XhRSUThM/kl6RefPJs9IMifdNFriGx4zvOnrktAgTrtojtMUU4EF+Inu3xqTDopiHU0K
 wb1zqVv3Q+NfPBqJtkeMtQRh3DWAKjyQ3mkSJ0QuzN/ucv+sYqDL7/DZRU+UUh7kBb+s
 T9xAm2Dh1AzyqrrHtXoF43mrkYPMW08uczU/YbEGyO0jPzOaPkVeJc3QvOTpBmr7pSpb
 8fakpzvLLKzad7La6vU5XNAhe2scGaE20u+Zu+df/MtSdxUxlJS+/r23glOeJDlvj0wz eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uytd379yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 22:20:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DM3egZ052747;
        Fri, 13 Sep 2019 22:20:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v0cwk4jet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 22:20:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DMKQHV031508;
        Fri, 13 Sep 2019 22:20:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 15:20:26 -0700
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <axboe@kernel.dk>, <keith.busch@intel.com>, <sagi@grimberg.me>,
        <israelr@mellanox.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <shlomin@mellanox.com>, <hch@lst.de>
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block layer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
        <yq1mufei4zk.fsf@oracle.com>
        <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
        <yq1d0g8hoj5.fsf@oracle.com>
        <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
        <yq1k1affx8v.fsf@oracle.com>
        <e59b2d78-4cf6-971a-1926-7969140d2a01@mellanox.com>
Date:   Fri, 13 Sep 2019 18:20:23 -0400
In-Reply-To: <e59b2d78-4cf6-971a-1926-7969140d2a01@mellanox.com> (Max
        Gurtovoy's message of "Wed, 11 Sep 2019 12:12:08 +0300")
Message-ID: <yq1lfurdejc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130218
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=981 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130218
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Max,

> what about broken type 3 in the NVMe spec ?
>
> I don't really know what is broken there but maybe we can avoid
> supporting it for NVMe until it's fixed.

The intent in NVMe was for Type 3 to work exactly like it does in
SCSI. But the way the spec is worded it does not. So it is unclear
whether implementors (if any) went with the SCSI compatible route or
with what the NVMe spec actually says.

-- 
Martin K. Petersen	Oracle Linux Engineering
