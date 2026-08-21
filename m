Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9835C6AF
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787292130; cv=fail; b=IHlczbszcH8/iD90GTS5DA9Nfnge9uReqqJHKdATrC8Eyl9cejkCwmE6IblqE/fgm+asQZ7F+5EyY7pNWyWJDUau+Dn9F8UH6U4kcL/EnfgvjcVrg087gL0KIPCt8kCTQQ+rjd3R0p4G5H6+q5S7q0jz4P7EJRAhiKQ4kTyh0JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787292130; c=relaxed/simple;
	bh=rZIpq/xQq9CIQyzoVo54UJjtv6OHkHxqMQlJR6NZhMw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VEmJr8+6Kav7b/CrFaRhnIXnMrtR6dcc4tcq/hNFxhn37ciPG8MBCnckxSFE/fUFKqDUD1yO9u04UC6xDRizZ3gMJldYKCki2h4htRSpi6qlUhR/9YahNrBpleFaw8zocfSuiGhxHXCBOd22IPk+6qXEJ+V6qgcAF8erUeY6pFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qT8qjy01; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C9P0kvj/; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qT8qjy01";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C9P0kvj/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787292127; x=1818828127;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=rZIpq/xQq9CIQyzoVo54UJjtv6OHkHxqMQlJR6NZhMw=;
  b=qT8qjy01Df3QPMAG9FWgJX0t5SA9wQzc5ixIzURE7KlxbecGOkCEMCGT
   3Mz81nRzTLZOv4pXGnOC3nNWP+jVpgJu3vF90vMiyO+eKyYfzThNLYxCG
   JrzS8G3pxVpTiNwGTEjWtQW5Jd5iqs0icvdnkYR/uZdGeoZ4mOpm9S49G
   0xo2hlV9QihUmjan5r6L0YZraHfnNOhfx5MuhxIhzfxOG4NOokfR+vDTr
   RfORMimB9azV5mJsTNAzUrhDRim6WMK0zf0bB2WMfYpGJHJyx2SbtgSZM
   Eg96n/Xc/LRCNqS0I46NjCL/CSZMxJ4OnmJ7HE7E0MNzUlZuUHdwF3pRZ
   g==;
X-CSE-ConnectionGUID: YrgVp2juQPmLKv7OB2iK7g==
X-CSE-MsgGUID: WmfEMuxrTl2070EUozeRXA==
X-IronPort-AV: E=Sophos;i="6.25,234,1779120000"; 
   d="scan'208";a="153017242"
Received: from mail-westcentralusazon11013013.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2026 14:01:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7SZXaXUUV6Ufuip3bPYrH2BxCqo3ySFIWmL8ZHlDU0FAmxgzGywLGFyM+oa/NQRAzhfmZH44PXOguEqmK3eES+FvR0axGdXEKvJoNJXfBk1Orzad6Ujsry06IxjJEuHmQgBjXA88xZCi3Ku587U1LBdwLDCwf1CJcNDPM+3iZOazbkNEGx40OeKUrhbqMM2EcFpd1RKO+AA86s7jbcF8p1YSZ30V43xnlvXhlsUIEDvxqicZa3ESgaRn28e/mvWuNAzU7SGhrVJS0c70O9wmjLedx0b204HNflaYpwvNjqzaxzDJgbvkspueD9HCCXbQljcQIbSlFfWLGpx6MtVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kWj1JDKya8bHiw/SbLQ4244f7FA5RzEOs8U4tDvoFw=;
 b=yykBcmL/6BhxuoHDMEgq9YxP7+lxTE8By0lB1dak8hzatDu6Hbb+UXVExih8tMNA9S5YezuR3c8E61FpbJcOuCxiJ5kWjlmY33/p3pPB0144u2M4AoKfJyK1F5Y+EI6ujRqi6+4/0EoJeAh3hdsnMtuTRg7bH92qceL5AW0wuBAABt6ThwKaHYOgPAApABl48rt/xlskU3TOFW2qGB0cB6zE3l1C+0oVrcHvBv9KHYdq8mc+F+BM7JBAuCT+ht2OnQFNP+licdbAtyXxd6HdsNx8UIu3GrNOvBYtehFMd8TFTqalpxQwGMlukfVhgyb3glg6YDuECEi2ntnjhXmorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kWj1JDKya8bHiw/SbLQ4244f7FA5RzEOs8U4tDvoFw=;
 b=C9P0kvj/+MonHQglligptGfLuu+7c0HJy+vt5zohEN5YZ8ie1cjzG+rbMSOfU7u0/0mxow6Tb4stGQKYWx3TCB8hkvyTkZVHkqTPDEa68a0nV6Vp3vZ6U7IgIHRQwtth3B/7EhJefqQQqrUgogTmRK/07ho+ibJUyItLjk86ruM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB767244.namprd04.prod.outlook.com
 (2603:10b6:a03:31c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 06:01:58 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 06:01:58 +0000
Date: Fri, 21 Aug 2026 15:01:53 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, 0wnerD1ed <l7z@0b1t.tech>
Subject: Re: [PATCH blktests] block/045: respect dma_alignment
Message-ID: <aofpEiLpsmRVtGJR@shinhome>
References: <20260806094218.2077413-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806094218.2077413-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYWP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::23) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB767244:EE_
X-MS-Office365-Filtering-Correlation-Id: 411cf717-6dbd-4521-38f5-08deff49b5ec
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	pfVqia23IoJSp7nXi6VLpjT+XnK/5TdDZk51zLkTKHJkPTzpFfnr7U0nLzDzc9X40Q9fDhnyZv4qmWZ/a9Y1UZhlTUKAlJBoJfgxmFGqE7vBmlcEHGSS3VhaetHs2d+r+GaNPCpy9uAbjtMfWevbP375DrtRPwOvhPPnQVBrpGqq9UdTg4WauZxCy1i+pG33+MzxqyzygMbEKDgPmGJfu3WgFDZB8WhGw7WrDwNNY21PsrqSFon01LltuojSZ2ODF8LRkudCV+ENtku2mRDC4a1F0Bg6b1jUWR1sCDlKCK2Xx/kEFaIy6FYKOcjSqgCX9Z2OdnG389xSCqJDNiZQyedXm8UGfXKr2C+wuyC7I+TcYsXy3CfOKnHITSL7TW4ArTh+kKmMMJADDjBgJb9WSy58Y5wix8eE+8CdHZd7eylTjQHS2hW7K1vLXB7Ii5QGH1espDYlWUQPHCVmHUrtXyfW/VKgiKD/YdDxg4OQwiFxaYodisAuRnV9MGfD0mAW4Sy1TdHtdDL219kjlEV9K02cKq3cxpXkty0OWrUwgsu1felidU6seGkDsM6PaUTb203Pj2cQ+VFSQnpXA3aokHc8efIBPaUloqzBA92uY7CUKVlrNbC/lXaVVYdhSc3g71La8PoTbsbr4/hrIX7xxc5cpYks2G9H65qRHR4seCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s64xOn6eIUktNjyuxmr1qkwjw8Q+/cLGCF2veULAyyrYAzBaYMIt1XtyGbw+?=
 =?us-ascii?Q?GLLtBiCRzJTjjxiEW3JGz/Eg0ECHRoTZeIuys4KReaF5MPNgerbzD8CCAUjG?=
 =?us-ascii?Q?GF66pfZBUMjFbAmGiomQvOEYqqudPTLOlWOVEUeBxn4/LF4Sh4wctErglxzr?=
 =?us-ascii?Q?kYt0E4dBrGA+2fq5Dv0EwE3tZzF5q1JgBw7cqCO0p3t8BBANnEaKcTE05pPa?=
 =?us-ascii?Q?yMHZlAv5V6lEruNUCxBErAW8TEqQ3XoalRrMfaBU4vCzucPyP6R9C7Si2Arn?=
 =?us-ascii?Q?XvbgsB43cdNag1ZSvMaXOcBXdPZqiZ1Mkv1c2IGiEw5gd75qInpef/d+CTCo?=
 =?us-ascii?Q?nRZV1sgAY08LE8n8lsKA417OVbqcCgYM9HbU0a9EAe77TfQDJP7MTIFrrSyR?=
 =?us-ascii?Q?mQ3ZQBytDIjgyTqq/TRvhRMbzOviVbmDmvZwZaET5ifBXT3AmX7N2BQnfizg?=
 =?us-ascii?Q?Y8PtfEgKhEuYjAdkUWDlqHcbCBZhvk05QPOZ1X8lcjaigFbnkIoqVDxKCYQp?=
 =?us-ascii?Q?h1iFpkBQ45nC6q7ire90ouxRGkqezyRNidxsbm+SdaAKkfcURmpfy8sF4u6a?=
 =?us-ascii?Q?JounivNNJjZldawKqrTHEv21AECuN1v+MVo7DewLJnNgDY8jPv5BB30fOafC?=
 =?us-ascii?Q?ak7g61Ir6CbeF28xpxBtt04iWcj7WYCm+rSSTZUXT9MCQImMbVkPUqRaiOuL?=
 =?us-ascii?Q?h8D3wa4zadSjb5krasVMCzXwUPrcKh/YUJQuiB87064IHg9JXxUQqpZnr/Pc?=
 =?us-ascii?Q?eZ3n+8tlHOJoQI2QdPMVD+Euq95gQ7WNkt5vAlkf7L+DZ5m7Uz8mKbW56YQV?=
 =?us-ascii?Q?SW0ZRMGHYs++LDta/lbL8iIpZkDZl4FuZ4v0/btP8I1X4Tqh3Yl3ErzezUlv?=
 =?us-ascii?Q?ZGHyykN1GPv1p2k1HK8TVSD7zQshXGZJj2LtmziBDzrhuhXuRBnkqWRCUV1i?=
 =?us-ascii?Q?f3CMaB569YkPoteBocMkCE8QzUibM/F6+4UOTG7oJvZbQqLA2OqpcqfItWJ4?=
 =?us-ascii?Q?P+mjhnwy4gHos7/CoPjx7WtX/i64R3IkKrvm65d3QSDzMvxZ/pWVMBk9ejZP?=
 =?us-ascii?Q?iN52z8tAHMvxWqUfNv5uEh5Xf5OEJLT6GNhwNES0LRfpwsd2fmO2ZVXCvOKZ?=
 =?us-ascii?Q?lgQYrSrS3IqQvP0k4zwrKh3MftdOs6q41ikh2+DmrHYH9QHXBrccHbq3uHGa?=
 =?us-ascii?Q?4lr6/cGk/9Q5owDmyHdmQWtzsyEQuXGRJcdBuxTWsiw1KlwtNo+gXt55Rla8?=
 =?us-ascii?Q?N3TwOworVbXR4yru04XIN4M1p6NKTW8g7Em6frhtiFdYkKCjSs/hu4rRQq+u?=
 =?us-ascii?Q?FO/80p99Ytui3acEt0BiY8fquM5ipv8wyV5FnuJwcbS78j73J9P0klBOjeK5?=
 =?us-ascii?Q?sLVHlrvFe4zFEjoniG9eOsg6FxrlPz3AAmQA0bziQ8LVX1bLk9pMZBtvt/F+?=
 =?us-ascii?Q?4ikDm50o1695QX9AiJzvuwq4kOoPustvVDuohUFRL9uWnGUjWNTrODym1WWs?=
 =?us-ascii?Q?gQKFtFsiqHbIOljKzTaGlobhsfgcJWewADrHkitVltKn74936D0U5/ydTo/8?=
 =?us-ascii?Q?HTzezDWO86qSAZmP60iUGpSJSorlf810AHr0byypIbXuhbxzKPGAaYJely+W?=
 =?us-ascii?Q?K7LcBFhpvtZ+3AnoijxvIVmDAnohEfDYc6zf239hcdSBDkozvkweWa/lvsT+?=
 =?us-ascii?Q?qz90TFjcaYWJPhjb3EDw94o7XgQ2Xqg9zMDz26OVT9salURp1vh/63AyNd9n?=
 =?us-ascii?Q?zAcRqhs+icyMmuxWh+fdO3eA+aQbrPs=3D?=
X-Exchange-RoutingPolicyChecked:
	bYejwceKsqz58RWUhoA7RLWZVkEBwywkArn6YNDbBSaUmwb0R+RhFFHoyNtgaRozRkqCNQRGgmWTneALf3TcByWRTw7Pln2EGjG7nUsvoei3Bd/Ed5ULXWMe5OpjMBc3Cc5tflp+JGj+nY2YQtkRsBEgheP4yyvrW5QrzqX8CBb4faxDH0CnU33l/Dvj4U3IYEB2bxtntIEL/PZU4NRephJnv1KV1DWNfcIIl9YuKSLaJWxKv6C0JmohtmWBrl2etY/hlPLuhSvR9tcG34Epi+etNwUl2UjZfSHtr6f/ZCv3EsnpkaQ6h2Xgt28L6D5G7qaiXvxbBPRRt4RggXYiiA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	riWaeXt/6LZ+qL4716vevFAkVlq2Tm92p7G2dCfPWMauaGUKbcFPxp75Ewg+CLrIXd1hjCrdGesLN4ZWqb2jVjosPFKRSWiHxt0+e+Onx34Y93FnHrG0NawkH+dxfGcwCLIPVoXY4/o1ddIZjYT7fech2607SYLoxQNPCrHMmRJmF0fPgQdM9IaLnz5pN7EngF8kI37+evV8WU9YLDYLJt9B5IGkyuGB/2byARG5p4tX2vHrl7Ijv5m/TksOfjmGCciApI840j6KFJUgrrRpFl4dGA5m5OxouSsXrJpbJxXiwXGNmNzGSW0pRzqJB4YdWwGNaM266vhhfQlGgL9wxWOFyNIvs+AoSqhFsFR9jDxe8Ys3w9LNMLSr+WTJDrJQgVJSCd6vk+CyGq/qrIapo1k8cLP3AKkPCKgUcRAH22RM6jkQ/9mTtI3nAdIgYsStdkvMHrowvUHNDvYIxCe9LroRhhP9kHDeNB9MX3jT/R9b/9FYvKByBNchH/h0nZtqZkeTxdgsg01K584bmSweMlvEobmehh1msaWC8XAqaMSLoomSvzYn73BvQ8PVz9N9l8wtKuJgXkqPZhZIIQQqPEjzJ95khp9GJ7oVt+8dhBOjZrqHlkHXQxcqyrYSGw5l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411cf717-6dbd-4521-38f5-08deff49b5ec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:01:58.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EXfCq7D7mwGHIDNGO/SYv7sCB9fAgA9BYE4Qe9AWQOyFCGZaZ+7N6rVX5MeFYaz9bHYEC+dcyYuL5JCAAefEMOudSYfDB7KaG2+t6lXBp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB767244

On Aug 06, 2026 / 18:42, Shin'ichiro Kawasaki wrote:
> Since the kernel commit 14b007e17881 ("block: validate user space
> vectors during extraction"), the test case block/045 fails with the
> error message below:
> 
>  block/045 (test direct I/O full-trim bvec alignment)         [failed]
>      runtime  0.550s  ...  0.630s
>      --- tests/block/045.out     2026-08-03 19:26:40.407053612 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev/block/045.out.bad    2026-08-05 20:48:33.366932845 +0900
>      @@ -1,2 +1,4 @@
>       Running block/045
>      +bio-full-trim: pread returned -1 (errno 22)
>      +bio-full-trim helper failed
>       Test complete
> 
> The errno 22 means EINVAL. The commit introduced the dma_alignment check
> and returns EINVAL when the check is not fulfilled. The test case calls
> pread() with one byte offset. This offset is not aligned to the
> dma_alignment, then EINVAL is returned.
> 
> To avoid the failure, respect the dma_alignment check. Get the
> dma_alignment value and pass it to bio-full-trim command. Use the
> alignment to decide the offset value.

FYI, I applied the patch.
