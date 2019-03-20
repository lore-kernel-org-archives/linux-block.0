Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05035C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A222184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 09:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="NxHW3nlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCTJRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:17:45 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:64484
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfCTJRp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 05:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0sq4aCZBERPCtTevGNnB6qRb97CHQmt0zXkoGRfFzQ=;
 b=NxHW3nltXCmmX5muNOx2mveEcYL1jXkLjKqpJ+KaR2mgeDk1sAhTgistfbXWlhpH0SGjUnOoaxL0MnB/SdHEow+sEaFxLMxDTIbpEoV9KrmcwhEPRtYrKEupJWMJCooL9iav6TpoTIz8rabtVuK3e6GFv0C58xVvuzFT75O/AnI=
Received: from AM3PR05CA0150.eurprd05.prod.outlook.com (2603:10a6:207:3::28)
 by AM4PR0501MB2627.eurprd05.prod.outlook.com (2603:10a6:200:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Wed, 20 Mar
 2019 09:17:41 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by AM3PR05CA0150.outlook.office365.com
 (2603:10a6:207:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.15 via Frontend
 Transport; Wed, 20 Mar 2019 09:17:41 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1730.9 via Frontend Transport; Wed, 20 Mar 2019 09:17:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 20 Mar 2019 11:17:38
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 20 Mar 2019 11:17:38 +0200
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 20 Mar 2019 11:17:36
 +0200
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Yishai Hadas" <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        "Tariq Toukan" <tariqt@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
 <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
Date:   Wed, 20 Mar 2019 11:17:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(189003)(199004)(230700001)(53546011)(316002)(50466002)(446003)(110136005)(65826007)(31696002)(2201001)(106002)(47776003)(8676002)(16526019)(5660300002)(356004)(36756003)(186003)(6116002)(336012)(93886005)(3846002)(64126003)(229853002)(106466001)(54906003)(58126008)(16576012)(31686004)(81156014)(81166006)(77096007)(486006)(8936002)(26005)(23676004)(126002)(2616005)(6246003)(2906002)(4744005)(2486003)(76176011)(305945005)(2501003)(65806001)(65956001)(67846002)(86362001)(4326008)(7736002)(11346002)(478600001)(476003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2627;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55bc57aa-8ecf-41e4-8ad4-08d6ad14e78d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2627;
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2627:
X-Microsoft-Antispam-PRVS: <AM4PR0501MB262724B00624803E02894814B6410@AM4PR0501MB2627.eurprd05.prod.outlook.com>
X-Forefront-PRVS: 098291215C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WLJS4luNeZwzR6QtQwyeeSQVXH1ATDlOWxqZHVeTC4ixWijAGUR5PJVFJWSBnaI6X1A8cTQDvx+GRMrgIk9Sm0Kt5WtkLDfbnS1mV1NLXzfZBqoO936qCm4M7YmsW4jPQoOGmsmMkq4UzKJpPn/xOp52XnKrUrevfVDPAEW5X4ntpP0zUKRybv8ly99sIWqZrGC/QmKAjJb3qHQ2x8g8R96ASQLmqPTm8MJoB2geOXNHIoE5MCNDxipdYCB/SaWcwo1RaqoKxrtSrlGkNIcdh+DD5gVL49BXBAK9qr+b2i4PQ6A0LyplszcgtPqEUyolFMNFZgnF7ivQSIw8lG273CcXQPxJ2W//QUezKnpQxN2GS+8oMYl3irfYkIPu8uQmvoe04lKY6nhVHTMI3Pb3RfTt4U+4cfEmykUA2+dGTSE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2019 09:17:41.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bc57aa-8ecf-41e4-8ad4-08d6ad14e78d
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2627
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/18/2019 11:34 PM, Sagi Grimberg wrote:
>
>> As we discussed, let's check with RDMA maintainers if it's better to 
>> extend alloc_cq API or create alloc_cq_dim API function.
>>
>> Sagi/Christoph,
>>
>> how about adding a module param per ULP ? as we use register_always 
>> today, create a use_dimm module param for iSER/NVMe-RDMA ?
>
> I would say that its better (and simpler) to do a global sysctl knob for
> it. No need for a per-ULP param for a starting point.

for sure it's simpler, but in this case all should agree that in case we 
run more than 1 ULP in a server, all of them will have the same 
configuration (no QoS).

are you suggesting something like:

/proc/sys/rdma/mlx5_0/dim

Jason/Leon/Doug,

thoughts about the best way to configure this feature from your 
perspective ?

