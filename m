Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69E1FDE19
	for <linux-block@vger.kernel.org>; Mon,  2 Dec 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134163; cv=fail; b=fsRtLtGc75PCCUvatsu9c9BskzA6iXWP44Z6oZmZOziS+iCx6JRjXoy7UMe7XJkJvWCKRWD6nnblXMh99hjrr8PORXRqIeqCeWnw6dfD4rywOxwBnf/3irZ6/zJqEY9r0vGZhMVV26DGjSw11goL+nf4RHk84Dtza78XyZ6CGa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134163; c=relaxed/simple;
	bh=jaQ+PKrXNiMnJaJz5VuzEsfDIzBIkw5h1slkmgdE26g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=lKTvDES9vt4UWrr98H7Ymr6FIPAcQcgM0TLxWIuuBXBEL/1WRE1grEQ1JVnouonOMAW+05Q6b5A7KFh3zCLMtR/A7OnkSFZ7h9GHUNDfcIbBo0qPuW3SVPFPnmbl35Tw1BNnkvOGMCKuclcEQpsGvOmv409fsZM20bMt14jkDyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVRE2vu6; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVRE2vu6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/AuuuL2sMCOSBcLNTS3HQGPChnu0iTTFd8YBCy5gMk4DKAMvk3GnEnZv97PDH85hLYJHju8CtBNsaUR+IeLQSl2iueKdy3SsTayj4w0j4qMiKNH3nBaHPOWwl11nCzglnhEAMbyrsvD9m6uYXkUkERjkR8eXXpXzlygMTfwoxCXYLKtSOOymKmPPHtw+m8E2oatjh7ShFvmpSdOjuT6kk5aW2MGj2PD4C84TkXQJRuWhmiysoLaV9LfVKQ5CJCUZdte4bgoLFNoMbIKUuN22TnqvdcsxNhtNqGIGdJoM/bKmHSUFy/mmwkLmSeNLZqFp8pbrVdjob6Tx1dP/B9pJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXTJ++Ku47PXQH375/5mQOjnwUQq17kfI1rcFErp2L4=;
 b=Z23n70jeCI+LEjxFZThCjkzx0Jna7+OSKMsa69A17OOvbRscPx5O+yvFLsZcIvMgacHcPq2ZQ6c2ae7jtlQk5tgEgwX9DFTId3hoxZOXGmLTrnGaFxwQbdFv7ab5zmcRK2LSCmngkH7/+l7TXcn3+UTWj4g7cMDFmQ/SO4ebPZXakjayn6ATK+WOsd5PBnAW2bggWLlI/bpe3IwT4AqjkrrqfQ0yJFTzhvF0oS12FgGAhWhLi11AMjNmYZHeNohgiL/AeOcXtfq27kQnygRttO0ib2f/UC/y0pK0NkQCTtQv4YnNA95navJDoZqLzCDc0/EYvecSmhZGmf0kq0ZREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXTJ++Ku47PXQH375/5mQOjnwUQq17kfI1rcFErp2L4=;
 b=fVRE2vu69jSQDn8zOu1LzGah8210asR7hI3pFNPrGfAFtlqKMerXxambFxRsYr8IVGFNT4noz/M6mZJ2Hplux2iLM6XpjybiLVbqjAQIgA0n7nI22l11fgEeeban0u5OQrYoQWVVuPWqvuMeeUFVkNlisIEuxr7Y2uYavh9N6f6qJJOgfLH2KN3lOS6SsTALx65hSj7ZyO2gXneRpzR2Td8M0eUvEq/e1Rwd6EAYCN4lBw0PCk+Vzw17Yy2K2/T27Z8UIMiTnEkjKVXjqXzTtN3y97yKlpZGnYcZeHigaTYDNRonn6tMEF39ClRtWRNFELYTxPIdIVBgM6+4iL2wXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 10:09:13 +0000
Received: from CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7]) by CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:09:13 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Daniel Wagner <dwagner@suse.de>, Shai
 Malin <smalin@nvidia.com>
Subject: Re: [PATCH blktests v4 5/5] nvme/055: add test for nvme-tcp
 zero-copy offload
In-Reply-To: <5eqjhfwdxqiofyabkzon6qhcjwgpr7sqz3smlchorskyf7xoxh@t3j7og24ggdh>
References: <20241126203857.27210-1-aaptel@nvidia.com>
 <20241126203857.27210-6-aaptel@nvidia.com>
 <5eqjhfwdxqiofyabkzon6qhcjwgpr7sqz3smlchorskyf7xoxh@t3j7og24ggdh>
Date: Mon, 02 Dec 2024 12:09:09 +0200
Message-ID: <2537c8iv1kq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::6) To CYYPR12MB8940.namprd12.prod.outlook.com
 (2603:10b6:930:bd::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8940:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfa677a-1dd4-4d5a-a19f-08dd12b95f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L1iPP/N7ho5fje3d7Kx083LpXVVZV4V2tqSBUcPHvRWwM32lYdW+i1EYfWbY?=
 =?us-ascii?Q?sP8diN0xntAWfaIGVugM0Ms8OUFDBz1T9XlFuVkLwJKMhTMJQp7ZZUO3A4ut?=
 =?us-ascii?Q?b9r0mcxYr5V1Ysb6wCw1SG0X9B6MpDrLBbk07og796hH/tGKzAArBEmdzabR?=
 =?us-ascii?Q?0+dYCSLVMbWNH18k23byixjev2nYCI7tkZIWj7YPO757FNge1mUiahRwnq9k?=
 =?us-ascii?Q?sf21ctKBurf9JkYySt58RRa/4MBnz+yZe+T4UPepqwjhQycyD4clL0U0xd9Q?=
 =?us-ascii?Q?ZEZJjiJaDbpVh5OZ7tB0oyZXX/8raF6nYYclAcR+UNZl408FgcixFRgX86/D?=
 =?us-ascii?Q?w1qI9LDJpoaCfpkYPgiEUylk5eMmBepEIgw1H9NuJiXSjXWLr25wKxPxOPNA?=
 =?us-ascii?Q?oB1XmTChSHJnWF7sEV1BrH078Arh8RJ77aLR8ZpfBnKZG5byW9wAsIyZBuuy?=
 =?us-ascii?Q?8cdNlfZnmlzXgvqCbeYgo8LqBZZ4+gg9Mo1aIZB3aahuJHDba68OWn9b7RTX?=
 =?us-ascii?Q?USiNqnuyuJmMjsOj0ezZOrF7sbWnKAl2toviGYgbKOfAX4m2em7C8/7tVwEl?=
 =?us-ascii?Q?1Mrp1UeCkBGsjCsXmupmWbNevIDgDVpZaZ8Bb61FhOUVypBgqOowr7O4G8az?=
 =?us-ascii?Q?RIcWR9Ob5lV/Py4Xvmd7D+HyXKgtgS/cNScQAegyyxgfkBte+FmrOuNzPi1g?=
 =?us-ascii?Q?un+9pd6d8bLuWesSnZ9uxRCVU4BDu1Sqrjfi4pSz5XxpO/7ARHsvYmD8jGWD?=
 =?us-ascii?Q?wi/HA+uSNHkizeJI/e4RfXVpvqRN5X2pu5JPACuEowWhxIbS5CrX+Wwt3yAM?=
 =?us-ascii?Q?30GQcu8+eI3vNFa6W1533D5+HGxmf+6V0o+grC3etoWH3Voi1gFEOfPXDGGW?=
 =?us-ascii?Q?75kWJxryzP1LKobrZm0WUmDKsOwCPbO1doFfeCvz63AdOspKlIXyMQUY6/UY?=
 =?us-ascii?Q?a0KwZRvpAeRiqzU9daqVEBBZVjLxAX4xtexFK13beXgIgRZMKTVdHtss5K/g?=
 =?us-ascii?Q?93x8zs9FMZU//KWk7loh0MkqPc7Fca2wslOU0CkytUOXEFJRUPQJadF2MGwt?=
 =?us-ascii?Q?yeQn1dnlKry6Y61uhbTFw2jD4F7TA+mveokmXpDg52S60/itlEcUwTRNNDtt?=
 =?us-ascii?Q?/G4cTOF/x4J6fQfZnoCBzZ6HJ3Fsual349z+8wT9+P4Fdef87z4du41Pysgv?=
 =?us-ascii?Q?VOqfSIgXXLHkyDEoOhnSb45DP0xr945yt6KC45pVERFjSVxgD4j2JWSt5SRu?=
 =?us-ascii?Q?XaNJd0SFnEGFRS9Fa0Q1wv64d2KTTFnnohTAKNWjHcCB48t07gGfXRn29LOw?=
 =?us-ascii?Q?iPGEAwLjWfd+TLATzxiygNslVEhBPfts2MXty7f3Oj2PSSpTIQ8TKinubf4T?=
 =?us-ascii?Q?HftgdtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8940.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aE95ufZI/yGTgtO6Mu2oDCcI7um9VQFBwsD9dBTksS9sEaMrjJjItz69xe6E?=
 =?us-ascii?Q?Uh6A4xp/uIhLDI0lSOjLr+VBOXKwgrcTuhf2ONrnVip/xk0agEpv8Cc71oOW?=
 =?us-ascii?Q?8ZFsFX94o2ymu66sfAoTdKIaaTJfwjaS3tg2r2B2DGVAXzubaJ/gvN7vqkdU?=
 =?us-ascii?Q?VfD+KpBsyKeuZvpED9ZZS32D14U/3ZsN+d+VVUa8TO7aOkhRcY0mqd3Q+YGn?=
 =?us-ascii?Q?DrXod+RGs7o8XEnqqm5BmjI4npl6ZYWyIwPfcLdbzg1/7ZEp0Jy2s7x6lbBH?=
 =?us-ascii?Q?F8KnKVWJRedIXiLna36MJjmSQ/PCoo019G47iWOKt1ZqyQU1WUU+Y0DEXlvD?=
 =?us-ascii?Q?FdI7+mw3JlVcoFbTJGn8SbjpUgCncRLa0qlT64OzcRAdF1PE25510/vN72R4?=
 =?us-ascii?Q?4eV3H2tqCCZid/q5+qhdInX7mGriYvxy8I3HY98ELS+uYX2uRiwp1Ty2umPG?=
 =?us-ascii?Q?72znD0yEqp4Cls0auUbfLaIGniu70C5LR91LaWiA2lJUpXL5CP527hSbMeC5?=
 =?us-ascii?Q?J6Ijj+th2y2Ri9RhmN/TFAg6eJh/IgRxMLYXSh4H4vNUn2cVl0Z8TvLYoCdM?=
 =?us-ascii?Q?qAxH+QLNW8gbvmNIIcTZ5CRS6k0f7M6ptwkEZZ2FD0SBe/vfWofB5UIuq5M6?=
 =?us-ascii?Q?4HPwdP2H/30ucbC2G+7YimSVUjT+v82YW9AptfJaBURWd8Cwj3bx0E3rLP0a?=
 =?us-ascii?Q?Xpd9th1XW86yGDT1rloXc6uYXRHCoKoBnacD2WSlOZGwuZfuCe+JpdilcXYV?=
 =?us-ascii?Q?tXJfY+qAIP3wMNXj8A1jkgp8ptwIdQ4UBLRdNa2frp3B84Y4OGmvDhReV73x?=
 =?us-ascii?Q?pPzVemhvoMYDonUz4Joj5SqqI/Dy8gJfrldaLIBWMAo4I78qyRS4L6x63QzO?=
 =?us-ascii?Q?2FNpDYaLKLZx2i2fq2Si+jXOZbvEpbZPZ13O/BNznUUoQSCC/GMjqB6sn3kH?=
 =?us-ascii?Q?d4/jhcb1oGlZs1GqjQv6qXEtrHSv+dMkLs9mCpUAt0c2Aywo7JJaFYtdaHYO?=
 =?us-ascii?Q?LPW60l1cC0jz8pPvGdGa8RvwpL2Qw7tPrRpkWuyC9q5OjMMMTfHDORkCBM6H?=
 =?us-ascii?Q?Y2BL3bvc+oYZNQnTRkCsIfXlgqYKDmWOH8qDLdSTefxyPHxI0zBKpDIG/Y17?=
 =?us-ascii?Q?JZDHc2ugdFFJEF2SyQwVyBsEi7/BrjFRMD2CstCuJVA/IOY+cpWOjVZb5gHZ?=
 =?us-ascii?Q?ybIli/aGxpAD5RIw7MM60K2i3cR5lIkNDV3xpCSjcI1yUcX4er/1nJY1A4M1?=
 =?us-ascii?Q?RdKIk9ga57CuKLatL4OhF82ANGEXS99y84O7HjjgXqkY1p1HmDwxMkH/N+5R?=
 =?us-ascii?Q?QooyfTzxCg9U/QPRbP8uvkcF8TmE1Sa79pAcWsguBCgf0u4uUr1+8Rz2shK6?=
 =?us-ascii?Q?I96EJya7fJHBaZezrycAysG6untMkvEI8H0DAvg9TrWTGoIDRYAHn7lusnns?=
 =?us-ascii?Q?BuaIN/XKuAT7zzqoiM8yXoTA2IAzLu9VF5O7ue3ulSmzvQkdfGogzOxFlY7g?=
 =?us-ascii?Q?M6FrJ7H2qX5o4Cj37113+LXONqpl95AAg5RuG5aP9J0slCcpAStrKi3Be7Ce?=
 =?us-ascii?Q?Bn83EKCtmeqUOP44482HhukVy9BAf67JTSOlWwkX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfa677a-1dd4-4d5a-a19f-08dd12b95f13
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:09:13.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U26/0vQwns9vcOTtRJoQZ41BnWNLWXOOl126zyPy+Hs2OXm+MVbqaTKR+TsL9CRGUmec9gevpucYfsBuDABzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933


Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com> writes:
> My understanding is that this test case requires the target set up by
> NVME_TARGET_CONTROL. Is it beneficial to explain what kind of target set
> up is required here?

Any target should do, but the host needs to use a NIC that supports DDP
offload. This means the loop/localhost target cannot be used.

> Does this test case require specific hardware for nvme-tcp and zero-copy?
> If so, it can be described here also, probably.

It requires hardware that supports the ULP DDP infrastructure
(specifically nvme-tcp). This includes ConnectX 7 NIC and above or
BlueField 3 DPU and above.

>> +requires() {
>> +     _nvme_requires
>> +     _require_remote_nvme_target
>> +     _require_nvme_trtype tcp
>> +     _have_kernel_option ULP_DDP
>> +     # require nvme-tcp as a module to be able to change the ddp_offload param
>> +     _have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload
>
> I checked the latest kernel source code but could not find the ddp_offload
> parameter. Do I miss anything? or Do you plan to post kernel patches for it?

The DDP offload is part of the nvme-tcp offload series [1], and the only
missing part is the netdev maintainer (Jakub) request of including the
tests for the feature. We agreed to have those tests as part of blktests,
which we will then run in a CI.

>> +     _have_fio
>> +     _have_program ip
>> +     _have_program ethtool
>> +     _have_kernel_source && have_netlink_cli && _have_program python3
>> +     have_iface
>> +}
>> +
> [...]
>> +
>> +connect_run_disconnect() {
>> +     local io_size
>> +     local nvme_dev
>> +     local nb_drop
>> +     local drop_ratio
>> +     local nb_resync
>> +     local resync_ratio
>
> Nit: some local variables misses declarations here: nb_packets,
> nb_offload_packets, etc. It might be good to declare multiple variables
> in one line, like "local nb_drop nb_resync nb_packets ..." to reduce number
> of lines.

These are not declared as local because they are global, see the top of
the file.

I will declare the local ones on line when it makes it more readable.

Thanks.

1: https://lore.kernel.org/netdev/20240529160053.111531-1-aaptel@nvidia.com/
