Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67512032D
	for <linux-block@vger.kernel.org>; Wed, 17 Jul 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202125; cv=fail; b=MFUcpQC14SEY5UHA/QVdxcjLlc0sf2nsOLVlJMau9ujBYYMhNAunnkpk9q6dhuBkG4Zqo0pAlZGqv6oTg5jXDisL1FI3/3EUlBHDLNH7UUI4ka60BdxvCYZ2RdyP+TonbgrM5nnphlKOi3XiVoeEqICDkYkHV8OvCMApMCYShwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202125; c=relaxed/simple;
	bh=gldv3mA6xqmGFuqDUwU2bFpHm7vu8THXtYp17hriztU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7hfM8wW5K23YGZq04EbiOLoZ6MLrSq2XFwNTFfNxB4e35S4+oit9Yjs1JJ5bnNaARJiiIJeGgE53m6xyowoFqz8iHozRrSTKABI8jD6s1q+g32Zh1OHmDUTAqvoAmU7mj+SwN4yMhqL2OIimLrPzjoybKz9vCd87IOtWxwcnbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ERbIpCgV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cAp8/6et; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ERbIpCgV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cAp8/6et"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721202123; x=1752738123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gldv3mA6xqmGFuqDUwU2bFpHm7vu8THXtYp17hriztU=;
  b=ERbIpCgVm9leDzs13i+kuGGs1/8XL8CX4Ad0nVWcZ06M8nnMHon4PWDL
   oHsz6mS/mjPkeTrBfyYkApaJ7+fnJD5RzyIhWmdceNLPa/P5PWIN4MxFS
   4R8Lfai3K8XAKAcdCrJAsKJkou8+PCLpAylsIZLQsu1awQVfqQtbYBiZj
   9UrndSLXg2O/f6sXweXjGWFfGXSWNusWViSNvteyTUY03cJCjALwLvf+4
   Qo9oFsfe/ZlunNv8Npz4I3Lay/gUOoAkaDHaRn6WUTuCWDUZmGXfEkWqR
   Den2IWn4rUSDpApuiy+AQdSJPRyA84E4CxmW5rrL5nzlgCiKtcbWHlT5T
   g==;
X-CSE-ConnectionGUID: bmoFH/IDQLCwL5L4tmh7jQ==
X-CSE-MsgGUID: nTDdMttwQT+tIphRrYYbHg==
X-IronPort-AV: E=Sophos;i="6.09,214,1716220800"; 
   d="scan'208";a="21389122"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2024 15:41:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDDsxiaet6Kl4/tqxVqNJ8ExAdWuEYyZcTbVJulV4uic8zrUxdhiA5AgVx+qZFUEOTu2eAHFk4jqeoXggud3xZsK2nog7JpvPe9vvg4i4LO3rv0L1T63RtH81C4uV+vq19kOIYoH77NEw6zW4CNLm5mWELz++vrpiyFA7uuJTOoccmEnEzNEJWeyY2jbG0fAEritDhFGhG/ndkBrWsecjqcWLEOsKPILPOCGZiZuwlBNaWhlWDiEUss11/PLkuKsuGAZYLl7Q1ywVzR+7KVXirF2SxLZ5ms/vsG5X6iM535REPxWInFoSvegizludxfc0mDgGzrGs3WeClNfnsBJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gldv3mA6xqmGFuqDUwU2bFpHm7vu8THXtYp17hriztU=;
 b=VYdbL/IA8tSF4zHF1HkeQev53tdl170YfaoyFO8+9O3fl2nqOjh+nP20aiA9x0MOg6alAaHgZFhJO4mc/A0n9dCJyZTswPlup7Nmhxbsm5GW76BjZ6FuhfKNInPhVSVzLNDYSfFZ5qotyRhakZr5BsR4L7km4juyOxbZ3dZXIDign69m7To1p7ux1+6oA1MjNkGghey68ZdWycZIkB4vOxpviCP1k4NHGaTuYLfl+0MK/qCPfmrMx0mm28t6E84iAdAG4lACLjziEQuK08SfaMiEhH4DYyp+hkKE/BvExBtD3dblDWKoiq0eQSzroYsHF2vTEoDeY6a8GplOw60LHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gldv3mA6xqmGFuqDUwU2bFpHm7vu8THXtYp17hriztU=;
 b=cAp8/6etDnO1TjbT7XFoQ0LURVRbAy6X/29/u4qfpiFj7Ub06q1aZthoAgjTjBpefPt/WfB6Klao1wzAb75FArNXTQEj+I2t+sWI23YfEhbEpjs2f+4RMm5SVBB5YwbH3tNUOlFvachbzTBuChU7t/n/CykNg+MN04JVvJ5VMdI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO1PR04MB9535.namprd04.prod.outlook.com (2603:10b6:303:276::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Wed, 17 Jul 2024 07:41:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 07:41:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Thread-Topic: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Thread-Index: AQHa13ZloNQFnpI10ESZaT4cm2k5SrH6iqcA
Date: Wed, 17 Jul 2024 07:41:54 +0000
Message-ID: <iviiquxyax5ofjcnd7g45wwgbjy7ikikfz5oqdnuz4kf444gno@xpaa42btwok2>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
In-Reply-To: <20240716115026.1783969-3-ofir.gal@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO1PR04MB9535:EE_
x-ms-office365-filtering-correlation-id: 259fd5e7-201e-45a9-5a43-08dca633edcc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TiBIsrJthrdZfj+m8xhkIxmX3ZydPnHsGc23YVnj2BR3oPkrTAMuVPw73HFE?=
 =?us-ascii?Q?9cOYQivxsgSeGYDJC502yBiQA4f9bmFwMh3iaRxfr/rtWjutyIS4bKgm8zaL?=
 =?us-ascii?Q?JrsxutXGZr/YwqWvymE420hdCzjV1BCRjesHOL/pz20ib8MQ+oz6y2jmtVSx?=
 =?us-ascii?Q?ctTXm4igjzJ+iywawvyprn51SHsheOEw+KB1O8EXQTxU0ZOlAmeCufk9bNeL?=
 =?us-ascii?Q?zdrR9WHMDu2QY+qgqVqhL28EyXbwQkXtoxoO8VdAC3cL1PhdJeZpBnlBTBsY?=
 =?us-ascii?Q?Y5oH5CaeWl7KWv+WAm6XJ+HC8E5gr1lQHtyF89E+Vuxu+n632bvgSa/Q72o7?=
 =?us-ascii?Q?fHS6+9fyavE0Fduuw6MKjqTMErBqduhJjidtDnD5K3FqktsYL0Yuw+IZ/RHy?=
 =?us-ascii?Q?MWckJDYiiK+EIbW6bC6zU4sQllqKj6qQ6Wr4GD5UDYRr5scQg9gB4o8ffY5R?=
 =?us-ascii?Q?w9vK5GvwBTl27SwGX2NMFCXPRY3rwjfVm7VB0jKPq/61kMdf7RZ1yB/NKgFe?=
 =?us-ascii?Q?U+pvvw703zTDXST/3x6LSTbmAK2ZeVtFdL3N4iiTBVskav5xYDvOuBnpy0K6?=
 =?us-ascii?Q?pWY08BhCRD9fuDIeAerE/f+lDPOUWMuqa4QTnyk9wiu6vw+e2owzMrgE786j?=
 =?us-ascii?Q?3tP1Mu0tmFNcUhn0VEvzjX8PG6y89WgtSlONKdWCuspVxukezkk04RFlT+AX?=
 =?us-ascii?Q?Kirzf2S6kaK6pmTYbjJ7Eve9NkRcSTzLS6rwEPAoFK87IdY98g3ZxveLx2A/?=
 =?us-ascii?Q?JkwsC4O5zHed4F3lXtb+eFmYwgAN9DCKJ3MF/dHsYvnS0RFQV0yVewTuw0s3?=
 =?us-ascii?Q?hABXaV0PL6RwEAYEh4mo0rjAmiB4o+vhf+BemkXZBAcgXhYw+oPNHOUmU1VG?=
 =?us-ascii?Q?gu4QVZ3vY38bIpnHoPSfoE735omPXDJ5vum8eFZZT0pmsmhOrlB9daJJbU77?=
 =?us-ascii?Q?Ix+nvryMYQ4jPlEcSXn39okKGXk0b4itnr+IXjTe56f8MlUX+L1Zu9i8fWjO?=
 =?us-ascii?Q?dMN1b8MHYZUQM6YSNtQXYuvLlesSdXca//9zJH+cjdhmywujqwXuEAp2gUwk?=
 =?us-ascii?Q?P462HvDHwPpjasnHU2wSsuFMGnz+pGdN+7nvezualxJdg9CVLXcqyQD/Kc2/?=
 =?us-ascii?Q?7P//CrawIir5Ws1AQ+TS3WgWrxhJpNNQ5oUDEICsPjRyJmWg7ib83iUHO8U6?=
 =?us-ascii?Q?fcm9GR24K/oV9s0+vwy7wrmJGHFTFsBze2TZAqnEtOkJlzMlbcfoBxItmRLE?=
 =?us-ascii?Q?JSTwAghmFf4KrQa8+HcSE1lnoRpPWUCwpvpui/RX2LwZwlGNANuAtJyXdUPT?=
 =?us-ascii?Q?vhogTio+DxxJMJa/TWtewXYY3SMbSyiQLNLL4BlB04aU3oZ9LHTrmfRNUtC9?=
 =?us-ascii?Q?VkK+SbTf0+ifRC6dhEcp38SLusCToiYvA00oDH0c0QV63ZiN9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N0+Je8VF+R0gMxPRJIGa5GnWfP9vzXWwstjDlK7IaPWqJAVsRBQA8AJbot70?=
 =?us-ascii?Q?J+zYyQtTimQVy397a3aikahGKnouaoujMoeTNehpHxZmWiwD1hCJqfpH8S0z?=
 =?us-ascii?Q?a/v8mKaUIfJpDOF1tRNYdu6SvcUjn0aImtwTcnsJ0nNYVPy2dbuhDWx0Hzkm?=
 =?us-ascii?Q?lLcifI/whPsImB5ia1TqnfnVFjPK28Bec9gG9pxti24GjwjVKT9TASAKSfrK?=
 =?us-ascii?Q?p2lHxfZ8S/p9wwa5DZo15jDssIZkMLI05gGhuLJCQtWmwnBnBpqTiVjJ1z9l?=
 =?us-ascii?Q?iJQugDuu5U/DwPb/hQDxkfVA71UO3oxRrwqvhLbNxUACrHsbXHx2Fw8ri8Xc?=
 =?us-ascii?Q?H1gC0J5tBlMqjVwAs45ujmuC4n1m5wcf0sptSeZkFa7xjL9qyd5fB+2V+iBm?=
 =?us-ascii?Q?lR83JNPJ/zLio/l0aLL+NuRYlkr4ACQexVM4WbW5SVdMgzdtlS03eq9O0Rdw?=
 =?us-ascii?Q?COGm42jHjw1SsmvItiC/Y27qPpXdyyAGPLd3GOaINq0q+ekJuBOSJS+dvWHt?=
 =?us-ascii?Q?d1c49XR8Xka7dBP/ZTt83JmWfOeLhwt3i4RbP0c9W41r4fA+cpCnCVgG8OKy?=
 =?us-ascii?Q?IDgpo56pKepfnbDzbEMJje3uhAH0kB2D6qJ7xEofCAtybiqWouQeXiQC7qW7?=
 =?us-ascii?Q?uO9FwxkbBAQTYkHrGdn+Omeyx6EIx5re49n0tNoZfeNI5GNLGJdBvuyrArGk?=
 =?us-ascii?Q?UKMmUzWqFY3M9kVx9G2V5CGSnmpssHuYclRMzQysLK/jG5dopWj0xft1bjYt?=
 =?us-ascii?Q?xsRaDaM0EfecYfiFTKv3EIoaS0BgSXUbkaXAeI98vdr7j3o/wGxEscHhMEs5?=
 =?us-ascii?Q?T26/Ilrq6rDu1NZuXOaZ2g5B/iTnmCP2/Em49dG4M6uWpfoWqMMbzfPcEv0g?=
 =?us-ascii?Q?5eV/4FM2cmzFVlsoLturSgrQ8JIKYSyjypJmhum9v5a/5+SKZfcRPfcUBP86?=
 =?us-ascii?Q?AJngrrdK1/yC/b8IArSa2YBlGaMG8hKh9krhTLlZGcejd0g48lpHGs9RswRL?=
 =?us-ascii?Q?cmUmjsSrDEKI+Ip+OZDKXUIGP3X1H952nMXNfQg6uSAblPP2/HouU60U1UAZ?=
 =?us-ascii?Q?PhhBg2WYQ4TM9PF99T8Ty68y2ccZNJuOQWKjFWVfeC78hCvGL2nzgZ5vt1zD?=
 =?us-ascii?Q?SdIU1LYM19aLvynz6xD8+Wfb2I+Uhj+D8/5lyyyQnVJUeUI8euztRipLIuIb?=
 =?us-ascii?Q?jtAF2o1U1xTaBL9TUnctps7EhNWNTDGpV3Ore/DxSpvmUDYNn//yI3FqZxvy?=
 =?us-ascii?Q?NGqKWY6n2oyBWQuV3Rj68OLIZ04DGbZAEt4wv68pziLBbaxFzxCnJlkWV446?=
 =?us-ascii?Q?29nBgnDYBoJqdR08CDhoDLv040k4vMSiO6czh/Y12TFYlIf3Mren6/qKQ4Xr?=
 =?us-ascii?Q?z1k3y8XLOp6887dWmpqkAm/EkokDkFGnkdaxncaufgxmJ60siq5WeSN/Je9n?=
 =?us-ascii?Q?dpYOZZVjPIl54mzzRZUc0WSyH8nlBH5VQXwfpeJzilXnHkUBBek2ELtB0bqM?=
 =?us-ascii?Q?W37/37RLC69ALFIxFvLR7A6YdFiZnHY3ScoxVYHE1VqlYbleUiCLmk2l2RuR?=
 =?us-ascii?Q?tKH9Ggq+N223RVLkQTjcH36akSsR09erClc7Fky0oQMp7/ANHtg11aq8iDQk?=
 =?us-ascii?Q?12Q67kaORgHUDo5ISq1Ct/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFBA6B21FE2E784FB65E74E40A8AF9CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g54wT15udma7PoMDujLrmfZhs5TfhaN9kkQ62VrTkQg9CB7qk5PsAmOje8OL3v/zJFomYJuyyCfJ0fOEm5RphcTf50QNYDpxIEa3sh6sWt+7ajiIf9Lxr34JB6TMtFsPJstpDOyWxhASFgf745AHMbiMeCCpM3jzW+CdAVV5iiBjJ0KL9L+ZPIRZIpiNlBwJ++r13JT9TdyDS8K2NG4JXr0bN28SB9ywarp8YX1VTvWvzdbPH5j9mwEwOZY+4Lwau8OUOXkk9t5U0Da1zv5bqSa5dVNqCDgkorEwaN/9sVHW62K/OSmpZ3kVv3xZ+8/qFqRdnMpBUwBucxOk+hLG7wHUpLLYrddhMPlLH5hd1aqYTR3dgLepKmFRvD0dgEBC0OYcHcb58erPl7HXYyiB020I3z7yS3zAm8L4LTBarkwimY3M6TM+5AlcYyozPdMTwbAzU5CenTKqjyCq6kovNo9XB9buOmO4/KJFV7wJd8HLiiImes2lwZmcY1LPpFPqwes5/VSt8rgpYT9ZqbfhMN/DONZvqJMDLR3yl1iZNGd6CjhPz4CcO7OcJDXu9YE/dHJzpgKjK1izEABJZ4Rcb5E6qDkXtPIY3LZWg7qnRIP4p3B8z/GtQK46SazdYgj1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259fd5e7-201e-45a9-5a43-08dca633edcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 07:41:54.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es5r4Ns9CGgGCrAKmfuFmsl4ywFKYugddezqN3OShUqBzRr+p05i1mxkninUP2n2CJqaYq4OdZhTWYS5pY6fvEeyewMrdhCfA9v/5n77DYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9535

Hi Ofir, thank you for this v3 series. The two patches look good to me, exc=
ept
one unclear point below.

On Jul 16, 2024 / 14:50, Ofir Gal wrote:
[...]
> diff --git a/tests/md/001 b/tests/md/001
> new file mode 100755
> index 0000000..e9578e8
> --- /dev/null
> +++ b/tests/md/001
> @@ -0,0 +1,85 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# The bug is "visible" only when the underlying device of the raid is a =
network
> +# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the ne=
twork device.
> +#
> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages"=
 and
> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"

The cover letter of the series says that the new test case is the regressio=
n
test for the patch "md/md-bitmap: fix writing non bitmap pages". On the oth=
er
hand, the comment above says that this test case is for the two patches. Wh=
ich
is correct? (Or which is more accurate?)

When I ran this test case, it failed on the kernel v6.10, which is expected=
.
Then I applied the 1st patch "md/md-bitmap: fix writing non bitmap pages" o=
nly
to the v6.10 kernel, and the test case passed. It passed without the 2nd pa=
tch
"nvme-tcp: use sendpages_ok() instead of sendpage_ok()". So, I'm not sure i=
f
this test case is the regression test for the 2nd patch.
