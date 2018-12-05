Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA98C04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072BF20850
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWqoVpfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072BF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLEC4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:56:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34668 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLEC4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 21:56:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB52ru87161541;
        Wed, 5 Dec 2018 02:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=JFzBr3JQOQObjsFDTERj6Za7ppYxdGfQ7lP/EYzGgAQ=;
 b=LWqoVpfn+syqB73+UcsWLLC3OwQQAO0VSM3ZRtSL9juWmnd9KEFuuOqURB62AvgbU7k9
 XLR8UY2HiWyOtVyCP/eGVNKhvxEHqd2F6c1xmxtwOMmRL1GP7Q38BVixXaUsZkfYf27x
 37EirxShnR8de2b84pvHCZRtcXmUP0c+rBsfx7aZw+alUUBEEMzQKdY4c4ih67TeoeOz
 F3+0wUmZ2zta2S5ZJcSHN/QeKRqtz9LChMXvqgjAMGwQE1utMqLgYUyB40Vm9IrH+3oT
 MjD/DX9IeyqGtwgvJ9enXIG+8CI+EaFIHu3R6hcbjE3mix99uhPqJ1LJbxoTQVYKZDWx jQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqtyxqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 02:56:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB52uKCZ000344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 02:56:20 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB52uJMO001858;
        Wed, 5 Dec 2018 02:56:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 18:56:18 -0800
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "chenxiang \(M\)" <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
        <20181127130811.GA2780@ming.t460p>
        <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
        <20181130011935.GA7573@ming.t460p>
Date:   Tue, 04 Dec 2018 21:56:15 -0500
In-Reply-To: <20181130011935.GA7573@ming.t460p> (Ming Lei's message of "Fri,
        30 Nov 2018 09:19:36 +0800")
Message-ID: <yq1tvjsr8a8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=629
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050025
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> For DIX/DIF test, I think you need to pass 'dev_size_mb=XXX' instead of
> 'virtual_gb'.

Correct!

-- 
Martin K. Petersen	Oracle Linux Engineering
