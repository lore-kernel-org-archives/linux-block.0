Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020090.outbound.protection.outlook.com [52.101.196.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486064A2041;
	Fri,  4 Sep 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530220; cv=fail; b=jYz1269rnZ2DOxgKVqR77t/1jNONAWomA6CykgHDQ8vst7FTwGNGkx2bVxowdxtKCS3ZncOEAB4Bar66TiClZo01e/7996g9tich2YlrZ9yr5vxsvtmEzH8EwxquW8gag7C6XfcZIGNDoto+1HWcjOLwSB20LhCM2FOlyaa+NmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530220; c=relaxed/simple;
	bh=HQXrPnlYFee2noIks7uw0OZXGjPEkBv3+Je7ohwr3uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cUenr9clMH4ja2oWEp7dL6Kn4UQ2xmyIOzsdWznYFwn2vCagC99rhUX2kGgFYMbvYzbQNh54zz1cTQlGO/e4lPYoJ0d6nCDknzQZb5zsGEAmypFhxzdnt1ZFc0HFfpqpf3Nay+J0NVZto8PiWPn2aMDGDIjrv8XMn+M/NqmxDNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6KWCDKJ0cTfbvBbfc5SOJMjcGsKQcfkAsrE1VJKEbdV1H0avExk1uf2dpeNGygHCGBH+E33IC7x6gSRk9YY7eGE8rsmgMP7UGuydCT7HhvZZD200iL4Ov3I0M1OQPegjIMIYaRrynbd3EqnaH0uyqjm0vE7Gs4RjzEU4Mzvc3sb27cpmXk22qysVm/zvhr3CcIFeaeCaCXPGGuJYz8v/Rpq7xrrS78oiptw+JVOdMOO0QPY0oP9MrcjCuYLT43Qlv5T/GFCOtrcz9ccUBrv2u1DIv7iiaBoMbOeYGKNRGYyrAg8PevGK8tt6qufMZ9cunz/v2F85HCmkwgVE1oB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tFcNC3UXw6ERszbKua2USNZSD9x0EDd4WVdk1PcKf8g=;
 b=djj7iOfFxbbtKWRFKlrcTL4qy21a6qC2ZmhtR3IMqmksaC+p65BSruEwkS5U2BydE/W8d9xmFSQu2LR+wJJM8MDM2npsPJEweD+jE5ru5gMPw5E1Crp3ZKZrKTn7aQX6VOmNGiXTqBWXwd4L7ZiXvWa1tkKavXvibELhF5rjFV1x5WFVjD3RkG3uaLbkWQ6nUSXkRHPqtj7wB2Xj9zUEd5tPF0o/lLNIr0CNDx0qN4LduO/cNXhJxViCfs70gQdMv73QKoBLutggVez1HoTHwSmfyPKF8YdshRGnA/coUQIBctPqOS4Qpy7sxwvbtZM2gbktiTUn+poQXx7WPUdWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB4134.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:56:53 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:56:53 +0000
Date: Fri, 4 Sep 2026 09:56:50 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	bigeasy@linutronix.de, wagi@kernel.org, marco.crivellari@suse.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <xo2u42apweqnfj3mq5b7jmjcvdgqrr6f4sh5sy5ys2eose3xfs@ux4utwwiiscz>
References: <k2lz7cbhtzlx23qk2nhii46znecytdfrcyoctvpqgu2ibttdbz@v2y6jttq2h6l>
 <20260904114249.217677-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904114249.217677-1-ionut.nechita@windriver.com>
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: eb501cd8-7c29-40cb-4f17-08df0a8c6029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7GssUaaTBz/9rCLK0o8xZhoPDZnymjZFmEF1/HYFgvCSFyk8zz/kfI6xJUPNIBWIRG9yjag6CFZhcwOlmIsc1gjEGpRxW+YnWFX/o1Au3cf7eKFK8TfwZ2BbkkJJyC2kpuNkBKbb/JKSY6o/dhr9Usea7YzkmmOPAt9PvLFUpzPC4Qhq8KZX08gKVJr6EMz/ivNgIFDREgkA0Aus1k2HbzZY1Lc0DHG7WApemXAxx4JiOQ53Kufo0s/2uOG/mFpzz7O58YDPzuvEhUMTGxZiFDObc4OMtX+TieJdt7XysX1je0l6H0rbfpCXoW5FLwWmKMxDLGkPGn2Dk9auljT+nHEdeBHUfXOXDXyco8JjaiuVtcUXZLgWwVIxy6/oW8IjVGOqyEQaTEaXHBG32f45ouEE7rWK4Y6f/tJ8P1ZPrvmKMhZ+njRGk/2IIK6v+QUPIRMFSo3GkfKLQnsfpy/mrFX+C9R4Tf5uqcMojR0fGpKHu/5GwAlNxQNBBrRBs2kdbDmBEA6foA3+tX8C3kd7wxsRZfmNRpGqnZMuJbmVD6Jw1dNN79o9UJth7ECoPopabqMq5czrrLUIlIX8roLS1WjnRi33IpyZMREMDG64FuCf7DTpfhJqRRXp34QtflTXf7mTjWKllrPsMKznvgDUEfGCfTG5jpQmY0SLPpmfFT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1YydmpuZ1VaaGo0enJPVkJieVYyYnBFVUxUMkhzYmFKbDEvSjd0RVFTclQx?=
 =?utf-8?B?Skp5Qjh4WERCK1JBQnFlTDlsZ1FBWm5UTFZLclFqMHhEanY1eUIwSlZJdXE3?=
 =?utf-8?B?SDkwSUdiMEkvQTBJeGpBU0dmZTFNSHlHQTB0SWUrNE9TUEFXcEtiV200VVdR?=
 =?utf-8?B?dXo1MEFlMHJwQWFvZWc2cHdzbGxOY256ZjIzYWExZ2RTdC9HMzVFQ1Y5NFRK?=
 =?utf-8?B?VGd4VER0WDRHbDVkcUdEdW5nMDFaQkhmdld1Z3lNd1NtbXFIdjRBVFZ1OW1o?=
 =?utf-8?B?T0p2WGIvbTJQeXE5eWYzZklWbkJpOEEwWm9JSHZNdEI4a0tvRXhKK3FwRXZo?=
 =?utf-8?B?c2tjUUt3VnNqRGcwdHMxYXBOdktjZjFKTDBFTmpUTTVlaUJSZnQwRFg5cjhJ?=
 =?utf-8?B?a0YzSUpkV0JYRlpIWTl5TDJHcjQvekJhUGFjYm5jN1grRnRiNlU2T1Qxd2V2?=
 =?utf-8?B?SkJkNXVrMFB4NWdLcUdlZ0FNOWdyV2dTazllbGFVY3JoblB6WURxR084aE9r?=
 =?utf-8?B?aG05UW14SDZQNW13TVdua1h5WlRUV002MDFZbEVnRnY1bkxUL3VDNVFnOWJZ?=
 =?utf-8?B?T3dNOGx3YlViKzRBbWRhZmFxQ1d1dHhYdnZlbHdMYXVJUGxJMmRhcDlBZy9z?=
 =?utf-8?B?Y2ZMdTRjUUZkblhic0xyaWt1dXM0RGhjVnBOMVVERFVGNEZBUjQ0SU5TTlRO?=
 =?utf-8?B?S1NaV2hIMmNDcHVUVFBLYWVMcHY2dkwvT2pITmplbjM2TElXeHhCbGVNTjRT?=
 =?utf-8?B?cHcwelRXTG5ib3djUVQxSXhaTGlQRTdheEFvSU0wUG0rNm84SWNBaFFTemxD?=
 =?utf-8?B?OHFyNy81MWsxeHN1TjdRcjR0TUdCVzV4T1ZmVUlna09jdTVMU0llK3g4aHpP?=
 =?utf-8?B?UHkyT2VkamQza0xhaHRQUDdFblViemRrMXp3dVEvV1ZkMTcxNERCK3h0aWtv?=
 =?utf-8?B?dXhBbllZQzFmNUlDczB1Q3NoeTZHR3paQTJsWURjMHo3NU1oR3VpL2M2empY?=
 =?utf-8?B?OE55dC9xdThNL2hjWmdxNERQS2tLa0JZSytQODhQTWZ3bGVtZEk5OUQ5QlhO?=
 =?utf-8?B?ZUhaNDVPWnhtU1RmNllpSFpOM1VKUnlURGJqMTgwUEhwSXFwNWhZQ0JXbHIx?=
 =?utf-8?B?cElWZVZJZ3FONGsrdUNwZHBrOEptajlnMUF0aWFyNmhxc2krR2h2NjNxb2hn?=
 =?utf-8?B?aVI4ME5YS0NxckRFcEJUaDVUdlg4V2xMbnI5RjVwS0ptV2o2RlpVYmJIMXcr?=
 =?utf-8?B?WFk2VGZOdEd2MzVNcVVwMC9XZkpRRXVxNjZzTVdpU1JUMlo2M05mdE1pNVdr?=
 =?utf-8?B?TzdkVHpXT3hSZUFvSk0yYzlkaC9rZEZxZkRKSzByS2lqd0dtbk1pUkdEd2oy?=
 =?utf-8?B?S05qMGsrMHA5ZnNaS0VPSU5xa21vKzdHS3A3WlBOc2FEK0xaNG1WcUwxZTNR?=
 =?utf-8?B?Vm0rK0lnbjJrZFcwUlc5azFvT0d1aHB2VlZGTmhKdXVJK1JIWGVsQk00V3JN?=
 =?utf-8?B?aHgrdDdlMEFKOUtTYjRJWFdkRGVPeTlheGtoTmpQTHdnWElaWXBmMVVVcFlD?=
 =?utf-8?B?b2pMaXVsVkhVYjJKclJhdzdmVmxIdHRQTlRCUWtUeE9hWnhWYnI4anViRFZK?=
 =?utf-8?B?RVIxTXFIL25jUjRESkNKUUVpbnNkVFlwT0oyQUNaZzg1WVcxZ21rQ05QK0t3?=
 =?utf-8?B?Y0g2eDV2VlR4OXltdHh0OGpHczNQMWdwUEhReU52VWF1c044UGgyUVMvZmIx?=
 =?utf-8?B?WHYyV2ZQcWZFMktuRWFlYUFpMEdXd0xjZFFGTUw0L3RaUGlNY3ZGWWU1NmZL?=
 =?utf-8?B?UnhySEgveWNHWXVIWkVCYktWQVAra1AxWnlESjkwZzV5WFczZ09IN05KbHUz?=
 =?utf-8?B?NVRyTUdqbjZkdkdyVlQremFyMER3eVJPbDlROXZsS2NUMHlvR05SRkR1TjBh?=
 =?utf-8?B?K3NmNkl6WTZrL2NybDVpVE5FejAyL2Q4WHp2VGdzVGFGSVAydkpHcmRtRWxQ?=
 =?utf-8?B?UlBlcFQ1TVJxZHp0RVhqOER2MzQ5YnRTMzJKalpqUTA1OS9OaUNYcFBHUE9L?=
 =?utf-8?B?dXQ5Mm5BUjZQN1ArYzM3MkJRcXdqeUtIZnd2ZnVpVUNnQmdRNUpLWFg3R29h?=
 =?utf-8?B?K3ZJTE03ZC9qQWE2cmxrWllBbGJ2bUdSWlBHTWczWllCa3dKRm5ZSzVzNDRk?=
 =?utf-8?B?RzVCZm4wNHozUjB4N0ZkK0kwZDhlZEdxcUxnbFJtbS9xY24yKzNtQVh4S2lo?=
 =?utf-8?B?clRIczJFS0Zxb1RxNmpyL1o3dld3a2x6a3o1TmU2blhjZUVTYlltSmZhOWdC?=
 =?utf-8?B?Rm14MHhEVXFUUW02N1hyMDdRaHNSRkJJNysrcnNWWWRTOE9tRXlFdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb501cd8-7c29-40cb-4f17-08df0a8c6029
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:56:53.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLkgndeZnULgHfCg9Y3BAL8ndeR2iheIv2dXt4T9OZxsYRNPdcfboOzp9UwIY1HU2bWCWB3FR6zrJDVJZpjoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4134

On Fri, Sep 04, 2026 at 02:42:42PM +0300, Ionut Nechita (Wind River) wrote:
> Hi Aaron,
> 
> Just a quick follow-up -- is there a newer revision of this series in
> the works, or posted somewhere I might have missed? I'm mainly trying
> to gauge where things stand so I can line up the GNR-D testing against
> the right base.
> 
> No rush at all -- happy to wait for whatever the next spin looks like.
> 
> Thanks,
> Ionut

Hi Ionut,

Yes. I am working on the next iteration. I hope to have it ready by next
week.

Kind regards,
-- 
Aaron Tomlin
