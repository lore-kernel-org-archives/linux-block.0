Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5281DE892
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491779; cv=fail; b=MsPWpL+nQ3ZG4+Sp27aNpQM8UKqPj0lYWMYYhfMUQ0OhVsi7SLHYT3XtEhSW4+/xdaQqc3xQbfc+ugJl3BPpqgBu2KnC7AJ1IwByuAnPm0jbgZI5e+bqz3B9q+YPYDvNefGZlPOj2U2RLQ8PBrUdSMTu5ljA4feWJYEOXKzui60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491779; c=relaxed/simple;
	bh=3rD1eQ1k+wSGp3FGUi2lM2r6HheNHHoKvi4WPJtm4hY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilkbPLUBEb8j7bKb6E4/7D6azEmYYkhIX1Se921MkpMYmLeU3U6rZNp+R5f/JPn/CeLi0f6ur0PxdRPJetqZ32V63ggas0/YQcM3nSOeWczToi3jrQfDjfuoknS8xMChsZ4oaPObnhlsceXS1Cg9FxkTvrqci9iRan7ovDJvLhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TVb4IcDg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WiJaAxCN; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TVb4IcDg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WiJaAxCN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752491777; x=1784027777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3rD1eQ1k+wSGp3FGUi2lM2r6HheNHHoKvi4WPJtm4hY=;
  b=TVb4IcDgr0OyxOfVkkyiCyeXoxuWOUf1Av8xF27CqXNUkopUqNpwppQX
   XHSktK9HlzNfT/Gpzj4y7oVIoIV9jrJFK2rGOTgd4IQwaH4Ls1K9tCR5m
   nI0TOybk1hksQAblwyFCS9rT9urPM+pkZ0eTnlH03R1T8wcD6wO4Dwxl+
   6a+lt6pWVVmCpTWSPTLeo9Q2SvYDuYd6reP+6vms7aWXDxOjVdH/Gfq3t
   liUBLJ0zlXs/vHAvJdyjKksiuetT+qroPgxSncpyOf6p0rMeTecrHLFHx
   +5sVKAH7xWQdHaSI89BCXsi8sQpU4DOzwWTGD5hMuCNq0U/HluGLzaK2F
   w==;
X-CSE-ConnectionGUID: YUMX/NJLSpi785IWBWwDCg==
X-CSE-MsgGUID: WJesKBkaRvyIMZG4huNUaw==
X-IronPort-AV: E=Sophos;i="6.16,310,1744041600"; 
   d="scan'208";a="87002824"
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.80])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 19:16:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y570CN13Lp3djCbQA5fbojduzkn+nPi0/LpE/q7Yo5ysu4LnNjwGpX4/ToZX/W2H7UZ6co44+KhyhDg8vJDJuVDgpJrQ3r/ln6EwxtxQDZrCHcn3k1IUp9tA/1ZWn4uM7knNTbsKFgdCeU22jB+e0MJWCAlYhjlxFc+mgqPIStwVgq+Ej3WRdYSYXX5W0Jj9LcNQHsOIPh8dQoUsGrqwA22oGq8HjlDCMJoF3mIIO06fCGLGeH+cweHx88bbZq17EQXpjN0in2XBFHbs7qU2A11W71MykaMcspB8AlhOnyMLqZjOnXlbnkBAKp7rgHkfuZvl+QVkygYBROYmy4eZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rD1eQ1k+wSGp3FGUi2lM2r6HheNHHoKvi4WPJtm4hY=;
 b=InAp4dmxp4t3D5uNsjFsVdaq0MfyrN3A9UwB3frrfOiUeKOl6W7w3JYhuOSPwAHRgFzTyYbwGHE03BMBlOuSuZO30FeLBxw7yxLt5eXTLbx6C4VenVGFaGcqp3ki6OiaHDp3idQuH3C9mxGG7jvvt68EaWmyBTM+o7x92pqSA/RWJLdJLbVwRwO98cRrCXtobbcBmds1aMjfCrHl23RajNiPwdw9SxDJsc1ocHnRvzYE9HjYqX02tnE8SOu8y0URiQaXVtF/g0sb0HpMz+7CJhT5Gijp7pMinq5EYxNoNyWIryaoHQEAkBPHNvfPWC6n7QtCoEazQJcJLUl2Evuc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rD1eQ1k+wSGp3FGUi2lM2r6HheNHHoKvi4WPJtm4hY=;
 b=WiJaAxCNdNG6wBBzms7sU9nm1k6/OVQPRhmSCt2hFpWaYEIKA07URaIYmFcbRrvV9Yu8AY15/brMv3M5U7bPCpsfbeZkyHicDJ5+r6meU6m6cTnE/iUTVjI4q35wGtPh8v/I/mm0r/hgEquwRzwtTKmvNSQE7YOtR9a0uPkVr0g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8801.namprd04.prod.outlook.com (2603:10b6:a03:538::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 11:16:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 11:16:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner
	<dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>, Bart Van Assche <bvanassche@acm.org>, Gulam Mohamed
	<gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests] loop/010: drain udev events after test
Thread-Topic: [PATCH blktests] loop/010: drain udev events after test
Thread-Index: AQHb9I1JcXXsU7zvlEaOLt3uO6ngMLQxM2yAgAAA4QCAAENFAIAAAL2A
Date: Mon, 14 Jul 2025 11:16:13 +0000
Message-ID: <e3a1a10a-1f1d-438a-bf55-2e26b4fb6c31@wdc.com>
References: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
 <auydt3njlbdh3ths3hzyiew46svwxxtd37dxzjbeyoqfk5n533@mpm2seuds26o>
 <ce654347-ec66-495d-a7e9-551bd6b4a002@flourine.local>
 <xzeoilk6746sjqejfzfbk4rue72jsunfga5te6ynipdgaks2u5@qkjsbwwworas>
In-Reply-To: <xzeoilk6746sjqejfzfbk4rue72jsunfga5te6ynipdgaks2u5@qkjsbwwworas>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8801:EE_
x-ms-office365-filtering-correlation-id: 947da512-fa99-4fc9-7624-08ddc2c7d829
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OSsvbVJQNEdnQzFoaEJnNTdZU0xKRXJYRUZ2NVFwdUt3VklXNzE1bitLSHpo?=
 =?utf-8?B?dFRqeUsrelRVazlpN2xIakFCUHY1VERqT0FpQnpjT2tFZjhibStWcFVYQVpm?=
 =?utf-8?B?U1pxWGx4MG1tS2pnVE0rbXBTemFLeVlaU0JHcWRoNlBXMENUcDlzc3JyUHJT?=
 =?utf-8?B?UlVLT2ZPY1NmQ2JSZEs2Z2xOYmhOTS9wQmNDZGdqUXNHd0RpQ2hOWmVNQmQ1?=
 =?utf-8?B?MkpSMzZ5RHBZWFdmdGVaMWMzTWdQZGV2THVVL1ZKMXBWbFpzc0JEYXVMQnlL?=
 =?utf-8?B?VmZLbldBazRPN05PSFlhMm9BYmtLRnFDU050dkRTalRWY0xnZmI5TzN6Sjd3?=
 =?utf-8?B?cGYzUklrSlBGblVUUGV3cURmdUpPSmdNR3VIRzV0K1UvNVl4ZDhQYlNsTDl2?=
 =?utf-8?B?elhEaXJyczhJSGVJemxSVnFSd056UjRMRS9FUkY4ZCtEVlovYnpOb2lJc2NC?=
 =?utf-8?B?OXlBM1RaTWpUYlArZTVKWjB1RzltekFPYXdDNnd3aU1xdXJERG5pR3E2ZEt6?=
 =?utf-8?B?TmVJcGFvMmdWVmdGTWFNNjViazRPazdyTlIrK0ErRlg0aGFGekEyTDlmazNW?=
 =?utf-8?B?TVk3dG5hb3pJVVdlczAraTJpYnBrZGtocmoxOHRjRWZacVNOQXJKV3Q3M3Bp?=
 =?utf-8?B?UHlneTV5UitnT3pDb1c5K2hBUlFHcytrbjZHWDRwODc5ZXJRemxOck5DRkh1?=
 =?utf-8?B?dWFsQ0hZellmRFhTRDdJMUFLYys5WEczZ3hwdlBLQTFlTnZXQjh2UTJ0ZmZM?=
 =?utf-8?B?bTVIcSttNGE3ei9RSjNnNGxwdk9tYmluelpGQU9UeUFvbU9Fd2RlRSt5c240?=
 =?utf-8?B?RllQbGQ2dVFXL09GWm43OGptM3VhcFIvL0RUMm1xME1ldFhYcDlCSmZBUG02?=
 =?utf-8?B?dFBTNWVmUG1uaW83OUwwZ0dvbGM3cGhpUVNwRjZGVm9GQjhkOElYaWlWNHE4?=
 =?utf-8?B?anVycDNkSUVHcFZSSTBrSjdtV0VFb1p5aEV6UnB4bjgyODRsMmFSTkcyRytl?=
 =?utf-8?B?RE5VM0d4bHJwODJyclp4ODF6SDFMU092OGJYTmhGWUwwRjNRbFg1UmFXaTJN?=
 =?utf-8?B?Ri9ROVU0TGVEa1FxeDZKa2ltZFhGdTl2ZjJ2Qm9xWTBuaDFzZWlqamRxaG1Z?=
 =?utf-8?B?OXJYUzA5Vkk1bkErREo0dzhRdVdib3NYeWdFb3A3TlRyVWFjdWVlQVdQUXB5?=
 =?utf-8?B?WmlvRk1lUmZYd1hveVFndHpOWnZ1SnBZS2ZTeVdaRUNLQ2dkUEo0Qm9QTHk4?=
 =?utf-8?B?cXR6Q2pUWXB2VnVySVFucWVMNWpSUnpiRG1xRFFsOGlvVE5rVlNIZU1SSG4w?=
 =?utf-8?B?cUM1Sjl2U0Z2WFovbUZ5UmgyWjJaNEoxcWZKRnYzTlBLS0NzRkJpYnliV0RU?=
 =?utf-8?B?cWwzbEI5NEtMS05pNGM5cFZoSzBGUzhoYmZRaE1IRDFTSlRxNmFsK1dvRWRP?=
 =?utf-8?B?cEVqZE45QUovbEZDS1NQeGdrVGNZQ3RBTWROVGhxZ3VEN0dpY0xqY05iS3Bp?=
 =?utf-8?B?c3FxblM4TThla3Z0enZYTUt3bTZTNjU1aktMUmI5S0lFVXZSbXBvOTNZcTVZ?=
 =?utf-8?B?RTBreFI3RHpqZVFBbnhQbzZ4SHhKRFdzRlNMTXFIcGNGcXZsK1BoMTdjd0Ri?=
 =?utf-8?B?b1JOSmtvTjk3NUcvMDdKTEtnZC81VU1oYmVmcUdMTkZ0Vk83SzBnL2JBTXhL?=
 =?utf-8?B?UTRvS0xXM1NFNzdPeldiUDZOcFpKMmRNREMyUjRvSnZPQlZFaFplUUtFa0pV?=
 =?utf-8?B?TE5zRGt5WDM5TkFJbW9BeUhEWmNhQ3JIQTJ3M3pPMjY1a3ZFbW5raTNOeWtm?=
 =?utf-8?B?eXIzRGs2Y1c2NWJmS0tSS2g3ZW9KcUdEMHhQZytuZDUzemxXMldiRWNiS3pr?=
 =?utf-8?B?SFFISEdoNmtadjhwM2ZRRmFkMkxkRzFGTFh2MkJJMHpnU29xWExTdHJrV2Q1?=
 =?utf-8?B?SUwyek5SaUEvY0VVUXY1N3FuK3lSNlRPMU1MOGNXaVRUbFRZbk8rMmVFUkRH?=
 =?utf-8?B?QXhaM2FCSFBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3Y4L1pKMkNvb2NZa0lIeGI3V3ZIQmE1SC9BblQraU5ML3RoelZ6RlQ0SVRx?=
 =?utf-8?B?NGR2NEVtQnhjbzJJbHJ4WXU2Y1l2TXRqTVFvb1ZMQzdscStybzVUMnRZRWpq?=
 =?utf-8?B?NHdHMVA3OEl1ZWxoSHduc1kyVVdZTEg0YmJNUW9CdElNYUh2NlhJTFdhRkdG?=
 =?utf-8?B?eTM0K0hVZTZkbFJCVWR5MkxZWWIreVZpbklPdWEvVG9UM1pHVXc1aDVrKzZP?=
 =?utf-8?B?UlFhNGRSdFkyakpkNElCY3kwK0ptajNjMmZqNGtua0dmYS9nbGtlM1RHMi9l?=
 =?utf-8?B?TkNGWE4xci9nSGVnWFhyYy9YdU1MQjNKMUd1QVFIZ2ZRVk5pcmg3cnJPTHhF?=
 =?utf-8?B?Q3M5S2wzMXZsWXhVMlNZQ21LTGxnTTRLcHNPd2NwaXhEQ1JxYjVrWFdHaTdU?=
 =?utf-8?B?RURLWGlaU1BvclFXbFl0YUlWZk5JenNzR01LWTZXdTV6RDdHZmlXcWRQbEFk?=
 =?utf-8?B?YkNRdzQ3dTJrZGUrVUgyYndacDRoNlRJUXZ6WlZ2RWxVSW5ReTlGTW9kZ1o2?=
 =?utf-8?B?ZkQwM0pOT2ZVbkJrd2NPNVFnN2VoUXRreWcrSHlqTy9aWVNhck1ZU2NPYUpa?=
 =?utf-8?B?bDFCR3ZSbGUzeHFCdGhJbEN2bmx3OFBaN3gxbXc0SEp5aG5lcExWRWdoVCtN?=
 =?utf-8?B?bTJIV1F6MnV6NjcweU1IbFhxd3NvRjVqalcyeHNpMGVEb2o5cWJBc2prOHhG?=
 =?utf-8?B?TSsxTmt6TXdIQkFMbjZnN2h4WjU0bUJYYU9BTFNLNGI2NVdVRFdqcGs0UTBC?=
 =?utf-8?B?NmZGOC9CWFdSMVB1UEIzUk5uYnE0Y2RZQlhsSnZkZDR2bWZSa1Vid2doYTVZ?=
 =?utf-8?B?OTFkV1RwTi9SQWxyM1gzR1pyd3FzUk10MHFZV1hYS3h5c0lRVmx1Y0Y1WUhK?=
 =?utf-8?B?cGNqeTFqRHFleFplL2FrcGg2eGhxdCtZRzBmNjlGQXlSZ2YwNmxYS0doTFdh?=
 =?utf-8?B?Y2lKbWFSNnBCclNKa2x3c0JkUWErU2lGaVhiMmRKVWlnMWh6L3AxQWRubmFu?=
 =?utf-8?B?clV2QnpIdXlQeFZnVUdBSG9pdHVuT3BVZWlJb1FRKzBSNmM4MjdvWFdWb2t1?=
 =?utf-8?B?aU4xQ1U4RU1XdVJsVjZQUlJod3Z2SndXS25ZNFdKeFhGb2lpSmVtemVpbnZB?=
 =?utf-8?B?ODdvSEFmcnNrUmxmdGltYnh5dGduYVp5aGt3SkNDVFFSUVArdUkzWDVGRTlX?=
 =?utf-8?B?VGU0eTljZEtPcXZIZVdGTGE1QktOM1BlNUhvc1pSOW9wM2cydTVub1lhTVpt?=
 =?utf-8?B?VlBsY1UzRXVEQU1lTG9ndnd4Y2k0V2JwYzl4aHE2QmtRN2tIUlllNkIvMUpD?=
 =?utf-8?B?ZFluVytYUGl3Mzk4eExLbUZhbjd3R0ErWDVEZWhIaFBsMUxQb3VaY29Lc2JO?=
 =?utf-8?B?bE8wR044TWlyeEpXamFuVThSSGcwWjg3bkNiMGtUUUhZWDB0Sjlra29QclRY?=
 =?utf-8?B?N1ppc3VoQTNldnhvTkVnN0NkdGpsNHRJMlRDUk9RVjdZUmFaSDhKdUZreHB1?=
 =?utf-8?B?NHlpa3FvV0EyZFcvWlFDOXp1bWhlYWtqNE1PcEluRzNKOXRYU1E1dUJ5NjR4?=
 =?utf-8?B?Uk5BdlNoR1ZIL0ZKVzI2N0JUdG5FZ095YVFhUHl3OGtZcnVnNjdYSUttcXBW?=
 =?utf-8?B?S1M0VytJOW5iVVZUc2wvQVh5R2ZldUFCUGw2M1B0WVpIRVdvc1BIYVVERTdL?=
 =?utf-8?B?V1doRUVMM1FFS2JLUGcvbXlrZjU5dktPaE1CWXE0R0trNU96ZGZLQzVrNlRn?=
 =?utf-8?B?aHl2K0IyMWdlVFU4WE1yTzhtMzNxaHNrU25YbVVLOXlzSXNzMFY5MDRUNnlN?=
 =?utf-8?B?Nk9oUS9PTFFtd3FLU0owcTBXUklwYm53SHJPS1UyeGttS0RWR2FISjM3b3g5?=
 =?utf-8?B?WEhPeGFNNHNsQ25teFdoemFmdFU3RDFmTWRQdmtxK2Z1WXpJK0poSHBtQURR?=
 =?utf-8?B?anA2TmhKbzlyNUYwRkhzSDRWN2kvNHBMNlBjaEo3ai9ib0taVHE1Zld0SEhW?=
 =?utf-8?B?TWpSaDh5L1Q0MEJJUXJwSUZVZERCRStkVTA1Z2FTakNzWWlvOEF5dmNOcmJB?=
 =?utf-8?B?TXZFV3hqTCtDVC9OempHS25oYmViUVdTc200WDBIQzlKay9RazdwclhPalhR?=
 =?utf-8?B?cWJlVkdPVnMwODdZMjhuclVPelFST2NXN1F3Y3ZWbmZXTlRUN1E4cTliSm9U?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <605D3226563A0C4BABE247C95AB25AB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	loZbk5eiC4//6KHdI+lB3kfhL9xTSaafF6yLeiGnza1E7Jt57KdpFCNdijvIQYnMsACW8u4UpbqJ4BWZgVh5630aB2xk7hEccd6y7D+ImjPL2DghKr2lCA2Qj2zecbAvwrZBWmNSrhvTcBCq4y5iCBCMEZrFZC6yeqcxQjNO1ZgkWSNj5XDd1RyhbH8aILdHzOYJGWw31vhHS5iYS+qVgCtsmFz9CzltQLfnDqV872v4G/g3YNIB6wnrTV6b2EyoIvT34IPZuMU8y6/RSZeku2rd7hYkWoDNvuTAeh/GVuxYG0OhLNzNJJopgbYB5yzhy/4UU5s3tEZck3ucRtJ8qQjb8P8uUYHxEMrTkci5bh5KH5chiNXkd7vM+PLd2ACJvfKVzTRD74kVRDrQHwP3A0lKzlZjil2jQ71VHqpRnlmi8XgF9U+egwGKbebOyd1Kc3hqed3cCF80QOgew+5J7pIfICPdQdtFSI6JI5PNyuxjzu7aL8lkUO9SDiLNXePBUPhg+2SwGxVhzpQVPb8CHOzXwXo4ND6yEzPGnsqO7sJtKl8qdbGsTZNEWjMoU9f0K9pD1k/kJ3PBjTlu/pEg2RDSQmwMmSrsE3TbFdlxmt3EkpUMEO/ova7BmKahidAB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947da512-fa99-4fc9-7624-08ddc2c7d829
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 11:16:13.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1zUo2YjRpU0VwS6f/C2ReW2VcBknSV9kPaQKHm8a07nuxYGrrSUzoICxGF9RkLR6nHv0m+iUK70CU3lSebtQhJQNb0Qp+Wr7ag9+/f65UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8801

T24gMTQuMDcuMjUgMTM6MTQsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9uIEp1bCAx
NCwgMjAyNSAvIDA5OjEyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPj4gT24gTW9uLCBKdWwgMTQs
IDIwMjUgYXQgMDc6MDk6MzlBTSArMDAwMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4+
Pj4gLS0tIGEvdGVzdHMvbG9vcC8wMTANCj4+Pj4gKysrIGIvdGVzdHMvbG9vcC8wMTANCj4+Pj4g
QEAgLTc4LDUgKzc4LDEyIEBAIHRlc3QoKSB7DQo+Pj4+ICAgCWlmIF9kbWVzZ19zaW5jZV90ZXN0
X3N0YXJ0IHwgZ3JlcCAtLXF1aWV0ICIkZ3JlcF9zdHIiOyB0aGVuDQo+Pj4+ICAgCQllY2hvICJG
YWlsIg0KPj4+PiAgIAlmaQ0KPj4+PiArDQo+Pj4+ICsJIyBUaGUgcmVwZWF0ZWQgbG9vcCBkZXZp
Y2UgY3JlYXRpb24gYW5kIGRlbGV0aW9ucyBnZW5lcmF0ZWQgc28gbWFueSB1ZGV2DQo+Pj4+ICsJ
IyBldmVudHMuIERyYWluIHRoZSBldmVudHMgdG8gbm90IGluZmx1ZW5jZSBmb2xsb3dpbmcgdGVz
dCBjYXNlcy4NCj4+Pj4gKwlpZiBzeXN0ZW1jdGwgaXMtYWN0aXZlIHN5c3RlbWQtdWRldmQuc2Vy
dmljZSA+L2Rldi9udWxsOyB0aGVuDQo+Pj4+ICsJCXN5c3RlbWN0bCByZXN0YXJ0IHN5c3RlbWQt
dWRldmQuc2VydmljZQ0KPj4+PiArCWZpDQo+Pg0KPj4gTWF5YmUgYWRkaW5nIGEgd2FybmluZyBp
ZiB1ZGV2IG9yIGEgJ3VkZXZhZG0gc2V0dGxlIC0tdGltZW91dCA5MDAnIHdvdWxkDQo+PiBnb29k
IHdoZW4gdGhleSBzeXN0ZW0gaXMgbm90IHVzaW5nIHN5c3RlbWQuDQo+IA0KPiBUaGF0IHNvdW5k
cyBhIGdvb2QgaWRlYSB0byBtYWtlIHRoZSB0ZXN0IGNhc2UgbW9yZSByb2J1c3QuIEkgd2lsbCBh
ZGQgdGhlDQo+IGhlbHBlciBmdW5jdGlvbiBiZWxvdyB0byB0aGUgdjIgcGF0Y2guDQo+IA0KPiBf
ZHJhaW5fdWRldl9ldmVudHMoKSB7DQo+ICAgICAgICAgIGlmIGNvbW1hbmQgLXYgc3lzdGVtY3Rs
ICY+L2Rldi9udWxsICYmIGdyZXAgLS1xdWlldCBzeXN0ZW1kLXVkZXZkIDwgXA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwoc3lzdGVtY3RsIGxpc3QtdW5pdC1m
aWxlcyk7IHRoZW4NCj4gICAgICAgICAgICAgICAgICBzeXN0ZW1jdGwgcmVzdGFydCBzeXN0ZW1k
LXVkZXZkLnNlcmJpY2UNCg0KQnR3IHlvdSBoYXZlIGEgdHlwbyBoZXJlOiBzZXJiaWNlIC0+IHNl
cnZpY2UNCg0KPiAgICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICAgdWRldmFkbSBzZXR0
bGUgLS10aW1lb3V0PTkwMA0KPiAgICAgICAgICBmaQ0KPiB9DQo+IA0KDQo=
