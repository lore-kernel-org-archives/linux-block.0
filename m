Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE4C433EF
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 11:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiAFLyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 06:54:37 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:62464
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238658AbiAFLyg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jan 2022 06:54:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VknjHOvKBt+aNeKTXPz4bMoKM5wN+bFC05Tn4oCH39K7xOi6kP18Bo3cc2hsr5aNNne/baZsW92npvpoB6S52Us+NuFflempDy0pmbVnDSicQ2tAwbONP5a8dDiIixI2Dx51EVEo6VmNgKLZEhZAUhYGg4jfS8m4rY8QXcDSyLgu/KqjcFMimjbzlz2BCxEGy0G5HzdczLXfVsJIhkn+j5D0hm0P1EMeXA9wmROmSh4OQub4f7k6DI/SBfLzsVg1T5+imK6h7H4+psYMY+NW6t3glAzsdCWM/A1a/6b80IZTJDD+soGjQLQ2Y+nIzgJCxQI9OmznQzC+hr2HQveyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuY4/Nh20MBai7B/c6s5DeZo/r1pulTZcfgyPzXb6Ew=;
 b=Mzrq4LBzfukoKfVAytSe5EB5359vJ6NppxeggI1QDIV+UtOb14U5Ye3cZmPqkrF1tciASdJq6DgQlhRUy9TEss305nyAFR4qa81jsP2+sraoc5HbEPrWCMxqPUHeYnRss5rkkIvQMsA1x9lKuUq1tcXHUtIa9QwdgQZp/MzEJz4jGZOBkkLoNdtorV9tLYK/TVhyrdiZxdAJqswHfy2AGcGvYWysyxDtT6VwzHp3rUm+Ob/eBxOkwm0jSGErFnwCB5U44DnHTH/wC8RltSitGWHt9t+rmAZTmH8F1uiviFaD6j7vefVV/zmXp3GOd6j9vLSMVT90/WJlXb4I4gPvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuY4/Nh20MBai7B/c6s5DeZo/r1pulTZcfgyPzXb6Ew=;
 b=Bp5olVxulQBnfs0yvmFUQZN66sWhoDjl63rTfqmQSoFRNh7P8Hv0U6gO2XUeLuOexEeS4E66uqRPoaaZs0SgHAvRV4Wc0/r4dFo+ut8MIO3eJssaRsY8a/bzUKQJqz8z/hDuZ23PyAed8W61KdeM5nyi6gkTwO+6JeLnPMB5xG6zOTC0+7BDZvBobua4MHvQQWFp0xo8uMCyMvCBq94WHCChL2euVWW/DDaomQxWkeg/4hs/jhJGVV0p2MPrlp8UH45vrxrPxQiWL5+2alwe+cpxrkzrCVpqs9XG3C1ypuELVrcHHIL6noDauseqObY5VUoqMch81lBG+zKyO5VLJw==
Received: from MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17)
 by MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 11:54:34 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::fa) by MW4PR03CA0312.outlook.office365.com
 (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Thu, 6 Jan 2022 11:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 11:54:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 6 Jan
 2022 11:54:33 +0000
Received: from [172.27.13.64] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 6 Jan 2022
 03:54:31 -0800
Message-ID: <02a943c0-2919-a4d4-6044-7a6349b9aaf5@nvidia.com>
Date:   Thu, 6 Jan 2022 13:54:28 +0200
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
 <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
 <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
 <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
 <20220105172625.GA3181467@dhcp-10-100-145-180.wdc.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220105172625.GA3181467@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 877fc4ef-d0c4-48ac-9887-08d9d10b4e80
X-MS-TrafficTypeDiagnostic: MN2PR12MB2861:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB28614632495B96FB3B2B1221DE4C9@MN2PR12MB2861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vL9yNr9W0woJQ7Lr0kMgvJvMLmkXnTA6GGrS4Og+CMuo1c5SHdr3+ticPb64mrrrWj5CvZK/+wnLDRK2avyt9j0rCA3Vif3KP8V7ap4QyKx8J/Rf3SllVnZ+zEC3IRQJ9M6um3Zq2sM3InJy5L6HAbjIHBOWQveKkSC67ft0u+dt2Z6YlXKuJqA9ztB7ARydulTT6RwkeT4aDcIfdFM+gvyoR93L5BDK0OCCYxMlvq3Y/upPQw+tcHgRqUzT2sMKAGMwueaPdSyb16k4SdXHuRa1A5vSebdrQqnvWxKj1/WKtb0X/zSz5hnmPMBIQyVdB68+61F4SIcI7DCOcErH6JIj8n4GyfDjxmjxsRaCD2X4RiqzSF+v0u+HWxkUegt036pKdVBcven8x+tg7lbHJT7hri55UqsmIsO/kcKEDEKX6DMXcJKVLYUMBmwhwlrioJ8kKbLMEPptFGBEKfV5BGpJ1HETTDmMq3VVJIQppBa1w4KH7luDogdObt5jId8hUVMsfieD122JD8b+doCN+NUNfg86arpu0Nl5i8w/VovvAMzTYmvtjCUKf2D+UK+y8SrRERFNxLk95hxBWa/miAELZ1Ep7ZLCXiVVt1tl7OZsdpus4MwjY17SYMrELtCaZi6osgMv6kqbhFOs00KpmAfVC8RNTrdDJUhQblnnbG29PzJKqrFj7dOkhgeiJGkFmhiR3Y7UibuCpAqLFrSFEfWUNcyk2VXL61stgHY/Gx7xyvStHSV3YO4ynhfVTbMykycA9tMUdLEnYpiA25KP5CNe/gwlK2UKRc7TbxuTMYfQ983ZFdQIcTIkYVJBa60bJE+oU4lmb82cV9TfU3tzJv+ShWoCZYlRCVY3fvUuKgblRIv89rinAKZBtQlvOSaK
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(31696002)(86362001)(31686004)(70586007)(70206006)(16526019)(4326008)(26005)(356005)(83380400001)(6666004)(82310400004)(40460700001)(5660300002)(36756003)(316002)(16576012)(81166007)(54906003)(6916009)(8676002)(53546011)(8936002)(36860700001)(47076005)(336012)(2616005)(508600001)(2906002)(426003)(186003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 11:54:33.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877fc4ef-d0c4-48ac-9887-08d9d10b4e80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 1/5/2022 7:26 PM, Keith Busch wrote:
> On Tue, Jan 04, 2022 at 02:15:58PM +0200, Max Gurtovoy wrote:
>> This patch worked for me with 2 namespaces for NVMe PCI.
>>
>> I'll check it later on with my RDMA queue_rqs patches as well. There we have
>> also a tagset sharing with the connect_q (and not only with multiple
>> namespaces).
>>
>> But the connect_q is using a reserved tags only (for the connect commands).
>>
>> I saw some strange things that I couldn't understand:
>>
>> 1. running randread fio with libaio ioengine didn't call nvme_queue_rqs -
>> expected
>>
>> *2. running randwrite fio with libaio ioengine did call nvme_queue_rqs - Not
>> expected !!*
>>
>> *3. running randread fio with io_uring ioengine (and --iodepth_batch=32)
>> didn't call nvme_queue_rqs - Not expected !!*
>>
>> 4. running randwrite fio with io_uring ioengine (and --iodepth_batch=32) did
>> call nvme_queue_rqs - expected
>>
>> 5. *running randread fio with io_uring ioengine (and --iodepth_batch=32
>> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
>> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
>> expected !!*
>>
>> *debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
>> seconds, it appears to be stuck. Doing forceful exit of this job.
>> *
>>
>> *6. ***running randwrite fio with io_uring ioengine (and  --iodepth_batch=32
>> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
>> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
>> expected !!**
>>
>> ***debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
>> seconds, it appears to be stuck. Doing forceful exit of this job.***
>>
>>
>> any idea what could cause these unexpected scenarios ? at least unexpected
>> for me :)
> Not sure about all the scenarios. I believe it should call queue_rqs
> anytime we finish a plugged list of requests as long as the requests
> come from the same request_queue, and it's not being flushed from
> io_schedule().

I also see we have batch > 1 only in the start of the fio operation. 
After X IO operations batch size == 1 till the end of the fio.

>
> The stuck fio job might be a lost request, which is what this series
> should address. It would be unusual to see such an error happen in
> normal operation, though. I had to synthesize errors to verify the bug
> and fix.

But there is no timeout error and prints in the dmesg.

If there was a timeout prints I would expect the issue might be in the 
local NVMe device, but there isn't.

Also this phenomena doesn't happen with NVMf/RDMA code I developed locally.

>
> In any case, I'll run more multi-namespace tests to see if I can find
> any other issues with shared tags.

I believe that the above concerns are not related to the shared-tags but 
to the entire mechanism.

