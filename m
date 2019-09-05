Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774BC43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211192070C
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 22:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="g/LW+FG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfIEW04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:26:56 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:62878
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389378AbfIEW0z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 18:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLgVRPFg/ZWGLVMHVNY/KTAgLRrAG7Lps45O5fxDur9s4ougWF8QJcRcnDdDu6kY6U0kz724x7nh1Ovkh2cDcu/lX2/HjLmqiOpF0oumrtaST2yNQwdYCCJim1jnOKTNwVdX5dkmTnRNhdceVFL6emUnt2J1XDyqFOlVjnBlR5/ZxDilID2HzsHPEJ7eNmkGIorLhK5q7CbYy5cVyuPUDDxmIk1oJj/p6xQgbKwCUwJAW5FYPkBW70daj37Zj8+POIKC4EU8yl0pKKBxKQZrBDFr00y0FTX2i3bJlpkALjJgyrMVB8CvF5QO3v323XQKn4nGvkMIDcE6t5KDIxOpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLF665LHxh5cP7R64VSQzFtrBVYsSvCjet2eT+IPmrE=;
 b=Lgltjic8duASR2fA6fCFbTvQSBZdwwLFO4j/I/Zh90dUvqbmKFRW4LPyg8J9MXv8x91bNLdPzwaeUEGiZeOJvpSr+F6JELIMIsbRGU19npRJYlfejsmyc7JCtIb+ZwaV6L+1KE6Vu1ApUuvoqoXWaLCgXbgkW8vv/DGh3oPkVEBSOGHBivxiFlxdCevUoYTcCxt90SQ+S+Q28agaWP7ap51puI0p7nDKvpND3oNBkBsk9pOlBwLyvDevWT2INP4FiX1b5LZZw7hAdZOB0YGDAtatE3LtIuxRWlLPbsSJ6pjNbEbud0Rtv5tINHTZYsq4vuIt5yBXcQVMyU7uiUwrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLF665LHxh5cP7R64VSQzFtrBVYsSvCjet2eT+IPmrE=;
 b=g/LW+FG6GVQRn4U6fJ+y9mH+kmZOugM15g90ObXp0pRqJYU12Ok7K9Oj+D5wWY/tNIYXrmTYkIzK0ha0ogptw82a/ECoftrfCOj5EIxicUkKjBBCPQnhB1LlNXeva+7THEU1mWzhG/xAOJ4F0yrL4Qsbl+qPm8LI3ptwpSJt3KM=
Received: from VI1PR0502CA0002.eurprd05.prod.outlook.com (2603:10a6:803:1::15)
 by DB7PR05MB4283.eurprd05.prod.outlook.com (2603:10a6:5:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19; Thu, 5 Sep
 2019 22:26:50 +0000
Received: from VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR0502CA0002.outlook.office365.com
 (2603:10a6:803:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.14 via Frontend
 Transport; Thu, 5 Sep 2019 22:26:50 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT009.mail.protection.outlook.com (10.152.18.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Thu, 5 Sep 2019 22:26:50 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 6 Sep 2019 01:26:49
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 6 Sep 2019 01:26:49 +0300
Received: from [172.16.0.20] (172.16.0.20) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 6 Sep 2019 01:25:54
 +0300
Subject: Re: [PATCH 3/3] nvme: remove PI values definition from NVMe subsystem
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <linux-nvme@lists.infradead.org>, <keith.busch@intel.com>,
        <hch@lst.de>
CC:     <shlomin@mellanox.com>, <israelr@mellanox.com>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
 <1567701836-29725-3-git-send-email-maxg@mellanox.com>
 <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <75189f9b-3eaf-c676-4096-eb3e9e78993e@mellanox.com>
Date:   Fri, 6 Sep 2019 01:25:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.20]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39850400004)(136003)(2980300002)(189003)(199004)(2906002)(2616005)(36756003)(229853002)(6246003)(107886003)(7736002)(5660300002)(305945005)(31686004)(53936002)(8936002)(81166006)(8676002)(81156014)(486006)(4744005)(356004)(126002)(476003)(11346002)(86362001)(53546011)(2201001)(446003)(65956001)(65806001)(186003)(47776003)(31696002)(16526019)(26005)(336012)(478600001)(106002)(76176011)(4326008)(50466002)(230700001)(70206006)(2486003)(3846002)(70586007)(58126008)(23676004)(316002)(16576012)(110136005)(36906005)(6116002)(54906003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4283;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c800fe6c-e78c-4c06-85d5-08d732502574
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB4283;
X-MS-TrafficTypeDiagnostic: DB7PR05MB4283:
X-Microsoft-Antispam-PRVS: <DB7PR05MB4283D3F4C5CF07F17E998131B6BB0@DB7PR05MB4283.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: niagxElZYOuFseaXC7DsEB3OVzk+59a3l3tzOemDtxv5fL2T2dvd6LdqnzTN7YGgwv3L3rjSXVSeRslnZjlwxk6WAoGdon3EuW8Tvy/wNKyOPQ9unMP7cjqWmxIUjXHOJFY6FZN8D+zLm+jiEEBDEHd/w6w1cHCfSHy/f2s3eG3PDrGT4xO0LHq6rvlwSW+jeV9b0EPUV8TIqEIVnfaq/Q3i0sVUEb47WoK3X9KqXfZrdDvWAqddMVnaPYqdvQHrIKFrQQ110h/f0jVo76Ruj9xl341kytwl9nJqX8QL7682rCF0wMBiBRXiAvn5AnQ1ZTDVHgwpWb8Js7GhRcyxLiLOV7gH/GicErovz5xXll24ZJdkmTR2zTanz5gtEi3lEpBYdzcFYXZ0WkULnudVNfqWUzKhU6T3Vuczasg+XKA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 22:26:50.0267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c800fe6c-e78c-4c06-85d5-08d732502574
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4283
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/5/2019 11:52 PM, Sagi Grimberg wrote:
>
>> Use block layer definition instead of re-defining it with the same
>> values.
>
> The nvme_setup_rw is fine, but nvme_init_integrity gets values from
> the controller id structure so I think it will be better to stick with
> the enums that are referenced in the spec (even if they happen to match
> the block layer values).

according to the spec:

"NVM Express supports the same end-to-end protection types as DIF. The 
type of end-to-end data protection (Type 1, Type 2, or Type 3) is 
selected when a namespace is formatted and is reported in the Identify 
Namespace data structure."

This is exactly what this patch does.

