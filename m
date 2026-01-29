Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9A340A4D
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682512; cv=fail; b=TG8j77ES6jzdebYgAf2KL9D/cD4ud0QNXOAEcRbLZ7vxbDmwVjKkl5Sd/RYQ/hQnyHujoHBQ6FCNqXi/N6Unkrh+rrH0Fu+spKdw8juc+WK/zLiFWY3faT66qNbe0qF8xIm7/UykZ1wtrasbQ5nmOto7RKTYjg6yxVIJTWsOqfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682512; c=relaxed/simple;
	bh=ddmrlL0C2JtMXj0KYMf7pWdTShjEJyGSiQsvqNs8JJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=b1RgJgGs0s5Mz3f/CW83d9e0RTTm9IqAbNasgTl1np7hSbjffZrQYoPZQThOMBtuV/cXh916eH7dIkuqM6936BlAEvFPuXD+4EwEfMoN4+F3C3qLUoEPWfQ29W1/PR6WvBcJiBvEx7RwDyfBnpro4fhnG2ysvjLmN+00+RYm35k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWSN6y/p; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWSN6y/p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPzC8NV8FSBAKROEv3I+K4N+sEeqJKgFVrk1aYoEFoqqB8RAAzrHySdGdTra4tQ6bjCjL1m2ZQm3QXD1I0aIcHnvgxXiu2AcPk/ILJmp3HXeQEDxOxk+aB9vD0jg95uTzs729Xp6bKfMRafTkB7tDliQNfJRUCfgAXc85tUezdrkWwwjsJVofLljGKeUrxknRh7UJapix7dpJSWYArk3DtDOkQUWRyHfW+I3xB1NUZZtxhFyuWA3aHeOMsR/m0asoBbYF4y6xlogdd+LoZOovt0oAKRZLFl0v8bt5QN7q9/wAbKlzd+//qqoB8mcUj3hSMLekZQjqigABCjNGKqzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddmrlL0C2JtMXj0KYMf7pWdTShjEJyGSiQsvqNs8JJY=;
 b=RtsO8ZKTDzLWmjvdTkpW/ZMXKBOfsVQUSphXN//Egd7tpQ/ihXHAyVhWtU5jrblQx8ZGbY1StjSoIotJz3BUeJuv/jWYB9/3zvTE6SB2FJ66PVRSsOOcGIIreo5tCiP339ef0hG+tYuqpgPGz7oKhl9boRQeN7JFM8oHYWEuktvOhb1yQI74kfmJKcxNnUxCOwDXibF2F4YprApqMBhTwlh9b4M1wsc6WHuC6sQZ4IoUPddK1nAvygEIgI5Onu0QYaazpC5Q2aBMV6V07vzcjh5jKpt8SAvQRM4LI6mrw0pYOQJ9V/i6GMzFAbszf/KSy9JK/rzxJQNJBgi6eFqO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddmrlL0C2JtMXj0KYMf7pWdTShjEJyGSiQsvqNs8JJY=;
 b=HWSN6y/pYv36ksYUlOJWwLR9LAXfUkBAU3EL0HarCov6mphdAr5wRZ4hl2znaJYTA2NgMvfUc7425jAewQIv2jde7Xupiwa+76TGgoVaAn6VRdG2g+ZuYwqlwZDsL7ZDmNo5exdHFykagJpx8dKvDufbSFuMpW07Uwspxptkd5u8UDGmIGrYxPziu3Ch0cMbOzYdYiDLiCY9DIKSBP1vcFHx3BJQHzRLsT0rY3dIGQkuDzkSGhnnHj7Ot0BdPgzMGa8dctabtZO7brneEjXaUKcJBc8H2jCPH7JfvRmat/PqQDqCGXNA0cuBPdB5xN8o43LpfGemkbWKW3YfeftjfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:28:28 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::74db:87f6:729a:6476]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::74db:87f6:729a:6476%4]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:28:28 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Daniel Wagner
 <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>, Shin'ichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp
 zero-copy offload
In-Reply-To: <a19ae203-bda9-4034-a1f0-7528e942d7d4@oracle.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-6-aaptel@nvidia.com>
 <a19ae203-bda9-4034-a1f0-7528e942d7d4@oracle.com>
Date: Thu, 29 Jan 2026 12:28:22 +0200
Message-ID: <253jyx0pvax.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ea44ad-6a56-4c61-dba9-08de5f212435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wd3heb3j2q7yePOxEU6Ak1RIbYxSMPfaNL2BWN2WkXTY1xl9bgdr1uDmIYxu?=
 =?us-ascii?Q?xQb67Yy4YPaL2WSO91iRoOnevDf7vYNdk2VvPF0adOpSQEWPgb3Z5Dums+NM?=
 =?us-ascii?Q?pftKunv3CMDtDjzLNmjz7/C4hPxRx0RFV+tfqWh4gdydTAMew/pOE6VeqcBB?=
 =?us-ascii?Q?lGahku5Q1N12jbNtKGzRVcr3L8MUs7pM3f0H0w+v2X+hCT7HgAOj3+GKgc6X?=
 =?us-ascii?Q?TQeK4vJXRzbZBA7u5EZ/FvQqbpg/VZ/EXaoTmZ6MG3SBVrvWfZ6tidT9thNI?=
 =?us-ascii?Q?WAkgLAXR4TJljEe0cE0EAVL9DGqDXmcXyRwnXFcV6tjWHjLKo4riIg8/pzcF?=
 =?us-ascii?Q?bDiw+rU2PUF5HVvlv/oi1SsRkqUwtDH8zebqss6mAse7cVi6HdH5OZCjxpdn?=
 =?us-ascii?Q?5cioNni2PpTILn7VT2sC45BcObsdPvvBjlRIlF8h3MB5SLJoCiDPC8B/h+tO?=
 =?us-ascii?Q?KoVFCBws8Ws1M/GDGOFSNXLnZBa4mvCIdYoxOJ46AbFWWwpbfxkXWbvMQC/l?=
 =?us-ascii?Q?9aos48W2YEj+GUQdZffjUTTr2RFISTq4Z876T8seVdbvawrUOU44eJ5DIFIK?=
 =?us-ascii?Q?UjMf8whseRBmHoLbVXYt32Y8NgOwxrhvoOYlgfOiwRGx+I4n9N/TtdZnIfhl?=
 =?us-ascii?Q?as8MStkcOAtpS0p6/yUdWJKDRMOsifRa06DVPOx8i8aXkioMFbQc4/rbnN4a?=
 =?us-ascii?Q?zEnHHZvvddLWp3DQEa7+EfzVugmTnxwuKpFnXQaJXebzULNal4zODZNI1nr+?=
 =?us-ascii?Q?2ctlOjo2oIpusl5RdHWwlfaMo8b6VUg3RTktRtjLRLUE/CvikvTAg7NG64XN?=
 =?us-ascii?Q?GfKkAD/DXcB/OLRcTHCNbNkddtE+a4AHL59VzyboYuElA2vZi487Bi1EFxRt?=
 =?us-ascii?Q?yExPecaxXbVU7l/Q5GoCKOJqrSeUUC3lVIiSqfLI9o1yTvZ8a98j+yLZzBM6?=
 =?us-ascii?Q?mQ/JU9cl5GSXZUl1+wtavacmpZE5uD8EVBCjPesH7CEUKOfoI/KOsAKFH2H6?=
 =?us-ascii?Q?iM/7Cw7bY76uUgsLD6nG2w+5U5eDHDYH8XhicAYIXgyoWu8eUHs70BrIGGNo?=
 =?us-ascii?Q?VViBAkmU8nPZH1g7c4kP5OwTm4CnDum2GFpCrgBrDkiFgxrd4rX59ZutHzup?=
 =?us-ascii?Q?5ykKQ8ikv4yOI98Llp2YgcqbQo27tDX9nBZEK+0lciEhAPf/zUNUzk7+Y8tZ?=
 =?us-ascii?Q?pDNQhHuCCsUmpiPkl5dGVeZUDF5BKTseFARmwfUK2Gy+Zl4vD7+jIZpt6PGu?=
 =?us-ascii?Q?LaEiIJwVWxM1/IXgdzlVuL/U4dwJ5LsChmYxZRkE4IMZmQHtihRI0FXyIgik?=
 =?us-ascii?Q?zQCk1d5tBoBxYfI0KIGvv6FHvIm//XU6zgKDTCidYEOudsIeD74T2xz8p8yx?=
 =?us-ascii?Q?FXx9hSkF3uEHxAb8thKb8MlYHGVIFVPK6lVYZ4Lk+dWcq2U7Tkj3bun0jgyH?=
 =?us-ascii?Q?bmY6Xev1fMSYffsj5uuJ4BGqlPKwURZBqMUIsQjsiUcXBWakSBFMUeUdYxOp?=
 =?us-ascii?Q?nX5o8l6fvVclft7cDl53MeX40gvZSz50X2dkJX8qKpDkebhoJE5BCZTiOONE?=
 =?us-ascii?Q?PKUvgzTVXVwto4ce/rM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnVHUQfTLebUpt+0kjDa0iv0xCFpXXYyKkgwFjJbmBfYS1+TxfHI895Sp32q?=
 =?us-ascii?Q?w45uadNM190rh/o4SX0CoBEQPnF2iGVfJc0G+9zpOYa3DSxDChk3DkUdljyu?=
 =?us-ascii?Q?zbv+R2NrUnejscexgtb7OwsidCp26gx4Zv8acFFEfcPG++y1B+sVylUoZ1YE?=
 =?us-ascii?Q?B3+cMY9h/YhlJs8JY3xb7NWghktwCGbfZAlSKN7U/w7dcGPXRE0AACRzWT6p?=
 =?us-ascii?Q?EVmxqNPs+US+kB873FzraaA/l5PHPN8Qqs698VZxmOiMyrV2oAdKJFevkrn/?=
 =?us-ascii?Q?EM47+3Y7G45BW2PusZ7uL3eiILlZaVIuedtNtciQ+Fwr20GrjMVu1LV0msCc?=
 =?us-ascii?Q?Rvhagd8b4Hd2sZ4tCDsGtki5Ntx3/mTh8bxiESgh2qZp81FTch1EKuSL3gUF?=
 =?us-ascii?Q?wKKuKlL804cv6opjZgKSdmuZGKO0pbGQp5fjXyWB4Jhk214CuVXqtm/wawzU?=
 =?us-ascii?Q?GVQL/9c5g1WMrnwI+0GHBJspgwcAl4Cs296dZTnURe7TiP1ym+e6JxorhGsB?=
 =?us-ascii?Q?g0Cn06JcNwXpDYqW6VW8UVOzH8xYREbnVkpmpKtbbEWKQQxtgVhvL8OL0yXy?=
 =?us-ascii?Q?3zunKdDzpCR2EVbssCdfBZbHTbkeiGaN6ZyQiklzroTr/yN4xYqmykmNWYsP?=
 =?us-ascii?Q?q3T8LdOj2brN4qlojbcFMIVHThs8vr+NOHn0BRAJu5c8BOv6palzqp3K2tga?=
 =?us-ascii?Q?H/XOQU8ARzniUhzoD36Wui+orJfEFrenslYXy+awWzvTOeE57XZi4NfmqK7W?=
 =?us-ascii?Q?Fk4Au2auHIc6IaFfUFDHidxa433NAMskib5vUq7pt12BWr9VUN9OV5EIjyHA?=
 =?us-ascii?Q?lbPdWJsuNJGGKkZa6/q0yn5snBwuK/6pgAbiBJrWMg4IvrU/zeSjfelDHY7e?=
 =?us-ascii?Q?74X+DkBVepBpHbBjAaXZO8T1HVn79MntXigfwzcmhD/DMTDI/ld35oCMUILC?=
 =?us-ascii?Q?do9D//OA0s+gb/DfNM/i0xtXqmtkXexyJqfhDRvvnzV7zMWVRd9uiZ28B5qb?=
 =?us-ascii?Q?n0l2jkWnPi/MbsFPM/O54l4QI6bfXjuqr0TuigICSiRvkRQFoMU59WiifaPj?=
 =?us-ascii?Q?1wtJHd/nqovPYSnPHo6UKFSj2O95wD2zQyQbBwTi+B9TmuFlLIkvfDnZNCwC?=
 =?us-ascii?Q?omMQKag5XBHYk9v0K5msCyvgEDD4Tv5s+7JvYZmk1MDDQ0vK0ihUYR+l+FNb?=
 =?us-ascii?Q?0JlWHtC6s6eAwLSx3yIpgbLvLBcVgbL8jSSF/m+UTGohA++p3lVKZ3QHEajw?=
 =?us-ascii?Q?w/8eZFbW2xCuxJXsC62aSN/kAa0JSAu5Uo/zZ0iy+ZRpQst+7wBYoKUywKPD?=
 =?us-ascii?Q?VxYXBgA/BHTS+cg3LllLqSsnIBeTou6L/OYagOpDefMPpTubo3GpZBm6JDih?=
 =?us-ascii?Q?f2w45AgkHJob4XoXdbzg8YmLaegyj2K09U2GxBtnNnZYrXasM9FQ/R9G6/aq?=
 =?us-ascii?Q?wUFhYVnIWBBk+Ali31gxiju8/ynjNfDGdBewxY3ZzUVcRPRmRmwc20GI6qRC?=
 =?us-ascii?Q?iJGtZvVOxa5qZc8oGr51iu9JergwnkhJrIHbn1yres6AGHqZ4RKqVblUZPel?=
 =?us-ascii?Q?WX7oYIeEC8BzZ+2g7UzqdZu/KYbs6fMRp2s9QQPHyMa+dg8Am2I65WpryevC?=
 =?us-ascii?Q?GVjaFy7ASAkJuwPnpalGTKDCzD52kJt+nLVGTMh78eXC/JkmN+kMhxS4IpCT?=
 =?us-ascii?Q?lXnj0a3ktxG/tEtiERTS0eoZy/eo9EhgQOOiWytjURPhbFSW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ea44ad-6a56-4c61-dba9-08de5f212435
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:28:28.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o444zrxqrQ1MKneHrNC9kQqvX1Z6WO7gX41sL02dPDAH/pRMXHxU1Tn2xyQmM3Vr6uQ4N7jeH6TnOOH5Qccwpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

Hi,

John Garry <john.g.garry@oracle.com> writes:
> I notice that this kernel config option is still not included in
> mainline, over 1 year later.
>
> It is strange to me to merge tests for features which are yet to be
> accepted.

These patches were required by the kernel reviewers to be merged in the
test suite before the feature can be merged in the kernel.

The last review round for the kernel feature unfortunately required some
major redesigning and has not been merged since.

Thanks
