Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF231C43460
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF11861279
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhDLJqb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:46:31 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com ([40.107.77.53]:58350
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241874AbhDLJjn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5SazesYBIQyQDCqHJtovqLmzX6wkUKn+4DJUSqXfDKF+1+/upWD2YOlgOp52Flm+fZtz+bMpupAu25+lMU+9sHCuly2WVWP2G3OuhDNYiq8AfgAV5gMm2V6i3635MxZHyMrtsSkBoIMj+bdg/52HbqW+27MqizcekNiLr/mtbgzGapa/Eg5E3Kdwx5lCkSuHh3qarZOt/PdmMzAgLABvD3a3QIUbeK45EqPcjzBEtw6PNPOyNlmor98l/p3YK+IRJ1pfBCNU/IfrJtQieNneV5wCGiB3gXvb9QlFK4N7PWrQ/O/hq6rkl7/qy7E7Eu/R/6LwtJCKFhq9ZXEG2j5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrM7m5aTXmcF0MhQVdjX6oKmvPoecGhjbql3Iz91hRE=;
 b=JOzuqXrF2UeMyXuN9CzZi9hXbRPJtpd5QY5QQ+9PJ4xhniX+5eaeaCKnlfFBqCHajUjI0hOiNGojZI3V3tSRip66It2Ku3HDPQws2wkM63M3U0yg4faTk3TyvJ8Y/koDCLyvaTOAZOLJ73Art/zc1a73A2Pd9dasJswrJxGcwI/Bh8k8RNeAWre/mlDBp0LB0n2pvLHX4xW7rcCoEeQL9BvIxfJi+f4zFdC7n5OjSevQdoR9gvsm3YD4ONcbPoTAckCv2I79ChBOUJjS+52oWflsi1y54Eu+Yeo4P3kcRf3V4ch0rwfgWlU40M4W87Llhu72VMmtg+mgluWQL796sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrM7m5aTXmcF0MhQVdjX6oKmvPoecGhjbql3Iz91hRE=;
 b=fG+1+C8rHNr9dl2gr33CoyrgAiS9YhUw1aNNR10F0h8Ngo5aARWGKwWCHb2fjKCQ34mcgIjX120nzjkP16B5qouUCEoGFPtnNU2UUr0XFpqJGTheckpCMc5VuCj8Q3WgTFNIlCjD403mESS2ItT1LJ3Jlcmk/PRwvMDJ81XpYiLziuY7KNqU7dMMNtF8Ur6FsZKJF5LmMmXc9v9QlXEEWuG97XMbXyhS1+Uk2aXsWeSNdpMmuV5VP758H2AP1SgCvi/fXxhKwFh7vVRRXJ39WWCDNMRnyfEJmz1J87h7m3cwSsZK/Fg+PbGH3Q+poIKjuYeVrchK5389GaaaqJW3QQ==
Received: from DM5PR21CA0016.namprd21.prod.outlook.com (2603:10b6:3:ac::26) by
 BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 09:39:24 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::bc) by DM5PR21CA0016.outlook.office365.com
 (2603:10b6:3:ac::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.4 via Frontend
 Transport; Mon, 12 Apr 2021 09:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 09:39:23 +0000
Received: from [172.27.0.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 09:39:21 +0000
Subject: Re: [PATCH 1/1] null_blk: add option for managing virtual boundary
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "oren@nvidia.com" <oren@nvidia.com>,
        "idanb@nvidia.com" <idanb@nvidia.com>,
        "yossike@nvidia.com" <yossike@nvidia.com>
References: <20210411162658.251456-1-mgurtovoy@nvidia.com>
 <BL0PR04MB65147B275F17A60AEA672651E7719@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BL0PR04MB6514EE852B9B75F2B3D73CECE7719@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <1da0e414-f091-c266-3033-d39d26099a10@nvidia.com>
Date:   Mon, 12 Apr 2021 12:39:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB6514EE852B9B75F2B3D73CECE7719@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf02041c-0edd-4add-ae2e-08d8fd96db1c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:
X-Microsoft-Antispam-PRVS: <BL1PR12MB517647EF87A92F17668B761BDE709@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaTP/whmN6MqDeI4B8w365qhcWpBHj7rIDT8T1vnS4vVkCFWsu7GKcD3CPVUsB4+4mYHVwhV+NAJzFAH+dSw/7AgnjjF03NfTnQSnkTAoPr2U/RR7bwvjXxOcPZI4pcJ5MlJwQFHvsbdxt9q3s74Yac4p1XhNnR/Ds9XlSf5cP09L44mC5hHBpZzcaxT+p6EWU/q69u0yRsdAI74Y1p0gqZ1uKplaTH94xKQX58IXWfXmhLNRHqXj23mhQBlO9f3LJy/uOq/hyuyVMCuIUOvWCaWG12JhLWXFUvwFSg/YTvfEh0DGK9WdtSJ63cap91fQaHorhugfMh8J45i2SSHzuFonoSJZ0hh5S1kI3/CwpHmrQqRuF/vqkVD9dU1C6bFuxfU9813LJW4qeje6rLNvEq7fY6qXPdm20eSp7tfrXZSujwf9cQeVi6YdOn60ooqG5LohKQaRdY/99ft0ybtkzSV9y3xsvpNqXWYRObjfmOkcLwuRf/mipvXUsrZU4AMN+XWOi1rcYZjbFnXpzZd923DdEs5inl14SKtEi1N0jEZcgQ7m2OAPOoD5BTeohTnEKntrQ8yyj2BVi8HRq2orjqeeTUopQw7Cgl1WxHomoni8WJCO492rJBXwVfzInFx9cEvYessVdC6TrUXeOsevCg+NaLu6VMxXWczimLc3vL6iPTT1W5pys2feDqNti/g
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(82740400003)(36860700001)(86362001)(36906005)(316002)(16576012)(336012)(478600001)(70206006)(53546011)(6666004)(426003)(70586007)(2906002)(26005)(107886003)(7636003)(4326008)(8936002)(16526019)(36756003)(5660300002)(54906003)(82310400003)(31696002)(186003)(356005)(83380400001)(47076005)(110136005)(31686004)(8676002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 09:39:23.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf02041c-0edd-4add-ae2e-08d8fd96db1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/12/2021 2:36 AM, Damien Le Moal wrote:
> On 2021/04/12 8:34, Damien Le Moal wrote:
>> On 2021/04/12 1:30, Max Gurtovoy wrote:
>>> This will enable changing the virtual boundary of null blk devices. For
>>> now, null blk devices didn't have any restriction on the scatter/gather
>>> elements received from the block layer. Add a module parameter that will
>>> control the virtual boundary. This will enable testing the efficiency of
>>> the block layer bounce buffer in case a suitable application will send
>>> discontiguous IO to the given device.
>>>
>>> Initial testing with patched FIO showed the following results (64 jobs,
>>> 128 iodepth):
>>> IO size      READ (virt=false)   READ (virt=true)   Write (virt=false)  Write (virt=true)
>>> ----------  ------------------- -----------------  ------------------- -------------------
>>>   1k            10.7M                8482k               10.8M              8471k
>>>   2k            10.4M                8266k               10.4M              8271k
>>>   4k            10.4M                8274k               10.3M              8226k
>>>   8k            10.2M                8131k               9800k              7933k
>>>   16k           9567k                7764k               8081k              6828k
>>>   32k           8865k                7309k               5570k              5153k
>>>   64k           7695k                6586k               2682k              2617k
>>>   128k          5346k                5489k               1320k              1296k
>>>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   drivers/block/null_blk/main.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index d6c821d48090..9ca80e38f7e5 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -84,6 +84,10 @@ enum {
>>>   	NULL_Q_MQ		= 2,
>>>   };
>>>   
>>> +static bool g_virt_boundary = false;
>>> +module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
>>> +MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
>>> +
>>>   static int g_no_sched;
>>>   module_param_named(no_sched, g_no_sched, int, 0444);
>>>   MODULE_PARM_DESC(no_sched, "No io scheduler");
>>> @@ -1880,6 +1884,9 @@ static int null_add_dev(struct nullb_device *dev)
>>>   				 BLK_DEF_MAX_SECTORS);
>>>   	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
>>>   
>>> +	if (g_virt_boundary)
>>> +		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
>>> +
>>>   	null_config_discard(nullb);
>>>   
>>>   	sprintf(nullb->disk_name, "nullb%d", nullb->index);
>>>
>> Looks good to me, but could you also add the configfs equivalent setting ?
> Oops. Chaitanya already had pointed this out... Sorry about the noise :)

Sure, I'll add it in v2.

Thanks.


>
>
