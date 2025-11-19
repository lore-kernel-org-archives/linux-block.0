Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15752D9EEA
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595574; cv=fail; b=jJvmT7FKYD5jD+IIcGDzoBixfi3uQPQRU6i4QzDIVJ/2kOKRuGbZgFo1bZ7sTsLXHG1QKdm66VGT7wnqisnGJgunQAzoLYXRJExnixFZXENXj3u/WtHSDO8SsVVXsvy0BI+2s34VxKkHWrddmwfqBeobEFfKQDHM5n+zQnKZVxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595574; c=relaxed/simple;
	bh=DCiVN3aXTGJYEV22f18ZnpbabtRk/guXKMXlY+jMYUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TszAT9izuVxtWF+6DYTQL+WxwxrLeTkbiPRp7LGiD0DOVmk7PoxXOwxCX5g8ITONrieH4vbgncVzbfO9HNs78FLeCfyxlkQa6KQr0JZajwo6cfx24Gl/OJBLRSmB7xw2qTWeL8MjMzfAqks0Ewqwd8ARpZXsS01kT3nonKN7h/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n1BxSuXe; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n1BxSuXe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3II3y/+FHD9yFRvnQUInm3RzN2eceAITgDwXPlrTaGaNA7hDhcHZKfQfrHcg7bbnKd2T6ULdu3+yHhe3Xvscq0VQcotxAFOSx7eBY7i3Ev63TcPumCb1YPwkUEOu9I7vjSKD4epytME7p2rwvkeBi10koRSFKKuQDmiiVQ4wKzZb8o7hDOI6D+shvrD8m9PO+Uoq/dkBE5p8O2BbX2HC90PheSeX5AArayXWjJ5UXQeapqgAHDZtxKXNgzEPHxkihQjPOLrBbj4YbPsuYjgis/XikttGJEFUIMYNrxc7SQI2hwKL78UW8UafvUtxc+SVNec5ho/kJUsPospME16TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCiVN3aXTGJYEV22f18ZnpbabtRk/guXKMXlY+jMYUo=;
 b=TbvvVxW8h0KFxyx78Y/6IMZ+sbxhxlaEtYL+9QWWTLrJqkO01BVsbI7mXI3yA2pmJioaWreMW5Qvkf5PXbS8Jqp33wodxaa23YkmpIf4LYDv8h3wXjWtlnhmFGNKTlUNdgYHczaWy3XDLWG7fSpP87G+zRsNRQWR4/8w4hVhpSacBnADorViX0yluNTkgB6KfZGdcMSQGPweanmuX3/DoL6pxTTcAqquDTaqGZmSCLtZ/JO4KVJda0oi0nxHRSyTyju85kkfGNFzT6d1mWv9N/Do+xZp4RLBgqLf5Qp/GKbzOQCpYwlKh56MBS3K8HT076QfBHsVLL7p0w6hLfSH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCiVN3aXTGJYEV22f18ZnpbabtRk/guXKMXlY+jMYUo=;
 b=n1BxSuXeRaFK5FtVuirNO0eBAZVWZWKHjFOsism6kI1jkijm4fD8H4ecFryYD+wgz5AaR4trE+G8LdQhCiAVceMjUnBxh8uXrEBhof1nVIGZpArkmw5t+QiImJVN/9cx3dCNHeTnGTCSEhlzC7GQUCOW6jUO6yqJGIyBJXIEq/hER55ffr3l/vQYqZctu2ZZq2DR6IEY3/q2yjLGMhBYgNMeO+D3znb3XzKFX8TpBOR+FpgwpV/ZdoHzlC7JbFfQdofQ4A+zYmtVgB1TGkecYsSVn4iu7sKCWs1tEY5pFNXT3Px6lrPQwch8uKslQtflCehrPvG15hOCA89F8agvfA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:39:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 23:39:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blktests: test io_uring user metadata offsets
Thread-Topic: [PATCHv2 2/2] blktests: test io_uring user metadata offsets
Thread-Index: AQHcWY5qECTFORLU6UmelYge4ToHZLT6qGKA
Date: Wed, 19 Nov 2025 23:39:30 +0000
Message-ID: <61fa1035-6c40-4792-ae18-9e90c638c68d@nvidia.com>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-3-kbusch@meta.com>
In-Reply-To: <20251119195449.2922332-3-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8909:EE_
x-ms-office365-filtering-correlation-id: 9de03d2e-9cae-49e8-00af-08de27c4e2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXhkZVI2TDN6aHUyT0FTRkRpOHNEYzNtUzc4L0VLdFZRNVRmcEhRN2hIUlhN?=
 =?utf-8?B?VExtcGU5M1hGN2lTdXhEaGQ0Ni9HQmsvNVMrT0V2UUJSOUpLZjdIbFlQZ0RB?=
 =?utf-8?B?b2sxa3lZUUxvQ3liRk9hSXZ4Q0Y1WGhBa1lwbnB0dFdlcktIWFUyMUZJbnRL?=
 =?utf-8?B?MDVJWkRldURiaktDQWtJN2NkZmMyQ1lNSmpySDBIb3UxVjVqRndsbnZmUnRC?=
 =?utf-8?B?MzY0REE1ZUl1S3lvTG5tWkZjZmlnYmNDdTJXa1Y2aWt4OHg5WHAzSmVxR2pY?=
 =?utf-8?B?dDRTNk11bUdtY3AzcnVZWWtQUW4xaDBOeE94UXptWk9mZ3VsRVRxYi8zdmFU?=
 =?utf-8?B?Tm1VdWpZMjhCcFlHRWdBTCtTVU85cERDZTJucGlRZmllRGxHOXZuc1h6ZlhV?=
 =?utf-8?B?VGg2VTYxSUZTblBCKzBKazNnRW5UZTJJbmdiTGEyL21TU0dqbldtaEZmWWxQ?=
 =?utf-8?B?VlZIWFdiMzZTWHF3M1k0SHRLOHNia3RSZ3NyR2ZFRTRnd1dGUk5VM0duY1Jw?=
 =?utf-8?B?T1lQQXNwTHhGeVV0UFZJVXNQUnZIQUgvZ3FDMUU1MXo5dEphaUNOemxENGta?=
 =?utf-8?B?MklHRXZMR0JDajQ1dkNpTVFKT3RBWEdLaEdSayt0SVpFRVBGZVRNaThZRzEy?=
 =?utf-8?B?ZTZkUGJWazViczhQTkZieVBjMXk5czBBdXd3aTZIUGNUZ3NPTXVqa0w2Y1B2?=
 =?utf-8?B?bmFkdXdyZk9lYzFsaDhGS1QyL0s0QU9JQ1MxVjZvREEzRllvZUMxTXNzZ21y?=
 =?utf-8?B?Umd1VUpJMW1lSGdIQ2dHZjg0c1VGZkFzVlZKVkVnTkdTd2hVM3o5ZlVoT1RB?=
 =?utf-8?B?bndoSVkvUTBFNmhOUGt1UmtGWjU3Q2VuTHViTi9kemQzUm9yYTF5dldrSUlO?=
 =?utf-8?B?SGxrcGhLbE5vK2xRcTArWWc4RWlnK0ZnbFQyQTZRMW5mZTdoRkd6RWllQm1W?=
 =?utf-8?B?UU9XQnlPWDFwdFZYRDU4bE1wQWY2ZnVoTWhva2NmTXRRN2pyT3pNVE9nSUp6?=
 =?utf-8?B?b0VMbi9rcXMwYS9QUWZrMVpwYW4zQ2tyUm5zMWxRMnprOE9rQzRFdmp1azJ0?=
 =?utf-8?B?KzVUbE1sZFhzL25hYzRQbGxJU3Q3eXNjZlJieWVEZ3ZHTUo5aXptOEZPcDlB?=
 =?utf-8?B?VXhxUEh1MWpXVXM4R2N1QU5FUUF1ck5MdjNwUlFpMzZQVFJNTjkxL1BIK2l4?=
 =?utf-8?B?dmtRWUZ4OW1USlM1eDB5TGNOQlAvbThnRlBkYnRMcDNnUnJ4ZVc0UHpNQnFB?=
 =?utf-8?B?WVlnRzBYVTBYSVVtdlRuNytzYzNEc1dPY1lLZTVHSGU5d0ZMcDJvVmwrSzBy?=
 =?utf-8?B?bGJIdG56QitqTHZoRW5vWTI1d3VhUGVKS2RYd2RLYnZnK0REcmJrdGJiNXd3?=
 =?utf-8?B?amVQSWVwc0VZSHZYUVZQZkVjb1NLUUcxVGhQSlg3dTFCSnBlUUVzN2tWdkpN?=
 =?utf-8?B?cW1BTDRKa0ZDVERCN0E1cVFmVDFCVS9oUFVPakU2MzZhRjAxVkNPb2IvY3Jp?=
 =?utf-8?B?NFhydzkyVzF1Z0wzVTZuRFczTlFpUmJxSDl2R3dKekZyVndMZFBIdVRkNUtX?=
 =?utf-8?B?cHdPWUhrSGxoYS84S2hUVzJVbVBpQ3BGQlkxcXBRc2VwcE1PVzNXenFmc01n?=
 =?utf-8?B?Vmt0c2M4UjRaVlhZMFVzZHNnRGE0Vk94Z0lxOFE5WkVIazlKbllmcWt2TVRp?=
 =?utf-8?B?eDFnM2VESzJ2ZzVJaXVQZ04yQVNWNDFVQ3pZS2xSd2hsdDRBN2p6R1k1WFJF?=
 =?utf-8?B?YU5pNStVb2ZRQWtSQzdGRVVHRUpMWlJvWGNhTG5iN3FLUzE3aXl0NFZESVRv?=
 =?utf-8?B?ajNXT1NtdmNiZEpqR2lsaTBJZ00xaWNsNWlLQTErTEtoMFJ3K0xPbmhPZG96?=
 =?utf-8?B?anlxdEoxcnB2Q2E1UHdSc3QvZ3dCMlJBNG5Ib0RQb1RMOTkrWURnZHVNRjBG?=
 =?utf-8?B?UnY1UVYrRXpNVTZ4QkthTGY5Mzh5NjZwRkNqb1NmYW1Xb2VtMThtVlZDZmJF?=
 =?utf-8?B?eVJ1Tyt6UnNnOGdQWmhqOU5pSXo5eUQxOWtRR0NudFZGQXlhWEpseTYzY2dN?=
 =?utf-8?Q?fvdEG/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enNjb244VWpHYUNPQkI1LzJaditVWmNXdjZjM2w3RmJTMkx1RXpkTUpQWmhT?=
 =?utf-8?B?TE5pYVhtaDB1MTFRaUFXdEdZZmtYc0szY0tUWGd6TUw1ODFwcTA3WGtucGE5?=
 =?utf-8?B?RUJnUHA2T2JvNldIMG5XUTNhRVRSUXJsU3FGQ2NZVmxWN1hYMGNkYll2WGdp?=
 =?utf-8?B?U3F4SXgyTWw5WkdTc1hKdkVOZXlDN1Jpc3IrQ2NtWGhyeHQvOEZJVkYvRlJ4?=
 =?utf-8?B?aURUUDRtQ2FwRlpLMzRpR1k5UTlHOUUvcWIwVGRnZGxYckVzVG9Tb0RLa1pF?=
 =?utf-8?B?K0laR3VCUFhGWllzWjROMlpGL2ovV2Z0ZVlMTTJjU2ZHMjhNRnIrZThZVStP?=
 =?utf-8?B?U3ZuRnZTM0orVHNlOGJZZEduay9pVGxzVVBxdkw5U3Z1Z01IZXlqck9YdHpL?=
 =?utf-8?B?dGk3R1dKL2FIQXlHVjdxRGpyT0VnUUNEckRMMU9lTitLYU9hVHZJOHdIdGhZ?=
 =?utf-8?B?VlQwLysrdUdNMzRWUG5ia1VBZ3kxZ2puc0lKbGloTHIrMVF5MHE3b3I2NFZl?=
 =?utf-8?B?Q0luQWlKL3N4dHZnd2prT3ZLY3NBeU9ITGNzUzVraVNtQnkzVUVNWElKZFdv?=
 =?utf-8?B?azcvZG1rZCtJTmJQSXJ1MW44MlZBeFJTbjd1NmlVR3Q4bEowWDIvTEZIYVFp?=
 =?utf-8?B?RW5EWFlPcUIxQmRjKzEzM0RIdWE4alNkNmM1Tjl3NjdnU281NEZjN0dIckQ3?=
 =?utf-8?B?aWQ1VDZwc0E2ZG9EczRMMzNRR1FvbEFDOXoyUjVzT1lRMDBmeTF2MVNNdUt0?=
 =?utf-8?B?MkZrbzQzMzI5QjN0eWN6YlR0NWl4Ump1di9YREE5SXNKVThwSE5QM2FhR2Rk?=
 =?utf-8?B?TUVwTnJUdTlhcDgxQmg0YUs0aGY4bjcrbHRacXdWa1NOeVJpMmhNUERBYk5Y?=
 =?utf-8?B?ODlTNUR5SGw0WW1TajRhSGpxQnE0Slg1ZXpLMGpCMUNpSlhUbnlNVW9BYjh3?=
 =?utf-8?B?cjM5UENxSXQwdVA2VnlYdUlENU1obXpIUnF3ZkIvMERrMksrblEvYkFldjc3?=
 =?utf-8?B?V0l6S1FkTm1OR2lOczFqaTQyeVllWXM1dnRIeHIzWFJYRXQ4bkczWlpWZHFP?=
 =?utf-8?B?VEFLZkJ1UmNxaFIremQvTG11TEhBcWFxbXJFMithbUpsSmRPZERmcVcvVXQ1?=
 =?utf-8?B?R0Q0QWhLdy8yNHJiM3JaMEtza2hvUHhaNjVWNVRFMWNqV2NpWWFiMXJ3REh1?=
 =?utf-8?B?MXlRY0xqQjZVY0dabkdCNVBuSGdZNUVUbkpRR2duZ0RRdDZ4OVlydXpIVU1P?=
 =?utf-8?B?ZzR4QVcxOVFORmVMU3oweGEzWUdSRzlRR2N5MFVLcEEvMlR5emI1bEJaVEtE?=
 =?utf-8?B?NWhBQitnN2k5ZWtrQmNWSEZWOXlvMlpQdExqYjBSMzlBSTMyZFhLSE1RWHBR?=
 =?utf-8?B?Z1NGbDlUK0RMOEVKT29FQ2JwL1Y2MUJRQXBsQjI4WkFadFJCOGRjbkVpZGV2?=
 =?utf-8?B?OVlab3ZPTC9lWXFlYlJ4T0s5M0wvOTF1ZHJYWlp2L1NDeThscjZWZ2tvN2t2?=
 =?utf-8?B?Ylc0VVpOTHBKVWEwMFgvNzZvZnFkTDBsanN4Q2E5Y04xYVAxSjE4UFBDcGVq?=
 =?utf-8?B?VUk1blRqNG53aUd4cHBlM0VmdTlJVWVaMDcxZTB6NTZTd1ZUNDJZaGZ0dStF?=
 =?utf-8?B?bituV25ya1U5RXRqcExCZ1B0TkRETzVmeXExdXd2Q1FtYXMvR0NBK29MV3p4?=
 =?utf-8?B?Qmw3VHVac2JwNXlWcXBvS2JjL1AxalAzeWJIMnFZRzcrZGlldWZzNVRTNXJs?=
 =?utf-8?B?d2pVUDh5RWlKKytjakZjT2xVMkxlLzVZVHhJdUFBMFppQzRMMXhuSmlEZ1Ey?=
 =?utf-8?B?M0xRbjFSaDR1dTM4MFBrdW5VVjdUSFU5SWxMSTNTdEVwSU1hTzJkZnUzaVUw?=
 =?utf-8?B?ZjFsV1BsRUJ2MVZlU0pTQ0RVSWtES3lzY2VMRk1rUVovS3F1cjJoLzNzclFS?=
 =?utf-8?B?azJ5bk0yZWtSNEpkRElSeVFSVUhOdEdrRE9IemRGU3pXeHRjTWhPYkNPQmxI?=
 =?utf-8?B?My9MSXc0Y1FqVCt2NkZGRkx6MHZnbXorOFUxRDltb2tHQ2U5WDVYWlJmb1N1?=
 =?utf-8?B?NXM2S3Vjc0FBQTZqbHRPUitJRmFrTklaSlA2WXIva1ErNjF1VEQzWUVzUHZQ?=
 =?utf-8?B?Vjl5V3ZTdnJsMU5qNVZJcjY4MkhzK0FjcWQ2RFJJbzlzUW9reXdGUHdLZ0xL?=
 =?utf-8?Q?JndRMh/AloSTXQ2q2gJbARImVsg4ESUNQid/QoLKetbv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5D863C93F22684AA993B1FEBEA7133F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de03d2e-9cae-49e8-00af-08de27c4e2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 23:39:30.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Th+zA0it22sY6UD1s9eZLaZ2eeMRlK1hA7Bztr6U4ZNrR/UZblCCckGlS5NzA3PXavJAky6zJr/KBddxKhsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

T24gMTEvMTkvMjUgMTE6NTQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gRm9yIGRldmljZXMgd2l0aCBtZXRhZGF0YSwgdGVz
dHMgdmFyaW91cyB1c2Vyc3BhY2Ugb2Zmc2V0cyB3aXRoDQo+IGlvX3VyaW5nIGNhcGFiaWxpdGll
cy4gSWYgdGhlIG1ldGFkYXRhIGlzIGZvcm1hdHRlZCB3aXRoIHJlZiB0YWcNCj4gcHJvdGVjdGlv
biBpbmZvcm1hdGlvbiwgdGVzdCB2YXJpb3VzIHNlZWQgb2Zmc2V0cyBhcyB3ZWxsLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==
