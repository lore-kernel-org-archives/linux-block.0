Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834917C61
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088596; cv=fail; b=VeFYRDyVk2QymREF+BBuA4pgJJ7gjvDsNfqalbFQJDu3UYIjlC5mcgx0KHyqLr/Mnq059gY13UvChv554sVZlvPYch1o+7n7W1Yrs+W2xeV50INB1rKOcrKXDZC0FdX/n31rAE9asr54AjoQ/igzYFU3x5HSTHOOtDy8dAIGlAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088596; c=relaxed/simple;
	bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F2IDZ3lcyyOMphPfo+eDm/Wm90F5+3BrpRTm8IxrZ7gI7rvHigxigXXcZxRLekIL367gmPJ+xbz4AQKDu41eknBs5jafv8hiFh0Y1HkY3iPMUiTeGiy7g2rNdoFdSAok2a0OrWYeQeEb6gMw/lNCwRlaNgg0SzdDLlbzwVmAsAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RPaJDh1h; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fTHXMpCB; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RPaJDh1h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fTHXMpCB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706088594; x=1737624594;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=RPaJDh1hQ2pnzo+4eBjVTDZWycTlfkjtArc5zyAhL3glEmplvdpjP1ah
   WH94ZW+2ExUEyOsgC4Gzsl2wlPWzIMrxArIL6osgmU+ztSjXMaidLKwk2
   an6JmPCFFUdRsQkiD2bt+83vdqLNSbI3Y6AdFGwzQw5K325WjhzwjijdG
   O26zw+KEDuZ+ApAiXrS6cKflFaYlSRks5VKVFERq0gDJIosXRnDga4qu9
   XRf/FKap77bpITmbauhRmD9djeKeI+Ce+W5iYfs+yTqIEv40W8ssNNf3A
   lYP2YpUnbvH+VjkIY8f4OdbfR+xLk9cOCQdcscotccPYdbgLycPF1PxhT
   Q==;
X-CSE-ConnectionGUID: A9a3+WBJS+CHDqyL9vEyHQ==
X-CSE-MsgGUID: LlQeJvjyTnmC7HUa8HzEww==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7611890"
Received: from mail-westus2azlp17013032.outbound.protection.outlook.com (HELO MW2PR02CU002.outbound.protection.outlook.com) ([40.93.10.32])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2024 17:29:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7KJ9nlOMIO8hUn8yUukzLdkMoLsWsWXKr0AaJPKbXIeY8eoTleDX9JK2cQ8cXbHB1+HsWgRAeo/A8LVTu88INHANmJieMNPE3NOwtnvJnC+fL07gljLKmmTLbInOdP4kB8STHVLthtlphEkx/bFZk1iNfNwUPOPar1GU/DCJiCZGyV62dPvIkcYrTB2B//56V9S58PYRZHzwfOrDGVkGW/wK7W0zUFz7CvvwIPehuWt1aFTJn1nqOYGX0tiBtWRVvyMie250UcTCPuVvlEQvt9vKVK45s+juW1oCL4732toUu8dTgBXpTMd1p3fB+T0Loo/NcUOMACcBtHA/Sxmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=LQRwGtLmA9o1Lt4dEIm9QaKCcX3/gQS6DKaGNkVUyhw2/Bfa7jeLNmgdXL9TnybtRLJIEfbLso/cfYzFGPpeWCEoMnYcD9PdlVT2ENeNVZyGH1U1sVZaSzCladZ802DCsMiZ8ldkUnMsDnwd6FwiQijlqI7V50XO79VCHGQ/H7v9OUcZ5wgTSTDrzTfJDsSVWLNgywuhgLWZzpaVOrqfkAWlgiH8iO4FD/bhXBlb8O57WAC8NNttl7dyu6jrl7G9pFdkg/YfO+xNRwL+WdXmuh9hLdAF1+H0hDaASVRpLMZ6tP0Uk3Zu3q0strA6noqQo89tiE+uYzIUU+gpoXFoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=fTHXMpCB0I9BzX5Yb+eWiYeQDHq0WRDqf69NbJpoIUOMDTIpKmUop26aRW8BeD5rMUhdJPZd797yKhMccVtKDbc3SougWzME0VoO+ctebPYtFVCG3UZ46D4PSojXgO0FCJKZYTJEazgBmEDzgaWpE/Eqs1qsZ/71YNzSt4lHl5k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8493.namprd04.prod.outlook.com (2603:10b6:806:326::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:29:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:29:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Thread-Topic: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Thread-Index: AQHaTiNMSiIxZZvpLEWUbVHzXjFeYLDos3sA
Date: Wed, 24 Jan 2024 09:29:51 +0000
Message-ID: <adb223c2-a587-4a7e-9d6d-f2579429fbbc@wdc.com>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-3-axboe@kernel.dk>
In-Reply-To: <20240123174021.1967461-3-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8493:EE_
x-ms-office365-filtering-correlation-id: c0adbdae-8422-45d2-b353-08dc1cbf0442
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pWAo3k4TDMzY8bTQBVsH5lWTJL+MkJwzz+he5NjFxwpkfIM0374nBB+/Em0/hCvQDjws3s438NUPBHnYXcSIi8SzA/tHSf8d4DS/QuhhXfxB3ejfJce+Nq1w9YdrCQAb6haPoSnSQ0Sw/AaMc3EVJNMbeUGhqme89/Em9aDARSTGw3nqiJJE3B4MMHcXQsRoIX1stUVvrJSFe+2dccYXnZziOLQxjT3nrVBSfHTrT1u+s0bky14CIbKY5jB0nEE8gulWHWjRwGpzJqhYfYlrRrBR4WRwn6rX9he9TvjRY+eo+vA6jhkhfvB3aGCDwdXBAcp5EWzyVFBM+Qvnepur/l6dhMEyXgkukVEy6lfcFlXlJe+q3MJ5VjUcJAbKwHRHnCmnoonbwRcfWuH3U8CoCXmgO3QnHsR217l8T7kYWfv+A9Y3VDiPD+ICZ7+BXYDhCxA1pIulLsUsFmvPwmMCIO/oSUxPJLGiydxFXwGtjbIqoHD5XYI5aLLDgp4Gttt8UF00thuRRknzeu5wGmxjYqyPAaoy6IEp9+vQFHkP/nNjlOx5Jk6dn0ZVCk7T9BlMpXk5HxZTVdEc5yStiE2bAvo3lf9zYsSgcZUAAG49VdE/xD7LPSdFtI6gK60d5ClDhVITB3qprGaEQfYrh2AgQ7eIAumhnqI0wb7yKKBY6IAqUOzRbCu9cM1Ts9gdQYIf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(110136005)(82960400001)(91956017)(66556008)(66446008)(66476007)(316002)(66946007)(64756008)(4270600006)(6512007)(2616005)(122000001)(6486002)(478600001)(38100700002)(6506007)(71200400001)(8936002)(76116006)(8676002)(5660300002)(31686004)(41300700001)(31696002)(86362001)(2906002)(558084003)(36756003)(19618925003)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3M5NzFEdnZaakNtYWRQMUxHN3hwVEM4eWZZS1cySEU2dTNvaDQvN3RvTC9U?=
 =?utf-8?B?NktmbDdDbm8wNWdEM1JOUkJ1cFdrK1hJTWFzTE84VjNKeUpWT2Q2MnVDU2xt?=
 =?utf-8?B?WHVrM0EyVWlKQ0RJTGJaOGo3Sm9HbFRTanI4QjlaUHNwdHl4MUlxWmdIVExn?=
 =?utf-8?B?MTh3NTg5VWpDaGVuZU5sQVA1UlJzRENob1hYL0l6WjVqTXFzOWFlUXZuaVFJ?=
 =?utf-8?B?RlBVS1NISkZxM3VLOWp3KzVGUURna29nT2xzd1VsdjJ2azN6SXlYaXptYk9E?=
 =?utf-8?B?U2x5Y2hLdEhZUVcvblVyN0dXMFJJeTJhcjIzNnhOVUdrZ2lVTXF5OXhTdnQ4?=
 =?utf-8?B?NU5YeGhUNk1UKzJrV1FtTmVWUGFJSS9TRGdqREFUcUJONHRLV1Npb3VBOUM3?=
 =?utf-8?B?Q0xPZU1IRVNMKzA0WTdsTFVUYWNqVm5ONXhwTTF0MlR1RlRvaDhNU3dlL1FT?=
 =?utf-8?B?VFE2dmJlNFpaYkhCOElCckFYakkzYTc5Tk9VL0NPZTMwMlllS01JckFCOWdn?=
 =?utf-8?B?REFXNVhNdHdWV0FXa3loc294aFh1a2pTZjJ3a2l5NFJEWFI5RjhWM01tN3o1?=
 =?utf-8?B?L1phOFdFOFhrZHBpVkJuMTMvRnVFOFpiKzZsc1FsSVgwaWJsTVVmMWJjcmhR?=
 =?utf-8?B?YjB4NmVFTWNoSVdKSFdhb3dhbmVVK2loNlprMlFhWDVuMytBSlJLMHJZQ0hw?=
 =?utf-8?B?ejlmZ0VnMkMyd3FXZ0svdElEbGlJRjFwWTgyeXd6REh2ejlzUk1RQ0JMWFc4?=
 =?utf-8?B?cEw5TVBvMjNQNXozSGpFc3NIWjdaZGZTcFgwaVRnQWVHM3dCbHQ0ZUUwZW1E?=
 =?utf-8?B?eGhrVVI1ZzkrUTZxc1lUeUduVER1SUpxOVZwbWFaMFlPcDZNaW9nd1UvL05T?=
 =?utf-8?B?YXNGTy8yK0Z1SXlSTm42Q253V0k1a0podXQ4ajVMQ3V4VjVzdHFZbXFyaHU4?=
 =?utf-8?B?VEg3cWVveDdJKzk0K0V5MmlaZGNpa3lQN2xSN1FLbHFoU0pVdmRuSTdvRUhl?=
 =?utf-8?B?dTBSOTVrKzZEYVBpQzM3R0VjVUJHVWNFc3FmL1RFamc2d2g4S0pRL3ZId1Na?=
 =?utf-8?B?cTdCRXV5U1M4MjdLZEhJOUdBK2ZodWFia0t3SzNMZmt1VDJFRVNQK3pwMVhn?=
 =?utf-8?B?dGhsd2ljQXYzNWM0ZVU5U1RvdkJEelM3aFRhNEZzZk4waTg1VEdWNkVQeG92?=
 =?utf-8?B?a0dpVkZ4cEU2YWRYcWdjN2dPckFEKzhCTTkwYUR0dWY0NmZUSWZrOGpEeWVS?=
 =?utf-8?B?Uk1icit5SkY4Y1pzSHRmay9QUjJ1TDB6OU9DL09OWDRQNHB2WWpNSEYzWmw5?=
 =?utf-8?B?b2x0eGZIaGVJc2g5MlJ2aHhXSnhUdU9sVWsrbHZKdHpvaG5zS1krWWFWRytZ?=
 =?utf-8?B?ZjcwYWJjWkU0Ylk4d29mamlOWG52bHRFYzRXaldVQmlOdnk3T2NMeDgwcWF3?=
 =?utf-8?B?L2hDcVhkSjM0NWlmSzdHQUxTd3pFQTNMS2JJRHk5MmFxZ1ltQXVLZXRIL0tr?=
 =?utf-8?B?NHY4bFlVdDQyN0RLalh1NC9ONUdESkFmdFBFOUhBSVlKd3Z2YXI4MFVEQ1ps?=
 =?utf-8?B?bzlEb2dUbnY5cXR5Ni91TDJCa213MzZSRVYrRlE1NTkwaUN3bWtSZ3ZZNkhi?=
 =?utf-8?B?eDBhRU9yR1E5Z2ZOT2s0eWVJVUdDQVAvRGVucHRMbm5jWEtpNGV2Q2ZFVlNa?=
 =?utf-8?B?K0lCbFdxUXRjZjdldjhYOEdxOGVoQm5hbVovSzJCWE5DYmpSbTJ4VmFyT2hP?=
 =?utf-8?B?V3Fsa202NnkzT3EwVjVnMzhhQU81YWZUUUtIVE9UR09oMjNxaStFcmtYb05q?=
 =?utf-8?B?ZHpjN1lTNjBwUkoxZDAyekhXN1dUMDJ4RmZSV21ybkh2SmplMHErRTB6OFFP?=
 =?utf-8?B?TndzSENpanlhR3ZlNlNOSVQySWVDSVM0MlZ0T3hwT21BQVFkVG45d0N5Qlkv?=
 =?utf-8?B?SXV1dEVYaEVpTGNsSkw4TW5maHVBZUh4aXdGUGRWWG5BZTV3M1I3R0FtMVll?=
 =?utf-8?B?RGF5SEhBU282M2lNdVVTMUI1aWV6R1lLWWhIZEgxNlRNbmwrMXk5M0hXQmU3?=
 =?utf-8?B?QW9wQUdBT1NLT2N4MUZ5QTQyNll5VHBlRlNLRytsRmRVZys1a0tIT2RLVmhI?=
 =?utf-8?B?ZDhaTWJaUGlBUWdGUnplTlNTRnN3Q2hqMWtmdUJnKzBwTjRickZMOXZyUDRw?=
 =?utf-8?B?dTF4RkRRWFBPTStneXNUSTFhYTFieHpLKzFvWis1T254eWhaWG5xQWtocHVk?=
 =?utf-8?B?TFhXSTM3c2pNY2l3b1dEcE0rb2l3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8BE6709D8D7D4D95F78C34108B8B5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jc2s+pGrSmkX5SJEfQNcnAsbL27YDNRUQodSu1jY3t0J3+C5jqF4a9FtIudt5jF7v5LTPp2MgDAoHBtlXVDFbd9wR6mRxBxV0ZvpZsNuNQOxFMZERCppXRMF1zrO+xh8d5jSIyXzKnUezXVK733uTtlSVqyh+LdbiAoO6j7Df6wGHJeAbK34PIm2yPB0TPxL+4v64XkUr44a+mO6vXat6ER88F5V6JaqCL7RV1QpzFyoTB+6napb10jnpQwiQSq9xL8wpmZfMT5WJMKiPk4hBRzvUrAzhHda3WdpzzEAwMbY6NFAcm8wsKvJc5BpPEmITFojt9lVz6DD3fDUkxryD0UYUVMfTpMX0PY5P8qnJwX1zbHqnBNmVYTGUM7yjacKXnpXkrz1IMvJ4737L7ar/IQIk+bGPcgTSxaFW7gd/LBzv+QuUkZM0pmFS57SyMTT5y+hi+rqm0TRbDNXNDT/yK/Q+DQA3uRtU4plvlTsmprqU+7/A2epVyT+KCldC6Ev5MkCj2CyoVVGajigTjeC/WHbOnXTi9KG16cgUen3VdjumD9EEXCQ8OrLBpPFCb7zdlO6ICIDRxWZZhVoM5lzX9KPUoT+AGm3KqGiAPV7O556/Wvmz+xG7qgPaijgo07A
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0adbdae-8422-45d2-b353-08dc1cbf0442
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:29:51.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JR7em/6LLmfVN0Yz7DmeC/CcVM5Jv982Lm0Fh+z29hAjiSn8MKZCBL1+9AKpZ+3Letxnh3RgkXCSL59dowxS3ARBhlrrPhnv30jXEdEUAIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8493

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
