Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD923A6
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491620; cv=fail; b=H1IHIirXoAhDaUzK3TNlHnHcBoRrEZFyDzhw4SbX7H3m7z7HxSrmHpmVTqnMAYXkZbzL66FJ7q5Xd2IV5GZJOa9o2xtAke8GTk3RR2+MFR9fmX89ZUyy/qAqpaba/tegHOZNemNAe73lfiC2TvQI9K4zKXhfBlt8XuwCOYzkAoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491620; c=relaxed/simple;
	bh=aBBCz01+pTJ/deD2nP6IFzVenATGb4wxSrKR4IxNrTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LHLsVfOgfdK+CN/DiGTyqqkyKjDYo6B+Cepv0rPwUUgJf9XFrjoOfvssuSC/HN5Q4S3JR2RZiYUEuE6laT9AdbXD1c6voPYELL7WrVCJfWloqYM8/s3jQj5O4PsVDhd4p88B9wbpHXZsMOKTOoFGG8fwZXpLkTzwk/Km/q+FM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eHFMxvjG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pa6Xr37Q; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eHFMxvjG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pa6Xr37Q"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752491618; x=1784027618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aBBCz01+pTJ/deD2nP6IFzVenATGb4wxSrKR4IxNrTI=;
  b=eHFMxvjG9dJ8Yxm7/DxiZ5e9bK7GhZvTBVfl0n7k+ljrf/98/ejd4JDZ
   Y6wmecwsP/5Roql6Z46Eydq0Kh/ZbBff3xsfzBtrvQM+R4t11F6kj0ADp
   mPlr4fB4JpC+ZmrbCzX+7o3ef2nofsKZoy2h2FNZfK0LUbFWJ3h+p1Qed
   fpjgS+J+7rEFHvGPQUdjloyKc2Teq2KQV19GS0sjPPkcTiGG04U22YWwo
   VVSdb7+WvQLIDxpOxY/hJ8lwozASqbDIuNbx9oQ1jZTPo8XBXKwfpIrU7
   pZSB/khJSMjtrQ/tn+P/Yymo/Tt0jfIpHYiR0InWaOlQVhCB6VbR3RTDL
   Q==;
X-CSE-ConnectionGUID: 0bvhyWWdQECOGW4TwBlaiQ==
X-CSE-MsgGUID: U5eNsoAPQMmm0i6Qti+nSA==
X-IronPort-AV: E=Sophos;i="6.16,310,1744041600"; 
   d="scan'208";a="91745077"
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.63])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 19:13:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGMQrwAxoeIV4uK3I3EXzW1Bzb7DwofuoPzM3PRbeQSIuBs9j/xYqgOTWK448gkXi40/tkljIYQlN79RygwbblpLxfVHJWBaHh8K9Iz74e/Y9jHdVVIMqT9hSvFT0Yx/snu5rOM870tHSvuEBpUtdYIf+/XJQyykttIwiKkrA+Pbza41/1au59fjKxc7kUxQqiHJ+54ai9//9hBF4LmC52G93lELdfRQQnZU68TZw5M2PuMHw3e1f5kyO4lFKCh+uEPpGu0Cw/w99YSvAQtDBdDM0mljhKvfQAXfh0S/0V6PuBzrrwG5ET86zwNcYR9t2tVe3u+95ERAL+UWuzC1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPuCT+Zi0mWmvblJMS/Kfv9dmzc3RRSrTUuK4J1eG+c=;
 b=PWZZ7DT30Qyt2zP9NeURg0XDsEtokixgyh8PRs/XwU4InTpXX2ixQhEkf0C5PeW3mEvK33XnA8jJfkinLovucwFkKYtSAY2EqDOuZI/feeJ4SP78eXe7+sxQ0GyoUliv78ngcYhDu98ounPVq4sSQIsWm/jmRpKpZq4lEfgwpj45Hjqc3toasjISaDYgUBRSBS69MBG9R2CTk1UkzzjFY1rQgHMwPJ3CSCL8TvTGerobLJKS14uSv8KTXJb/uzzArwxBK44o0R1L5fy4wXnfhL2UQ/bhQ4f7FQ5O3bEgNPxwIz7NuAR0huJrLtJTsfNKdGmWnATFNTiV8+/VWzx9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPuCT+Zi0mWmvblJMS/Kfv9dmzc3RRSrTUuK4J1eG+c=;
 b=pa6Xr37QAMSgx8jFa1L2rNYQd3q02xaAbX8YAAru6l6x3n8DezKM37rytayJkgcoBrYX5PpdLcfCR14ffqPQ+wLygFwSYeUnEXkBxFkw6iurusGVpghbILRLYn4kWe/u2PlfB+Z5PvLFjHIpEyVR2JMbO0AAstlxNKDwZJwQ3Qs=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA1PR04MB8288.namprd04.prod.outlook.com (2603:10b6:806:1f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 11:13:34 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Mon, 14 Jul 2025
 11:13:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>, Bart Van Assche <bvanassche@acm.org>, Gulam Mohamed
	<gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests] loop/010: drain udev events after test
Thread-Topic: [PATCH blktests] loop/010: drain udev events after test
Thread-Index: AQHb9I09toVb8pO2h0OhtfsAK1jtU7QxM2sAgAAA4gCAAENEgA==
Date: Mon, 14 Jul 2025 11:13:34 +0000
Message-ID: <xzeoilk6746sjqejfzfbk4rue72jsunfga5te6ynipdgaks2u5@qkjsbwwworas>
References: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
 <auydt3njlbdh3ths3hzyiew46svwxxtd37dxzjbeyoqfk5n533@mpm2seuds26o>
 <ce654347-ec66-495d-a7e9-551bd6b4a002@flourine.local>
In-Reply-To: <ce654347-ec66-495d-a7e9-551bd6b4a002@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA1PR04MB8288:EE_
x-ms-office365-filtering-correlation-id: fc236e7d-9c50-4955-4006-08ddc2c77928
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y+RW0lCIBSgU4wue+j+n6OgpS2+Kr4cApy9ALSB2wIq0KugPKFaLwF0yjTnH?=
 =?us-ascii?Q?4PErweNx3R/hyW3F7XgQ0CugBDoUgc10hyqL5zsi/e73qzaFEYDrOoJtDSYK?=
 =?us-ascii?Q?rFQv85fuuKgmVHp+73gIJAk4s3PvDNLAYOQTcMNB85jNXvpECaPGF0NcDLls?=
 =?us-ascii?Q?0/lJ01aB2OXc+KdoN5erIIfqyJu1/aIByNYTKdYE9AK+VDMV0rCutUb70B5H?=
 =?us-ascii?Q?uwPzLRs4o7kaA9tGlhAOY5EthlUNuVRef/kxSz2g8GMOXQuhqwy/PU9vugUX?=
 =?us-ascii?Q?mjL52lqrb1s7jaPTHgQM4blYC9yHYNZgawcB5u0h8VTCO02uUXB92nwtjaSC?=
 =?us-ascii?Q?xeOtvhUgzprlXrPtHTN6IXfcWE0ta7lfSqNjMN9N57TL80Nw8KRyOvzd0AOv?=
 =?us-ascii?Q?k2hGHUDPamj5oDHw5i91Dc3JDedRZQS7Z1sa+TU/eoQiBS0rX0VyoYA2Z50e?=
 =?us-ascii?Q?sGhAGIIFTFhIl1DcAo1qvbVbgGakK0mou/dZj7+GL5S8ZkYag+aytsXeGvb+?=
 =?us-ascii?Q?0YJRx0Us8y7gQKm828JuRNVqm/lHTKcS+gzLgV0WSXVSUXhKHIF3PGvaVydz?=
 =?us-ascii?Q?mvhaDuiqxwAq/y43IteniKwNTC+/JKLVyt9+jOJM7TMrrc6pQhOYVSY/Vv7U?=
 =?us-ascii?Q?abNdctgLXBBX/vF3gpP0v68RTu5+ow4Uq+o+9i+ZcB6GhwlTxGuWUTDkPK3M?=
 =?us-ascii?Q?AwPWd26JJORddQmbNO8B4hrZT5dM+PYIDieRcSzxzyR1zb443TKFa2QHNvOs?=
 =?us-ascii?Q?ZPMHRmH34e5nTYdG46j6T84EjAgOx2aoca25n+xqfw5GQi+JMMbKIs1nnO0d?=
 =?us-ascii?Q?eD807HlOnrBa+/cvOZ+6UqKpPHGWAg1LYNqzAoBfBXjCHJ+MRRcouJlHdvJU?=
 =?us-ascii?Q?CAkDk93GKdOYv218JTiQffC2RjtmEvXG01BdyeVVfABWgnYcPiBGIoegJGqu?=
 =?us-ascii?Q?Q6+UrhtyMnwqKmSBHCgOL2VdiU4jZvgeb84p4tINWaFjAqSN6rN/1cMM8a2O?=
 =?us-ascii?Q?8EhhbkFJ2T+4alz3EK1aPP9Ah8NSi6AbvmkYESfZ7+CBK1FvEPggVwFymbr5?=
 =?us-ascii?Q?vf3WuLhNQibzXuB1sbWCNM//96y/wLgSPBK8ygbN8FUro+NqL64/Ptw3i3h4?=
 =?us-ascii?Q?sVFqsjF85OGyYJVouxJ1jJKJRmukXurEmGIgZLKUYE0Vb2ZNZY5cSsDiDiYc?=
 =?us-ascii?Q?oqorXWWcB9CeBfjMMAGZ5+OOrXb0MMGYWQGo9QfJ4slILTjz/c1GEx7n8NV/?=
 =?us-ascii?Q?crJTBGakzAycd334O4cgaKo6pjWQCeU81ybYZAkZOwnZjNw06K/sK87DkQTK?=
 =?us-ascii?Q?+QT+TMNFJu7TLVnPkRe5oVmK882lsH8KaTvb9r44jkRZOczQk5Sou6tWnGKk?=
 =?us-ascii?Q?PVffnnvgJfiqLf/XDmVwzlTfZfwgCLLV4gut9dVMAcuBqWBOBeXTobwRFWBY?=
 =?us-ascii?Q?tl5fIEDFsk9gCVbhNQDSR+9zumqEFDDe6Usd51rpYgNAoLU1nNg/Zfqeb2Ts?=
 =?us-ascii?Q?EWy3gH06OMwjPKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fz3sRyvV5XPoFt4M0yhFI9V/Jg0BQjX4LBmFXM3wMnji3tqC5ZMr7TKc9qYS?=
 =?us-ascii?Q?BGcifPFcw7GKfJtCXO5mv0Neea7orSF+oV51D/kCP7tP6nmMX03a/5KASLdu?=
 =?us-ascii?Q?hwGyd0EZ+cH7cFnrb56mZSdlncxxFMEfKMgQlUriSt28sLD6Qg+a5b67NL8B?=
 =?us-ascii?Q?TXufGfu0vWNAkdXQis9JphYSEMItjYBto1StCXEjcpruT6Ylo9McOMhqAe9E?=
 =?us-ascii?Q?AwWTqujuvlh4VmwiumRrmXTqQDqbkWavb0RT4Ggg/GXFmLG/iCtDx5cUiSZB?=
 =?us-ascii?Q?8ip5P3a4x6G6YA9gKEdslaH76DrKaNbMStaIMx9TwVJSPacvNNGH6aZArEc0?=
 =?us-ascii?Q?zYd0qKIhcemYZYZrsPRM9Ef/qfPnpo3qcXJ9kHzVgxF0jV7Ik78fsiyGrj+l?=
 =?us-ascii?Q?DAHSb5ERoZxTbK80t2HrjBA0419MpHWS7RLDjeVVJYx0LdkjRmVW1+/CpINx?=
 =?us-ascii?Q?hNRJbYpi+i9F5zWmLkLp3hjUtwUZBVRo5x3bFmKxb3j6UnVnxtyLxBW2MQQe?=
 =?us-ascii?Q?GDhD6y/MixMlpC1VHbB4/A9tSlE8/9+Wt6uld0a3qeDl/Bj/0Z2rxCYtLl8x?=
 =?us-ascii?Q?Q/EPTluxhjEFGU5106O8JUgViT7up8qU4gg/btUV7VG2jVT51hNIHP9dZRMO?=
 =?us-ascii?Q?pxW0OH6AzdS8BE2tvQ1T+OQ0mO8yfpZC2rIsBtKj8emPLlBxp8Ujp+ZxUJVi?=
 =?us-ascii?Q?clhvx6dlNu2dFW2wmU2fCnFxAg5P9P8OZ65HY6wbaZp8VtHTkRAuENP+m2Uj?=
 =?us-ascii?Q?/6SnbNtMb62hGVnKRIGYk4LyiYcOqpe7BHuydR3hf+38SA0its9CMpZLOSXO?=
 =?us-ascii?Q?1cnxlOxv3VP97VkCdZOF4MgXbvGQc5yhSvrYcbps704xOoC68XlpIXKT6rA1?=
 =?us-ascii?Q?15ijiZHyBKG0IDcsFCi0olGhA/mKu8CJV2GnZsFwdWwdZulfCzSm5xjx7IML?=
 =?us-ascii?Q?mVP2t4YpGrF3tRnBgf31380Ua/Sr+SyTGQFp+bFjA55ST0hHdlTeeu5FfI2A?=
 =?us-ascii?Q?r2SE0EW8Np/9xBBaT0274dO3pn/nEK9TV0wT4tK/5xegwxdOsgkcMQilGCXQ?=
 =?us-ascii?Q?WJ9jEyeMte9C3DgYlERlbxv+NnCRDFk52cNl5Wqar4oGWsQJj/DGCddbz0Cp?=
 =?us-ascii?Q?WOc9Y+cYInct9CkBEpGvSff+vzDqq7aG8vUDmZPFbFTquXilRQqNIbhQmSpc?=
 =?us-ascii?Q?9UNcHdF/kqGgMbzWLKYBjNGFm9zhskHVHA5LkBo3EyBA0/aBmVIKkhTeQ0lL?=
 =?us-ascii?Q?vTu8TdB1XSo2KjFRVP7q2AmI1zHVK16tzd9AksoRK6qEELQe262KF3xqoyUl?=
 =?us-ascii?Q?Bns4wMQS96LPGT7tEE49kfBTHCwt5ARZZ1d276IoS/aWXxN9ZIEch29Wu3mL?=
 =?us-ascii?Q?j18Kg1VsXaRkLHNuJ3lnPlmGk7f2PbVoDCisWz3xHQ2104oeToh9IBO62As1?=
 =?us-ascii?Q?4CA+qhJbZQxpaEUunwBBJIWeMVEgV4IA3Kdq43fAWMvQDLWKhkdcRGReVzQK?=
 =?us-ascii?Q?4KV3k+1F3bky5lkCi/Bb7e56pGoWFcBx//EqYbITYaH6RvFEKbwrs9yKRtRk?=
 =?us-ascii?Q?+gF9r/yEacgdGnUe41aDVB57fsDIgp8Oy39lbrReB7xBQIh75vnnIDldSjx9?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C432EAB18E2E1345B5C4C69444C4EB92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y9LHTsztrt4yK8+tvpruJj9bbY5dbI3HxHu7T/0dTvZNEN0gm5t0nf1gg4UCUH5PY/C0EnDFhdMF0A2MHA4icYduC/X/Sd6MCqFIMllSS3/R5DQvQucO23IdnAewE9Nl54jzw5Bw7EHcvDOTwZWieJWugkphP1F0VPDBtdMUBQgox7bKvGJkGEjDNZbBbGy0XlAZnLpp6yf2WaAZNzuaIYcqpw1pyVGwN1sH2642iKZe3I1BQcM6cMT/28E10NCn2tH7c2sky6+ZelomRM/jt500/n3hRF/II2KLEWSgvzlbfnOQkAktVkxzzKh1vaEatbWX7mbz7dBS0L2jrX3GPGIVZXuViiQdYYKKROdTReONajZLwPEC2t5sfh6NSiLjf+0OB337dEwp2By20d+q+MIkYpr6m7eD4lq1WE/T+g5RcWRF1X511hOY5dWiRV9uOvEpb58G5flP+i6J6w2lyIx2A8YKxTTe2mZPJg66mhmDAfGsZiZdVGjNL+zmRcDia5lrEGMCq88aZuR2lf4JzWv1rSW7kDdki+WCW6801gipNhIsuUn/DXfhaxjbj6Vo3YIvZdrASGE3MAKHn96xiu3w31mRyzRQGuKv9cu95IoUkxi8WmxddXR2MmzP8uFv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc236e7d-9c50-4955-4006-08ddc2c77928
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 11:13:34.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SzaoVvAqTvx3u1ykBNGC9trOiEbfKXHtopZSh/F9OF5DnNX6WsqC0FOVh03tKtE/r7CXygfYe5714WhALPvosEjZQEUBrx6Hzg2QiKbfl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8288

On Jul 14, 2025 / 09:12, Daniel Wagner wrote:
> On Mon, Jul 14, 2025 at 07:09:39AM +0000, Shinichiro Kawasaki wrote:
> > > --- a/tests/loop/010
> > > +++ b/tests/loop/010
> > > @@ -78,5 +78,12 @@ test() {
> > >  	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
> > >  		echo "Fail"
> > >  	fi
> > > +
> > > +	# The repeated loop device creation and deletions generated so many=
 udev
> > > +	# events. Drain the events to not influence following test cases.
> > > +	if systemctl is-active systemd-udevd.service >/dev/null; then
> > > +		systemctl restart systemd-udevd.service
> > > +	fi
>=20
> Maybe adding a warning if udev or a 'udevadm settle --timeout 900' would
> good when they system is not using systemd.

That sounds a good idea to make the test case more robust. I will add the
helper function below to the v2 patch.

_drain_udev_events() {
        if command -v systemctl &>/dev/null && grep --quiet systemd-udevd <=
 \
                                        <(systemctl list-unit-files); then
                systemctl restart systemd-udevd.serbice
        else
                udevadm settle --timeout=3D900
        fi
}=
