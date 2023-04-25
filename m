Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A9C7EE21
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 10:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjDYKZP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjDYKYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 06:24:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34512C84
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 03:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLOOGyHytGSBP1VAhd26X1UKEpYixIJTVBakAS96HhtuOOHHx+RcVVcBeBMMefEvZ7/pwCEdBcHpB59yTXU/3/vhu4DG+4dw8Gos7+DkEAHyKxDlJVx62PPmwuu8Efti5Pqmj/yzYLR749//O4SMSBjQHp2SnN19sxHBh15RsNF+JMORIB7k9iuAIDkTyfelE3/YVj+jwJlkg5+G21zjUjnZjxx2Jy35DP2s2VHNvJ2FI6KFUtuBGjhTPfGvxdMknGpbGje6Pfjcl0XHkd63MuV5CnNLEVY+fRc+LtEvV04QliihmIDrYBBsz3RqCFptwtRXzzkUgmAI2LtuLQaCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nGAcme1Dpqfyr+x5T4bg7q14EUteZ3N83glVG6efxM=;
 b=QhS1JVRzDHvv2/4W0fzZIWEbyIJUtmzMzveG/IFeHjb+zHqMP3UwkrD5mlUKEixJhTJ1C/ErKg4sOsidogtTQ0MvLiGh2M+AHK3xRrKkAczTeEmbE6r3AnK23LOLalShvWiyJcULbsTs6qwaZkAWDTbHX+JKQBGvDwI09Od+HujMogyhOMpoiCmybjtKk78CIc7bIzas4RnxpCeuBI1gPcZqeg7gCfzpduTroernv3a52HpXuOWhhBeUKgpu0vCFnhlNav0O3fOqHJmO0l07GPbKMa84fFHN1qmOwQoYoKoWM52ExG8TUoXse8Kj7EM0mh9DneXj6U+HAqU1K41cvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nGAcme1Dpqfyr+x5T4bg7q14EUteZ3N83glVG6efxM=;
 b=UTj/PTjGRKaRoealRBZKl7i5zobpzhDEYNc+xaTBWKxDytiCNqO83K4Vl7O+oBGx5oraDJ+Cdm2Ncp4CjWnV9XyEMCjx5bfrR9t3EZAjMhwS+a6TBsMD4pZn+yGMIpLLiHnBCd5shYiubAzmf63s2AtEb247ybHJuTyrcrnuWuJWn9F86bow753xHcJzMuFXOmQlb0EJ0TNhOj2J6X+0W0IC2P4TF5xmb2alFCNSAJeRvEtFNYLhmTazXuip1SE+ODK9wZhDuQpKYgwiBPlqzCdYqHeK7mgonlLNqHXKvCtFFyyPxMbdWjQpxrvV0k/45Qp4REdQExQI+HsM5SmK4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 25 Apr
 2023 10:24:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 10:24:39 +0000
Message-ID: <85974694-c544-be82-97ce-c318adacda49@nvidia.com>
Date:   Tue, 25 Apr 2023 13:24:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] nvme-multipath: fix path failover for integrity ns
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        hare@suse.de, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
        israelr@nvidia.com
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
 <20230424225442.18916-3-mgurtovoy@nvidia.com>
 <yq1jzy0lnyl.fsf@ca-mkp.ca.oracle.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <yq1jzy0lnyl.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 81425076-0126-4e3a-1de5-08db457746bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSFP9BobspEfAHY3vNJ8ZLshEd/1JHer0jXttJoEMG+5NiEovLRrWZ5GZpQdKnqeiCSfq6JqmyLU+C3fuzazOgDCNUEViIfrJ2K0Obh1fEoS9ybRAUFMPmc9TTdoPyu5VSY6vYyMcaQ+NhPyAfwluVALbb9gV5kDOtsRm9bYR85CoNiUJnN8GNo8imq64Q+Jc/TroCN6N0ENS9WmBlEzCVhrRP7tWYwDsVUaQxzxfKLY9PJk29xpjzxfWEycrGPaXYBaL4BSbzOJYzjShMVs1mfg2r6vPT92EK8fIWyAqrfpz3PcuZVuN16+RyU+S8A75Duqt7OP6/kJGWKUQskfUX7xzX6P7EAqmrHhmdze05aRiduX1ViKPBpOpIaEo4YEIQGLF5JLWD2NfqRdVooYU+jPtanm4N0vpmf7pyGqvT4qoJ+WCUb+osYOsgZfOc4aCFL6wb+pvBt1aTchj/5cLW9WYHYzimx+Kdkl/dr7JAUtjhO4XawQvheQJDUM984JeRROVNSKa45oYP37Xj50ElnrQQ7g8GzXOm3RLDRetX5xf3q/DXZHmfzS8sF6FKS7Xaf+zxa/0C7A8t3RtDrZK4vpT5Qm54a+Si6hpacBYW89UDGvchrPAM4xdCv5wPmlmZfvPaeW276QU9qIsX3E+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(36756003)(8936002)(8676002)(38100700002)(5660300002)(2906002)(86362001)(31696002)(6486002)(6666004)(478600001)(31686004)(107886003)(186003)(2616005)(53546011)(66946007)(66476007)(6506007)(6512007)(316002)(83380400001)(6916009)(4326008)(41300700001)(66556008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZxQ3FWd2toWm1oblZKZkNNUGx1MnpUVWdaazhFeExBcW9paVRSTFVGWjFv?=
 =?utf-8?B?WjVKcWJNUW9wOGpLWWFxc1lSdGZxOXJuVFVJYTcvdUhYa3gzN2lnVWZyYytE?=
 =?utf-8?B?NGc1VmI4SXllNGlkQmEvWmFHZUh3NVcwZHNhc3N5MTk2WUZYVTRITHhUdkZO?=
 =?utf-8?B?T0UrYVFDblM5OHNSRlpBYnE3a0cvUDRoVTk2c01ScDhBbHk4a0hxRXFicDBS?=
 =?utf-8?B?OFp2SmpEamZOYjlNdGpzWHVkY29BaTZ0ZjVrR2hseG00TE9Wa1Z2Z1RwRWNP?=
 =?utf-8?B?L2FkMUdLVlJOZTgwbHlHdHdJbmp3M2tKNHVWUzlWbTk1NFVmekFsLzM4NEpt?=
 =?utf-8?B?OFhJKzVJZ3poZWY1bU1kWWdSWjMvM1V4UVJqeHMybm1qYUFZQ0FWNUptME5H?=
 =?utf-8?B?c2pINHlXcG5YUTlTc3ZkUEs5NEx6RUpZcEkyZGxrbUF2RnRaSlRROFlzMVFD?=
 =?utf-8?B?MHNOK3RzKzJ4SG9GSkZaWm9taUxlMlg4Qk1Wd2xBVXZ0amw4eXZzakRsTFMv?=
 =?utf-8?B?LzIrYkQ3MFFPSlFTZWlOOWdqWTFJcXE4RE5BNXlISXUwSG80MWZuR2FIWUJ2?=
 =?utf-8?B?elhJcWg2cXlJVlRIOXRZZ291S1JmOVEwSmpzcENVZVY0WVRiZWVZdWdSN04y?=
 =?utf-8?B?bW1oclVGMWVhbDBUWkVqMzMwdmcyNnhQTkZsUjJWQi9iNVEwSkNiTnMydzVm?=
 =?utf-8?B?WmVoUkNQRzBQUmRHZlowM1ZOTURaaGpOVjgzU3RUaGl1bHI4Lzd3cGQyamg2?=
 =?utf-8?B?dHBMSHJTNW5WL3pqUnh5b0F3QlB4bmJCbUZpM3BmL2E4clRPNHZPZkE4M1pn?=
 =?utf-8?B?L0t5RCtHM2RuUUw3aVpOVFVqOGJqWlFSUUN1ck5UWXhRanNBdEVGTFY4emFV?=
 =?utf-8?B?SHlwTUNhWEtYNkRVT1hMcXhVOWJmZVlibmY4NXdwZGRrdFpGN1g4d1dKRkdZ?=
 =?utf-8?B?U2k5TUZUMktvRFBWSHJyaEE3QklCaVhWVEs1MlB0SmFocWFWRUoxaCtBNVBu?=
 =?utf-8?B?YVlJOTBFSkU3amtpcjBWYkVONlVRdUpkOUZYeDh3WTg2M3VWdGoxSDYrOWNv?=
 =?utf-8?B?MzAxOVhmQjJWUjB6RzMxZ3dRSTMwUXA5WjJiNW55Ny9qUjRzSS9wUVRVU3pJ?=
 =?utf-8?B?K281dmYyWGZ6U1hZanpnSWRnOWpCSHpkTFRHREZFNWV4RTlveEttYmZxSkJP?=
 =?utf-8?B?OExCWEtvNGpSQzdTTHdQYkorS0R1aDVwVCtUNDg5R0tNdFhzNElhcUU4dFFW?=
 =?utf-8?B?RjFCQllRR2wzNXluZWY5YWgzQXNvQmRvZkFadFdJcjVQa1MxYUltcVdvV2xY?=
 =?utf-8?B?WU9FRWtVdGl3RXRiaWNRWFU1OVNOa2FpU0hMUUljM3BybTJrY2lGTURsMkI0?=
 =?utf-8?B?bVhuZlRkbTd3eXJvZ3I2UlRlK0M1SVJWRWNPUnFiZlFndHJhQ1loM080aDBp?=
 =?utf-8?B?bkd4dUJEaFBNT1Zhc2NOaUJIWUdLd2YzZmxyMXdpZnlWTnVpSFFpcXRmcUNU?=
 =?utf-8?B?V0k3d2ZvYUtLb3lTR2YrcHdOd1A2c0lvSHBlS2dBbldXTTJaVnlhKzI4UWZQ?=
 =?utf-8?B?eGN1WUF6TVREd0txdUNIVlJWSzlUS3M0cDhFb3pGWU91R3FPeTM3Z2RBTk5U?=
 =?utf-8?B?QTY0dW9Rb3JoaEVib0RPdFczd1A3K0dRWE5LY1Y4MnR6ajJTVXRaR1kzTHRn?=
 =?utf-8?B?NFNiSit6SUpmT0Z6RnNFcTE2RzdwbXc1ZG9HWS94T1Q1dS9pRFA2R1JlUUVa?=
 =?utf-8?B?Ulp0empGYUhXT2prT24xTC9EaWg2QndVT3JCZmdhRUx2UngwVVhMdWoybUVl?=
 =?utf-8?B?WldLdzlIalZMd3M5bnh6aGJoMkZoL1IvOXRKNC9LNENrUDl2Y245Z2FXMWlU?=
 =?utf-8?B?K0JxQkdIbFREcEJnSGtEVE1rT1hiZ09RYkplUWF5VmM3ZkFIVjBTK1QxNEd5?=
 =?utf-8?B?UHJIM243eEJyc2FKeERSc1lJMEhqejJ4SS9rek1VVFhxWEZGQTA5d2xOd1pK?=
 =?utf-8?B?cGZPd2tYdE1xT0FrSVRzY29kODBNUTMrdGw5ejV0Tjd2eVJLd3VrQkFkbkIx?=
 =?utf-8?B?TklzN0dhZjFLS3FhL2taRGFwUzF1M1VaUWs1bmE4WVlKandHcVRUSE9oVHZx?=
 =?utf-8?B?cW5OdHh0RlNQRXIrbC90VmhzUEJPaEhXNnFHUEppbGltTGp3bnNmMVJONlNj?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81425076-0126-4e3a-1de5-08db457746bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:24:39.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OvrEta5qI29cASuMvBKIBMS4H0fknOiXme/b6zhU4cR49DIl7qGNokTVhlCP4SDNTzfEHmN2gA31EoGRAV+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 25/04/2023 5:12, Martin K. Petersen wrote:
> 
> Hi Max!
> 
>> In case the integrity capabilities of the failed path and the failover
>> path don't match, we may run into NULL dereference. Free the integrity
>> context during the path failover and let the block layer prepare it
>> again if needed during bio_submit.
> 
> This assumes that the protection information is just an ephemeral
> checksum. However, that is not always the case. The application may
> store values in the application or storage tags which must be returned
> on a subsequent read.

Interesting.

Maybe you can point me to this API that allow applications to store 
application tag in PI field ?

I see that app_tag is 0 in Linux and we don't set the nvme_cmd->apptag 
to non zero value.
It's been a while since I was working on this so I might be wrong here :).

I've noticed that in t10_pi_generate and ext_pi_crc64_generate we set it 
to 0 as well.

The way I see it now, and I might be wrong, is that the Linux kernel is 
not supporting application to store apptag values unless it's using some 
passthrough command.

> 
> In addition, in some overseas markets (financial, government), PI is a
> regulatory requirement. It would be really bad for us to expose a device
> claiming PI support and then it turns out the protection isn't actually
> always active.
> 
> DM multipathing doesn't allow mismatched integrity profiles. I don't
> think NVMe should either.
> 

AFAIU, the DM multipath is not a specification but a Linux 
implementation. NVMe multipathing follows a standard.
