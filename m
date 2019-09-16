Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C872C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A17620678
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZfP+j118"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfIPQVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:21:30 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:9454
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfIPQVa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 12:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwdiVXdrvdPy9aq1onkINzsUV4A92dwjdkkjizqSgbQq1CmsMHCPpVQ3IUw8c7M8rBmt61O9wcgJ1C85DUCXxTr3l4TAj006H2Akf9IOAXM6jT6bB0S+I1fOV4fNwSMM2D5AjV/018u7XZYB5qhqeIqDKZqyE8NWmMfA4iBhuL89i6hDoYeniAP7TnacIbgt6Jnid9Dv5yohaM+nYHjXHLM8C9rFIb67AetXGdmnTnEntgvVwHrznVJASiJLGO6UkKR2i7JROZ07rzvNkE/ecO/hBtYAGr0QM28nV7Wl6uiYuYG44tiIY8f4hTkmK8zXYZf48zJThb2/p4F/Y2XRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWK2jW4Qz2i8nKnV4GFc/QvDTGy54eZN1NXrigwSs28=;
 b=iavJt6bf1H1pRGap0ynzDNRaryqJpVJoTRWcsqmy+CeFt/529S5lM1Iw5UlxrBDyFLCS2pQGNtYsLNv4OnzDw1uT4Yhi0ZIb1JxXiEm4qWuiq0QamzDe5WaJYz/lI6Z1Fv8lDxh5BJ5CtmgI/IaTc0A6Lr9egMF6C2wj8pBJNxJLB9bInchG5+zh8cjHZnaPzWhUHkndLKZykXkKUhOBSwKDAdu2vvemPUCC8Hq6AIYTF9j8yzWbuslddJ33mXcLONnUwF6xfOaYPw1nvlxmrJUUUPXhfgoC6KRJ4c99L6YBNrua0qXf0R+FJyMOZ8mZskl3q5Dszsakv9fo0ioIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWK2jW4Qz2i8nKnV4GFc/QvDTGy54eZN1NXrigwSs28=;
 b=ZfP+j118wUZ0j1MM6EnLJznIEe+bJimoRg5gmIfbJ2tprZbFuv+8RSOnUgBue519eT8Jd8f32V0BPUUNYeQfBei+0UrYOSQKUPr3+L9pi1av9fRpeVxKIkBAouIy0ONOqGTd19T0luF7MpMn4CblNyBpK2EA/wSFcPm34J2feGY=
Received: from HE1PR05CA0140.eurprd05.prod.outlook.com (2603:10a6:7:28::27) by
 AM0PR05MB4931.eurprd05.prod.outlook.com (2603:10a6:208:c1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Mon, 16 Sep 2019 16:21:25 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by HE1PR05CA0140.outlook.office365.com
 (2603:10a6:7:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13 via Frontend
 Transport; Mon, 16 Sep 2019 16:21:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.14 via Frontend Transport; Mon, 16 Sep 2019 16:21:24 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 16 Sep 2019 19:21:23
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 16 Sep 2019 19:21:23 +0300
Received: from [172.16.0.57] (172.16.0.57) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 16 Sep 2019 19:20:36
 +0300
Subject: Re: [PATCH v7 2/2] block: centralize PI remapping logic to the block
 layer
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>,
        <keith.busch@intel.com>, <hch@lst.de>, <sagi@grimberg.me>
CC:     <shlomin@mellanox.com>, <israelr@mellanox.com>
References: <1568648669-5855-1-git-send-email-maxg@mellanox.com>
 <1568648669-5855-2-git-send-email-maxg@mellanox.com>
 <f56d2bef-93f4-95b1-b607-d97396626359@kernel.dk>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0684c4af-ab42-c6b2-7bcb-c2ac59a0ceb8@mellanox.com>
Date:   Mon, 16 Sep 2019 19:20:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f56d2bef-93f4-95b1-b607-d97396626359@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.57]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(65806001)(26005)(5660300002)(47776003)(36756003)(70206006)(16576012)(316002)(31696002)(4744005)(106002)(8676002)(23676004)(7736002)(81166006)(81156014)(6246003)(110136005)(107886003)(54906003)(53936002)(53546011)(230700001)(8936002)(486006)(305945005)(356004)(2486003)(76176011)(336012)(14444005)(58126008)(2201001)(70586007)(86362001)(31686004)(2616005)(476003)(11346002)(446003)(50466002)(126002)(3846002)(6116002)(478600001)(186003)(4326008)(16526019)(229853002)(2906002)(65956001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4931;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b223d527-5ca9-4678-22da-08d73ac1eb4b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR05MB4931;
X-MS-TrafficTypeDiagnostic: AM0PR05MB4931:
X-Microsoft-Antispam-PRVS: <AM0PR05MB4931830EC775C887FBE19D18B68C0@AM0PR05MB4931.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0162ACCC24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gmSDwzqkModPCr+/p/EFJxQDETS/5ckQxU9KLKwRF39ULvpiM5lC+lP0CD+hvvhuyE/8P9PSN/tvHkJR6QtdTwBPG30pKp+6FIJpZFORHFn50vzVGxyMeYYdPm0Dtm0S7JPNwbchv4TaiNzEjsvjpvbpQn4A0r7oOpMHwnCsTr/PgYFEjUnhRmf1t3s9FxBA1a0Ju5EoxNEdjp33Z0+DHGEmvwwB0KU+FV2v5h1PD6eQPKTCrs1rwis6RNwkHwKuW12QQKc3ecxWvXJtmm994gdolMNpKNP4G4BtOu4//WFBAgkhIOWeWAq1keTDTEDF/+P+t9QsIayiGFit5CYJM4eilXzed3YFQArCbGZeflPLapX68GArIUuQbjcYSRBcSgFYAP/tw+Go0iCvewbiFRNf3gTH1e4zhVPnCrOrzYs=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2019 16:21:24.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b223d527-5ca9-4678-22da-08d73ac1eb4b
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4931
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/16/2019 7:12 PM, Jens Axboe wrote:
> On 9/16/19 9:44 AM, Max Gurtovoy wrote:
>> Currently t10_pi_prepare/t10_pi_complete functions are called during the
>> NVMe and SCSi layers command preparetion/completion, but their actual
>> place should be the block layer since T10-PI is a general data integrity
>> feature that is used by block storage protocols. Introduce .prepare_fn
>> and .complete_fn callbacks within the integrity profile that each type
>> can implement according to its needs.
> Two notes (for future reference):
>
> 1) This doesn't apply against for-5.4/block, I had to fix it up
>     manually.
>
> 2) For more than one patch, always use a cover letter.

Sure, thanks !

