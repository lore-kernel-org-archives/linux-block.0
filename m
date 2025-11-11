Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952C2E0417
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887879; cv=fail; b=f880icCmFZxzFPz9OqjOpJG77hj+DBVh5cun7KY7NOZzBmf88Ac5ZC/Gl/8six8KMY2INsQkoreUOhtXmcTdC+8E/S7HeKni9gWK2mz1lAnCh7Is/rrVDBUbwSiex+VIHGT50ZgpFwhj1TI+Y9GtjKyIqXNZ6qucb/BU2ljpPM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887879; c=relaxed/simple;
	bh=nV7TInbjtFHQelLNFpM97mX2VveSlemGNZnQ4yih1tQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUurTIDy/ToyvfroF4Kb8aOOHInSFJ4DKMkA0/6vS8VgAnXB94fI7WXhkhFzivk4XeftHc1BErIfpRquLzzc63NYLhjCSwyGVdl2PPsCpf8CzJDMBPp6bVRw5nIG0gE4jc2RuSJgBgUqaflTXWHeCsqTCP5flhp8lX6ha1IWPYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7bvpS1L; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7bvpS1L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9sqPZaA7krVLZwLhraiH5uboZ5aZCcPVVEyb4qI83htqqCgYz8ZXam6nNRx4dgw4e6yFJy69KQUxQv3JrEn/Yty4r8kfF9UMUKQ5coq6mYN1L0UD2cD7GXKiQvTUbOvzA8GHbjTeElE9vGru33PD26EwFcJFVWpqJjI/UOJt0XKFfBdRZw//cY8tITVzErYVyWT/9mXYML0dCAf/zyMXqXL9aDjHcHvPSbUpx3IWRE1Svq89RWGR5aV1MBJEIufqsbLI9DV4XDxG35pi9/FrSiSdXfArgEmHS2/FEOaYiXQi7qsllIt8Qws17f39XB8SL/G2C9AHz4h8YVJa/yY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV7TInbjtFHQelLNFpM97mX2VveSlemGNZnQ4yih1tQ=;
 b=iRKInTVOAEzvJTom3FRb+ojd/xQ++DFp2PwsYLzEq7e3pTVlDGGhWgnQDbGH8wkFkFbE840xBHLI28M3RmQVwZtYB1Z2UpXTrBdwaZ2UlaoB5qGMfA+BK9dPycb1ayNctsHT7ACHkyPdcZ/OOFZu/2omaXadxLP33io3Z0R47cQOd1ZdbNJxDgQhVkI2B5zj5xC97eiWWKco2ViA+qZB0N3IHHvciYB0VP/TPfGFyaaLbcM7XrtQG0IaHLtBtqpppEM2al0L6G4KYQYDisYCMdiHO9s6GW4YIlszs8VjvLfgvh0jA2VhrKmdPdxnvgZSIUjNl6wfM2yRQyRNFuo1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV7TInbjtFHQelLNFpM97mX2VveSlemGNZnQ4yih1tQ=;
 b=C7bvpS1LSmjLAKW5C9/GJUmT7bGhZnYGGdD9iMIAEZFEtfTyQZz+UMLNqGImCAQrc0s7r8vXlkftaKJs46Uf9EctUakwgDLnuELvnreqGkLS9RcCXZnQfV6DAazf+UOgW10Bu/aAou6ALnOLfEBJpKWWzf3FYztlfuTLxVYFgoTxmdspwVLgAm5RqClmljCKIcaorY9vzYheZLFl5zUSfBdGO120hGzY20HdJEGBpy6htjpZr2roYlPSCS7RvOG5lkJ8HI9kHz2vQzUGTr/KbGkg5So+vOuc1Gcd7cLu7ycqVnxJMxYNiSljBhmNJ+ekXHOfQkICSBMg0N5S+gxrow==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 19:04:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 19:04:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH] blk-mq: add blk_rq_nr_bvec() helper
Thread-Topic: [PATCH] blk-mq: add blk_rq_nr_bvec() helper
Thread-Index: AQHcUzd8kPewO3gfWUW3XSWNUY0WM7Tt1ZkA
Date: Tue, 11 Nov 2025 19:04:35 +0000
Message-ID: <2871129b-3b90-40f5-b9a4-8a3bbb8b2ca7@nvidia.com>
References: <20251111181736.54852-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251111181736.54852-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9252:EE_
x-ms-office365-filtering-correlation-id: e914b9c8-d546-407f-a0bd-08de2155276f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUZJWjM4T3AzUVBrOHVYeTgvL2M0U016RXhicWtRbGtMdzhnaFRrL2s2b1Ay?=
 =?utf-8?B?eEdpRjZPb0tEcGR5b1dUY0xSQlJyRlJSc2NIeVJoNG15cFdNZDNUQS9WM1VB?=
 =?utf-8?B?cW16dzZnejVtL0QzSGhmcVhNd2tSTXhxSHB0M01STVNIaWdyU3luMkFnWExN?=
 =?utf-8?B?UmYwWi9McDBrUHlZQ3laZE1tQXdPQkdTM1dLaHNIV3N4bjZxenJxa01remhE?=
 =?utf-8?B?MTBFaXA4MkErNERKbWxrRGR1amk4T0NRM2NlUkp0UkV5WjJ5UXBWWGNSanA1?=
 =?utf-8?B?dm0rUjdkZ1JXLyt5dWdHMGQxVFl0bjBmemY3bUppNDBZS0FPdFpSV3F6TFky?=
 =?utf-8?B?c2xPVVJuRGVlUVVSWDNzUktTTmVpYzRJZUZUb2N2TFR3RENzcU5Sd25XeEY4?=
 =?utf-8?B?NGZidjVSUmJHOVhFWmhLK05WVHRpa05sY0tJWWt2NE5qV0EvRUZBV2R3MjY3?=
 =?utf-8?B?V2lyY0JRVlVKRngzd2UvZE9WNGk4ZG1HUW92bjlHL0Vua201Y2xNQk5hNHFa?=
 =?utf-8?B?RjdHWTJlRjZNUDRvMDVTamFnY29QUFlvZGorMFlBblk0L29US2F3Z1RJZzl2?=
 =?utf-8?B?SlhWQWIzVHhsV1FJcnAzaVliNmk0aldrSzdtRk54MVYwL1dXNlg5b0xSczZ6?=
 =?utf-8?B?N3NmV0ZlYkVLRlZVNEN1VitzOVd2L2V5ZW1GM1Q3emU4Q1V1NVovK0I0bnJj?=
 =?utf-8?B?aURpUW1aWm1nd2J5REw5cWNvaXZSSzhSdlNVdG1NMVg0c3NESFhYdVNyenJw?=
 =?utf-8?B?aVpWZTVHaWQvR0Q5ZkFQRjhjSDJxUHgxcGlxdk1OZml0WG1RZkVpdGErczJ4?=
 =?utf-8?B?YjdUWmIvMm5Gcm1DMyttR0hyUG9walFYaVo0UmozUGgzQXRaS2ZMUDgzZ1pX?=
 =?utf-8?B?V01xZ2JTamVjM04xRU5WWmJQSTh4YzdzMUxoSjRWeEhlREgzRm5OL01ORTVz?=
 =?utf-8?B?SDJOcTByd3lHMGN5RkNTNEVmUHgrWnJzODBMYmo3bm5YSVpFQmx0Ynlicitk?=
 =?utf-8?B?VXlKUkdoeVY2NkRuMnpZWXlSa1UvdzZSRWNXM1plaElFMng0c0lKM0JCaVky?=
 =?utf-8?B?TGVDV1RPWFhFekhRRTNIRWVrMWw5bkZHV1RqU3N4SWUyZ3cyb2hFd2dNWXIw?=
 =?utf-8?B?OGdJbWJ5eUtuY0xSV0N6eEtkbTZZMk95SGltMzh3d2JQVERpUHp4VzFZTXN4?=
 =?utf-8?B?eG5CazAwSzUza2hkUFhOakhrcUtRbExMVXoxT1did01LcXhlbmVoL0J3elZK?=
 =?utf-8?B?bEEzSXlKSkxYd2pZaVp0VmVOOFVFaXVHUkJYb3JtV1lzOEcwMU1XcGtzTjha?=
 =?utf-8?B?U0dsR1MxMWFMSzVPNlFFYkVjK2gxdUQ3OVJXdlFaVVBXTi9iNlByZHBjcjVn?=
 =?utf-8?B?b2U3RjNwUEVsemlacmFpRUQ4VjQ3NGFRc3k4UHd0YkxsbkYrenRENmFkTFVN?=
 =?utf-8?B?eG1keEpqMzBFdWNwSGU0Z05zQmNPUjI2dDRuTkRaYUk5U0pqcTB4RlYrRXJs?=
 =?utf-8?B?YkRJK2xITWlSMG0yMG4wNnhPc2lHNU9LUjV2Z0VzTjIycXl3TXoxSXk1Nzh1?=
 =?utf-8?B?anl2MnNPaXY5dGNqKzJmMFg5RTFOTnQ5eVlaYVQwSTNTT0VMcVA2aHRHZXYy?=
 =?utf-8?B?SEZCUVFaOGNETHFkNCtIVDVLN05aUEM4Z3RDejZZS1h0VDR1VFU2eXNoQXFQ?=
 =?utf-8?B?S1JOUGg4NlhsU2YyMjRXK1l0c3lpZjNXaDYwWDljdWRyMTU4VWg5ZXZKS0RI?=
 =?utf-8?B?b1dWcW9oYklCTWFKVmdSVWI5WCs0WFF4YzAvSC9UNm15UWRnYVJDOElHWnVv?=
 =?utf-8?B?a1JDYkVWU1hpRXJmM0xxYXhyV0pGTGhoV09sSXpHUDlsb3FEL3o5b20rOFV1?=
 =?utf-8?B?UGxwc3J6WTgrd3IyRXA2aFBybjlHbkxDK1ZoRGhiQlRlUWhvd1BBM2h2OGpE?=
 =?utf-8?B?d2NsMFVieWlxakVGU1RnSTE5a1pZNlYzMmlLTncwbUg4Nml0Kyt5UENXa1JO?=
 =?utf-8?B?bXowaEIxSmdVNXJwbm5MNStnSFVRSjJ1dW1TZ1RKeVkzN0Z1Z056LzI2Lysv?=
 =?utf-8?Q?/TKuW7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2wrNGlNOHJ3UlBOeHprWTIyTFVnWFVQUW95Y3daVnc2T1hnSXRtb3J4cFpX?=
 =?utf-8?B?S3RGZFNxOXhIWnliOTdWaEZpYnMvMmdqeHJkMzU4WGQzSU5JZFRSNlVRbzUx?=
 =?utf-8?B?WGVjMFV6ZnNEbkxib3ZsTFN0L0Y4NGhSR296RHdiaEJqclA1Nm9Db2w5V1Nm?=
 =?utf-8?B?Z2FwZGEvMTJ1VjZVWFAyaDFSKzFIbHRFK2ZQWmNERk1ucUFWK3VZY2NUYnJF?=
 =?utf-8?B?MVBZTzRlandoK1N4TXdHc29TUEQvUmtYMHREWk1IZDJrSExMbmJsdTFUckZa?=
 =?utf-8?B?OTBrTGxweWMvby9KY2FacjdVUlpQdHNTVmhUcjRjOXNBMENOVEhhVDdSN3ZE?=
 =?utf-8?B?anQ3VFNkK0FkS1htRlVuSHlyL3oxcW9pNStsRFB2Y05xaC9aMzBuUjRPeE9h?=
 =?utf-8?B?K29mU1paYVhoSkI1bUtWZ2dJUmx6YUdwbEQyeGcyZC9xZ04rcHkyTGlsMjNx?=
 =?utf-8?B?cDZyMnlQbHFndXZSSVhwZWRoTzN6L0Y0R01zTEh6NWRwaGM4Y0R5ZXRxRWRv?=
 =?utf-8?B?UEZwNzlrZThZT2VadDNSOEdIa2pUQXE0RWQyN2d4TFYzMmNxMk1LQ3FyUEtO?=
 =?utf-8?B?MHBXS3JTRXA1RDVvOG93MDdXKzlCSWRvSjJXdWRLVzZzNnRLZVY3eTNhT2VJ?=
 =?utf-8?B?UFRKa0t6VDlKVnI4UlNxQ1duTzk5OFlVTHI4T0s4bkk4Y0lCaEtOKzFiRndr?=
 =?utf-8?B?dkpVZ2dZWGVLMnZPN0h0dWwxNEIrR2ErazNBU0ZCNjZXeHppSG4xbWR2bVVZ?=
 =?utf-8?B?MTB1aDZoTmRDWUZkSXVvU0MxT215VlpyRWxRM3Y3clNOZ3pGUTdRZUVlR25V?=
 =?utf-8?B?STdQUHorZWR0SG5peXpyaXZtdEFlUFFjbWcvUFN3SGlvYXZqZEdjeHN4eWpP?=
 =?utf-8?B?bUhuUTdvZGZmbDAxbFlLWmh5a0FqUmYvSEJFL2FNdDdybm9KaHNsUTk4aVUw?=
 =?utf-8?B?ZHBLaXp1d3VmcTFuT2k4aXJPWVAwSjBORWtIK0h0bDk1R2V0Vis2TFFwd3lz?=
 =?utf-8?B?UkxxbSswdlhKWWNsYTBWUGYyNkNYdkNVdWxzSk1GaDFWVVRUbThLMzMzVzRE?=
 =?utf-8?B?R0U4VFhYc0wyazZxV2hpZktNeTRFUVJiY21reFd6Y1QwWkxFMnJjRFdmQlJZ?=
 =?utf-8?B?aVFlaHdIMDJLalBNWmNWYTIxSGNCb2M2K2Z2UHNmUGxBendRTm4ySDNCeFZG?=
 =?utf-8?B?SWYvUkJZa0FXbFJ3N29RNjJJN0pTeHdhbGdabElPVmpTSkdtTVlTT1BNMUxh?=
 =?utf-8?B?VWN2KzV5RUZlK242Z0tLUTN6YWgwd2hkMEo3OVJUNjhKWUxFS1RLTmh0RHln?=
 =?utf-8?B?d0NQTWtRZ2h3aUFLSXZtNi81WFRKTjg0dEFRRlVUczlDVnNlTzEyQ3EzaVNC?=
 =?utf-8?B?RlhkUUtGc2dQYnlydGRCQ1E0RVF3dE5NV2F4NDhhNS9JYThibGxHZ3FrYkQ5?=
 =?utf-8?B?KzBLQ0NmM09sM3gzb3V0eVlYVGNBYVJhWFN6YVNTYXNLMVpWakJjeUVXZ2d4?=
 =?utf-8?B?MDFaN0NBa1E0RElFOXU0YVlHU3NERktwOHJiODBzblRhZ1BnUHpMdEgxRUxs?=
 =?utf-8?B?RkFnZjEzbVc3Y3VxMTVITUMrR0QzSnFXQWU4S1k1enBuNjFFaXZFUTIwYk5P?=
 =?utf-8?B?eThiVFNSd3JEdUJaekVvOXlGaGkxVEtZcW1VTHhzSWdhTWR4cEpFdXc1YTBk?=
 =?utf-8?B?d1hhbUlYaDJ2Yko2cCtDa2YycGlwbU5melJOZndNTjNMbU82Z3VzSWxadmJE?=
 =?utf-8?B?djNQdm1yTFNBMGlFUDdCR0l3L0k4c0xaekdSZmRua3FGTy9yam91S2FWRWtt?=
 =?utf-8?B?ZjNEcVlkNHNFTUxPbWhmRlR6SERFOHB3ZkJWMEpobG50aWpvanRkL3dObFdt?=
 =?utf-8?B?bjBKVU5kak45V2tYTnhPaHZObFhhUXRWQlAxa0ZFREhiaTJ5U3lQUllQditC?=
 =?utf-8?B?RTlzZVJncEU5MkJpcjJXUkQrVzZhd3g4OW94d0tlMjFBVTN1MEtUckZ5cXR1?=
 =?utf-8?B?akIzZzZaQlIxRUxnZ2F0SEtwKzY4NWtDNkpKVGFWRWxBUVo4a2p5UWVPK1NX?=
 =?utf-8?B?MFg4SCtmWmh1YldLd2dxOHQ3eGprZjA0aFlTQVBUNnBveVlydnBYSXFrZTVq?=
 =?utf-8?B?SEhFM2E2bllBcHFXSEZDQUpsNnNaWVErdTcvMVJvemZ5VXovL1dWVGI0L0du?=
 =?utf-8?Q?3Q/maYeqqwp3oBy2SiOEVPdZvf/gf2XYiMEqwS0GNHI5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10D86D8E7C5CF241AD07208694A66494@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e914b9c8-d546-407f-a0bd-08de2155276f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 19:04:35.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTjkZsHnsW07LVoUFTFuRmB+tH1KjB6NkQGT0YWnuT4T6LCsVAwgJswqWqh2Y+kXF0yxSspftBJzyDW/9M9umQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

T24gMTEvMTEvMjUgMTA6MTcsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gQWRkIGEgbmV3
IGhlbHBlciBmdW5jdGlvbiBibGtfcnFfbnJfYnZlYygpIHRoYXQgcmV0dXJucyB0aGUgbnVtYmVy
IG9mDQo+IGJ2ZWMgc2VnbWVudHMgaW4gYSByZXF1ZXN0LiBUaGlzIGNvdW50IHJlcHJlc2VudHMg
dGhlIG51bWJlciBvZiBpdGVyYXRpb25zDQo+IHJxX2Zvcl9lYWNoX2J2ZWMoKSB3b3VsZCBwZXJm
b3JtLg0KPg0KPiBEcml2ZXJzIG5lZWQgdG8gcHJlLWFsbG9jYXRlIGJ2ZWMgYXJyYXlzIGJlZm9y
ZSBpdGVyYXRpbmcgdGhyb3VnaA0KPiBhIHJlcXVlc3QncyBidmVjcy4gQ3VycmVudGx5LCB0aGV5
IG1hbnVhbGx5IGNvdW50IHNlZ21lbnRzIHVzaW5nDQo+IHJxX2Zvcl9lYWNoX2J2ZWMoKSBpbiBh
IGxvb3AsIHdoaWNoIGlzIHJlcGV0aXRpdmUuIFRoZSBuZXcgaGVscGVyDQo+IGNlbnRyYWxpemVz
IHRoaXMgbG9naWMuDQo+DQo+IFRoaXMgcGF0dGVybiBleGlzdHMgaW4gbG9vcCBhbmQgemxvb3Ag
ZHJpdmVycywgd2hlcmUgbXVsdGktYmlvIHJlcXVlc3RzDQo+IHJlcXVpcmUgY29weWluZyBidmVj
cyBpbnRvIGEgY29udGlndW91cyBhcnJheSBiZWZvcmUgY3JlYXRpbmcNCj4gYW4gaW92X2l0ZXIg
Zm9yIGZpbGUgb3BlcmF0aW9ucy4NCj4NCj4gVXBkYXRlIGxvb3AgYW5kIHpsb29wIGRyaXZlcnMg
dG8gdXNlIHRoZSBuZXcgaGVscGVyLCBlbGltaW5hdGluZw0KPiBkdXBsaWNhdGUgY29kZS4NCj4N
Cj4gVGhpcyBwYXRjaCBhbHNvIHByb3ZpZGVzIGEgY2xlYXIgQVBJIHRvIGF2b2lkIGFueSBwb3Rl
bnRpYWwgbWlzdXNlIG9mDQo+IGJsa19ucl9waHlzX3NlZ21lbnRzKCkgZm9yIGNhbGN1bGF0aW5n
IHRoZSBidmVjcyBzaW5jZSwgb25lIGJ2ZWMgY2FuDQo+IGhhdmUgbW9yZSB0aGFuIG9uZSBzZWdt
ZW50cyA6LQ0KPg0KPiBbIDYxNTUuNjczNzQ5XSBudWxsYl9iaW86IDEyOEsgYmlvIGFzIE9ORSBi
dmVjOiBzZWN0b3I9MCwgc2l6ZT0xMzEwNzINCj4gWyA2MTU1LjY3Mzg0Nl0gbnVsbF9ibGs6ICMj
IyMgbnVsbF9oYW5kbGVfZGF0YV90cmFuc2ZlcjoxMzc1DQo+IFsgNjE1NS42NzM4NTBdIG51bGxf
YmxrOiBucl9idmVjPTEgYmxrX3JxX25yX3BoeXNfc2VnbWVudHM9Mg0KPiBbIDYxNTUuNjc0MjYz
XSBudWxsX2JsazogIyMjIyBudWxsX2hhbmRsZV9kYXRhX3RyYW5zZmVyOjEzNzUNCj4gWyA2MTU1
LjY3NDI2N10gbnVsbF9ibGs6IG5yX2J2ZWM9MSBibGtfcnFfbnJfcGh5c19zZWdtZW50cz0xDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaTxja3Vsa2FybmlsaW51eEBnbWFp
bC5jb20+DQoNCnJlLXNlbmRpbmcgVjIgd2l0aCB0eXBvcyBmaXhlZC4NCg0KLWNrDQoNCg0K
