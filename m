Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EB258ED9;
	Sat, 15 Nov 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245512; cv=fail; b=TqmbLmFjFOvzY9GznMsVXK6kToCQOIkRNNfh2IKRp6lzJwyZjMZ0lgX1k8WcqRM9D4DkNpi9qIKQMboDq0Q9PAqSHr8pU7vx1UxNT2FlkksVBh2WkpAtBIs91v85CaqMlSaDot0G3GGqdzDJh6QBwfSZLTROVe5ckY4kycy/zf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245512; c=relaxed/simple;
	bh=ufgZGUWyisuoi121HQKWlxtJt63WtZj1RhtOq0c9FBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YL0BluNiIogCP0C9CDmp2KJJ6/bNZ1A6p2eOY4Ddit1zXhEJKe6QH/6zxZ8Kn3S/hhaVUaGmNYGo8JyWRpnaCo/Z7tAyMKYEtCPIF82YSwCjfwOckInCFqT8JxCgsl9LWU2DkMPAJLRdO2VtAEzSAUylqx2epAEQqqjzn3kpGDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+sAs+0p; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+sAs+0p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjUJGGFTw+ubCI6nPPr71ZNmsl16XxnYdLVbVOCAGjfJ8CdIxhY4INMkzS/E9jED1o/qmofHRaPKLha6Py2/eTPEh95afS+2sBJ7nBQblSuHnm81bkHs5z46FTGNSruExocPaMhcCa7+NGQephVhMOKXj7NRdXHPGtPB8GNlM+eRI53OEwF7Br8o/3YSHHHq0DRXIPcmT8W3adpMonDByro6+V0vbBmN6fGfn7ELG1rBcnjy6tuT/C9NhVCVRbMbe8CDw8IlYdkBBWKmgtW5wrklXPpH+2tx5iV4ZS6kPY3Ze7XrnChvbdTCDO2XTVQ5J7oOcAHcI+0OBTKPngKdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufgZGUWyisuoi121HQKWlxtJt63WtZj1RhtOq0c9FBc=;
 b=uzVIFLCDkhcWwoVc7/0QdCm5ExhMlCdADRqoYFqd+yVWhqp8MfEEwQMyOUnRMzpoOzz6zbIE5e4iQ0bUfAqlJJgJt0GBUZGEqB2QVv1QA07OxrriXwU81aOExUiySpewg7kYgzRRhZ3YyRkEuG58zUTbGYSVxmRkwTsQ9EC1cYrk24g3Y3BakrNFeLnTXJr5esVc9+MyuO1Y91TSh/psXwzUvdUVWjtP6qTObdoBSfCLIxu5cxAl6LGzrWkePzHR0nVIeaZPuy3wPYmGt2Z1Xu0QZr82neJQplhoPAn+0mVR6k1BMWHyo1n0QCW1GJpnyr5DUTwciJXs0lwWnAr8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufgZGUWyisuoi121HQKWlxtJt63WtZj1RhtOq0c9FBc=;
 b=t+sAs+0pFSKwxU++oLJR8gDL23X9W7sdG3H12XFwYtQ4tCTAgOPxl+cseTpuiAODxYhQpu8yKc3Aj8PAocwpkRO1BlbW85KTnFJUVjVrsX9Td6QjPP6atDEKjh6c7809GkYmnfHN13eqFeatrDoCUddSKTthA/blCHid+CXutqSAkTpto7PcJX3xXNesYb4OvxMgw39MbZIMzBOaBa+iNwlPbkQS8dOWsUlrVCtRPQdZ6jhgL00ZTaBRTM/DAnmvmJ2qfH9yLx0slhZoHcsWenmH1IwICuYUxMI2ZAJH18HPBEWcI+RAmw00kIsSR7sQ5gPZWQ9eVDX4VOCsrflwLg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sat, 15 Nov
 2025 22:25:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 22:25:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] types: move phys_vec definition to common header
Thread-Topic: [PATCH 2/2] types: move phys_vec definition to common header
Thread-Index: AQHcVkwygkqCOHzt1EG4Kgz+lFTxr7T0UM0A
Date: Sat, 15 Nov 2025 22:25:08 +0000
Message-ID: <45c46766-2cf4-4e0a-8756-131872ca188b@nvidia.com>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
 <20251115-nvme-phys-types-v1-2-c0f2e5e9163d@kernel.org>
In-Reply-To: <20251115-nvme-phys-types-v1-2-c0f2e5e9163d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6242:EE_
x-ms-office365-filtering-correlation-id: 097da4c0-590e-42b1-9974-08de2495d598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTFhM2lDMlJxMmNQSzBiRjRFaG1WY1M5ZXlWSm92UTNBbTlsQjVQbUx1ZWhS?=
 =?utf-8?B?QlRMTGdrQUdlcmJObFc3OStpSUkvVDgwdTRXb3p4WTJkSFJBaXhjWmZWUTdv?=
 =?utf-8?B?T1ZhT29RdVZiZGRtdCszWmhadFUvK2FGVWVzNEEwT1VnQkRUTEUvakhEU2FZ?=
 =?utf-8?B?ZFJvaE5ScGsyVmd6ZTNqUURiRkVXMFQxOVVCME9qWU1nMmdWMHJ2WlBrbHk5?=
 =?utf-8?B?OWxOREw2Yy9UckJWNEhZdTVIQXVxTTZ5Mkh0NlpCZU1zTy8yMHRtMCtvQnhK?=
 =?utf-8?B?azVrcVFFTit5YnQ3bzlac3VlZlV3a3VqYU1ONFJ6RFBsSSttTXhON3R3V2N0?=
 =?utf-8?B?bHdEY2E5MWdTcFY5ZHFNeWhqcHVEVmxENlJRMWlRK1RVZ2F5cmh6dE5lQ2tk?=
 =?utf-8?B?MUg1U1VPQmVXY2ZvdkJlcVFOU1UwbDZnWVVTUFI4NmxRS3Q0bXNrazBKSXkz?=
 =?utf-8?B?clJyeFZIS1I1Z0thVGg1dC9HTzJ1QXU1Nk9WVmlqWG10ZEh0Z043SXdiUk9C?=
 =?utf-8?B?T1F3b3pMekJQL3RVWjdFWWRyaFM1enJhdGF6MWlTSmVkMjJmb0FudWk0WkdZ?=
 =?utf-8?B?b0d1bUtQdnJrL3FqVkR5UGQzazJWU2p1Z2E3ZUJEU2hXdDJaVmt1SlRHSmV4?=
 =?utf-8?B?VUZEVngrWjQ4YkpqMDRkWHJZNCt1S3BKUGpKWWMvVE1KekFQcmhuUUFEMS80?=
 =?utf-8?B?ay9ha3hsSXo4dEdEVzdVV0xKVDNHYWJDRVFLaHdpaWQzVjFvdy9YRW8rYXVJ?=
 =?utf-8?B?Y0RiVzlaNDQ0MTluMXkvM2ZhYmRlc1YwdVVEZ3lJV29OYU1lOUhxeUVNZXlo?=
 =?utf-8?B?bzdDcFlkTXVHeVkvOG1nUHRpLzM1QzR6YkhwOCswWGFnaWI4U0RLT3J1WkNu?=
 =?utf-8?B?bEttNDhEbFZtTmJ1YmwxaEpUcGpnWnlLMjNKTkJXUmhzKzJIcnRlL29BaEQ1?=
 =?utf-8?B?Zm05NnBKM0ZGOXRaenJEb05HakNDMWwrV0lJQU85MnJZamMxYzdHRjdLNE9a?=
 =?utf-8?B?STNHbkVzQkVVdlVPSk9CQWtZcTNKRjBoQTJEK2htT0tBV0QraUxTdE84VTVM?=
 =?utf-8?B?MnZmZTRaYW1Ub3Rta29QWW1KMmJtNWRTcm5mcytSK1VVelR1S3kwNWZ2M3hZ?=
 =?utf-8?B?TnBpMUhBVTlpVEtNc2k4N3c0SDErV3l1NU02aDVjSkxjVlNaQlQzYkRTZVlz?=
 =?utf-8?B?T2orWFZLWndpcWxFZjFjRHFoWll3cS91YTB6UFZUMDlFa0hadHgrYkVNSE5L?=
 =?utf-8?B?Mkc4S3pqRUV6Z0FCbU1HT2x4dFY1MVVEeGhOdW5KUDJ1LzRVa29sYmRnSTlt?=
 =?utf-8?B?clhvbzZyQTJJc0h4Y3JZUUFBanJOOGZMcDA3ZzROU3grNjVTaDljclZrNC9r?=
 =?utf-8?B?eG5aRTA4b3ZCSk1HVHVoaU04UzZBQU9QQjErUi9UTWNuaSswWlNiaVhZWVAr?=
 =?utf-8?B?UWhKVEZjTWZETm1kcXFwcnBpN2xLSU1GREpKT0ZqVTJpZ2tEV2tYWisweTA1?=
 =?utf-8?B?STROSDBtdFVLT3NqanlOREZVWHdYVHozZGJtOEV5Tm9JN3JFUmJWZG1TQVdR?=
 =?utf-8?B?RzlSdXc1ZDU2b2tRQ0xoc1NySkJLV1htRkRPN0dHNDRDOUVUUmJzZ2tFSlY0?=
 =?utf-8?B?Tm1SLzZOcTFLOVk0U2dIK3MyWDAwTldweldnVWQvM0lmTGlRUERtUHQyRTNr?=
 =?utf-8?B?dzBIdTU2RlJkQmV5alZ5Z1lUN3pRZGxDMEY3R01Ienpyb2FmSGtudWZNdXFT?=
 =?utf-8?B?NkFqN3RsVmhPcldNTmQzSEp1NG5UTVM4MXpCM2xWL3pwYjA0QmhTMEFtSXp4?=
 =?utf-8?B?ak95TmZxMmRHZG1CQzZpV2xrN3E1cEZOOVFIUUo4YXRyTnZ1YzJUVmpvY2xP?=
 =?utf-8?B?T05sQkpKU0dDcHVyOWVxY2VaMmNqWWxGdTNZMk1TMjB1NFc0V2szMEN5TlNK?=
 =?utf-8?B?L2g5RW9ZUGFnck9zdmVpY2dwLzhnekpqOFl5OXE4STVHSUJQNTVTdlNUSUw5?=
 =?utf-8?B?MXlsSWM1OWlVQmQ2bmMrRkJxN2xVbFVBaDhRRlRnRGM0QUJjS1k2ZS9aNUtr?=
 =?utf-8?Q?FJ7XiT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1lSWnZMVk1iZFlMOXg5L2p1OW5haVJyWnFRcEFHYWkyVlJ1TkVKbERTRUU0?=
 =?utf-8?B?bzBESjVTNTljc3poN0Y3YzRyVFg2WVZUVnFvWXo3K3VValF4WkhRZHZsZnNx?=
 =?utf-8?B?STdCTC9DQkxtbjBqSzh0NjRDdEFwWU1oTHI0VFRBSDlNa2tXL1N3UGhSWTF4?=
 =?utf-8?B?ZXhEVFRNUTJIUi9wdFVSY0o1YUZrVFVqcmpobDJqU0lKNE4xY1MvRjc4QS92?=
 =?utf-8?B?VGZWcExhaVZVeE93a1Iwdk9kaHl5SUU5VVNISjB6TDJveHplcFNlSFNjWVIz?=
 =?utf-8?B?OGFqWmNUREpzc1pMSzIvRTk2RktxZTVEWWpBL0J3NFpLbnZSMUNUMzlrRFlJ?=
 =?utf-8?B?T3NieEdoZTVxSHp6RlpXcG1ldy9lVWxuUGgreWNtY0FsYkM1RS8wMTgxMjJX?=
 =?utf-8?B?Umd0TmZaa2R4aDVjNWFCK00zbytIUmZkWWtYSkpJVVdaMDF3dGUvL09ZUG40?=
 =?utf-8?B?dFFpU1hqOXh0MVN2QTJpS29OaktkbXBXbjB4RlNlamlNdFNyd2hnMFpiOEk4?=
 =?utf-8?B?ZjE0Y1FNSzNMdjlmWlNCLzlQTDZDTE9NYnRPaGJhNG5VdmhMN1hyRWRRdzRr?=
 =?utf-8?B?ZWZQNGJyby8xVEdKdENSYXdQdlREZ1o2bkdZRXRYRk8yUTh0MjZuRWR2dkFa?=
 =?utf-8?B?NThpSFY4U0cvdE1uNmc1dmk4WWRqdU8wK2RUZHhoaVJjM0xzNStPcVNmcTRB?=
 =?utf-8?B?Yk4vdlF2QlpSSFg5WHIvdm5LOXpLaFVwTkxiVSs2ZUw5VkRMSGY3L0VXMTdT?=
 =?utf-8?B?Q1pwcjRNamNYejVOYjN6Y1l2TG1JdWZHVU56V0VJZGZCWUFNV2IvNXBWbldn?=
 =?utf-8?B?bUZmWHpMelFrakZMUVNkQ3BGZ3lJTWlkK2RDMkRkSGg3UXh3eFowblNWVFp1?=
 =?utf-8?B?WFRCMDY5NzZSeVNRcVljTW9YNm15dW1LeXRuNE9kSG45MFJzUjg2U0QxY2tJ?=
 =?utf-8?B?Nmc2L0gyTlRXbEpIcFdzeVY3Z2pUVk5KUitQQU12c2thMUdkT21iZngrWDBE?=
 =?utf-8?B?N2dCSlA0OEVCRndENzVDUzl6OHMwcG9OUWNIbVI3QzladVR2ZGpBL0ZlQmlS?=
 =?utf-8?B?RlFiVU4zOU9jV0dpbnRoelVwRzRPajhQdEdLUjlDd2xGdVdBc2ZIV2tKekor?=
 =?utf-8?B?aU4rN0JncWd1dEpYbHAvRk1KTE5zaGRZQjQ5YXlNaWYycjloQ2Y1UHBiRDNm?=
 =?utf-8?B?Wi9yNVphOEt1aXJva2w1Q25vOWpyekRWSXQ4dDBVa0J6WHpkM3huRXZhV0hP?=
 =?utf-8?B?VHlKNlJHeWcraTBQMTZTS25rakVlTlZUS3NDbmV4WnhKMWMwSHQ1d0Vra1p5?=
 =?utf-8?B?K1Iza09DbTBqNlNGUzZZbnFuUGcyMUpYQUM0L0hkaG41Wnp3RWREUGVnMVVX?=
 =?utf-8?B?UFFmVUd0QklrVHJyaDZkRmdtNnczbG9RQVNXTWxLWXZleTl6VVdQblhhTG5a?=
 =?utf-8?B?UmZ6bDUzVHhlcHdFSnNrMlArSlg3TGxKc3RCeUwwbStQMjFkOFgyWWFDVTE3?=
 =?utf-8?B?VGRHUWg5T1Boa252SHY0RUhtc1dmNzNVNDQyRGtWNFhKVUE3MXVibW4waDMv?=
 =?utf-8?B?endXNVRrTm5rVHdJWGdNVlVwSjVocytOR2oxNk5iWTZHTlNiOVhXL3FjVEt6?=
 =?utf-8?B?Y2tOcXRYRnY3UUp5RGR4ZjdRTGFEeHVKUzVxYVpHWVV3b1cvR3ZXcHVyUUQz?=
 =?utf-8?B?VjU0L2pyaDAwM2J6MUNybVdudGx2dGM0TkJlbnZiRGRwbU8rNjJ1WG16NmRk?=
 =?utf-8?B?MFE3WWxjeDZDcnBwQlpCMlZ3SkhzakdjZGR3WnRHY1FzY3N0R1RNUGRZT1Ev?=
 =?utf-8?B?NG1YTWc4bmtkOWFnMXI5cWlZVStvcUx1Z1U0NGFZa1ZpSVE5QlhTd1YzemU2?=
 =?utf-8?B?bjFRa0pxZHFYZWhxY0lSZGlBV3R5OGJZZWpZcEF0Rng5SG5JdEpEWWZZRGxD?=
 =?utf-8?B?WVRxZk9OdkYrMEYzZUJOb0xKMmcyV2ttSm82M2ZKMkErVGhMRC9ZV1FVeHpM?=
 =?utf-8?B?Y3BTeU4zVng0YWwxdVkyYmtpRWNnRHNwNnBieHk3TnZhMzFGaEhaTVdZZXhu?=
 =?utf-8?B?TG5ud2VlYVNNaDhMVUo3czYyM3Frd0E5cnRXNXhranBHYkF6c2lKMTlGMTlU?=
 =?utf-8?B?ODFoTlpibFVoOHFGbnZwWmdqOTNRTVViTzNQZ01kYjUrQW1uM2xGRHFvYkN6?=
 =?utf-8?Q?uzGP4LVAmYRFPZEHwEB34o2DOJlJh6fFGFZ5Ev/jyokC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC78FD0320F96240B1EAFD204A487F7D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 097da4c0-590e-42b1-9974-08de2495d598
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2025 22:25:08.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8fKoyu562Kxew4ksE8TpUrt258j7spHVny8/yZJtY11zfFGdxLtdYJHQrN1+BV8C0Q43kFPbYFkhOs2MSE6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

T24gMTEvMTUvMjUgMDg6MjIsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVvbiBS
b21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KPg0KPiBNb3ZlIHRoZSBzdHJ1Y3QgcGh5c192
ZWMgZGVmaW5pdGlvbiBmcm9tIGJsb2NrL2Jsay1tcS1kbWEuYyB0bw0KPiBpbmNsdWRlL2xpbnV4
L3R5cGVzLmggdG8gbWFrZSBpdCBhdmFpbGFibGUgZm9yIHVzZSBhY3Jvc3MgdGhlIGtlcm5lbC4N
Cj4NCj4gVGhlIHBoeXNfdmVjIHN0cnVjdHVyZSByZXByZXNlbnRzIGEgcGh5c2ljYWwgYWRkcmVz
cyByYW5nZSB3aXRoIGENCj4gbGVuZ3RoLCB3aGljaCBpcyB1c2VkIGJ5IHRoZSBuZXcgcGh5c2lj
YWwgYWRkcmVzcy1iYXNlZCBETUEgbWFwcGluZw0KPiBBUEkuIFRoaXMgc3RydWN0dXJlIGlzIGFs
cmVhZHkgdXNlZCBieSB0aGUgYmxvY2sgbGF5ZXIgYW5kIHdpbGwgYmUNCj4gbmVlZGVkIGZvciBE
TUEgcGh5cyBBUEkgdXNlcnMuDQo+DQo+IE1vdmluZyB0aGlzIGRlZmluaXRpb24gdG8gdHlwZXMu
aCBwcm92aWRlcyBhIGNlbnRyYWxpemVkIGxvY2F0aW9uDQo+IGZvciB0aGlzIGNvbW1vbiBkYXRh
IHN0cnVjdHVyZSBhbmQgZWxpbWluYXRlcyBjb2RlIGR1cGxpY2F0aW9uDQo+IGFjcm9zcyBzdWJz
eXN0ZW1zIHRoYXQgbmVlZCB0byB3b3JrIHdpdGggcGh5c2ljYWwgYWRkcmVzcyByYW5nZXMuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IExlb24gUm9tYW5vdnNreTxsZW9ucm9AbnZpZGlhLmNvbT4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQo=
