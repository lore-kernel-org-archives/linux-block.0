Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189F25FA13
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557999; cv=fail; b=qZhih+lDbDhXrfY35d9ksZujHjUDICGdFE6Sqldw5NCYOePaEvKSNDg50FhF2P0ypMQz8jUIsQfmPklesiAfI8c2mbvxEYdMJ8u54ndK2DFkc6De8b7taLiSL3rqeW/v6H7+7IxoCCJO4hlCIO/2FPzFMAuPakLaVEsjOAP2PzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557999; c=relaxed/simple;
	bh=pbzGXQiLFPpTChxYSafuABuamkmCeTLBcAFJD0wZnag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=apLOtuGl16wHLzkQZ8oMdqzKqcwbsXWQ6+l9Y75pqBi04WUzqS0dv5leRRVhdrgYXltYsDzbDTQC13Tkpe4/Pdkgf0nbftp9b4QnZqe/2AoQzQrI0nvI53l97koWRUYHvEr4zPap2tfzIEkYd1vW0lH/KvjO2EnwBzlL5AyF3/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ENyxYh10; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XqAkNCCC; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ENyxYh10";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XqAkNCCC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752557997; x=1784093997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pbzGXQiLFPpTChxYSafuABuamkmCeTLBcAFJD0wZnag=;
  b=ENyxYh10QjAQhea6kMbmE40hQYzRi/8dTrB+roH8jUgJtyznLQXch6ex
   Tf2gMIM3Hw4NKPSiXUS5efB4Ze/uqFA3QTG0TDNvHwMVrhbGUBxYk40kx
   7nLISO/IwZatnjQheYeFJoDC5onrzvlpYUP5yysaDB/+LjqS+Zg9K6dLR
   N3BKiYykPOqL8sWWvB+p2FYk4OHt7WalTXmzRpuWDiCc1LL1OMQCflVQG
   PO1pDsiilpEeXlFbopzENFL4hBbmbRb+0NyNaN3n5UTOTNNWuXwlkYGAu
   CKecrH1PUqHI2BZ4u3oAGc5jVmHuBbqPzhXJm7kSoXvGrlnlPYy1O/vhM
   A==;
X-CSE-ConnectionGUID: 6OicukWNRrOCe/SunGNhqg==
X-CSE-MsgGUID: xjyazrSwS2C7Dq4B6y6w2g==
X-IronPort-AV: E=Sophos;i="6.16,312,1744041600"; 
   d="scan'208";a="87568699"
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.57])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 13:39:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWItFgXvlCZm93IW5fhVREQQtJ3u0nHWYtUpJayS75KzRGEE00oal403qCd1zD0gxPf8X5FksegTm86IhlqYu3uwwW8D7EqIYal1O6V+RNieo8H8tGzfOytk/Tv0VF0Uk4z+5cnywMw05EweGnCtKrepUlDTfeFbsNxnHREYYEneRhmCbqgD9m/ILJtJaqq8p8X9BC6jHl+syUH9aTbPzAtLV415dfnlrugbwE7J9d/GgWHo+N/E8MZa24a1XFEWip2DQ+zh15cm+1eWMejAMjsWhmc6EaZCXcgLtrn2nIjScfflRrDdWgp34FwS1Ge+27pGrHsQP111DXE8ZFg44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbzGXQiLFPpTChxYSafuABuamkmCeTLBcAFJD0wZnag=;
 b=WJwdn5gQkmF9WCwOkbGxm2WI50XgsdEwdaTeS1s22I0Sh4zLWrcdg5oAuHhPBO+v9viZ1diVm1hSGUbJvHjnoRNwAn2e5ACglF3gzetMRFUnqgbweiHUnOewnV9Jgl1hFN37naOR7dqtOZCbMImM+iP4mvQu9x5XwQsGRL+j2zVR67zTguV0Pt50rf3GA08EZXdKoqEv1f+mjZCxBsIqGRvs9ak19yNIKQWtsfLPvhiK9Szbwe13wayZfVropVpQCfM33vfbJMgXDPC356iexvZDDNCiVlkTK4dQFw64r8jgOiB6/AcW2w0/j4ObN23vDigUK/zgSZM2nPySE2NlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbzGXQiLFPpTChxYSafuABuamkmCeTLBcAFJD0wZnag=;
 b=XqAkNCCCoOUARZve3zpa67ZTSrozbEbLOK+lt6l3NzfrYeScEz9otnleQ8n22qOXvLxkgHEHRF0XCZWs/iUl4Yf/R5DhdQ4l9sF8F8Qcm0L7wob2RBOI/rqpmTVVPQtqIOUZtRSkXrqCdj3XQ1WK5Ne1sgxtG9qut6DwZj6KupQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7118.namprd04.prod.outlook.com (2603:10b6:208:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 05:39:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:39:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, hch <hch@lst.de>
Subject: Re: [PATCH v2 5/5] block: add trace messages to zone write plugging
Thread-Topic: [PATCH v2 5/5] block: add trace messages to zone write plugging
Thread-Index: AQHb9M0BGLx8kQujP06xrVP9sD0jT7Qx00QAgADY4YA=
Date: Tue, 15 Jul 2025 05:39:47 +0000
Message-ID: <295ceba4-cb5c-4f3f-9868-f6feca603b7a@wdc.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-6-johannes.thumshirn@wdc.com>
 <72643230-7825-4482-81bd-d6f25c854d9a@acm.org>
In-Reply-To: <72643230-7825-4482-81bd-d6f25c854d9a@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7118:EE_
x-ms-office365-filtering-correlation-id: b6bb2299-047b-42fb-2b85-08ddc36202c9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3Y4RGg0cXMrZWhISi9SSDVtYVZ6UzNoOGk0eEtnODRPbWhybkl4dy82S2Rp?=
 =?utf-8?B?OXRlM3M5a21NL2JwVERKTDR0aWswUHgxV2VNMGxxN0Q4NU96RmhRbkFudS84?=
 =?utf-8?B?NTcxMVNWOHJ5WXg3YU9qWE4xdFEvc2pWZjNMRHEyVThWVk0zZ2tIaFNpVjBm?=
 =?utf-8?B?YjN5TFp3ZHgrcTJwT015TkszT0tQNENEY1NUQjdlRGoyUm5MeVF2c3lXY0VB?=
 =?utf-8?B?WWJ2WThLdWd4dmRBd0t2WkV1T3BDb3N5Qi84ZjV1QVZTTWdzZ3FTQzJ4M3Yr?=
 =?utf-8?B?YWY5NnRUVktPVktaOVdkSXQ0ZFh3MkJ6R2MzM1pUYyt4dUlLbVU2WDhiNE01?=
 =?utf-8?B?ZW1zYTlxZzlFL25SVnoxVEhJQWJvN1RzaUxRVVR2S1hRQVVmUXJuZ2MrZnpr?=
 =?utf-8?B?cGpaZ0FwMlQ2TDJ1OEt5dmFnM3FKV0pCQTVCbHB6RHNqTjliNnVSSlRmenRM?=
 =?utf-8?B?dU1PVHhiZnpWSmt1ZkxiWkZ3ME1nUUdrTFIyS0w5NnFmMGFjVmJuZ2o4Wlhn?=
 =?utf-8?B?ZlhrQWMvc2ZsTm16ZGFvT3luMEpTbkZvK0pSWm1mYksvWWFMQ1RVbnM3MlRC?=
 =?utf-8?B?SDJmdjJwdHFOR3JNckgvclpDRUZZcjdxNFMrYlRIRGphRWo3UHgvdlBtRVY3?=
 =?utf-8?B?Qk10bjU2QlRTeXdhVXVXOUhxR0VUOHh1elV1TXd0UmV3SmpOczJJQXRMTUU5?=
 =?utf-8?B?ejBObXdDRVFZeUhRNlRFR2RwNFBSM2QrUW5hN0Z6ZkZNUHcybkZaZ0hmQ1lh?=
 =?utf-8?B?aFZWaTV1ckQ3c0tFR1NuMTlqeitmT2FvSHBONHBJSno4MCtqaTVENFIwcENQ?=
 =?utf-8?B?SjdlbHQwYzg2bVRGTmRmUER0Nzk0b1g1UzA5ZXRMWGkyVWwvcTlKaWJoa0JD?=
 =?utf-8?B?NnRQa21KQWZHZ25wREN6OExZdmREOGdOQ0owUDZQOFFtREFPbU9GakIxSmZv?=
 =?utf-8?B?L3A4OXlFc01zb1FWNkZ2RGJncVVMeFRPYUVDd1ZXcERKN0dSZHRlek9maFlL?=
 =?utf-8?B?WnVRTzJrTlQzbmZHNkZHSXhmaXoxdllsWUhkb0xZZXBMRWZwSHNuR1JQRFRF?=
 =?utf-8?B?aUxkUU9PQzJPRkVHSDI3ZUR0c3VrRTUxWDdQNGtjZ2NOY2lTcGN6bXVZUjdi?=
 =?utf-8?B?U2xnRmZiSVVFYXZ1OHZjRTVGWlY1UUd2UlZMaWlxYjl0N3g2a21HL1JsV283?=
 =?utf-8?B?NUh1TEV5VGk0RWxUOWZCQ1BRYmZ6dTlMcEdLQ0xwRU85VmhPZGhVYkhzaDIz?=
 =?utf-8?B?azZsRFRwdEtrZlVFaTNHeHBoNGVrdk1nMXZtb1I5aXJydFRnOGp1WEl2TWE0?=
 =?utf-8?B?YmNxUWxtaG5LcGRDckFXc1lRQVpST01iWHBqYUtVYkRlb3B2T0ZMdHJTTHlm?=
 =?utf-8?B?WDh0NjlNNlR2eWZ1ditBQmxzUjQwZWIwQy9wSVpqQWN2UDNXTkFtaWQvUUZ1?=
 =?utf-8?B?TGtESTN3K29RQUN2Z0U5VjUyQ29tQXpCaXQzZ0NYcFN4cWM5M3B4Yk9aODR6?=
 =?utf-8?B?bDFsRHptUm9tZU92VHRhMU9GSE5tOWdlcGhvMG8xQjBXczNOUUo2Z2Z6dGtN?=
 =?utf-8?B?SXc1ejRxYkxNLzdnMCtGbEJrN0xHTWNtSWJGNjJjcTc3RTdvbHFyVE1NNkJT?=
 =?utf-8?B?dWQvUi81OC9QMlR4MXU5blY0Z25XSWdyZTBpNklGOTFadGV0SHpZS2xYRnVE?=
 =?utf-8?B?UTg4cVpnMytMc0ZFMDhDOXlZUS85NCtOVlVocmVnUGZsRk9TNVhPT1ZsWkhq?=
 =?utf-8?B?eWtwMUZ6bFRlOEd5R3QwWTdtOWZ3b3pTZkpBVFNwTVZBaElOZHIwWnFzQ1Yx?=
 =?utf-8?B?aVlzRnBGay9yY0dCSXN1TWRWK0dHczVrVlc2K2xFMVUxeUl6VlZoVEd2TDl5?=
 =?utf-8?B?c3ZPUE1XU1E2d2NVdklMTUhJL2FzQXNLSERBaFkzRHVYZkRYTGxIU0kxRFZX?=
 =?utf-8?B?eFNKOUpTVGorOFVzVE1EVk9jVzBNdWhhYW5xVXBOTzN4aGwzLytVVmVGS0N6?=
 =?utf-8?B?SGhPSmJWVHdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGR4N2Nmd2lubFovbmdEMGF1R3hXM21oM0wxRWE1MUl6dEZEZ3VBcGVpK3Nx?=
 =?utf-8?B?N3VOVGFXUGxGQStEM29GQkxrVUU0QXZZMnh1NEhSVE5XeGJKTXhWZC9qMWpS?=
 =?utf-8?B?Qk8xdGhYcDRzUlRZVzBnMXBybkRnbU5CZzVWWDlhSkNnY2RSK3BPczBvZ3dL?=
 =?utf-8?B?UldsNCtUQThOdkYvZFdnaXd3N1JGNERhUzJHb1BwcjNITk1kUkozb2NMYk83?=
 =?utf-8?B?UytuRms1ZWdKYkFhTk5oclVabjR2NkVoT2tlNWlTaVY0OWE0ZEl5UzMxMTdZ?=
 =?utf-8?B?MUc0S284dE5CQzhIN3R0eSs1MXlLcnBYV3N3ZkJnY0dPb0U2UENRZnh3SGFU?=
 =?utf-8?B?NDRCbTB1ZjdVTkNJUUNxVjNSaW1IWWphQllBMk1KTWRpaldBNkpxOFNkUlpS?=
 =?utf-8?B?QTBxV0xsUXovdjdsOWF5Z04ycGNpTmwxRDlUcndabDVocmthNWhjTnU2QVBU?=
 =?utf-8?B?dnVNWE5XMzlVSis5MEtQb3lETllWc2RQN01XeUgwMGpwYVYzUlExUDR4NGNY?=
 =?utf-8?B?WlI3MU43YXpRWDliUzNuZ3JlNnFNWjR3OFdwMHlzMUNpT2t5WUxaSWtjdnY2?=
 =?utf-8?B?a0JUelhNMjZoVXo1cDZ2QjdZNUNONDdiTG5DSDJIZmJRcW1aejJnU3liQUx5?=
 =?utf-8?B?Q2xmWXlDZVVxRGhBSWxrVTIxekIrVVpqaW1OcUtRSExRVkxlK3o2Z2ZyUWg5?=
 =?utf-8?B?bk1vc21VUk5NRDl4K3JsSTdUamlIc2lRRy9LZmtaL09WNlpSNmFmdm90TEc2?=
 =?utf-8?B?THpsWVAxOUtTTm4rbDhsK0xtWHIzUVZabm54dGlnV1RHTXhaSEJYa0RqV0Zt?=
 =?utf-8?B?YjJ4SGs0bWxtdmVaNUcxU0o3NEhlV0g3SUR1eVpGQ2IrOUE0cnRUMlRBYUlO?=
 =?utf-8?B?NnVZT0wrNlBFMVdMK3BZUnNibXNXL2RteElyS2hGbHhsZlJ1YytLYldPbFhM?=
 =?utf-8?B?dUJiTnRXd01kTmZVVWNuL1puYzY5VW1VMmNnRi9rNmwrY1NLQURvdnlxQ3Jl?=
 =?utf-8?B?S3AvdWpSa2ZKTVhrZk91KzQvbGNDcDBDZUM0UHNzb0Y4TUczZjJzWFdJT0VC?=
 =?utf-8?B?Tm9zMnJ4dWVCVVcxby9vKzdjVUo0aEV0WW1LUzZNa0VNMDdROEZmY283TWs2?=
 =?utf-8?B?RzZOQ1FkbnErQkU5N2R0RW5rNFJzVk5pUE12QnkzNGJrbGNSRUYwaVVqK2lj?=
 =?utf-8?B?Nkpkd3d1bHpsdWNzc2o4QUcvQjM5UXZGdHliaGsyUTZSanF1OEFvV09YYll1?=
 =?utf-8?B?M2lQWlBRYnNQUWZ0RnlyWGwyblRpay9kblRyaDg2Y01OMEw0azhrbVJsL3FV?=
 =?utf-8?B?a3RBVmVIaEo1R0MybkpObjZOcm1YRlJhVGpKN1ZHaE5nc2NDd2NjYU8vL2l6?=
 =?utf-8?B?YnlYRElJQVF2UVNub2o4N2J5RVIxQ0NXY1dWUm9wKytCamt5bFg3SnBGc09v?=
 =?utf-8?B?RUQwZmhWUjNVdURKWld1OTJzTnJLcHM2cFpibklzUXM1aHRydWJCSFlzbkxV?=
 =?utf-8?B?alg5ZWZpeDRuRGNVWDd1N3NBYzNjemZDV25jajNZWVQwUWQzT1poRm1LMUVI?=
 =?utf-8?B?WmVSOUxZZDlVc1daeXduZUMrMkllTTlnZG5xK1hRMVZOWVB3ZVUwZFFLNGRv?=
 =?utf-8?B?UFNBUGRvVEZvaUs0dEE2Q2hsTnhhMytvMjRlYkY1cE0veW9rQWVHTFVhekVZ?=
 =?utf-8?B?MVVacTl6VU5wOCtBaTNFSG5saUU0bG9TbFBnS3FvWHF3OWNLYkhOTnVXRnhB?=
 =?utf-8?B?cjFTT3hzRm5KU0NOY3kzS2hsSEUreHAwUkpqRGRXa3c1bFFYb2pKVWtDdEM1?=
 =?utf-8?B?NXc1VjlGTm1CL1Z6WTBoZmp4dkVhZmFRcklITW50YzI4Q2J3WnVnc0JMcUpI?=
 =?utf-8?B?akZwSzBjSWFubzZBK3dDMkpqVWNPNDNLZEtKRkhJc2hTdjlqL3ZlRWdoTTZW?=
 =?utf-8?B?VG1EU2JtRnNXUmxlbUJsS2R5eVc2VTM4RDlGZUgzcTRqRldoVGl3REtVRkJX?=
 =?utf-8?B?SHg2MnFTTnF3VVB5SUlzV0Q5UTd6VXpZenA3VEJIZUF5Zk1vSzV5THFGRHRS?=
 =?utf-8?B?dTRwc1AyREU0OHNHVE52dnpoMk1URXRFWUJGNGdGOThOYkpXaFB2T1RtUGtJ?=
 =?utf-8?B?cXNVNFV6ZnZtTjFpOVI4dHZ4Ymt0a0d2eTVhRk13S0s5dElFSHdNUy8rMFAz?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA22C1DA7A4FA64ABB0F85A567F4BDD7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nGfgZK3Zv1xQzpZTrixAHHxDSOCZDe4jBgA3J371u+sgJRN+tRpDky572+R0NlK7+PcpZj81CG3fSWPLr2MA/cPeW1lXoHEPwdhwn+JwsQZpTFyfdPPHaH5XOODQ/vFafsZr1mOUCCS1DwCZj8NoH0ks3LmdjbFjcucloIIbrhqnvv9gp5jXYc4YGhknKStE6o7AU12jIjIHE+t1+CywtUcOVjlhmU4TzqEHvcciw0yLVQ7WleX+k7QfviRvv50dwBgHbdZi57rkzISb7v+Chw4F0cknbmpCVw+ZYXGePEslQw3Rd7Y48Os63KMeOiIg2dftUN/nKX2OZMwsywemAXCSfcttM7yA4dGtmHVwls4//5a1guqaMATC4ApOeLPUHXyk7nQipjVNVDrfMvQ6wKdyFiJmA7Pg8qyqSL38BGiRuuD4Ls5AaAdhARGn1RliKa9v4rEolQ96PqUEGlzJlT2u/N1UKanDq0cUhAn1D4xRZqkhf6XWlZzo4iCNHI7qEhuT0RjNzU+qZzAkXSMM8pDYqQUdwbKPI+ofsSCJaLOZlo8OvaTYFmtQSINnVlO7tbmbJcyUwJWuhpzY3kG/VnJOmns0Vz4pDZs1MQQ4HgG+2aVvYNnzYD/q0yzo4dgh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bb2299-047b-42fb-2b85-08ddc36202c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 05:39:47.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCe3ko3kaWWwrvleO1FlcZQzhF1k7Q7bFn+qOFDtJgBrvUY4QXWG+Jt0+SUPzvIJJX1501sIT0VPSCD7h6Fs2arsOnKPsATA8t02T7ul0ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7118

T24gMTQuMDcuMjUgMTg6NDMsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNy8xNC8yNSA3
OjM4IEFNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiArCVRQX3ByaW50aygiJWQsJWQg
em9uZSAldSwgQklPICVsbHUgKyAldSIsDQo+PiArCQkgIE1BSk9SKF9fZW50cnktPmRldiksIE1J
Tk9SKF9fZW50cnktPmRldiksIF9fZW50cnktPnpubywNCj4+ICsJCSAgKHVuc2lnbmVkIGxvbmcg
bG9uZylfX2VudHJ5LT5zZWN0b3IsDQo+PiArCQkgIF9fZW50cnktPm5yX3NlZ3MpDQo+IA0KPiBG
aWZ0ZWVuIHllYXJzIGFnbyBpdCB3YXMgZXNzZW50aWFsIGluIGtlcm5lbCBjb2RlIHRvIGNhc3Qg
dTY0IHZhbHVlcw0KPiB3aGVuIGZvcm1hdHRpbmcgdGhlc2Ugd2l0aCAlbGx1IGJ1dCB0aGF0J3Mg
bm8gbG9uZ2VyIG5lY2Vzc2FyeSB0b2RheS4gSQ0KPiB0aGluayB0aGF0IHRoZSAidW5zaWduZWQg
bG9uZyBsb25nIiBjYXN0IGNhbiBiZSBsZWZ0IG91dCBzaW5jZSBub3dhZGF5cw0KPiB1NjQgaXMg
YSBzeW5vbnltIGZvciB1bnNpZ25lZCBsb25nIGxvbmcgaW4gdGhlIExpbnV4IGtlcm5lbC4gT3Ro
ZXJ3aXNlDQo+IHRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCg0KSWYgeW91IGxvb2sgYXQg
dGhlIHJlc3Qgb2YgaW5jbHVkZS90cmFjZS9ldmVudHMvYmxvY2suaCBldmVyeSBvdGhlciANClRQ
X3ByaW50aygpIGludm9jYXRpb24gdGhhdCBoYXMgc2VjdG9yIGlzIGRvaW5nIHRoaXMgY2FzdC4N
Cg==
