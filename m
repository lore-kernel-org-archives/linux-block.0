Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793721058;
	b=I+6LUvaT8OBYH80XbyCTgyBmgqqE54pYcbp3HrXl/dFh3RiJQTmPZuqvsoZbTNl1sV0d
	 SdWJmhHM1wXi7arjNOKDNJQPgSQHPCy5pAicWFqFQfadGftCLdWzCOyRL6ffn2F2BenND
	 AepxFF/O0PGGR8VhTP0If1v9WPp/CGQqIdD2HU3DvHUKaJFejsR7Pgbyn+OK2UBqXTP8g
	 STSqesyg/rtBpojLb4P4GlcqO0w+LhMGVc/d4YbMmVgVJCoUY3yJtmoEKzmN7bLT0cHCD
	 JeWjTcZ+DfcPhAMgSKjltYO0jD4+6jdrIMjcoPsPSJDeJJ3yVYs+6epNMHnXoEKWDsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721058;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=b1NBf00Rb7dOPs19r/c6RTBNnwcB4TdRTWiigDfv5mM=;
	b=M3Q+tDbuj7miwOZjYQb9O7RXtPvX42tsNavM0oUSVfVRuPDJ/QvdyxWyZm47i7CmeXvD
	 h/+zAeQfMJO+3NOxEf5z9bWd8dKDOe15vTYOPHv6DVPihfYAmd9yWoQe1wucuwcS1KTzw
	 EfpxAKRFkWcWU4GAZ0gTg87/ktGw8Po+6Bm1CYhNzCLa33C6lRC/Sc9ZhiZfao6ehCzZM
	 upcYZL8pwPZkNfp6Br/hLDbaPbgLFepEqJSmJmoBuTe3CW1vVK04yinjYMDl7RY25YJVB
	 ItwUPL6TjfNKOPVuqon18pTI7N1FNuHffPku8d/hWpsqq1K42oWCmLnS0qLlRhOOftw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.135
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022135.outbound.protection.outlook.com [52.101.101.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FC606A32F;
	Tue,  3 Nov 2026 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B48FC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl3yGCjjEX0pJ0eiXzTXSDs9PVNzaLQ5V1HaRmz+KyDRqrhdKbgXzL7I0xEgfRFuEU96Q4CiDItloTB65NUIeECoZjXlhJ/Zw73sSuEL+Vpyu5xiUNA2VLvBKFkUtny8myCj3YSD0FegvcFfBvdHGQGU8bL4YWhbNsxX+NmQkn7E+PqAaLV0k9tHUCOFrcf+kFYAS6L6lPr6EcqmgPZz5dGIwSz/cCbHvRqzX2wvN1Wz6KJMrqySgmZbpnitSeWzdp1qAPWCrpK4T4NIZrC9ZaMx+R5hi1qsqfBVwd2xxu5Ax32h3+JjkHd86Hy92tdnRdB5am2kUPWkG1lvn8pwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=b1NBf00Rb7dOPs19r/c6RTBNnwcB4TdRTWiigDfv5mM=;
 b=XCT2dt9mCxsUp9Iu30Mld2WVSgSImKMpb35dtEKxarP0HWsNcWz3ey0mHl7Cx6AD0ze7l9XGPK+j2dE47NDieRMC/z7LdhQcPgQ7d3BaxYd4FjV6sPMptVUfmef0l/Ohzmngn7Q/mWlFwNNV3xsaK5rPPIj353WDtdKtNrGm/NGgts37c89nwiCf661Y9BZsJY260SYrf2zvNFrqOgbeJ4rSVPwr0wg07VLTMZlLyRtProFeabJoBlEymO6uB8YweA8QhHo3Jx/+Yzzz2lyTf7afQFo+rkavJ0bnFSa2s3QI1J1u2bNwVjWt8CyweWI+i2ZphTvk7L0RlTBBDxYOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOYP123MB3166.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:50:54 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:50:54 +0000
Date: Tue, 3 Nov 2026 10:50:50 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>, 
	Surabhi Gogte <sgogte@purestorage.com>, Hannes Reinecke <hare@kernel.org>, 
	Nilay Shroff <nilay@linux.ibm.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Maurizio Lombardi <mlombard@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <54jezeeuin7u7g22uuwwf273kmvw4acwezw2tb5ulpuyr5iyu3@hwertv3q7aie>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOYP123MB3166:EE_
X-MS-Office365-Filtering-Correlation-Id: b08df99d-e900-4285-1935-08df39c23e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|261009223027099003|261028144727099003|261102130727099003|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YeuHxbPt0Hsn3T01a+IhkHnOdmXxDs8CD5fcQOoM9VOnymZWp2/Wyq+2oicCCmdQ5cQnzReon8oIn6fPOqDq0FeUJYbcVs0qgOYPfoZdghfYlWSUvtfCqnf1zVqGGDOTCDrWGFsJqk8k0dT+eMgh7CKiJhVO6rrUbualqJpMUckYhu6BxtpF/VdOiOR0F6Y7MNyyosHu7bcQTe6342X6WL5gAjqZQGsC2Txg8CPkvh4Q8LXXh5DhosI9k+zq58M4V8dmAldG+O8DOSwzQeyPtojotEXyDghpPDRvo7AFG4DfIUGiwMj+PN056NA3jaLZ/NSMkM1FcjzythBHv9xXKs29NzvStdLMmRolS2fH691vxG1QoX47vIsxlJNp2mQQM9LmYNfNBlrlsQ+WGyuqnjY5C8Qnx3vi0ugoGmDrDYUIDR3unAVEAEx9fjuGxUvBTFJmdWxLrXQKRa5I6skF3TbuzPdcxHZaiDC8lz5qA0Icr3Kcfud1HPCP6R5hJ6fLcLJ3ocNZOI9nNnoTGOeTKFFt8vR00wGkoVeY/gO70Obk2qvZd9e3mLq5kBydYumg9HjsdcCaZXmSIuP59DKW2BkE6ectNM8Z9lntSF2H1MK05wgmJ5d8JXXa70mJaEQ2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(261009223027099003)(261028144727099003)(261102130727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUt5ZjdWd0Fyc2wzSzcrSW9qSVcveHlRSHdpME1MSUZFcmZPL01KTmJLQWVN?=
 =?utf-8?B?WUxzNWw5aFVrd1Z3U2QwSnZhNmU5UFBnUE9EbDFKQ25NOHkyYkhsOU43ZUdi?=
 =?utf-8?B?c1FZaE4rNDVJdzZGcHZaMW5YRzA4a2pWdHBBbklmd2Q0c2VRcFlmek43Z1hW?=
 =?utf-8?B?S0JmT3NLeDRpUE9pZkZHYXFlbWNWNW5EMGQ5RkpRZjExejNlcXhmbDlQY3g5?=
 =?utf-8?B?d2g4bkJvOGh1SU14MWNEd2U5dHByb3AzL0RQWEVuRy9LUk1yYTZSV2VCY3R5?=
 =?utf-8?B?bWdwL0JJYjlGM2tSOFpVWDdncU9hcVlLalNRZEo0Zk9lUFhGZUtUQ2xMUTB5?=
 =?utf-8?B?T1JIQzRFVHZjbmdkUGxqSW9URXlNNnlJU3haOU5FaGdhaE5lTHU2dEdRZ0Nq?=
 =?utf-8?B?d1pEakh2UDh1Y2lXWHFZcktKakkzTXlRZk5FOC9jWi9meVN1S05CQ3c0WVFF?=
 =?utf-8?B?L0VUMGdKYUtoRmM4MmJkQ0xnWlpsZnFReGxKUW56cHl6ckcwcklQS01ZVERG?=
 =?utf-8?B?QVZrRmllTHZXTWp1UGcwSEhlejVQQ3gzbnVhT3NHMTVBMzlTNUthSkZMeFJ2?=
 =?utf-8?B?alFUelR6UHFtVkY0ckljM2FTNnZleEEvclhWL0crVHgrTmordWF2a0trMXhy?=
 =?utf-8?B?WUNyY09jYkdUQkR2WTlLVUd0V0xmV2dwVWFZdWNpS3JBakprRHVLN3VmTGlk?=
 =?utf-8?B?cHBjOWg2eEp5OHJVVzNCd3NjbWE2OEpycUUzVE1WZmZCLzcwT0IxcjFUVzMz?=
 =?utf-8?B?aDVjNUthWHc4aEw1Tk9zTXhnWDV0Q3Btbk1kR0M0RHhZTXdmM29XalRPSE9x?=
 =?utf-8?B?dTRFQk1MdTJoSVFqdHZZVjFTK0M5WVRCY0RlL1RZeFN0MjdsU28yZEZkdW5H?=
 =?utf-8?B?VDVxenkrZGZwSzZRKzVnMmdHbWhlQjRVVkpHNncyRVZxZmt5QkYzUnd2Wk44?=
 =?utf-8?B?UEczNlFaUktvTWlHTTZjTVl1Q2IrZzV6ZnRoUDJNNzBuM2JpYVA0Y2ZyckdK?=
 =?utf-8?B?bnIwUkhOcVQ0U3Z3VjV0enRRQmMyM0FrR3Y3TEJLdkVFWWY5cGNwZktuRXgr?=
 =?utf-8?B?MDBQVk5WNmg3Nzk1c0pPT09razNKcGJGenNaQlhWZGJTWGs4ZmQ2Mi9JYmRn?=
 =?utf-8?B?OTRCVC8rQVVrRTBUcVoyL0xSYlV4YUlPZmtrRytiSE9VcVhWdnpVR3ZXLzlk?=
 =?utf-8?B?UlBiWkFLSDBoU2FZb3hZbWJ6RURxTXhVVFQwOWgyWmZRUXRTVXE0d1M4NVZQ?=
 =?utf-8?B?K0wyWm1BMDVCbFFZeU1yVEV4SnVqeWVWNW9qUU54T2R0WHd0WkNiYkVEY3dQ?=
 =?utf-8?B?S1BVcnR4RDg1MXU4bklFYldmNlY5OWo1NUpnN2VOcGQxY0NhZ3RvUXExWmNG?=
 =?utf-8?B?Y2ZpWkhjbnFNK0FQV3JxTWJUdGcxZ3grZkpoakgyNitrTDFxdHpaTTc1WlF6?=
 =?utf-8?B?WXEzRFpaVGxqdUJBU0lPZDdNVlVUWE9aM3Zma3N1STdVZ2ErSmYrTXJDN1BW?=
 =?utf-8?B?Z1p6dFhSWEZOamVJblBWVWdkTnpaKzl1b3J0a08rTWR6Yk9EbkhiazJ1UktV?=
 =?utf-8?B?VHJSQjd5cXpsSnlYU1ZzV0xpMWZmSllIRHNCN3dHZ25lUktVdkdHZ1BVRUdi?=
 =?utf-8?B?WndqSys1bmxQdGxnVWxwd1hVOU40WXVJOHdkSXgwem00N2VKczgxR3NldnJO?=
 =?utf-8?B?c2JZbG4wUHc5N2ltSC9NcERvSGNTN3pSN3NNblFpVjNXOHFuamJRZE9VZm9n?=
 =?utf-8?B?SHZrUEt5My9waGRucGw0bDh2RDhDVThRdG1iRkxRbjcza2s1OUo1eTVlK0Yz?=
 =?utf-8?B?WDdGejdRaW9sQVNRZFNBL21HY0xoNWJiU3J4MkRiS0JqU2Y1NHBIem1IS29Q?=
 =?utf-8?B?RWtQVU9ZUHFYY0NRcjlhVXJpaEJYWFhtVFM4REhMemlIblhGRFpYU3dFa3Jm?=
 =?utf-8?B?amdtSFVzaXhhWTdhQTN6Vy80Qk9ZVnBMUzZWNTQ3STF0L3FRS1doWmdpazJ6?=
 =?utf-8?B?RmljMHNqdU5EVlRIby9BdnhiUlozQWk4UVZTcnh2M1VsT2prRHFONDczMzhl?=
 =?utf-8?B?TmdWUi9JcFRUVGRERTFOVGNQYUIwMFc5bHhKcWxJblU2WUY5WTVqOVBQTmVn?=
 =?utf-8?B?QzhCZWFvc1hXNUlUbUZqV0RHUHBoKzFoYllHVW5pUXZxanJZaGdSbVI1MHoy?=
 =?utf-8?B?UE5uZ01oYnpZUXc4OFpXVllReHAycHZWWklxWHB4UG5KNm5VRlVjenZqc21J?=
 =?utf-8?B?dTljNTBNeGxqYnN3dnVqWEZ0cXRQeWJRdXhsVTJyNDI2RWpML2tEZEVNeC9j?=
 =?utf-8?B?bEJVUUpiZ3JlcHN1YjZNZkxWUGFvZWthRU1yeTJzT1FRcFlWUEZ0dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08df99d-e900-4285-1935-08df39c23e49
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:50:54.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXhqfwGUG9jcTmwa45lJdr6+uy8BPCUVnktN5FdWDToTl/MaWWM8zHePU+hmBS0Qhec+ES32jL6ALfsJXGcY4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3166

On Tue, Nov 03, 2026 at 03:57:22PM +0100, Daniel Wagner wrote:
> blk_mq_alloc_request_hctx uses the first online CPU in hctx->cpumask to
> select the software context for a request.
> 
> Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), hctx->cpumask excludes isolated CPUs. If a hardware
> context is mapped only to isolated CPUs, the mask is empty and
> blk_mq_alloc_request_hctx fails with -EXDEV.
> 
> The NVMe fabrics transports use blk_mq_alloc_request_hctx to allocate
> the Connect command for each I/O queue. As a result, connecting to a
> controller can fail when using isolcpus=domain or an isolated cpuset
> partition.
> 
> Passthrough requests bypass the software queues and go directly to
> hctx->dispatch. Their software context is only used to select the
> completion CPU and as a hint when freeing the tag.
> 
> Use the software context of an online housekeeping CPU for passthrough
> requests.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Tested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=domain or an isolated cpuset
> partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
> kworker on isolated CPUs") the CPU mask of such a hardware context is
> empty and blk_mq_alloc_request_hctx() fails the Connect command with
> -EXDEV. This patch lets passthrough requests use the software context
> of a housekeeping CPU instead.
> 
> The nvme fabrics fixes from v1 (patches 1 and 3-5) are in nvme-7.4, so
> only the blk-mq patch is left. The blktest for this patch is nvme/070,
> posted separately.
> ---
> Changes in v2:
> - Only the blk-mq patch left, the nvme patches are in nvme-7.4.
> - Reword the commit message to describe what the fix does (Hannes).
> - Add Tested-by from Maurizio.
> - Link to v1: https://patch.msgid.link/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org
> ---
>  block/blk-mq.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5fca78778c31..77685e6283fa 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -717,6 +717,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>  }
>  EXPORT_SYMBOL(blk_mq_alloc_request);
>  
> +/*
> + * Return an online CPU which is neither isolated from the scheduler domains
> + * nor from managed interrupts, or nr_cpu_ids if there is none.
> + */
> +static unsigned int blk_mq_housekeeping_cpu(void)
> +{
> +	unsigned int cpu;
> +
> +	rcu_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (!cpu_is_isolated(cpu) &&
> +		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	return cpu;
> +}
> +
>  struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>  {
> @@ -767,8 +786,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	if (!blk_mq_hw_queue_mapped(data.hctx))
>  		goto out_queue_exit;
>  	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> -	if (cpu >= nr_cpu_ids)
> -		goto out_queue_exit;
> +	if (cpu >= nr_cpu_ids) {
> +		/*
> +		 * Isolated CPUs are not part of hctx->cpumask, so it can be
> +		 * empty although online CPUs are mapped to this hardware
> +		 * context. Passthrough requests are inserted directly into
> +		 * hctx->dispatch, so use the software context of a
> +		 * housekeeping CPU for them. Inactive hardware contexts have
> +		 * no online CPU left.
> +		 */
> +		if (!blk_op_is_passthrough(opf) ||
> +		    test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))
> +			goto out_queue_exit;
> +		cpu = blk_mq_housekeeping_cpu();
> +		if (cpu >= nr_cpu_ids)
> +			goto out_queue_exit;
> +	}
>  	data.ctx = __blk_mq_get_ctx(q, cpu);
>  
>  	if (q->elevator)
> 
> ---
> base-commit: c8c53d669d4e45b3a804013251a34387d7e11bfb
> change-id: 20261013-nvme-fabrics-isolcpu-5b4948362f88
> 
> Best regards,
> --  
> Daniel Wagner <dwagner@suse.de>
> 

Thank you.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
