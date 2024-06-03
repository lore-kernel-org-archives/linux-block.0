Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D23FBA7
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411726; cv=fail; b=VcDCcy5RZwS9N+iFOOyi0l96R1gwhp+onRDYdX71VpUZkW/fQuh94i00+BlGNG82eRbN+OtBCCiTYUoUBCXDd1mZtTk5CUciHMhmMIb+3g7zzUkeGBBs1ShMBXPT0e12Ku4GZ0Yle5YCh1CQVQRwfcUXI2Ur6EQK6awGA+IRgQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411726; c=relaxed/simple;
	bh=zJkcZV/FLJfPBqbdwMXiWMRXEY5OgcbkEBd4KRBaIMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6BM3fMgbLI2NXdXVhkHPk49Kk5CRrpSCyqTF30OOzPDASl4LCwPOjHIAerP3hXohXcoR9SofKE80obHBwdw8B1Clb1yhJdiS/FzuAPoBw1UwE+hHYFYafyvxE7oYOT7MpabomCeit/J0hdCdpoGYmW3dLyCTf842mG1ABvEot0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gGei8a/h; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ss+x0bti; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gGei8a/h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ss+x0bti"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717411724; x=1748947724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zJkcZV/FLJfPBqbdwMXiWMRXEY5OgcbkEBd4KRBaIMU=;
  b=gGei8a/hvtdfhPFnQe2R5rsIWcJuQ2oIDXmHzmiIfse/gU6PC2RO4LrA
   /438KU3r3/iwGYOwfL9Idci7o+eo45yHXvuMZHAV14m2U9ec2O5pzeC+g
   EJ1SrLd+a8gPOPE1ZLDlp2phsVNA4LgQwtvuKFW0Fos0aVOziFph1yyEd
   A07pToZhUlEGMZguCLModsOVniTD87kuULxJeJr1mCUIXPJTXdnkGLCBN
   LbFrgg195BfYtWMJf74LmRgKp4aWy6RFpbz4R+hf2WcDZphD8GmNBu7nB
   d28QDOdTiZWfdfeBwtO2d4Z+YGDqWWuQgeBxs5B+W4T6Cxn8S43SwQnjs
   w==;
X-CSE-ConnectionGUID: cpye6WvWS8+vvG3KKnHToQ==
X-CSE-MsgGUID: R4B96+sNTfSsCDJeILPWKw==
X-IronPort-AV: E=Sophos;i="6.08,211,1712592000"; 
   d="scan'208";a="17706723"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2024 18:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWei25f4NaM+lg0ZZ0ixo7BeQH5m2cI/K/1ZMqzGbzwyeI6VNE5Fi5NcDJSxuG3FkJAd/qQD/72zYSFqcwcJC+8mzgdIcaE+6IfAUfu46JbnsoSRqkZAMOj9bKkN5jKYJlAJLxdrqey7mHX/t5/F8r9rWQ5bytxTGNQf4DHxWb6foyxWKUpAkR6yZMhQI27sYI/PdWmdwgRNPtgAK1ae+CfCEdCyNrdQ384ygN1oZ5VG+9umYWXSr6LzuVhV0l+CBkb5RennuAeK9heOHQS5h69m1J7DYLwQNnpka+hJhZZsc8I0pMJO+nHtcp2lvc50Eb5hg2v/QEeNfaCWmnJu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkqYJ/Dzx9EQMiPN9NZwNAixl7Mnybn89V79XLCTCII=;
 b=HvjYARW8WY8WXwel6WZOZzuol+NX+ic52L00NtRb0MXCv3U4p0STOcfqMOaTNBkNrTEwYatixq7s0zKGAuHY60bJNCYw601rHilG9uuIgrhIrYUpxPZnj6HMHVmIJieIKzvrXk23arIBrTOUUMr9NAQ6uAUbnO5uqcGYBU5JS4M/T3dxq85mFMBANHE/vrPTTYWNFhtyfd6ARF5RaEDy9aWFdC87+6ftrdootcSWmDBFOqZ6B3WcQ9K4TU21M3tDcaJW8Jmei9jRML/D7gVbt66GVYYaTAGV1GOCo8GhQLjDQRM6fGLNkipHXTaQ1zLlsebm7BCuXrMUjYtyLoneJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkqYJ/Dzx9EQMiPN9NZwNAixl7Mnybn89V79XLCTCII=;
 b=Ss+x0bti7vkDn4RJosdJL4q9if2sOYeINHfMVz9Y3LfvBojNF0jXTO9GRkFOknXEbVWrenHopjNxiqFXzLd4/mISQDo/QFSQYcroWmTaao6JeRDHFr5sg63g5FUP1ai/XwcvsMo0vkPaniqtvieQsGaWgc/Z19L3jNps12hQpGg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7671.namprd04.prod.outlook.com (2603:10b6:510:5a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Mon, 3 Jun 2024 10:48:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:48:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: Re: [PATCH V3 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V3 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHaslo7LGrJZSVauUiGTCt3iR9q9bG14nQA
Date: Mon, 3 Jun 2024 10:48:34 +0000
Message-ID: <6wxosk3bjaxumrk5xsy7euifwvftspikk4q35m67tvryvculra@63zgrasrshxt>
References: <20240530062545.79400-1-gulam.mohamed@oracle.com>
In-Reply-To: <20240530062545.79400-1-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7671:EE_
x-ms-office365-filtering-correlation-id: f86663a1-1c63-49d8-3d52-08dc83bab7b3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+4mK7Ba3tA0khJ2YrnRVtLq66OGcaZfyQyIwZMU7+TOsVUvyJnjY2OMU4Ulc?=
 =?us-ascii?Q?jWy8RDdApHrEUXpS/aHEDpeFGcVh5+H1N3Hay/csLTXvCofsbzGUWTbrQQgc?=
 =?us-ascii?Q?dRhYecGRYhlaT4nl8slX5RTOf19BG6Jv0qdgOP1WnmKNxNst4PwsAK4SpOUH?=
 =?us-ascii?Q?M4RTH11tC0f5Aa2RvSWNxHRZPsks2KLnklF7dyLctaan35h+gWMp8CvYrYJ4?=
 =?us-ascii?Q?2GIaTNLOcdsHPZOfemuDB3AcMvgC1F2O5wKcibZhcn+QLeaINv7OQO/T7P9n?=
 =?us-ascii?Q?A5vp0/P7XQrKvmb1y0kYiGPihbON9KpHe0v7PsfMdZur2IMjpMU1CKAajFMk?=
 =?us-ascii?Q?JK391UPTz8TdIO59111FtCDjCtc5OoLM55adz5pIIT25GplWqgsnszNndMPJ?=
 =?us-ascii?Q?eCcqdW9pS7LPR020RmJoEv2oiYzYQCrd9KyCB9YHFkzO3NOQ2PnVSOIeRb5N?=
 =?us-ascii?Q?1CSWPQ02mz+V5gMoMdPAB7Fc3fTxjEQLYOEzSOY79QdBYnpVfSBRGM/OjcPQ?=
 =?us-ascii?Q?0E+VHZelfTSL7fzRoUVCuvZaMdvu6tvukltqSeTJ8P2mQhB129Jo8Mf1iIKa?=
 =?us-ascii?Q?yShVJYU/DSDN/3eRu0ZxZA88cbiM/0S47l9kta6VXUj6nvcg1fjZMNDf2wc0?=
 =?us-ascii?Q?JXBC/RA8JM04butqgL3D4q4q/llHN4VMCjBadrdY8vYAmyWBSXI2QEO7UM74?=
 =?us-ascii?Q?0CZ9V+LLxpn1yN0DzAYZ7UtfHfYeoDUZ1hOCJ6w7SZpcDCYcsre2bX5VmRms?=
 =?us-ascii?Q?FBVucPn5svGUP1tIBx/vDR7un2VRjDefsohWNC8NZZGu4i8SJWlqRJh+/F9W?=
 =?us-ascii?Q?BnH63mp8gvFN6/6GipxvIBM8rYq14L2arMaDQq+XIHBSAN88bfyGSUm4oJcJ?=
 =?us-ascii?Q?73LdGE+lkPyB/mbxawhQrtcnBuA7XC/dBHoIEs7XsNHEC30fcXtVtI0Ot9Qk?=
 =?us-ascii?Q?Xo9QDOnTxjgCal8ggQu2exbm8BiJPVZgqaG3Xz8eU2UcVqCSWGvWiTOm6BqO?=
 =?us-ascii?Q?NLWa1GXNHhNFtlWmiA5f5lrtL7RU1+1rNPmYf1LOMuDK1K5ie7H6685ldaFv?=
 =?us-ascii?Q?lnBfTqhCrKqHHaiPt5Q1ysXJyMzVyzRfOpS025n7CQ3CpNfjQ9DfTmudbHhE?=
 =?us-ascii?Q?arCYAaOEgJyhSGQW6Tw06+1DqQJg7yAjLbCUyqtXflxDbgxPN79XsAoSvkLa?=
 =?us-ascii?Q?p6+a80UOW7Q77ykMJBLyE5BmpeXZnqEJgBX7UrZcn2/PD4z+OQm9LA8ioUOy?=
 =?us-ascii?Q?1anQLYyFQ5rawj7oYV9VpPtLCq7l9N+DWsjRtpD3PzL5xs3nsrwrl0JtUt5v?=
 =?us-ascii?Q?+COkGf/tuvxy5VjmZGtcxSDMZYByLrdK5M2pzR20lOQzYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j/M+h2uAm9fe0+ZI2HqidPUzNZRM6YCS70E9zXydKHH34Ii0+2KuuzYo63sp?=
 =?us-ascii?Q?qOvEMIuLReliyMZAIBtG534xAOiHKWCbvVkgXGPKiSNGjvdlbE8NaBb6oGJJ?=
 =?us-ascii?Q?vw1Ri0DAY1pbUc7liteH9/Ov9JeBwguIuadY/zzUEPncKMyXhd/7e9bjCrHx?=
 =?us-ascii?Q?IOzdo4cNYtXXcASXweoKwSSa2vfOEDYm7Ij1R1JTXSYfMoWBUkosJkjhY42Y?=
 =?us-ascii?Q?KnJsU8WoSYnb2WZL4/Cz6V2GDngKDRZUR+syu84rQwxvj5ZdTaxCD1Q6hlmK?=
 =?us-ascii?Q?GoKyouIDVJ7xzwk6n5CXZByqMS7DTQdXo2M0WOF5IhmWLTIk8xYYHdkan6+F?=
 =?us-ascii?Q?fsa8Oj7Xkym8Gjr5Fpq5STGwiFZRX0/OMxwj5PDCi0x8J5m84IBvItgaulUn?=
 =?us-ascii?Q?A1OIUftYDH7RQ3vgZ/tWkDsTUqv59bCbLGMU0JYz9KNHVHfy2NQaI0XinLAx?=
 =?us-ascii?Q?cJRevswlfCzfRNChhFanb8YfpwiXCPeWOhYpfg8XVgwTftAUSv8sijIShQHL?=
 =?us-ascii?Q?Znf+d9xNann21rOKJGM5REsSkJN3h/WDPMBXNdqP5JvR/FCpxjBn9Hq1gchg?=
 =?us-ascii?Q?BmKYcsTdMejcm5qr4z7Pz9cpcIx/v0bJfZinx7OR3aRB/AeIcZbRkGjGy6F4?=
 =?us-ascii?Q?Jm1XDRS6pMc5b6v7gnSoajvEVe8+1cS2cGjp5qgLTXyNGNxI3X9LxzWWbCE1?=
 =?us-ascii?Q?r+W+xTzskQIAaLOKUijMjeTyMOa0/kIeyrgB5AStRRys39Eia3vcqqimTiUl?=
 =?us-ascii?Q?WbWMWZsjgbseKgAlQN9OmzayM7yCYIRP7jkBbyHo2FQdW9OoxutgoXdnGfpv?=
 =?us-ascii?Q?nvJ6E7Va3uCFK7UgKZx8VwOV4HKIjNucnnP3DJEx1fht7LXhAB7HoAEe10g8?=
 =?us-ascii?Q?fyTckGhLfS+Zg/WqOWea4XgNJQyBs+oy61j1WlHfXzfqRDIt2NJyXQ7Slrth?=
 =?us-ascii?Q?g7uV1HTPTky1IPFSWhrboESdZJMEbL2bb7kxhYWNnnq/lKINWUF3de1V4h72?=
 =?us-ascii?Q?g5AdKcwcf4A6VlMs8yaTO+jtnFElTp8YeLtHm3UYXzRBxMGfW8Qvn12ECC5W?=
 =?us-ascii?Q?Lp+/hxZ9WIS99OIZeHl3sRz5aSs3OtaKKpjrP62nk/Nxs8r0tPHARDoT1mgm?=
 =?us-ascii?Q?0CpKXDfTS0pH30GWME9FzGNi0LGIFGGBHi6lzPwuOGAna0Ph1i/o8SpioeI1?=
 =?us-ascii?Q?MyEm9Ul9GYLKPQqimf2PR7qbJ12bTHc2arL8rknjkAHx66C+0dDKaZG+2Vmy?=
 =?us-ascii?Q?3jUj3v635Au9ElK5rUf1gr3s/tZFsZdnYlFUBKIkpibKo1dqcyos81fLlWem?=
 =?us-ascii?Q?RwavWcwMWlEoBrwGrQBFFcd+NPUyoIsTW133rI0RizLapRgzC6xApw/JOkZL?=
 =?us-ascii?Q?druxHHSRwM2wV01phUjlRvFDgtzojFVUvUkzcDPdTxiR0D0t69nfAX6cexmZ?=
 =?us-ascii?Q?o1x9pjuM9yoFRiylosxjt3ZmnIHcXNZMvIPRPDhl7vGNvfusHhIgR0J/gZsK?=
 =?us-ascii?Q?Jc/W3umLo7z6xPKdJKMl2H20oHrHWeex6kRrTgZdakMaJlluusA4aUo1nnT9?=
 =?us-ascii?Q?P41cGApbuph8WufXtTIuXwFaAWK3iobpmK+jSYSsaPloQKbHTNWAl1Mdsbg9?=
 =?us-ascii?Q?6+kOBVyIuBsRAJfeR0TXbRQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <003C4ED72B7236469238864100FA352F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3pEPFCyh/L3pLSejVp+6tc+yW9/LxmzY2qyh+OQCqDUF6fW6BdVKZYa0FJ13LGCkYEEziWoHYmjIyNrgambBklVNytnmDbU7MgXxlx760mpK4H6x3BBGDJ4D+YIl7rGuO0cX47GnM9OwqfJHQV/lQ62Qg1TWKmlj1uj7LISCmb2EGgKtkxtfZjt93kNiKfvFtFKtakyuiEaB2+nbQ/VIh5XbZsVucbsUqwhSNKlsEgcL9N45y9ppifRm9e07Ar3LSNbm3Gm8FLzhAioFGPrwsj3ZFOsXCo7W/bNMjSKO1Y5k1tLIvcrUf6dz9pcVX6mfSxuc8nPGo2pgfOrYXJE9mJj/UGdNbjlU3Qd37eR9m1Kx5MJ/3haycKwI6JXRD1QFwC4bTKbYl6BD5yFyfftrMoqzYtDSGAGvMVsH8+X28rzlDAnhhyLBngpLUYlyHkxdBdMjGJd0nTozPTwAVa8rKOC3r4u7LSfYroo7qg4xjJN0BXEjhXeFoSlyn6iSPkELr2sSUIulgJ+wGjGey17xR+Dg5C8R5h4MWuDAYy/frB7t2YSoQiUU1a3iQIbi1dlv4Mu0dcYDvkC45C6Rpl9mg956xyv2mwTxgmpNMEbopM1IGF5AilC9/Hu/2TEkXHiA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86663a1-1c63-49d8-3d52-08dc83bab7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 10:48:34.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBtoVyN+Gbf9JC7ArYOHNuH8bKoKniBoiY0mNTSYhY3bcd2wHX4MtkzTtRF6Dd5jiYvSA9sqJWxm544gegIjZJpWvuQ3SoL72gb6fwSbzNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7671

Hi Gulam, thanks for the v3 patch. I think it's almost good. I found some m=
ore
minor points to improve. Please find my comments and consider if they make
sense.

On May 30, 2024 / 06:25, Gulam Mohamed wrote:
> When one process opens a loop device partition and another process detach=
es
> it, there will be a race condition due to which stale loop partitions are
> created causing IO errors. This test will detect the race

Missing last period '.'?

>=20
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
> v3<-v2:
> Resolved all the formatting issues
>=20
>  tests/loop/010     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/loop/010.out |  2 ++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/loop/010
>  create mode 100644 tests/loop/010.out
>=20
> diff --git a/tests/loop/010 b/tests/loop/010
> new file mode 100755
> index 000000000000..19ceb6ab69cf
> --- /dev/null
> +++ b/tests/loop/010
> @@ -0,0 +1,77 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024, Oracle and/or its affiliates.
> +#
> +# Test to detect a race between loop detach and loop open which creates
> +# stale loop partitions when one process opens the loop partition and
> +# another process detaches the loop device

Missing last period '.'?

> +#
> +. tests/loop/rc
> +DESCRIPTION=3D"check stale loop partition"
> +TIMED=3D1
> +
> +requires() {
> +	_have_program parted
> +	_have_program mkfs.xfs
> +	_have_program blkid
> +	_have_program udevadm

I understand that Chaitanya suggested the checks for blkid and udevadm.
Actually, I don't think they are needed. blkid is included in util-linux, w=
hich
is documented in README as a requirement. Other util-linux tools' availabil=
ity
is not checked: e.g., blockdev. As for udevadm, many test cases use it (ref=
:
common/null_blk, common/scsi_block), but no test case checks udevadm
availability. It doesn't make much sense to check blkid and udevadm only fo=
r
this test case. I plan to post a patch to document that udevadm (systemdev-=
udev)
requirement in README.

> +}
> +
> +image_file=3D"$TMPDIR/loopImg"
> +
> +create_loop() {
> +	while true
> +	do
> +		loop_device=3D"$(losetup -P -f --show "${image_file}")"

Recently, we had a couple of troubles due to behavior changes of short opti=
ons.
It is more robust (and readable) to use long options than short options. I
suggest longer options like this:

		loop_device=3D"$(losetup --partscan --find --show \
			"${image_file}")"

The same comment applies to losetup, truncate, parted and mkfs.xfs commands
below.

> +		blkid /dev/loop0p1 >> /dev/null 2>&1

The line above can be a bit shorter:

		blkid /dev/loop0p1 >& /dev/null

The same comment applies to some lines below.

> +	done
> +}
> +
> +detach_loop() {
> +	while true
> +	do
> +		if [ -e /dev/loop0 ]; then
> +			losetup -d /dev/loop0 > /dev/null 2>&1
> +		fi
> +	done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +	local loop_device
> +	local create_pid
> +	local detach_pid
> +
> +	truncate -s 1G "${image_file}"
> +	parted -a none -s "${image_file}" mklabel gpt
> +	loop_device=3D"$(losetup -P -f --show "${image_file}")"
> +	parted -a none -s "${loop_device}" mkpart primary 64s 109051s
> +
> +	udevadm settle
> +
> +	if [ ! -e "${loop_device}" ]; then
> +		return 1
> +	fi
> +
> +	mkfs.xfs -f "${loop_device}p1" > /dev/null 2>&1
> +	losetup -d "${loop_device}" >  /dev/null 2>&1
> +
> +	create_loop &
> +	create_pid=3D$!
> +	detach_loop &
> +	detach_pid=3D$!
> +
> +	sleep "${TIMEOUT:-90}"
> +	{
> +		kill -9 $create_pid
> +		kill -9 $detach_pid
> +		wait
> +		sleep 1
> +	} 2>/dev/null
> +
> +	losetup -D > /dev/null 2>&1
> +	if _dmesg_since_test_start | grep -q "partition scan of loop0 failed (r=
c=3D-16)"; then
> +		echo "Fail"
> +	fi
> +	echo "Test complete"
> +}
> diff --git a/tests/loop/010.out b/tests/loop/010.out
> new file mode 100644
> index 000000000000..64a6aee00b8a
> --- /dev/null
> +++ b/tests/loop/010.out
> @@ -0,0 +1,2 @@
> +Running loop/010
> +Test complete
> --=20
> 2.39.3
> =
