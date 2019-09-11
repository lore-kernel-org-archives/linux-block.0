Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37302ECDE20
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 09:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50F621928
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 09:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="RFLi5C4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfIKJMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:12:16 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:63360
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbfIKJMQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 05:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCWbemChoGSVWwA4p2nHqYJrB6JCW4QVYfLAPasttONEeLW/dKCYywKGgaWKwyZejOzYDbGv3FA2JOjaHV3Npeem1elOeiJse/xAKX7X8f4zGhmYbAdjOeveRtXhpIVTpREQ5OyOOeQnd4/ilZG3+9vkpA7PvZoAJErvn1Z5H2X5Bp0/PdnL7UmL4o1cdKwt9nv6GFOQXs+n3VAEoCncU/KpBeAJvCxRGzlrp8G1mqTbOoHzRshNgrXltsJYaDen6TySozwRnRupIIDGMHCSsaV83SUm/GyWIVnFvKidIc5d9bE9kT1HTjtYEeZino/D7xu2XQKBRgF9SnBjEVgu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubbXKUd1bdbtHqW2UB1mLwwKZ7ch1HiuZJdOsQU+tco=;
 b=V7K/9y1Hv3JvjEu4Zu0fS/IWCCZEUIuUyLzdS1s4KlJWdfxtq1x0LZ0cDyWXdkmonISuLI023dwCalRWvzftKvUctvxybxErIjmk+HZRxD5VyK3PgOLX4fYAxByAtIdn/bkDyASboSOuEdXg7RmioORuEtOwic5Ulgi7kpuO6Qwh2nvkTDuL3a93CrYX+8oLQsbceha1ZQV8/HVrPhUQG33BFQsG5zEBvfKFEsTyUmo2vat5qJYEaWwqmL+bSkZkEg++Ag/cWCebrWyFmYjxLLBU33v6w8WYGq+IxVPBGbMw4T529rZMaQSdW2p9c+hjL1iAi82Ull47g/bN9cHEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubbXKUd1bdbtHqW2UB1mLwwKZ7ch1HiuZJdOsQU+tco=;
 b=RFLi5C4fob6+X27WH2EpiBTgEXXezkKm2jrmMiA2A0F5MwXJaVgGmYmxHaWovq2gFjn0F9sRokODFhCWmeoet6ZKj4emQIwkh/M/w4Fr6clNHb1CepumntQ1A8eV1YOZseLFgVTM/qBVm/j/vKIw3FjRJcnqwGL2t4MEX1z3ecs=
Received: from AM3PR05CA0116.eurprd05.prod.outlook.com (2603:10a6:207:2::18)
 by VI1PR05MB4382.eurprd05.prod.outlook.com (2603:10a6:803:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.13; Wed, 11 Sep
 2019 09:12:11 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by AM3PR05CA0116.outlook.office365.com
 (2603:10a6:207:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Wed, 11 Sep 2019 09:12:11 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.14 via Frontend Transport; Wed, 11 Sep 2019 09:12:10 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 11 Sep 2019 12:12:10
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 11 Sep 2019 12:12:10 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 11 Sep 2019 12:12:08
 +0300
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block
 layer
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <axboe@kernel.dk>, <keith.busch@intel.com>, <sagi@grimberg.me>,
        <israelr@mellanox.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <shlomin@mellanox.com>, <hch@lst.de>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <yq1mufei4zk.fsf@oracle.com>
 <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
 <yq1d0g8hoj5.fsf@oracle.com>
 <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
 <yq1k1affx8v.fsf@oracle.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e59b2d78-4cf6-971a-1926-7969140d2a01@mellanox.com>
Date:   Wed, 11 Sep 2019 12:12:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1k1affx8v.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(199004)(189003)(53936002)(106002)(36906005)(11346002)(229853002)(230700001)(81166006)(305945005)(26005)(76176011)(58126008)(16576012)(7736002)(2906002)(316002)(6916009)(53546011)(31696002)(54906003)(31686004)(86362001)(14444005)(65956001)(8676002)(47776003)(50466002)(23676004)(16526019)(356004)(65806001)(3846002)(6116002)(8936002)(4326008)(5660300002)(476003)(126002)(446003)(70206006)(2486003)(70586007)(478600001)(81156014)(336012)(486006)(186003)(6246003)(2616005)(36756003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4382;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3969b29d-2644-4af2-4bd8-08d7369820e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4382;
X-MS-TrafficTypeDiagnostic: VI1PR05MB4382:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4382751AEBA632DA8A0BF869B6B10@VI1PR05MB4382.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0157DEB61B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lmaJxtS6W/E8XBXZFRwl049tgq8gpxgWqNY37WhB1367g5gYSUpFPMnRbFQflPMUxl1ipumXFwZw4hSPz2pdU8vG/xPo436lhyjbtjbFWAbuQJKkCsZYVC4e1cGmxeYs43ajYPHeT6cIdMUZ6i2jEDkpoq330RkrhlwKKyDETfakV/la01Y+B0GEyWzbdH4R7zCDQ3EyVbHVifq7DYvlibYsvQTleienygqk68GVGhDSKYRzB5/djbpbRLMX0SFNKA5XsY0yCpyqFwCUF8sLRmR4bDSgeY3ygf9+29bsd8/dsPdAFcdQKptVRQPQ70xITyiKGxJHtEwPck6sQGF5qNCioI4qUM6P3MWNXYD2dkRc7pDex/c+gCKuC/W+B4ghO/AqUGqenY4fLJKjZPKfINVuF5T+7gUyC3KmLtDkiO4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2019 09:12:10.8591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3969b29d-2644-4af2-4bd8-08d7369820e9
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4382
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/11/2019 4:16 AM, Martin K. Petersen wrote:
> Max,
>
>> I guess Type 1 and Type 3 mirrors can work because Type 3 doesn't have
>> a ref tag, right ?
> It will work but you'll lose ref tag checking on the Type 3 side of the
> mirror. So not exactly desirable. And in our experience, the ref tag is
> hugely important.
>
> Also, there are probably some headaches lurking in the slightly
> different app/ref tag escape handling if you mix the two
> formats. Whereas Type 1 and 2 are 100% identical in behavior if you use
> the LBA as the ref tag.
>
>>> Anyway. So my take on all this is that the T10-DIF-TYPE1-CRC profile is
>>> "it" and everything else is legacy.
>> do you see any reason to support the broken type 3 ?
> Only to support existing installations. We can't really remove it
> without the risk of breaking something for somebody out there.

what about broken type 3 in the NVMe spec ?

I don't really know what is broken there but maybe we can avoid 
supporting it for NVMe until it's fixed.


