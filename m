Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F2C4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5B621920
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EDZB2fyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfIINbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:31:38 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:23944
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbfIINbi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 09:31:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU6FporQoNrEEynHpQMqldcBBBHK1tkCbd4/9OGb6L35HKq2an6858G/vGLS59L3ZmSaac9ySZJjWJCEOWGiWgHlti5K+LgMzEuo29ytK1nGBxDvLMEWgZFqJjY72pucGL3q1i1XOhOWQfjqedp/Xxt54dl19meP5FsAiDaKawnaB7b2L4E3TqmN5KFttKWr5SZtLTt2rF1uGLDP2YCflIm0W+0DMfi9fXLDZuigSG4XuotVxiQedeoD190ZHPa1sd1rxynuyNSO62M9dna8pAbz/HTXcQHoaPt+RTIGB81yChs5TiUhcpT8s2WRawX3fE2UMfD+sXDdSerokcHn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykq9r9bLB3qMfBTRpuxDJzytvdhzyfe6K6BtQtKvWeE=;
 b=OpXLXpaV3ipE4Vw2bc6beTWvtvVaoCfnamaVXobpAv3VchpeeMFtoYoPPTkuzbDmzKOIHrP7Fx3IfIBdrCvuevB+vpiXC9Qu4rXiz8A2saWRfeGtozEaHAiXwpz5ntrOrJTd7ckYaj5socgBVRtyyzE/CDdZqV0C9dmd6IZBMJeWLPwxqQDabID9lRLH55I6+vx8gSCRd9Ju+D3s6dWif7uumLGqiOE9jHo0NqLQ1EW1pA53Wk6OP2m+hQAPqmHhMblVTR1LoSRGLobsDOZPS4+QujhkjhZlBWhkzSsFJ+vxJBKuORvb36CqlVkMJY31CPUOYGX/W1U1AjfClBv6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykq9r9bLB3qMfBTRpuxDJzytvdhzyfe6K6BtQtKvWeE=;
 b=EDZB2fyLQTrc5fgZSsMcotGcULMFM3JZE+mwiAcv5S9iscgzUOzvfOcUPfI8zbL0fXmltsAmXaY4D+qFVGHD9/bGMie3CRZDjdyOjfT50YI8a2oNASAbht8xpcm4ourT6/DvB3ojeEkGZaZsxHjFxA37H2TdYZwCb//2AWpcp+g=
Received: from DB6PR0501CA0031.eurprd05.prod.outlook.com (2603:10a6:4:67::17)
 by VI1PR05MB6112.eurprd05.prod.outlook.com (2603:10a6:803:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14; Mon, 9 Sep
 2019 13:31:33 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by DB6PR0501CA0031.outlook.office365.com
 (2603:10a6:4:67::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.15 via Frontend
 Transport; Mon, 9 Sep 2019 13:31:33 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Mon, 9 Sep 2019 13:31:32 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 9 Sep 2019 16:31:31
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 9 Sep 2019 16:31:31 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 9 Sep 2019 16:31:28
 +0300
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
CC:     <axboe@kernel.dk>, <keith.busch@intel.com>, <sagi@grimberg.me>,
        <israelr@mellanox.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <shlomin@mellanox.com>, <hch@lst.de>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <1567956405-5585-2-git-send-email-maxg@mellanox.com>
 <yq1ftl6i4xx.fsf@oracle.com> <20190909023601.GA6772@keith-busch>
 <yq136h6i3qb.fsf@oracle.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <36eb14e1-0070-881a-fc3d-9fbb55d2cdfc@mellanox.com>
Date:   Mon, 9 Sep 2019 16:31:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq136h6i3qb.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(446003)(476003)(26005)(2616005)(2906002)(70206006)(70586007)(50466002)(36756003)(478600001)(230700001)(31686004)(2486003)(106002)(23676004)(6116002)(3846002)(4744005)(5660300002)(31696002)(86362001)(8936002)(81166006)(81156014)(8676002)(305945005)(53936002)(7736002)(486006)(356004)(316002)(65956001)(47776003)(54906003)(65806001)(58126008)(16576012)(6246003)(110136005)(4326008)(16526019)(561944003)(229853002)(186003)(11346002)(53546011)(336012)(126002)(76176011)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6112;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a732eb7-2391-490f-5b96-08d7352a07d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6112;
X-MS-TrafficTypeDiagnostic: VI1PR05MB6112:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6112A9AD6A8300E124EE46F4B6B70@VI1PR05MB6112.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 01559F388D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3a8cZcNj3ZFMZZI5G3xMzLK/QVB/A2whyP1TptJILY7K4ZrDVKSjDiLYOcfvh/IToswIUiPwGLeSp+ZAReGXGwPKygG8OHyWiwSSxSSviC431j/aQdSMHWiAThmnoZJ8h/Wf5Iwmadut8/o+zXSqIeoaUMjhrkpmS+z6DD8nHjTnW89H2UxZBYg78gEgAy0tSKDf4awORN5vdYTorIOIGmNhsxdgKbAULJdVWE/9xSAyUUD3xpmYCH6X+ytWy4FUWkOAydA7/u7pP4abHt49X9a071qewqPegVqtZ9XXzONTdt4UM7rRVK0esZYozDKwXngEGcI5KIk92znQGoGGXX/sUqTQ9/vejvShy0EJI7n+E+m/podtcYf4CY0kmBf/FUqbU47+iEWZ8dwPj2eDKBYbgJrjyy0RUooETccg86M=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2019 13:31:32.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a732eb7-2391-490f-5b96-08d7352a07d0
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/9/2019 5:49 AM, Martin K. Petersen wrote:
> Keith,
>
>> At least for nvme, type 0 means you have meta data but not for
>> protection information,
> Yeah, NVMe does not support DIX Type 0.
>
>> so remapping the place the where reference tag exists for other PI
>> types corrupts the metadata.
> But the device shouldn't have an integrity profile in that case (see
> previous mail about why keying off of the protection_type is a problem).


I see. Ok I'll not handle NVMe type 0 in this patchset.

There is no kernel implementation for that so I don't see a good reason 
doing so after Martin's proposal.

