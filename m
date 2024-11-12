Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F0203714
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373145; cv=fail; b=VcGFXRGE2IaG0L9QUS9JfrADvmrWpRs0V65jFpQZDtlfBJUKq5EqkvVGnp3YzOne771qT4xEacqzXwxutUvrJej9/bCKoJwKLo0CKklghLZ/rX+kkD/kqXqnHDdTBnOyEuMhv0ee33FaHbX8UcRb++L1ZLPfZukjF3hW/TAq4aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373145; c=relaxed/simple;
	bh=+ZVs4mcphbrCKdLTL62/kfHQSy+P5Wf5FGimb5WrJdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4vQqXYvKaN26CWnjL8sXCk+tOaUzXumr5cKQeEdIkYBeQ9nuwTk1H2y2s3KlN+5AvzmsnJxfk6pqGfNCmXHb9FHOaxjDe8YFsOFasUJ7heS5z9pmCEZyOAyU03FmY3nvdGPZp4ZMJ1tecpE9dI2jwRA8SRm/faumVFwh/VzlMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/fsUjwS; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/fsUjwS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFyDfJhpyx6/32e6tPFd+rzZrZQl5FGA7gd46Si2MeAv9k/uvwiLMTAOJ+i3nqrEYB6kuorquP+Z5vRzx8wbH6Yl8i4Inyvv++4KDeG0xk4cwFsHZCurSXWg3KQAIojWZmhNcBSttwHx/Jt66kG/VdGv8Z28D84vi3UkBHlTM+UwDtzPDYdyym27WsNeZED1a3xYPhdV3EgTAYug8x1dxyF3NdIuJ5M7WEqImJnob3sLCJqoA9HLP7AJQuS0eOl26degySWDd6SfPZpmQSnNL2Q9MHDB88sPEF2NBKIzSpDakI748CznzlTAJkfhIIZbxg+ANDKHJshIXLPg7e8ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZVs4mcphbrCKdLTL62/kfHQSy+P5Wf5FGimb5WrJdw=;
 b=OB+QxJOhusLKHJrNLmy00t+sDiliGEWMnuaNHr2B5BpAOSPIMy/fEAo13sFjZltVYmqrPJJHhcxH6zfDB1cD94gS2k8K+X7YDAyqlqgXaV0rPWkpjo33suAam/+CxETty3qQQZO2CdpkHdM7Ku8M0KAbl1v+YW2IA/bKv5CDu43GQhiSX5na8zOBQvCWQ6HUTUw9qbbQqoLgiEbpFD+e3ITJ/al5WBK3IiAYzMECJAYRUegwajueG64JF6TSoT/nERGQVNqMsvqakEr6d3KLKWcxojNj3dyM9MIjvbf1t4vyt1M4Mxns4r3kPtUd08ZxVvxp7tT/iHdXgNNw64dP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZVs4mcphbrCKdLTL62/kfHQSy+P5Wf5FGimb5WrJdw=;
 b=N/fsUjwSUxt6rYJqRE3BktFzq3ap6wBPDC3MlHArYipxlL6ngndr9k4l5hUjN4K8myvVH9tirbl2hGsJJIGKhN+k5J500vukLmlVWytbT8s36mTirug+G/FlOuYtWb/rh5NQziLnrDcrDXPIA0GjWlZ1jg0Ga/uVpKEWaE4cp7J6UTtAfJmg0BuzjEYziDmCz3cjdN5wyaQlJuO8ksKL2bF7dBFx5ePlsMnOSszI2tjtTHJ/+EysWT4YkNr/DdVyzyS2zW7FD7ahW1ZWvHmtKPaXw97xnfSZTJJ3Dkn687wXmyZJELrJfKOqgoj+9ka05wPU0vnfVcr6bvi2oEF+ow==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 00:58:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.021; Tue, 12 Nov 2024
 00:58:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Topic: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Index: AQHbLu/ijN/kq9fajUGjfF8Lslt6jrKs3jYAgAYABIA=
Date: Tue, 12 Nov 2024 00:58:58 +0000
Message-ID: <aa20b141-4712-4b68-b02c-9caf7cde24a9@nvidia.com>
References: <20241104192907.21358-1-kch@nvidia.com>
 <32ge2scpracxiqw7hcqeb4xnfowofw2cjods5rr3ckecgpxxdj@fqny5zqdcelw>
In-Reply-To: <32ge2scpracxiqw7hcqeb4xnfowofw2cjods5rr3ckecgpxxdj@fqny5zqdcelw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV2PR12MB5990:EE_
x-ms-office365-filtering-correlation-id: d46a032a-f397-4297-a1ba-08dd02b53066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHdZK1NWNmQwenprL2pWbFJPaXZ6TWJudjVocXJLQmcxVGFsWTFEMkhHSmxp?=
 =?utf-8?B?WXZseHZ3QW51TE9jaUtBZWpkc090UXg3WXNNOHJOREpBSVpRTXhRTWZzdzF1?=
 =?utf-8?B?ZERtM1hZQXhqa1U2VEI0YmpMTlorTGJndEZjRDBXUTJTSlErcEpNZFl1V2da?=
 =?utf-8?B?b1BjODhQdkhRenNwWjBiZVlacVM0ajluWWNOUDdJcWZ2MkIxRDN2NlJuUkpS?=
 =?utf-8?B?U2NqODhQZW9VTXdlN1VwZjRqSDZIMkdtL2hFNmVHMEw4T1hzWWRMaVZFKzNi?=
 =?utf-8?B?NTVKcENyUjNBN2xXb2NOZFJWcnRWTHdSM0p3WGVWTTk0WFBFbkZPVks4a3JL?=
 =?utf-8?B?S3JReU5RT0ErQ1FEaHlNQ1F6bnY5akRuOFhtbzc0RGVBelZ1UVNnRGczRU9K?=
 =?utf-8?B?Y1dKT2E3c09SZjl3SnAzRjJIYkgxZU5lZVFVZVhEaGZPSDE1RmMzbDJBSmg3?=
 =?utf-8?B?blVpRzQxa0hRbFZ6Zis0VEpYQ1hZaVk4bG5LYjQvSkFuTEhvalJsdWd2dWh6?=
 =?utf-8?B?N0gxWk1OazV1bCtsYVBzQkNYa3FJNXVJNERsY05pQ3hlOGhpWC93SXYzelJr?=
 =?utf-8?B?cFcwUDZVUWxRM3NabnBlcitvcTZBREwyMzVDanV2V2NQTE1hR2Q5QnBic0N5?=
 =?utf-8?B?OEdoVklnbnRzTkNYU0VNeU5xZDRFeld4OHQxK0drVlVNeG9YZ20xNWljZkd5?=
 =?utf-8?B?K21LTUV4OWZ6RE84cXhYV0ZrSlRBMGZLaWpCZW5Sd05sY1NxUEVzTzIxQkV6?=
 =?utf-8?B?MUNVV3RKejRBTWdiTGVPbUhobS9oUFl0TjcyRE1OdmRPNXRBd0c5M1JDWlBl?=
 =?utf-8?B?MDJBNDVtejd2NHNvUktqUVA2VElOZG1MTWZDU2J1S0ZVY0FVRHJHeVZBRkl6?=
 =?utf-8?B?RnpHZGk5bWROWUNTbHpzS1ZWUVZEa2RWamdORXgyNHdyWXZyaU9FMGVSUngv?=
 =?utf-8?B?NXgxVWVhRlJqOWxZa1lYaW1ZQnhQcnZKcmhia1hTK0lQYWIvUnF5bTRmdnZm?=
 =?utf-8?B?UW5ucU9XUVlVTHM3bUluT0NqN0l4VFhCbnpnNzY1M0ZOTFQrUUJVT1VUemZ2?=
 =?utf-8?B?YlBmbmRLc3VQdTBQYWJNREkvdXJ5ekhHMXA0NS9aQWs0REo5d3FKeEdKSzU0?=
 =?utf-8?B?Y2ZQTHdMc2h1ZkFGYms3NDluMHNWSVdEV0dLYjVQaVhJUm5aN2pXMGVYQVQr?=
 =?utf-8?B?VjZmVWZEZWpZdXQ2di9JNGlOWEx1bVpHQ2svU0hFa2NrWVdKaG1rNUNxVGY1?=
 =?utf-8?B?SkZlYi9WbVdQbFNXVkwvMFRFWWR6ZDZ1SFNJb08vT2w5aHlrUVhaVkdEdFNt?=
 =?utf-8?B?WFMrWlVmRVJkV3hzaHo0QzBRZms2R1JQZVFhOXJjbnJSUzZiTm5Qb3M4b1U0?=
 =?utf-8?B?RFhLak5JL2diK3oxOU5jR1huZnVtbTdzNTZaclI5M3lQdWh1aDlOTWdkeUxF?=
 =?utf-8?B?czRBaktRNS8yVE5xS1dSSjRkaGVWMXQwMG1RSk8vdCtTc2kwVnVieHZWZXFV?=
 =?utf-8?B?QmM0WjRHZkNrMjB5K3JpWStUaklnWG4zMjlMZ1IvU0pIdTFGZXJJVmo4Ynox?=
 =?utf-8?B?N0lNTXlhY2t2S0MxVzZEM1JwbDh5a3Y0ZEdwK2ppMUZ2SmVmZ0x0SkpoejRn?=
 =?utf-8?B?R2xNbmVYbkhmeko3Ty9Eei9KQ2g4aWI1REcrWmVzSEEzRVN1NHZHRlFPZHFY?=
 =?utf-8?B?MmFyRnJERElXRUdSU29Wd0lIS3p6M2lsWjRjTHBNcGxNUFdwckx0SnBBQVdo?=
 =?utf-8?B?dVpPWkNhRllFYzRDOFR5SHNZUm5DRnRTL2xqamIweTV3SzhrSW1ybURjdWJM?=
 =?utf-8?Q?OSneL6bTf9GQuZRMCABr3uaW+Yi26gw4dP08o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czFJb0VGeExXUDBHQUd2SFVZWkIvclpXMzluMTdZcmd1aGxtVlVYNkhHeFlJ?=
 =?utf-8?B?MC9RbjM2K3hKZjREbDBZdUFneTBQRUxPMnMrdEUyUVJGenN2ZUlMWXdYWU9T?=
 =?utf-8?B?YjdFQUdZMExRVHozb2ZKYnRITlZra0o3R1R1d0pGazd2K1pCTzBGSGlROVM3?=
 =?utf-8?B?REd4anRCRTloUnlOWGdTdUhBV2FraThyTlhSbEZQVXl2Z0FYV1RQOUxac29v?=
 =?utf-8?B?RzRac0lzMWVCeWNsdllGR2ZJTDZiaTIxY0xWRUVOaS9qRGhiNnM1VVpQTC9y?=
 =?utf-8?B?ZjJMUHRyL0dCRU16YmVpZmJWdEZUQmphNEdvNElaYjRMWDN3eG1iQkFXRTFw?=
 =?utf-8?B?NXpYVWtHL2F5aGdKUnhlUHlyWmlLY1RaS2pHTmxTZGhQQ0g0OUVwZHNBTFpV?=
 =?utf-8?B?NFhzM2lvN1k2RU5zSXZDcVRjMU42VXMraHc2bkxBcnpkTWxlbjIyelgvT0R1?=
 =?utf-8?B?c3AreWJMM2dBUGh2TVB3dVhnUUxndzd5M2lBK3Fucm45b3dlSnBFc0RQZWdS?=
 =?utf-8?B?NzRvbGt1WXppWVlNOFAwUlEwUFdYK2plNEZMNVVEaGt1OWE5QWhEU2hCQzhD?=
 =?utf-8?B?WUlxV0U1Wjh2cHpjUGRjcGE1MnArT1R4MnhaSDEwT29pcHljak5PL1lNVExN?=
 =?utf-8?B?c3hWY0RzTkVmU0Q4QUZJa2dzdURIZEtzOE91SmRwbkZVbHU0clZHazRUeU9O?=
 =?utf-8?B?NVY0NU9vTU84NytDcVNKOTFmODhEd3RqTnZtb1krMDhlTU5yTG1rZXc3NUtP?=
 =?utf-8?B?NzFaNWp0L2dubUJ2c21veHZrT0tvRElQN29sMWpiTCtOUFV6TStBUFdIaVNL?=
 =?utf-8?B?WGY5blpLZmpLcVRUcGNFTkV5NjMyQzhhRW4vaDQvNEFNR1IrZHF1K0lxZHE0?=
 =?utf-8?B?SEVzbDIzSlhLVkt1cVlOTDNtWmRSL2tqbktLRjF4YzJ3V3Jkd0hCWkUxWU8w?=
 =?utf-8?B?TDVoMlBlR3R5bVdtM3BJbjIyamtJWTNQMkhZT0FaSjdNa0Jwc1RtZVRpNUV1?=
 =?utf-8?B?VC9VcjJBeU9CeVVodGo5cnFRVUhlSFdlTCtRMzhLbnFSUlVXK0hCNzhMV280?=
 =?utf-8?B?UVpxTUwySWhRMjdKU3ZtdUl6MS9SQ2RNOTBXMGhDaWd6WmFMd053UzhBbklR?=
 =?utf-8?B?VXZ4cWFjQWN1akJoTUZYQURhSmo2djA1VGs5OTA5d0JlV013ZWx0azQrRzI5?=
 =?utf-8?B?dHlMOFVFSlBJdWgrbnh6a0NFNVVneUprbTZpWWlkZFFKNFdLc2pDTHUva3Ft?=
 =?utf-8?B?d2NhZWEzeW1Oc0RWbnMxN0tGL1l4cE1Md0hnMHZYN1lKUHRtZ3ZCRk9NSjQ5?=
 =?utf-8?B?Q3RjeTg3bGR3OEdSU0JRa01tamptc3NFK0hlcC95TWlJUXVPSDMySEYvdXdi?=
 =?utf-8?B?eVppZ2t4c001QVE4U2ZwSjAxVUkxTDhWQ3R4aFVua2RUQkI3ZFZaN0pQdVdS?=
 =?utf-8?B?SS9rTm9KRGpodXlqYzB5VTFVSjZ0ZzVBYndpRGhjR2tPb2llQzdjY29Bd0xj?=
 =?utf-8?B?ck1rMUR0c1Vzd01mOFNwVHNkdkpzZXRGNlJ6NFYyQ0lPZ2xJNmpFdHVtcEJ1?=
 =?utf-8?B?eFY4MnFzRW53RzJqeWV2YUJkdStZN0N3QUdZSWhQSnJVRzd1d1ZPVi90dXJn?=
 =?utf-8?B?LytsaTlZV0s2bUVDdXFncFhHUXN5RlJ3KzFlUnNHZTQxUWttSEN6YitLNkkz?=
 =?utf-8?B?dGI1Q1h1cFliTG82NkxRRXFEZlR0c1VtT0tDdk15TytDeFBiRGFwSjlEUmJn?=
 =?utf-8?B?RFBNNWloZ056bjhlZnZGWVNVRHRWY2lJTXJML3pkNktOM1Q2YloyS2VWSGFa?=
 =?utf-8?B?QzU3WHJNcm56YmtnTnpHTm5ubk5TcHdvQTJkS0ZSSXNMSjBtVW9EWmJnZmJj?=
 =?utf-8?B?MlpGckNGUSsrdTk0T09uRU43bU0yNXUzeTc4OUVYRGtMNjM3dGJmRjd4NkZk?=
 =?utf-8?B?UVpCaXA0WWFvN0lFd1RWb0cxTUVIK3M4ZWhEMndhc2VGWnhiSEVYY2U5VTVF?=
 =?utf-8?B?QmZTL3NvY081RlBZV0U2b0YwTm16VHhRUXBNRkN6REZLcmRUei82SmhpZmQ3?=
 =?utf-8?B?bEVZVWZvTXBtMVJvQ2d4YXZ0c1gvUnZOc0QwRWdnQ21kMGNveEVPdHNjeFZX?=
 =?utf-8?B?WERTVnZMKy9YTnZRczlldno1Zk1yd0ZrM1R2ZTg3UXRzcHBYaEpJTW4wWWRC?=
 =?utf-8?Q?tbSuBjAYc11fv5Gyy0UnI0ncPE1YwvXnr/b6aCMbBVhI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A27076FE395D54FAFCE819AC2481695@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d46a032a-f397-4297-a1ba-08dd02b53066
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 00:58:58.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiTBVBHKlcxxKWFwO3gknjvVeguKda42SlkZ5IZMlKjiOSv88NihoZ7OjF9rp1OlbUkFyDi9MAJChSN+0DxzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

T24gMTEvNy8yNCAyMToyMSwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gT24gTm92IDA0
LCAyMDI0IC8gMTE6MjksIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFkZCBhIHRlc3Qg
dGhhdCByYW5kb21seSBzZXRzIHRoZSBjcHVtYXNrIGZyb20gYXZhaWxhYmxlIENQVXMgZm9yDQo+
PiB0aGUgbnZtZXQtd3Egd2hpbGUgcnVubmluZyB0aGUgZmlvIHdvcmtsb2FkLiBUaGlzIHBhdGNo
IGhhcyBiZWVuDQo+PiB0ZXN0ZWQgb24gbnZtZS1sb29wIGFuZCBudm1lLXRjcCB0cmFuc3BvcnQu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCj4gDQo+IFRoYW5rcy4gQXMgSSBub3RlZCBpbiBhbm90aGVyIG1haWwsIHRoaXMgdGVzdCBj
YXNlIGdlbmVyYXRlcyBhIGtlcm5lbA0KPiBJTkZPIG1lc3NhZ2UsIGFuZCBpdCBsb29rcyBsaWtl
IGNhdGNoaW5nIGEgbmV3IGJ1Zy4gU28gSSB0aGluayB0aGlzDQo+IHRlc3QgY2FzZSB3b3J0aCBh
ZGRpbmcuIFBsZWFzZSBmaW5kIG15IHJldmlldyBjb21tZW50cyBpbiBsaW5lLg0KPiANCj4+IC0t
LQ0KPj4gICB0ZXN0cy9udm1lLzA1NSAgICAgfCA5OSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgIHRlc3RzL252bWUvMDU1Lm91dCB8ICAzICsrDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNzU1IHRlc3RzL252bWUvMDU1DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9udm1l
LzA1NS5vdXQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS8wNTUgYi90ZXN0cy9udm1l
LzA1NQ0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGluZGV4IDAwMDAwMDAuLjlmZTI3YTMN
Cj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RzL252bWUvMDU1DQo+PiBAQCAtMCwwICsx
LDk5IEBADQo+PiArIyEvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wKw0KPj4gKyMgQ29weXJpZ2h0IChDKSAyMDI0IENoYWl0YW55YSBLdWxrYXJuaQ0KPj4g
KyMNCj4+ICsjIFRlc3QgbnZtZXQtd3EgY3B1bWFzayBzeXNmcyBhdHRyaWJ1dGUgd2l0aCBOVk1l
LW9GIGFuZCBmaW8gd29ya2xvYWQNCj4+ICsjDQo+PiArDQo+PiArLiB0ZXN0cy9udm1lL3JjDQo+
PiArDQo+PiArREVTQ1JJUFRJT049IlRlc3QgbnZtZXQtd3EgY3B1bWFzayBzeXNmcyBhdHRyaWJ1
dGUgd2l0aCBmaW8gb24gTlZNZS1vRiBkZXZpY2UiDQo+PiArVElNRUQ9MQ0KPj4gKw0KPj4gK3Jl
cXVpcmVzKCkgew0KPj4gKwlfbnZtZV9yZXF1aXJlcw0KPj4gKwkgX2hhdmVfZmlvICYmIF9oYXZl
X2xvb3ANCj4gDQo+IE5pdCwgYSB1bm5lY2Nlc2Fhcnkgc3BhY2UuDQo+IA0KPj4gKwlfcmVxdWly
ZV9udm1lX3RydHlwZV9pc19mYWJyaWNzDQo+PiArfQ0KPiANCg0KZG9uZS4NCg0KPiBJIHN1Z2dl
c3QgdG8gYWRkIHNldF9jb25kaXRpb25zKCkgaGVyZSBhcyBiZWxvdy4gV2l0aG91dCBpdCwgdGhl
IHRlc3QgY2FzZSBpcw0KPiBza2lwcGVkIHdoZW4gdXNlcnMgZG8gbm90IHNlIE5WTUVUX1RSVFlQ
RVMgdmFyaWFibGUuIElmIHdlIGFkZCBzZXRfY29uZGl0aW9ucygpLA0KPiBfaGF2ZV9sb29wIGNh
bGwgaW4gcmVxdWlyZXMoKSBjYW4gYmUgcmVtb3ZlZC4NCj4gDQo+IHNldF9jb25kaXRpb25zKCkg
ew0KPiAgICAgICAgIF9zZXRfbnZtZV90cnR5cGUgIiRAIg0KPiB9DQo+IA0KDQpkb25lLg0KDQo+
PiArDQo+PiArY2xlYW51cF9zZXR1cCgpIHsNCj4+ICsJX252bWVfZGlzY29ubmVjdF9zdWJzeXMN
Cj4+ICsJX252bWV0X3RhcmdldF9jbGVhbnVwDQo+PiArfQ0KPj4gKw0KPj4gK3Rlc3QoKSB7DQo+
PiArCWxvY2FsIGNwdW1hc2tfcGF0aD0iL3N5cy9kZXZpY2VzL3ZpcnR1YWwvd29ya3F1ZXVlL252
bWV0LXdxL2NwdW1hc2siDQo+PiArCWxvY2FsIG9yaWdpbmFsX2NwdW1hc2sNCj4+ICsJbG9jYWwg
bWluX2NwdXMNCj4+ICsJbG9jYWwgbWF4X2NwdXMNCj4+ICsJbG9jYWwgbnVtYmVycw0KPj4gKwls
b2NhbCBpZHgNCj4+ICsJbG9jYWwgbnMNCj4+ICsNCj4+ICsJZWNobyAiUnVubmluZyAke1RFU1Rf
TkFNRX0iDQo+PiArDQo+PiArCV9zZXR1cF9udm1ldA0KPj4gKwlfbnZtZXRfdGFyZ2V0X3NldHVw
DQo+PiArCV9udm1lX2Nvbm5lY3Rfc3Vic3lzDQo+PiArDQo+PiArCWlmIFsgISAtZiAiJGNwdW1h
c2tfcGF0aCIgXTsgdGhlbg0KPj4gKwkJU0tJUF9SRUFTT05TKz0oIm52bWV0X3dxIGNwdW1hc2sg
c3lzZnMgYXR0cmlidXRlIG5vdCBmb3VuZC4iKQ0KPj4gKwkJY2xlYW51cF9zZXR1cA0KPj4gKwkJ
cmV0dXJuIDENCj4+ICsJZmkNCj4+ICsNCj4+ICsJbnM9JChfZmluZF9udm1lX25zICIke2RlZl9z
dWJzeXNfdXVpZH0iKQ0KPj4gKw0KPj4gKwlvcmlnaW5hbF9jcHVtYXNrPSQoY2F0ICIkY3B1bWFz
a19wYXRoIikNCj4+ICsNCj4+ICsJbnVtX2NwdXM9JChucHJvYykNCj4+ICsJbWF4X2NwdXM9JCgo
IG51bV9jcHVzIDwgMjAgPyBudW1fY3B1cyA6IDIwICkpDQo+PiArCW1pbl9jcHVzPTANCj4+ICsJ
I3NoZWxsY2hlY2sgZGlzYWJsZT1TQzIyMDcNCj4+ICsJbnVtYmVycz0oJChzZXEgJG1pbl9jcHVz
ICRtYXhfY3B1cykpDQo+IA0KPiBOaXQ6IHRoZSBzaGVsbGNoZWNrIGVycm9yIGNhbiBiZSB2YW9p
ZGVkIHdpdGggdGhpczoNCj4gDQo+ICAgICAgICAgIHJlYWQgLWEgbnVtYmVycyAtZCAnJyA8IDwo
c2VxICRtaW5fY3B1cyAkbWF4X2NwdXMpDQo+IA0KDQpkb25lLg0KDQo+PiArDQo+PiArCV9ydW5f
ZmlvX3JhbmRfaW8gLS1maWxlbmFtZT0iL2Rldi8ke25zfSIgLS10aW1lX2Jhc2VkIC0tcnVudGlt
ZT0xMzBzIFwNCj4gDQo+IFRoZSAtLXRpbWVfYmFzZWQgYW5kIC0tcnVudGltZT0xMzBzIG9wdGlv
bnMgYXJlIG5vdCByZXF1aXJlZCwgYmVjYXVzZSBmaW8gaGVscGVyDQo+IGJhc2ggZnVuY3Rpb25z
IHdpbGwgYWRkIHRoZW0uDQo+IA0KPiBJbnN0ZWFkLCBsZXQncyBhZGQgdGhpcyBsaW5lIGJlZm9y
ZSB0aGUgZmlvIGNvbW1hbmQuDQo+IA0KPiAgICAgICAgICAgOiAke1RJTUVPVVQ6PTYwfQ0KPiAN
Cj4gVGhlIGZpbyBoZWxwZXIgZnVuY3Rpb25zIHdpbGwgcmVmZWN0IHRoaXMgVElNRU9VVCB2YWx1
ZSB0byB0aGUgLS1ydW50aW1lDQo+IG9wdGlvbi4gVGhpcyB3aWxsIGFsbG93IHVzZXJzIHRvIGNv
bnRyb2wgcnVudGltZSBjb3N0IGFzIFRJTUVEPTEgaW5kaWNhdGVzLg0KPiANCg0KZG9uZS4NCg0K
Pj4gKwkJCSAtLWlvZGVwdGg9OCAtLXNpemU9IiR7TlZNRV9JTUdfU0laRX0iICY+ICIkRlVMTCIg
Jg0KPj4gKw0KPj4gKwkjIExldCB0aGUgZmlvIHNldHRsZSBkb3duIGVsc2Ugd2Ugd2lsbCBicmVh
ayBpbiB0aGUgbG9vcCBmb3IgZmlvIGNoZWNrDQo+PiArCXNsZWVwIDENCj4+ICsJZm9yICgoaSA9
IDA7IGkgPCBtYXhfY3B1czsgaSsrKSk7IGRvDQo+PiArCQlpZiAhIHBncmVwIC14IGZpbyAmPiAv
ZGV2L251bGwgOyB0aGVuDQo+IA0KPiBwZ3JlcCBjb21tYW5kIGlzIG5vdCBpbiB0aGUgR05VIGNv
cmV1dGlscy4gSSBzdWdnZXN0IHRvIGtlZXAgdGhlIGZpbyBwcm9jZXNzIGlkDQo+IGluIGEgdmFy
aWFibGUgYW5kIGNoZWNrIHdpdGggImtpbGwgLTAiIGNvbW1hbmQuIFRoZSB0ZXN0IGNhc2UgYmxv
Y2svMDA1IGRvZXMgaXQuDQo+IA0KDQp0aGFua3MgZm9yIHRoZSBwb2ludGVyLCBkb25lIGFuZCBp
dCBsb29rcyBtdWNoIGNsZWFuZXIuDQoNCj4+ICsJCQlicmVhaw0KPj4gKwkJZmkNCj4+ICsNCj4+
ICsJCWlmIFtbICR7I251bWJlcnNbQF19IC1lcSAwIF1dOyB0aGVuDQo+PiArCQkJYnJlYWsNCj4+
ICsJCWZpDQo+PiArDQo+PiArCQlpZHg9JCgoUkFORE9NICUgJHsjbnVtYmVyc1tAXX0pKQ0KPj4g
Kw0KPj4gKwkJI3NoZWxsY2hlY2sgZGlzYWJsZT1TQzIwMDQNCj4+ICsJCWNwdV9tYXNrPSQocHJp
bnRmICIlWCIgJCgoMSA8PCAke251bWJlcnNbaWR4XX0pKSkNCj4+ICsJCWVjaG8gIiRjcHVfbWFz
ayIgPiAiJGNwdW1hc2tfcGF0aCINCj4gDQo+IFdoZW4gSSByYW4gdGhpcyB0ZXN0IGNhc2UsIEkg
b2JzZXJ2ZWQgYW4gZXJyb3IgYXQgdGhpcyBsaW5lOg0KPiANCj4gICAgICBlY2hvOiB3cml0ZSBl
cnJvcjogVmFsdWUgdG9vIGxhcmdlIGZvciBkZWZpbmVkIGRhdGEgdHlwZQ0KPiANCj4gSSB0aGlu
ayB0aGUgY3B1X21hc2sgY2FsY3VsYXRpb24gaXMgd3JvbmcsIGFuZCBpdCBzaG91bGQgYmUgbGlr
ZSB0aGlzOg0KPiANCj4gICAgICAgICAgICAgICAgIGNwdV9tYXNrPTANCj4gICAgICAgICAgICAg
ICAgIGZvciAoKG4gPSAwOyBuIDwgbnVtYmVyc1tpZHhdOyBuKyspKTsgZG8NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgY3B1X21hc2s9JCgoY3B1X21hc2sgKyAoMSA8PCBuKSkpDQo+ICAgICAg
ICAgICAgICAgICBkb25lDQo+ICAgICAgICAgICAgICAgICBjcHVfbWFzaz0kKHByaW50ZiAiJVgi
ICQoKGNwdV9tYXNrKSkpDQo+IA0KPiANCg0KZGlkbid0IHNlZSB0aGF0IGVycm9yIGluIG15IGV4
ZWN1dGlvbiBkb25lLg0KDQpUaGlzIHZlcnNpb24gdHJpZXMgdG8gb25seSB1c2Ugb25lIENQVSBh
dCBhIHRpbWUsIGJ1dCB3aXRoIHlvdXINCnN1Z2dlc3Rpb24gaXQgd2lsbCBub3cgY29uc2lkZXIg
bW9yZSB0aGFuIG9uZSBDUFVzIHdoaWNoIEkgdGhpbmsgaXMNCnVzZWZ1bCB0b28uDQoNCkkgbW9k
aWZpZWQgdGhlIGNhbGN1bGF0aW9uIHRvIGtlZXAgaXQgc2ltcGxlIGZvciBub3cuDQoNCj4+ICsJ
CWlmIFtbICQoY2F0ICIkY3B1bWFza19wYXRoIikgPX4gXlswLF0qJHtjcHVfbWFza31cbiQgXV07
IHRoZW4NCj4+ICsJCQllY2hvICJUZXN0IEZhaWxlZDogY3B1bWFzayB3YXMgbm90IHNldCBjb3Jy
ZWN0bHkgIg0KPj4gKwkJCWVjaG8gIkV4cGVjdGVkICR7Y3B1X21hc2t9IGZvdW5kICQoY2F0ICIk
Y3B1bWFza19wYXRoIikiDQo+PiArCQkJY2xlYW51cF9zZXR1cA0KPj4gKwkJCXJldHVybiAxDQo+
PiArCQlmaQ0KPj4gKwkJc2xlZXAgMw0KPj4gKwkJIyBSZW1vdmUgdGhlIHNlbGVjdGVkIG51bWJl
cg0KPj4gKwkJbnVtYmVycz0oIiR7bnVtYmVyc1tAXTowOiRpZHh9IiAiJHtudW1iZXJzW0BdOiQo
KGlkeCArIDEpKX0iKQ0KPj4gKwlkb25lDQo+PiArDQo+PiArCWtpbGxhbGwgZmlvICY+IC9kZXYv
bnVsbA0KPiANCj4ga2lsbGFsbCBpcyBub3QgaW4gR05VIGNvcmV1dGlscyBlaXRoZXIgKGJsa3Rl
c3RzIGFscmVhZHkgdXNlcyBpdCBhdCBvdGhlcg0KPiBwbGFjZXMgdGhvdWdoLi4uKSAgIERvZXMg
ImtpbGwgLTkiIHdvcmsgaW5zdGVhZD8NCj4gDQoNCmRvbmUuDQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldyBjb21tZW50cywgSSdsbCBzZW5kIGl0IFYyIHNvb24uDQoNCi1jaw0KDQoNCg==
