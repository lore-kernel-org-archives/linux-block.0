Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9302C433EF
	for <linux-block@archiver.kernel.org>; Mon,  3 Jan 2022 15:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiACPXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jan 2022 10:23:16 -0500
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:29760
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233918AbiACPXQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Jan 2022 10:23:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9E1izyAAycuBr5cfh/FE6gFKxo1K1tYa+ip9cGzygbrhdHGXZapeveIAheVwOYoV8GvUVx8dWtysDd5nLtBiIY8mcvgbFM5p7p3UHogzwygPfhe65vjdI4J1PO1t23bw0GuFXcGmKKvzf6B6QJNF3xg4T/wFmRkVGcsH7hDhL4d240icACJmnySvOrlj7fjwADh4HVDuOvJ2Wl6vnb0iBi9rIJdTelJr1tiLWmkQv+egzSKtUoglQFtZPrjgC/Crt4c1rhItvK2PANCCTXnR5IEkRKfEN2BZH4FZVKAyBhc79nzDbVOY8hrJLanH6/fmCq6LZyYyFsEbZEdydgbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeCWBYj98Mi5h6zlFe3LIeNCIHr6asFJmAPJibVfa74=;
 b=LL3r1QNm3ikie9W2Yj0SqTiMCrtaAk169xwF9Hic28X3UV6TR2uztoqrrgPecBDMJCd/h6C8nkvLBDHiRdWdKReNqJQbHAZXXcXZp55lvMX7GUmg4a2f4RHVTuXswvUTPUz81rXyClN0LNWKd3ok78FdszzMfw3IN0huaf8rIlMYYKUBtxJeO0fXTC/clor5+M/InN/FLjKwx2WsAof883HfZqzt+7FsFVpjqRmGlmfhjuBJ4cCj4ev4eOv+uElMk5bmFnXsyOvq4R1r8K+kxts/PLnJkCx4DU4VRBoKvakK5lqP+CXfEjtzkCgC6DwYqkTPEusdkJjglZeLozHUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeCWBYj98Mi5h6zlFe3LIeNCIHr6asFJmAPJibVfa74=;
 b=rFz7XIgUMq7xPUCtIpLUD4uYKG5soyf40NaCN1v9YkW1pGxNT5PJayJrLwTl4Wf4mVWGa6OYyV7dZg7NwpXsmPSlcq8XIw92H6hJwv5Vf63mJAHC242bUVN8AZjEZ2tPG6Z1jnCKIsk+im1yQ8aKoGKqlDQrZhzbunV+ZEQbGgaQaXIcceNhKlzThb3g/y3xsEcP2ZHwE+1r9C2V7rp8XGaXeXDvi6HRHYAbLJdlvixYlO4kt/Nsv5TMh2QQdIuZ38RlaZh03zzV80ykFFJ/x+N2XeWORGHG1BhpZri7LQz78GgM0/YWcYo1O5yI0XSGrYZ8eESY589EDunPuDNhGQ==
Received: from MWHPR21CA0049.namprd21.prod.outlook.com (2603:10b6:300:db::11)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 15:23:15 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::8c) by MWHPR21CA0049.outlook.office365.com
 (2603:10b6:300:db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.1 via Frontend
 Transport; Mon, 3 Jan 2022 15:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 15:23:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 3 Jan
 2022 15:23:14 +0000
Received: from [172.27.12.4] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Mon, 3 Jan 2022
 07:23:11 -0800
Message-ID: <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
Date:   Mon, 3 Jan 2022 17:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <sagi@grimberg.me>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
 <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfda783e-ce82-4e0f-d74c-08d9ceccf637
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01551F1C6800AED62A2C7176DE499@DM5PR1201MB0155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GK1CpE39dFFB9wduQTcxZSISPwEShOuPPLzkCgEdrnHyq69c5Bc74uxl/6wUkN+PBoh3sejugg/yZ4eEQHGk8qRrz1/L9ceyDCZyiO7JIdMQkHSka1fXcgMuzBCZRhRvXyV9ksvVuq/INWKEWGo/r1VPGGETM1BS6KrXjzdbgRBd1TKsQGhu4mdivqFn1oFeO+w/xd/3aZYAprn5kP8nU9BFwkC/ny0+B2A81xACIsGgas0CWa2LPOB5l/N55DPgE1YZXYY6TNoIOSQ6Y5swPXFX12Bl0+kREzyeooEV6Rxjt/Vm7bDtLvRo5mndAKtkZpV7Fqrl/iLCn6G6Lrcw/m6V3rX7ie2rCSE/PqaBKObhQRG0AbpOvmp/HzmvAMka5HhESDTIJuSpAIduVUL4uswuVw9zwPu5+nUB1Rveylod1ve6V7R7OmTgZ96gjoZte/LFR+bzEZop3t7gPcDZGeOprnYzZJezPGGzBX1hk0rr7V0XxCyhT1vI2KbIvT+WPRP8Flps5slfsKVGI1oUBTqmlYCxES2kWPJHL09DNyWdkGEIhZvtjE8KENLLu3tJg6MUiqkDrKyeH2eS/uuHKsHAX4XLtZDRA+doZUiVaGE1a9MBZ/2lwBzPpfidodHNwg35LI4hslNHPc8OkeuVBWmbNa3Ktnev6nxhh3C2X/LUwup+u/wJsyjUBlmbHkr4p1Awf/nOfkLXSYxBpixFNL+OE2h0qiqZwHR1Ggp0SpZsP7fyBk1fw5qoSMgKBNfXJres+2vjQyJz7kFYguIXox6ZbWLkKQIebZ30p3l7Uh/jAWe65j1l+lyQ+Owy3VRW2yMBgYX2BMyVh4/OfONWZA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(36860700001)(2616005)(336012)(82310400004)(81166007)(6666004)(54906003)(31686004)(53546011)(83380400001)(426003)(186003)(16526019)(47076005)(31696002)(508600001)(8676002)(316002)(70206006)(6916009)(26005)(5660300002)(2906002)(86362001)(356005)(40460700001)(4326008)(70586007)(8936002)(36756003)(16576012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 15:23:14.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfda783e-ce82-4e0f-d74c-08d9ceccf637
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/30/2021 5:30 PM, Keith Busch wrote:
> On Thu, Dec 30, 2021 at 04:38:57PM +0200, Max Gurtovoy wrote:
>> On 12/29/2021 10:57 PM, Keith Busch wrote:
>>> On Wed, Dec 29, 2021 at 06:39:02PM +0100, Christoph Hellwig wrote:
>>>> (except for the fact that it, just like the other rq_list helpers
>>>> really should go into blk-mq.h, where all request related bits moved
>>>> early in this cycle)
>>> Agreed, I just put it here because it's where the other macros live. But
>>> 'struct request' doesn't exist in this header, so it does seem out of
>>> place.  For v3, I'll add a preceding patch to move them all to blk-mq.h.
>> Did you see the discussion I had with Jens ?
> I did, yes. That's when I noticed the error handling wasn't right, and
> doing it correctly was a bit clunky. This series was supposed to make it
> easier for drivers to use the new interface.
>   
>> Seems it works only for non-shared tagsets and it means that it will work
>> only for NVMe devices that have 1 namespace and will not work for NVMf
>> drivers.
> I am aware shared tags don't get to use the batched queueing, but that's
> orthogonal to this series.

Yes. This series probably should be squashed to Jens's and merged together.

> Most PCIe NVMe SSDs only have 1 namespace, so it generally works out for
> those.

There are SSDs that support NS management and also devices that support 
multiple NS (NVIDIA's NVMe SNAP device support many NSs).

Also all the fabrics controllers support it.

I don't think we need to restrict capable controllers from not working 
with the batching feature from day 1.

>
>> Unless, we'll do some changes in the block layer and/or remove this
>> condition.
> I think it just may work if we export blk_mq_get_driver_tag().

do you have a suggestion for the NVMe/PCI driver ?

I can run it in my lab if you don't have an SSD with more than 1 NS..


