Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC533C9
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888200; cv=fail; b=eADTxGxgwJb0qEbpByN20il1HeS/595yxsLwIYPPIJiOnfep8s2GUPUJl+JOcmIjr5dmDDbzyeBmnb7ajkv+AnIgCS64edGOH/JJRodFQtXWyzQbHDaFVdBFb/FzQ2w7gGX9FrWaAavFmeYM3W/2n7+WPQY2cxbr+laGoY/VdHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888200; c=relaxed/simple;
	bh=AkYHk3nIU+Zxja7lP+J4MG1pC4m6N2n4BK4qQVOqcqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhHvyg2iXpIICwOVBp2iVfW8E/T4wrLZdOUYFBT/PQlbceyd3xehswN4V33PVIW2EabDjJXA21TDnJqpIfS7qd8KkDnLqKR8VJIvLz3LfG/jJ1cJBALw/Cijdxo/SjoNmzqg2wnm16yVy1H43/iDA2Ysm6TWBkKH3N2+5XtUMyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GuHfz3Es; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GuHfz3Es"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAzjEuJ+R3lDWrbxr34TLYymJjzS5wqaKVNWWbl+Nt40C4MRgEaua5I+Auq9t181yS6p+6R8haaFKs2VsgUR6NfE4OoUa7PAqcgMqmi/ZOPAtLlavLhJUMOM1wnjcfr4vQlgnC1EsR57xhwGGFCEgaSoH0x7tIClZBAToO6c8RanCN2hECFfL9w1gF/4wYw8wkDIsCDYH2upxZwuoBJWKX1EXyw1UCJdlWyWDp/esIS+MhhP3Q6gPzK/4y3WGujcW0+CaagiArP4izCGrBTd1YU/MWqRdtLb7DIBXYDRmpViZkrzJydhuaMwaJVFlY0ujZkgD1Zc4MhOHDXgH96XLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkYHk3nIU+Zxja7lP+J4MG1pC4m6N2n4BK4qQVOqcqw=;
 b=SYXCikM01o8rymRVypqleNP4Xq0rfqZJ23XUIW6N+uprm2LVO27YrAcmSE0Izhh8OTY2K7O60GAwRNiSjJZPs5Y1qB33n8F6BGxPcI48EWirXa0j9G1K50d9CfXB+eFIlMGoDPqrRY6Qh9YAOoSfJX6IdzX0mMvlNlvg1B1GpNDutGeN21EBBfmuIxzn0LxUezRdb0PXabKeIYJ6BGaGXvToYyd8EpVOLpqGcDhVXTuMqlKzTQwGAclbaSLSi60rx+PrHB63+AtjrLst0UjGhZnjyR2wgIdVgSLSgV46Aj1EhgApLVgkhpC7ajrJaPgKMG0g4Ra7gRH4WsEQaqX+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkYHk3nIU+Zxja7lP+J4MG1pC4m6N2n4BK4qQVOqcqw=;
 b=GuHfz3EsLIFF3QzAqaPQvNwVpR2r1XJEoQnsyVmzqtxAWJUuWymAyzNzYyBWPSftP9etfPlELrbMlRUdvdUbg+aTquEpuTbgY2puPR8lYKWTtfTUFgfpLQ4isGsE2hMbsDngZuu4en8HBTjPCZgc4lyWYKLq9BMWP+TZixlHQmV2A//UatYBetO46bR3RcOQhlJk8BFiJ1tWFWciU23jnr8PALYiixyn7QlwRgFc0vignuEKv7O1OzQQxGK0H3PebFdvQ6o3sP4wd0szKySKY9x+oR2bQyFO2jluKWl8e/TW6L54xrmlVdZXaPcX6TFZszeZHtx2d4pBw0mTknSejg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:43:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:43:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "dwagner@suse.de" <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
Thread-Topic: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
Thread-Index: AQHbHJebk+6CdkuMaU2IePQRm1FslbKFz4GA
Date: Mon, 14 Oct 2024 06:43:15 +0000
Message-ID: <6e1e4df5-ccee-4a92-80ac-64976a526003@nvidia.com>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-3-kanie@linux.alibaba.com>
In-Reply-To: <20241012111157.44368-3-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6305:EE_
x-ms-office365-filtering-correlation-id: a0353a0a-c443-440c-5b48-08dcec1b7b5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2VkVXBZalFnd3UvUWx5bUVtMnVYSHlVVFU0bURGZEN4emZCTE9xVjMzNmVr?=
 =?utf-8?B?Z1pCYzN2eHdabWJEOTJlMWc2YU8wR1V5ZVkrR0ZSR2N2eW1MWU5ldnBScnph?=
 =?utf-8?B?S1N5TWROK2lLa1VXUVRWS0JwbHVSV05sVVRwSGpkOG42WGh2M0QvdDFDZXBz?=
 =?utf-8?B?TXJmS1oyWnlYUk93OFlycUdLNitxT09Ha0tvRjBHbnVGTnBiaDV0NE10Zk9X?=
 =?utf-8?B?SStFZ3VvL2pQTXZFMlNWQUwyT09rRkhUWVMxbmNrN1NaYlRjMWxkQzdBbU41?=
 =?utf-8?B?SUlhVXBwVTI3TnRyejIyblZXd0IxQ3djekJTM3B5cTh1M1hteWZieG53ZnRF?=
 =?utf-8?B?RWE0QitJZ0FKYkN2dXNWMzNTSTMxaExNalRod1JGV1NzUHEzR2kyQzBCTFVY?=
 =?utf-8?B?ckw0ZXNmSUtUN3hiSW5EZm81YkZZSnRtVkpyYlUwQ3ZBL0xRU1pzRndwU05O?=
 =?utf-8?B?ajNRZ0x4ODNMOFJjcTBkbVo0cW9oZUxDTm5qc3hpM01qNHV2Njh6SUQ1MDF1?=
 =?utf-8?B?a0IxZlJYQ09nelBDZzhITTlVcnAxOEkrV3J6WkNmRkoyTzJWcG1PZG1WTkVY?=
 =?utf-8?B?cE90MlVncUdJNE16THlrTkJaY2x3YU1CRHNsWDFNdU56eXgvbnBYaU0rR0NI?=
 =?utf-8?B?clR2SzB0Yk9sa3ZwNzREZ0liVXd5TUluYnM3azYrNFBpV08rd2liVjNSbDEw?=
 =?utf-8?B?R21SQ3dickNGVGM3eEJwZ3B4MWtveDZkZzVXa2JIZmNnNHJRRWFXK0RJT0tw?=
 =?utf-8?B?MjZUWDV4Vk44QUI3Y1VtMzRDNWVGMUwrL2RVOFJhRDBZakpaSmJTaFlFS3dM?=
 =?utf-8?B?VUkrdHhtVXoxR3R0TjlSbi9IWG45RlZGaFdQRlNwaFBjd3l0anpRZnY3blFj?=
 =?utf-8?B?SjNnZXJ2WDRBZHVIbzlKVW1NSTgvRHBMc3JxdHRyQUhKWGRnNjhKU2g2WHpP?=
 =?utf-8?B?NEhyTVVveG1pL1BQdlhDOXI2T3daYmhUMmQrcE1TaENQeUtmZzlNOGFyeG85?=
 =?utf-8?B?QlRJU0picXlPSG5zbFZ5NTc4cktwQmE2Mm5MRzVzKzhhTndoMXcxdElaS0xI?=
 =?utf-8?B?QkJJSlR4SlU1TnJIVmRUaEoxSXA1eUV2clJ3NU1XcEJST0d3WXNLeDNTZFhU?=
 =?utf-8?B?eHNId204RmlWNnFwWTJBb3lBMk9XeUplV2tBRXBDVTY2eHhXek5xelRRUU5r?=
 =?utf-8?B?SGl6RVlqWU9NRWlsbGN5alkyK1dMZ28xbE1TY1N1S1NUNUxTVUpyUVVhc2Nn?=
 =?utf-8?B?ZENDUHd1NW1QVGtsUzlPaUZ1L2ZBbG9JQm4zS1Z5SzRpR2NEYVE0b29wc3hC?=
 =?utf-8?B?VkxqbTdHRUxyUnJJQzV3cnFJQ1dTY1JEa0E2MTN2eXFmd3R6MG9HU0Y1Njk5?=
 =?utf-8?B?Ykd3YkRJU3ROSGUrdVA5dUlJVlJzcjZsQ1BrSGxjdEZOZGFNYjdBK1BxbGw0?=
 =?utf-8?B?dTV4UE9kQWQ2SnZGT0NLNWNjVDhXaExvZCsydjZxbS9BSW1ibVNiYkNlTWJx?=
 =?utf-8?B?S29Tczd1K0hMRlZWRmgrLzdxd3pEM3YreXI3NVpMUDArekZLUUxCSklVSTNx?=
 =?utf-8?B?RmRWTC8rQnVrOXJlRWFINjFLaFB1cTM0cURYTm13a0lWa005OXcwUUlHbTdK?=
 =?utf-8?B?NDczQ3NYVURHL21abXNiSG11aGZwWnY1MVBGTy9CaGdoRTF5cmFFMkFySmt3?=
 =?utf-8?B?QUY0aVlscXh1akptL0kzKzAweEUzSDU3VGtiNHlZZXE4ZnJOWGlQUmdRRFd0?=
 =?utf-8?B?TDg0cGxLVEFrOVJJUTZTeE5EWkdXenh3cU5vL1dKM2RJOWhKeUxRaitTeUVn?=
 =?utf-8?B?cnhxdW1CRWtQSkJKS2hCdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkhGV0RYd1VEOGNmMEZXcWQ1dHJVS0FHRG5ETTY1K3FlYjZWNnhmanZaaXBO?=
 =?utf-8?B?Mng5WlpIZURkOE1HdFBSMkJVdTJmMnFjMlc3Vkd1cEY3Mzd1ejhPU0xmSEcw?=
 =?utf-8?B?c0JzUjVxaFYwcGowTTVuS3FPUFg5bVY5WUxCSG5la0FxSUJMU3drY0ZXMVU5?=
 =?utf-8?B?enNpUGtoNXRUQmVrNDhCUk5IK0JkS2llRCtNaWNHSDdVYzBtN1hRWnVyYkk2?=
 =?utf-8?B?eTZwTWk5UDh2WDlkaGwyZkNFRks4dGQ1d0YzekxGdmtrSDlyYWpla2RhTkxH?=
 =?utf-8?B?Q090TytRd2w0aHYwaTRRaEJMTzhsNk1jaEpYUlY3STR5Q2pyYzhMZG5Dcm83?=
 =?utf-8?B?RmRoR2t6VDdERDUyRDhUUFhoczRYTCtVamxtN2NZTzhxQU5UVFN3Y25MNStl?=
 =?utf-8?B?bUMzQ0JZaHhBWGRxY1lNUmx1TDN5Q1g3ckx2OE9nUkhMZjVrZUJPa2ZqcTNJ?=
 =?utf-8?B?RXRZSkp3RG96a05BdExBUmtwSnNQcFBjVTQ5cVZRVnpvTmxkVkZqZVlrQS9Y?=
 =?utf-8?B?QzhnRmJYNnNEZHRKRG9nQzhna0FneWpVSHBPWXJoLzdoclFYd285Sk5kK1Fi?=
 =?utf-8?B?M001TWlHRndGQ3hScnJqS3U1TGVrRTh1TERMYzh1QmVVS3p4dVZXcSswcGJr?=
 =?utf-8?B?cGtocTZ5SUJUUVBhMjN0YW53djhIQVQ1b3I0VGZYdk5oQ3dwR0p5Q2ZweUx4?=
 =?utf-8?B?aDBoVFU3RnhyVkg1QzVkNEtEeGhJVGt6VER6cStPV0g4Y3dTdFlXdzVGSldK?=
 =?utf-8?B?QWhEU256aGZ5UkhRc2t3R2pyY0pETzhyUmZFRTlZRlUxcTd1OEJHTURNNUlD?=
 =?utf-8?B?RDNoQWZHZEhPT2NLZXUweS9aVkdReDBleEJ3VVl4QzhjN0VNQ1N5RWNrbGpQ?=
 =?utf-8?B?MHhCZ1hJdXhaRmFmSDVhKzU3REpOeFlWWk5IVlJmR2NxYjBDdmpxZ3JSNFUx?=
 =?utf-8?B?cU9oQi9VSHBnVktsQXZTRFBjVG9NcXY2eG9WNktwSW9MeWx5VkwyVzNTVVBl?=
 =?utf-8?B?NVBURSsyT3dKMjgxV3pSUjJZVktFSTRnamNUTXFBOCtETWpMaDVoazllK3I4?=
 =?utf-8?B?bDgybWFlR2tMbmVzT21WSFMvY0lkUG9WdDRxU2hCeXVtTElESFVXa3kvN3hk?=
 =?utf-8?B?ZVYvOGExWUdUeTllQ3RxYlZTOU5ycW9OeFM5bVhZMURkSzZGcENvSHk0d1RS?=
 =?utf-8?B?aThLYVBvWEVUZEJxVTdzTGtNK2t4aGgvcGhYK1VqT3lsRC9hRm1yZ2NCbDE0?=
 =?utf-8?B?RWlFNjkxUSt3VU9aclRBSlRmS3NBcnpLc01KQTFUTS9ZQ3ljV09KSTNGWUZT?=
 =?utf-8?B?Rjd4RmZLMUsvNFhyeHFxbXRUdkNPbjByRk1KMFg1VDVEVkV2Kys0Q0NxUGo3?=
 =?utf-8?B?eCtSa1diWjZENWE3OW5YY0FzVzdsNGdrR0NKa29uTEhFU2ROL29sbzhEcWJv?=
 =?utf-8?B?MjNqKzd3dURqZy83RWdha09BMjd6VXBUMGx4dk1iaFVlYkJha1VoUjRyQzRs?=
 =?utf-8?B?ODBRbVl3YTFRM3REMDJyZE5CaFZaaml4NXR1dkF6dUoreDl1eURTclZuT2dT?=
 =?utf-8?B?dVpFVGJNOXhFMmxWOW4vTnp3TDA4M2pDeE80T1dIOWtJNzVpZVNma3VwZTJ4?=
 =?utf-8?B?Y3RrNitUS1EzNkFiUEJYVCtFUldZalFWQTJnelVBQ0I4OGdYMnBLR1poWndu?=
 =?utf-8?B?OUEzVjJoeUdtdHZ1U21DNUVIWW9NZU9keWNiOCtPMklsL1kxL3d5aDFBSTVX?=
 =?utf-8?B?VXA4eDdmR09wcGxKVWRkWG1aemVtMGxrSFcyeTlMdnRXOHF4ZW5DMUlPMUdF?=
 =?utf-8?B?L3dKeWJPTTR6Mk5KMmllWXZFdWI1bzBMS09QZmhZODgwbDlhR1BhZjhqVVNR?=
 =?utf-8?B?V0U4RnpoVkp3YTB2cFFlQTQyOG8zVklUaHhLUUtWYWtRS2FvMjhLcU5NNnVQ?=
 =?utf-8?B?M3I5OWM1bldtMHAwcVFNcU1URlF2YmZZMDFOMStqTGlHKzhRWWJSUWhMb2hS?=
 =?utf-8?B?NFdKWXJuckY4VVlRbU1PYnlvRlJPMjF5ZkpGVUVpYkxOM3owOWtkcEg3T2Ns?=
 =?utf-8?B?Yi9UbmdsVUxMdWhiSmlPYmp0UW85RmhXN0svWS9Ccmt6K3lZNkVjbTRRV0lB?=
 =?utf-8?B?TDJCaVZXWG1IQTJFdSs4enR3bEREUEhQZmkrSlVPTFdISFhSYndRTSt5S2w0?=
 =?utf-8?Q?6NFqZzv8I33ouyQwKxW42FKDyfBq/74wsqUscXVlbNSi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <838163053C572143AD41C70B817959BE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0353a0a-c443-440c-5b48-08dcec1b7b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:43:15.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1q/8m5fhsLY0ARHWE6Bu1oIwmDLOi1+5f63RBDHRzF+McIn7ipDCiCTq4bCPlCeSYbslWKFyDj7zHbyWqU7gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

T24gMTAvMTIvMjQgMDQ6MTEsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IFRlc3QgdGhlIE5WTWUgcmVz
ZXJ2YXRpb24gZmVhdHVyZSwgaW5jbHVkaW5nIHJlZ2lzdGVyLCBhY3F1aXJlLA0KPiByZWxlYXNl
IGFuZCByZXBvcnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEd1aXhpbiBMaXUgPGthbmllQGxpbnV4
LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9udm1lLzA1NCAgICAgfCAgOTkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICB0ZXN0cy9udm1lLzA1NC5v
dXQgfCAxMDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMDcgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy9udm1lLzA1NA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9udm1lLzA1
NC5vdXQNCj4NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvMDU0IGIvdGVzdHMvbnZtZS8wNTQN
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uZjM1MmM3Mw0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL252bWUvMDU0DQo+IEBAIC0wLDAgKzEsOTkgQEANCj4g
KyMhL2Jpbi9iYXNoDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPiAr
IyBDb3B5cmlnaHQgKEMpIDIwMjQgR3VpeGluIExpdQ0KPiArIyBDb3B5cmlnaHQgKEMpIDIwMjQg
QWxpYmFiYSBHcm91cC4NCj4gKyMNCj4gKyMgVGVzdCB0aGUgTlZNZSByZXNlcnZhdGlvbiBmZWF0
dXJlDQo+ICsjDQo+ICsuIHRlc3RzL252bWUvcmMNCj4gKw0KPiArREVTQ1JJUFRJT049IlRlc3Qg
dGhlIE5WTWUgcmVzZXJ2YXRpb24gZmVhdHVyZSINCj4gK1FVSUNLPTENCj4gK252bWVfdHJ0eXBl
PSJsb29wIg0KPiArDQo+ICtyZXF1aXJlcygpIHsNCj4gKwlfbnZtZV9yZXF1aXJlcw0KPiArfQ0K
PiArDQo+ICtyZXN2X3JlcG9ydCgpIHsNCj4gKwlsb2NhbCBudm1lZGV2PSQxDQo+ICsJbG9jYWwg
cmVwb3J0X2FyZz0kMg0KPiArDQo+ICsJbnZtZSByZXN2LXJlcG9ydCAiL2Rldi8ke252bWVkZXZ9
bjEiICIke3JlcG9ydF9hcmd9IiB8IGdyZXAgLXYgImhvc3RpZCINCj4gK30NCj4gKw0KPiArdGVz
dF9yZXN2KCkgew0KPiArCWxvY2FsIG52bWVkZXY9JDENCj4gKwlsb2NhbCByZXBvcnRfYXJnPSIt
LWNkdzExPTEiDQo+ICsNCj4gKwlpZiBudm1lIHJlc3YtcmVwb3J0IC0taGVscCAyPiYxIHwgZ3Jl
cCAtLSAnLS1lZHMnID4gL2Rldi9udWxsOyB0aGVuDQo+ICsJCXJlcG9ydF9hcmc9Ii0tZWRzIg0K
PiArCWZpDQo+ICsNCj4gKwllY2hvICJSZWdpc3RlciINCj4gKwlyZXN2X3JlcG9ydCAiJHtudm1l
ZGV2fSIgIiR7cmVwb3J0X2FyZ30iDQo+ICsJbnZtZSByZXN2LXJlZ2lzdGVyICIvZGV2LyR7bnZt
ZWRldn1uMSIgLS1ucmtleT00IC0tcnJlZ2E9MA0KPiArCXJlc3ZfcmVwb3J0ICIke252bWVkZXZ9
IiAiJHtyZXBvcnRfYXJnfSINCj4gKw0KPiArCWVjaG8gIlJlcGxhY2UiDQo+ICsJbnZtZSByZXN2
LXJlZ2lzdGVyICIvZGV2LyR7bnZtZWRldn1uMSIgLS1jcmtleT00IC0tbnJrZXk9NSAtLXJyZWdh
PTINCj4gKwlyZXN2X3JlcG9ydCAiJHtudm1lZGV2fSIgIiR7cmVwb3J0X2FyZ30iDQo+ICsNCj4g
KwllY2hvICJVbnJlZ2lzdGVyIg0KPiArCW52bWUgcmVzdi1yZWdpc3RlciAiL2Rldi8ke252bWVk
ZXZ9bjEiIC0tY3JrZXk9NSAtLXJyZWdhPTENCj4gKwlyZXN2X3JlcG9ydCAiJHtudm1lZGV2fSIg
IiR7cmVwb3J0X2FyZ30iDQo+ICsNCj4gKwllY2hvICJBY3F1aXJlIg0KPiArCW52bWUgcmVzdi1y
ZWdpc3RlciAiL2Rldi8ke252bWVkZXZ9bjEiIC0tbnJrZXk9NCAtLXJyZWdhPTANCj4gKwludm1l
IHJlc3YtYWNxdWlyZSAiL2Rldi8ke252bWVkZXZ9bjEiIC0tY3JrZXk9NCAtLXJ0eXBlPTEgLS1y
YWNxYT0wDQo+ICsJcmVzdl9yZXBvcnQgIiR7bnZtZWRldn0iICIke3JlcG9ydF9hcmd9Ig0KPiAr
DQo+ICsJZWNobyAiUHJlZW1wdCINCj4gKwludm1lIHJlc3YtYWNxdWlyZSAiL2Rldi8ke252bWVk
ZXZ9bjEiIC0tY3JrZXk9NCAtLXJ0eXBlPTIgLS1yYWNxYT0xDQo+ICsJcmVzdl9yZXBvcnQgIiR7
bnZtZWRldn0iICIke3JlcG9ydF9hcmd9Ig0KPiArDQo+ICsJZWNobyAiUmVsZWFzZSINCj4gKwlu
dm1lIHJlc3YtcmVsZWFzZSAiL2Rldi8ke252bWVkZXZ9bjEiIC0tY3JrZXk9NCAtLXJ0eXBlPTIg
LS1ycmVsYT0wDQo+ICsJcmVzdl9yZXBvcnQgIiR7bnZtZWRldn0iICIke3JlcG9ydF9hcmd9Ig0K
PiArDQo+ICsJZWNobyAiQ2xlYXIiDQo+ICsJbnZtZSByZXN2LXJlZ2lzdGVyICIvZGV2LyR7bnZt
ZWRldn1uMSIgLS1ucmtleT00IC0tcnJlZ2E9MA0KPiArCW52bWUgcmVzdi1hY3F1aXJlICIvZGV2
LyR7bnZtZWRldn1uMSIgLS1jcmtleT00IC0tcnR5cGU9MSAtLXJhY3FhPTANCj4gKwlyZXN2X3Jl
cG9ydCAiJHtudm1lZGV2fSIgIiR7cmVwb3J0X2FyZ30iDQo+ICsJbnZtZSByZXN2LXJlbGVhc2Ug
Ii9kZXYvJHtudm1lZGV2fW4xIiAtLWNya2V5PTQgLS1ycmVsYT0xDQo+ICt9DQo+ICsNCj4gKw0K
DQptYWtlIGl0IGVhc2llciB0byBkZWJ1ZyB0b3RhbGx5IHVudGVzdGVkIDotDQoNCnRlc3RfcmVz
digpIHsNCiDCoMKgwqDCoMKgwqDCoCBsb2NhbCBudm1lZGV2PSQxDQogwqDCoMKgwqDCoMKgwqAg
bG9jYWwgcmVwb3J0X2FyZz0iLS1jZHcxMT0xIg0KIMKgwqDCoMKgwqDCoMKgIHRlc3RfZGV2PSIv
ZGV2LyR7bnZtZWRldn1uMSINCg0KIMKgwqDCoMKgwqDCoMKgIGlmIG52bWUgcmVzdi1yZXBvcnQg
LS1oZWxwIDI+JjEgfCBncmVwIC0tICctLWVkcycgPiAvZGV2L251bGw7IHRoZW4NCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVwb3J0X2FyZz0iLS1lZHMiDQogwqDCoMKgwqDCoMKg
wqAgZmkNCg0KIMKgwqDCoMKgwqDCoMKgIGVjaG8gIlJlZ2lzdGVyIg0KIMKgwqDCoMKgwqDCoMKg
IHJlc3ZfcmVwb3J0ICIke252bWVkZXZ9IiAiJHtyZXBvcnRfYXJnfSINCiDCoMKgwqDCoMKgwqDC
oCBudm1lIHJlc3YtcmVnaXN0ZXIgIiR7dGVzdF9kZXZ9IiAtLW5ya2V5PTQgLS1ycmVnYT0wDQog
wqDCoMKgwqDCoMKgwqAgcmVzdl9yZXBvcnQgIiR7bnZtZWRldn0iICIke3JlcG9ydF9hcmd9Ig0K
DQogwqDCoMKgwqDCoMKgwqAgZWNobyAiUmVwbGFjZSINCiDCoMKgwqDCoMKgwqDCoCBudm1lIHJl
c3YtcmVnaXN0ZXIgIiR7dGVzdF9kZXZ9IiAtLWNya2V5PTQgLS1ucmtleT01IC0tcnJlZ2E9Mg0K
IMKgwqDCoMKgwqDCoMKgIHJlc3ZfcmVwb3J0ICIke252bWVkZXZ9IiAiJHtyZXBvcnRfYXJnfSIN
Cg0KIMKgwqDCoMKgwqDCoMKgIGVjaG8gIlVucmVnaXN0ZXIiDQogwqDCoMKgwqDCoMKgwqAgbnZt
ZSByZXN2LXJlZ2lzdGVyICIke3Rlc3RfZGV2fSIgLS1jcmtleT01IC0tcnJlZ2E9MQ0KIMKgwqDC
oMKgwqDCoMKgIHJlc3ZfcmVwb3J0ICIke252bWVkZXZ9IiAiJHtyZXBvcnRfYXJnfSINCg0KIMKg
wqDCoMKgwqDCoMKgIGVjaG8gIkFjcXVpcmUiDQogwqDCoMKgwqDCoMKgwqAgbnZtZSByZXN2LXJl
Z2lzdGVyICIke3Rlc3RfZGV2fSIgLS1ucmtleT00IC0tcnJlZ2E9MA0KIMKgwqDCoMKgwqDCoMKg
IG52bWUgcmVzdi1hY3F1aXJlICIke3Rlc3RfZGV2fSIgLS1jcmtleT00IC0tcnR5cGU9MSAtLXJh
Y3FhPTANCiDCoMKgwqDCoMKgwqDCoCByZXN2X3JlcG9ydCAiJHtudm1lZGV2fSIgIiR7cmVwb3J0
X2FyZ30iDQoNCiDCoMKgwqDCoMKgwqDCoCBlY2hvICJQcmVlbXB0Ig0KIMKgwqDCoMKgwqDCoMKg
IG52bWUgcmVzdi1hY3F1aXJlICIke3Rlc3RfZGV2fSIgLS1jcmtleT00IC0tcnR5cGU9MiAtLXJh
Y3FhPTENCiDCoMKgwqDCoMKgwqDCoCByZXN2X3JlcG9ydCAiJHtudm1lZGV2fSIgIiR7cmVwb3J0
X2FyZ30iDQoNCiDCoMKgwqDCoMKgwqDCoCBlY2hvICJSZWxlYXNlIg0KIMKgwqDCoMKgwqDCoMKg
IG52bWUgcmVzdi1yZWxlYXNlICIke3Rlc3RfZGV2fSIgLS1jcmtleT00IC0tcnR5cGU9MiAtLXJy
ZWxhPTANCiDCoMKgwqDCoMKgwqDCoCByZXN2X3JlcG9ydCAiJHtudm1lZGV2fSIgIiR7cmVwb3J0
X2FyZ30iDQoNCiDCoMKgwqDCoMKgwqDCoCBlY2hvICJDbGVhciINCiDCoMKgwqDCoMKgwqDCoCBu
dm1lIHJlc3YtcmVnaXN0ZXIgIiR7dGVzdF9kZXZ9IiAtLW5ya2V5PTQgLS1ycmVnYT0wDQogwqDC
oMKgwqDCoMKgwqAgbnZtZSByZXN2LWFjcXVpcmUgIiR7dGVzdF9kZXZ9IiAtLWNya2V5PTQgLS1y
dHlwZT0xIC0tcmFjcWE9MA0KIMKgwqDCoMKgwqDCoMKgIHJlc3ZfcmVwb3J0ICIke252bWVkZXZ9
IiAiJHtyZXBvcnRfYXJnfSINCiDCoMKgwqDCoMKgwqDCoCBudm1lIHJlc3YtcmVsZWFzZSAiJHt0
ZXN0X2Rldn0iIC0tY3JrZXk9NCAtLXJyZWxhPTENCn0NCg0KDQppcnJlc3BlY3RpdmUgb2YgdGhh
dCBsb29rcyBnb29kIDotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
