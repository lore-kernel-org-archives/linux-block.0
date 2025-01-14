Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1EF8BF8
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815579; cv=fail; b=iGYnl5algOoIlt6ZdfsYn9mCspRe9jKm4+T/TeCEMP5ax4jV2nxri9KI366mIQwHVqDbXfTVl5yvYl4yTBw3z2QR6kSFbTRCGR78LXKIFCt32gmrWnNqYClDOXVaUbgesrxtm3N4XZXStXR4DlFbWTvmeqj+FYsN41RMTmzX4Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815579; c=relaxed/simple;
	bh=T3G9yIZ9JFCNgBGsQEf2KYFXQ95OFeHCv67bojdUXBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNcdTsjlxCGwUbEk8cUx1WHWHkEXfpqQ+zZgJ4Cu9xQurJ7Q3EI7Iylu3GZv4XR6vLKLCFpXfCx/TybMfOCSOd2QdWGF16t3rYwyp7G3qMaZOG4UiUky7s9VV+QV3Y+SQ0dt6CuoMeZNTV/iysy60c9qI0MUDShqZOWev3WSOpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vo5F2aWl; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vo5F2aWl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl7kwWulETOZwWG2PhYaMQFe6SW6hiuZ7D+lfhOYhVMt5c9Tgg55C4Z30Awow8wS+OCxAmPq7wURL+rtHbaTd7J1E6uRIzileD1UFXD6PO76T6nDQviMlMqGqQ3GLLLhM4XHoocSGzUWt0rO277HMMU5G78zQufzxCG9Dk5yvXaiegS0XwQXY6mXn6EHU8vVuJKnErY3JxvRKruDW/2hGuUMytW5A6NXXGvVz6atHJ4McOfjQBK2aa4EPJC8xE09O+aq6uEQBM5bhJw7GCwQeq802Cw2y194JrhU6EXrqkI2Z6T0RxrQ/o+mcQEbV81lUYNPY8aT4fNXj4rEdKEwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3G9yIZ9JFCNgBGsQEf2KYFXQ95OFeHCv67bojdUXBo=;
 b=iXUa/PPxRhBD7jzgeu1lVzYCh/iNYjaaTGxrszz8jBhI9xSx0EioNqFfa1fh+cE8gJqK8CMsZc51/L6EDp17rDUbzqAIUSFzu4IQUC7hdwEAA3pg7Ejhh6MJ6e2jsxCGS6FNULHZCBUiTyIe56W6z3W7lv4yR6MKTKUlCuSzyDrMtBmpYjc93caBQy0VGXP3CL/sJVuVzPrl7SqoDwV4V6FtSKEH6s2rABOLgkPxTZzMRd6u74Dg/uvyj57nVBnY+kpVYw2Rl82U9kWfwnbGXKN+8qxBKVcPLNOcgpC4glYMEJiCQN0jWFIhwNLdD9WDpk7a0ETlW751A/h0tINa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3G9yIZ9JFCNgBGsQEf2KYFXQ95OFeHCv67bojdUXBo=;
 b=Vo5F2aWlC00z+QHXm0wp/mv5KJ8LWArwgfoN82uKztuEG8284SlLYNrNSD5uWn/pPrFwCuC9bgerGKRhWR/OO1sOrIAbIXIJvTo3zFQgcKffzq9H5vb8l1s90jolG1d4RRQ+mz9TQGq65ynVchbm2YBOM6P2XfS/mC+hdiP34jFBPFrmi0OkIQJstmWLVpox7hK8ZxLewL81DgP1nAkSj9weat8xF+aLHd/spavhXJf1joqYpBKuHMT9AP+HzaeLcWmedb01nR6hKBuY3P2DXeJqzf0PKJIgfmJetXQk32ND9mhZRe1v3j0dCVg2PXgu049hxZDpXyI4yNf9FUCRzQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 00:46:14 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 00:46:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 2/2] blk-mq: Move more error handling into
 blk_mq_submit_bio()
Thread-Topic: [PATCH v3 2/2] blk-mq: Move more error handling into
 blk_mq_submit_bio()
Thread-Index: AQHbUZMZ9Dnfg9jsPUu3c3RlV0FZdLMVmEWA
Date: Tue, 14 Jan 2025 00:46:14 +0000
Message-ID: <cf037a76-3f77-4e47-bec4-8df34c225c58@nvidia.com>
References: <20241218212246.1073149-1-bvanassche@acm.org>
 <20241218212246.1073149-3-bvanassche@acm.org>
In-Reply-To: <20241218212246.1073149-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4047:EE_
x-ms-office365-filtering-correlation-id: 005b00bd-d02c-465d-96e8-08dd3434d92d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlBLZkNObkNXd293cTB2M011RmlNWGFYWWlvY1A0YjRXNzdVWEVMZC9qdjRI?=
 =?utf-8?B?dm80RnV6S0pHWldRMlBscHIyZHZySDB4a0h6dllxSTc5RG1lSGc4OThlOTlL?=
 =?utf-8?B?dFFDb3FCMlFTbXd3bUpzZGp0WmgycCtPYXk5ZXl6a29DeE5rMWZwa1lndlhr?=
 =?utf-8?B?K2hhRzdIYVJiNmRZMHZBREtWMmFHQmhWY1FaM3NKdlRCYUZhR0F3STJhcnNp?=
 =?utf-8?B?NDF6YnhxbGdzeXBaM0JpeGdXc1pqWHJBb2ZpaUVoRkxhTFBjUEFaY2I1c2J5?=
 =?utf-8?B?Z1NMRzcybHlSVDNrVGNzdGtuSUFoY1BLT25BMDJDQU5hb3VqbkhFeTB5MVlo?=
 =?utf-8?B?TVZOT0pzMXhXQjExVHVlUStJbFIxL2VoamRaeWxST1lOL1VHVDBFQWdmR2Rj?=
 =?utf-8?B?TkJqbUhsdjhOTVNCMytyT1VHZVdZYzBMbUc3OHZQS0tUUXdhNEx1WmFLL0hS?=
 =?utf-8?B?b1lSbGNEV1ZjZFdNNiswVlhRbFRaSE1uczlaVWJzd2Fsc3NHK2hoZ1paWDhU?=
 =?utf-8?B?bW9BTlkvMW5JaGZSUjNKaVE0aHFOOGFkOHA5VEYvZk9JQnRtcnF5alltUnEr?=
 =?utf-8?B?ZXFuTFR0L0JsQTdlZm80d1VLRmVnajhZdzllY2tjc3Q3NUlLcnRmeE5oTmFr?=
 =?utf-8?B?Y2lpaFdPSmpPZHp1akJhTnBhRVJKWUhDaWlOSmJ3NTBVeVppSlE1V09kd1k4?=
 =?utf-8?B?ZHJud3BzaUh2djlmeFJDa3QxUDdEYkdUdjVUTDNWWldqeXF0MWFtMUVmV1pR?=
 =?utf-8?B?MkdNN3pKSjRzVFdyMzRlU2xOb3VJalc1NkYrT0U4N040ek4vM29odFloTWtn?=
 =?utf-8?B?UjZkaGJ5ZUI2eTRtSnVyY3JUU1doNTVONzdrNythTzFBUFVxZGIwQ0ZEcGtZ?=
 =?utf-8?B?L0l3ek5sN0RmdUIvejljZjA1dTRuUHpCOVVpVWZRYUhaM1BnL3YxbVFoK3lY?=
 =?utf-8?B?L29SMXBJOWl3MkF3VWx2Y3h3OWpqV1JtSTVuc3NlRFAxL0JQRlN2Y0h0Ny9u?=
 =?utf-8?B?bG9DaXNtN0FXTVMyUlJrR2V2a21jUDBjd0RVVTh0T2tBM2Y3M1Joalo4RGx1?=
 =?utf-8?B?VWphWmRmYkhqalh4V2o2cllCQ2FXd1lkZjVyL0J2c05RM20wOThtMEJBMEkz?=
 =?utf-8?B?SmQ0QUxsNXVFbmJsR1JJQ2lBVkY5Q3VMVnRKc1oxdUJXa0lNMHVBS1M5MW9s?=
 =?utf-8?B?UlJTb1hwRmRYRms0dm9mcXRRU1dMM1Q4YWd5R1BzdFBlblNKVk1WWTJhNHEx?=
 =?utf-8?B?MVZMbEFNWWdKVGlwR0xuWXVGSDd5bTJXT1ZXcmtFYjk5WjM4a2Z3Zy9NUWl6?=
 =?utf-8?B?TEFoRDdtdGl5Znl1NktxQUM5SGErWHVJNWdZNU5VaENoZkdSb2JvbTFMTDdw?=
 =?utf-8?B?MG5VOWlJd0Y5YnNTSkl4SFdvSlBycU5OTC9zVkpQdk1JUU5Ja2dOMzdpQjBr?=
 =?utf-8?B?akZHNUV0elI5RHBaZ2dTNk5NRjhncUtpM3RzTGFXVEk1Z2YzUVlmdjhlWDl4?=
 =?utf-8?B?V2NEVGpkZitwdXhSVjN4SnZ5VlNVOFdaa1dnR2ZzTjBZc1BCL2kyUG9NQ00y?=
 =?utf-8?B?TDQ1cVZhVktac1JGTXJsZHpTcHlDVkhhelYrdWtPeER3cUZ0ZnE1aHpZY3FR?=
 =?utf-8?B?YjlMVkswM096WUtkYUJsU2xENWE3bWJ0YXhoV3orZ2V3Rmx4dnZCait6aCs5?=
 =?utf-8?B?ZWZBUlNuc2NZb2J0VmlPaFVuekdDWVgvTUphNzhTK1I0RkpPMldqSXNFdlEx?=
 =?utf-8?B?bHFZd2lZWkQ1cmJnTHkxbzU2QzdRUTJ0NzdXLzJhY3F6dzd1S0tES2ZQemlD?=
 =?utf-8?B?dTZJVi9mZzIxWkJjUW03aDdLeWZHSUwyU01kWjFGcEgrNGV0c2VUVlJ6aVdz?=
 =?utf-8?B?S0YzU1YyTkFzQklKdkxTWlJSMjZBSkVhWWF2STQ2Qm4wditiZVJZYzg0QmF1?=
 =?utf-8?Q?yU2V24qrUhR/zJ2PsIxSmNZv2oo4S3IA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVQwMXlWMWRjS2krakhxMk5Uc0NQakwwaUl2NUc2SEZFYnV6WTlQdUNXSXBR?=
 =?utf-8?B?OWRMNk94dy9HRnljSW13TmZKZU9KUElKazIvaTd5dXNTaVN0MXkyYzVCb3VE?=
 =?utf-8?B?Vm5sR05XRXFuRk53Q3dROHRMczhQUUZUTHlHNmdxTGpHU0JMOVViM2lrWWV2?=
 =?utf-8?B?YXB2L01YSEVMekJGRE5aV0pobXROR0tZN2JjTjIrTEpjQ1Q2WDQyd244dlZu?=
 =?utf-8?B?YUVFQkVXSUFXVCtoaHFWaHBLMHgxcWVBSmFtTGtEUGcxYkNwSG9lWE1UQjRC?=
 =?utf-8?B?RFRyaHFIZGpxZHoxTlZienVMTjNSS0xXZ2dGY0tQcERVNFd1MjNqS1d5b1JR?=
 =?utf-8?B?N0NRQ0hqeWJKZFRrVURiWlNqODVlNklNYXNNOHZKVGE0T1ZNSWZINitGZ1ZS?=
 =?utf-8?B?c01aSHc4bUlsMHpTZWt4Q1AyeDNCRzFSVHlCNGE1ZCtBTEJPS1hDVi9Hayt5?=
 =?utf-8?B?K0pUSWRMKzRXYmkyWTlGbVZuM1RtaEhSVzRLdWZwMExrZ2o2MHRQRmdCdTR4?=
 =?utf-8?B?T3NPR0lMWGhlc2ljaVdSQkhTalRHWkNxSUdDUGErbnVqZENUYmt6VXB4V1Qv?=
 =?utf-8?B?Wnd5U3k5Q00ydWI4dDZEaHpwc1ZyeW1MeTliaDZobkNkMnRNNlBsZkwxNHho?=
 =?utf-8?B?S2pnU01lUytWZXBXZXhZejhleVZNZ0RqN1ZQdHpIaUhLWGkyRU13dDRnTmcz?=
 =?utf-8?B?akIxNWFSZG5WUk5iWWRwMXYwc2FOdnVkVlkxQ3NhWWRyaWN5S2VyOTh5TGF0?=
 =?utf-8?B?ZGRYMnNVTUlTOXBIUkp0V1NEKzJJQnNYaTZYZ0RBOWFlSGtIaGpwb25iQ0xP?=
 =?utf-8?B?dVZJcGVocFN3bENNVFJxUnJwdksyS1Y5TGNTRHFZemtUajVOcTMzbEJRNGlu?=
 =?utf-8?B?UzFhMGE0ZEdtOXZXempwNzJiLysyNWdNRHk3MmVYQ3JwUTFHOWJVeDUxTFFj?=
 =?utf-8?B?MktLUnhRZ1VkL0hhQTlxZ2xrSEkzbHlRTHNJcUNyK0ZvYkVyYlE1TlMyU3c5?=
 =?utf-8?B?dlhrbG5nTUxSNjNmNmtJb1NRdUQyWDd3M2lXeWdxMnRxclVNU1BTd1hZSGQ0?=
 =?utf-8?B?dGRlVEh5Z1ZaK1lqSzRPWjZsNTl1TFF6UDEwVER6R2x5Yks5RWVxL3JpUXJO?=
 =?utf-8?B?cStZM3N2ZFo5ZWhCTFpuOVloZnhpcDhJRGdRSUpBMTNNV0RpTlBQc0JPa1dQ?=
 =?utf-8?B?MERKK0lJYVFiNmFENk12VmhZVlVFYXgrcm5UbWV4ekJYUmNXOVZHcHpiWjVU?=
 =?utf-8?B?dFlyV1JwMWkrcGlHN29xOStEaVVSRCtzZHo0NlB5bWZ6dit0dmhnY0hRMDdk?=
 =?utf-8?B?bTI1TkFnTU9saUI5UFVEYmw5WXJSYW9mUXk4SjZsOFArK0tjYW1Zb3Z6SVRZ?=
 =?utf-8?B?R0lKVmZDMFNnVXJWK2g0Z2ZoRVRNTmswaSsrNWpHVlRQWTJnV1J6ZG95ck54?=
 =?utf-8?B?amhGcWZuZndwMFpaUGpSK09CS3BkbC9zS3prcDBDRVNRbG9sQU94TTQyM1RU?=
 =?utf-8?B?cU9OZ21GRHBVa0MzVUI0YWZ0MlhWcmNlOUdEVzRqY2lPQ0dkeXg5T0YyKzJD?=
 =?utf-8?B?QjFaNGFWekE0MjBjcmJBMm40OWdITUd0d09MdlFtQWxOV2syVzhUWXhIL1Vz?=
 =?utf-8?B?NFA5WHRjeWpseHBQVkNiY3JzZ0ZEajNWRXVvSlFGbmhYTnlSNWt3TGkyc3dC?=
 =?utf-8?B?eG5Zb3NqZGl4NGN4Njl0aWpMQ05aMFRDWmpuK3YzSXhlRlZFWUZTWm5BUVhw?=
 =?utf-8?B?cTIrMW5nVkpMNWphb2FxcUJSWlYxM0ZiNWpIZHY1aVhHTkhwMmowcnVxWGJr?=
 =?utf-8?B?czJGdTExNGVrRkxBS2NTTTd0UG00a2xwMGVMeTdsZUhGM0t1N3ZBUi8wcURF?=
 =?utf-8?B?enlkSTF2dUZzeTZJampxVitMTy82Q0N5Mm5xOEdxRkZiMDVsTmZOcEp5TXRI?=
 =?utf-8?B?R3EvL3QwRkkra2Z6eTZBUlBPNUNQNUF5ekxFWTgrbmppVW1sa1J1dzI5R3ZB?=
 =?utf-8?B?RUd4Q1ZoZ3RPQVRYVTUzMVVZUk0yY0ZCOHFTVVl0NGxwc2hyZ2l4RkpKdHYy?=
 =?utf-8?B?WmRxY0RtQXJ3emdnamdUVldXMWtBVU14QVlJV2tCUkx1MFYvUXBUajZRM0cr?=
 =?utf-8?B?bE4rWWNlbFc4ckY5dnl3NFdKRzE5WXo2ams4QXFLeVlydFBQSW1vZzFiak9G?=
 =?utf-8?Q?8y1fAYHNOEnBKJh3oKUdOgdyZ+vMAwQfWNy+8r0gGdtq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF5C50B3210F1B43934C3D90C4C1DAE5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 005b00bd-d02c-465d-96e8-08dd3434d92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 00:46:14.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZKLx/de1Lh8Hqn/iJriDVr2Xb6MuQaAggekpTLfWlMmP2j4NZJiUGee+pF4aKnZFzWOf3nEcw0Rlw4ac7fYpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

T24gMTIvMTgvMjQgMTM6MjIsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gVGhlIGVycm9yIGhh
bmRsaW5nIGNvZGUgaW4gYmxrX21xX2dldF9uZXdfcmVxdWVzdHMoKSBjYW5ub3QgYmUgdW5kZXJz
dG9vZA0KPiB3aXRob3V0IGtub3dpbmcgdGhhdCB0aGlzIGZ1bmN0aW9uIGlzIG9ubHkgY2FsbGVk
IGJ5IGJsa19tcV9zdWJtaXRfYmlvKCkuDQo+IEhlbmNlIG1vdmUgdGhlIGNvZGUgZm9yIGhhbmRs
aW5nIGJsa19tcV9nZXRfbmV3X3JlcXVlc3RzKCkgZmFpbHVyZXMgaW50bw0KPiBibGtfbXFfc3Vi
bWl0X2JpbygpLg0KPg0KPiBDYzogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0K
PiBDYzogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogQmFy
dCBWYW4gQXNzY2hlPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
