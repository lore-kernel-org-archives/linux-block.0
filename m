Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BE18B1A
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120033; cv=fail; b=pl71FekEVhM+csxpd/QAqVW/MdHE/1jRIL9jEMiNwZ6TfcdqJWZ5c8vlo2pjTqy2stKdelf058lgK9aEK8I3eAKEEZwW38VooprJmYzHRvQk4gwCivn612GuQccbuIlH4OV6UJxvYCJr9YfySGHzytLR1kbVcMRrcZLBTCANHlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120033; c=relaxed/simple;
	bh=F4y/NusY+Rf1qasYOGtM/SmpFXcbBs3RQC76kJAU1LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nu7frvG7eb1YGPGmAPGglDvrgdvBFu0a5O35oAejMLNoeX/ufmivJ0cehWDZBgjeqpFbWIsCUInV1PptsmxY1x2LVK0vO7G/vEcMT/FFkOA1Si1qY1OPd68DN0aZbhaAl2asEi6wP1Z2RtwNHne3sqy4yH7isax6z3+7aA3+BNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OStMRbY2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=w+B7qjhq; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OStMRbY2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w+B7qjhq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717120031; x=1748656031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F4y/NusY+Rf1qasYOGtM/SmpFXcbBs3RQC76kJAU1LU=;
  b=OStMRbY2gI02v4yjvrWB43TOhgDJ/J9c8wfrZmN2oTPJ9YWys74E/WLe
   M0blNiroGmbKru7L8MRK7AFJujvBVcNwYHc2Iowv09P5bgSxuSUdlp4Cb
   KNeH0RjFDpL+wInv9MXpirtqJvj+ETgcencsiY/Xhjs8JSRg9A/9/BiYr
   WmJNlMcy7cXgFC9mNJwJxVO1q8frWGZDLx8ubi4BiHmz3UQnIEl8FbIpu
   TuaLzJ90/Z4OKS4XohvytPIwSn/rkxiRztX8LdJ+PmGai3lsTEQ3cw6Bp
   /iNalvF0H05CXA5OaehuX1PNntdIchOeigmwkL2tcIQNvlOZMUFeFxPHf
   g==;
X-CSE-ConnectionGUID: xL0e2lsrRqWxxaL2e372HA==
X-CSE-MsgGUID: 8kTXjhW/RomqwE6c1BgGJw==
X-IronPort-AV: E=Sophos;i="6.08,202,1712592000"; 
   d="scan'208";a="17788882"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2024 09:47:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoobcaHn2r2NUjVTrgN1AxRA4XmMDZ2mIS/NtIAewne+MM4ZNDe9n2RhV5+q3HcfPniYnrx5/O2SUJzbXQglEqsYMYzEjHkJwfWLdrt5n0gJI0Ggq3otmNnupMc5kTTJ3UbouFhUkHivLQq0z+RIZz5OB0pLjiwdLCUaHFxqDHzKay1rtq15t2kLbcBQ2+Zv7G4tclsJA68XTz8hr49M9JI+8YEJzKzrcuBZ4Po6P+SorGgtrp5HBZxwaZrOTqscdHlvp5G+1GCjOtARs17Mcoq0L8Z3AuSxe36srdKAZ1FLYHAFGZ/oMH4hIu3vErkzBB3lm6cwky8kMcIuqupdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSQAlCvbHFyKI8GZfxwn4t0/DY1rHcFdFfQVDvQeCvU=;
 b=I2t75djpSzCMQpSs/xUsktna1Ip7uFoW1qfmPipFk0sBEBv/akJOKu11IggEjiJexpGeqcMj/CtMAp/HhSsm1XIMIdCBqZWrMFtq7uGt+HCM58cX7jiVW2N9AEkNPur0ulyuW1oIg/HGDKMCCPXkz/8vuliEDbG2dTN0kgmhS+3Z1rhmk3moSlYsVukvCIkOz3VobyR9rLkQw7ScgsgGPIWPjsn8k+CSRlPSFQEVkUuqc0BdzK/7joNBxMj6OCchEZ7Fje/fQl0gHLDu2Ms6jsf5HQ1FnUq85kzw0Xagm29wZjNKYEvKtTJNn0SUS9gSzg/TLWD1HCQYOvC95umB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSQAlCvbHFyKI8GZfxwn4t0/DY1rHcFdFfQVDvQeCvU=;
 b=w+B7qjhqnXEPmmItss5S806NcwgIywB+BfDQnUTQg5PkdV1MC+qohLd1VS9VcoNhvwkiw5Odx9oQF8dAe48BFUwo9olzrM3/ulk8V2GwCPi6sZdcsgprtvYhErmFVzZhTLx6TtJXSL3fHiEryvEk3wJ9v0oNtG0s9h45deFvdPc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7320.namprd04.prod.outlook.com (2603:10b6:510:18::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Fri, 31 May 2024 01:47:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 01:47:08 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH] blktests: fix how we handle waiting for nbd to connect
Thread-Topic: [PATCH] blktests: fix how we handle waiting for nbd to connect
Thread-Index: AQHaq6POIzbQh7y+cUGT2zs6FG/CorGi1NoAgAfokoCABeQvgA==
Date: Fri, 31 May 2024 01:47:07 +0000
Message-ID: <7n5i56nu4mbewyp437t467bsisuckmdefl63lmsbdj5zc2oz6u@yscit6ywgevj>
References:
 <9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com>
 <p7qubalwunuxohkn2rfxejl2jkfpcfqp2d722xra4vmqpiofid@7niwetngzy5u>
 <zv2aiq3nmbvpnk7oiubaxuxv6b4tie26ojfm3nnpboos4sn7qp@rnm7gycicli3>
In-Reply-To: <zv2aiq3nmbvpnk7oiubaxuxv6b4tie26ojfm3nnpboos4sn7qp@rnm7gycicli3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7320:EE_
x-ms-office365-filtering-correlation-id: 11b4c1a6-539e-4937-7463-08dc811394bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8hTxLI+0hwVzJnnsXQjOS4rchroTykzp68ldIVpLG7WfyyVsCbmoE9VKic/y?=
 =?us-ascii?Q?mxLeyvgbIy6VBEDF/lYbIY1CZ2vq5xZzEv9LwsFtGx3XUAo/CzR7F1XHQvLw?=
 =?us-ascii?Q?X1mt8nS6SRFUPGsdsyh71HcFN67FyzC4QvE0ncWt7S2IfjnYMyBhndYWEKGn?=
 =?us-ascii?Q?SYVoOZnu/MvYzYBkgtHsfuL32CsL1SQ5zW+6hqRsNzL5dTJZJXlogueV/fjS?=
 =?us-ascii?Q?32/684V6KjF94EFALSTQtAakWFoyH5EqHg1CJLlKuhbJAK1wDZJt+98Jyjbj?=
 =?us-ascii?Q?etL3SEDIOX1EWHxETOXPnXM63vD18vTv994EhHpJfuN/IGW6InuK7nYir1EO?=
 =?us-ascii?Q?5wsS1CRwoQM98lmAWXpArUpu7uokEMUcZRjFXk749T6rhFOuYd9gy25BKjrc?=
 =?us-ascii?Q?cS777Dk7krmskDDU7PizrKsSl5xt0PGpOdCgapWEqmzLB/yamWIa07HBqEot?=
 =?us-ascii?Q?CkEg5UL4NB6LuZk1bOWdXgAzrKxEdXcRYOac6zjeXq1z9pPR46+2FNPkdqKN?=
 =?us-ascii?Q?65+4hKf4lNo1qJH8gpiSB4i6hGA4Ol0Y04PoVtiyTT/OqOIQ+0B8Un7+AAg3?=
 =?us-ascii?Q?4rrtrZ6ysW+SAvagKVOXhNZ+rN6lD9uPzDelRlag+7cP2tFUIKGCopMsU8wB?=
 =?us-ascii?Q?s2PGha1OxkLe2F8cNBvjPLL53qqm+6/ou/1xKNAE5dccFNrqF67WxzEH8IlJ?=
 =?us-ascii?Q?xcJkUbRRZY26KiwbR6PSEEn0hlDE4dZj6EW9r6++d1oQryW0TJ90yXFWsHoL?=
 =?us-ascii?Q?4iZNOgNG93IMei+NBqrXw61TN/dZWv4f6PlPE0tNpl1oxjqUMB9T1yhTyUrR?=
 =?us-ascii?Q?varIOJh8aGneAcarYtkdH6EOfEsVglrDLBeSWrdFwBHIBZTNE1nakhgSs3xM?=
 =?us-ascii?Q?4vHsemmcxfqlIxGr8RLj73sG7FozWUpGYIgJ6mg4ZnbUeFzR0AM4rLs8Z5wq?=
 =?us-ascii?Q?zmiuCvMQTPjiVtqp/nYYJldstLNYhNQPGlxRMZS3mD8kcBAzv3HJRwSSN7gO?=
 =?us-ascii?Q?fWR5ayU3e3sXYIbXgYqv0HqLO++wIVQeiXk7brsjp55UlVOP0OPWu6aKlT1F?=
 =?us-ascii?Q?btjHn+RaacQlVdMrRx8qNqX6//awQzf9jm+1sqKSsVAmf7QGI4BKvu7CbnRp?=
 =?us-ascii?Q?q48fKyI/X1gyPOfSw17+mrBGPuYdX27pHKqBqiO6cJKlU+eawPrT+KFJd8Df?=
 =?us-ascii?Q?3J1VWBghEAkW38Qdg7NU1SFOq8o3vpcT1ih0S2AL64xTOWu1h1LYwpmiXcwG?=
 =?us-ascii?Q?Dq0gzQGxubbRt/etAYv+5Zf2pocTXpXhPKyFsfAXmA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RT26scjFf9zuSpfseiT9YjwcZc5yfFgSkXQZFWB6Vihf4wZbhojeZqDHV2Qr?=
 =?us-ascii?Q?p5f1tczsrUIdNAz1FesJFhHv7hlOJJU/yYxIT3mm9hxd73Lrnl03s6c7h4xM?=
 =?us-ascii?Q?PC8awDZZf3RRL4bShB4ZHMvJMOrox2UuhtylRw4S49KVcE1HkXrI6VEqenkN?=
 =?us-ascii?Q?fjISuDPIB6NdzxDUezsKPKF1XoWMG/6dR41QaklAjG0QoWd55GzldsKyeW85?=
 =?us-ascii?Q?gG2RJ22hEmml6JhyvqsEuRdtsaQ3i49Y8N+LOS9RnCJFEtMViDAxplu3I24p?=
 =?us-ascii?Q?ObjpkezT8Q4+Vw3u2kqQTEvkRff+D8BHm1H3BAhEiCUkWQVLXGOk01GF51Av?=
 =?us-ascii?Q?Lk0s1PNMQudGvpUtU1Pq263tIfkhcBnPOygEexZ4yDVnwrJ8430rPJ6J6mZh?=
 =?us-ascii?Q?KuACyuZOBR+7XVZ8Md3qo/ZkSxbuWK7mSiBWcH+by1ZJxvRJCpPZ3daqMpjW?=
 =?us-ascii?Q?H0bK+ktFY9b0f+WdctxG/N1MYCciLKVtsAXjKCSEUB+XjPCIg+HDYvgh3CBy?=
 =?us-ascii?Q?XcFjmdI0QofHfBWIXNTIAI2Qr9v8s/loKhbRFkcCgCDmIOHAG4RPt+rqQvVb?=
 =?us-ascii?Q?bDmS9avVKFHBvlOfrrYxo9+352HAJYkrYkOCZTG0uH8y9l4pCRL6AAjxwE1z?=
 =?us-ascii?Q?Ra1RPZ3AXo/RsKd80APq+zLSblV07GZjkBEuj1T3kBmfZd8VSwpTvA3Aelam?=
 =?us-ascii?Q?dTftzYACahoW8I3pFt/hebW+LplJhI3ZKrXTapdTqrOiGCKA+xiJ3MlumOU8?=
 =?us-ascii?Q?0JxLezCddj+Vn//MaRbnR41z0Q2RoS54uNad6KvG2DYgxvgGRztXVLh6ecF+?=
 =?us-ascii?Q?YvrhnUnta6B7wriMVKqAyx3beTmNETDpIpK27v0baG1Za9Me48Gq+HZti5yM?=
 =?us-ascii?Q?aPctxH5k8dVjtglztKI2RwuvG5cO5WK2s38MsENZ6PfjYDyU5tE/awmgkRa2?=
 =?us-ascii?Q?97vjv1iZsUbYzt+qojVwC616eFNKN9GQYmzeKRAe7k57KCPWbE+kjM8G2MSB?=
 =?us-ascii?Q?blqhGgMaZFr5Ce9gbQ3Q94KOXRI9wa8Vvq+fvcN4g+Wp+8oMyjTbIXAvKe6x?=
 =?us-ascii?Q?ldh8LHo1noUXeJnVuE/g92Q+qeymTbN1fkiyDb9IORV9xFvGr/ZQBtkthSEG?=
 =?us-ascii?Q?Hve/yURzB6QuOrwhp8cx8jXOF4eZmt7vRR/29CT6zBfqAKAV2QdZPjR507mm?=
 =?us-ascii?Q?9Iy1KPmm1NtorAc3jgUzMdHEhnnlK7kDmxFOkmUKN/fL3kgntjhSOZsIdfoh?=
 =?us-ascii?Q?IOQVcvkC27lK0THQjUu58sl5zgI6Y6R2ZrEuKswgStUkNzhKjUsY6S5zALiL?=
 =?us-ascii?Q?VXmHtH7uhQaMf7pmD1LTcHN+KESGu4wgKrwTwNCLlU/Ywnstb6a4NwR55+BT?=
 =?us-ascii?Q?kX7LDfLB3nPMV4B+9iJ16Gd8cAXCDWLQEDB41MNHZZ1tFT7rqdSsYs/XlMUr?=
 =?us-ascii?Q?KKvUOntXRs+kH/IV6gusJIf+O1Re7FWyZO/Wpdlgzb7cuh6SY0088gGAfm80?=
 =?us-ascii?Q?02oJDt0koSCo0NqUItUB1GCLddTU4X9KN86iRwyZgGqe4091vv2jc0eMqf4w?=
 =?us-ascii?Q?Cp61+ipjTs4aCIfOYnrwsfiRBZa4lOgarlZSapAtA9Qfb2AvZspbssS64P40?=
 =?us-ascii?Q?jwSHYXgEN9xFf0lFIK4yjFw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <848BB9C033640F4D97E851C6EC358B77@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bX1g4nemKOYgHOdvCCXtz1+u1OZM4KvEBjcc7Ipo3nIk1Wx++V9RBHwuusi0ev3ou7JyIGM813cf6zLa9vr6M2dhWWbJoekB+1YcOVEBsVzLjsbWVH+mD1/wBmbFs0gis/Dob+9kts0/PLbSbvNC2Lsc1q4wg8Sd4+r/FcZe4q7WYSUZ7ob0rIzlTF0jFP9GLT1on4mZwkXQD/sZbAFzBkCSq7FsGqZDW9ptd5+7gHeQL0iUi8LpUE4eMsPdUpleuERZIo4/TgHmarwTipQ+VLrsdwkPVljLtKsnGAHOcvYAuuBJXLfH5kJyd57fIFo2WAEiYkLnLPCwVopxDA35nRGmHpIgcomWVUiaLHYv1EOHFRzDIuo4ponBh+qUCeJ42D4fy58RqNhHFggGmeFU3K2qjzBwVTEAY9LTUT0kwvvBLmaiLboa0/T8W7TK+FnqctRHQyQd9jWAuu6l+piCeJ/aGE3vWg+L8meSWldqUZ1npA9VbOptzCfQROv7iNK4w4jhK+ptl3GwtmzMUibuNwQI8/Gpud6xzIIphqxPSJpjplJv/V8jLlLJTjfCMlwKckewqPU8SQwiZBlXNnaYFDORVe/T4cXiuP9w2bNHd2KjgKhDQPOqHUHA8VYStDKQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b4c1a6-539e-4937-7463-08dc811394bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 01:47:07.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hz1a3xBf+3YsE5JITTyjYW7oSIKP5vh296xS1ZXebwZksWAaxn8JjFHt61yLSOv9J3+UwWA1rQ7SHm8uzKxUICuOzy8CjQ5G8e9sVErSLuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7320

On May 27, 2024 / 07:49, Shinichiro Kawasaki wrote:
> On May 22, 2024 / 07:02, Shinichiro Kawasaki wrote:
> > On May 21, 2024 / 13:24, Josef Bacik wrote:
> > > Because NBD has the old style configure the device directly config we
> > > sometimes have spurious failures where the device wasn't quite ready
> > > before the rest of the test continued.
> > >=20
> > > nbd/002 had been using _wait_for_nbd_connect, however this helper wai=
ts
> > > for the recv task to show up, which actually happens slightly before =
the
> > > size is set and we're actually ready to be read from.  This means we
> > > would sometimes fail nbd/002 because the device wasn't quite right.
> > >=20
> > > Additionally nbd/001 has a similar issue where we weren't waiting for
> > > the device to be ready before going ahead with the test, which would
> > > cause spurious failures.
> > >=20
> > > Fix this by adjusting _wait_for_nbd_connect to only exit once the siz=
e
> > > for the device is being reported properly, meaning that it's ready to=
 be
> > > read from.
> > >=20
> > > Then add this call to nbd/001 to eliminate the random failures we wou=
ld
> > > see with this test.
> > >=20
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >=20
> > Josef, thank you very much. I've been seeing nbd/001 on my test system =
and this
> > patch avoids it :) The change looks good to me. I will leave it for sev=
eral
> > days before applying it, in case anyone has some more comments.
>=20
> I've applied it. Thanks!

To: Yi Zhang

Yi, I guess this fix may avoid the nbd/002 failure that CKI reports recentl=
y
[*]. To apply the fix, could you rebase the blktests for CKI runs?

[*] https://datawarehouse.cki-project.org/kcidb/tests/12631448=
