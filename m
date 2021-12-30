Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED4C433F5
	for <linux-block@archiver.kernel.org>; Thu, 30 Dec 2021 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhL3OjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Dec 2021 09:39:06 -0500
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:4439
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232911AbhL3OjG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Dec 2021 09:39:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIw+Nt4kUeSIrik+i8eTILILBVJUzO0z/eJ6C51VZxGsdLg6h4VHV0YgKg6EBm+ODN3424oRMDVJqkiIVAuR59kclOGsUfcQyIONEJ1kq3c8Ni9qiCDyuk9k6+m1Nh14uL7GYR+yTZQpIe02wnPiVuLr/0aWC6JnYmIMNXRhgl3pL/jDBbV0yMP9RyzJcHjxudnI8oSlRHHqO2Nap67COFMV43dlrqFZgF60/2cgm1HEWcPYhhG1OMwrhc19xAAP1bdUSMkcLZ9URncQKKSggXTDELUCeq7OhnPyZTrDXk4e0jRuIn7VLhTDvqypWRii8qlpnfJQJfstLdMg4xfWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfRGqgSwhWrAMWLN15s8nEMahY5MU3rE9zCJ2j5NjA0=;
 b=NX5QEDzqEkbfA29Y49NLpEjXQMN6ZLVeBheb+IQKpRCVN3ExWGBSNjV9TKJ6XNEg5VgFUutazEI7jKpaR/ei8UlW+TIF8wQengQXPNet2YBCGYkY6SPHYHC3ljuWqgGvWrJdQtKctoZRiOv84tku+ify5MAS2QAv8bxxqsYuIk768OaOZ6GyPawU0hR9CqHAdFhLUENghnjp0LC7UDSK6s3qScSZs1+DDw8PQtu3GPsiPz2Ns+cBt2NUZ8RLru4QBDUO8x8+s727NsYG1dhEsvO653xujNozp4Azcs4pUThmvvG1nBpK18bMO7lymIHqlO0BNqHLUeyar130Ry3Dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRGqgSwhWrAMWLN15s8nEMahY5MU3rE9zCJ2j5NjA0=;
 b=HqvMjxLS0d1wiqPCtXxH7LHj4hk8LUzVDoWutmlOjTIAq9DTbib9uWGjT/Fufdv7n/maQsBm/OeXaq8avaaB0qTM4jZHOWWJY0hMk0HEgAaos8n5NYRuK3cvSeAy02dYj6VmPA4I3ag53SsGX+fBgv16k/ASsXWr3Ihlrzsu/9DCvOzc+NwSU2Q/glRL/4+dhbH6B7S20qRiNolhyw4R/TEB5EXaC4f3M41Vs55aaG9ylrCu/6Xiqq2cMD7Jua7sar6u9Wd0TxKLd9XeGXusGOhOySV2Rh4vbKnHJUbPY5Qkgyp2XzupIjW335crpekifDt4aDePQd3+t/GZ29iKGw==
Received: from MW4PR03CA0332.namprd03.prod.outlook.com (2603:10b6:303:dc::7)
 by BY5PR12MB3908.namprd12.prod.outlook.com (2603:10b6:a03:1ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Thu, 30 Dec
 2021 14:39:03 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::26) by MW4PR03CA0332.outlook.office365.com
 (2603:10b6:303:dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Thu, 30 Dec 2021 14:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Thu, 30 Dec 2021 14:39:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Dec
 2021 14:39:02 +0000
Received: from [172.27.1.202] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 30 Dec 2021
 06:39:00 -0800
Message-ID: <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
Date:   Thu, 30 Dec 2021 16:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>, <sagi@grimberg.me>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a694e405-0d65-4629-36fd-08d9cba21fe0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3908:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB390862D6A136769602D7B378DE459@BY5PR12MB3908.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmPQuXD33WOUwrL6noErWDLS4WNC6NVglWJ3eR97gPG4OM23A8Z7oGrR7A74DhChFpCBUf9hm0202CdfuE17KVJFJTTSx+Db2TlzlCZb0CfC0QZj/9zDlVlaSQ4dm+5kpCxN9IYRVgUf23UBNaq+g4D63MSQOwAafG/FwyKiFc5hxuNor2apQnxzOjGecm4XXdvL1QJodQQAZ/2yZByapxw4uwv38gXldSqeK8xqrFaUDXdhYkaq8y+wtkUwEpacI5xGoI/uqEZg+gf/gS5XLXEchxBF9EgBTKzfH2lB7Y7a06wPZ4i2RrimVWmQWmECVvEiO/+lQf2OmC82Ox3Do2kMDhnOCD8v88oltPyWPhAdWfxDmPb5c5E5X9x/VmISgnt6l1Vc/07yv6vAvihX6F4JvVPtQ2strUafWa3PTa7Hun65vU7ieRoWnj61AiRrmQtTrYwRbbK3iqMZeq6/+pctDA7VpBgnz0uzGYBmvaBzFJWp0xWT3XdCf+Z9xw+4082Pe2fjrD+3Rv4it4TfHBdVgdNiKh8f8v/P+r3zIFRlUbQ7FcvGXBUDoMC6yGBlj247jvGFtI7aCdXTJHgVAcNdzArxheV/yHcR13XSodBf+Z9m0NRdx2s3CpSIl3Q2vHmalptxc7STAlWMT1bQvD5HmVmvpfP+rsB177hLIGrOfoljbDhBrjUjGHTFojay/vrlx3WyShSVP0lRh5FIHtkUNTsOwjYeydh8Zrbb7tvQQFikWRBgksehL8wAuSdPfpbQ7fxAejhDhBFHdbHqRNV1UsWfK+tUDUVoKRJw1ZvlZQPKg4XDYn0JSDxjVvGY2wg4+tuZ0kZKJ4WqBICNKQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(36756003)(8676002)(2906002)(186003)(54906003)(508600001)(26005)(6666004)(316002)(110136005)(16576012)(40460700001)(83380400001)(31696002)(2616005)(31686004)(47076005)(36860700001)(426003)(16526019)(4744005)(336012)(82310400004)(53546011)(86362001)(4326008)(81166007)(70206006)(8936002)(70586007)(356005)(5660300002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 14:39:02.8314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a694e405-0d65-4629-36fd-08d9cba21fe0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3908
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/29/2021 10:57 PM, Keith Busch wrote:
> On Wed, Dec 29, 2021 at 06:39:02PM +0100, Christoph Hellwig wrote:
>> (except for the fact that it, just like the other rq_list helpers
>> really should go into blk-mq.h, where all request related bits moved
>> early in this cycle)
> Agreed, I just put it here because it's where the other macros live. But
> 'struct request' doesn't exist in this header, so it does seem out of
> place.  For v3, I'll add a preceding patch to move them all to blk-mq.h.

Did you see the discussion I had with Jens ?

Seems it works only for non-shared tagsets and it means that it will 
work only for NVMe devices that have 1 namespace and will not work for 
NVMf drivers.

Unless, we'll do some changes in the block layer and/or remove this 
condition.

