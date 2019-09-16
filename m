Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E526AC4CECE
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA33214D9
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZrCMRNMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfIPRWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:22:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfIPRWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 13:22:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHJ1v8030790;
        Mon, 16 Sep 2019 17:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=cv+DwWu9qoA7iqv3H2CpGW617J3RoXHp/vizYrY+tpY=;
 b=ZrCMRNMBnZlDrtqwP8+dWglJrV2cGcPJexJJOkZWUlOaXHwOmKWyhKw1v79KTFHsHQ4t
 tRVXhGRos4gX2mYvfqLgWKO69LEq7POoj/KBvsUozw6QIb6QVczGByQALTVGRfw3/rha
 5/p3LEu9DDdm+xgb3qLe/tJYhSg0jER2apZMeGhZV2PoSTJcNu2DyA2mPwM99gaEt30b
 Lxu3sC2GzLh7h+pyG0ZbPtDpH5YV/3rkRky0wmMfwd7cPe6C28EKm6dQzQ0zmODPakJd
 RXiH+E6yQhjsE6mqvghJeXymtVoZE7Gg+Re5EX9L0rJ3Eq8hJuLRURKboZXZRsfSuhfG fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v2bx2s5nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:19:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHIngj084270;
        Mon, 16 Sep 2019 17:19:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2v0p8uwmbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:19:54 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GHJsEq014272;
        Mon, 16 Sep 2019 17:19:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 10:19:53 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>, axboe@kernel.dk,
        keith.busch@intel.com, sagi@grimberg.me, israelr@mellanox.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        shlomin@mellanox.com
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
        <yq1lfurdejc.fsf@oracle.com> <20190916080328.GB25898@lst.de>
Date:   Mon, 16 Sep 2019 13:19:51 -0400
In-Reply-To: <20190916080328.GB25898@lst.de> (Christoph Hellwig's message of
        "Mon, 16 Sep 2019 10:03:28 +0200")
Message-ID: <yq17e68b1l4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=795
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=870 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160172
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> Do we actually have Linux users of Type 3 at all?  I think for NVMe
> we could just trivially disable Linux support, and I suspect for SCSI
> as well, but I'll have to defer to you on that.

There were several companies looking into building Linux things using
Type 3 SCSI devices. No idea whether this happened. I definitely still
get lots of mail from people using Type 2. Something which also really
shouldn't exist outside of a disk array.

For NVMe, I assume nobody has tried Type 3 given the discrepancy between
how SCSI works and how the NVMe spec is currently written.

In any case. Since Type 3 is a pretty trivial subset of Type 1, I don't
see much benefit in actively removing it. One could argue we could
reduce the plumbing by removing a level of indirection. However, we'll
need the infrastructure to support the impending Type 4 as well. So my
preference is to just leave things as-is for now.

-- 
Martin K. Petersen	Oracle Linux Engineering
