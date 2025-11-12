Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E72F56
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913736; cv=fail; b=Qe+MuSBjEmdc/XfJgJvLl+kdbv9ihJ9LB8Py9KjEQZhZZbq4wL4U53FRNPmHd7HNMKbayE94QnqcVx28YHUa4GR8gXdDwboZIFCWZ3AQK6EIHLK0uIzgBT2tMEKvNaUPtgccbpVayzD8S4AwUngTRJHPnYgKtT46tCtuzLPFZOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913736; c=relaxed/simple;
	bh=ejKGqCWPUVzBBz63JT851TeFd67uGuMVKAjR2UANXOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PIBDpFR17AGXIxrKiI9UT9EPqI+ZG8l2f+DPq18H+k5/bG/N/mLFjNUvrjfrylFSEuZv06tjrgMqi85lE1uoXL8ZR009uEjN7ogq8YK17j3bBhDQ4gCW74t6cpDiZTAoiKU91RiI/ObuxPjGY2f6J+ZFzxLYyyX2YNzFVLpDBLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q00wfyKy; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q00wfyKy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZhcITfxXC2dqy7ZiDSKCisLUphQrfn0CjFSIqUc3TFE3Fjn0B1QtLRcGtmp13QNjuGQj8Tay+wcgsuzOMNCkurjPQaT9I5RB1SJmelXQG62cmtxdUGrwEchEkzBm48bWgmHTJ9lQvRB25A0GRx5gAXly4s0QSgNY2s+DsAdJxoI2W0/M4fnx8W9grAhZh8e8fntKAsMpstnpjOoOW97gY/3gMxfdwK1FmA2ba/YlIFyUO2AQGG/MbEtraQlEiOOKOWL03Ynu7M2Rz7W1MVErr8vsoFIDI+S/UKCO7AdAoye9LsPl6zfFWp450guDxeJUcXuq2NjMuMkF4ZUC5tRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejKGqCWPUVzBBz63JT851TeFd67uGuMVKAjR2UANXOg=;
 b=J1wP2qk946p+Q0ePPhsBhx3dQaB0/It/b+NtpLscyZqMiOjf0HWzTQ7r95/3ho+VDBAhjpra5onDAmJOZWZ20J2o5uDzlIhc9ZZulPxKWaOu/VA8odWHQ9gHmQn+0wrH2KbBO5p49VtSLPxid1cvrZc1pqrCMaJsw9vG8+oMsP1eMLT2PRLPFYuRGULpkBEflDdWGaVXpXTwKdXcfBWFr8TSbOZOmH1uP8IGAhxYor5s0WC/CdqCpTwnMbeAZeFhlyd6TdWCKYX329kRYrnR4D2vZz6HZD5//GP8sLn4lvakde/TvNDsSYFYorjoB1WXQlgWbbXuoGGyyF+CRh3fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejKGqCWPUVzBBz63JT851TeFd67uGuMVKAjR2UANXOg=;
 b=Q00wfyKyEu2bQ+Uf3Rnlhs+vQl9MvyiIGQnha83Yy84gKt/UiC1hA4hck4SvMV7xv2Wz8MZWdTuo2qD8Lde7vEFYe93s4iPkoQu0FEQBKS7IA2er0cAnLbqB1V1nlLAMsj1dKrHEOFmzAmsF6Y4yDXWEGDYdsgZW56zhfLyIT3WHwGMiF87Jm2iDd5eC4q4alOJDDBTzzdt82mq47XmdR5Blg47RC38q7tXyVLeCIaZUp5SkaoILbFs/nbdHuYkfspmRg/uMG5m3CeuojkFFCTLXLr/T52ykBWDlBj/dN8nrDvZQfksNQS9TB+/fBwK3kFyeby+xcbQGQvtNW/9uwg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Wed, 12 Nov
 2025 02:15:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 02:15:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Damien Le Moal
	<dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Zheng Qixing <zhengqixing@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
Thread-Topic: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
Thread-Index: AQHcU1fLinJu53fqvUCgBZXiC1mIBrTuSgYAgAADuIA=
Date: Wed, 12 Nov 2025 02:15:30 +0000
Message-ID: <cafae79a-afa2-49c6-aa2c-dafe3a5e3003@nvidia.com>
References: <20251111220838.926321-1-bvanassche@acm.org>
 <aRPqoinLQjYFBJsO@kbusch-mbp>
In-Reply-To: <aRPqoinLQjYFBJsO@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB8023:EE_
x-ms-office365-filtering-correlation-id: 24dc78be-8d9e-442e-d670-08de21915a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEVUOXY5R1VCL2NCZnNlMnhmNkoyZElPblc0NForVUZPNThjZmdYeUNEVjVH?=
 =?utf-8?B?Z0xSQmsrVHJhbmpTUnMxbkJTNkgzdFZPc3lwT1gzZHljMHY0RFpFU1VNc0FJ?=
 =?utf-8?B?ZFpPcjJqbngwRXIxQlVUWXc4UlZ5bXVBMit2YzJjc1VHNzcreTd0NUR3a0xm?=
 =?utf-8?B?ZHJMOThsMWR6SWNvSzdNcklCTzgyYmRoRkNrRVl4NDlDeHdXTlN0UVBUYUU3?=
 =?utf-8?B?ZmFMcmtlc0FIc0l5RGdGcnoxZ2hRMTVoK0xaMm9Jb0RJZkRXeE9TY045OVRv?=
 =?utf-8?B?MnBXQkpMN3B4OWlmQVZIaXFrYmtRYVhzUkkyUWtyTWFodklRQmNwb0I5emxh?=
 =?utf-8?B?Rk04cGMwQ29lS1pGY0ZDY1hFU0RlZkRKS1ppUzcxY0djZDVOQW10TUpRdGIr?=
 =?utf-8?B?dnFiSWZ6TlEwQlhxSXJ2QzVuODl3eis4bkw5SGV5N2NuNWcxcHlBeGhQV3hQ?=
 =?utf-8?B?NWMrajJRNHZOd1V1Rmp1ZDJrRzdwWHllVkFJOEdIN2xFWVpFSGQxd0JPMFRR?=
 =?utf-8?B?NVQ2WnExaTJOSDFiZ2trU0F0ZGdJYUJXaUc1NERDR2F4V2xHUHlTQXJNL2w4?=
 =?utf-8?B?R1RUd09WaUJHVVVpSHE2YW9aa2dLYjFIYzE5K3ZVNHJxVU94ek45YmRiL1lt?=
 =?utf-8?B?MWN1SUt2eVYzRkZNRzNqWnBybXlEdjBkVGZiVHNFRXo5cnR3cXZhUEJFa0RC?=
 =?utf-8?B?SlZ0VUZzK2pXZkljeW1CS1ovREtwc0ZJbFJIRkc4dGZaZ0Vjb1M2MWR0T3d6?=
 =?utf-8?B?bDlEejZESlcvd0NrWWhyNjFIVUtnMEttWWpmSTh4MDR5Z2tldnI3TXF3T09x?=
 =?utf-8?B?SVdUUGY3aVBnQndHMnhEdE5FV1FMei9Rei9MTVRkV3YySTBKdkxHSU5IRWdk?=
 =?utf-8?B?TnhhVFZsOTNkMUxKTjV2ZFhDQ3A0WGRXL2VyK2lPQ3ZnNGVFSXFkZzJNNVNl?=
 =?utf-8?B?RUpRdDhmWGEzeVROdnNZbFdYWksvR3NuZTZFcDJuK3ZMbXFTdzFnRW9XT0FE?=
 =?utf-8?B?Mnp3Yk5TeVlneU56c2lsbWlyZ1VrUVByTWh4NVNRODVCYWJaQ1p2Nng1akN2?=
 =?utf-8?B?TWZqdUw4aFZwZkNpV3VoY1l6c3BxMzVmQk1DRllYYnZBU1hNK2QwTThQQ0NP?=
 =?utf-8?B?MmZkRUZvQnJ5eEJrSE9ubHdza0c5TkhsbVA1ME50NDBtRXYvK1NtNDlSM0ZR?=
 =?utf-8?B?ZVhzREh4MXMxd1A5NUNCMGIvMFhWMnZTT3NnK1hKQm9pbmFtWExIL0ozTHlM?=
 =?utf-8?B?TFFVOEVRY0F6K0kvcHFqaGgyL0FSYk13emNCYUFzOUJGREhsd1dPK0F1ZVBI?=
 =?utf-8?B?NFh0TlBiNk1veFlYNE9wSUFuZWFaSzB4QmtVYTN1RFA4OE5zMUVPeldIbEJn?=
 =?utf-8?B?WmVCYVQ1cGJFREh3NjBIWlJFZDNlMzlWaHNFMTRnN0VQMkErUTVYODdUbzh0?=
 =?utf-8?B?V3lZVlBIcDc4Qmxsa0dkRVFEOUs4TVFwNzFPcDFtMGQxOU9nUzE2dlYwb3hs?=
 =?utf-8?B?VXNQbjdWQkRsWG9TNmFtNU11czNLNzJ6OXpHTFp1ckwyQk1PQTNmRVlQWlVF?=
 =?utf-8?B?eFQvczZWMjc3amRYZnc5R1Q4MnJFT1AwdENXM2FCaldMNHFOQTBCR215cklI?=
 =?utf-8?B?dnk0eXJxbTEzSUhoemFkSk1ESThtUFo0Q3lPSjlqYnR6MUYvejBQSTRPeUtH?=
 =?utf-8?B?ZTc2eVdHRXJhbFZ5aXE5UEJHcm02RUNpUEFWeklzRXgwdjlSeWxVRW92TzAx?=
 =?utf-8?B?V2xjMTI1MHFsVzJ0M3ZqRkFWclBmaGlpNDVLbmlsVldtQWhXNlUrMjErRkVY?=
 =?utf-8?B?ZFVZM1ppcHY2azh2dmsrUkZEeUFBczlSaW9Pb3BMa0ZGaGZZZUczWkduVUIx?=
 =?utf-8?B?amZXR2hiODIwcUNQb3lDQkNxZXlGUjRLb1RKOU41MTd1VmQ3L0ZjQzQxSG9v?=
 =?utf-8?B?OVJwbVgrVEczeHF0WG9Mdk9OOG1rSjhrTU5rZm94eXFuaDJvaTlGSVVvRVpV?=
 =?utf-8?B?N2x2YU5TcXMrZ2ZITGlILy8va3lsWGVvOVYvTDFrakJiMmQzaDFmYS83OHpq?=
 =?utf-8?Q?j8bXyl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2RXSWtTcnhxV2tLSEN6RlV1em9JVE56QWZUM1dRaGpjTzFqaDIwbTBIYnJU?=
 =?utf-8?B?V3ZWN3YzbFUrSVF1ZFJSMFhHbnhhdkl6UlpUVEJiVkpRaWNVcGswOTlUSXYz?=
 =?utf-8?B?S0FheUpjeERUZVVBTFJMZTlJT0tFQkwrVVpRWlNSNllHNjltMTI4TGU0aFZ6?=
 =?utf-8?B?dXgwQjM5VWlqUmFVVDJwN2NiSDM3bVpqTjlDWDhLZGd0NWtDZy9sL3MzYjBH?=
 =?utf-8?B?TGdGbEZZcnlrdUY0cmtYdC80MG5ud2xFeXk1V3JzNk9zQzF2a0tvQXVta1E4?=
 =?utf-8?B?WHkzSGJCTUlobnFQVEtuYS9jaHArMkJNS08xVHpnZ1BxMEhWSlk4bGRmbWQz?=
 =?utf-8?B?UnF4S0dQSHVBRW4zbFNRYVFIZXVmZURsQjdjRWtQY0t5REI5dXE5MlR0TXNh?=
 =?utf-8?B?NmxTSHJJTDRsNEZiN2xGODJZanhHb2pCMzRjckh4QWgzN1pFZEo4cVFaMUx0?=
 =?utf-8?B?b2ZuM3dhb21WaU5EZnFOWDFWV3JHVE9QQU5GT0dMVGlDeXRtckIwMkl5WE5v?=
 =?utf-8?B?ZUFyejVxWWt0L0hBR01XbzJwWmVmNURZWXp2QTNSM2Y2blJ0UFlJV3hWV3B1?=
 =?utf-8?B?V0t1d1FXYTYyMjRtY2puaWw2QkJYTytzVWpvMWoyNy9nQXc2czhpaE1rTzBz?=
 =?utf-8?B?WlZ4RkFmYXZ4ajhQZzZIbVhDK3Y4NDdpK0o3WjBKZDJ6WjhoT29JcHJOekli?=
 =?utf-8?B?UjQvaExOdmdWdURiUWdBTFM0ZCtTZHFsYlZNZm1DNVpndXpJZmlkUXhrd2Zv?=
 =?utf-8?B?OWcxdzQwZG1aSVNkaDlSVWltSDRHNXh6MWVhcW54d0haaUNzVVJQRUVGb3hL?=
 =?utf-8?B?QTVMQ0RMeElNVkx1M2hBcjlWUmQvWFJUZTlvVldZSVcxTjVuUjhYWlMrdHJ1?=
 =?utf-8?B?bUxFZmFzU3JTUmxJQUhzNExrVTYvTG1BOUIyZ3Vmd2lOVzNoaXlBbVl1VTUz?=
 =?utf-8?B?SkJRUE1GTlJrZzM5UnU4TkkzVS9ZNDREV1J3eTEwcXZUVWt0Y004ckt2VWNK?=
 =?utf-8?B?cWt6ZHZuUk1IVFljNEdNTXpVNkhIV0lhTHJRcitCRnJjSVczUE9oN0YrSTg0?=
 =?utf-8?B?RkEyc0pRdHlSTG93azhxNlBWWFlheGdTRjdCRVRyQ3EyNGhXKzNyVFZIQ2pL?=
 =?utf-8?B?Z0FjbHN2NUpESzZHQzVtVUEzN3hvTHl6K2xzY3FZeUxLOHlWR3lSbGtsTFln?=
 =?utf-8?B?UHVFZHR0cm5NTlkwSnhLb1JKZWRyV2RMeFpJTU9NMzRZNFZTS2hIS0xmQ282?=
 =?utf-8?B?eFZxSWt0WXBodS82MG5NVmplc1Q1MHU1M1FXUXF2N0xROUtPUFd1WEhYa0Nr?=
 =?utf-8?B?aXI2UkJ0b0tPY3hLc1BkN2ZnQ3Q4SC9abmd6YkRvbElielA3b09wT0F3ZWsw?=
 =?utf-8?B?Zzk1Z25reUNTVHd1NmRNNzI2M1J1bjdqRkg2aVpqRHRHUHVpKzJnYjFpSDhM?=
 =?utf-8?B?RmtmWWtNMDd1YUdDUFFuOUxtSnZvdmVZUlNraFZzU3RSQzhaNUpJb3N2VnlU?=
 =?utf-8?B?U3J5dnF4VVprM3N1V2VnSWpCaTF5clk5VFdsSVhFMGRuY05ZZjNpbytPL0hR?=
 =?utf-8?B?bURVeGY2c3pBdWM3MzZTYm05OUpyZDFOMHFpeSt3M0Z4UGd1anNpRDZmTWxP?=
 =?utf-8?B?UXZzem0xSDlIc0sxRGxSbzZ0UkZ4b2ZJQkNDYUxyZTdEaEV6WkNYcGxvNlZP?=
 =?utf-8?B?WTdSdVdWNDgwTDQxODIwL0UzaVo1SklzSTBnbEtUNHd2ZHdacjNRcksvZDhR?=
 =?utf-8?B?ZG1tZy95azNUZTAra3JJQnQxSzN2Vk9YbmNURU4xN0xaVHN1bk4ya256Q1hv?=
 =?utf-8?B?NHFaUHUyVzdWYUhXMGRKVkQ4a3BnMWRsRGEybzR1aHBVNlZyZlJVZ3Budjdq?=
 =?utf-8?B?WTFPVW1pL1A4NVdSVmd1emZFbEpOUVhBc0s4aWNvZ3IyRFJYcjZGTDVpMU1Z?=
 =?utf-8?B?dG5FUTFJVThFVVdaZ1pQWDFsYW1wR2tGR0dSRUhGbXFrb3J5VytFbnRFaEt5?=
 =?utf-8?B?WlZFajBEelBiYWRpTldteHBFcTVUU2tNYTRvbnd0Zjk1MnVtT3RkMk5DZlZB?=
 =?utf-8?B?N1JWRHZCL3JQaGpEVDhIQWc3MjI5dzZVMVlaZWQ3bE9vb1NXRGVyMHFzK0F4?=
 =?utf-8?B?eDZKSFFBSm9NRk1TQWVyVlZpUklPczZKdkxXWFRxeGlqc0RlZGY2c090OEll?=
 =?utf-8?Q?7euXGdsefCVlqOnNlyVI8/QmEskAccGJlAgO3B7nv0MM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F53ED5F8A688140A2C3C7B76B06356F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dc78be-8d9e-442e-d670-08de21915a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 02:15:30.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7K8fPauKvLT7lWFwhRS/BsbZtikG60Y4xJ1vHO1znk2ymvK9mAowtZxW/qiRsu6So38dub3CJLe19UlkJCoew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

T24gMTEvMTEvMjUgMTg6MDIsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAxMSwg
MjAyNSBhdCAwMjowODozM1BNIC0wODAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+PiBUaGlz
IHJldmVydHMgY29tbWl0IDM0NTFjZjM0ZjUxYmI3MGMyNDQxM2FiYjIwYjQyM2U2NDQ4NjE2MWIg
YW5kIGZpeGVzDQo+PiB0aGUgZm9sbG93aW5nIEtBU0FOIGNvbXBsYWludCB3aGVuIHJ1bm5pbmcg
dGVzdCB6YmQvMDEzDQo+IENhbiBJIHBsZWFzZSBqdXN0IGdldCBvbmUgY2hhbmNlIHRvIGZpeCBp
dCBiZWZvcmUgYSBrbmVlamVyayByZXZlcnQ/Pw0KPg0KPiBUaGlzIHdhcyBpbiB2MSwgaXQgd2Fz
IG1pc3Rha2VubHkgZHJvcHBlZCBmcm9tIHYyLg0KPg0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWlu
LmMNCj4gaW5kZXggZjFlNjc5NjJlY2FlYi4uNTVjM2Y0ZDYyYzJlMyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9ibG9jay9udWxs
X2Jsay9tYWluLmMNCj4gQEAgLTEyNDAsOSArMTI0MCwxMiBAQCBzdGF0aWMgYmxrX3N0YXR1c190
IG51bGxfdHJhbnNmZXIoc3RydWN0IG51bGxiICpudWxsYiwgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+
DQo+ICAgICAgICAgIHAgPSBrbWFwX2xvY2FsX3BhZ2UocGFnZSkgKyBvZmY7DQo+ICAgICAgICAg
IGlmICghaXNfd3JpdGUpIHsNCj4gLSAgICAgICAgICAgICAgIGlmIChkZXYtPnpvbmVkKQ0KPiAr
ICAgICAgICAgICAgICAgaWYgKGRldi0+em9uZWQpIHsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHZhbGlkX2xlbiA9IG51bGxfem9uZV92YWxpZF9yZWFkX2xlbihudWxsYiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zID4+IFNFQ1RPUl9TSElGVCwgbGVuKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZhbGlkX2xlbiAhPSBsZW4pDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdmFsaWRfbGVuIC09IChwb3MgJiAoU0VDVE9SX1NJWkUg
LSAxKSk7DQo+ICsgICAgICAgICAgICAgICB9DQo+DQo+ICAgICAgICAgICAgICAgICAgaWYgKHZh
bGlkX2xlbikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY29weV9mcm9tX251bGxiKG51
bGxiLCBwLCBwb3MsIHZhbGlkX2xlbik7DQo+IC0tDQoNCg0KKzEgb24gZml4IGJlZm9yZSByZXZl
cnQsDQoNCi1jaw0KDQoNCg==
