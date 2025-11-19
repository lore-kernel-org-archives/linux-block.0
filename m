Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2E30C366
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595578; cv=fail; b=KxVmjRFpBsM5gzAW0ELnGQg/+gA2ixUt1iVdg/+UiHIzrF7lqmVB/02KSGY/EbhPK/T5hxovlY/JtsgBCMpjCHaYbY4nvIhciG1f2cnVY6EGEwE9qQJ0+126ubYJAXSsgKdnpJsx1tFEHrf4mUBUkAl6ntagoHtrh/F8ObM2lDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595578; c=relaxed/simple;
	bh=VLF+QAsf28lk9PgNIx74HF5myTNXqyjBQf5FuJhjiJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muF86Mw4csoxzuxnkcY4olqiiqhjYpX+bbXCkWJBX2wb4PAnUjtVeTkOovo3FxbfaFiiv7jLtnooR9Lls8pww55wvkeS3Dqbno0qx7P5Yv4l2Dg6rf1ONH9ll8K8jj8DPviOHjqOHJnDnS1hyAgvoc2e0aWfivLF6gLw6/7K+Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hZGm/o2N; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZGm/o2N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnpOPKYkNs3J38dTQZkoIcGlr+GsXEyBYzutzbi/W1wIebEF5twyL6WmBm+YIDKkzjH/2l/7JosJufXKZ4+T4naatIRwmviYTQdF9L3QUyY0wTYgllYv3mv6YwkU/czsHDPdzPylHEb7eCaC6tRJ+zhJW8LFj3sk7Rc+O+qDg8RQ4QbGO8X7BvstNqRDMNEtTLMdQqRsrA5KHtgUGe3D0bxpfBGmdYqxmRdgXfZNTZYZmqbEGC1c7OWWWYOBvntKkRw35Bx3SxZqeEK7YdbT89aNpvlpClNZ/bFegrLlyTzhLiS9r6XQ6PlGmw0oELRvrK5CvW3QGuJh3YTmk6Fw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLF+QAsf28lk9PgNIx74HF5myTNXqyjBQf5FuJhjiJU=;
 b=jSKhwIQLDbQsOQNL4/3ivXzPm/iL1c/7A36/FWFElHQwX6vu8jR9XlSeiiZ5BIjogMI6xHrkmZFH5HqKtHvdaRgN8fmQAeP1csvBHyZ6k1Z8Rx0J+3kEDgdwhV1yWBh3d3SUNZlRna/YYsCvP5NUY+yV5FbGM0G+zKqiX4n9CLfecvmXnnWd7NdbPToyl4cvKe2tlUSFmndVBi/Us35uux6UMVh6Ngx85rERg4bGFYJCSaTcssYzDYX4bYLDqVfMMlr+JRet210Jgo4S2BzALkrZnfGdBjV3ldYL33UUxKrCZYutQ+y3tjzsU9vHZ7VPqIZleO/1kLP/g2kfNZeS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLF+QAsf28lk9PgNIx74HF5myTNXqyjBQf5FuJhjiJU=;
 b=hZGm/o2N5jRkiE9KeeiDcGS1r31S/IuR0HYKWhoeOoRKlmRaIWgRCt//YIuce96ofrP9amjuI8xnzTF/Rj5LqaVmjvEvkmO6RBuyCLKxP2D89FCUdfRsoj7KG+Ta53l4UFhrB9MKODzadrkZKqyKnPNSw/gu9uu8RvN0+e10WedzDupuAIASg9b8Ho/A/IOU4OXt40+7YjjrFQ1OtxdU+6hzcFlC9802221xCNaqLU/IfBfljGMuLbQnvmWDE+ABCNTxENF6ljulkWn4WFR9YhuAl7NX4+4F0gyDJBTwSpCv3Sm6FHPFUwhBFZdOSt33T/4ip8nZgZQ+KQFowo5v7A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:39:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 23:39:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Topic: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Index: AQHcWY5pp8pvRk/tS0G+GdNsr4pEy7T6qGAA
Date: Wed, 19 Nov 2025 23:39:28 +0000
Message-ID: <90a15e9e-3ff7-4f7c-be03-63330d10b1b4@nvidia.com>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
In-Reply-To: <20251119195449.2922332-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8909:EE_
x-ms-office365-filtering-correlation-id: c77a8c9a-e01c-47f0-ecf7-08de27c4e189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3dJMGlpR3d2VXhldmZXM3dBMnhDV3I2dVd0Qm1wRjdNNCsxcG04b21EL0ZF?=
 =?utf-8?B?eWN2aytxZlQ3YVVrWE04R1hzaU9oTWVzSzJWaWorRGZUV1JYQk5CWjJxQTBN?=
 =?utf-8?B?QmxtYWVQVmVuUlVtdFdhbmJsZVBmMFd5T09GaTFld0dRcEQ0aHUxejUxQ2FO?=
 =?utf-8?B?UjVEaEFuVURIVTJSWlFNMG1Mc2ZoM2lSenVndUt5aC9rR2xhemVkclJaY0pa?=
 =?utf-8?B?dDB1UDQrM05sZmVEd3BkZ1JQQnQrN0QxOE02Z0ZrSXl3aTdyZDhZKzBRbWhi?=
 =?utf-8?B?RTZ0S1R4MGxzMHN0VVcyOE0yM21tSC9TMktZVDNPWWxsSWJJb1ZUNi9BcEpp?=
 =?utf-8?B?WGY2SHFtWnBFRnN4a1RHVldZbzR6NEFqSTRDV2d3cFRlZjVwV1VsYWJhM0NQ?=
 =?utf-8?B?T1NhamtqWVl6ajJ0OXdMSjR4Vytza2JPL3RBUFNhVWdPRTFOYzcyY3NLc1or?=
 =?utf-8?B?TmxBemFIRC92am92VW5RbzN5RlJyckhPTVhMZC9hbXZTdTJxdXRFSXJxUGFv?=
 =?utf-8?B?dmtRa2FoMGZMTXY1QjhpTDY1RnRlb2JIUFlqS2hZUEhMRFZrQUVEQUhneUF3?=
 =?utf-8?B?ZUcvYy9uejBtRGVycDNZOVBHQ2ZtR0JjeGtCQTVMSTNVZGNJTHQ3TW8yaDNx?=
 =?utf-8?B?cXViQ0dRS3pCdGNtYTR0Vkw0WFJhUWJvMnlxKytkcWhDUWNVNzg3N2o5K1Ex?=
 =?utf-8?B?MFovWkdwQXdadzQxL28yTzF6M2xzYnFkVllQNDAyYnE5dEp6dlhRUUZHbjM4?=
 =?utf-8?B?bi9LQnloRVI0dWlWUlhDYlBlTWZtRVQwNmlLZDJUaDEyZGxTTkJDVXVZM1Bi?=
 =?utf-8?B?SUpXQWFtQ29GQ0pXOXFZN1VsWTZJNkNlSWl0VEIydGdleVhrYWJtd29SMlU3?=
 =?utf-8?B?cER5TzFlV0MrV2RwVVlGbCszRkw4TlRVRlBmR1llcjk1Kzl1NXdwNWpBYVk4?=
 =?utf-8?B?ZXZzUndERG1EaWJDVGdrNXFHOFF1Szk4OUVOUm44MkJ4UEdxSXdldDJKUzF2?=
 =?utf-8?B?eE41UEtqN1huTk9Pc0xpT2tIaUxBT1Q0a1IyczBBRFBuenBxWDBzTzQ2NVJp?=
 =?utf-8?B?TFp4ejcwOGJHV1R1bkVZZDlUMlRLMklFcTZZVVZ1T3JXek84RHhXcm50VlNp?=
 =?utf-8?B?T3FYalBhQS9KRkZDVjZYM3d6aEttNmYyR0FxcnhjMUpoSU1DNXRtcWROWUd0?=
 =?utf-8?B?cTdvako4YUsrL2UyeUtBRG9HQ1l0TENnNzFsVWlXNEIzOXdiaFdNL1dCTFdO?=
 =?utf-8?B?c2ZLTXdrSkppbWYyRWpKSys3ajRLdGl5bUZDVWFsc3N2LzFmYWxLOWc2dFpQ?=
 =?utf-8?B?N3hwdHlueHlFSk9yRWYzVmsxclRzQUdsWkV1d3pvck5oUE5wMDAxUTJRZ2Mv?=
 =?utf-8?B?U3V6K2YyajZuTitBMmV6Z1FiZlZJMUh1bW16RXFqL3NiSHp6bnUrM1dpbklH?=
 =?utf-8?B?OFFKSUhTSVA5ZTg3MVo0U3RyZDVEREZrUEtJcWx5S0VrMmJqZVY1OGNWQlZL?=
 =?utf-8?B?ZTZPdHdPVHNmNVV4b0thQytBN0F6aVA2TloxTjNxT0hkRCs0bVVPYldFdVdL?=
 =?utf-8?B?T3NiNExjaHBMazhyYUFGWjlaVlNBSjJFNHNCMmNKN01NUWU0YkJOdW5pWkYw?=
 =?utf-8?B?TUptUXhKSzBiUW93dWNHWC9FejNYa2FHdTdtazlDSzNpNDc2MnlUQndOc3Jk?=
 =?utf-8?B?Tml1YmFaYWRPTE5YanY0Yk9zTi8zVldaeFZIQmlka21FWmFtS1ZYcHRqQ3ZT?=
 =?utf-8?B?QWUzeG9zSzI0K1pjRmFua2pBd1RzNVE4SGpxcUxXMlduRzRNZkUxZVhKVVV1?=
 =?utf-8?B?eHpJZzY3WnhtS2FsakJaZ0VxdVJINkJvOGh3Qkl5cVRkT1B1ZVhjTTJQSWR3?=
 =?utf-8?B?Kzk4R2p5NDRaeUE1MFJYRE50MnllYWVWZlE2NGRISWhtTEFObzAybWcvQ3Nm?=
 =?utf-8?B?RGRsWExhc1d4SnQrcFhkSE9kTHJvc1FCTHNzdmdYeXpCamJlRTZ5bVBsWGZa?=
 =?utf-8?B?dEptM2lTSjFSVkhJaHc0ZlhSTWhONFhZTWkwc2M4TDF0ZUdVN0hKTnYvWHdK?=
 =?utf-8?Q?DufThj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjhNZ2lkaEpBVVNjTjBiMVRESkg4dVZHbEZHWnFzSEI0bkNYQ1Z4ZnJOZzlX?=
 =?utf-8?B?ZDJOUE9xZlJvT2hvcVF3M3c1N290NmQrL3BpVERvYjBFUXFDcmxQU2NpQjZt?=
 =?utf-8?B?TU9TVldsM3gwMW1qeGxHNjNpaWVnOTYvZGsyMm1rNnc3YVNhWExYaHBTa1hP?=
 =?utf-8?B?OW5qUklzZUd5QXhURU1vTFVnbTcxVW1mQ2dCUmtpcE12TS9VWVQvYTkzNk0r?=
 =?utf-8?B?NTRUOFlZU2VkMGNGa0tHeStNRXllMkpObXVhT3BmUUdSTmhJS3RxWUVObjR3?=
 =?utf-8?B?ODNlUk9WRkFwbGhsLzMwUWZQS2lZRGVnNk9TekdyTForYVd4UXd1NmJlcUsz?=
 =?utf-8?B?Uk9adDNYOUdUVnFxRWhWdVFnQ3ozcGhNOFpxZzlDRitEcERzR0o1Y3hYdzM1?=
 =?utf-8?B?ZXVmUE9jNEk4RGNoY2d6RllWUzNPQTRMU2orQ1VBMm1JQUh1N0FqRVlPNE9h?=
 =?utf-8?B?ckVQWTBYT1Q1ZzJleUVKQWVGWFdMU3YwMWE5Q0xxeVFKamtiNlpXRGpQMlBj?=
 =?utf-8?B?RS9Ydndpc2J6U0gwanB0Y2xoc1VqZVFNSmFmeEZsaWdjM05icXpJYzlPaDVO?=
 =?utf-8?B?VVJMZE9pMEUxWDdBZ1Q0SlNHSTByTGJNMVY3S0VBSys2YXh0QkR3WVR2Zi95?=
 =?utf-8?B?WnlCYm5BeHd2S21uelcydHJia0RMS0IxZXZiaDRVTXlYYXIyR3lTQUlMOGJD?=
 =?utf-8?B?d2xKNFVnZ0svOWp6UDFXUUpXSVFGTXVxWVhnWXFTZ3hWY0d0VXh3aEdJMi9C?=
 =?utf-8?B?VWF3Qit3aHVUc3R6M0RtbmdRQzRURkRjSDJLZE1XU2dsRjlaY01jTmlueEFh?=
 =?utf-8?B?eXlZdVEzNkx2ZnNHQk93cnplL2hHN1gydXdzRTdsaVZmTFdrZ3FpMlRCMnFr?=
 =?utf-8?B?SUFINTVLVmpSSnRreVcxZzg1V3JLUFZ3NURSTitwWE1nMXVuMlVKSURwdVEx?=
 =?utf-8?B?SDczLzBmbnpxWWk0a21NdHZmZFVTQ1JTMk4wQWM3dW5TNjhWbUMwRldjWjM1?=
 =?utf-8?B?TkNCaDY3Sklaa0lCNEV0ZVBlM0RDSk84M3FJeVphZjRyN0xGU1JOOFlXeHdI?=
 =?utf-8?B?S3NhSEVBTHNnaFVRMXlHQm1YSytCcHVDT1VLTXR0RXh6TjJPRmxnN0NHemI5?=
 =?utf-8?B?SWY5U3FZWUx6bzM5KzdDZllnaXRucDFibnJNSlZCY1VhclFpajBsdGhCM24z?=
 =?utf-8?B?eXdacVczT1hhMXphMzRJbVFSNkhURGxpSzFoT2Q4Q1NBSGVFRlB3b0dPUi9p?=
 =?utf-8?B?aEo4NVh2V1k3R0lPOGNiUm5UTUR5cnBhWGFPL2h3MkZMMFlCZmR6dWRtVlkx?=
 =?utf-8?B?THMwWWNRWWZhTW1KdHN6WGZSZTNSV3RibGx6WUdkMi8vMDR1RG03dzJub3Iw?=
 =?utf-8?B?RjNicHJucjhkTjdhMUV1a2U5aWFQZmwrdlNqNVI0T25mQXBXTkFQblBvVDh4?=
 =?utf-8?B?VjRoMzlBcThyem1RajNzK3hYUm81NDdDREdPampXcXA1eThORkVFVFRGeEJL?=
 =?utf-8?B?WTVYV2ZQK24xTXpqbzQ2ajRldU56Vi8rZ1I4Zk94MGRMZHplWE1oQnlVVWJI?=
 =?utf-8?B?eHhsZzFGWDRmSVA3NGdVT3VWMkQ2YTNOS0ltR2k2WkJWcHFOTFFmUXE1YUhu?=
 =?utf-8?B?VU9aSGdTbW05MnVzY1pYazArTllDMmRwa1lJQVlMSmhwdlBXNExaNmhYSktH?=
 =?utf-8?B?RlkvMGN3SGZ5em5JaDNFQ21TQXNWcUc1WmhmOFRrOFVlODZVeEU2Z1UrUndP?=
 =?utf-8?B?RE90aERadWU3Y3FJSU03OGhwSVJRUkttV3dmdUoyMmljMGZsUDF3VytTSklN?=
 =?utf-8?B?RzNRSkM2WFlYcUx5VzVRU0hRc0xPRWF0MWZmbjhPaDMwN0tkS0tkUXc5ekNB?=
 =?utf-8?B?Q2k2aVlEaHFXREhsYUJ6VlBic0tYbzFVdVlQcHlvcXEzK3NlZWNlbUhwRkR3?=
 =?utf-8?B?b0pDTEVoWXZQWXFiQXpTU3dPSkNrYTlQYUw1MVhkRDQ3czh3cXBmNkZEbzJj?=
 =?utf-8?B?Y2NBbE53U2xZWUd0MUw5RTdQSEJVWjFCR1E4cklMZTFsdHNjNTZ4WEd1ZVFC?=
 =?utf-8?B?M1kvbEIzc1M3cFdETG9hcWFFd3pTZ1NEalZkK3oya09TQVNLNW5BbE9ReHNk?=
 =?utf-8?B?VlNNT3E0Z0t0eVRzL01ET29pVUZrdVVYMVpLZUJKWDRYWGlGVFpicHJDejN4?=
 =?utf-8?Q?YBVBAC762nUiJu9NGBuB09rAYgRbZZP6uxEBt9fydmbp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C156A0F8239C9F4EAEE913254988CE53@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c77a8c9a-e01c-47f0-ecf7-08de27c4e189
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 23:39:28.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lq1s2naz7JakyO1dtJIvdU6aLzzr7BVz67q7draZyVucHnWV/2+Vwn4ewOCodYYETuCSjKVres7+VqH+ZfFbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

T24gMTEvMTkvMjUgMTE6NTQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+DQo+IFRlc3RzIHZhcmlvdXMgZGlyZWN0IElPIG1lbW9y
eSBhbmQgbGVuZ3RoIGFsaWdubWVudHMgYWdhaW5zdCB0aGUNCj4gZGV2aWNlJ3MgcXVldWUgbGlt
aXRzIHJlcG9ydGVkIGZyb20gc3lzZnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNClsgLi4uIF0NCg0KPiArc3RhdGljIHZvaWQg
dGVzdF9wYWdlX2FsaWduZWRfdmVjdG9ycygpDQo+ICt7DQo+ICsJY29uc3QgaW50IHZlY3MgPSA0
Ow0KPiArDQo+ICsJaW50IGksIHJldCwgb2Zmc2V0Ow0KPiArCXN0cnVjdCBpb3ZlYyBpb3ZbdmVj
c107DQo+ICsNCg0KZXZlcnkgY29uc3QgaW50IHZlY3MgaGFzIHVubmVjZXNzYXJ5IG5ldyBsaW5l
IGxpa2UgYWJvdmUgYWxsIG92ZXINCnRoaXMgY29kZS4NCg0Kb3RoZXJ3aXNlLCBMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K
