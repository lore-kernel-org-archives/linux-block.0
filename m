Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC427A457
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537401; cv=fail; b=MX2Hmwr4hTF9EXKA35q18fXgHagy0h+vtrDASGc1wJfburvK93eBcsYFWUw3iRUrJapuwZ736S8/el+irZx0BdyqAH8kMbV5CG3zioNvxMLznf3liOLFMj4kJaZOHfnXd9djmTtbGFX7kuOOev6ZO33sMfvB/XmDzVMAzY9dvJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537401; c=relaxed/simple;
	bh=nUL12NMxJcbwvsmp3oMCBEaZtW+I1N42g89krPg39h0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5LGU1POk8BlVQSDXPiVyRn8GVlOWZ2mHJc8SYiJvExZhTccOZ5FlZltFEeydGpe6KISznfhdKL0w8TBIRzQ0GHLoecQ0DVBohux9kbrJJVXFVXpVq06yvWCZgC75qtIhg7p8hEzoOkHQ/jdKWd4QmBxDZ8WHdCFLChRJQ+mHS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZxQ9IQL; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZxQ9IQL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTTrzfUFlwAfNm244KvbgddgMYEOxSsSCoiMZ3GtuF4NgpXhuIoFC1nEsqFy9IZUmqeadhJSOEBU7AFSVMRUOIckRucpOIXt4XlCpPZSks8JWxEJUC5/i9oL+guUWLcT3t8pkrb803lfVAS9OfvP2UoUTM+qkf5Zzw1IN49bBATBOY3mGsAJmkxL3SMu1pUtJwuBCW3ganYtDGt/uerraawSV/cHvnvtIWIMzlu0hcoX4dTrws5wj2YuZ506CHZso1+mrSjLcVu+MzmqUn6FnDKKZxJ7GDED8M76T9i0vb6GX6+tg9eoLPzOyzxlIq4LkHkvH0DKw+BwZ8Tbuw8ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl8v7CtbQHPXH9Zrfvsj/ZHp8Q5VvLbKMBZrbt8Q+rY=;
 b=dgwypwnUdfWtu+ZzqEbQj3s3wUaSZ5TJlDx5MyT0GQCg5v/h46UrzvRNecfgr2phEhn/US/RMfPXzJVYsFLPP5t3LoHhprfkZbmIK0Ki5YUpes4XoO1rU6Bl0ULi7qj9XVhuWpuE7Rr7WNC8O+eJiJCSrLWqXYde/8QD9eNyZ1sad1MWUDVSPS+bXE0v+CJZCdT/T8kVHazNfTFAdFMZ8NghDpXKkIqlfEymLCPdwf2PTPwFzeF/4G+7s51cwxogD+6+xjil2cUi0EKQsEjr8zfVzBUJ4kbk9Fpvr7lTsADnyvQFLLEVe0kXPmRU181a/CnqeoszkEVfK5xk8X+cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl8v7CtbQHPXH9Zrfvsj/ZHp8Q5VvLbKMBZrbt8Q+rY=;
 b=DZxQ9IQLNBvSwFOWbfHIiKuodaWRbkGOKwFP01pAFJtDSWo290kCEFB1feYNC5Mf2A5WMTK/srAy0knlHiX59Ndqk3UCat4aMuiEZrRgre7Lopshl+wp4oififuTs/n93WO/bAJKdC2B4cV9TXCxojekOTpcuFvX2yAy25klZwsd+fxBRoSsZ1GCsy0jV+BFG6UVDw6YpJvxajqVx7JMpvQJpn5gy7SCq8nSSgFBNsh/I9SL4KnrOrdYoYBjSLzCL1OKr5mpB/HICM2XX7MO1FKklLmdAoNijvrQWF8GIFcEmGJyPec4tP6HztYsLjT0u24qOD09JxlpDVIFy3txyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 13:16:30 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 13:16:29 +0000
Message-ID: <df889108-6b11-4cb7-b77e-8d27922cbbc7@nvidia.com>
Date: Tue, 6 May 2025 16:16:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Port to 6.14-stable - ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <9a10100c-9d76-4522-9f6c-d0a6ad32ca81@nvidia.com>
 <aBlwTtmeZErD4gnH@fedora>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <aBlwTtmeZErD4gnH@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 018a1cd2-29ea-4cce-cdcc-08dd8ca03680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdVUVVNODkzVDBBU2M5VjNIVGZuaUZyelZXOFVCanB5Vk0yTzFrb0Uyb20x?=
 =?utf-8?B?ZzhOdWVVTlhxSjRvaDRQdjVDYmRyUE9mV3BrMHVmeVpMR3lDSklYdmFnM3Ux?=
 =?utf-8?B?VmY4K0NMSCtJTVpqL0cxMDREM0l4eGhTUC9IWUdjemtuZDVWNU0vU1BxYlJ2?=
 =?utf-8?B?UzdhVlQ4eTlpaVRRQ1NLajVMb0Zoa2Z6c1BnQllrYUtKMlNxYjFHYk14Z0c1?=
 =?utf-8?B?ZDY0S1Q2bHVORHl4dDhHUGNWK3psYzlncEFsT0JRL1JuanQ4VVlmZFZ5cTJ0?=
 =?utf-8?B?VUZJelZPV0FWTjE3WG5RVlBUU0k2cG5KTGo0WkIyd0RWZ2drTUZobnJTTG5F?=
 =?utf-8?B?ZFE4bXBTbnF1aU9TRldORUxmL2VnM2hpUVY2cjhwM3FGdEM3dU56ZEJ1TEFO?=
 =?utf-8?B?UUluR0N4K3FlUlNhRWdrUGNmWXA1NDJkT24wYi9yVTNMNWRrc0JWQ2pBK1RO?=
 =?utf-8?B?bU9MWnB0VWNvTmVkc1F4dUhKODVjVUNMWjJqbWNFTm5WR0p4S2VybVRMcTgz?=
 =?utf-8?B?cnZVSllaNEo5eGlKWnlPaWhkalU1WTcyS05ISEdES0pjQWVhcTZOTHlpUE5v?=
 =?utf-8?B?MHJtS2E5OGZGTFpvZy9BY1E3NTMzU2tQZDcyT3NQREJPY3JjQ1QzbFdORE9V?=
 =?utf-8?B?WmVTL3VQVUhkNWIzSy9GY3JUS0hnOXo5dC9tVkVDQVJYNGVuVjlDQVVXYUR0?=
 =?utf-8?B?M0ZKSnhUOXo2cG9WdWhZZzU1M0hWNG95b2tSdldCeUNZNmQ2NUFvUmVnTkdk?=
 =?utf-8?B?OFBiT2Nielp6K1BpdEY3TURIbzROK0lBTXdJZ0EzZmQ4dk1ZOE1iYWZHTEVz?=
 =?utf-8?B?S0x6NkpIcktIajVDZHBaWUhjSFlNWHVWcldFclo4Uko3R3VxV2UxcG51N1V1?=
 =?utf-8?B?d20rMDhwZXE4NUlSNHJDbFVsbWxzV1BKTUFTRlEzRklKYkxEblZHcGxGdm53?=
 =?utf-8?B?RlJDcjRkdzMrWGVyWVZVMVBYMnhXUkJkYjFqN0tPRzF6WVVmWDJpUjZJQ25j?=
 =?utf-8?B?R1JBKzNSY0pIQzQwcU1yU2JrT3Q3Wjl4bmY2MHRQYVdGazJSK29HVmxHMnFH?=
 =?utf-8?B?TlpmOFBCMUlwVlRScUlRTVFSbUxCSTQ0MlNFTzVhYmNodlY5TDBPOHd1cit4?=
 =?utf-8?B?V1JJWmdWZUo4UGtSZkp1VWdGQUZiemNnSmhrM1p5SzdRVjA2ZjdRbEdUMjlD?=
 =?utf-8?B?QlI4UHdObklZd2RycUtrbHFyV3RCL2RBeUd1eU9aNDFQbTJDckpJYVNyYm5y?=
 =?utf-8?B?MDFNMUptT3ExdXY0SVNuUzJ4OW1rd0dzZFhndHEraDJic3ppbjc4eEZ1ZmxC?=
 =?utf-8?B?c1U2TVVOdEtFdTVGT1NmdVlEYjhTY25LWDN5ci8wZEYxZFU0WTJsYzVOWlRL?=
 =?utf-8?B?YnlhOGViMFF0aE5xRVI0dXVaMzAvbVZuZlNqdXg3VHJ2NWt3cWF5TllSLzJQ?=
 =?utf-8?B?TnEvemt3RVBWdnBTeTNnMCtLc1ZqVWl5czV2WnYyb2lERFpaSTJDSXo5andm?=
 =?utf-8?B?dTEwcnRHTVJ5VVVLMlo0WkpPek5lTGorbEF1SElKZ2dPY04rK3VYNWZRejhh?=
 =?utf-8?B?Z0xiVlpTNGQ0cFVNNG83aVlORS9jSEFDNEJQMm93WGswKzgzYmIxM0RwN2ho?=
 =?utf-8?B?RG95M2RMZ2licVRQeE5LVGtxUG9hanFMckxUMElMeEV3SGFtR2VRdkVucUxW?=
 =?utf-8?B?RlMzZGthckRuTEhHVHNGL3RZVG1rbDNRQVBRaktKck55OC9HSHhURUhPa2xj?=
 =?utf-8?B?emVxSmU3dnBPeC83SXQwWk9Ec2ltM052NWt0RkFyaWpnL21qN2loclZvVVU4?=
 =?utf-8?B?WEZiZkowQTFqVmNkUXpIQWhuM25YcnF0QTNOL0o1NjFrRmFVS0xJOTZiZEMx?=
 =?utf-8?B?TXcwanlVb1plbDh3c0x2UTBVSTBWQmpwNXpwYXY4SmFaYkY3REpHTmRKc2E4?=
 =?utf-8?Q?sO4f3kz9tS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdsL1IyTk1qVlpGdHZvcTBDTXpZUFdkYmFPcnBUb1F0U01GZ0VGczExc3Bv?=
 =?utf-8?B?R3d5WDl2ZGNEUjFaMFcwUnkyNnd6WEF2Q0NjSHplL01tc0JKbGxUT0l3VjRt?=
 =?utf-8?B?UUp2Q1JOZzU2YlRhQ3R3cWFZUlY3elpEZTE1NFlaS2lZbWtScDlnUk9RejFT?=
 =?utf-8?B?b01yL1VUbDljNWdPRGhUK3lFQXRZV2F5LytQbnNMUTFNeDJ6UHhWNnNweGRw?=
 =?utf-8?B?NkdGWjcvWVZTZllWaWZLNE9oM1RyMVRGWVFsTXVlaWI2WVhubmdrbXFCWGl2?=
 =?utf-8?B?QTdDR1Q4Rllud3BpYTE4RVZ4amhDRUoyTkhIaUwwL1ZRTE9jZk5OcUh6eFFH?=
 =?utf-8?B?L3NwR2s2VC9lVnlQbXpiR0RKdEtqMEdPaEkxSDZxYjZady96MUVqUjBQeHVH?=
 =?utf-8?B?aTI3dmZEejJqbkxtKzZCUk1CZ1pHdE80Nk80S0pNaFNNTFBhdHZ2Y3lJVFll?=
 =?utf-8?B?dDg1Y05MRXhGNFcvaFdjU0YxZmo2c2N4dXFYdjROUkE5V0h6eExtWnFDT2FC?=
 =?utf-8?B?YUhtL2lBUGEzcWFOb1Z2WWp2KzJHLzMrcWt2eXZ5THBWRElqNFFOSTRCV2Zs?=
 =?utf-8?B?c0FZQjdwamhnb1BvVzhmZmlJUzlzbk5HWlBVejcvblNicUdGSUl3YkkzcldR?=
 =?utf-8?B?bEpqUm4yZEI5T0ZrL0Q2c2YrYVY0T2xFSFA5cUVtUHRSUk5FaTdkUVo3b0lR?=
 =?utf-8?B?UXViWkZFNyt1NUNNbWl6QTlMdzk1NVN2dHg3dkloZkNrWS9WaS9HZW5IcGVj?=
 =?utf-8?B?WkhkVHFGSGp4V24xWjJGd05KQmVWaWx2NVlwaFhZdW1YZDlJUzEzRW80NUZE?=
 =?utf-8?B?ejV3YmR0YTYzclRnc25GcElFZDVkaUVlYWFpdmVUZmRJQU8xUmR0MHB3S3Za?=
 =?utf-8?B?NTYrQkJxeHlVWjJ5QjVqSTlOVFJnVVNNejJyMGdkd0tQNkEwdXk2MGkyRE5B?=
 =?utf-8?B?OUtWQ2dNOENnSjJPbVZCQUlvbW4rL2FQc2NIeXVNaCtWNXNmVkdwbTA4MmIr?=
 =?utf-8?B?M1Rhdkt6Nk15YlJVaS9VR2dHcGNKOWo4QjVsOE4yNmlINTBEWTh0OEhCc1ZR?=
 =?utf-8?B?UlhXRk5hTnMyNVRaYmliakxVaHBwbXQzRnFSamZsaFc4cUxHNUl6TDBRL09j?=
 =?utf-8?B?NXIzdGljZ3lKLytqakk2V1EvN0VueGRscFNWZzYvTFlQcG4wN2NCSk82NDk2?=
 =?utf-8?B?TEtraGM5OWtoS1pBSFhQRitkanhmaVhpU0s4RG9Ga1A2dFU3UzZOMnRoWlZF?=
 =?utf-8?B?dVl2YmEyZW51OEMxM1RnUFl3SjNwUnd3U2F5TTU4SzFnMGF6U2NBbjVUMG10?=
 =?utf-8?B?NEF5Y0xuTmFVQkhlUVdNUnNZREdhOHJNRTNzYy9hTHVaZnFaWTR1NmRUZTBq?=
 =?utf-8?B?NmFWWktCOGh4MmFicWl4YmNJaWFNalpDeVhSQ1FlMmNJMS9remhEZDVaNTZm?=
 =?utf-8?B?TUVHOWNvQ0pHRWtlcnp4a0VxZStZM3hqQWEwZzZQbk1BR3g3YmxqNHN3WTRH?=
 =?utf-8?B?NUY2b0QyaUlzRmh1L2NrY2oxenU4dXEraWFqSXpRL2hsNG5VcGwyakhYejZh?=
 =?utf-8?B?STNFbGNudldmdkJMY3F5Z3lOSWNucW9qSWhYVnVlU2h5alplRDc1Qy9na1lC?=
 =?utf-8?B?eXdvT3VGdWVnOU1tYzdIcEx1TVQrWDZybkFIbUNvcEltUXRwV1EwZHFpcmRa?=
 =?utf-8?B?eEx1NWg4S3QzRjZZQUxnckNtZWVHcGtCZERCWXZNWmZqNnlJdVVEUlY1SUFl?=
 =?utf-8?B?ZWFSZkVBRUtwZFlDUlhxUzR1WjFPZFRqRHJhV2xuWDlyeG9WUGhmejlEYndR?=
 =?utf-8?B?S3djSjFRbC9wZzNsM0lVRGJTbVlFUXRXTTArMWozanFFNUVXSjJNVnhFcVFu?=
 =?utf-8?B?eE8rOU5CZ3JZOUVmV3ZnTmQrc1lwVVRqL0VRUjFpUDVlWi82RVhwMHo4WkNx?=
 =?utf-8?B?aThGUzFKSlhaRHRVblNyUDZXeDR0am5BcUMvL05LRUhJdDVTWEoyVHVPMGZY?=
 =?utf-8?B?YXNzS01adFJqRWYzbmNkV1JnRy9Ibk9VUXYxTFNFdzVNNFN1elBFc3ZGckJT?=
 =?utf-8?B?QUwzejNUWkd6ZE01TzZuWWdXQlFCWm8vM3hoUXZPNzF4SnBCeTBsODFKdC8z?=
 =?utf-8?Q?93kMT4dMPqHgdd+6iA/s9ZbAK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018a1cd2-29ea-4cce-cdcc-08dd8ca03680
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 13:16:29.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIUGOAWiu1qqN6EerYU0R90Rwxh/B0hozbW80tazNVufDcuPaSIvyS2DFXz3RltzopcQhVt001sDTc3+qJmq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

On 06/05/2025 5:13, Ming Lei wrote:
> On Mon, May 05, 2025 at 07:06:37PM +0300, Jared Holzman wrote:
>> Hi Ming,
>>
>> I'm attempting to back port the fix for this issue to the 6.14-stable branch.
>>
>> Greg Kroah-Hartman has already applied d6aa0c178bf8 - "ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA",
>> but was unable to apply f40139fde527 cleanly.
>>
>> I created the patch below. It applies and compiles, but when I rerun the scenario I get several hung tasks waiting on the ub->mutex
>> which is being held by the following task:
> 
> Hi Jared,
> 
> You need to pull in the following patchset too:
> 
> https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/
> 
> which avoids ub->mutex in error handling code path.
> 
> I just picked them in the following tree:
> 
> https://github.com/ming1/linux/commits/linux-6.14.y/
> 
> Please test and see if they work for you.
> 
> 
> Thanks,
> Ming
> 

Hi Ming,

Tested. It works great!

Will you be sending a pull request to Greg or should I send him the patches?

Thanks,

Jared
