Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7413BC0C
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739098892; cv=fail; b=tpZj4B51dQZTC2In/phvuGDptXW55711Zh1CgmwHzO+4ti6P8AkFG1TJwggg2u7Z8kZsPRnkk/E75PnLKaLI8GyTWeVt0vRHuhrR8ss5egL387X6Egvch96OdDhANbfa4qCdz3iLnN8L7w7qYyXJ3OVwuqUpCOVlT8a93qqNxDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739098892; c=relaxed/simple;
	bh=DkBgmCxjsZIflwMilH68iA976Yzn8zyIE2CfWHWVSFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCcnBlLROAKhbXV/vnneGbuBU0yYHahsToeVGFPuEvNZma4VcQcd2nXbInSgMQNIRKSOoJocdSDBcnsIMW9tpX+PGyP57g38whZFcXcEDaqgjBLBFXcw+BzpHNWUQaNyknrqYe0oqUcPc7WH30Nw0KPQ5XYLXsNhHNK7QaE9xUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T2eSuU+c; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HD1zU8eg; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T2eSuU+c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HD1zU8eg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739098890; x=1770634890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DkBgmCxjsZIflwMilH68iA976Yzn8zyIE2CfWHWVSFI=;
  b=T2eSuU+c0m6A4fujgyAvCkmX0GNl5N7VU72PT9QfOywmMQA9YzN6tlAm
   hyxVn+LG2xoAHeHJQuiSRp6I6ibhT+3tYDMSyNJ2+4TWDK/NKvrCieEcW
   AI0vl4OZuvTIAIsyOZBGgWKvaPJnsG5DOXIG39sHbtiqYBcz5AG4/RJa5
   Psrr5IWxMdvO4zdclYZKLBeYzA+bdkT3rJTnbrZ+tIg2s/dvLhS2zf5AC
   Jze9SXbxpuC4WTMTIl4S0A1KUOL6l8OfEjearjq7fSmN+1XO5+PoA7XgM
   H/Nzlz8ysY789X13Kso6rQOhoRxmkvunmwaiQSZoTH3TXAp/G3ZoVHPYJ
   g==;
X-CSE-ConnectionGUID: OPqeCT2aQjSaiwz+A8vvCw==
X-CSE-MsgGUID: iQjdvWW0QWGKXrTB/QtG4g==
X-IronPort-AV: E=Sophos;i="6.13,272,1732550400"; 
   d="scan'208";a="37752530"
Received: from mail-northcentralusazlp17012055.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.55])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2025 19:01:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXteote2CttkS5jC1H3AtbrxwigvCzyAiRTKm0J7wzCRcWzmw5SmItcl4vg+qe+QfcUvl4lczUoDjOhZbOWA0tggoZGfLyOBIGY0ZH7IzTtNo1UHUyEJfmtmLbMtLAPtMQtBS0C6jgjZKaLKswBRAVdqLU5I+QC/s673No4XRcqaa+kALGvygvTBcXGFKrGlZToM5x4yJUBUxs3A7EkeT7L3aD83NJz5UC9yYQkALgpGY+V3MITf5gxxwThw0KvlLVMJdcPovBBoBvyuSzXJmz/0Fal0YdPH14XwF4zn5e1c1fuIbLaY+PvLkw9hceMrIkTeFxF8X2Pka7c7sRcEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLcrtv+Cp4/9vaw0/23sqx22pIJYhHPL7T168pk2egs=;
 b=SwkM2kZsSz9UgDqeKYwhw2nQwBParDRTdLrS0Oq3Nw4vGUZzV0/EkDgYsR6V+sIpk5XpjfMChccPHIFmlKqhiWxGpgJfGUDWidM8QnPf7IVBCQKWgK8mVQChJwaG5aFWlB8bSeJfpN6XGS9CB5+pW+HkET997sI1aw5iffmXk6lixGtz4UPN3Fj8Y9i7valXCqDC79DIwdSoht3H+oIdrCXuDGd5IPF6+9rN5i2PKSKwPgRMiHZJgX7g4RWx1Le3BP/CXG8jzUF8n5Tk7L0/6qf/e6Kh0rWWs68HKieqFsV+olkUWUC0T8RDcQCdSQ15bhNDkfsc7jLi27JT2reW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLcrtv+Cp4/9vaw0/23sqx22pIJYhHPL7T168pk2egs=;
 b=HD1zU8egEnYuD3J9fWUmTlAi2k6k5w2P61xemujvfOq3IAFKZb7AVxpo0veidlNGuoqBbWbigE+h6+p5OYBph8L+3QXVa55HKIoZ1Ts/m58mgAqfdcgw2+uZZKIOJgDD8W3eAK72S8+o+uChwEbdmJoM6rPnwnzIX7QyajmTkYc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8395.namprd04.prod.outlook.com (2603:10b6:303:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 11:01:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 11:01:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCHv2 blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
Thread-Topic: [PATCHv2 blktests] srp: skip test if scsi_transport_srp module
 is loaded and in use
Thread-Index: AQHbd+I9+Gy54Nnyrki5fsCgEppZM7M+1B8A
Date: Sun, 9 Feb 2025 11:01:19 +0000
Message-ID: <txeuvax5vk36i7ydy5jhwmlp3m754g6rbpuofsm3et5a5rmpo2@amq2cxopgchm>
References: <20250205150429.665052-1-nilay@linux.ibm.com>
In-Reply-To: <20250205150429.665052-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8395:EE_
x-ms-office365-filtering-correlation-id: d072c1cb-3f6c-4163-e405-08dd48f9152d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qVQ1SbFdbj/rAUB8aEshbMfe3c+MT41PSep1Gnt2jY7EJ0k8669OixbOsJ0b?=
 =?us-ascii?Q?ZbdyCLwh969141X9wc1HGkfdGg9hj/R3eHP9K47lgSJ7Fk7O55f9wFLGbge6?=
 =?us-ascii?Q?rKWUr9wb7e9hmb2/IQapVTgsqMfkBEMUToEEBro+m+0agrk/w6yzdWEkROmr?=
 =?us-ascii?Q?BLXnyz9o5CQhNvkzX6L6sXzWteyzxo8scWKC70eaLsSx0qXs3RyWG4PMkvas?=
 =?us-ascii?Q?vhp9GiVctNcu7FkjBcTOZ2YEWtgaqn/o+tFjR8aTro5VBMuqqWzlVzYbPf6R?=
 =?us-ascii?Q?Qc7xh0hkzJJ9MclMSm5cmQMjnZPGBBEIzw+VoTwe6FPjiPZpVBmCiWp8ta+t?=
 =?us-ascii?Q?RICheDbjIxCIaoKML9PdQbjpDzrVY8zCvC029JVRzY8PGi4F53Feuvb5J1no?=
 =?us-ascii?Q?MtNx3YbNKWI24KnzAmMoplPC8xIkHqRYhTqLFr10LTQqpsjNES2hgO3/0KOZ?=
 =?us-ascii?Q?0T7fX+7MT4daF37dYa3wmb8kjZVDnRF0ZRp8o23OSE3f8Oz3jhRh83CVl+YL?=
 =?us-ascii?Q?Sg91dxxyLeOLUgXgON+7zYqb85/IaY+WIQ2SuZIdPVWstPpNLqE8GJAhbg7V?=
 =?us-ascii?Q?U4K41wLq2ooCu+pHbGFunP0RgVeG8u+36awKaH58egi++cx9P+DQ2FL1E3/k?=
 =?us-ascii?Q?Exl4A+HU3aBRihJrdLjOwsPlvaLEKUuraRZU37mZCRat56S00XQfIhxEBb8e?=
 =?us-ascii?Q?MiQ5MiyqxaGWasjI6B4cL69Am/XG0hfFNxxX4OZyuOT19sdzQhJ4GqvnKeyZ?=
 =?us-ascii?Q?urVKW6OtnhGcaZQhIMkxQ+4bATgEYWUToqYk88lLJ74louEoImzYebr4nhug?=
 =?us-ascii?Q?4/r9gmVAXL7niEwwKHWNR/YvxRKsAI6RpjsP26HY+lgFsWVXehp2NbDOMraI?=
 =?us-ascii?Q?3D7Z6FSfI98+dRciG7b4sZPKPMRDde9wj/EFOtDb9p6lxEUHziBEQKHyTJiC?=
 =?us-ascii?Q?FaYdJr0Pq59og4OxrcpnNRyrDQVTBK85ImqqBRci/nsTf7c8SSu0MejG6upH?=
 =?us-ascii?Q?ZP10x+Ib6TNwZZtWSklLtXKeglQkh1FEws5RIdBXUIU9p0opA44al0x6OWcD?=
 =?us-ascii?Q?FXiOUGhaB6penOdcgIZ0IlSe645T6M0IfhVmWXux+WZJbvW2tGU/u2IDl6mk?=
 =?us-ascii?Q?rZHvBpHK9q6wiFHV6dvYv8nsY4gf0P4T4nuVOOXK0XVhJtA/G7knHMdIQxDI?=
 =?us-ascii?Q?uMa4WPYw82R09X/kA+9AIAYmoY2nGeqfm7T7NEmmPAnSoVxkGIF4P8JcOaMc?=
 =?us-ascii?Q?8nNzyGHR8VuebbuavLaEHmHfls6qvWpgzTSTSrplndziMoQYhmu3qr++d2CE?=
 =?us-ascii?Q?laubkQtMb0QjwZyX38XnkKkKoASByNvIQy7aut00xYAw3IyBfLLuOlbsU0Bp?=
 =?us-ascii?Q?zt/LXv8/hqegPvKuZFun+dRxa6QhBUnOtfNlGRuL6xJo+uzO80y7ffJTaNSj?=
 =?us-ascii?Q?YzNXlDFh52UDGX/3HNwV/Uj3TD8F8nKc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h6+RcTyiDaSAzDEw7qojElH5klG33XQCek2jp8FWRdmvsYt44bQo93PMNDhz?=
 =?us-ascii?Q?kkzNo63358uAqi0eGpyYDpacpZ6EFIvlfxP9pwVfpzmpbC8pAcKY3pDzUUTa?=
 =?us-ascii?Q?uiiDbwOOOUvIf/wb5waKxI0lLmP334XkNEj1SonuSw/e7WG+Fdc55WvKBHAF?=
 =?us-ascii?Q?i6BNxfdV5rxzNFwYugx1yumI0XycEUo8PabTttj/JKEvKZEmKAVA2F7Uzm1c?=
 =?us-ascii?Q?8RVAq6sU3C9iYJnvAZr3dc7kjTPfAUnszpV0+/3ilWToHssGbNEEDqfahOmY?=
 =?us-ascii?Q?TP4GrhzNnxwosOG5PI7fkjNuzO97ZHGg3hC53uCVhQ6vbfLJeiTG9GavThay?=
 =?us-ascii?Q?TZNEhnzTs0eDbRNn05pVU4Bl+I2ct8CgVXkrzNRBWs+707RK8dxUtUSoo1AQ?=
 =?us-ascii?Q?ylfZQMp1peDji7go+NXZV+KJhSfn+Y4ayJO1zemT/AaUObkbA51Sz/laSxE9?=
 =?us-ascii?Q?JdwWiF7UHhkyRUupNDHogNMYM0lVPgqjYJBAhrUKGo72rZ2qW2Y/aDvowusG?=
 =?us-ascii?Q?sbVRXAUy2jZ63i0a8L7OOFpkJ8kbZZtXSz2A7zieL8Am23IDfW3P8XZwRg49?=
 =?us-ascii?Q?qOo3n1avtE9Jy44t4YPv4DF7+crL3lIpcU9DwutVjy0cMXwumiT+UYSze5hD?=
 =?us-ascii?Q?B7qk6RWdjfri774O6Wga4P1Lbggmz6vVRZEqEE17Qa/CXRy8Z7LJmmVqGn4j?=
 =?us-ascii?Q?Dzqv1ALB2MBW3I4uqsBvdbkt90D6ZWBkEyhdo6Uk5cbi873O/HkZEzXxdWxH?=
 =?us-ascii?Q?V75IbLQ1v5iefqJsrTLTVgsh5sqFa7IKfZlX7Ld2q/Y0Ach/7z7cBP0Lv32/?=
 =?us-ascii?Q?CTZIec+dU/kbn4utD2u1eNGRlsbhj2RkLewXegiU/7PstMHfZSDjLtPgUK8I?=
 =?us-ascii?Q?z3wLDIi5iTKS21I37KjZ6ddI4E1RZGxB1QNJxKntDBock3jDibnQZ/mce2Iv?=
 =?us-ascii?Q?l3Jzl4vUfZROYeWW5Zwy17EshKfEhv8iEGIZOEFW+2rHKNzzTlWwZ2u8DuXj?=
 =?us-ascii?Q?nCtGN1Th12vueXH0tD3+jB6dqFVpdLE/tM9leksYPQgxwVZzqLbRiFgkUkmS?=
 =?us-ascii?Q?W7QqL1L24VokjHbQwzQ7GN+HU1O9MZtPgfELXW1XRECO6mfaIhvY3lPP8XGP?=
 =?us-ascii?Q?HOXgCRf+G5Qids9WM57Bw7GHmJBCgjasIDeHG0THyi4RGZJUU1bNm9R8EDHL?=
 =?us-ascii?Q?ugs9pPL+T5kdown9dihr1EzSzITLuEKvyWxVxYTPic7fW+zZ3mZyPbm0cdXB?=
 =?us-ascii?Q?HTz1rMVi0ckgCb9Q/p4QiUSJxQwa1AOqKYkS3SxQBCpBQdNZazMa+6Q71BfN?=
 =?us-ascii?Q?2ujexGTmZ+K6aVENzOe9H+x/aqA4KwOcMVhOmrLl/8BOHxzdz7aXkmJSd8o5?=
 =?us-ascii?Q?b6xcxCMdBHJs8yIm9VgSqKqwMH8KjNXLtfDip4eBpwFJVks/Vz9OdVq9KNr/?=
 =?us-ascii?Q?Yc+rUfLlYlztw6IDdAHWZ+nxIvOE+h2aKxQtGFsQSHZANYWlfmoQxGcI6O2m?=
 =?us-ascii?Q?0w5YbJfkSrJmZWdprj9yK6QPJk2foa2DWwdrdGDJqXn0V0zq3nKCrcw3WpYE?=
 =?us-ascii?Q?6+lmWELUciBhpFGESQHyIUoxCk39B8MPyAIbX598tQuCuskKSEA48yEme/lr?=
 =?us-ascii?Q?tTMB7ppnq870hKPh1ew5OlE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36A1DC0F6E6B1A48B0582A5717B78176@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+3WEOyU5hu1U7wEnFYE6Yh2CElpnJe0iUtq+Nhir9A6El94cgp1YJno2we3rTJtba3jtRJDDSyTVSXvAuiSMNp+Y8WezIAtGw+7zt3MBV9FsdT/MTBqYg0RKyd4/9ICQibGN6x29lxmRci14pGj9ZAQM0cVSS1R/73MDfntAQaYiWM2FYHg1kpyZrnbxx31kV2cifkWfMGtR1x3pocndjXcVkgPNi411VjlOn2KHry14NJ3wdQaLytx+eKLOcxGrEItAV2kodanUfMtTxDm5WDXba8L0uB1+E/m48u3zbM2+5g6HHHpFjoKDMQhUDLkW3gcBj+ZPAvLXrvQdJYERTpkJqg28Q8zpUyPkCbjo03mJeUV8PT67RAvPt+FdUGnExQZFdlM3kdTtv3npzvYu8iAuSncOiSKtWkeJZjcP2R447rCAelwadnjf4BoHXTugC3f1TPeZk4MTnX+vgl7TvvSzbNATD5WDTDFP5D1Spn8RvIZW6OF4w0Z3cJ2LIchRcnL2abFmllBrnbHVISWGQmnbWVdHs7XeJtSzHh5LVBwlCwNhkFj7TE65L0GbNRgoiz9yFC5OAoyRkISogAOWNkOVdd7RH+a3DF8IneElLxpj80KNGJLw14JHR/HbyaXx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d072c1cb-3f6c-4163-e405-08dd48f9152d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2025 11:01:19.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPLyHO7AyktN3RGFoQbEz1KUxpkRSIFdB+dWx7Y88gplFGrYqFSiKStiGaXpVJS43TZ3YzkGZD5lWhmV/UKjoK3YOA49epyhlS4fMu6j94Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8395

On Feb 05, 2025 / 20:34, Nilay Shroff wrote:
> The srp/* tests requires exclusive access to scsi_transport_srp
> module. Running srp/* tests would definitely fail if the test can't
> get exclusive access of scsi_transport_srp module as shown below:
>=20
> $ lsmod | grep scsi_transport_srp
> scsi_transport_srp    327680  1 ibmvscsi
>=20
> $ ./check srp/001
> srp/001 (Create and remove LUNs)                             [failed]
>     runtime    ...  0.249s
> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Perm=
ission denied
> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Perm=
ission denied
> modprobe: FATAL: Module scsi_transport_srp is in use.
> error: Invalid argument
> error: Invalid argument
>=20
> So if the scsi_transport_srp module is loaded and in use then skip
> running srp/* tests.
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I applied the patch with a few minor edits. Thanks!=
