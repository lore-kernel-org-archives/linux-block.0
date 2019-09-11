Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DFC49ED7
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 01:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2545A20872
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 01:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2d4RXQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfIKBRL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 21:17:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfIKBRL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 21:17:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B1E3gx081074;
        Wed, 11 Sep 2019 01:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=VW6NQiLrb7n2pHcWqpWBPIO16ZVy6fIAW1nnemdhT+g=;
 b=W2d4RXQI704f78e3bazF325gUq5nSExcM8L/MYUTAKI74XCFvNKEYCx5wCWvHzHvYofz
 u3A81ju3LxDcJyx6dAkeAP781PciE2tYDlOx2FODMuFpaARbY+vta6wqL1s7ZOsQBWTu
 wTEyVOMhWKZ98s4CeS8ELQuPTBbjwGuYWAcr7uWVvTAPOjzD+eJHHXFa9QkwvkaMSZIB
 R8eP1Gf+Zp4GX9GKR7f4PXysnvGTGG1EiANP2u3WxKVdV9+G2mBrFkJEIlKB7SjPVDtb
 n4JfHlIHN8yOwKa5PnuVCr60TtAvNgt8WQYsJYitGtAVMmuztUH4GbYRpM5kxdDi2ngR DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jy6rpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 01:16:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B1E5kV060189;
        Wed, 11 Sep 2019 01:16:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uxk0snpkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 01:16:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8B1GZeF028961;
        Wed, 11 Sep 2019 01:16:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 18:16:34 -0700
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <keith.busch@intel.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <shlomin@mellanox.com>,
        <israelr@mellanox.com>
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block layer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
        <yq1mufei4zk.fsf@oracle.com>
        <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
        <yq1d0g8hoj5.fsf@oracle.com>
        <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
Date:   Tue, 10 Sep 2019 21:16:32 -0400
In-Reply-To: <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com> (Max
        Gurtovoy's message of "Wed, 11 Sep 2019 01:27:29 +0300")
Message-ID: <yq1k1affx8v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=658
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=724 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110004
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Max,

> I guess Type 1 and Type 3 mirrors can work because Type 3 doesn't have
> a ref tag, right ?

It will work but you'll lose ref tag checking on the Type 3 side of the
mirror. So not exactly desirable. And in our experience, the ref tag is
hugely important.

Also, there are probably some headaches lurking in the slightly
different app/ref tag escape handling if you mix the two
formats. Whereas Type 1 and 2 are 100% identical in behavior if you use
the LBA as the ref tag.

>> Anyway. So my take on all this is that the T10-DIF-TYPE1-CRC profile is
>> "it" and everything else is legacy.
>
> do you see any reason to support the broken type 3 ?

Only to support existing installations. We can't really remove it
without the risk of breaking something for somebody out there.

-- 
Martin K. Petersen	Oracle Linux Engineering
