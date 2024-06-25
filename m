Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279A144312
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301686; cv=fail; b=ATb8RUwka7gFNrpJngqPV/LIcbwnmHasAR9bhJ7WxZWxZD+F0zO7v9dnp+VlOylwQhyToiK5vVdMz7zcI3yaPrH/R1Ro/b/SUDxF4rXfkrUk9kQ5yX+KzXfDwsj625cL18JlsN7pv60siBsS2RI3hlAhDyWHdzioexYwaxntWbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301686; c=relaxed/simple;
	bh=9pGi4vveBGzn7eXPb/G0wXOT+DPrsrz2zBR6OIgPzVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POPwDjV5TwUzX9Ca2TtzSdyWjVAd7ctjkH9NHkdcOOGZZ52M1Uq/liJj9s6bZK6uhR3aQLcJo5ljymcpvvzVEe76n+gnbPsz4cdj0DgE9ioNfcTlVOm/tmaZyjSn7IauY495/ze/XrFMDKH6gV6cpyiBXQR4sW1qS3a2aWiu5xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cUp+gfAi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rhA0GvBH; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cUp+gfAi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rhA0GvBH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719301684; x=1750837684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9pGi4vveBGzn7eXPb/G0wXOT+DPrsrz2zBR6OIgPzVw=;
  b=cUp+gfAiQENBFYv6arJl+58+oHK6GJk8lp23GM2FqFUBcxKfKIVOY44o
   bH8vbVvbwLnh6KrYQClxuYZLodV+uOv7y0a0okeUQ9onA02u1OIvtYq20
   oXkx9ZCaPYx/MZckH6MySuZ2+bGBsWzE9c3w+yfx91vbgxzHgiBzqQvE5
   BsRJ1T6ALYMcPCuHRqaFPsOSCgSygvQrH3kbwtAHhBCrSFKWq9RqpeOcN
   M3ZR+OPxa4/tEbdAQSiXBVlo2Iv8QpNhy8FPoahtJJ3gbg87pmouE8g19
   71J6VLwjZWkEc24u8cv/yf0muY4AC2sRTZwB49HMNd+II87O8BN9ypgxf
   g==;
X-CSE-ConnectionGUID: YLSemhVHRLOdOJKrsMhX8A==
X-CSE-MsgGUID: l2Vw0x+CQEmIMBvWPFatVA==
X-IronPort-AV: E=Sophos;i="6.08,263,1712592000"; 
   d="scan'208";a="20750785"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 15:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/dmpeE0iXgtdSgH4dZip5IQuk8iik0jfRCeMsYOAGiec802prF4LRMj1e/ffUusfW9mfccjR63hCiA8QLHNXG81ubiWyAjX9PvGDa+cBN53Dmw8qPXJ+Yo5eJNwpzoEYm+zFNEljnWdGhoEXiHsW3T/DXHmvRmPCQkrSjrNgFEjo2n7n2WCdfQwYriR49QDv05r2dmY3GgDXmlKf2bIcKBaZ6bRMsG+WPcKa5oZ1qmzig6Gypc5bOSXJt562P1A8AcifT73Q4c1hvtNwOTwxBBueiZqBDA8vrl1X4BTyKsDyIvWUBZaWeREYXIPje3rgrIRQ7rwEbsJ6v0DZfDrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ZYF7EXpgmityOEWVbKHkb5GQLycpzfzGNRMB55osc=;
 b=Daw6Si/SESM8r0TVToI3Ox1xGiytTFdqJG8WkLfH+i2T/0iXBUCVnzdLpmyvPf7KBr1AeDr3KvDfDg/g/1zhZKdPjGBOyHwiIhqPFLrzNWy8t1ymSewjL41PLFSfIKG1eZSa3Gp+qeS+gX48vkvnsKtjcSbL5h/6O8aH67SwqSL0W+sCy9W9g3ZckDH1IFz/RuBT3q4zi+pS97PIK5Zil6rIZJJU/7InMYT5Rg0UF6DTR2Ba07/Oe0FDwQseFgM0TGLiEoj/7PQIlQlLAF7v8di+s0sOWvWwx1kEU4iZIEUb4zZPfx2g/5TTxBHeavI+kjGHNEoIjxTkz639NT/Pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96ZYF7EXpgmityOEWVbKHkb5GQLycpzfzGNRMB55osc=;
 b=rhA0GvBHsNzk1gnlUBkQjBLckU9PYA9Y2pWFgEz/umtYRySi6iaU7EnYsiuAu4NjmasyRJHvztP9suARMVUxNqFSSg+j971jkVcsGOx3xYnmxp6CaZdjqoA6nnYc0PZf9I+/1vePFZoAkeVcuWPe6WtakCidNM8731zA0lFzmYw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7213.namprd04.prod.outlook.com (2603:10b6:a03:291::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 07:48:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:48:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Index: AQHawv5xoaaqr+UJgUa8S/dIdWRS6LHWZ9sAgAG6J4A=
Date: Tue, 25 Jun 2024 07:48:00 +0000
Message-ID: <i6ke4p3blqkyxje5dhsq2n2h5mxubr4pj3b7hjq2fgolwzfvd3@jiacs46tsfj3>
References: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
 <IA1PR10MB724022648B6D9B63293B719498D42@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To:
 <IA1PR10MB724022648B6D9B63293B719498D42@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7213:EE_
x-ms-office365-filtering-correlation-id: 3cddb26b-5e6d-4ac0-46de-08dc94eb22fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HPC16nNWNwJThbHMFRmcXM4v072glV4htFCpFUsTilH79m1CKtq5VfFmSzrE?=
 =?us-ascii?Q?CUHzaYJ3c2ZKBwEjCSII4FVcni4atdBuLcWEXRUCZWmbbaf0ZT3B0gekWQy8?=
 =?us-ascii?Q?MxEc1rfL8c4IVsQ6i//avq4ea1dF55+T+cSWx3TpqLYZJr+TLAQLn14u48T7?=
 =?us-ascii?Q?panVXMr1r1q1qSGDAfn2s6H5R8LAUKTaqQ0xpF8cULs0I41yWq0E2MiPnCh2?=
 =?us-ascii?Q?wJ6DARYD/HZTcoURky3IcPwyeQt8/LujNejLSOBqapd/+SL7t4OzmQL7AlsV?=
 =?us-ascii?Q?FMSBUHj2cnQwxIwJyuv+hR80yBR3oL7OYoAyJ7nDcfhNa4Qa6i9N6RkwxXlw?=
 =?us-ascii?Q?ciK5H0miB1aNjx+6yyRjEF+1hpXplKWMKdjdHsSoE9yTICOilWd1CbBglz8b?=
 =?us-ascii?Q?jYIqx484xUfC0aGACzi8WPs6SFDVkpCZg283fgbBImDqUDMnrEZ6PuQ11wRN?=
 =?us-ascii?Q?Hfk9iLrWaTQ0LHa6WRfhnhfE49+YM5X584I4GDuzh6qq06egigZAEfDhgOtH?=
 =?us-ascii?Q?85/DTP8egfPFfKmPTgF/aqYhr06T1KZ9kqGg37U8CfwCrHHHx/oqw2n/6U35?=
 =?us-ascii?Q?jI18TjMV5xwhZPFUXxElz6uAqCTDySBOES+Em5t+HwA6uDHkiVLiPKa3f/Qc?=
 =?us-ascii?Q?yJudsrW4U26BsfNvAPFsw5o/Ufe/Di5vgvGcJBL72xOeTWAXwDdd3VFhvag7?=
 =?us-ascii?Q?DEDdYjjb6fkt3AN5/uKH6u4uRBM+xVUNW80hNcv615oZsSykF/VP6lG1xUJz?=
 =?us-ascii?Q?H+JsoeNdQQZC+dG+7gFA+rOZItmO9mmEnPvKrT5mINXpbiqRPg6v7Yxsc69D?=
 =?us-ascii?Q?wAwZnDiAxTI1NMAG+zU2sNZMNs5An16H+K7p9cLYlVkxYe+wZ653kG6JUveF?=
 =?us-ascii?Q?rfg4HGS8aeirzU8rHxw4PP3r0aqRzVpBsM2+03Pl2BcIhczT83zGVU2qVN80?=
 =?us-ascii?Q?EpLj3fLTxe+enoV+YOcvDceZ5uFjgC22gKsJvZOQvY/NKd/MYgEunyGl5RWj?=
 =?us-ascii?Q?bR51a0FerGRpG+38oV0vUKrIFHM78RHwaL9Ux5uEJGKfA3ftb3EatWrM23uL?=
 =?us-ascii?Q?Lz2OD1jICXq/pdHlWXhTi9cYGoJPf/2WPIvo1b8l+BdIg0Jv0/73RmfTrvrb?=
 =?us-ascii?Q?zni15OP3YeIEvR1KKqfluAqy1lle5PrGqeQ3oMEN5KwPwQo/nLeeV8NTlS+e?=
 =?us-ascii?Q?OemjA74FVTB1K8FKuvvKKEf11KIV3xI6DOh5hMCi8FS+9TO4OoZ0LC5w6hdc?=
 =?us-ascii?Q?aWR8T08/6mc5eRKuc1ZVxtQ9isnpoffde7l5BtGei0tzV8Bpy3SgkS3d7uej?=
 =?us-ascii?Q?1utMvd7Dc4shp84mSa0g10nK7F9K7kAmzflqUe3pe3Lrb6XWArBPkOyqwAzc?=
 =?us-ascii?Q?za0lkm8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7p7Z9GwvUJBdbaxJ3pU97RcPVDJAxrNIcjwoUjquJ5HrvtsBmLAccyc6p0Ea?=
 =?us-ascii?Q?YU3/sYiPq9W/aEQ6bixeqRK7VrpP8fWXtA+Xm0rNY4uq6CLVT0CVfEGHryKx?=
 =?us-ascii?Q?SyMS+TyHNU5hUrSyzJk55SozmGFUVs2qvlp9qmSnjzW0UoJSjds0rRtRIa9x?=
 =?us-ascii?Q?J4e85M65oU6V2Qol+VTTk1wAOSvgNQG32RcvM141v+/IAwsfgM1ptFA29biR?=
 =?us-ascii?Q?6ewzT3BYjGl+AOKa29KQAgBUr5mqKEmd2p5YuFes77dx6dnLDPzCpU0QuW5J?=
 =?us-ascii?Q?bovL0aFSO+d1rwdlBXVNVyprYNXO3Uf9JB7YqHi1OJIdHZqKlbzC4wFMMdW1?=
 =?us-ascii?Q?Kwi2j4aEMmuxfTlMy6FaNzI5lQkQHtMFGBbD9vfHJw/qASJpr748nJUWgFI9?=
 =?us-ascii?Q?KYZQ9Qj/u3fmAXznWQOmcLem2Hx7IlLugtTMoSnZzlIjvATs7uncPP/F1OhX?=
 =?us-ascii?Q?ksrpEC+SIic0OoY5GInPta6Bz5vcBfCwvihk6vrbH/lCnjcyyUBrzzGSStmu?=
 =?us-ascii?Q?Sw+XgLadrlb5VZLeb7JWCeG2GakKfm04iHoNwU8+VexdT0RQXC3fWt136Y42?=
 =?us-ascii?Q?sFD2YE144iLsV+mJmxsCTRE8c6OAzk8cKwo35Nlcr4KlrHtMfkSn68d8ol8J?=
 =?us-ascii?Q?oawPxcA+gATFS3mbRYz92pu+nkP/JfhkBI80osBSLq+oj+eA35ptIQJMr+yH?=
 =?us-ascii?Q?FqBZB4KxQhg3m2TjkT8JqQJCu0b6ZshbfLRyJsoicFF7JqR9hN/evUL20rjC?=
 =?us-ascii?Q?DgAAcpgAVCALWL+tUz+Yn2gFsBQ5SCzsWY9vjk44ehBduJ5Fs3f6zx3r2cLJ?=
 =?us-ascii?Q?984O20Zb9GtOpsPxKHUv1eS2HQFm//Me/0E3pLcddLmXxMYtNImOQaUoUAT6?=
 =?us-ascii?Q?9pLl/UX/SkW36ABb2VovNkPuylm/s71JQJj47B4lzEFRwe+g3LhSoTY4qENR?=
 =?us-ascii?Q?sJ37e0KQ4kKUH9aDXFaewv0q6W9XbbZ3x6iFj2044MITXmnqmUBd1v+hrOaX?=
 =?us-ascii?Q?eUQsWeAqXTGUUGuNQ+b78+mChp3CbpUgpe7MUyJZWgjStPQet1gwp4DjxZdi?=
 =?us-ascii?Q?m0J6xVHLZ4dFYKQdpwXcipemwfcPHt2LY9tOSE7b4Ny4ea4U77YtgLRZmmMW?=
 =?us-ascii?Q?oJxBrLIpUp8KObOJefQQU/z8LoXYWqhqewxCUIY7x0tgBJr9QpoR1wl2mB5i?=
 =?us-ascii?Q?vPkauDgLSFgdKA27UkVoQawFwk1gjuuiPMjhG4rxjaz2V311IslQYB9Rf1Oa?=
 =?us-ascii?Q?c4wYBtTqLM5WbtrofDCH91F3KVQ7mdfkGyki5pJUsuVYIQaRNO/gurUeRpFy?=
 =?us-ascii?Q?IOmSFdnEg3+9olF0Gx2M2I1+Jmh2muljIqC9zFSwLfA33rIUv+k2gtTKR2aK?=
 =?us-ascii?Q?H1PPYLXzQUr6D962IXZaFnSYTfy15CYnh9ZbriTpRt0huC1tPvU0MuApgYJ0?=
 =?us-ascii?Q?8UjXsqG+PXkjPpLwTVEXPutHJCc2QWePNUyxybKZt/vAnMyaWB1ITx/vHLzj?=
 =?us-ascii?Q?995nbI4iDypT+C3sHJqD4CwjSbOwiub6bIIV00HSNhOIfXyOzf1xl1RyM5eI?=
 =?us-ascii?Q?9UAgEx5FewQaugtbkQozUCmQgEYM8JhEZtidjaj6yWkIyqiBZ7pA3qBGArXz?=
 =?us-ascii?Q?dpZn+uYFLR4FjccXZj7WnsQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <241EBFB7DE5EEF429F1D448A32AF9833@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9EVAwo8A1fKPVFs/vYPCO1jpPZGeUFoy9NHuVvb7WNygv2xEc8n/D2Y5RaxRG/mhjilUGON7ICmrobrXRZn/5/NULfbF1cB9CXOg8browy0AWyAVdM1BjG+LMsePuK59FBZGjK43bxCdFclqUfsgP7NscWYh4bpznPI5DIo/HuDE228fiiZ114xWmdoi08nmwspnMwmvN9dxXwCz5R4N49+TwfkEwG/Z6BE5FsS+R2vTBGAg+t6+kfCOA2cMvaRAiVUCD9LdJ501CGjx8SR9aMFVb00KMLQR+arobzZ4R/57VTA5gzpX30hB0uxzUCBpiU8gZbtE2n3yCH8nc7lujxhYjT9n2OC8nUB3ouZaRaqP7t28A9/EEJyK6NAW0kkzITotPddKktS80KRQnE8Y++QKiSAypZp+dGXmfP+WqcpWkvlv5e6oc/gwqhLPK1KyGf6guq8nGEYUzJS136YSG/aHKfMC86Us30cgfXk0titW+nKAT5wQcXFwrVdmgRNprDbcHOMaqjFYtzhzEEalEdYm7gvVJn73QAca5/BOHDFtVrJy4JtBRusY5ewg43MKarsz/LnE8AEBbHx2s2OMPytXqWxQ+rj87MZgVax0LqvBKUsgyaAj0KNlmWVU7MuO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cddb26b-5e6d-4ac0-46de-08dc94eb22fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 07:48:00.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oaoGz5X+n37LO2LPN1s0hVUn0HJ0e7qbIM7gD/uVAtFWNn+P7KrMVk9xYHBDlaOPSBsm1Cy/YqJlJFwtHLJwSckpx3Yago3HRJbpJLFY+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7213

On Jun 24, 2024 / 05:25, Gulam Mohamed wrote:
> Hi Shinichiro,
>=20
> > -----Original Message-----
> > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Sent: Thursday, June 20, 2024 4:12 PM
> > To: linux-block@vger.kernel.org
> > Cc: Gulam Mohamed <gulam.mohamed@oracle.com>; Shin'ichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com>
> > Subject: [PATCH blktests] loop/010: do not assume /dev/loop0
> >=20
> > The current implementation of the test case loop/010 assumes that the
> > prepared loop device is /dev/loop0, which is not always true. When othe=
r
> > loop devices are set up before the test case run, the assumption is wro=
ng and
> > the test case fails.
> >=20
> > To avoid the failure, use the prepared loop device name stored in
> > $loop_device instead of /dev/loop0. Adjust the grep string to meet the =
device
> > name. Also use "losetup --detach" instead of "losetup --detach-all" to =
not
> > detach the loop devices which existed before the test case runs.
> >=20
> > Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach=
 and
> > open")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  tests/loop/010 | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/tests/loop/010 b/tests/loop/010 index ea396ec..f8c6f2c 100=
755
> > --- a/tests/loop/010
> > +++ b/tests/loop/010
> > @@ -16,18 +16,26 @@ requires() {
> >  }
> >=20
> >  create_loop() {
> > +	local dev
> > +
> >  	while true
> >  	do
> > -		loop_device=3D"$(losetup --partscan --find --show
> > "${image_file}")"
> > -		blkid /dev/loop0p1 >& /dev/null
> > +		dev=3D"$(losetup --partscan --find --show "${image_file}")"
> > +		if [[ $dev !=3D "$1" ]]; then
> > +			echo "Unepxected loop device set up: $dev"
> > +			return
> > +		fi
> > +		blkid "$dev" >& /dev/null
> >  	done
> >  }
> >=20
> >  detach_loop() {
> > +	local dev=3D$1
> > +
> >  	while true
> >  	do
> > -		if [ -e /dev/loop0 ]; then
> > -			losetup --detach /dev/loop0 >& /dev/null
> > +		if [[ -e "$dev" ]]; then
> > +			losetup --detach "$dev" >& /dev/null
> >  		fi
> >  	done
> >  }
> > @@ -38,6 +46,7 @@ test() {
> >  	local create_pid
> >  	local detach_pid
> >  	local image_file=3D"$TMPDIR/loopImg"
> > +	local grep_str
> >=20
> >  	truncate --size 1G "${image_file}"
> >  	parted --align none --script "${image_file}" mklabel gpt @@ -53,9
> > +62,9 @@ test() {
> >  	mkfs.xfs --force "${loop_device}p1" >& /dev/null
> >  	losetup --detach "${loop_device}" >&  /dev/null
> >=20
> > -	create_loop &
> > +	create_loop "${loop_device}" &
> >  	create_pid=3D$!
> > -	detach_loop &
> > +	detach_loop "${loop_device}" &
> >  	detach_pid=3D$!
> >=20
> >  	sleep "${TIMEOUT:-90}"
> > @@ -66,8 +75,9 @@ test() {
> >  		sleep 1
> >  	} 2>/dev/null
> >=20
> > -	losetup --detach-all >& /dev/null
> > -	if _dmesg_since_test_start | grep --quiet "partition scan of loop0
> > failed (rc=3D-16)"; then
> > +	losetup --detach "${loop_device}" >& /dev/null
> > +	grep_str=3D"partition scan of ${loop_device##*/} failed (rc=3D-16)"
> > +	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
> >  		echo "Fail"
> >  	fi
> >  	echo "Test complete"
> > --
> > 2.45.0
>=20
> Thanks for working on improving this test case. I tried to test this but =
I am getting the following errors:
>=20
>      Running loop/010
>     +Unepxected loop device set up: /dev/loop1
>      Test complete
>=20
> This error is from the following "if" condition in function create_loop()=
:
>=20
> 	if [[ $dev !=3D "$1" ]]; then
>                         echo "Unepxected loop device set up: $dev"
>                         return
>                 fi
>=20
> I was trying to understand the reason for this "if" condition. Without th=
is "if" check, its working fine (With kernel fix the test case passes and w=
ithout kernel fix, the test case fails which is expected).

Hi Gulam, I added the if statement to check that create_loop() always creat=
es
the same loop device. My patch replaced "lopsetup --detach-all" with
"losetup --detache ${loop_device}", then if create_loop() creates loop devi=
ces
different from ${loop_device}, the test case will leave those devices. This=
 is
not good.

But opposed to my expectation, create_loop() creates some different loop
devices. I guess in your system, /dev/loop0 is created in most cases. But
sometimes /dev/loop1 is created. Then the if block was executed. I repeated
the test case run on my system, and observed the same symptom as yours.

To not create loop devices other than ${loop_device}, I came up with anothe=
r
solution idea. I think the losetup --find option is not needed. Just specif=
ying
${loop_device} instead of --find will work. I tried this idea on my system =
and
it looks working. Will post v2 with this fix.=
