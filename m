Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F0C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC6620693
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="l7lBH2Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCNJ7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:59:03 -0400
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:18697
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfCNJ7D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 05:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah5q6aOSD9cef5feim6jRzNwhJFcK3/aGJUoCyJozu4=;
 b=l7lBH2OitDSsnWr3tznosDbF6nUVDjwkG2UP+hXxTwskBpst1X4AHkPz/lSbuvjCSm1+o8oqu5MaZ/h72L9E9dRWkCHV+789gw+BOt56Y32gZzYHt3fEpU6VEZvUc+GIQ2u9Ve5lQ3uRNwDe8+g8zvCnX/80B/XquxhwyxEgboo=
Received: from HE1PR05CA0191.eurprd05.prod.outlook.com (2603:10a6:3:f9::15) by
 AM0PR05MB4562.eurprd05.prod.outlook.com (2603:10a6:208:b0::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 14 Mar 2019 09:58:59 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by HE1PR05CA0191.outlook.office365.com
 (2603:10a6:3:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Thu, 14 Mar 2019 09:58:58 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1709.13 via Frontend Transport; Thu, 14 Mar 2019 09:58:58 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 14 Mar 2019 11:58:57
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 14 Mar 2019 11:58:57 +0200
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 14 Mar 2019 11:57:56
 +0200
Subject: Re: [PATCH 07/17] nvme-fc: use nr_phys_segments to determine
 existence of sgl
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-8-hch@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a488077e-d68e-a388-4d45-5b966f01f96e@mellanox.com>
Date:   Thu, 14 Mar 2019 11:57:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190313175510.20725-8-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(199004)(189003)(5660300002)(356004)(106466001)(50466002)(36756003)(2486003)(23676004)(229853002)(4326008)(47776003)(65956001)(65806001)(6246003)(64126003)(76176011)(8676002)(446003)(86362001)(336012)(316002)(478600001)(16576012)(58126008)(110136005)(81156014)(81166006)(65826007)(476003)(2906002)(11346002)(2616005)(486006)(126002)(305945005)(7736002)(26005)(77096007)(53546011)(230700001)(3846002)(6116002)(31696002)(54906003)(8936002)(31686004)(67846002)(106002)(186003)(16526019)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4562;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60da4ead-f7b3-4854-8dc5-08d6a863ad8a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4562;
X-MS-TrafficTypeDiagnostic: AM0PR05MB4562:
X-Microsoft-Antispam-PRVS: <AM0PR05MB4562629050AB5E360B86759EB64B0@AM0PR05MB4562.eurprd05.prod.outlook.com>
X-Forefront-PRVS: 09760A0505
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2vekz4vz0NUyG2yOk9YPJA1Ig7IVK7yMPKxb/nMP3sglR2xeJs7rrEGxxS5Gw68JRZocv/wjlNu/4oyZUxmZSAQsoWPq5oUG9KDPd5BV6luNHTlpFOITRgxDHDYO1FECNiPYTSZZ3fsfCH6UNT4sHZFBth4dYsbrvDkQ4oHGB31J8LHOfkFf6uDlF9Al5moflqFoxykb5dQYuvnvSO0lUTY9R/IKZPeDm0yf8eXCU6JnYmOgminquubm9+DZESppfGlfmFg64GLinEwIa3S8Zs5ljH3x5EwTzcFOALnWcFbqxTt5rmK8RGioBSkz18Ur0+FAm8QxqIaOhsw6jTGLWGU49B4OFE0qAALCfnBVU26Nuxe+YhbPaFio8zKMRP4nQcZwYmW/b0fgqPKI/KsYKpccLnPEdU9hWDaSiR8/BZA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2019 09:58:58.4162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60da4ead-f7b3-4854-8dc5-08d6a863ad8a
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4562
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/13/2019 7:55 PM, Christoph Hellwig wrote:
> From: James Smart <jsmart2021@gmail.com>
>
> For some nvme command, when issued by the nvme core layer, there
> is an internal buffer which can cause blk_rq_payload_bytes() to
> return a non-zero value yet there is no actual/real command payload
> and sg list.  An example is the WRITE ZEROES command.
>
> To address this, when making choices on whether to dma map an sgl,
> use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes().
> When there is a sgl, blk_rq_payload_bytes() will return the amount
> of data to be transferred by the sgl.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


I guess we'll need it for all transport.

I saw that pci is covered, RDMA isn't.

Also IMO tcp should be fixed (didn't dive into it yet, just high level 
check for blk_rq_payload_bytes).

may we should have a core function for it to reduce code duplication.


