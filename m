Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2074.outbound.protection.outlook.com [40.92.45.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222133DD
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393655; cv=fail; b=WPY4gZ0KLca9DhJuFTdVbPMN6BeFtukbAvwxvDO9NcO9wfS+LWTWjyH1DkuCrUeZggYwHVfaVn56oh2Spu6PQQ74FGeFPJ862SaxTcKAzjSBeFHGk1O0DpqTHF7G0FyW/NfLrdleiBn6QEo1pFjtwsC5Yqpfkh3MCjQ4bQOyTZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393655; c=relaxed/simple;
	bh=Dd4NNcYqG4Tv/MIgHL1lxWy3hQmr6qfPrSPndWWurPM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QDMmw8yyO7esprcvqmFoHS9UW/0nwqgFku5aegGq2enGSr1zMwQk3x54HYDnWGCm0yVB4bvzPIZ8D5cw8O930vPIXiRu3CKhsSasf5ZQQfkSABOZ8turlbnj/nfdH+JGM9Hv/aRUmHAVGho7k5VQs9Fmq9CdMzfLj3Ty0BZCrQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=TbI4vw9D; arc=fail smtp.client-ip=40.92.45.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="TbI4vw9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2vvuZJ9w3tEXUfQsYSh4go25C9/6tuQwD0DPQRft6ZVN9XFly16Maqwcz3MRMNYd3CXpM7xQbmBM5Xs+XN/g0JD7s9AQFOX34F395nEZx1dOx45XOfRIXK2LB6jtPJ5d23BbSVk7ytBHnPmjSvQlpS+2oDoHRqn8qrgQuJDhMK38erY3ECOrGCg+wvvqWIx+N7OMizBH8burt8SAYUlhoptRGRbhVzf08PLjV5GQBd/Fl8sWD8g3e8Tjg6c5tD3kOi0SddOYho+IdM0EUO//rRxD/0+vJsrxZh4VZ/btLUkGRI6g2lpmQAY0awKthcjEJYD3WG/q4qxjoHQu/sJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dd4NNcYqG4Tv/MIgHL1lxWy3hQmr6qfPrSPndWWurPM=;
 b=e8YqtM7MuWoCeOcOgpHajoYnpoTQn8mDf/+71CtbHXHV0DbLiIOgSfMHG++Mo7ozSHvxXIELltqDcOt0ju5Oc1bFLD2Zc/plP1ZqvzHNUg0hCHpn+T3hpqZfrR/6FcgNMeZUE5y9i+gybea0SCI2+WwbPFwF3LJ0FEZDbA10i03M6tbqBhsfbXIrrUYYzL1Pbq2/dHG22ltSNj1xkLauVQfzyi3fLOqVrJrz/Bh0QdNETg0zDwz0Oq1eiK0Q8Sf4oCAhiKsa/u+a1sWvymfYvVNwKNMuDG+eTc9+/+cEwu9+yjZ3ouxQhHUaIzqEViw9qxoeHCXQbU2bYOGDKbgIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd4NNcYqG4Tv/MIgHL1lxWy3hQmr6qfPrSPndWWurPM=;
 b=TbI4vw9DQTJ3rhZf/vVr8/5FU1F8vKK1YLkuIS9UUCTd3JbHlnZnfjTFwjgePdmtHBdeDeG8xpiBolfkJKgo/VGa6HPui4Bojy+/joELwoShbxoj+YZxX8Ary+b8gi+0iFtc/ncKHkTGoFQUhbSHQjtDQXehmixVXdv6u7uH7OLbAeqaVgajoEJKdFt2wNg+8Tw178KU64WEz9W7qColn/x/IHKM6Efv9RwoO56Fu5jBn54Kg+kaEz/xxNjChzkI9BOBpBZDVDDu0sxMX/NC5QoSoIyub2rnc2lbvbBqedhAaPCuLqAuxY6+EKu+G+SMzF+dOSZbtlth3n4+v9x1Pw==
Received: from CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 09:20:51 +0000
Received: from CY8PR12MB7193.namprd12.prod.outlook.com
 ([fe80::aa62:af09:b5d7:2e45]) by CY8PR12MB7193.namprd12.prod.outlook.com
 ([fe80::aa62:af09:b5d7:2e45%5]) with mapi id 15.20.7698.017; Wed, 26 Jun 2024
 09:20:51 +0000
From: huang wolf <huang_wolf@hotmail.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: hello
Thread-Topic: hello
Thread-Index: AQHax6ojV0kxlxNGZEqQtq66fyRwCw==
Date: Wed, 26 Jun 2024 09:20:51 +0000
Message-ID:
 <CY8PR12MB7193164EACBF3B9F29911BF7F7D62@CY8PR12MB7193.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [JXsr1EiJNMxpyeuF2F0xSJpVRDt+DKO8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7193:EE_|SA3PR12MB9090:EE_
x-ms-office365-filtering-correlation-id: b5b9db14-cdbe-43db-3985-08dc95c14614
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199026|440099026|3412199023|102099032;
x-microsoft-antispam-message-info:
 p8OLIIryaAxJPMjNkPUr/hkCFcuh7HCqBI5edrjmkvepuKRueT++8neABy4ptVB1yOHwckppu7Ox4jyQb2oX4jy8D6+LKB0VdxkP0E30u500n3ScdyKSDjholRTj6ABSjvcgb4d/8z3NgkzHujK9aqEG9cz7IGTXh06PCWTgAzj1MBkYKrvUcK3uvnWsO2rgS5vxOF0uTqS26VfWiJj1AVCAm8XFaYqKi3tVLyq5Fq9PHJJbCmNsrP3MD1YHdxjaIrPUnmRZTkVdH8CD7q82iMaYaydzCvQvDccQBhA9nrtT30CLBaj1RQM/uMj3+Tj3Mo3H62POoaXgzhljVTS5J9tmhbgy6zQH+o7VsXXYyiN7iQ1GZiJhU48QWaQPL497zhvVrMpETO2mUV/CYsRwBiYCPPS/QoP0RZPxZbcCVvsum5Azw5d7+NInFfxpLP0l
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Vk1BNDhabGZuRmNqSVNmVThHc0NhT0xpTnhiQmpraXRMV2ppVmEwQnBEeDN5?=
 =?gb2312?B?OHRBWTUxTjFoWG8xcktMZmhkbWhOV0F5QzlCVjN6Z1ZOTXJXTVUrZXVlS0lZ?=
 =?gb2312?B?K3d2cklMSlZNdlZyVThVTUlhUXhXQlhlWmJ0NjJBVTVvUThKZ0ExTys3OTNM?=
 =?gb2312?B?UjRhVUIwTFh2dXRCZDdiQktobWRSVEQzL2tIa292Wk9NOUl1bkZYQXRDQk40?=
 =?gb2312?B?bGNCM3FNVW5TajBUOWZxa1N4VW5ZUVZaVDFEZUJlMU04bFAzMjZlc1Z5UWY0?=
 =?gb2312?B?K1UzYmNuVmJ5SHJmMmszc1VScVRKOGd4NGRDUHpDbkdXQnRGOE43bFUwWEJh?=
 =?gb2312?B?clpQb2xiQWQ1WnRUcDUrYVlvN3NvVy84UFIwY01Lak9ISzJTaGtHd09PUy96?=
 =?gb2312?B?T1hTNmZXc2hLNnpGUk0yRUJlVHo4QnhVZFRnY3dlNnNQQUpUTlNwR01iaHU3?=
 =?gb2312?B?ZWFycWU3dGRTVHdLcjFSRGc5MnBIVUZiNGVCb1dVSXJTTTJyOG5NeVppc3ZH?=
 =?gb2312?B?T3k3em56SkNKQjM4bFRpbjhPdDcyN0tSK1hpOHF6eWJudE84NVhlZ0J5Y2VV?=
 =?gb2312?B?MXlBcGFOQlg5S0EvT1hEOUllSkxBTUlZMkQ3WDhub0xWY251REJNWjJaZldH?=
 =?gb2312?B?RXA5YmxCSVhRMHBrYjRQWVl1cUVpU0VZQ1FTTDRmV2EzMDhWVzhzU3BSV091?=
 =?gb2312?B?Mzd0RjBzYit1L2kvYmZMRncvQzhQRWF3Y3p2Z1NtNVFKVkdNQnJOVWNzMzJC?=
 =?gb2312?B?ZFkvZzdrUEhLNEZLR05STm5zK25VZ3BsdmdvQ2t3UEsvS0QvaHcrZHhsZjlk?=
 =?gb2312?B?cXJZTDlzVDZsMlVlbWc4ZHRWSDZhRE1xVVRqdjZiYytEYldZSnVzMDVvWGQz?=
 =?gb2312?B?S3RDd1g1RkN3MkYwcUhIc1BlMy9wR0V5RTNrOGdpOHlSYnZjU0plYVJtcDJy?=
 =?gb2312?B?WTBTMSt1R3IrYjl0L042cEY4K09ycE45enN2WDJsam5aZTl0anE4RUdnZml2?=
 =?gb2312?B?L2tONmdLZmpBRm44cHRNUHNZVHJLMG52eXl2L01lTDNlS1U1UFpuUFZESkNW?=
 =?gb2312?B?Rk1aZXJURndNblFGTStBWS9XNVpvYnlQVUxQVGNIYWtZL3k4UVZlVzI4ZlAr?=
 =?gb2312?B?eU5oeWdHblhXUkVPOFdaQ3V4VCtuclRYajN1Y1FTd0VnajN3V29ROE9YSGcy?=
 =?gb2312?B?Y2NVVlVWK01EMVUwN1ZQR1B3VHFTVnk5WXJ0Wnh0VE8rWjExZzJlVHZjaytX?=
 =?gb2312?B?bmtYVU5IUnhFeldGRzhLUTducHZSYXhRSnBRbXhiMmw1UElWTmxPY3FvU1Js?=
 =?gb2312?B?bXdaWXlwazdabVNUQjlTckw1WWdEVWd5dmRMUDFQdFM0L0xRMDZaWFBGY21t?=
 =?gb2312?B?MXIwdm8rMHpMbzZKWjZDVHg3UW5jTHJod3JXNVEyckVFWTZwUUpSaFA1d2xw?=
 =?gb2312?B?bnpyT3ZoZUpTcStvUStCdVdBL2RvdFpCVDBxeTdsQ2hVVzVXcVo1Wkoza25k?=
 =?gb2312?B?U1p6TDdKbU9VN3ZFUkM5Q0FSSVlOOWFtVERHOFpwc0txd3E2QmtxYVl1MjB5?=
 =?gb2312?B?aU5TMHl2c3hlYThJUlBnVG1xWXhVdlE0T0F0eGk5ZU8rMElHRTFYMFlZMG9h?=
 =?gb2312?Q?SvExFWiOAIyVKwJl6/rMMCVTqBaPj1hjzPWbArTHk44g=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b9db14-cdbe-43db-3985-08dc95c14614
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:20:51.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
