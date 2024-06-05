Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A41A3BB5
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588347; cv=fail; b=T3+8wO+nW6bo1KBjq0XlamURuIz3LODQAUGXklhsLzz8GTCWWi7L/xbHd3c8fu4gR8qLWafhoIYuVKRddML9r5qz1DDGrwvMWHdftD43u0SLqvXMZlvbmrhSv2hw98baKCadWaAP/3ad5woxh2Cy3Q1xiJPE2jspfF9OiqRrVhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588347; c=relaxed/simple;
	bh=6IOyAUQA3+26zSq5UoxlbiU2A0XXEgbvA3CXv9vJ6Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QASQA4NyS21FDXp0nXJrWy5jyjnbLCQ5lqF6Vs5gvw/61hLkxHoamjXcm0kNoICdp16iCOZiJr02ZzdhfOVzjYYyZv5Cy5la5ZAq5os8p4NYrIywHnzNv5UC0lFuodqjiBci8G+MXc/3sl7wbIYWk8ByfJWsPgJb+i0kzpTHJF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Qh1Yonar; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B4rT7nM4; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qh1Yonar";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B4rT7nM4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717588345; x=1749124345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6IOyAUQA3+26zSq5UoxlbiU2A0XXEgbvA3CXv9vJ6Wk=;
  b=Qh1YonaruAzEPtTbKgJKUahaoQ20s5W0NIUZn43bUI6KO4Ni3suI/toy
   y5rJscL8uR/R3bCnjWtCYMj+A+agysL8A5ESEEhHVy9BA4jkNkVFo4hvu
   RROVA5ELPGw+x/0oBv8hU3arr75iQbgH6xmqUzcSyfP4L9PuvKxrKUQBA
   PoOnDg9zGWVLTxXn30TYy7z1cJCAOeZtMrxbLvxp6IJSBgrAUqRTZcR8K
   e2BV1cazPIlNQEJNAVNygHhZOeyhU2o8D+FSw1WE0E3Vj80iCAD2DINC0
   6b+2L4FLVS1Ryj+2pJzjLnsX2Oty6xwiibFRGgXBHbl2whMjJefgPb4tv
   g==;
X-CSE-ConnectionGUID: x6H2EFo0SDa5mn0Ul0bLdg==
X-CSE-MsgGUID: dfwolSKwQ0y489s036aWEQ==
X-IronPort-AV: E=Sophos;i="6.08,216,1712592000"; 
   d="scan'208";a="18266088"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2024 19:52:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nntSuYJ9fmGgibrraQfPfOVra0K6ZfxECUZUN8euvWFFVu4aya5Nl4wnIWuMO/omiz/cjA7Xi47ATvs44xI/aFz9lFympffz6f3wD9pS6v8ULQLjXa/MTTqUSXLFjA7/z+d55UFfO/+f0eiTOzkVP0iCq8YbEj6gCdCeZJoppOgruLPVm3MkWwLhugiOTw34JHODUpWh1Lgj428L24JTkVCkj+lKA1zdoQ4nsbmMwcJW4tOdrFbGpOOAJMLaYGxdLyB9fHZ1wsSg3v5rSdSOmnrwEa3+cyPDaMahIrG8UEFEIr0ayl0aUgsffjYwSy67J0z+h/wCZxqTe4R55nLsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHmNhyJ2IWttd4H5qmY2kuBHbkZgXpFBfMOmduWE6PY=;
 b=dVQfRc9dNfEMmosn0zgPi0rmEeKmw/UW5/Bf2bhZpyqjROCZUhV0IrfXyJT00szaGVSwu5zSauxalfuQc+QknsQ3HYqKEo2p9EMfC8QBvtLpqwF/JA4GwkeJqIpPps8kvD4pgDC7HWoRfF198Hd2LlmVY9l8VTBKtfBLrtUjMyW+Kc/DvulOFkGdg2giW79hyqG3QHdPY8YP1soeu+cEr7ROwLgOw0zHVRnvz8i7IelOQBCNotrmCpXiBxkk0t5qN/5ILdfOnlBBElKHHQzx1Yx+qQFxGt2+5BIk1f2dCf92dbOImmQaMLsy2qESRFKq1I64KhPgqn8wF2iUr+ayMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHmNhyJ2IWttd4H5qmY2kuBHbkZgXpFBfMOmduWE6PY=;
 b=B4rT7nM45AOqb3yuRVsiZeAeLUNrdRO0GJ4OjjoyTncwLFDGq48ekw0W423bcTTKkxA49c0EMM/irZBxm20HFfnBSqvVzqjh97YAR6lCwYlUSDOUKDi/NeFk4Wb6x9KGxmtiT1/myxPY101MSOhDvI8QmKNxPWbpo6YZTdB9U5M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9481.namprd04.prod.outlook.com (2603:10b6:610:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Wed, 5 Jun
 2024 11:52:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:52:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH V2 blktests] block: add regression test for null-blk
 concurrently power/submit_queues test
Thread-Topic: [PATCH V2 blktests] block: add regression test for null-blk
 concurrently power/submit_queues test
Thread-Index: AQHatuTvd0olZPDMMU2XR/h7zKqLxLG5D9uA
Date: Wed, 5 Jun 2024 11:52:22 +0000
Message-ID: <a4djmoku2cxfxhxrhgdu6b7vqyi4idqdzza7fx37ps2hdyorld@ababkd4e4zzd>
References: <20240605010542.216971-1-yi.zhang@redhat.com>
In-Reply-To: <20240605010542.216971-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9481:EE_
x-ms-office365-filtering-correlation-id: 4e0d21c6-df98-4373-e9da-08dc8555f5e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HzZ5Fphh4gYmCZzofXRrEphIKLgpFtRej8MAZeAPY4ooLXDwQ60K/9HNb44q?=
 =?us-ascii?Q?4AyWCjuAouz877jFSD6jzlnlAyxNmkIzS8VhIHxGU1DMS67ZLxoOeJQ+g6H6?=
 =?us-ascii?Q?LkH1E1M+LCMd8BfcYmi4zFQr3XCz+g5hpyj8OjsAS9izPFF1nkE5Mgnj0SCu?=
 =?us-ascii?Q?L3PZpshRPw+sOkZtDZUA4D0K4yQoryElXtuD1XLiTt0boaF0TtrVuRJ8JE3e?=
 =?us-ascii?Q?itd3lAmo5LNwMRwef7LWoVL4yKN9eNeyxw/mneLGZdpE6wTO5HF32PeHoBnI?=
 =?us-ascii?Q?MTXBG/wLtbXr75hFj8Cokdkd7HglWkTAkGIGLTbxVWPW/uuDxLS+FOCiq2sL?=
 =?us-ascii?Q?vGrdobrjpZ1ucgcns75ryEjCjfVCRQPx6KA6UycvGrL0mgm8bsyTYY78QX/i?=
 =?us-ascii?Q?ya5lZRxoKcg5V+Dhn2WnS9ZeocsSPmTT+iEM+BizrV+zkOmJJiYZ0MV/NuAX?=
 =?us-ascii?Q?8om/n2Wk7e0HOKKc4fFv2ijTSwfFhmA98AyhSWMEZsreHekHqqTJ7oXu1k/w?=
 =?us-ascii?Q?ABRJnGYFMMK6RQgU0jIe64cXSvx6nU9vSHftdu5bmvEHu+BeR3jwKnjuE0Fb?=
 =?us-ascii?Q?5NyyMdFB/ZsRIoHJKr6DUWmpp1cS3jv7sbDPYVdsuZ94Pa0mnzQOWKhbXkgQ?=
 =?us-ascii?Q?4OtE7LMCq0v8GgTl7louEtjmglgqxz+deGtksYfep2LL55xsQUUj+4ZKK/Oa?=
 =?us-ascii?Q?YmoplMGSfFw0a4Qx5EtPDkUTWabElva2KL2RKscAqNsXa78NqoWsgC1xeXdi?=
 =?us-ascii?Q?RdnsomsUxkuZek1cKn9Df/d4akld49jozcAWMXJvTMOsC4yfM5xcMskFlD8W?=
 =?us-ascii?Q?XJidK0Nqzxr5BiW3WhiFIy1kZw3sG4DL4pJbF+GgrGIj50fxrNZqOBLGaALu?=
 =?us-ascii?Q?ibZkarNWUE0HRFOJOqOQBnp1fQV1oOu6RAv8PngQXyc9+BxItkLuokMQmM1V?=
 =?us-ascii?Q?RuEhhxr93mdzCyKzm4JxwgauUcCcd9sAgsoFmBmACRbg+GZ1GV5o4p6skUxc?=
 =?us-ascii?Q?7BGQPlry01JLWkKCs3CC2/Iyl5dEhCAFj1G5SvI1d/pvf/0kDD0Qtsg+29um?=
 =?us-ascii?Q?Jwm8dVfFo/XYL4fGfj5B0iNLrUVW5iA++WvI4WMyr4yISTgB386ywN0vkyrw?=
 =?us-ascii?Q?DeR70kNknk8vGqyTaxbqDYMjSCSYql0cIl/kqfKGV9MgH0ZFf+8Jd6tBfMhK?=
 =?us-ascii?Q?FdCYP2Kph/4+XbDEl7uhii4QiliDBv5bZUUq9LTtLfxiwQoY13nniWloER/A?=
 =?us-ascii?Q?Uq1X3NrfrjzdIDmCnGyVf4lhjB5CK4t+AvGvLeonW9t9LlkGEPWOUfWzN4Po?=
 =?us-ascii?Q?Ba9vHGHD+n6s5Im/+4T6A4otjcbDZcC/rpGBto+SoO6/S6N9cqj4giEHT3y0?=
 =?us-ascii?Q?qdjfkB6SFimAghCDUB0pgIzMFuF2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DEoPhjtIlVN8RzmDVO/EjKBinK3UmzrvB8StgT/kuFwuq/TWKAdk+damLoFs?=
 =?us-ascii?Q?AqgcnjV2GRyZo1zTd/kncYdGYqqA3wXP9w+/V9/vaPIOrXlpJv6eggmFZ4/i?=
 =?us-ascii?Q?ORw1G/N/DLzxKsrgkkqgd1KmGIepNLTJC+Gg62hI3+lyLfQKibuktPlVqMIl?=
 =?us-ascii?Q?FECtRWaN0QkpKVpUpBoC0WsHjwO1EjNfaDEHd6donRyJnY7bn8cZwkVT/yhQ?=
 =?us-ascii?Q?AHMTYPd4sEvt8sLBi/51fXNprXDkWXSan9EX1Gi1Ve2+GOazQ2z3eVwuBsoa?=
 =?us-ascii?Q?1HEIj36Q4uObDQHv14XwcWO3UioyDUMiPkKqj/O+0jJMh0/ZNmgmNr4qu/gW?=
 =?us-ascii?Q?pBZgHm7RVf/OR8yyZNKntDRsJ1txMionz/W/pkj5JQ6KcprSo6ZmHjXo2XZ3?=
 =?us-ascii?Q?IDWAPU9lRTLpIOHw1Im7kb3DrmSVsp24VYOMPGbZtik7/njVDHyyrthtafGc?=
 =?us-ascii?Q?Cr/zQciIZ9ju529pT/WI14PlekmzfBMtDCAKBpiCt1kAYKEEL+zFHuSqw9U0?=
 =?us-ascii?Q?IuhCRtx464xiHnUVa5koQvl6BHJssRl2SA5yDe2bugfgabCOSvuYnWrtx1RD?=
 =?us-ascii?Q?G1sHYEGO1iKJNoIaCBVbCkdUZ47xLxDg7e6gxHhrHbNYRlW0gt4fHs7CJwwB?=
 =?us-ascii?Q?3yDzm6oEaYvjtouD/Z/5Th5YTYkbfZrLCRFybJgXjW96v8/MWVpC9l3oBSXz?=
 =?us-ascii?Q?XK1Q5rrvbNM26bq+DJsHxqbzYHdssjDnEELbxirmCuB0jk/dV/wfSn5poQ2O?=
 =?us-ascii?Q?H+649uLqcrrjOMCQ7E8HvS1yUTEQlJO5WxGEgKeMKWw+4h/4LId/TVVdN6hk?=
 =?us-ascii?Q?rrSrqAc8sO+lCQM374zOkN9rdNlrAEIsHk+JsWCDfjK+es5HRfh2sJteGQY4?=
 =?us-ascii?Q?Q79Qo2+ecH+wqx62UnL6ySOYEkeOTCkuAWuwVpfjB12p/ldn7PQhU5uK4Ehi?=
 =?us-ascii?Q?hto3gdYMr5ZkoscALnCdjBjVTN07XCy1RonIWzoDrm5a3aCybYVS4c6pn9hm?=
 =?us-ascii?Q?HAjALKORsIslPDmGaPhPuv8hv030ifWUY+w35xTIoltVl6y715JKIKsY6ohM?=
 =?us-ascii?Q?3z1td6k5H9LeGapeKpzMcHuhJWq3WAUe0AfvdhrVKbkXznLjPGvoSkTGoK06?=
 =?us-ascii?Q?N3sWKa8dY1saMDCB0VFHIEQ3dP7r5Y9bizkpz1uJlLsCSx4PQ4bd4XEt4+9f?=
 =?us-ascii?Q?Z37DnTg9Sa3dGxAceBgoASjGe++E0X3EcG4nsA52y+Q3juyLom8FHQZhIcdr?=
 =?us-ascii?Q?xJa2EqwNy4141NzbrjvOGAlo/He8sAms5C+kCSSIPQabixjOxZrweNxqk+P4?=
 =?us-ascii?Q?BpnrACdkgKiI6Ndu5jyoZZL2mPRcTdOO+AwKpnRh8Dp4Ld+WishvandgMkJt?=
 =?us-ascii?Q?Z2ZTSHIpLHFa+MwMxDdcjoryh2uUPcXTaBYsxUPdDutVpkIrkVqcXj3AfDQ6?=
 =?us-ascii?Q?Ltkw2Smbh6eqg/aSkgVGnwQLw0W2kO5FU5HathhPWAtlhS6LJRJlne0iYFFt?=
 =?us-ascii?Q?HujJa4kncnU2E3Cw55en/pfVTNcG/fs90S/XbSjkixLwHz8pqFXvQ8sKzUKN?=
 =?us-ascii?Q?OXxSga5LTLNbRhE7GkOH4ctcFusALmVAu1oQ0qu+Mx1iH28+7lqr0RKQ1eq1?=
 =?us-ascii?Q?5BHzhlXwJliuhNNdwT1tFAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2357A4336962B6428291734376BCE44C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qJF3svtjfBWvT2udkkqNpamU2ya3HompUo7sdajD70jzVM6xu/QeTur4JGEDMAIuhmweM2tfallz5Ob0d0azB9OLSwhgGmQeR1xUpAbhTjxKFPDcH2QWGwOleDBGmb5ljyEtGyYUfdiRTQ2gjcvcF/ajCvAKCUkhXyrLyixgOuM9eCPwviokhpRwvhSf9Oib9x3huZyua0fV6fJr1rJUl0fsTNwgTp9YIoveoH4ug3XEPIRAKbk5v0uJ2mI1jOjG/rl1EhVBNz1JscpOugsfubKmfUwuq9CWYziDcn9QXCsliKoWJRXX0WCXaStE/ZH1vUaJzY1MsA/hsgqrtLto+r71fS+bCEMSQGRkCTxYQa0EywZ1bd1pcQy/EIfp2K5uDFxCxvyZDwR89rz6yeSICROL4KrgLVVWlnd4L3B7EJJPb229k6DUiOvP2zgQA58n3aTVvwFhDXcmEj0tfSP5ImAp5mcUgs1mK6VZvxGTgDW3Og8u7QMBudtbWDeXbiuNjcE6ECbQ/Xjv9oLnJy4ilHfW8LTGsuSJeNbB5VNtL4o/xswTn4Vf/sdX3vrxWsFP61KvFTk+VE+L8eAOT1uUkm6X6FS+FZcarabojj9m2nKdYtBGtmrY8ScNh9E3tXU1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d21c6-df98-4373-e9da-08dc8555f5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 11:52:22.3578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+bJceeTWsMUQWQ7soexFfZa6i1Tzm+hr0B4GaESku9N6BLqoYgKaJcjZLQ5ZAXAbXbsDGVIFtii4AiVMv2RTjRwwWJD0b/ioNoPrMLI5yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9481

On Jun 04, 2024 / 21:05, Yi Zhang wrote:
> null-blk currently power/submit_queues operations which will lead kernel
> null-ptr-dereference[1], add one regression test for it and the fix has
> been merged to v6.10-rc1 by [2].
> [1]
> https://lore.kernel.org/linux-block/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7=
AP7TPnEjStuwZA@mail.gmail.com/
> https://lore.kernel.org/linux-block/20240523153934.1937851-1-yukuai1@huaw=
eicloud.com/
> [2]
> commit a2db328b0839 ("null_blk: fix null-ptr-dereference while configurin=
g 'power' and 'submit_queues'")

Thank you Yi. I ran the test case and it looks working good. It passes with
the kernel v6.10-rc2. It causes the hang with the kernel v6.9. To not confu=
se
blktests users with the hang, I will wait for the commit a2db328b0839 to la=
nd on
the stable kernels before I apply this patch.

One more thing I noticed is that your current patch requires loadable null_=
blk.
To allow it run with built-in null_blk, I would like to suggest additional
change below on top of your patch. It,

- calls _have_null_blk instead of _have_module null_blk,
- checks submit_queues parameter with _have_null_blk_feature instead of
  _have_module_param,
- does not call _init_null_blk, and
- uses nullb1 instead for nullb0.

Please let me know your thought about these changes. If you are ok with the=
m, I
can fold them in the commit.

diff --git a/tests/block/038 b/tests/block/038
index fe3c7cd..56272be 100755
--- a/tests/block/038
+++ b/tests/block/038
@@ -12,9 +12,10 @@ DESCRIPTION=3D"Test null-blk concurrent power/submit_que=
ues operations"
 QUICK=3D1
=20
 requires() {
-	_have_module null_blk
-	_have_module_param null_blk nr_devices
-	_have_module_param null_blk submit_queues
+	_have_null_blk
+	if ! _have_null_blk_feature submit_queues; then
+		SKIP_REASONS+=3D("null_blk does not support submit_queues")
+	fi
 }
=20
 null_blk_power_loop() {
@@ -36,23 +37,15 @@ null_blk_submit_queues_loop() {
 test() {
 	echo "Running ${TEST_NAME}"
=20
-	local nullb_params=3D(
-		nr_devices=3D0
-	)
-	if ! _init_null_blk "${nullb_params[@]}"; then
-		echo "Loading null_blk failed"
-		return 1
-	fi
-
-	if ! _configure_null_blk nullb0; then
-		echo "Configuring null_blk nullb0 failed"
+	if ! _configure_null_blk nullb1; then
+		echo "Configuring null_blk nullb1 failed"
 		return 1
 	fi
=20
 	# fire off two null-blk power/submit_queues concurrently and wait
 	# for them to complete...
-	null_blk_power_loop nullb0 &
-	null_blk_submit_queues_loop nullb0 &
+	null_blk_power_loop nullb1 &
+	null_blk_submit_queues_loop nullb1 &
 	wait
=20
 	_exit_null_blk
