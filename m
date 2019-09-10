Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983C8C49ED9
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 22:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A312168B
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 22:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HdwIZHJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfIJW1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 18:27:47 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:7302
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfIJW1r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 18:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUm4cegM5hwezL89nw06mCo+ib1ZZNC3BSw30e2n39b57dyzxgSZaH110H7q/gPABTSXHLgolpI+9r3UNAIIHGjD1cVHsWjBcrzVFEgvbRXv29lltCtKTHUyHcixoTm+dOlQKowBmnLgG5Th9x6A1yMdQMpYPjCaqD5U+ApDJn3apkQAZGfqmNQS+93tNUu2C4ZJIoMMG5mQQjbCVg9P5mDWMa5mlnH5ZtmaTtL4lLMNDd+Ciylu9k08mgiQp3fuKZbZGRTy4+nXA6ABZeGUeGWm80/r2GnIZP9xpnQp6D3BXPpQbXioE95k9RUnCBvoVNGasvibEzOwQrd51Ozs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueuqhc/E9CCt8XZTnfi6ZGUiaA3iPjH6jHyYwtDZ/CM=;
 b=FxhpgTR3G9MJIVrbHbz7JaD8eBI4g7Sq26deCH/fRO4Jo8XLonIFdEIEEkdkjQzYBLKMjeJXWVppjBoRRPUR853by4vv6mzRtt8V5AFMHNOLSxHyuRyEy1fbRT8uYOoxZXiJrCTtm3XldGHndvzsEFL7dmXvKCuY0fcYLftZP/8Tt1654OgiQwlwc2+z81cZaCObB1UcRNi27xVqpYw0ZlV/HQ21Ogs6Tqaas978i0YHB6CLDkeQwka3TA9bRyjjEpOQbJV+k4l8NEBgtmq4LLXwmHY8nfhkhX1cSBlFs++PWtCcHYQeoF8ejfhYLksE0QazIxN4DoyqksbLlBv5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueuqhc/E9CCt8XZTnfi6ZGUiaA3iPjH6jHyYwtDZ/CM=;
 b=HdwIZHJ0Q2vh8DcWz269X3P/+KOuqqOFKb8sVIUNFIbkvnwbVc5fs8xI6clcOFYf6VZxPnaAOsYSV8IrdZH5jJD2waev1/lXY1LsyYgdf2Y/IcJbaurm6jwIaH/uZ4IUgSKhpwmO+W/DwgeEHrlqr4rgv23fHFihZFKhMbHuDhU=
Received: from AM6PR0502CA0059.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::36) by AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:47::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Tue, 10 Sep
 2019 22:27:42 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by AM6PR0502CA0059.outlook.office365.com
 (2603:10a6:20b:56::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14 via Frontend
 Transport; Tue, 10 Sep 2019 22:27:42 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Tue, 10 Sep 2019 22:27:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 11 Sep 2019 01:27:40
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 11 Sep 2019 01:27:40 +0300
Received: from [172.16.0.16] (172.16.0.16) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 11 Sep 2019 01:27:31
 +0300
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block
 layer
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <keith.busch@intel.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <shlomin@mellanox.com>,
        <israelr@mellanox.com>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <yq1mufei4zk.fsf@oracle.com>
 <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
 <yq1d0g8hoj5.fsf@oracle.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
Date:   Wed, 11 Sep 2019 01:27:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1d0g8hoj5.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.16]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(199004)(189003)(51914003)(53936002)(36756003)(16526019)(2616005)(476003)(26005)(356004)(186003)(53546011)(478600001)(4326008)(126002)(3846002)(8936002)(305945005)(230700001)(65956001)(50466002)(7736002)(86362001)(81156014)(65806001)(31696002)(70206006)(81166006)(8676002)(6246003)(6916009)(31686004)(336012)(11346002)(446003)(6116002)(70586007)(229853002)(486006)(2906002)(16576012)(54906003)(316002)(58126008)(23676004)(2486003)(76176011)(106002)(107886003)(14444005)(5660300002)(47776003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d426a94f-1d45-4a2f-1c69-08d7363e1841
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR05MB4454;
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Antispam-PRVS: <AM6PR05MB4454D4CC705C3884201FB67DB6B60@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01565FED4C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RsoYQRowWKrgsqvcIq2SRweTdErTHW/yNC4sDIBWInGRHPS+jdtUIMn9GO35dYXZWr2LCq8pjiJ/4QMLr0N4HzI3we7ORYH2GQKvc4Fo9XqkG0WUYPLakUm8FrpGc9n4HCBoCVeBQEerN0NErD7u5dBt3uDZzIboeGri8xYIzFU6xxiiECt4cyOraebgWpl8vkNp9IHqnbXTEx1YafNAykijpbgsQOEU58c5VxKE7aFR6wiJwAYsKinhNeFVEySJdLjmztES9FID8DqNFpSN4CSI7/qW9Avfb4q88qmVCo49Kl9R5Pa+lzSdqt9D+br39ZqjpCfodFrT+gJOjydZYp47C7GXcAQ/0xxxpjFJ/7NyAY1Eux/Klg6BO2b+65NkMcWmgda8TegRKmiPrhpLq6FXD/XUWE3YtTi/dQafItY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2019 22:27:41.7315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d426a94f-1d45-4a2f-1c69-08d7363e1841
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/10/2019 5:29 AM, Martin K. Petersen wrote:
> Max,

Hi Martin,

thanks for the great explanation !

>
>> maybe we can add profiles to type0 and type2 in the future and have
>> more readable code.
> It's a deliberate feature that we treat DIX Type 0, 1, and 2 the
> same. It's very common to mix and match legacy drives, T10 PI Type 1,
> and T10 PI Type 2 devices in a system. In order for MD/DM stacking,
> multipathing, etc. to work, it is important that all devices share the
> same protection format, interpretation of the tags, etc.
>
> Type 2, where the ref tag can be different from the LBA, was designed
> exclusively for use inside disk arrays where the array firmware is the
> sole entity accessing blocks on media. And thus always knows what the
> expected ref tag should be for a given LBA (typically the LUN LBA as
> seen by the host interface and not the target LBA on the back-end
> drive).
>
> For Linux, however, where we need to support dd'ing from the device node
> without any knowledge an application or filesystem may have about the
> written PI, it's imperative that the reference tag is something
> predictable. Therefore it is deliberate that we always use the LBA (or
> a derivative thereof for the smaller intervals) for the reference tag.
> Even if T10 PI Type 2 in theory allows for the tag to be an arbitrary
> number. But Linux is a general purpose OS and not an array controller
> firmware. So we can't really leverage that capability.
>
> Also. Take MD, for instance. The same I/O could be going to a mirror of
> Type 1 and Type 2 devices. We obviously can't have two different types
> of PI hanging off a bio. Nor do we have the capability to handle
> arbitrary MD/DM stacking with PI format properties potentially changing
> many times within the block range constituting a single I/O.

I guess Type 1 and Type 3 mirrors can work because Type 3 doesn't have a 
ref tag, right ?

> That's why we have the integrity profile which describes a common block
> layer PI format that's somewhat orthogonal to how the underlying device
> is formatted.
>
> There are a couple of warts in that department. One is the IP checksum
> which is now mostly a legacy thing and not implemented/relevant for
> NVMe. The other is Type 3 devices that need special care and
> feeding. But Type 3 does not appear to be actively used by anyone
> anymore. We recently discovered that it's completely broken in the NVMe
> spec and nobody ever noticed. And I don't think it was ever used
> as-written in SCSI (Type 3 was an attempt to standardize a particular
> vendor's existing, proprietary format).
>
> Anyway. So my take on all this is that the T10-DIF-TYPE1-CRC profile is
> "it" and everything else is legacy.

do you see any reason to support the broken type 3 ?


>
>> I think I'll prepare dummy/empty callbacks for type3 and for nop
>> profiles instead of setting it to NULL.
>>
>> agreed ?
> Sure. Whatever works.

I'll send the patch tomorrow for review.

-Max.

