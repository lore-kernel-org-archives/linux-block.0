Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173E222566
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012961; cv=fail; b=a1CEdLkrmetVDaDEs64ZOuAdQ50bE+Oi44nTQC2KziLk8zMyk63SKmZBnOuHbxw+hyq+SvpGyyOv/0AacGYFlzSsY49aHMTYpmI8eEJmbetJLh/dX9UgALnYG8v1bJO25OFUUsIDFcDcRJeH4iZc2Wu1iWzALqV7y/3ZthCHPYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012961; c=relaxed/simple;
	bh=qfVVxK4ESFcL9B57DpwMJQQkOiCIdT65e5+j7nrf7Ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yw055lAqBj04RzoLRBAWB30OVA23G8OqHP5Dfoty9jBI5HSBs2cNNNBtH09RJG5H+p9EPc1q20Aj1Gau9UMzrgSwGHNXeK1kTl7/oOH452dHPwJ0rTVqTBQtrmypZh+FCyHtZFafmSqXFLhRbmujjNg03yOGUrqBEQAyLupj7cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dZfZKTiq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zgVnBZH/; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dZfZKTiq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zgVnBZH/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758012959; x=1789548959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qfVVxK4ESFcL9B57DpwMJQQkOiCIdT65e5+j7nrf7Ps=;
  b=dZfZKTiqkB9K3fRqbkp5F5NnuDUpkJS5tc8HtjtKllOLMnTRLDEdUoxV
   cXvCvJURwNOqUz7HQnXGJouQTXxhdzL5EvKWp6CIxtmZU2/Z2OXWKhpJy
   7cccPGYDl1/0OawVfyY2XvsiVy/fMKC1e1XO5ScuJwQNM4t20jLg73fWT
   2DlTDDTtqTnUzoE6YN/9Nw/6JDmJdta94F+uZ5zb6s5WzTM0hJnZmDJwe
   htaOuYDe6gj/qPMwm+UUmdX+wCKbFCesJUe0WBggWcPPDE20aBr8iSdd0
   nAj/R0DKuQIfXBYtW1ispppQVC8DLcQQvCeO2xqMMXQgL8JRzt69ioGgy
   w==;
X-CSE-ConnectionGUID: 0+xidAvcQPydIr73HYjNvQ==
X-CSE-MsgGUID: mtKSYOYQTK6B6MSG22vQ3A==
X-IronPort-AV: E=Sophos;i="6.18,268,1751212800"; 
   d="scan'208";a="122305122"
Received: from mail-westus3azon11010003.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.3])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2025 16:55:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUz/oeB2eSntBSFgRXlH9qufZ5jrh2OgUxjC6rcFhL8jrXkdAR3fNMDF36wbhlCm/jQUDgcQDnRRX/1T9qjXZlvp2i5KFCfTzQ2P6GRQ+rqih7YXoAE7v+nGPvaGIMSW3b1jO61cUNcNIBVPNI4n4CNleO+ULuv3w5QqHtJ3dFrYHo+FmfUGnpO5gvj/fLfbhz5KuSoz+rxLljiD7ntMLQmBGRV+/omYp8zvQLF8UFrrE7ptfGndl9Ja0ZM6Rvj7U9dvTG2yU3d10GlHoClW+txvMNsjaPvWY5+PeOrMLrVcayBuXuIcdKGe6bDp65Q2almOAvT8ZuaTa+OpZzwJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaHv5IC/9YISrmwuDhfR6tNkLIR/BTxEQ89ef560oDk=;
 b=PtXaUjKMxLDWYOjLc/DuyFIf1eLxSv81XtS8NIZ9fQ9SRp6hrILNODQWx2JzdEtq+13AqXbPHtkuaWsUpgsQmpgx3PRHgC9el9UQDzgKAWPYVojNK3GRnzfW7KlNmYk5OtQhhSJBtdbl9Zx+z1HN+4MI2d1SsRsArmAIiY1E1Ke10lzq2mXhG7MuwQt4DWTG1EXh1O7LYpvnqaV8E8oCv6wll6uJD7+NxkRAccI6L1OM5S1+fIimy1dyPdzd7gyWW+F4AMbtnsoQUE0kcEenJ2QU3kXw3OOdm5jbHKxGdAUF6qriw5tKUTiyHsd8WwLGo7ZEtit1GY89eX76wXp8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaHv5IC/9YISrmwuDhfR6tNkLIR/BTxEQ89ef560oDk=;
 b=zgVnBZH/eczTwjcpCsdMPSWglMl6be5tPYmei3GQrmouXgMt76axD0e8Nnds4qomwqs6UdLGYrJIqRCvCxqyATc68lYhlkshggnR1yWFCQK5lpqur4m6eK1wLE79XsJn5GG82ZUWi5lzh87UjlLUrH+CHENnrHtfOKnTB7kNApo=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB7114.namprd04.prod.outlook.com (2603:10b6:5:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:55:57 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 08:55:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
Thread-Topic: [PATCH blktests 0/7] Further stacked device atomic writes
 testing
Thread-Index: AQHcI8u2iSuhaaPAf0qUtMrB+Xji4LSVh9YA
Date: Tue, 16 Sep 2025 08:55:56 +0000
Message-ID: <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB7114:EE_
x-ms-office365-filtering-correlation-id: fd28848a-453d-424a-eb30-08ddf4fed9f5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EBfin1BizUjzdlcfs7WinvM+rpdFcL9Totc2tmoQcrFZJ8d54LE8M819Yp9y?=
 =?us-ascii?Q?oqtqUSn4HMMe08KSUwi3pVrV8v0BTlVrwAw7owwCz0PKLWhSh/Xvzl4UR3WZ?=
 =?us-ascii?Q?Q8ZQ6s9QX+bPTotbsjh9000IenCSQWluy6f5lOm+7e9KcqpWRiXRTXjUzrfd?=
 =?us-ascii?Q?HMK+0y3vciGBUpLTZ67cp4Q5gAzoyeWvoKhTJspqqfNbAxx4okewUm1BYahw?=
 =?us-ascii?Q?nDaQLHI9EMOtmjnqZL6Q8cEufZ5c6yHy7U6rxGd+2hbE1VBW+vhuPmwvz7SB?=
 =?us-ascii?Q?FBrLo5wO5P5u1L0inNN0ox8KtvE+DjLrYM4XJI/WUDe3PC5g9x5s0W4ATNS4?=
 =?us-ascii?Q?7MxlG9Pae4eXaTImwtaxqk3OVRLldIAYmN5L/i70yi4W6syWB3GE34Uca9Vx?=
 =?us-ascii?Q?aSeJ1yfyhsSNUcaK6fCKck7FaPxw5lFUZ1vvtrJq/LQmEPLKvbCWb0+EDlDq?=
 =?us-ascii?Q?TJG6vN0BDrQW1BcMag6xqea1kb9uoBZ3xJSXYn8YL/t0rIeFNn02wZHgAFq8?=
 =?us-ascii?Q?1sjAfJ38DVZ/BO8emljYMrPf1P7ALDQoKKxaoSbiwuTb6Vx5an1qRFsQeQJR?=
 =?us-ascii?Q?Q5A45ucXQQ0Rk5HcjYYwD66JEMnUyiRQnJa8zz0ykJktep0IRajOYDK7udv8?=
 =?us-ascii?Q?mkUk0jeAsce2e/2n7vcX9dy7Au6PujU/+qdrogSpCh+U6+gNVjtzRs64DcPx?=
 =?us-ascii?Q?Q2doEwsQspibzPMGy7jMr00BdbuFLtJce9QnNPvjDKdWBf4kKxLE3fyEdLni?=
 =?us-ascii?Q?1yQYMWn2n6yaezqSBerLNFVWuFIRCNbGjsFigMBQvWlXFNvTD0io3xj6qj/K?=
 =?us-ascii?Q?ky10JI8/x8Ay0lIk4MlmTiUkRj46mJM273+gc0rQCBtk0heglv4b61h79voZ?=
 =?us-ascii?Q?O8sQCcOwv/6PJVSbEhfFY4D87U9FUqtSjLICL2GA0/goFdSQ1woR8/tLsHiL?=
 =?us-ascii?Q?sOmEOXYG+SBnN9UJKZX/N7qmADZx0ehhWflSG8aP4MHTj84xgxki6lz9rT23?=
 =?us-ascii?Q?SekE9GfYl0IYLLNBo2vb3+IEIBA4jeiwPxNP+aQ5XlleoIEjkUz9Oa4JhWpD?=
 =?us-ascii?Q?e2H/HQ2g/AcwvMTxsJzCA6i8zR6H4BghRH8FhK5heOVqlYVQKx2aG/UJOV22?=
 =?us-ascii?Q?cBDKZEwk9kmsyUE7UwVb7q3aXWJdUB0ICTuC45qidlLv3wGUQf1qfKae3cxn?=
 =?us-ascii?Q?7tn7fY1e2nwgDY4QBLGbdHgJMUBiVZZsrCplKfDk6apSU+gKVZe0bALvUcG2?=
 =?us-ascii?Q?7CmghyHPj0N/fTtyuhzx4FJcqTEa59RWqo2pmrqpQPgiaUl4sqtklqAOADhw?=
 =?us-ascii?Q?dBeue6ir4G2zpoDVP/GLXPOyWP1rZVDc1KAKy/J3vd4E5aAmgnhRa64iqFUD?=
 =?us-ascii?Q?dSpr0asNFNFLo0nvLcF1531uoEktLjRBK+cnZs6V0PgiFvo8p288wWgBAhPy?=
 =?us-ascii?Q?g5LpbWU9ZKHPo9UR/zQg97K99GPouTFEYqOGA3hSiDiGN2/gfFskIHxn+KZf?=
 =?us-ascii?Q?47TPh586WQWNvVU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?82c7tXJpcBtuc25uHIvinhEI5d0XpKUE6dRNO+UPTuiDA9seGV6UvIx+PWZY?=
 =?us-ascii?Q?EE7PxqZGZxpowHJ/fgLXKOcOlZvuGovZ8QfsNZws5kmnWqqQAsuJN9wdGeeG?=
 =?us-ascii?Q?gZZVDRPpdWIBMatv9CWupgFsjjeBxn+kf00kHEGOelI4hIolJ9yzLyimfHRp?=
 =?us-ascii?Q?ibLTCgItZvZ+JMDyHDn/zgOOzYKHrF5PMrzx5bsHFZ77ZZUQy8cV1TKmlCXG?=
 =?us-ascii?Q?UyUBfG3pgmXx4Dd/9Ns5sSyw9aKqQShnmv+zUA+ND6vY8UCH4v/c4Dp8qEnk?=
 =?us-ascii?Q?hqyGZ/JG5//V18LqoQYvhcGOfTQtOLj8Eizv5XrieBG0AWXynvjB6Luc1PPN?=
 =?us-ascii?Q?izLsF973HM4xDmpQM+LUwwaN/YOiuiIrX1bQDL4iAjTPEZ3cQu3H9lwmjxkF?=
 =?us-ascii?Q?yOtYcgmv8dOQDJRb0QJ+4/dpEeQT1w8aZXxBLYNZrXYBMw44LYO+mqBe1C+f?=
 =?us-ascii?Q?lsHkPCXgejMqqEb82LflZYzIqDaxkt53zWkwnSw91JJM/5JmjYvL5zpcZPza?=
 =?us-ascii?Q?zln4oUdn1jAswDbMHG6rrBLLx+GTQ40dY8uWXTFyktAmqwlCoDgwMvopOfUN?=
 =?us-ascii?Q?oiFddDep6/d1/wA8Ai44uXzACaQ7R2nnXC4GKjjQmWGIGt5Fi8kEqzzSwkhs?=
 =?us-ascii?Q?gaiZDaqkjA2CLYQOZwvko63zpE3kxKGclBH6deL96jNFvC6oQYCdTpyRZEMd?=
 =?us-ascii?Q?kY3EYJrfqHFpe49/wIvnWkxYo7FVpKr7yKVxcbfrfb0dZK+gLGcJELT58rjL?=
 =?us-ascii?Q?dhjdutZDLaYCq2pX+DJA4ExYKQAgWY3xhiXx6VTG06Hxnm2wSZWe1dhR6FIh?=
 =?us-ascii?Q?azyO01Tl0YvPHeg1tpGHOYf7L+Rpj+sTwwP49Qb3xhaoCIRtkRGQHN6M6PLc?=
 =?us-ascii?Q?/ZjQadEyFWodC/I7cBI6b2FmoTsl32PodegBhWfNYgDC8bTHmAhAYmoyxe9A?=
 =?us-ascii?Q?P3LyWTr8uy+dPfAB8mDzQbuEbWptvgc0tqwMBWK9Vox8ISmVR12dcJqxSDv4?=
 =?us-ascii?Q?gC3MzZ1OkL8HDVpDVj+c1zgEQ/BrP95pYTLql+qKSBJa1Hjn14HDkye0ypeM?=
 =?us-ascii?Q?YK7DwhiBBAmk+kO2hNudqTbv3mEcjp9U/iVsH6lIWLZRTkePeVxp6jNRKk7z?=
 =?us-ascii?Q?ucQ3n3ubTb9bwPm8xEPxI0hWHfhOE2pHZTxURvMfKerzsCLypem6CWe61IAv?=
 =?us-ascii?Q?XVuAxNMJHWtBKig7DrWrBc2uVSW2WZwQmcCPiTPIbro7U+ZWGKhcpQfTT1RJ?=
 =?us-ascii?Q?deYNO9pQ8ABFOTHo4w/DS7w74pTP3pII5hFeU/TecwL3pbNErzG/IqWyZpyU?=
 =?us-ascii?Q?gFscTkNkHiIWP9HJOhtR0gm4A9OtrIbYUAKVKTeYjcgxUHNqPs4qobnYW9Su?=
 =?us-ascii?Q?6T5joR21gUvq9yQXacbgUpx9z9A7/Z2jVQtCbgpJ9LBeOgqv6w5RqKLxgaEN?=
 =?us-ascii?Q?ewwrLjTjs2EY6ZQiiFnv1ohgs8bf1YZWq6R6v/PsVbnb53chgDMQLvi0pbjn?=
 =?us-ascii?Q?g4gd9rLOzqChaXorFL1/4SNJXukSMrqw57guqtdfh+6siUNoQiWMaO8hLZ7y?=
 =?us-ascii?Q?a19qu7UOTAYrqUxqRJvgR1yF/zXEWnwtElEHUnWolNut7PDZ4jHqX7JehKNw?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BFF917151803542B769D55C3D63ECBC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l2FO3NgXcN7OOPt2FLmCTOYsxw8VQroJSSrUeMedVE/j3/ti6Fh888jUnN2k6ZU4xvFkX66fmEJCP8OvomteMvgKzG+b200XmaafyRywU6AGZEv3u2rUbZuUaEjJYaR0II6Q0cMi6p0k7jEzkUiw7RYA7fj1Ax3bqjlTy33ikMTSIH2IeCS7i3YUh3JnxRdW6wU4lV7BmTDCwdz5KXCBt/h/PCj/lBXyolQKkMdwebLG9chn6dWOrpEGUpEN4QnsPzWuQGgdspUioS9sDgGVsb8xyg0sCY+XWZzq0r+fhq6lkrFGgdsl6JCKokeTRx8JmIcedqVWj+Nd0YOGZOxn2sshymqvdm/NOvHPg0YyyV+d4EbrC2QSqPTgN8zEla01JorfFhT/5cejOWFuM9dLSyTalLw6V0n3c2xjfTtr+RHppQbAYoWL2Kw1KuPLZCAwxjcKFVTHoBFkvwGMIo6WJv1DYG3lWYGFmEHVS7IJ4M+xL5A9egIBSTjRnauZi1wXyIPc+aMu5pA1T0ak19gQ0W7nRe5wb05nj0bWjfSP636gJBfzpoq9meRhdYiw4xwcB9PoyVbmYabDU/RITblvUxVRYds6r6i3a4hSgpuzG4klldLx5y9n59VEN6O3X5h5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd28848a-453d-424a-eb30-08ddf4fed9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 08:55:57.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfJCwnlVHrXdx0s0bqC4TWry4VpKo5/MWUwKonAZLs8NovANZnfxPDT3FDE3HulHivT6hNtvPSO/C31Dqhv9vpux4rMuESVwE+KzTYYzg08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7114

On Sep 12, 2025 / 09:57, John Garry wrote:
> The testing of atomic writes support for stacked devices is limited.
>=20
> We only test scsi_debug and for a limited sets of personalities.
>=20
> Extend to test NVMe and also extend to the following stacked device
> personalities:
> - dm-linear
> - dm-stripe
> - dm-mirror
>=20
> Also add more strict atomic writes limits testing.
>=20
> John Garry (7):
>   common/rc: add _min()
>   md/rc: add _md_atomics_test
>   md/002: convert to use _md_atomics_test
>   md/003: add NVMe atomic write tests for stacked devices

Hello John, thanks for this series. Overall, this series looks valuable for=
 me
since it expands the test contents and target devices. Also it minimizes co=
de
duplication, which is good.


Having said that, I noticed a challenge in the series, especially in the 4t=
h
patch "md/003: add NVMe atomic write tests for stacked devices". This patch
introduces a new test case md/003 that uses four NVME devices. Actually, th=
is is
the very first test case which runs test for multiple devices that users de=
fine
in the TEST_DEVS variable.

Currently, blktests expects that each test case,

 a) implements test() which prepares test target device/s in it and test th=
e
    device/s, or,
 b) implements test_device() which tests single TEST_DEV taken from
    TEST_DEVS that the user prepared

The test case md/003 tests multiple devices. This is beyond the current blk=
tests
assumption. md/003 implements test(), and it refers to TEST_DEVS. It looks
working, but it breaks the expectation above. I concern this will confuse u=
sers.
For example, when user defines 4 NVME devices in TEST_DEVS, md/003 is run o=
nly
once, but other test cases are run 4 times. It also will confuse blktests t=
est
case developers, since it is not guided to refer to TEST_DEVS from test(): =
e.g.,
./new script. So I think a different approach is required to meet your goal=
.


I can think of two approaches. The first one is to follow the guide a) abov=
e.
Assuming nvme loop devices can be used for the atomic test, md/003 can prep=
are 4
nvme loop devices and use it for test. This meets the expectation. This als=
o
will allow to run the test case where NVME devices are not available.

  Q: Can we use nvme loop devices for the atomic test?

If nvme loop devices can not be used for the atomic test, or if you prefer =
to
run the test for the real NVME devices, I think it's the better to improve =
the
blktests framework to support using multiple devices for a single test case=
. I
think new variables and functions should be introduced to support it, to av=
oid
the confusions that I noted above. For example, the test case should implem=
ent
the test in test_device_array() instead of test(), and it should refer to
TEST_DEV_ARRAY that users define instead of TEST_DEVS.

Based on the second approach, I quickly prototyped the blktests change [1].=
 I
also modified md/003 to adapt to the change [2].

[1] https://github.com/kawasaki/blktests/commit/7db35a16d7410cae728da8d6b9b=
2483e33e9c99b
[2] https://github.com/kawasaki/blktests/commit/278e6c74deba68e3044abf0e6c3=
ec350c0bc4a40

Please let me know your thoughts on the two approaches.


P.S. I will have some more comments on the details of the series, but befor=
e
     making those comments, I would like to clarify how to resolve the chal=
lenge
     above.=
