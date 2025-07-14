Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018422F152
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532504; cv=fail; b=V1Pu6zlTxTr0sGooaes1fh/zYx8Cw+QaKBoCBb84zxTOUYE9uJSeFjc6R0ZuEIUhjwX3+u5R/XRYfHbWeT44OJXZi7l1rZ7LZyhDKOxFeh/fu9ja5beMhP/W7nfD6nt9U8puZvWtfp6+1wkrXqijENtULayA8aBEj7fHO6bH8Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532504; c=relaxed/simple;
	bh=jI/l2KYbZ8Ju0ctgPUbqaR8zutBu57EVW+FJKfWy42A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkCCWyAZ7GngTtzlB4rOAYq4sQmQgQaFBBYFlTqUhx+Rl43KYr6ICVxzBmPH2f2ax+uGyqAkyNUYURI+JobIYE3FV5N5VjL2YXr9DhM4tPSMkeT8UpHsZpOt1/7wyDkUfG2o5KIKW3/iYCMQwurOSzIbw0KehLih+KiYS2QEB/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=imTjQ3+s; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="imTjQ3+s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in5hOQxW9mibw5NkR8uXrVe9l0gdickR70Sgh729GEPKF/9sYCx7QU4QhQEkyriFHp88m/n0f/GW+uni0nR8TYobPPUzULg/irmDcZ/4XtEr9RBP3KWUOHrQq8fz25zorho2Cv2dxfdpv6TYHwREzWYH4pcLVTL95M5aHPDEBJqBo6oBh4G28GDYfFfsdZDZ3tN/HF4fPXNppotkyoS5/CAS4UKUx6V/7I+YWw3/DSXKfVdl7lQIqAYiFZvkPPsz+oAtf32dkYxeop4SWJb+YRDGJ/JJXDrZmHYdnqK6XS6uYsRtbFikcAcx71fPnwFFMQp2uHT4DmVZrzj0s1Hmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI/l2KYbZ8Ju0ctgPUbqaR8zutBu57EVW+FJKfWy42A=;
 b=WmcF85utU1V68khVY8G1YKqtNxwUip7zXAoBat7jiqV0PT+8CQUZMb06bgmPKP+M+EmKUvfaQQ/t7MUkZNNgh4krZVpbdQvqW+xwjpz/zYksYJ2wDKziMJH/cJJSbyhacEcId+5d6FSuQQhb/nWHGYCbpyjtSoJLGxmrsP3vYIgCmV/5RfRPbmVLDZzzmKqAY4xoYcThtcwuz4aatAdH4fAMud+6+kU/1x79Lxf99tpBe6ACTrKFIJQoAB8n1sGejKusPY9s7y7vKM2Xb243keYCBbMSJr3KWrAtiJzGn1KfPjvM9AxAs0fRZI2y3KcVMjMxd7aeL/Ma5tYVLFbhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI/l2KYbZ8Ju0ctgPUbqaR8zutBu57EVW+FJKfWy42A=;
 b=imTjQ3+su/bIlbsKf9a+LxsvWx1Q31XBSaD1EZwW9fQ4LRDP/GvtrAjaxBGQEkrNe7bXkJAlqwMxF1tRozF3ii3w61rx7EeqkpOHhNN1cPsaxc3v+uvfFWF88KVaJg593HgjJ1U5pOiAuKhw07S3GvIRfTeWSfrm+wD4xrPEGGjcDw7AGI3e1JZGwNEJDrX5h+VZkediaz6q1Bqb0tbpuVo/+E2OjG2s/ffe0nVOf5lUfHDwPDIpFTV+L89q0x56l5OwdsauMxUaI8R1JY1Dk1m+vr4f5ZNZSWYrfY/LCaHUnrUZ9xn5eEalfU0R0HtHjfCZpVtLY9gbHN/5CCtnCw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 22:35:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:34:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH v2 1/5] blktrace: add zoned block commands to
 blk_fill_rwbs
Thread-Topic: [PATCH v2 1/5] blktrace: add zoned block commands to
 blk_fill_rwbs
Thread-Index: AQHb9M0PkFg8hakwskads1b3twfmoLQyNXWA
Date: Mon, 14 Jul 2025 22:34:59 +0000
Message-ID: <5483bfbe-d5fb-424f-92ea-044d32df5f0c@nvidia.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20250714143825.3575-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: ccf57c27-2985-40a9-dbbd-08ddc326aac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmIwMHZndll6c0RwYlRDeGJ3NmROVG52V3gycWdNUjVOcXB3Q3IxMlRlTWRm?=
 =?utf-8?B?VWExRnFnQnpEUmp6OXZHVCswNjRVYWxxTTJVZmtUVXZHbDNBWGJPRnBvOXho?=
 =?utf-8?B?YXZBWlljclQwaldkZ2hjZHJHL0ZDT21CUGc4RWdVMzdKLzNFVjRBNW5hTVZD?=
 =?utf-8?B?YXMwYk1hRUlsYTVPaUlTVVhmUlVERDFzdTVUMlI1ck1yT0Q0WFlxU3l0S01a?=
 =?utf-8?B?YmFCVVVUM2xwWEt0WnVNcUNUa243SlBPYklpNmY1T3FPRTV0YVR6WjZoUitF?=
 =?utf-8?B?ZXROSFJ4clRlaGlJYTN2ZjczYURMMWxXSjBrRVg2OFEwYVRPcURaMmVTZVVI?=
 =?utf-8?B?ZWpETS9FemlIL05rZE9kRkVINTNneE5mSWQwZkpLRWRSTmVPczRjOTdsWVRM?=
 =?utf-8?B?M2ZGNXcrR0FRcnl2aVZ2MFJZVUNtK25KZDJaQ2JlVGk4SXpjbGV2eXZkTUdK?=
 =?utf-8?B?a25nVXBGekxneFVhNk44bUlaZzBEL1FXeWJLVW51bGNOejViU2pLQlArbGg2?=
 =?utf-8?B?Z1NvbEVaZDYycFFuRmpJMUF4aXJCdllleWNPOGV2eXZ4SG82VE5hVnNPN3Fm?=
 =?utf-8?B?YVZMZlVlekhsNUNUaXRNTFM3azBwNzhBWkVRK3NjUlpYN2QzblJzem9IbkJ0?=
 =?utf-8?B?S0Q1Y0pSa0VKMHdPUGJtU2tLbURodDNxVjlwcGR6U2FVKzhMS1VVdGhHb3ln?=
 =?utf-8?B?a3VGQVNXRkZDb3phVXFnTXZGa3dxQUFxV09GcDhEcldUTWNnY2Y2ZzdFNnFx?=
 =?utf-8?B?MWV5bkZnSVBYcjVLamZ4ZHBMenNxeng4M2tpVEtNMnpCUzN3R1V1QWVhMFlQ?=
 =?utf-8?B?eHpsMjVpM3pmRnYvQjBidkJicEgvL0dzWEJQWHpQSGRScDJzMWdoZHBMUkxE?=
 =?utf-8?B?WGVjMno5NUNyZU9uOTFPWXNRT1M4STZHSi9uYk0yUGJZeWM5eDJUc3poeUd6?=
 =?utf-8?B?Mnp1WG1HUVZFVHNaTlYvMmZwditWS0hJSTJ5aHJHRk81NzZneVcyNVVGVHJF?=
 =?utf-8?B?Tmg0aG5CWlJGRWd2OGRmbHE1a2t6ay9ZRlpFVGhMdlJQNytQTC9wUjRLSlFO?=
 =?utf-8?B?SlZicXlNd1krd2lrYlZRKytyZlZOS2N3U2tiRDh3bTRsWWdyM0YvQVM3TVl6?=
 =?utf-8?B?T0F3K1pmTWczSHlNWFF3V1BEVlppdU5vS2pIWGNMK3RVMmkyUVRBOVNIbTRw?=
 =?utf-8?B?WjJRRnliNEczU2JZc2ZhaGx2RHNya0xGSVlod1VPcXlUL2lHakIzRTM2Y3Zk?=
 =?utf-8?B?amkrUE5SOUMwMUdQRTJKdEJEVnVWMy9jUFdsdzV5dGF5T0dEcmJ5anVSUUN6?=
 =?utf-8?B?QlFrcmlGNXoxeXBTQU9tSVJMUnAxdVJlUFplL0ZrcW9wWGU5Zk4wMGR1djl4?=
 =?utf-8?B?S3JwYnZjbU84QzFEMm4yNnNOV2Q5dThrc1JFTC9CUmpGZ08zaVRaTnBwcmZ0?=
 =?utf-8?B?WGgxVHU3VGRIOW82OW1oQmxtTFZoUkJNY2xiWHdHaHJCbmFOMjRwRlhJKzVF?=
 =?utf-8?B?RDdxS0pUWTJTVTJzWmhmc1plMjNIUis2VkFST1A2Z3RtVWNYdFBHaEpLaVdi?=
 =?utf-8?B?UHVZWFdwQWI1UFlBY1g0VCtmM01oeUFUMVVOYmxLVm9zeDJsUXpWdUt4R2or?=
 =?utf-8?B?dXQwcDd2UXdGdkx1SGNMdG02UVVLMVNWVVR3R1FpTFg3Kzg2c0lMRXFyaGRi?=
 =?utf-8?B?MUtoWEtXZXo1UVJ4OUVJM3dneVFhREVJeWR3a3JydDRpSmpTZS94ZVhhb1pt?=
 =?utf-8?B?K1RxcXc1cXUxNDRWVDlOb3Jxd3dDSTljeTJUV0RJQ3B2cEJXUC9ISUZGTE5v?=
 =?utf-8?B?NWt3ek00SzVnaVRHZ0tHN29FeEhtNXYzK0VQd1BPa1RGRy9DekFBYzhGck1Q?=
 =?utf-8?B?Rld1RUpZdk1TaXlQNWY5Z1JNRWJ5VGtCTWxqQTVOWWk0TDBxSnloZVBzZ1pE?=
 =?utf-8?B?WVZLR3Q5KzljeTUwN0ZpUWRmazBLME1qVzltTFRZbHNmMlNlUVF4bFJuSE5K?=
 =?utf-8?B?RWdkMlhVeHpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um8xRFl3cGJwUmVpb0h1VVZWUHUzWnBFcHNvYnhXb1BRa0s5bVVSV3gzSys1?=
 =?utf-8?B?ellEaFI5U0tnbnhlYmUwK0trWWhXeTFEeERrREpTaXBtTHkzS0ZDa3pTZncy?=
 =?utf-8?B?dFBXZjRyNlBtK2p6ODU1OEFDQUdzbVJaM2oxSHNyYkVRWnZ3ZitVTWhvcVRn?=
 =?utf-8?B?YmJiZExtYzdBQWYyTEYrNXlnSHFJcEN5Y0FwbGZHOHZUR2RqZzhTODdTSWhn?=
 =?utf-8?B?bVFQU0RHOVdrS3dTa01CUlRjRmZoSDY5Q0lNOVVHTU80YmpucEF0MWZXb3dG?=
 =?utf-8?B?OENPN284THJGN3E1NXRyVnJaL05nZDNrQ3FXTjM1Y2xQTTFrWXQwcVVLd3Ev?=
 =?utf-8?B?Vk4rcm9xeGNSMmVXcjRiV25FNTNRbVIxZllWUGF6dzVPY1RFMzNYdENDZmFz?=
 =?utf-8?B?cmxqQVl3VkFCZWJMakNad1JlblNJUi9LR0lyTzZZdEdaMUNoYVZlOGl1UVVT?=
 =?utf-8?B?aXdEVlM4a1FyaHYxdnZKSndkcXE4Q0dLMnZKeWhKazRaWC9IU2RnZGIrRzZC?=
 =?utf-8?B?dkJyRVNtdmN6bURyUTRhMCtwck52dnl0dklvQmFDbWVoRmdGWU1ra1VYNlBp?=
 =?utf-8?B?TWFqUm1jVUc4clJVOUpQTHFHOUpOWlFnRWpQNWh4Q3VTbmUrOXZKbU81bk5Q?=
 =?utf-8?B?N0NJZm1mMW1XYXQxRkkveUZHMitQdHN3QjBURXE1bjlTb0tHMjBoektDTXFU?=
 =?utf-8?B?dE9RbEtnVExDRmNTaGptb1JmQng0V0dycUhrMzBmL003dTBiNzdrMmZyR3p1?=
 =?utf-8?B?MkxrUWR0cTRtNFpzc0p4b1ozUU5OUGlhN3o0cVpkR202YUdDaW5UZ3lDTjAr?=
 =?utf-8?B?TUFJQ0l6SHk4THViY2dtTWs4amUzRitUYlBNQ3V0cnhRNXhabDhtRVlEb2Ju?=
 =?utf-8?B?YUhYb255L2JXOVpISEE3eHR2WEtDR2prZDdnMk85cDFFTTZ2WWtCQXVFT2I3?=
 =?utf-8?B?WEJUVVdxZXBETmhwcUU5ZllyM2diYlRvSjdUS0JJWExBMUMzTGtzVnh6dzY2?=
 =?utf-8?B?dkFTNFZ5UTBzUjdmaHJtbTFqa3ozNjVLNkF3eXFmekV4NEJ2cnJFVkFyUEsv?=
 =?utf-8?B?akxzWlFzMEZRUmpRVXZNVWs2emRzS0xkYnlOT3BNWE53cXVZQTAvVVVzN3Yx?=
 =?utf-8?B?NTV1NlVDNStaSEljZkRPMkJHdlY1NXFkZDJiekJiQmhqMnpkaXcrcW9vTDlQ?=
 =?utf-8?B?NXRBSXhROG5WR0JIdGFFUkhMZ3RQdnFjNjRxbUpYdVBkT2hrdlZ5WFlzSmtI?=
 =?utf-8?B?OUw3OGxhMjNkVk9VRWtranpVSHJPcWQ1aXJ3TDBKdmxSRXE2UHdQU0dSWHhw?=
 =?utf-8?B?TGdYMndDdjlrTWxiN2lPTGJlWnZsNkFDSjlqV0RQUHB5RjN2VWJNcnA4aDY3?=
 =?utf-8?B?SFZja29FUUhTcjRZWnNJQ1pPNDYrSDlzQmZZaUhhRHg1eFRwN3czRW56Z1Ir?=
 =?utf-8?B?WHlpRlJvcUpsR0duSHlJOW9kM1MxV3NUd2QrNTR3Y0VsVStDZWNESFZSME5N?=
 =?utf-8?B?QnVySFUycU91THA0cmt2eUc4Nm1WTWVhQWZhK3JVdkpVUStVZVJrajJGRnh0?=
 =?utf-8?B?SFlnV3dGbSs0Mm14cnQwZHM4TUowZmFXNWFNYmM3a2drQWRxa3pOR0NYbCtv?=
 =?utf-8?B?VkRGWGxpZVRic3psVVZkR2V1SDhjWWdRNXlSdllwOC9EaG5FeFlTaXI3cjVT?=
 =?utf-8?B?ODZMaGFyWEMyRjI5Zm9rWWMzcmVHelV4NS9xNmZGOWU4SDNUU2NNU2tSTWth?=
 =?utf-8?B?UVhHendCSlZ6ZmYxQ0ZGbUppWWRlcENaZlNtSUZhQ0NhaUVEdU56djhtZDYv?=
 =?utf-8?B?ZUFYY2JVNXVmVlJuenArbEIvM2thSmhVdmxuZUJiYk9iVjFIdXJuYllEa0xz?=
 =?utf-8?B?ZktsRGJuS3NEZzZpb2JtVTY3bXlmMVdKTmRra1BYazdNQTFEYWV0enZnbEov?=
 =?utf-8?B?akVzejR6NFVldnNIMExhZE1EQzgxR3dJWkdDZU84QmYvZmcwRlZjc3ZlM3Ay?=
 =?utf-8?B?ellvWC9ERmF5R1dGekN3RG5MenZmQ0ErTkZNdHk2V0JLZ3RiMkdoSnNySnJk?=
 =?utf-8?B?K0FOM0t6UEJTZ3Fvak8xRjJQYVRaYXEvZUJoR1ltaEx0WER3UU5aeEpqNDUx?=
 =?utf-8?B?L3JRNVowNXA3MUUrUnNHeU9mSHNXQW9zNzkwaVlaM0JjZnB3OEtVUkZhWGV4?=
 =?utf-8?Q?OjQD001WUhk9KXHo6SjCmfRdzA1bTlyrJ+YhvJJjSEwL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C3D588E8E60714DB35167807F4417FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf57c27-2985-40a9-dbbd-08ddc326aac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 22:34:59.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BVaJmkjSU7ZCu3gRbRMLP6+1QpkQ+Q10MtZDWNM8ywns3VnvzGqWl/drMW7f5K8Xp5SMn0d/Y+XdgDwBq1hyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

T24gNy8xNC8yNSAwNzozOCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgem9uZWQg
YmxvY2sgY29tbWFuZHMgdG8gYmxrX2ZpbGxfcndiczoNCj4NCj4gLSBaT05FIEFQUEVORCB3aWxs
IGJlIGRlY29kZWQgYXMgJ1pBJw0KPiAtIFpPTkUgUkVTRVQgYW5kIFpPTkUgUkVTRVQgQUxMIHdp
bGwgYmUgZGVjb2RlZCBhcyAnWlInDQo+IC0gWk9ORSBGSU5JU0ggd2lsbCBiZSBkZWNvZGVkIGFz
ICdaRicNCj4gLSBaT05FIE9QRU4gd2lsbCBiZSBkZWNvZGVkIGFzICdaTycNCj4gLSBaT05FIENM
T1NFIHdpbGwgYmUgZGVjb2RlZCBhcyAnWkMnDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVz
IFRodW1zaGlybjxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==
