Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F913699F
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346980; cv=fail; b=cVFPboDA7dALNH1jaqBZ2em79zQPO3aKPR7FFePGR5ueDrFnqTM/apc7TEdoX65gnHU+8XCPH9cV++9WGE1oePT2OC3OXhLPjoG2D6Fki9axy5ux/LrWXSV4v+x79DxQlJeaXBak4sFe5lEBDG72s9oW7Gxc+0/yfViA7xvSs94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346980; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ao55oEYtU5RJifvQO5jyaeNd6pzt0oFYfKwu0Pp97sNybRGnbxwKO0APBV0Ql/6k9hGr7xsxCuwkBPj4z/ueG8nkc/2aEt7T9GlgTtoXSKzfHhMMvFXjYrVKhJYlCQxGrtXRA67KS+1P5iDK4vZWCF8woa372kz8QCtwqU0QwLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SwwhAsQs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BKapiqf1; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SwwhAsQs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BKapiqf1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713346978; x=1744882978;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=SwwhAsQsqSek7WSO8FzzE+0BO55180LqkJivLWX7I4Xf+6IrHarg8t1k
   izU+EhbNXQUfigTER5p5yvXPgJSQ4bIhx/kJhPmwERGyzyJ3SfwSyRGLB
   7+QRinbTtbuE3CFLf8QFaWacVLUTIo17wedf4kyNBN+ZQaY6FeEmYfN/F
   xOjDwkzyjPk5JPO5+hpFLVk/QlIU2QInEHj0y16Q7Ojos6KzBQ6edsOgj
   cYAzedGgIfumWKjD1GaJb1Q41Fd/QgBt//5F+oCjvjWZFZZkD4Hdxaylc
   yfSwAEe99RQ4sthLDnFODXEnthtmocamWNIK9vh8CIeWVIkBC9tfRsm7J
   Q==;
X-CSE-ConnectionGUID: GELGGuSeRuCJqxAgm1FngA==
X-CSE-MsgGUID: jJU1vSM/S4me9+vayj9vxQ==
X-IronPort-AV: E=Sophos;i="6.07,208,1708358400"; 
   d="scan'208";a="13641450"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 17:42:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMqPLpkkHeHQQxEUaxDR+BSVVlvYks+2BitfQPx0xQrKTOV7q+A+ydlFiV0XJ91r+/EJMvRARXna24LUGbXRIpJbkuz7B8oIO8Vn55SoH1mT4qZGXpJqrsQC0nkro3vM9FrnPKNhrrBFDaW4d4QOSCoPHWC1KDtiDw2fitIRGv3Uzw2vIrkPyi1RmXoPtQrGw8VeDEWMAxQms8t9rZ5/F2AgS3VSTzqCyAc8STe6jQwPbm/47JhyXETVMDtm2UfWhU0cefCi+PunAmZ9CjXk/fXf7+UqImQgJIZTkPlhFQ/OGNvKUP/q8Wz0lD0mQBCzu9BJC1V0kq4GGUYMW81Z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=TALjF9QXuCg64v7J0JFN3274/jC7n6Pm553U08UwoWdGHaEcWH4egtxEj1pJtS3+oqybZ0dZFPfNUHHjKALtORTjF5tH1RyCt2bgaikdy23JJCBXaIudIHInd2+dRlgmlccPsopi1GaiCcGU++y3HUPWE3EUkTxatST6fWwr3EldOuLPehhna1MZzzg2qTIYTswG7kUuMeeOOMfWJ2xvXGNzJCJcAUaCOWFx3MKCY1CK4CeVymPdXyA3tQK0fqQlU5aqB1ZuTtl7o06D63d8tiL6Dm4/gT28Lmq4+FbsMjbC/6ymfllUIVBC3moaazrUWH4VcEGD4649LAD5J3RpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=BKapiqf1wMcRXnMu+splIbbRaV99I2QDfwA2PyFkWt7qQP9nLans3PTbeVw2i2FrRSD1mRKWeAMvNhJvZKtogkiQdO64wWbN8T6PswTsWa7pQlC2hp6eRurK5YUnq/B9BOpNrSoZgaM1qp2RNly9+9fUkF/Ua1U64llSfe/0oVk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:42:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:42:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] null_blk: Have all null_handle_xxx() return a
 blk_status_t
Thread-Topic: [PATCH 1/3] null_blk: Have all null_handle_xxx() return a
 blk_status_t
Thread-Index: AQHai+35vkx7z3SS7E6iUUpg+oUnuLFsP2QA
Date: Wed, 17 Apr 2024 09:42:56 +0000
Message-ID: <5e4972d4-4d42-4606-8628-e4e5fa849b72@wdc.com>
References: <20240411085502.728558-1-dlemoal@kernel.org>
 <20240411085502.728558-2-dlemoal@kernel.org>
In-Reply-To: <20240411085502.728558-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: f7976e13-db48-469a-251f-08dc5ec2c2e5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ubfhh3GYRoiuCL7+Msn+quPdIJYlAcnJIccef+CTIiUGewbRBwXS2+vcHhXqtJZuIhWjoATrD97UH/ia0JlslTRmPYo2gL56Da8Sl/exegQKQfn53UjGCPG3pjYZ4VkHSeSiSz4Loc8EfHLVGCznVZnT59aq1i0Gm/QHMDCMYUXowladJy26un7Awt6QTEyjJuTJZ/lO49jJewL2zlQPY+DhVRk86sHULxwstLLbAHYarbvdYerJ5C7p0YQV9T8p8uIn+eaHhiaqk2FJRl5JxfU3rdtDvBCVbXb2wGx8vNitkdaAuBm7NqEICwArPnKYFkpuQP6M7mAaCXUzfbF04ts0LrwuSOZ4yU4vOtbZ1peDB4BQDnd1YhDb8qQJytu0gd3+kq0bqquUvnkzdlXqrX0gdv3hKRNQe6X8NDjSosyY75wuiu/xqmgrBN6Oj/aTTA1SG9FLWOQsT26gv84fqVmWzq+RnNuKGggrY0GcCUI6nLQkOENmJSVEw2YBwCFvKPoUrv1XeNtGjvSn9XPl6paE1Ic9PmrmZmCmtQeeYWZyTFcEyjjLWROquKaiCetCfsV2Lwe2oUyWyl2ci5fWFQztyU2Oo5HXz/IvMRLcRb/ybTLGalzFIRGYkMy/+Jj2zgNozg8R9ivzyuPSGojmhhXhEkgJUvZbylOi3NyNMj4Bqt6EcIGMXNPjfze1C3e1jtgkJk0HlZ+tJSzSE4JsGUVNu68VMPP6b0MSHKFttuE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm9zbS9mc1FRbVltNU9pdEF1NlpFSlVTbjJlbEkrQnBjVUlTN0hkdHBwZTZ6?=
 =?utf-8?B?TnZpK3hBdktvUXQ5azRIM1JSNklhRUJxVlBUTjN6TDAyMXJUbEZJS3R2cUlF?=
 =?utf-8?B?TERHWmk2bFFJWmlBUlRKRVNuWXlUd0thenowcm56cHk0TUhmbWNER0pZdE0w?=
 =?utf-8?B?SnhlTmR0eTZFdmJDdmw3RkxtZjN3ZThyUldnc2FYUmFnazBnNW9NM1dwNmRW?=
 =?utf-8?B?VmlTZS9RUnpvblA4V3BzNVh2SkZwNEVrZm14eTV4YXBKQVBLSHhod0FPbFl5?=
 =?utf-8?B?YUlNV0ttZ3RMd285UWxvQmJtbm9iZzF5UCtNdmVqS2JWczFUUzA5VEEyQjFz?=
 =?utf-8?B?WTZQRERaY1BGemRwWHN1K1FoSXBMTkFPL3FmNG81OGFrcDNpVFN0bGZKejEy?=
 =?utf-8?B?SUJBQUhiMjFnMElEaXVzTk9HbEI0a2srVjFRYXhDV09pem5iSFhWbmdMajg4?=
 =?utf-8?B?bHRYQ2J5ODR1VXJ3bnBUSWJwRzhTQkpKbjNDZjZsZVVqOThvQnZzMTliUk1k?=
 =?utf-8?B?WVhoUDFSWFFTNVRaSVlBMGh4dDc0N0pRZnlMM3lNTjlqVmpWVlJSZ2lGWG16?=
 =?utf-8?B?LzJRUmZPallZeFNJMlJXakw0SXJkR2tUNVdpNTR6L2hxeGtnV1l0YmYzNXpp?=
 =?utf-8?B?cDBmUEpuUU4vNlF2QW1kWk1qV251OUdhWVBQaUVONWRzUmovZ3lsbDlLOExH?=
 =?utf-8?B?YmgrNEQyZCtpOGVxYVFWNHRNOGhmbGxLU1cyRHZpd0paWVJaYXJGMmJ6eWVN?=
 =?utf-8?B?SWNUM2lDR25rU2hMdW5rZU9vdStmT0dodUY1cHQ4K2NSelNKTlBLUkIzUVlI?=
 =?utf-8?B?SmpOU1BPUEwyNGFhTWxPME1vT0tOVHN1eVVNN1ZDNTRoVXlmWWxXL3BZQWFD?=
 =?utf-8?B?b2M3Uk1EckZQRlRXdFQzZVBsL2R4M3ZBTWk0NTc5N0NTaGRuSnZxeHRXMmNZ?=
 =?utf-8?B?U3lPWnVYSUZ1cjcvMzJpaGhscFBsQ2x6YjV2TllRL0Z5TENYYkhWQnlIWHkr?=
 =?utf-8?B?MlR5djdybFEreEZJaEkvNitmd1Y5cW5SekRlcDA5VnhRdXd3ck1xWmlrM0NH?=
 =?utf-8?B?aUlmTEY1RFhac0VVWWxMTFkzMTQyM01IVlZucGxxREgvVWdIbm8vMDBycDJS?=
 =?utf-8?B?Tk4vSGluWFR4a2JJUjRvUllNMUthbEdtTStubnZPUlQ4TWRydDFWWk5MMW5E?=
 =?utf-8?B?b1BLV04wMU0wK3VvOGlZQTFQckFwWVdGVzdYVjVYQXVaVnQxQ0c2YmNwMks0?=
 =?utf-8?B?WnB1UmhRVlAvVjZBVTI3bGRnZGt6YUdqNUx4SkpOaVBOMDYzWnQ3RGxjNkhO?=
 =?utf-8?B?R3JQN0Z5eUZ0am9qOE1QMmcwNnNPaE5SSG5MbUNyU0VWbDRtVk8yc2tGM0Vh?=
 =?utf-8?B?bW1HZGhZWFRGSm43OUE1bnVETTNGY0pHWnNXeDRydTRsUitmd2RPU2gyVllr?=
 =?utf-8?B?UmhaYUk1NzFnc2FrYm9OM1A1cWNJTVZxVjAzRDhTOXJjbTFYSlJENThUNm95?=
 =?utf-8?B?YU43Yk5YMStSRjBib1RTR0lzU1RvRXNnTXIrWFdUVDVCWnFvN2hlNDVCc1hI?=
 =?utf-8?B?aWY5SzYxLzZhNy8zRXZxRU1MU0ZwVTRsejBYZ1VoU2dRR1k4QURiUmlJVXp3?=
 =?utf-8?B?UnNVb01JWldKWnd6NlpqTjkrNjJWckFQeVRjOGViRHpuaUNWT1lFL21DY0di?=
 =?utf-8?B?NGkvWVNnOEV0YU0wYzJMY1hpNHhPMW4zZnFtZ2llUE8vYnNndnFMOFJ5VU94?=
 =?utf-8?B?S3dld08yOHNTUWllQWVrYWZxb0Y2MWcycndKWU1jcVdGNGkzTGVQbVMzc0tU?=
 =?utf-8?B?UXlZWFVFY2htR2IxUVludG0zWUgvV3hZYTUya2hSU1R1ZUhHVFkvZkZVY0o3?=
 =?utf-8?B?b3lVMGdBcmxvNmtzS1g5bnkwVXlXWU1GN0hlMkZoMHpwY294endSMGJQRmhj?=
 =?utf-8?B?SzhFbjFSS2pLZFJpTnhUOFNMWlNDeFVQWHUvZG1QdHV1Y3VGeWExd3o3VjJm?=
 =?utf-8?B?NWU5MzhRZWJZR2NjOVdvRmkwNlUwR01xcW5LRUxMdDhBSXY3UWMxNG1jSlNq?=
 =?utf-8?B?UlhabTZDa0RJa0lxNkRrUUROMkhKS0NGR1pjNkNIZG9iK0NHNHdHVUdRd1FH?=
 =?utf-8?B?SFRNWVdDR0JvTVlzMFBjNE5rSG5uTzRkbTVOYUx5VlJLUGRaM255Vk0zNyt3?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EDDDD4B967DD54BB53DD63D57212F8A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v7A2+Xg4rNYi92m3y3tU5yQGLVXpG6klCURxk5eAct7rFkoPRSg6Qy/eWb/OcaBS9dABcLmBL8lmHROE6G/SGndo79uG60PLKf7X/e0BJUbeyAKThzYr+MVdRkOMqLaSLJHv7ifTbw0v6dRUXQD24F/5zsAT92L7vZkcLz5rBmPNIIqDai5OXCSB2uXcS7hNGrH2oWxzW1DVSdGnFoaBiYXCoC/GpWpAftXQfr/GeC5CXQJJJGLZo9PC54TQHGqHdg18n+RIIpVtEJuSe2q771uSY+PoPiktjzWdlvx+Ge6Lc5wr5OnlE7OZJMzs+9wUHPFUvhvf62Mrf8rk5ysmWFd9cFdqL+Lgd5GN5ReeqP7paBOYelfflJhyNkzlDcJT3dTBx6MWgIBomWg4DFvPyDEeUkuC6mSKsJd4FrgcoLkd7yXbiqLMdZr6VQsjgMeUg4o+AfpMEsI3eNuPeMAf4LnbOFtzB6OwMPGUEt7fQuZ1H1X866Uisk/0JXKhU18GW8cZb2OMjY1TqUVdFlknZSFXg0eiLUDHRWJ3tTs4iIeUq69tKEgpsWCYHEqhiYDf64fyWUXqzYc6nYSHevPWohR6W4J+4fACWzqJy+UH54KfclEb0QvBt7Tqeq8A/KTT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7976e13-db48-469a-251f-08dc5ec2c2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:42:56.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UteLoXfqmPFJ33YY5VT1Uk5z1kHhi41ElEZWuZ6ayFKCI2zSp66VA/Y64JsTzTfDov+ldFKAAtN/d+52FzmXIxqsqHxf2gLscGkZJ1ToEaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
