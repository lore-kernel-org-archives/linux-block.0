Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152415A49F
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777741; cv=fail; b=fgTS+mwWUsBqZITKcowmVctAeeCdkJfX3MyXtMUl5xaySVlig+jTL1+cstzy7u6iXmdfXRoGyrd9Bi4IzKgkoh8O9E6Li7nJJki5fXR5SpzEKorg6bj1e9XRFht0B/esf7NSVNwR8zojVDvJ84eMPuDUn5Ir5YgzZBTklEbFZKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777741; c=relaxed/simple;
	bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRhSJ/kv4zJ6wJzpH8sBGkH5k8kxjpgzO3vCsgWGwVGrGgUGo7TQi6B1xzEiHGwiZgWHntCPjzzjeMcMQA1n+DcVzOwz1pjEQhcF5CXOuNSiC32FK/rnQxLkoQ/OyKjuaf92pe1VXgu0Et/2kVIKVQ2WCzcylmnN/aPU3YpnQiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PK7+TY6E; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ARw502NF; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PK7+TY6E";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ARw502NF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706777740; x=1738313740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
  b=PK7+TY6ErquY3q+jbOvjPZyrqBXgsnlfIsJZs9PiU4T9qBCWwATG6wXy
   2DdnD35XqfkummBi/3D+39gw+JSFXDfYsPrFO7c4GT1c9IDV5DUz9Tfcb
   VPMYgSxGgeaUbkoSnbvb64XmUf99qLJyM0ljrS292YL4X46Z43/Pc/Q4v
   zy3Fd2SMgpOr1AMQdg6f1JKLdWaNQaAotWd+EDMsGmHqMiXUYObq50Etj
   SSgEUkY0xiUNQndH2kLBjzcDrT/EHv/XA4XAFiTTS+abLFq2FbXiuq48c
   xOftaX5dBs+K9EsZWCHXePWxT2c7yZl0afTyLCKHtURNHCBbTBJdukp/N
   w==;
X-CSE-ConnectionGUID: BCFzFLBNR9iwONzhPiApQA==
X-CSE-MsgGUID: Fml6sF4pQOCfUO08jxh5nQ==
X-IronPort-AV: E=Sophos;i="6.05,234,1701100800"; 
   d="scan'208";a="8176233"
Received: from mail-eastus2azlp17012016.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.16])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2024 16:55:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Par0hiS6a2Wn4SMbhcSHYnQv7B6mXXqEVZ3uoURNUkeBcZ8apjQlEu3/HcGN/JkuMPk9Canmp+fqaugyMRzxpKblqPmMO+33hCNxpmtf3ZfiydQkdUVsyepOjfY6iFeqvTzoE2l0bnUZCQ00UGDC0d1Xnm08KJeYnZ3aKHakJpIv3ja1kgy+7yylRAg1Uhf1bieEHV6QoM7jVGxXmVI1uI232ruICw3MvfuQMG+3FrkNbUiHAIl4wuG+dgiLFqg1Y7CfkGoNHMWMDg2zYajyl523fGh2sSm691J18BJWT/omzyTVCxXaHbX0NijOP2vWVnzq0XnMdFnKiwG8GCd3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
 b=FId1OygdYQAKTtSfqaruR4P5yf5dkB/qAzjawnGnVAH8hxOPklbitUz/KWFUupo3cLPNXFT5Rj3Giz0ttQDnKOQ3OVvbHpQD70y5oKlubvl2uDiPpJTFlseJa6wobpvUFoNkxldCSMD7/Fg6knm08hw90kNdA7xLyIvFKViwOx17D2xL/psRHtUXIO1uKGLOFlNe3+FXbi4UitsKXr4EOJC2SBKzFccnG2YaTQAxmjizuayl6WMJ5vdgerWx3mlM8Zs5aTp/zcnXopLuH/m2yBG5zTUggjwsoUFj7CiT8t4FDKkVpdb6dTcUBB3+skmuQ6aqFzXfekwmBEkOLpbuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
 b=ARw502NFg7vP3zzjplwWykx2Ar8tGWxnGFcyoIvNyIhGZaz08FyitbH4dxHQ13K0toMZ2Cv1BxnVeaS3Qoz/E4ZnaSOZXZZrlzWZ+SST40Oi59u1jQ5hY3Xefepc6BdfTGi/CBlhSRgRRaffGmfMv8/jRk7itJFHTJFGjTWTIKM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6715.namprd04.prod.outlook.com (2603:10b6:5:24a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Thu, 1 Feb 2024 08:55:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 08:55:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests V4] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH blktests V4] nvme: add nvme pci timeout testcase
Thread-Index: AQHaU/9hyM3n/sf0lUiQ4wyQitoIgbD1MNEA
Date: Thu, 1 Feb 2024 08:55:31 +0000
Message-ID: <6c574jvl3l4qty22sbstj3fnholnd37mv7knti5lwraoo4m4b5@uxrdvhauac5x>
References: <20240131043811.12292-1-kch@nvidia.com>
In-Reply-To: <20240131043811.12292-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6715:EE_
x-ms-office365-filtering-correlation-id: 8a66b9c5-b3ed-4e65-4a60-08dc23038b7c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xTAOJE0Pp2n98RSYAlGd0UZVQo+K1PfRdSbrSww/2NQKLtveYwP1aZBYfYUxuBjDEcAKyHG1KAK9ZZXo67Ty5k3hKiOMz6aG9M2uZ7FHni2whPpN0SjBrUPXgUFd5nNoZmuc8MhtNruXkg9hQ8LiVylITq2Afr1IiVA0FxV/SewvEImTVZquSmcHMuFSjWHE6KNb49hvwwMZTC3nwC57/vrFjqROkJY6DNv6JGEKWjK2ODnBBjlLwi+vrMatRgMMjcMcHfa3AMLQ99H9twfZu+RURrycR92bCR4Ev9/JrZ71fPwBhH8gtpjvWqcIjr523pDIZaqTyMKX5ge1QbOVnTrfarPa9SdZ0jnlKReQaUmgGjuTYuwlDcqcpt8v42TdANcE4Cydaox30e2/B4CVRKWBPSEPw0Hx5hn3Wo5YlmO/hUMPyujynoNr3CNSTtxydYwGje/zmne/aBxEr97GRay9iDyHGGeSesWRk7De46iGwIYz1ZZnfEve9ZnAGbezR9OSdWlxCy1/QDozluUdPjllRV23DPwI7Qv+Lg9YIvEti7Y1dXSFRBmOpezRD5EVLp4BsWl2c6y12zmLg3+dMc5xRfOcVjfVToQ0LVFGnRsZTCG+tUXJE/Vt8g33ZOWm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(66946007)(8936002)(4326008)(44832011)(8676002)(2906002)(76116006)(5660300002)(558084003)(86362001)(91956017)(66476007)(64756008)(54906003)(316002)(6512007)(38070700009)(66446008)(6916009)(38100700002)(66556008)(122000001)(71200400001)(6506007)(6486002)(478600001)(82960400001)(9686003)(33716001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W4Y5ztZa8p1lSCH6/YDqDUWVvt2zVf02gChonlvfkN/GT3DIzBvnX27moNKd?=
 =?us-ascii?Q?Ttu5pLBoUVSa9a6kmb4FlrfBbyalXAXmGFf36D/YrggMqQsaVg/InNXUrmHv?=
 =?us-ascii?Q?xEetfuwhD6KAH3KQyaZiSGBrybKwU7daGcMRpBI7wsgQ6hq60Xh3Is2XBY1K?=
 =?us-ascii?Q?WyxQXsRVfrp/5PIubwe71pTAQASYUCaT3IEChv08v8HXO6SUn31PgXaDbhtD?=
 =?us-ascii?Q?gQ4RJrsPAJ7ASN4pyovygK+LE2Wc17maWhRLP8PDcO3yB49aMOXjw7nYhrX1?=
 =?us-ascii?Q?XjcZ+VsUgAK1Tdaj0tFw2EI306RzFs1b9fJeMFHGCCXKG39vFG45WjY0Ezne?=
 =?us-ascii?Q?4SvX2YU3RnYF1rm9DGplgNPp/tkcQ8ahDUw0bjwIGye1tKJmItyFjsuQCV6D?=
 =?us-ascii?Q?aPvg5BzKCmq6KOQWstqG1k5oVtFclC3kYj5sLg4BIdmXEQRmVEp4S/X7CSLR?=
 =?us-ascii?Q?FgCgfLmRbj53/gpYvPzi2z9Md+ZuyJJsmYFoiu6nucsN4bbyU+CslfNF+23C?=
 =?us-ascii?Q?K6ttPosOTWm+QNWr8A00d77hgX6uOhEsXWSVp1BKbtSC0ySPI3DqcdtFSEOn?=
 =?us-ascii?Q?8HpjlIqnANx+WEpW58WDaQO+sg2I/18qjkWj7VFMjOvQX4AhirsBhtsR+SjZ?=
 =?us-ascii?Q?rQvjy6B8CeuugpgtxzqQZaK6gBffs2LNwJU4io5aoGOopDuTx68bwUdXKO1K?=
 =?us-ascii?Q?olZZ7g6K0aGpl355UTqM3JWHte2kzYZu2x43Xv2p5pFarCaPw9xR6UXmux+T?=
 =?us-ascii?Q?6wbQHxP1vCrJGjNEfAIKVMDiR8zXQfgOLhGkQB1Ab/zSEubIX8vwa3c0pQ9c?=
 =?us-ascii?Q?64pOeq/m/yGR2IX7qiMiYQ29VZdX5uqccxOpxqsLu77e1rn06PBM42JcYvSM?=
 =?us-ascii?Q?/19zwnTlWfOMB2SZUEV3nsUaUa0wCs23n/0nXtw2zOvhFXaREeiiv1I0FkEj?=
 =?us-ascii?Q?h33Ws9To/knim7YDagc3OaHe0PyWH2xtCL6sjOrTIMRgGZd7mmR7qiXKBbxK?=
 =?us-ascii?Q?EjgSAHrC+35kdeCKpFvCUR+rEuhb0zNJ2EWrLik3cMXqZv+SHKrKMKjweFih?=
 =?us-ascii?Q?ujyspGomLvcbhbuM1jfd1KTFclqtRJ2oty0Oyqu4ape1qBIsU7iK8fF7JAg+?=
 =?us-ascii?Q?uTbbFPWJlu3B9IyxZlVLh1z3nSdh5y9+I2yY5o21flACR/vTOZ0CgyCC0Rru?=
 =?us-ascii?Q?BJb4J1zwE1PACMSwTHE3p0Bk5lbkTQDjEcP9/b6wTZpb08YLU33zSpZX6705?=
 =?us-ascii?Q?PhN8cPho5ovxOlV20HMTfrYAqf4l5cT/XmK3KrdZj5bkZzgK62m5VsK/9+lS?=
 =?us-ascii?Q?Ej7eMqYX3SZinkgWE52uBpEl8KbhNXAbC7nenG99AEV83aHdBjz/BajGteql?=
 =?us-ascii?Q?HneXaYunEyWdIJ34Bilcf7RYVP6jd8P1fVBcck2l0B1x8P4zudamOeohwtbI?=
 =?us-ascii?Q?ubkx64kwoSAARu17vJJJKuwGDjRkUvOhUdRokKdhMgvYr3RdST4kXErmkfrN?=
 =?us-ascii?Q?3/YBgsK16tESqIcBFfEioUovZsYTj6OG4OjvA0fvGJw8AN9V6lQVfrU2KFIV?=
 =?us-ascii?Q?lTGxvk8VtF4cMJW3lErVzZP4wInmErE0dYWqaCHQsybFbK6CZDnA64sdanwj?=
 =?us-ascii?Q?2okgqFWGmkUPcqMr9sqhYrk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5429AC88F5E15C4FAE299965CC05EC73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VuTHhgKw5oK9iyI28ZjiTQ21TRS8IX73jt209EHuv/lQ9L+Bx5kqwjXVcDuWYrath5B9VzJsDUmeB0CaYSFVU9wIvaTesVFM75UovJcwTYHMuohs/HrT+9ru0iQfz7nJRkjZg0q6Xc9RMpIT/9OF6bVI+RIz7k/8FztSR4Q8Ba0XItjLMu0EtgKX4grrEXB3qXgtaTMwiay9kEWAjsqmSFa3aA+u7p2QVoAGDO7KueOZcxQ+Yk2WpJGj5BR2CvIPmbX1Ywnx/AWqFt/ywgPum/hOMu3Pb6XtOjnXa6ktPHweNo5deK/bEPBJmgPBuz4YnyVoxb+3fQnEWQ8jHHFgT9qosRM8QJazgMKLQkc9o1uwAjkarHLskIxYIY6pjN8xuQW4mkty/XUfly0EULpjcBptvSuXywhhGO8gBGHkRDd+EqriLg1uYYK5277DvQXZ77prioBDikYORnPlCWuvBX4mRk9Cgs35DfwqCdlabUgT8/ROy5uTHD9aa+AnxACOMtbVnxMLO1SWsJcGZW1WOMKjSWZk2XIntBcJ3OGpuMcEmeSxHYegL4n7Bw0mQczjj5fhsNnm3lh03T9Ijk4BBNe9ZlfemDMDi4GIvyBJplU/mthBZSmRNuuXXiLZgW9g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66b9c5-b3ed-4e65-4a60-08dc23038b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 08:55:31.1414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ng5So34gcGMiJ0t9S4q87Pu4HSb9YRpIbpoWB0B6Y0oRWrNWJ1EXPPRPsoM1CkxKKcXlgn953XlwPUFxmvzxsgOdxyspwwVs225BPlS9eMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6715

On Jan 30, 2024 / 20:38, Chaitanya Kulkarni wrote:
> Trigger and test nvme-pci timeout with concurrent fio jobs.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

I've applied it. Thanks!=
