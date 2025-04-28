Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3291DE892
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852425; cv=fail; b=XDUDFQrYPB4lGxOajLr8sYUCIDumRTs6o+Voqq4vhKLh2eEaGl8h7+JlngjiAuF+V/e6naI+AKeMJht/kLJ3WHy7c8c7HUGv1RPTzuLC27XeHxV6YsL5MqtGyxI/TMUaVojw034KskBywdaAXoZilxlzkRbz3Y8WjK5bxPdSpcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852425; c=relaxed/simple;
	bh=g0ozbwf7SissVgpyyaaTtTZ8UWsDbXYbLoOPGEQ8hOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BE5ny/MKvcvWgN4F+qO+UWwfQ+EsxqCD6W4sN5x7SDBozFjASKSykd6ofiKjn1dFHnamk9oZ4n/6gEyKrGhH5Rr/DEJPPqHeAjNiKI4GhwH/PFrNpym2eVigFL8StiIV7iMSBR7bvoXjCrcGCTXelmNB8WQ06yebCA5xRZdA9wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MS3kAQy2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UjMWnLXB; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MS3kAQy2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UjMWnLXB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745852423; x=1777388423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g0ozbwf7SissVgpyyaaTtTZ8UWsDbXYbLoOPGEQ8hOM=;
  b=MS3kAQy2q/oQN4PtNvg9+k3aWRK9EVkB8Bump3sQmIgblsn4c+uHlKcM
   wo7zeUcr8P0DzvIFrgrTwwD8lhiyEsSuRzJ7eD+lCDn4OgE+cvD3Nfbjc
   Ty1w6QwA6Fs6qfJie9WUakpGvuM99I0lhCD8PcupO55AKhNfDTiEqZZP2
   GWxCg4uZoIvGXnXxG9C2FVYpaZdGFBq8v2yILmQIHMKZsBtnIjGrVwGHB
   5jiCcMqtzb8PZYkD0oUeCIwiHx5gbAENoUPzvdZpnp8I4pfB5Qqh+X/lj
   PYgQ/ggwt0DmkTur1OP4iWjNtqiTXqAMWPGvO+i4c4sYjrh85d4DnTLKx
   w==;
X-CSE-ConnectionGUID: Jv5MS5cBRVWP7UOvd8Q5Sg==
X-CSE-MsgGUID: wjxy4oAgRoa57i5bAkiKfg==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="79612746"
Received: from mail-mw2nam10lp2042.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 23:00:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v49leo14aoi0BMccodJAfUWET6sO/o+ptoIEMK2dT1MRdAvfMpSXLbZEWt+7/P80DMZxxeXPQU03/ueRhahCDTVqHAs34a6nlP/3vqJw7zf/rKmmwUla1ngxYkZPVCrsSh9rC26KerlFS5DTxqdi6jDv9FzoWzyywdCRxBH07BqP/l0fo0Bcn2rBXXURYy4U+ncy1F5WEPpZB4kiOwmbSSyApML7YIzCPUHmvUQo9RfcRFmQpw2IOjV3Nj2GvTb0mq6o6JZLWrKYCEhQf8LrOd/WgJgdvx9U3ky1xRFCNfZqKc+mHBuk9Gz3xhlsYn7aqCV+xthycvlaY5wzniTERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ozbwf7SissVgpyyaaTtTZ8UWsDbXYbLoOPGEQ8hOM=;
 b=eUX3Usenpwfp/2vl1GJT/fJhC+vDzHsCvuPDOPeIzHR17rD+cqTw+HJz1VzsALC84CfTEF/p2cwU6S6RSueqr94M1w6RuVRPNqolIJj2HgXomR6TnmQN7utNwLQYY2Pblzg6FDYq+7aWkCEOTzaXU8odvrsHeS1zgoF55pQ8G192yJGJWLQvM3CSiaj0qPGYOJhD2pawLrIHtrRO0hzyLN/+EugCLP1m8zO6nwowgzV9EdYu5HZpOkmeCx6oCpyHHCqCUj0xvy69o+LZMXc67INw7j/HCzVBKNwXWzp58R7cLnt6G061CsAB5o8SVwmNxltDE4vt/y5f0ZkDWVLCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ozbwf7SissVgpyyaaTtTZ8UWsDbXYbLoOPGEQ8hOM=;
 b=UjMWnLXBsWSkMmS07u6dClcDSpdP7dHVX2xeoUf/43IFsAeHkP7b4wpMyXPFsCHZz0vfPAIJT6NQYy5eZ/xrSlDOC8+3m15G1F2PUOWbz0tWXVaX5sKk9DYxmxR28LjbuOgqy08chLdQn4fXyngLpNJftnRWaZzNfNCZpiIGtG4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN4PR04MB8320.namprd04.prod.outlook.com (2603:10b6:806:1eb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 15:00:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:00:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "Darrick J . Wong" <djwong@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>
Subject: Re: [PATCH blktests] block: add test for race between set_blocksize
 and read paths
Thread-Topic: [PATCH blktests] block: add test for race between set_blocksize
 and read paths
Thread-Index: AQHbsDckUpREgjv8bkm9jmmqQevwerO5PBEA
Date: Mon, 28 Apr 2025 15:00:17 +0000
Message-ID: <2dbr43gvr4wodxbffkty7ego7hl2ficxuccwbjumetsqqp2cdm@toiybr3f52op>
References: <20250418075431.1851353-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250418075431.1851353-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN4PR04MB8320:EE_
x-ms-office365-filtering-correlation-id: 427a76b4-9265-4604-8564-08dd866563c9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UuqUKMFy4fsnTfS/9a0Z52Tjpuz0cKv7U7HJuaMbDekxL4LwTH2de9HvkvG3?=
 =?us-ascii?Q?okAne0bJgTyavZL/wSWAiXvBHj2FxiDLr6GcbGkfQ16VbsGzS+5AeXDryAs1?=
 =?us-ascii?Q?DKjk6j3D/EVMnYVjjUL8it66sHkVhawdSo54Os2EWjcopUMctNYBYQJ6/7EJ?=
 =?us-ascii?Q?+yasyTOyn27XPcMGBRcIe+b0oOhqZjh5sE3Cox5eoAE/5dq9tO57VSllJP/x?=
 =?us-ascii?Q?BmN6YDJb5rGaZYrKE5RGXKJhSHUJhRezBtBkkR51mRIm+SumlJf+vKfUEzYA?=
 =?us-ascii?Q?Q2vQnDoR9Z525YIOreguRtvykvRpMCCWD5SVdSWxzuj5/5tBhNSFJL6wSdTM?=
 =?us-ascii?Q?Qi4IAexmVq3r2/MsDqJLEC0p88xI+7fXPLnBv7jawhQaBfOut5abesPZDzbd?=
 =?us-ascii?Q?B8hEmmcu17OUdnAY/j91ye7jjE1gBTgZSPibmoWIrWDLXL/LMQvqPSIA4koE?=
 =?us-ascii?Q?7nSjK5CXeNPmLiPAdn8mx57dTtc4MeSU3+prJH4xWsZetI9bMgtBGZckfpUu?=
 =?us-ascii?Q?pH2H1HjOwBa9iM5vkh6d4ib2+9QnkpbcZGWJSnwI4atsJcznAwjhJWMiBAUX?=
 =?us-ascii?Q?4MgUqbqm9QtY8XMP50Y4ODe5MEdAh+AqpofIl+iq140WumJ9IwHDhiCSkXPr?=
 =?us-ascii?Q?iMsK/ZmAHbQFFlhTe/c9iy1Tnhe8BzIjQGS541RvjrPRdoYjmidIoCEARcS8?=
 =?us-ascii?Q?SvN4p4XcJcKbK09BMBbTmi82tKi3ZEeR9SAua88jqlMGB75p0nBs/nHqt40K?=
 =?us-ascii?Q?MkRrYb0EHWlIySe/bKO+3Wx7L7S55PInFB4c9ej2V5tLuiAAsf7hbutfE53Q?=
 =?us-ascii?Q?wEiynnBr8jbgraasOVjsAIAP0qE+BwoXGTp5FiKuR2c5ZMYjHijvHXic18vl?=
 =?us-ascii?Q?q0yoKIxyVYpEByfXrT1/fHR30QfWFm6CR3qPoYJZKHtf8ikubjob7pli1iA2?=
 =?us-ascii?Q?lK6GUe7c+ERbfTHiMSQCds1DgYQyoSz2syHqrvf9yufzqaEjYDIA7FSSn9M7?=
 =?us-ascii?Q?LCTJRxy3esRuz1yhHxnEfGDn+hDDCtidwQU7nlSL2Mo+N85GYeuqpnvLRKrB?=
 =?us-ascii?Q?tPD95Ir/Y/cffVfECkCvBAHN4kZHsTru/NDy9JB9zvqUgoUtjX9A1jt/sJxf?=
 =?us-ascii?Q?nI6tnueovfvgyOEdfQM7GTdgmeRBP6tmNyzgfP2IamcKuEatQcR0TC2WgdV+?=
 =?us-ascii?Q?IEyApQ93CZUeYz3njSSTnYHxEmorBGaJRsf56yY4RLulxPTFlcACvO/SYqwX?=
 =?us-ascii?Q?/lEz5bBTR1QXZUBAENvDCSJXN/vaX6B8lTnppCEY+4LwVIzU/M772h9+stuP?=
 =?us-ascii?Q?knN/tpEAHiZgpo0bL6derharNPJCYsWsa0w6VAw+3KYgM35jluY/gjhDV/y8?=
 =?us-ascii?Q?P2z2irDi886NoXngTYqopih6JlaZLYfegzMs26n/1Wjh/AggW6xrBcx9rU/e?=
 =?us-ascii?Q?aO5acsKheKpPR3/xOfvfwrJ1iB8fMxYjhQQCUhmNo+FQWX0eaf+8e6Ivs+oq?=
 =?us-ascii?Q?3CsqdAP9mKuMFb8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TZSgYHM5cpY+8wX6VjNT98oLWX+KsUvmVs3hSl+8ChTMDaHZrdRT7kPvsNsR?=
 =?us-ascii?Q?+GuOmQD4WJFzH0QlLqieOPaxiWz/Tb2z5DlGgvw1Y/ZoSRyETZGllCNsLuU9?=
 =?us-ascii?Q?kB6tGEuZCLDcXUrU4hc7fv5FUSs0hp55vkpF3Qt0ZEo+Hb0CghzmaSz8eD/n?=
 =?us-ascii?Q?I5HfldT9A4s27mqjMiaRRqhu0C592WSpHJhEDVpyeu8Z4FDRhXmeUlOBFsu2?=
 =?us-ascii?Q?eav+GCheJTPU6q0zjN6rfm93y0zH+zCd6VSxf9+hL6wHuhoYh0dZJCT4LnpU?=
 =?us-ascii?Q?GBtGtbDurT4uEuXSa5kXTzutTiTiR0B+RMk5lcKJmI7uArOB+3PYWxNuht5t?=
 =?us-ascii?Q?go5L+l/tArDM5bO2rkTU3o+KivPfcEal1Ks/XG4tKesX9aKNR5gULcZsKgu5?=
 =?us-ascii?Q?lC+GriklX6VRgELewNROqGobIr0oN7ii8VE17BjMSeG0XSgfBwbixXZrpJop?=
 =?us-ascii?Q?a/dfYpba245eMnL9BWaBImi14nEjgt9pPDQISn2vr6whME5EefKbkf0w/Yii?=
 =?us-ascii?Q?1PHug0xnuc/D/hP3Oy24yByPDBjmXiFnPwOBXKhPEjBTgb9bf9iM5oGtWIQr?=
 =?us-ascii?Q?mhF+ZVCuthSqLsFtxFCXNvszURkJhRw4d3/tT648Btm9hfcGiaLxi4fP3n8T?=
 =?us-ascii?Q?65n11TIBsLYvVF7XRynUtpf27cTPW0GpN5+A0V8TjBOtsJNZV3+gEgeicW1u?=
 =?us-ascii?Q?4dZN7VS0LNssSLqDPANBLJGQgJiLnO0NPTOOdUx1VLH4l4PxrgAciFWs4QT7?=
 =?us-ascii?Q?VwC05TJbxCHBFb4hZhfVn+joZ+trpz9GQIrzOEsShIPHhZ1PokB5QB5sF0Zf?=
 =?us-ascii?Q?KdFlKrZ29ParMUa5FoZy3MdwGoC+8SAgbvHmOMMO21DtN5CHZRkSfZxvzNby?=
 =?us-ascii?Q?tDJh8DUefuKlDJnqlCdow6UwBK1/e26fy4LMLrAOG1dY2VdROpqOYk0jdtXW?=
 =?us-ascii?Q?z+IVAwhyM8h0zvvWK7gO7Y6MxBXFrRaJ3/nTLuevjrnUYG+wlkw3c312RQHP?=
 =?us-ascii?Q?LY6LHpkq/rRcezGgzsktY7PNoakkUkDyNc6tBJ4Mf+MHEoTyjJwAvLKkMrii?=
 =?us-ascii?Q?a/xbgYpiOu1XVfHC4xRC5bwtz2QoXjyvyuBpq+NRLGVgPkj6M3qFEQKkNE4S?=
 =?us-ascii?Q?BxULIcFQMtv0sgFLSdYVcA1bHwAnGblR5fawHCd6emtJCKRH/lFsDESX8Xqz?=
 =?us-ascii?Q?JJ/7jOrwgW3DbY2ldeXKOj5eh1XL/SuXCwJ2t3ARn64zQlCBAplCXeE3/S5R?=
 =?us-ascii?Q?vtHu6v8DNjRMooo7MPiM47aMOKiv7V7VO1cetDpptxx77x+GVv2Dl/ef6nhu?=
 =?us-ascii?Q?eAPP0LxN7doBYaF+MxsyKw4UzTTRPa8hFKi+VuRGNem8nCUC14T28nLuJP8q?=
 =?us-ascii?Q?GK1GY6Eg7jzq7xf/rWEiWWKqQK/CUKiRPbFSWDM1enPT1U2LIuSXloTRGohH?=
 =?us-ascii?Q?2A+Lnw+o+auiIO/3qCpxBu2WA8a4z3WHA4fZ2z7S4iqNhM8OSE9aWQZv1IgR?=
 =?us-ascii?Q?A0h7JNpP+DC1cIYxws2rvZd12OrUVYcFq26rsBAg8CCR9iEijQkLp37JRYHK?=
 =?us-ascii?Q?1GgCMJpGcvODQ/YmABmVi48S7yJBNfNTiN3DtqDLnYodctGnpjhD9aToZGAG?=
 =?us-ascii?Q?uhczJ2pCM1Psr8/Nqg2RCIE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <197791185C69A54389CDA939219FD869@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pt5tQU88XurZxmwqN6zoOYmNo7Ixu+NYUFIuaWIYJusN+FJhKwaGDTSRAuBo68HmBr0d2ongqH/5cWqp0MJQil48HPCkCZpLR4H/Ly8dvyuX9e+4/1PE1ot+WgvO0wRTOhMoo2hzcnlHP01cIKZingexovIGPP9IU2VJobmt7sLqj0Hgau0xekApkN/ZNJz5hMmvKExxHeuIqu/vK/ENfC47XPA3UCSaDi8dYR3srlWif5TPrC3bp4PxgtgMOBlipIYEefE/64Llq4ROkaZEO3Riby9uPiLvsqTz6G9GvNYN/D6O76PMqIzstD68rNUjjDUUc/sGYws4lDig4jfj8UqlqQ0k49GAhhmanMYjR5lDzF2aEdNuz2aSNDA6lqTepxBG5zYzSbFc0GExzgt//hbwWCX9GL0I2mBEssLX53Bm0lAdMovc1PIfze+bf15eVofhLIlJj+tchUbnJkVUbat3AdXBwpno8Id4BYECUNnhJ4MkCVzn1GoC6lcjL58Za/KVd9OUL+kWrqsYx8rWRWW3x6Fxgs0wwMrzJKvgjmj4+y6no4W44Zsow2H1y8f7jgACdZ/jszanx574WnorwrNrADH6MPD5ORoyNYMLPM4NjtBd1/AVsM28nLROqoQg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427a76b4-9265-4604-8564-08dd866563c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 15:00:18.0109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ff9tAsIWaLufDwHIsGsJi0JOM2s7fkGSbUyaPO+rM98ppgu3k44cdz8k7+x7DTxIhT2rW09XZmTnyPa7OV8lKsz0FY37DVxWeIPsxFmqag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8320

On Apr 18, 2025 / 16:54, Shin'ichiro Kawasaki wrote:
> The new large sector support in the kernel version 6.15-rcX caused
> kernel crash due to race between set_blocksize and read paths [1]. Add
> a test case to trigger the crash and confirm its fix.
>=20
> Link: [1] https://lore.kernel.org/linux-block/20250415001405.GA25659@frog=
sfrogsfrogs/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=
