Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3F3B27DB
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683416; cv=fail; b=fbceb5NtcAITRcXqtXPhUPtFGjhNZQ9iAI8h9hmrDGec/o9IGmO69DREoD0LfMhIP6hy3IWXe5gWn9frvXcf5Q6AtfL9djoiluRlgXnICxKDOTU9KKeE+y0EYn0Ntya0wzwm6Cu7KY2Y+usOrHGgEOylB6H/85fc9LxQ2tBeDCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683416; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FpMIaZQ4tOp2hmmXw3L2T/xtsWpAysss74EyIJiKEFMy4maLVsCHcymQkr2kiTKyISYuORXrd4gxuMZsUx68wWbBMqpQxvAu0ajjP+IR/w+xbOqV0U7YrRR8EcpJ7dKlT9OaxoQSyQdmUUQaP8qD8IizPshz8mUQq44GBXaBOYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i00XZo+4; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i00XZo+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzZwmPeNLbv6rTbrrtjBQfzmltrLEkeqCnlYLsR6s+hjOHmRpTrmLRYts9Zv/STeA2SJe0CsMXnBg0GfkOKra41khEAm3PdDxSFzMHPUtVTzg+cE80pjXwJXYfLeSqsxlTv2R+laYQeDfimVWoxtATBonEEu3dBTBE32LFt+VuiH4mkz8hZ7Q6wPkDj8Zb1QpDqtF2juwcf2I26Kb0lS2QxntnkIRRsfl0r0DY8GpseTc1WSR61f51o61WvVdCa4N5yIGxI6ZIUAjhTirLBTrilsxON12DS3bPK0Z009YjMC5fND13j+gXwgWZ8+n1yQnQZ/XlJFVBRVsfCNYsWIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=W36H28jAbWl4LeO7G1I4rXGSRcWgLMW2wnH6Cu6GVBnAvwVDxjuSn7Q7cXXryEIhh2GFJ+pwZ5qpiNIWKcAWs59FdInhksdhlA6n2XXT/Ci2N0bPENLQcij0ohzm0TqMPxomAY8oytrgWMTdiSIJeWmxTFT8FTWu/nQQO3VYgqy0B9N1PdlBlwwdgzp7sAh7HZ6cKGUAJ/zrlI7jSA1mc3HNZ81l4FZTrHt07KN37gNVLaaDubpy3cvw601FgKkQ40c2s/MEdL5+h4xcpo0gSCmiCWvLKhnPFT7h2urGQzzyYRV0lNcp3MakrVhJ73voI90KwP3zgZn3kKvA7D6fCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=i00XZo+4wx5pZtSUz2MNEruE7vxkcu6kJMZVgP8u/rDGgBS+2kOVoM4C7FBrIZxI4FRIL3hmR+DQb1E59F+IuqK9mk9Z/1x2mp5KHeHPwOPlGLMaBr5WfxvF6VJOwo3/9drvKsRlrzrlgvrhUhrv5uMIMzfazJRDym8EBAZ3lg4autlclgfIy4ux1GDH/qXKpj898ngG3wC9MwWZT/pymeRPPQT0j/oEO6eRO+1tlVoDEZYy2iWfT7murO+4fzn2qTfiOOz2TtxsHKJ9/rBkuA7YMbM1vv8ZWV16h3shrw8qIj1/esPvMblL4SpPRKnOmRVugvITyJQ1YHkvYM0Bnw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:16:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:16:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v7 13/14] block/mq-deadline: Make the lock context
 annotations compatible with Clang
Thread-Topic: [PATCH v7 13/14] block/mq-deadline: Make the lock context
 annotations compatible with Clang
Thread-Index: AQHc9RXSCx1KPXTjmkau9xu5hWNdfrYwRMQA
Date: Fri, 5 Jun 2026 18:16:46 +0000
Message-ID: <8ca9496f-02ab-48bb-bf43-b20d4b37d8d0@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <3b6e336ced91e27213608ffce205ccd24f4ba285.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <3b6e336ced91e27213608ffce205ccd24f4ba285.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: b62c98bc-eee5-4f97-5432-08dec32e9ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 JWYaj9Ov68iWNYmBnVjk5C7Ybr5f7DLv6e6gJFZiae6wLHvnR6PqUlvyzojE9Tjq1SfpCdMqjJWwSB6Z+4yJcF3ElQh3Ga3u+B13I6LcJUheWyAOgu9THEepFQRdUUHunczfTFBvSriKq7Uac6xPPYzN/xrCOR+dT7rhui4q6Ck/e+KQN9kz5DnVI1kmPd914mAkq3pOwyoN9veQvfpHPAyhb7ln1Vh644ZH3Y6i+cU/TmltygML9nBoWefl8UyjcC4RxXgmnn48uOFuVP2tbdnFiROJugP1g2uRSPXnIEOOfwnfo9rfEWbhzctRm6hR16iqTqzXKGbU4HqIGqd1tEtHh+l5nT7XJGlrkP9PRNcVhAwlbfj5r0i2h9yhJvlRq4xoNJR4CeZNWrkikaJxEudMiuPKGoAwGSI3aQ+hhvjKCgUf0P4SebUXkgOzqKVmqnIKPVS9OVUKTxu7H9Wqa1P9nBvkEhtsS6+dMXNbqPApqDgZwx7xrEzGoNN6dlRADBXtt/9KirE2ium+Tz9loJ104WekHvCHRF/0wemho9GlNJuHILZVFiacUidiA3sT5fcjBkgsp66XHNFK5kQFouUqO2w+Oknpl8D7A37gGsE36jcrSYMUAGT3RGRzHXVgGTIblO48kbWIMT7zBb24kZ0Up1o9gxi38lPQipJTqhzFMLmmLct7u4SHQckPZk/zPTf5k6W6nPgHJ4pXct92znadhY9IGdGARkDTHGTTeGhIDW/Fo4GRGKREI1L/UZEX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWdLYTMyTC9Jcmx0cExhcjJwdnJ6UHVRcUE3cHU3NmQ5YTJsSEhUSFBKK21C?=
 =?utf-8?B?cmxyaCs0MEVoUDErQlIrUVl5SmdhSDB3bnFhQkRlcGlFSXNLYXpzQjBNeGx5?=
 =?utf-8?B?M2ZtM0kzY29HUklJVUtnYTNDc3lYTklqT1dJWjFsaWRrYk1lNWIrMzRDSElT?=
 =?utf-8?B?Z3MwUW5mSUNhZ05yUHFlUUw2NkdQUTJkS1JHSi8rVG9UdTlmaitQVFNpeVY4?=
 =?utf-8?B?NHJQQmdYcVBMellHeW5EQU5wQmF6ejJKOFB5ekFiV0hhNmZxVjJXSEE4M2ty?=
 =?utf-8?B?R21RN3N6OGliUWUxQmFvVmhkWFJ0SkVIYVpHMENUV2d0TVR2dlVHSGNNRWI5?=
 =?utf-8?B?UGtDa2FNaVgvNDlxS253ckNESm16eUFxZ3F4VGlvNXRRdHVBZFB3WkFWYmNX?=
 =?utf-8?B?RnNhUGEzbXh2VmVVdGdDejIzYTQxbWNmWHNWL0xlcVc3Si9LNnNYVG1HQm9D?=
 =?utf-8?B?ZWxMQmlram96YmVpby9YMWNzeTRidEVXZHRaZUQraGxZUkdiTlNSV1IrRDl3?=
 =?utf-8?B?QmFCYXl1M29ybWJlUXppdWJJRzRKbVBjWVBFOGxmdjdyVGc5dFpEM3h6bFg5?=
 =?utf-8?B?bWc3Z1dPU0JYTHYyYkdCZnl3OUtFOWtaek9FbGF6Rzd6Y1pFUU5zRFJzS2Nm?=
 =?utf-8?B?Sk5sYnJ3TUJ4V2NwM3dUaDhrSTJqN2wvNDJ6WUZXQXhHdk9CN3BqMGdBWTUz?=
 =?utf-8?B?b0prUkxUeTgxWVNUOFpGNnVFNUYrZkxtb3poN1RMUFdaa3BHOVhJOTczVzlB?=
 =?utf-8?B?OEorNDBRQzR2MU9qa05BM1UwWC9BV0s2dExjMmh6Z1pQZlpDczZJZk5vb0hU?=
 =?utf-8?B?STh2Wks4cmY3ZTh5TWVIWDJXOVJrak1jRWtGRFF0azdqb1IwenlkcU51Yk5L?=
 =?utf-8?B?UnBwc2E0TzFQbytBZVpEYnhaTEVLSzdBZkNOT21aTVVHMXJIVS9tVnl0MTRJ?=
 =?utf-8?B?cHZvK0w0cUc5RkdKa1U4TDc0TkptSmE2T3NrN3Rtd3BNMVArVXZiWEQvRzJv?=
 =?utf-8?B?M2RvMjFXdTlJWDEybEJPYm5VSnE3QWdUbUZ6TlhpMy9MNmpJUjlIRHJYRG5a?=
 =?utf-8?B?b21XUmdXODVCdDJlRVZUZEVJZHhWemdjMUFLOUEvem9td0wyM2RDVG5JaVVz?=
 =?utf-8?B?Qy9NdXRmRGhEd09KSnRIaEk1WVNrMWJLaWRMb0Z0eGVvd0FYOXN2UWpxZGlU?=
 =?utf-8?B?SVcrWEp0a1RDV3pjSnBLeDI3dFJmWmRGYlU2RG92Q0Z3bktWblFRUUFxUlhK?=
 =?utf-8?B?MU5tYlZ2SnpyRlBkNlBNczdMMXJXdWFtYnlKYnNtQUdOL0JvMXN4Z3pnL1kv?=
 =?utf-8?B?TU9vNHBBbkgxTFprUXV5dEFMeXd1OFF1RG05RkFUU0htMWZIT1NkMGp3VW1n?=
 =?utf-8?B?M0RzMUhiMUF6NktrZ1N5RnFrcDdLeWNJWENTVjJUa09WRXhXUE5ob3Y2N0pr?=
 =?utf-8?B?UjlyQ0JYYUZyS1JwTjMyRUxJZmRiMG9FTmhTKzY5d21uV3FjM0NoNXNFMVEr?=
 =?utf-8?B?bFp6bXU4VWpQdHFvVHhkN2FJVXZxeVN3TWZIamVaRENCdVFBb1kvMjJRdXVJ?=
 =?utf-8?B?MFRhRVRPS3BQK0RDT3pxL0lBTjZFV2diR1lINWdyQlMydVRTdUpxSTJCbFVV?=
 =?utf-8?B?RkRGbG9UVGxmRG9KRVo5dzAxalNYMGFPdlhIbWJ1YWl2c29QY1BHUXdoM3F6?=
 =?utf-8?B?Ujk0aTBrVDdOeVl0V1I2N1EySUh2NTYyTDIrUlRLN3V0WFVkbitFRkgwa3c2?=
 =?utf-8?B?TGtLRFdSUHhuZTVVZjhaQ2RpUmgvdHdJc0cybVIxcmRPc21XQjY1ZDBrZW5X?=
 =?utf-8?B?QmVOTHpuaTd2a1p3VitJNkpVdXVxZ2sxSVVnSUJaeWtKNlZ4Snc4ZlpRa0Jo?=
 =?utf-8?B?TFpTOThIOWJNREhtK0lYdC96a2tyWDg1cDRRZWdBbFk5OHp1dFJoY1BFdDMw?=
 =?utf-8?B?dTkrV2pkT2dMbEt3eFJoWStyM1MwVlhDeGRFUXEwMWx6Q3lQKzhiOXJKZXVv?=
 =?utf-8?B?cmx2bUpmMTdwb01mYWpyWEJCR2xrZitlbElLNFVVMThHdGpmT2RKcXQrL3h4?=
 =?utf-8?B?Ti9zdHRtM0RIZHduMEpzaXBIV25wRmhnSHQ5azdDMVl3eFhwYTA0MCtjeUVI?=
 =?utf-8?B?VUR0bTJBK2VIUjVNMCthV1NKN0grY3JlYjVGSTI1VzNLOEF1RWpMWGgwZGZz?=
 =?utf-8?B?ajRYeStTejBsR2M2bTgrN0czSysvWVRUeHNTL2pmSG9JcmhaVnZwcSs0U2pT?=
 =?utf-8?B?dFY0UzdyQmxyb2pIWG12VU5QZXlCaXJ6M0JSUWtqNEdTK1Y1OEc1TkppalB3?=
 =?utf-8?B?S1p3T3FpSkxOWTEvUC84b3FLbklva3IwNTdMa0xpSUhzU0FLYllpUk81RGp5?=
 =?utf-8?Q?rF/jlBlrjWLaLLaXAjmVxTWXLiufgPvd4ZYOXAwIbqfcj?=
x-ms-exchange-antispam-messagedata-1: c1mN21C/ESI3eQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE0931240D22EA43866A3B357B3F66CD@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b62c98bc-eee5-4f97-5432-08dec32e9ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:16:46.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qo5w/pIYF3IaZSfv2FtkHSJUbBpvugEpltGBvhAzBVODD2dw/+wMELP/N3BNXlK3uRJqtbDge587wYLj1Jp/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
