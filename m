Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9341798C
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089332; cv=fail; b=W7C1lXc40vPCToSvxvDd7hNMMIkNtehrgOVL3TA49CIFrpBbfkW2K4TU4Hfhnbszg0slaoNpmF0FcWZx1aB/iWMUXTZHZ0NVqprUhCWUfE2xjkwvyonsDDEAfjvMxGkMHahQDai/Qi16Elkw8np5sXu+eGl7d3aXaWq/2CEf+Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089332; c=relaxed/simple;
	bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8r5qJZpOoqQCHdctH0UWX5YyLpQWCjwApGjs9iwKI71jgq5iuhPQXXKCHm/W6cMe5rhA9I0jym4UyZVvxUSb+sM3U816oZ6/gPxl7/k23CXyAoRSiu5wz32yGe5OdQ6vxRM/9JoVJW0+rreSCzYSsWY0cb9yxqjxyWXVlIZYpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lt7TRzWT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YoiN3EcY; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lt7TRzWT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YoiN3EcY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706089330; x=1737625330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=lt7TRzWTIDOnJevYj+fQCYTL9+ZFiGDV6gVL4RhYWIkCNotYgOFBjcLO
   po0Hqiqo736Vh1q1QrPMeHtVW9Q9kLZPfsITMuLOppyZV8fnRiuLeP/z9
   RgIlQVFUpELgU2o4Nw1yGksatQ5GNanDyzYRk1iOewtQD/pVlA+H7ZFZu
   w8xcGv2+iGR+41O2g9NMwpbg77e9D3V4RoKsDXkalXQrqsEd8kc7oHYOd
   wZ6kVrt+F3XfZ/2CdPGZnnU0aPIbF4qu7Ez99kqsth0WqE7RDeupZIUHw
   6iGWbx45oUBN4YMyeClZqjHbqgYsJRdUrMS6WpJPH7g2Dk+y6aoI+pMsM
   w==;
X-CSE-ConnectionGUID: KQkgNI3ERX+VeNk1HOX+xQ==
X-CSE-MsgGUID: uSa1clebQqyHRmLuBrTRsA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7334044"
Received: from mail-centralusazlp17014024.outbound.protection.outlook.com (HELO DM4PR02CU001.outbound.protection.outlook.com) ([40.93.13.24])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2024 17:42:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG0mTfMGeusmEEKO0WQxONeldzVTtVKJOv6JaWEYO2gYrgIhAogT7wNW8/CltnChLJcr35qrj+mCMve93+rQw4YFBPKzxI+1n3ER2cLEwYVGfB7+xOkzvHJChqqVSSlB3ZmDOPB5D4iYpcRSnWNCxUtsOOQXWyO0UkDeSBN5qHJiWKDDMnnv8bg2yGNxwfrPk+hqCgKrniuOf8Xh2nbVaQnIfArNyXMrTDIpfq8pRzSCVcPcscc338YrkRZxQQyvg5DGlXxuzX62VbtcXglTm6iPBuVm2qSNDDUIQ1YiszsdvUYxDDJY2DgniSFRj746Nb4tAxKW3jk5tfc7IZyJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=EDIZywKS64R49cUeCZj6laTYzYwZsi0f7/5AcVTUyi0v4sOYUVowpSvlifRElRPJZxk2pZm5NhtRGuy3J1AN5khWPKNxzUTs8vDZice6DOW1Zgy21eJpP2n/HFu14eB5M6XR8drUrNgtBlUfboWWQ5jWbQb3aouW6aA8rmBQDLbZFYmB7eUbwudhQfZGOyVrI61XZxbOu3tKMoLF7EG8U4SiEp3WNtaJwaoZ4oZRRRl2Cb0YeXlZHm76AYw3akuiMl3Z4/D6N013AqwRZJXvRscrzbBYUbz5CjZ0o8Mr4acw+3NaJ8UChV99rslzT7FhKe6UWg+3F6e+tWXiWjg4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=YoiN3EcYaj/SqphzJsP+30sme5dRyO+/OtZtlP8drqe31PvtYn6Z7/z3XnWA6anRmZOP6FoavksKQfKb/gbN72tgRkrTMXvDwQ24hWcoYWfpliTrMM34jWL0Doyb1pkJ5Yq/br9qOkcm7AR0O7VfLKmkhmjNJ5GY+veBhvUVjpo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 09:42:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:42:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/8] block/mq-deadline: use separate insertion lists
Thread-Topic: [PATCH 4/8] block/mq-deadline: use separate insertion lists
Thread-Index: AQHaTiNObDGrN1JyDkCcKinS2pCNLrDotuKA
Date: Wed, 24 Jan 2024 09:42:01 +0000
Message-ID: <3322dbfa-5d47-4e5c-a989-77809da60804@wdc.com>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-5-axboe@kernel.dk>
In-Reply-To: <20240123174021.1967461-5-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7400:EE_
x-ms-office365-filtering-correlation-id: 9c14f459-0563-4d3f-62c7-08dc1cc0b754
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g4JPp24yemTpdwzQ86imJpi/UFkY8h4Gq6yY9A9yCkV66kIb3LgBHnDu326zUhzQq4vrL9rGy/RnMToZGnW6J+FDEd/SpB/ym6/dKGXWsAYxVhzSEhnJsu1qKPR0EyYp9C6nOzbDRu4BJAw7SZbDhM9HPv4EbYZxDN4/baW9cA2UPoqqNwnXu1OxBlbjemlzmweIyGyhLk7naZ/vPe9lHEj/G1G6Q4UouttPVajpYQ4aSUnZHFjzZc5tAJIoglZSxAyR6by/q1NJ91hKLFGPQOfB6JfrR6V+IuFt+Gc3wnubAtbeakbq2nld1w94GGim8oE12Okf2mV7p+7d+PoPua28siGeaywyVNfGhd9Cj3exMr63Gcy4O9fibbAVwPDDjYtJnI+vWBRNTImyvfF6mD0Pq07hLN7XflJWRPdag62zzQ1bY6vXB+LgSIclNam3ahXxiBZH5iRiaUwrdGsscPwzDkjAfiMMMAsOfeFwj6GVMet/uSQCcuxDa+ogrs7XsAAg8R+zh+5eX7eS6eBERpcbavrKlOIK7DqNpoNhC10t5Sf5HItCqPvZPl3ZUIP8Wa36E7e4kzP5XrUSxoKKMipOtSShk9wVqwfjt97U7PzPlOdqXE+mwE3bHZkW8BkDCTN1mEcZpwMSFUP7TF+T/HJ/54GrD/Q8qQsHLV+uCZgJ80JN9rbQ05L0hv1EzdB8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(4270600006)(38100700002)(6512007)(6506007)(2616005)(71200400001)(66446008)(122000001)(4326008)(41300700001)(316002)(19618925003)(2906002)(86362001)(8676002)(91956017)(110136005)(64756008)(66946007)(76116006)(66556008)(66476007)(478600001)(8936002)(36756003)(82960400001)(31696002)(38070700009)(558084003)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2wvU3JvdlF2NHBUNWVTNFVjSlVPSkFJWHFBcmd1aDJCbWszQkFGZnFUUG1k?=
 =?utf-8?B?UlppZjlJUkxuQTlTRXRONHlYMDEvYnJmVEREdkhSYW5pMUtESzVmVVNpbFps?=
 =?utf-8?B?SHdHelhWcVpoQkxHaGJrMDFGTDYvTVFjeW0zeDA1eXpKbG5tVlNCVHY0d1V0?=
 =?utf-8?B?VGYrU2svUWZoMUF6bDVUZnkxQXI0L1dpbzNBTGhKcnhRbmVnYzZsZEtLSno3?=
 =?utf-8?B?RjRkUlJpWXRGTkRwS2tNdkNYNVZqbFZBbjUreXV5eFpsSUZjM1AzM3FPK0dm?=
 =?utf-8?B?b09sbFRMVVNNR1RVbDhnSmt4dk5NZ1FKL0Fua1JpaVdMMU9SSWg5YzdFZjRG?=
 =?utf-8?B?bnhPRS9VeXlpb21VY2Q2bFAyOHFZTVc1V2lnNVJMQ05NK3RBeEtMVUxSZndk?=
 =?utf-8?B?WWs3Q0E1dnFtc0dURFZONXlrWVR1dnNnUTVvUnJwZVFBcU9aWUJweUtYV2ha?=
 =?utf-8?B?QzBZRGQ2VEVGb2x3b2RFZ24wZGFnZlRnYmdQSFhPNVdkRXovZHFSSG5GVTNB?=
 =?utf-8?B?QzVyUWJjYTJ0azBaTk43N0tpRHEwSmVmTkxEN2FjRWd5MWlPV1Z3bG9sNU8w?=
 =?utf-8?B?QUpZUjVZbGk3Nmd4R0l5eGpWR01QQzYxQXVra1oxRS9Nb2tJV0tTRWx1aE1K?=
 =?utf-8?B?UzZkMzIxWXVwVlNLL2JrK3drdTFFRytsK2YzTG5oVnMwdTV4RDdGVC9YbXpm?=
 =?utf-8?B?NS9TWkR0L2NiampWZUhvNGpZcVplelZoUzhqTjRoeFE3d2p5S1QwTkkyeWN5?=
 =?utf-8?B?L1F0UHE5TUY2N0NuOW5BV3pHRFdyQXlGUkVyOWtmT2FjQnk0UGVkajBJMGpI?=
 =?utf-8?B?d3RpNXBnUnF4VzlOMkNnU1hoMWhIbHg1LzZHVkt1Qlh0ZHZxUndZdU04cWY1?=
 =?utf-8?B?Y2E1MFdqQXJqN1NTbXQrMnBFYk4wRGJPUEN4MXdsMFBRclpnSEtNR0tzTHNo?=
 =?utf-8?B?SkZFMnhLWU1zb2FCL0g0dHFzVkxCU2FwVnBqV3NuZE56Mnp2cXRHN1FrNEFm?=
 =?utf-8?B?VUc5UWw1dnh4TjErajgwVmlYM1hTQ0FLaEx2WXhJOE9KMEV2a2IzNTZyV0xy?=
 =?utf-8?B?cTF2TmZUTnM3M0duWVFJazRpVWxBaU5JZDVzU3pPcUdWOFBVRm1WazVDaSt5?=
 =?utf-8?B?MGY2SXlWczJBdHV3WWdHRnZiakRENDdPSHRKZmpmeVlaaWdMWUE4ZFNWYmVp?=
 =?utf-8?B?SmVKVytBdDlCdW1RNGlFdzJKZWpJZ283Y3hEY1lsMlRucS92Vjdjd2tDZFNx?=
 =?utf-8?B?TDRMSWtCOHppMmtLczRtSjZENXIwalQ1VWx6OHAwa1Fid21Zby9tRkJpK1BX?=
 =?utf-8?B?ZFpvVVN0aW5vczRQdndnSTVtcGNnTTJwNlYzVWZ0L3JNS3RmeSt1TGhXTitD?=
 =?utf-8?B?Q0I5Sm5uQnEvc3VFRUJFQTQ1TTlBVEtBRlBDZXVtamwyWVRXNWU4N1RxSlpm?=
 =?utf-8?B?MitvMnNPRkFFSGhEYWtqKzNYdXkzVTBTOVBBVmNGRFFWc3NkTDBmVG8wNGtz?=
 =?utf-8?B?N3R0bGpoTmUzQ05FeDFpU09RMlFFd25YVURQS2lEWDJVcUNzWXdlK2lDNWFE?=
 =?utf-8?B?akRhcWkxOTFkZGg2WFZUSFlrKzFDc1ZENkhpR0lSNDJad1ZzSlBTV0VtWHd5?=
 =?utf-8?B?b05GdWg0SlY2L1A4aVVOZ0Q2VG93cUxjcGxPVllsdkN6TmpGanE0UmZ5dFRG?=
 =?utf-8?B?SnNhRXlwdU5HL21mUE5zSmYzNVg0blRtL0NXNjRScytvUjRuWkpob3hIa2JT?=
 =?utf-8?B?THhNUFova1I4aDNyZFg3OWtLZDZ5NkI5WW1OV09EY044MTNNajFkaHVVaTdZ?=
 =?utf-8?B?anhUTzk2MVlDR1VGYUtKNm9Nb2lwYUZQeW9qdERwQjY4aEo2TTR3RmdLWE5T?=
 =?utf-8?B?OUpBdkF2RDhoSWNPY2IrS0N2OWRGK2Mrem16WGpZK0tvV3F0dFZKdlBvOHFC?=
 =?utf-8?B?Zi9QQ2gzaUJ2c0FDZVQ4MmQwUDhhcU85UXZ1MnlrRVpUVEkxbFRBQ280anFR?=
 =?utf-8?B?bkVueUZxZmwvN2pqRkp5UDNlZWI0VGl1K2pYdjh4b25wUU1DM2kvVGJNRFVJ?=
 =?utf-8?B?aitsdDNkZWlCRnZuNCt0b0VkOFl2bDU0NUZ6akNWZTNSU0ZoT2h2MGRwYitK?=
 =?utf-8?B?dVNlenhtQXc0dFZPd0R2ZURhSWZ6SlFCOU9SLzY4dkNYcS9wa0ZrUThGZ2Vv?=
 =?utf-8?B?OEV2K3p1U1lpUVRhZFBrQjV0Wll5MDNhdUc3MU1iczJxMXozLzZtdTZnQ0Fn?=
 =?utf-8?B?dlRleTRIYXM1MkZFci9GMVhWSHFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97FFB9C52D8C1247A2E264BF23944A0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C+VM9WP2GasgYdvw8m1OkxiG65Zfb6nbAs8kZBe/A2UrloshQkYVwwstMy4wRXjtaCvm/WkAu84T66oakTYaVOEjVle11/BOTwFt5p/FAnBsXKqte/8vXZVGefI3VEtKBKMqGhCyLt6XtxHlX4hMORt0hZOvQSRROxO1Pl5eKU7VCxg2blbltRHgC2Ex6jkE5ocC55/fTacwYVoxZ8ta3kn2yM/VkkrmwcIf0yM+t9DiQE2QpXYfm+FAGw2jIh8A7Jd8VUgOzPW7TUXWRN0pXhyE2GQ8+QhZTeoRARM1HbdLPrCt8tMFbr7DB8i0BEa23vWTIc88i3EQJd+MUsZDs6gQ63gj+64ChIlEgCuzXG66/o7XDaTB5jph4y3OMhZcYDZi1CkOqBjGEfsN9o2DXFj1p34y5SuJyMKDP2bhVPtq4VLcxxOWhwP3q46A1y22zN3Yo3th6+6g8qm39Y63SMS25milZiRS+6kLLR+y/NaSWz91xh3YabXrzmenGYUn1XnAlQPjRdGvHDC2ZN7hncDRS8i/MoL6RpokHMviFN+ZT/ctIGyGAuLZH8DHJGauYsjsA8nGieS58f3oANKgx+I69iJx1mJdh8afIYUnl5Piqe6hdDhsRMRmWorA6a+h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c14f459-0563-4d3f-62c7-08dc1cc0b754
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:42:01.4586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrjiQgl+s0IvmDRe53NbbLRGcgvR98doMaHOlTeCjEr8ucV/IoNRC3LS9c59/3IArzx8AyU1EqmXqKMz2G2IOoc2vtPfRGkLYE4tJ5Bffjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
