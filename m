Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B226D4CD;
	Tue, 11 Nov 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876884; cv=fail; b=h+IHernxiMu2ixJHk1RrZMp+wGaQ7yoshgQqXXSWnV7qhSfYo6DJDgRHBbg6OfN1hIiTU94oCa5iKijE/d1hZf7Sh31FPr25rwA8vbn8cBz78c4PAtXNRhsEbQ04riApqVlOQ8aeNa51l82YTvgRZ3ZqOGj5kacPSbH7WILh4jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876884; c=relaxed/simple;
	bh=tfm8nz049DHXXWY7YlMWuynSur01T/lNgtin68Yg9OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7PfaFz2x9HmCRxnBoD/djXw18xPoHocsHeTjGBbyQzV7y5VDAqeKzGgqNzpeteJL6ZFAk46jAiZRzmTarR70sJZfeZCSzFwN0ltqsL0I62yMPhndhnvoMmN7DV4e1s/4LlmqB1Rw0zduhqJH6gZQFim8aBbsrJGlr4ivPtzlS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mh0WtzRM; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mh0WtzRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzPu9Wrkq+RZihQJ8/cBWFRLNrPpoGLqb/ZfqBhV17cyIsTxZz/oAvqWTTuvaXejjUe1FuIjAe+TED0GHeUTS2EDuNCXhGhBGDmA+GiDk0AbrB7Fnm0UxXmh/sDtBHWCxkYmC2lXqq4/JmLuz6WnM5tf8I46o0+G5nmUfaQU4brR3Dcaop31Bza5MjKuOv5TwBYzwqsNqoWHmOabcnZSJIXrBDMbJQMiaL+V4S2StmQecdr+SzyUE198g5HTvqzTTa9rhSOR03eG22aucVM9+QwkLVtPkdlvqJPTyXEu4n7bsqhRGFtIrL7jGC7YMW0ruD7ZPha/D99ZQeKvKXjGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfm8nz049DHXXWY7YlMWuynSur01T/lNgtin68Yg9OY=;
 b=SCLYCEFED80S+gpK+sTyUTIUPK+e6gjixveZg7R00GzD68X31+YO9NnNadPRWiL6HkHjceaw3Leqhc/FgzpA85MBdytODl7qPiuvm5e2SbR/ashrx8p93lXQurDMmifGRizJKhtQBHABlP3jhqwzOIdvi8Td7qFetukYUAa/y1TmOLuPtkmgdn0+LYzP/kOIwI5uRV/KjU27v1lRgpTFOgzuINNHY/LHQU+009rbuf9/2egaF48XzDWPlr3X6IrQsRgExGBFFnZtShjkg9M5CwjQToyGt8jaZGy8WxkOw2cIOBYljN9T/Mi5UeAiy5q7mc21U2t+foH2olanMpRiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfm8nz049DHXXWY7YlMWuynSur01T/lNgtin68Yg9OY=;
 b=mh0WtzRMbM7v45bPODU8chJeSZ+94alOLrb6VwMiV8Kz+aWwrDKolaGEv7uAiNSgJtgqjFByvgBpnJ+vLbHDPpgcO9LFN393LKWtFm7n1WIEXSl/+Ks0UOUnP3+BwBoGP7l0BbTaZkJuc5cTTsWQplZy1StoSloI0X+7FEl+32cOvn+jgZwpBIh5v4lSufOcSFxDZC9eeNKkH6VZxwcFVq9Mp7gtoeVExAx8MFXRg2uYT0QzGnqlagrKBst2PjkF96vYIoQYw3rcVy9MpYw5g7Qy87O9p3u6EIppSE6VHO3Jilzwb70T3NhOr0b33PY7pC1UaD+afzDJlzTXUz3Vfw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:01:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 16:01:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity
 DMA iterator
Thread-Topic: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity
 DMA iterator
Thread-Index: AQHcUyRpCpxPOIM9f0mWZohj5MxpBw==
Date: Tue, 11 Nov 2025 16:01:17 +0000
Message-ID: <d899eb3f-bd5f-4b14-9ea1-34fd5123a9ac@nvidia.com>
References: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB7458:EE_
x-ms-office365-filtering-correlation-id: 0501a6c1-471a-4b9b-979a-08de213b8c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnI2WmNxSnVmN3VsMDMvRk5HNGRxd0xFUXJQWnhOQkVteFBuQnk1YjFwWm1t?=
 =?utf-8?B?cjRza1NrN090d2JwOEFBK1QxclVyUWNOVG9vUG4rZzBSSHozRUx1L0dQOWt2?=
 =?utf-8?B?K3RmN2RRaE5XemtwNGVhcWxLb2RQUzg4WGg2VDVUZjdaYjd3VG40N0xwNVVV?=
 =?utf-8?B?OWU4am9zMmdHenFLY0kzdEU1Q09nRkpoaFd4M1N5NzZkbXVOTDBRK080OVY0?=
 =?utf-8?B?SmZFNFZwUW5lSkZ3ZkVCc3Z2aWhFK0ZpRkdNUll1Wm9PM2crZG9ZSTE5aGlS?=
 =?utf-8?B?bk5FTGxJZ3lWeGVGaFR4YStheW01RloxVTVKQVVtcVBOc3FXVWRZNWJ1V1Fq?=
 =?utf-8?B?S2lNZDRVV2VKb21IMVllZDdHeGN2eE94d3NqcWt0QmIrV2hMSS9QRnNGYlpJ?=
 =?utf-8?B?N1d3OS9iU01SYVA5TjlCRWNQeWptVi9LU2F2bnNmaUMvVkdseGUxdmQ1TTlk?=
 =?utf-8?B?ZW01UU8rSlBBK3NycU9ZMW8za2xmWEh5V1hqeFg0b2o5OUpMc3pmZXR0MEYv?=
 =?utf-8?B?eFN6eWRKZ2ZmRjZUaEl5Z3dGTTdqWS9yZGxreTl6dndBcU5WOTRPQUtNZ2VG?=
 =?utf-8?B?S0Izc1VHOXErNTNnT3FEVGFMSDM4RlluV3FCc3EyZVA3RDRUVnpjWFF5Ulhp?=
 =?utf-8?B?aDBYOFFqOXRYTFhTNUJIbDRHNlNUbHVzNHdJa3hRNHE3cUtTT2pXd2RxaFMv?=
 =?utf-8?B?NTBKcDhsZTBZbVpKbE92ZmQ4bVQrYUtNejJSTUlsUVRMYXEvM084RzhaQm5M?=
 =?utf-8?B?dXpuSDIrcm05MDlGc0l0ZkhhblE3TzNNZkxmaFgrdkhCVFR2dUJlckdyL1JE?=
 =?utf-8?B?RFBueTgzdWFaaExYU1doc2s5YUQyZitEaGlmcDR3NW1oa21rNHFYZ24xUWxD?=
 =?utf-8?B?eVB5ZTFqaHBqeEt3aGdUWk1Ea3BUY3pRT3hlajVRTEMyT0tzNS9PM2VzZ0JP?=
 =?utf-8?B?d2JjdGtRYVplQWV0bG5zUGYyWHBGNi9VK0c2Q2JKYUxyaTU1TjJjdCt5YjNz?=
 =?utf-8?B?dkZydnVhR3h1eEZkeEZFVlM0bTd4elFPMGt3NktZNk5GdTNKOWdlVzl3TFBp?=
 =?utf-8?B?NWJ4Ums1YVR1d0U1VGFYcVdMOWF0ak9NSDB2WU1BTDZiRWUrOTBlMnY5eVB1?=
 =?utf-8?B?c2M5L0xSUHdsZW1KTVh4T1ZrSnBENnNkSkJyNXRNQnVOR2dZbWNMbFR3S0lM?=
 =?utf-8?B?MFpyTlZyUm54RFNSemlvM2dIdkxXZXNWMkVmSnpmdVdaanozckwrSWx3SHIy?=
 =?utf-8?B?MmFYQUVFTStkY0EvK282MXI1eHJseVFndDVkKzFUNXUzalhBbXlYc3QyRlNZ?=
 =?utf-8?B?Z0JnMURsL3Y4bTlXVmJmRVc1MytJMmlndExuRjg3RjFGaW5sQzU1d3dSMXVE?=
 =?utf-8?B?UEdxSzJzeXhNRENxR2dPT0E4cmVWT1hweGxWa1d3ZGUvVkJNenk2T1QwYmc2?=
 =?utf-8?B?Z0dDNHRoS0s3N3RBM2RPV2lzNDFMTnpFbzEyQWVBWnNOOWdEQk9BeENCSng0?=
 =?utf-8?B?VTgzblQzT1lFa0hTWTU2VG5NRzIzc0ttWUhFdmpCb1Y4MTQ3UXAwRFpsUzQ2?=
 =?utf-8?B?cXFBdVVqa0FNaXhtc2NJQURmK3dZRDBvT3RrTVZWcjNuL05FdzdJc1dJb3hW?=
 =?utf-8?B?QUpGNTA4bzh2WithdUhxYk5sT3UrajdzQXdnYmdGM0tDYkdLUHp5QVBWT2N2?=
 =?utf-8?B?UFZpbEdBdzI0UXowRnJZb3dFVnRzQTg4NHU3bGcyajNRU3FqNFFwRDlYaUtB?=
 =?utf-8?B?S3Eyd0VjcDZHbFlmNmRZL1JMQlZjMlpqR0duYzRoSGVLbjlBSUs2Nis4OUZy?=
 =?utf-8?B?VUVzQldncHpsbEV0dmFsMmw1SkRxQmpQM0w2dUJTSlQzaTI2Z3JQZnJ0SUNp?=
 =?utf-8?B?SnBTeFo0M0ptUTRYT3ozM3hGWHorZ1c4TzhYSXhVdS9CUmU2VHBCNWJiWHlT?=
 =?utf-8?B?djIzT1lZME83VlVGOGJTeW5POTFkeTFkMTJuRFNLRzN0UFVEZ2lTaVd4b0hX?=
 =?utf-8?B?K1ZLdjhqVjJBSERpSlhSdEZ0cm5wY2ZkN3QrbnpERmxnanlYOS9MZkNsbjNy?=
 =?utf-8?Q?dRzdmu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnpSVHMzV0M1cmJtUVMwSDB4T2pMSGNMT0Y5L3RyeWlsanZzQzJScVlKMkRN?=
 =?utf-8?B?L0VuQ3FncUQybzBHWFNyZjc0UmpoaENlbTROQTRscnFXN00xVnVJeUZRVjds?=
 =?utf-8?B?RVZOZUs5dzFaVVdYU0U0OG9DS0VNejNOT1FONndrUXo1VU1rZzJOOW1pNkxU?=
 =?utf-8?B?UFByUjRSMTA3VTIzQWZhWmxIZzlnMUhYbmdxejNjMllYWXA5azM5V0JYRjJm?=
 =?utf-8?B?dlVDd1h5dWNLa09UTnY1VVNZL3VoaVJpSk1abTExQ2xpZFdJblBnenYzT29I?=
 =?utf-8?B?bHZkdGIxUmxwaW0zL2p2MDhWajZNejBXMjhYSnJrS2w4UUcrYUJBeExOZEJH?=
 =?utf-8?B?VG9henp6WEdIdGRmQVBKcHBBUHYyeFVjSStyTE9MTHRFNXlTamR4Uk9JSGIx?=
 =?utf-8?B?YkE3ZjdBaXhqajMwdTVtbGRBWmtFV1pmN1A3dFZ1c3dSeDdHdGpPanQ4eGhY?=
 =?utf-8?B?c2FINERlYzg4Lzg3T3ZETENybUdCZ2x5OHFwR3E4ZlpqRXRWdkdVcjBSRWpi?=
 =?utf-8?B?dldPT2RndFlJZEZiZ0ZOS1BKYUZxbEYyTnY5ZE8zQjZnVHdOUWJQTkIzdnF2?=
 =?utf-8?B?VzhHN1lBMDZZVytrN3ZBQUsvZ1pnMUlVRHVoaG5pMFRmd0pvVmtDQTVDSC9W?=
 =?utf-8?B?OTZUa3NkMU5ReE5BUkpQRi8yOFN6bkVYNDI5eFFhUmdBeXREa0JneGlqT2Q4?=
 =?utf-8?B?TFRCcE5nU2hNd2dEenpETWd3U2tFOWhZbTFzbnhsemxXck1HY3REMUZucWd2?=
 =?utf-8?B?QVZkOEhEbXUwZ0dLOFlmcUNZZTRYUzlZYTNNVmJVRXo5bGc3N29oTG4vdFY0?=
 =?utf-8?B?STJhZ0MyL0pGcGdlVUdjYzl1YXlGZkxyb21rNGpmNjZDWFFaUS9ubitrdFM0?=
 =?utf-8?B?MkFYVmFhc3l5VThYRVNkVXh5d3JoTXN2N2NTZVQ5VlVLU0hweExKb0VXRStC?=
 =?utf-8?B?ZGMrKzJxWkZKeU9UK3N2ZG5WRHBkT3lGSWdoNzJxQUlCM2RKUVV4MUFidEF5?=
 =?utf-8?B?RzdCeWJhZnAvRGZxTUw2c0NPZERPOVovd25VTU53UG40N1laM2g0aG9INUJE?=
 =?utf-8?B?Zk8wRThJdmpJcTU3Ukg4K1VPVWxHK2FaYnBpSVhpSDdRUDJ1SlFZREZOcURC?=
 =?utf-8?B?MFBQS3lNdWpBOE1PaFZpQUpvbzFmUHBCVldPa00wUGUyVW51dS9Cb3N6NCt2?=
 =?utf-8?B?bTBaNlhDMW5IOFZYSzNlVWRvVUtVc1lqb1lIbkpLSzZDS0VPL3B3WVZJWFBo?=
 =?utf-8?B?Sk9HUzVodC9ObmhsVGFHclVZcjhZbnNyOG1kVjFMTzJYeUgzckdhV3dZN2gw?=
 =?utf-8?B?elppTUtZb0w5V2UwTWMraHhWU3hpTWtoTDJteXB5cjdxWDROa1dpU3dLSnpj?=
 =?utf-8?B?RWdDRVVBZjVNUWxsakx2OTdzY05nNUphVzV4YnJkZ0RaU2NTQWd3djJGS2h6?=
 =?utf-8?B?c1AydDRkRTdJSUk3MGlRQTk1T3FPLy9Pb0xLZnJIaDB0MmM1aE5nQnRWODBR?=
 =?utf-8?B?RmNCVndGbkllS2NySFFSekhvZGZxeXRwbWRtaTFHVVM3L2RQdC9aWkVPN0pK?=
 =?utf-8?B?ZWpuekFyUjhSdkY5Y2wrNUo2Q3Bhb2hicGV2elkzbERmZ1hZdEdpRDJ2dVBj?=
 =?utf-8?B?RGRTMUlmSVI1MWlIN0JUZTUvZVU2NlJBTlZkK3YrR2NWMEJ4ZXJ1UFJQdmRD?=
 =?utf-8?B?Mmx2OTR0OUtnV2ZpZ2VmaGdCUDIvS2xPVzdCQzEwamZ0d1UwRjJvblJtTWJa?=
 =?utf-8?B?SzhjNVNRWVVnb2w1ZFpQSU1XKzlrVHg2QkN2b3E3K2VYcTlTa0llSU1WbUc5?=
 =?utf-8?B?UnV6UzhyQzBPYkt6SExtL3Q3MHhzNmhzaHJvdTcwL3g0djhMTHhUMUY5RXlH?=
 =?utf-8?B?L1lsV09pTldpTXU3SHlxYnVLWWQ3UTFNT0JMMDNETEl6R2ZrcFBrRm5uUzBN?=
 =?utf-8?B?cnVwdUR1UUd6ck1PV0pDRE5zd0JTd2xOOGtaS1FmYkhDUTlJc05Dd2NhaUNx?=
 =?utf-8?B?TUlZQWZZNytoRjhwd3dJemhPZWVXQ2VHbkptYnBSVVVJb3NTdWpwWk5uY1Y2?=
 =?utf-8?B?Nm9RVTI3cGtNdERGN25mSGJJYUxHZzBoR0dVWUhsb2xhNHlZWnRiQ1lGb3Nr?=
 =?utf-8?B?Mi9aeld0eDNLa3JaQ3d2Y2xOQVV3ck1BNmJ2bjBwYjJWOWVqd0lCV08zOE9N?=
 =?utf-8?Q?/wsVh62B0WE4KTa9aG1lvxBSFYve3ht2neFFeLytYMPd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <352A5CDF7A584C4C9222380347B3435B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0501a6c1-471a-4b9b-979a-08de213b8c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 16:01:17.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6nke09EV4uIm51+nK7YkCgZopZZfA79aTx7oSPIzjvl/5CKuz+e3zjO1VP+wNJDuMmaiUtza23AKWiHpmIZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

T24gMTEvMTEvMjUgMDM6NTgsIEtyaWlzaCBTaGFybWEgd3JvdGU6DQo+IERvY3VtZW50YXRpb24g
YnVpbGQgcmVwb3J0ZWQ6DQo+DQo+ICAgIFdhcm5pbmc6IGJsb2NrL2Jsay1tcS1kbWEuYzozNzMg
ZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYmxrX3JxX2ludGVncml0eV9kbWFfbWFwX2l0ZXJfc3Rh
cnQoKS4gUHJvdG90eXBlIHdhcyBmb3IgYmxrX3JxX2ludGVncml0eV9kbWFfbWFwX2l0ZXJfbmV4
dCgpIGluc3RlYWQNCj4NCj4gVGhlIGtlcm5lbC1kb2MgY29tbWVudCBhYm92ZSBgYmxrX3JxX2lu
dGVncml0eV9kbWFfbWFwX2l0ZXJfbmV4dCgpYCB1c2VkDQo+IHRoZSB3cm9uZyBmdW5jdGlvbiBu
YW1lIChgYmxrX3JxX2ludGVncml0eV9kbWFfbWFwX2l0ZXJfc3RhcnRgKSBpbiBpdHMNCj4gaGVh
ZGVyLiBUaGlzIHBhdGNoIGNvcnJlY3RzIHRoZSBmdW5jdGlvbiBuYW1lIGluIHRoZSBrZXJuZWwt
ZG9jIGJsb2NrIHRvDQo+IG1hdGNoIHRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24sIGVuc3VyaW5n
IGNsZWFuIGRvY3VtZW50YXRpb24gYnVpbGRzLg0KPg0KPiBGaXhlczogZmVjOWIxNmRjNTU1ICgi
YmxrLW1xLWRtYTogYWRkIHNjYXR0ZXItbGVzcyBpbnRlZ3JpdHkgZGF0YSBETUEgbWFwcGluZyIp
DQo+IFNpZ25lZC1vZmYtYnk6IEtyaWlzaCBTaGFybWE8a3JpaXNoLnNoYXJtYTIwMDZAZ21haWwu
Y29tPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
