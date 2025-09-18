Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B41F4181
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168536; cv=fail; b=AHbrfBCAIa5EE9Bzmaq4tiMt+y5u8xwswCh8CW4StfrjhPyvTV4Lbseuo5NRYBWC31R3TsaQhLdeIjxT3fXKUCu2jU0VQkIk/Zq8H5VGNLkLnbURO9/JPaCBoxsP0TwWj5BXa+5esczRH2zGDKolLE6apr4zLYdiOCW2ayvNg5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168536; c=relaxed/simple;
	bh=feTv/acXiu3Cb6zer7IrX7R+TR9iirrucohG5nuy8wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CpkxQGo1LyZ/bANiYP4LAg9C3XJ4uvC0VICuealNSpZ3DBCjSgBuOb/2qAO15CP2GwJOIZcRQw8VJZhTBTa6GnbJRLW3Oc4otfmwwiqPV/D74JfMz7AeXnlKHoOBDntsi20jlHeYjzcWA850M8vVbv1xhrqMM1GBHMQ6lciMSNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WYmOLOeA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Hg4VYrwU; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WYmOLOeA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Hg4VYrwU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758168534; x=1789704534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=feTv/acXiu3Cb6zer7IrX7R+TR9iirrucohG5nuy8wY=;
  b=WYmOLOeAx9uSL6nbisMJZ2tp6RJ90M04byswHNpmNmFHg6GdFlwholJn
   DZLW43WKbBe0DZ/Ee4OUIQZyxtGT5Ak7vKtIzqnHl+RYkkrmEgJkdf8Zk
   1rnrU0kN+63QR/2WvcQycUdCUBI/wNuX0ZLYWKa5uk8sSc54301Rrcv+M
   R3i4zy55hOKDXc/zeQs5EIhKHB1l/U5624KF7XCvugZZVX2i3sdcRpA3a
   1ipDG+fTb69gRNhgzPHXWyCTxIKto2lUFKw7Puz1ZBcmbwerImfZXWiuq
   hr+1UAm9BfTChJAVrecrQ/mgFznz0kuzO9RhZw7TQlBxxpb8Nm3lcXWNu
   g==;
X-CSE-ConnectionGUID: OTzKY6RdQIap1WwQx05uhQ==
X-CSE-MsgGUID: bM0Z36zkRMec6YhrKfPPOw==
X-IronPort-AV: E=Sophos;i="6.18,274,1751212800"; 
   d="scan'208";a="124303400"
Received: from mail-westcentralusazon11010015.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 12:08:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVUCkFZmcYyiuioNVpo06GHFUWTUOUYrfeq0QC9s57/rz7iS9N5+6LYIBAIlJZlY/xXeYADK0jFMawOtRbs7fF/iEk46lwCMyouz5ZkeeWqKDmi34aCwZSnnPtokqdY2cDuIQ8KInid3Vye+6gLrY+0EOYcWpc2LRgGPWjaef0TpwO2HCbWjopsAz9MRZB4F4ZFGbUP8wAzgv9mDQGlylMwADO1gXp39aJr/ICWQQDZf0m+k/iGgTnqI4gyE/ZVNfPmmWRK4wVu4R+HTrJCjocdFsn3vsDCwXclPlArZB0DiXb4fU4wwjpzVscAu9I87yEP1jPwlK8EUUra+h/5Njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWNWAOUHz3nWE8d2VLrV0hcCrSM2+/CCcIY5PLvLOiA=;
 b=LVy9zoZ4ltpjQoC10u9a59WYymbjdsMTzHF4d4pVB8kILbBVLZ6GEDDmAKN89y0FOz4kORdXS2xzgu2FbUDm/qSgguw+SdrrjyHVZoM9I7jhFQr0cNA0mlOIj8zz2CLHHHfY7fgBjFbShFve9Rxfza70ny5tgzuk30VdiVYGEnol49DFO/HSxPNqybNC/O7brrtU3rDxc/9m1EqHj6bS47Icq1UJQ6v/0f1/tAGE8yldC0Wotj0+oFm65IPqmXI2EaGcCvo0Yr+n/TWZNDnymPTVrS6OnTXYIuAUjcq2svb0xkeLCADMXPHmVqYpwtrpVpKIUVAMIxsIjNThLs0YSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWNWAOUHz3nWE8d2VLrV0hcCrSM2+/CCcIY5PLvLOiA=;
 b=Hg4VYrwUXpH1ADn6quAdhEaQY9ZrMNB1P66RHn4JKZXqfyEzIFWqO4e0U8t5UtLyKJeVeGvVT0q57WkWWARlyGD48J9Ht5GhLzFBcL6Zm1DNtcStGWLBByO/F5SEe/CoQlvUKd6g/dLSdXWqhXoN7KCyb1z3cQpCk7+kAIMg26Q=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 04:08:46 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 04:08:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/7] common/rc: add _min()
Thread-Topic: [PATCH blktests 1/7] common/rc: add _min()
Thread-Index: AQHcI8u30/BZ7sa/j0ir1Wcl1dA9dbSYXEEA
Date: Thu, 18 Sep 2025 04:08:45 +0000
Message-ID: <3vajuldrx4svsmh2nabii56psc6kepncrino44gvycj3ekkufn@e2blebamxl5l>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <20250912095729.2281934-2-john.g.garry@oracle.com>
In-Reply-To: <20250912095729.2281934-2-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7550:EE_
x-ms-office365-filtering-correlation-id: 01b584cb-2270-4744-0661-08ddf6691022
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wDqX9+radiRVmlHlGSSyOIsuOzN5OTX1elWj6fNYiEIduLeZiRtamJj1dzEB?=
 =?us-ascii?Q?VZp4PTYzlus6XicN4CegIC5MYEvQ1t+eFfKRXGJCTFPtV40IjWi17ioWblZQ?=
 =?us-ascii?Q?SfXt6aEAjK+o6FjvK3+ySUYTLbzssYcEa4zJT+Sg1gKGSOSX1JEIEn5ipwNv?=
 =?us-ascii?Q?NC+LwRNrF6g/ra0VflMxNep4SHnOMa6lOo9qo61y7aHFrzr7R2fKndhFcPHc?=
 =?us-ascii?Q?b2iD5OAu85CDdh2+yXdO6oE280BReb1wikbD5JRjPWD09YjaSViVUydzFGOp?=
 =?us-ascii?Q?BuAGA1xdGnmZ6aF7xphmD5wKhevEmJo+3ej1iq79Xv+5N7RlUSbpxRSF1imj?=
 =?us-ascii?Q?3IX2JS0jL6Vzb2g+Jz6DKjJ+p1dHFvTp4sDsuLm0yHVMc1H2EVqMFpo0urd8?=
 =?us-ascii?Q?6TRFzZTqKfJlbcqZorrHzzqId4pivNDqxoTg6kq2QLGftv9gHhiFJdSDNl6F?=
 =?us-ascii?Q?2a03olBQO9kq+85w8WThmCTOgXL40rGXEweEy6St/+VV7wOI7QwdFx0SceTT?=
 =?us-ascii?Q?Kbszz+UP/ku/bMARG75t/aqkKglo1yGzZ0qxL6W2p6iximbohsZKLUru5fU8?=
 =?us-ascii?Q?zEsKHFsx+Y7aGTPWeR+LvUc3jw0fbBHfSlxdwBGNjijaMMudVD68CKAqasnq?=
 =?us-ascii?Q?TXEQ3YkAuhUJws3uD7fJFmMZ6LWFt8tDaaJyOQawQaOELZbqSpBu+bxi7tUd?=
 =?us-ascii?Q?8hR4PTo1nfjFGScxAitnVhx5y2fpJLlSCK8dFoH+o1OSc7JLVsC18JmnJZDg?=
 =?us-ascii?Q?QVGkGk5CIYnJUfQsecqe5iUGWQro6yZnniwa1/yZvj1gSCIup9OCe1BLG/9/?=
 =?us-ascii?Q?Nk7qThn4lX5SzMp4P7arKN1rrrKIkXwT6EAIi5QYST2G95Z/rdl8/bSFFJft?=
 =?us-ascii?Q?XAJcY598u+Lq83lgfmlttaGHnTPnX3RLkXs2q35Sv9AtqRyj2xV9Jr6LstWl?=
 =?us-ascii?Q?ekOIPUyaWumQvpsZeBp+DhYEDsa2VLkPy429WFPDzzSu3tN/NsDz3rZquZz/?=
 =?us-ascii?Q?SEwTfkNQXeR1yjplqlIepfm41PxPF0tf8cfknHkia38NxUFRFR8iUm9fRs+2?=
 =?us-ascii?Q?e5vWyL1n565CWr8IV1k2LK3Dsqe1Ry0B0vaVGN6iSJx4pm5XtdeZYxexddMx?=
 =?us-ascii?Q?1GNEUrWqv8i3/yjRACl2mXL7wwyManGZiRHWfVx7TrONN5/1XldJh84bueJD?=
 =?us-ascii?Q?zEedF5wGG4kbPa2lxNJbkugNtCn1yTe1QprpGvj4yyqKEYU/oiGxdAmFlLIj?=
 =?us-ascii?Q?aKfDp2f4q0uxJ+yf4uUtelbbKQXP/Rbk8U9xJuSyKyCj+XiM/lyGYAl/X/F/?=
 =?us-ascii?Q?cBV0yv+DTqye1QsoqnUlBHhfqmwae1g8TuvBl1VyIKY8hFpECrXa9+VZHzp6?=
 =?us-ascii?Q?d2XEq2xPWjc/366ILXKgwVJ9qeTDsj6oTSvlVmvOtX7bsxoseXpEJdmTc0Vz?=
 =?us-ascii?Q?nXv1EIoRKn4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LJ4R6HTfQO+enrQNdhpRSU3rTekVY7LJ9ya88MKpDzdIloxgnN5cQ79MflAN?=
 =?us-ascii?Q?WgfqvRNoX9oYzGeQsj8dZBcFX0Z5Ofq1CDXsA/6SG9YfyR+Y92zRZsUEiIt9?=
 =?us-ascii?Q?P+Rj2Hov+UinJoiYLxF5EPG49UcClz3aLBayy9V+XblZay9y/OsKKarw8lTt?=
 =?us-ascii?Q?8/BoyB9cOiDHxK1GMdc4MZOSBHMMOIV8HDKL62+KK4pZxflcEMniFC73fIBf?=
 =?us-ascii?Q?7xeRoCE0JZ768ilA3MfG5duGcHmx8ufJ+nFJDQB78h2iNPVrrAP8kDB+NUXM?=
 =?us-ascii?Q?qKcyJp1Yb2DAqzb2VCSwHULW17aNNXMgaD781exFIjMdv0EM0g2fR1dctXHm?=
 =?us-ascii?Q?lxQg9skSNDDqUEVZw3JBP0x5xmGyaQ1tMAVPMo/ENz0LtcF4KDi65wfW0eC6?=
 =?us-ascii?Q?HO873CBJbGzGfUzJItWFD+X6t9MOFG6sAdZoDHbSY8MS0PVmWuOHrVBiBs5s?=
 =?us-ascii?Q?sZtF4zFSxXdi59pQ3fuIDMfStWOq9Bdu/QnU1FsCY90/4GiwcQ8YaJn1y3bG?=
 =?us-ascii?Q?iz5GniFBS9g4obzcXROkIjQxssQHTDwHfywsEajofktud/BeyK2ZD3EA/VCt?=
 =?us-ascii?Q?4lQzGtjA+1HtzCYYnVcQYAwqwNL3ZYMGrUWnLSA5LiBH/ybWjrmjNpoSwqKb?=
 =?us-ascii?Q?ey2koEoQy1HaaUX5J0614DmDiGxbFS5+tJiNbPDfv9OOsLUXuI++TN5+Ksfr?=
 =?us-ascii?Q?GR7qdOZUWFNrusDmrzCKzTOe3DwRNYWIZgTuobjcIcgXwAfXEUV6Wh2e4QFP?=
 =?us-ascii?Q?qzAqZfgAGUjAaDaAXV583LiiVAR/J6YBkiusV2/PS7Rm2DA/UR5tYUYgAke2?=
 =?us-ascii?Q?laUBICKFuRc0aDRYgbrRfvKeFthqSoA8I9PQLLIG99WzRivWAN+T7hWCmTeg?=
 =?us-ascii?Q?3SjXipdldNRNLnJAzswTpLDs3NCI1WRpZdkNTjiVhrFXG9KYMqZuX2rTvpNC?=
 =?us-ascii?Q?ich8aZucWLUaZq1JxxB9aQpIjxffjaS+wfDtGW4Bmtz0z74QnQeELIdhKRuw?=
 =?us-ascii?Q?q5qIU+uVCOptqKFppIocFzbT9/CnuWI3pGKBE9EEo5SiLFcnX5/NvxfYy/Az?=
 =?us-ascii?Q?FjJmjEVLU6bApZPYYQHPh/pDqjLe29+vRj36qdvBb9ISomefP7+UqXh8JqUQ?=
 =?us-ascii?Q?WsBy5OdSkkwDzsu+w3RojutGSfIJXX7nSxBqgyWeXY9Cw1uIZYXvys20j1fh?=
 =?us-ascii?Q?tv3W7vO6VU79/JUGn8xXkXpWYwxVvxc77/OEIrt19WAymu2TTL73utNHBLxc?=
 =?us-ascii?Q?3qUtLzJw9NaneP3PYliVyjgPU0B5DEq7ZtHguxc3apQYLEZs4VEk/RFiBMJO?=
 =?us-ascii?Q?znEfQSSwtf2HrNMT6hxPClOCDSx0TUaxq14FrDFXB1rbbxTbzAf62tZgKsnH?=
 =?us-ascii?Q?dr5sO87CgL+8/S79tA6JaVvimyVgObmGcGLWIpsz0nnqhqI11zgZlXzIDMrQ?=
 =?us-ascii?Q?E0WPXYfAmcUJ0yxNVyeI+OnYY8uHf31/gigr+uDpJ9NYAQbLuh1L6R6rYM3U?=
 =?us-ascii?Q?sQCAfAAkwGcjkPXGUW2LNE6PudzPz6Uk2rxJzVYGh1lbnClf8vEesrlxkj+S?=
 =?us-ascii?Q?wUrwl4R3e7thuFx9KcHVc7Mdgo9bbJkEigLeuYsfOswpUStgZsCbOD19jlYD?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F088079FF779BA498F38F64098B57B25@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dhmrkVaDORA/efnxDR99fx1C4ZOvXH6SUYw5S84sX65XgLf+TC6IILMRaxaHmoxVmF00O8a6nIE5ooPHdWbMnOZ7l9Cu1hnwkqqxaIduzbM8lystNpwv7+ZOSHJyhszTE+E+Wjs4hGrVRlmEtEtVTZK3g5P6YikSuhW3tkTMEhYo66NmpdrBSnT70p9zEZwFUinkXqVv2sGDwmODqJUIkYQRPtGXAMX9r/oORpo+AETQrZLrU9AtoaZiqY0noKTMXibHUPxbyu8/kJi4E5A3J8y4HSInc9dp/cVteCiPZOgmN7PhSQV49cpHRMueqRZ+B3oafpxkb9ikJW7IpG+w96djLg6xLJtJJNK2eX7nHxIsmUjxeoJt90jstn9HWEhKn33NH8Y3aVz4GucIPQVfBmrJwPpDFcwtaYKjvxT99d8N5X7q8ZvtNFtBTsdzKkdji48hlCea65NE7xpbP79mUqlJJEJpDoN0JElVNC8L+FS+p42tml7JIJcWy4t21fKLDV6y46Hq4McLPmHsN1/ILpfHHGbIPn6R3MB0ug9gQttyIGahuQ8mC2ljYpLMsg6z6vZzHil8E93/LCKIDtBLM3OvjZpU+0tu1ElQ3IpnFKsBL56I+YQPauyg7Ep3+76t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b584cb-2270-4744-0661-08ddf6691022
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 04:08:45.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1MGwAxMWjdD8rBMDu5l1i5T0+PShFvDVZldwue2q8yZz8YvPGos/P6sViEhE9x4v2EqAasAHFwqytsWm4M2x5w/w7x82SGhwypwr46fBM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550

On Sep 12, 2025 / 09:57, John Garry wrote:
> Add a helper to find the minimum of two numbers.
>=20
> A similar helper is being added in xfstests:
> https://lore.kernel.org/linux-xfs/cover.1755849134.git.ojaswin@linux.ibm.=
com/T/#m962683d8115979e57342d2644660230ee978c803
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  common/rc | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index 946dee1..77a0f45 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -700,3 +700,14 @@ _real_dev()
>  	fi
>  	echo "$dev"
>  }
> +
> +_min() {
> +	local ret
> +
> +	for arg in "$@"; do
> +		if [ -z "$ret" ] || (( $arg < $ret )); then

The line above and,

> +			ret=3D"$arg"
> +		fi
> +	done
> +	echo $ret

this line above caused shellcheck warnings below.

$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
        tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
common/rc:708:26: note: $/${} is unnecessary on arithmetic variables. [SC20=
04]
common/rc:708:33: note: $/${} is unnecessary on arithmetic variables. [SC20=
04]
common/rc:712:7: note: Double quote to prevent globbing and word splitting.=
 [SC2086]
tests/md/rc:28:12: note: $/${} is unnecessary on arithmetic variables. [SC2=
004]
tests/md/rc:28:21: note: $/${} is unnecessary on arithmetic variables. [SC2=
004]
...

Other patches caused other shellcheck warnings. Could you run "make check" =
and
address them?=
