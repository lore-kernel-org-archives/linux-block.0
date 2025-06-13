Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126261A29A
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819336; cv=fail; b=sCjl0DOuqbUEV++eEqiNQgCYMZtsmry16RBlqCgRWEnw12BkotUcuLvKMmkPOZMRkFLRESDlbMKXOWyT0TDYYqE6caMjRhrUlNcCAO/hP93TxrNcCz8ZLKsYj971HGUg13f98XyUjs1UFf6/VwQGkZndLfM8W7qT53r79FZi67w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819336; c=relaxed/simple;
	bh=Ri4i7CHzwA6oce/C1LgaB+xd25GNdtYn4E1HuCsmzSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btQlRA0enyPIpQAc+4GHewwrRF7wiUuqeL6xifklwx6YuG5RMQtE0p/cBap/OAPH485xlKAV4UG4GzdSCwjPA4sFWra34sGVWjJPyA7e7M3WDmgmCvUcTcBTXq0SwzDuz+u99uMDE2QjSO3wk3XSbpYqlyXK49D0VstsL/p5R9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GgXPNDyG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nAviOMTz; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GgXPNDyG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nAviOMTz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749819334; x=1781355334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ri4i7CHzwA6oce/C1LgaB+xd25GNdtYn4E1HuCsmzSo=;
  b=GgXPNDyGs7MtiuU5F5MbgZlpG2NWG6lWQ+pcVLO6h4mnhuS5pB7udPa8
   wabiWAiwC/raFsFRL9aJxhmsAjDY2eDCWfgZ2+2QGXUyxJEArRm+Y0aU3
   ejDoS1vNKcTVR3Tm6b0RXvgysbosdSxYa299HRd4h/mqlRzcad0iCXUln
   Jbqk4g2+9DmOGLxSar0aRwR+lbHhkFw2MMZWMLvg/daZhkkM8+dzmCDsc
   2gKcenZgtdXDyKuQhb8yhqyGBpNOsnfkkjnEZ/iP2xGsH0YcU2WTvBb6m
   PCox86YJxp7wqC77E/w2t0gBOKh7bhncCY1hU16w5+CvYth/UW4QO4di6
   Q==;
X-CSE-ConnectionGUID: Y59OCqSkT+OF8P302Ulf/Q==
X-CSE-MsgGUID: ejp6UJkNQC6Amr7qOuZZRg==
X-IronPort-AV: E=Sophos;i="6.16,233,1744041600"; 
   d="scan'208";a="84515392"
Received: from mail-westusazon11010065.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.65])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 20:55:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzhyyyUaUMu9PLd8qFCQYssL9YSVeuGUX03w2afYblJN1z33ZWNlg4P04mn/cO7a9L3XSUsczbIZm/fW/4vOhOhN6Fz2fqjjGZ7QeRC7iYyf2G5niEW1XXCplvzaet3fVKcQlFtlmNOcpkmOm44SOtgZspF17XCqeMU0UuuuLv3YbXvRHXg/w4BheKCekd5MzwBvAnUbZMYAEoDGIqgGEo8rqm1RNtJ9tBi23ZEm5+ZBWULMz61gV14izUxIM/J6pObBEqRCuqV48LjkjslOr+I5tg9n2Ds5O+K2L8FJv//gLwtjuEsW723JD1gmLFk/sk4WNdQsT7nh25hmQGlWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX7f5EEdD8SN5kGqXbkNeCXugPBGWXlViv8wG7iP5Qg=;
 b=jCm0iFq3vQVi5tJj8ZxXZ7uijBOOZ2gZS54xI7ZIRWEWSQ5POY8Lxn9jelKpxC6bCPEUEKogxTb63KvA+5db3HrM3JEu3KgtRcfbW31S6vkuIlx0Qmz0uxWYG7GzIcmx4dFNLpSEHXg2r7NzSoNdMmIP/QeA/Lx0v7eMVuY9r+P5dsrPW6ctpDuI061Dob6hqCnHmAuec5d0gt7jP9DhhYS/IWse4NUxL1eMEL4PXIg5BzOXLl69PqMK6kLmzYcTmXavZnxIcssqx+yC86MHVeReks4o5o0pSido2NRmzDElb3pfvEW/mbr7K977FrUBrgEaLe2aoZ4RTnSlx3afeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX7f5EEdD8SN5kGqXbkNeCXugPBGWXlViv8wG7iP5Qg=;
 b=nAviOMTz1ZwuHEB8MwkyaifWwTSoOEGm4qQzAkDw+9k+2ldX/VFK3gByfgFR9ATz0KVn65n70ILE07MTFzhsi9mTJRfX76lc5tTa3oBrLgZMkx2SCAVA8BeuQseBmtn08V2xWHtSIv+w6g/2eQs/MbkZr7jScUCUYVqQyuUO+/M=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6425.namprd04.prod.outlook.com (2603:10b6:5:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 12:55:31 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:55:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Topic: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Index:
 AQHb1pcB8XrHg5kcCUm1uP/dxccmtLP7HeuAgACNQ4CAAOYKAIAA5TmAgACtr4CAAOEOgIAAsu4AgAFfl4A=
Date: Fri, 13 Jun 2025 12:55:31 +0000
Message-ID: <5cndstsi4ah5ykocezjhl45wq4jx5iqpw776q45uxf2o3c67kx@xyz4zivxf772>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
 <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
 <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
 <3et7jqzna2n2e7henrbr2foiopjqxl64pqxaadszrbmmuqorei@xinbpunqb2ye>
 <b36df65a-1b59-4c03-8d6a-d0a90729ad7d@acm.org>
 <f7uik7sjmi4ta57auekhlzv56p3enab4mufidfd2mrk5zhpphc@tsvmhjkbiyvb>
 <1bec0b1f-704d-438f-8fa2-fb19738e3254@acm.org>
In-Reply-To: <1bec0b1f-704d-438f-8fa2-fb19738e3254@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6425:EE_
x-ms-office365-filtering-correlation-id: ce52749e-eca8-4a61-06bd-08ddaa799460
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+g8tdpWygFrNYJaz6D/GEvmsF3dYD+V69rHG0LUcE9eu+uNMNyCe8PCzSxcK?=
 =?us-ascii?Q?tUvPp7CAkPlBvbwMFYZ7FwfR3otCppecUxa+NDOlB7Pk3AN3T0UEHEanUoiS?=
 =?us-ascii?Q?I8GChKULXrph2bPVBmnEjI3aMz/21ctKOm+1NeejAeGgVCP+3ugkwWxP/gJs?=
 =?us-ascii?Q?Q4/ap7TQufVmOErbMYGf6b/Lq0xDEXGeozepJnAZKb9DNsR4SiewbgA8yH12?=
 =?us-ascii?Q?HV6h9b20xRDH76qvwsyK6hxGSWOYSzUwcPDk7DZkNlCNRC1yNxRXPFXQDQVx?=
 =?us-ascii?Q?irx3+XFmtPESUF2qtdKnZGw29qvPEKEiIpEH8CRh7Fl/IKN8kYbFD5Li60Af?=
 =?us-ascii?Q?flDADTCtb8Z38k+1j30yjIKo9JW0+LBoG4b+agiS/5v3a33mRyP5lg3JKzej?=
 =?us-ascii?Q?OKkaj3+c12HvhqMFP62PjGiPpIKfT8XFpvo6PScJ1xi6hA+N98oF6k/o7TS8?=
 =?us-ascii?Q?er1tmSSdJyMNZQVe80d2CRMYQjnSS+wWnjGq0BQoi60No7m1ZSN2GeF4Pyxe?=
 =?us-ascii?Q?p+rOYMkdSzSZDPPeS2RigD6AC0Q8phFs2ZTOzm2ShFClpOF/+NWmj8+VX+Rq?=
 =?us-ascii?Q?rWUA5epl363exxmbeER76S7EjScVSrS3GkOfDW0+ByhwMRIl3bVD2zsgD4KF?=
 =?us-ascii?Q?PplDAsl0Kms6wgM9ms1Zx41e9BeC84pSbg1xRDt90oj+rLvPfA6S1ySy2pfs?=
 =?us-ascii?Q?F/65OW9av4cji67didQHeCTSPUYjN7ejr1vwys1H5+k9vig6PcMAvDKrb9zC?=
 =?us-ascii?Q?4Q57AhwBAkcpzaNEbTXSYKSuTGVqDRImgdUOey/a7aUBIBygH0S0x9AKIpvC?=
 =?us-ascii?Q?xwhDUnqrTPYco3AVlS9mHk3e4ropdNbEWdLrprhgGv82AB/FNQXSY2WerQrl?=
 =?us-ascii?Q?7Wqp+dyA2+y1FROW7ECtHXZattGMHacSOF21poXxdlKQhSkMgL7g87jKRZDS?=
 =?us-ascii?Q?y/p7yb6YR93QzFBmbRtuhM75HkuTi3Yxbky2gAYeAHavS8tuN0pqE6sh1qHw?=
 =?us-ascii?Q?WDfMXkEJrMLq8/CM8ECoh+GhqaYSwoxKN4BIk3KeBfoi0XcMxj6YNAAR5BT5?=
 =?us-ascii?Q?x5rX8lD4InzJEVubUwD57uLTKHlj5qPkJHX3yyENOSclqfRaxEzZHUQAomO8?=
 =?us-ascii?Q?8D+tizZdKx+HxH7hzt52OtyXECxHIxzDYWx3VM8JKLdB23VdzVpGVdEcAHW1?=
 =?us-ascii?Q?PItie5Wi1PJ/b7XCjx3uSBmoRUWSsnQltmz4i7zdiQkPzXMMtkL8GM4jc+YS?=
 =?us-ascii?Q?Yxb9yrR104q/APctwxMR9kpDh48+0z+evZRA/d+S0vT5Ll0w65M+UN82iEhy?=
 =?us-ascii?Q?tX2ruKN/SSfWmr0hS9F0eCLz8N3alcxYpufaoFT+uQTG9wzp9g/2NoZnNlhE?=
 =?us-ascii?Q?CKvK/s0dDRsB7lshFIMj4Ha9Gbt592vWK5ElW+K5YmZQ20ZVBNv6usWc0B0s?=
 =?us-ascii?Q?DWSUvPd5VYhWFCh92GEuhX4RK2kLENY1eAefaXzMrYmYUZ/0Cclpv3JhT81B?=
 =?us-ascii?Q?s9ROFm9Zbm5SPW8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/HseA+I3AeCAFkI3XG3WrwcL2hKeonTZY7wfG3nRM/Lz1TkTD8tGL2IzcdeR?=
 =?us-ascii?Q?2h1owiCINmFsTPBuk6f1h6hfMXSZ9tx0PT55hbrFp9VY/g0zs3FYUuJvfc11?=
 =?us-ascii?Q?dfSsUZwTuOewCcwY0gPHuhhgg8J2Kj/Dlg3uB+qo/Cw/5g31vE8zOC6TzEKb?=
 =?us-ascii?Q?oKTgD/nwDz6z4dbwmmnY/g0kwDh0w0HDOgZr4xik0hiYdkvjVxZNIIgAMbWe?=
 =?us-ascii?Q?lp5WiW7TYYSD6KQMZ1rzvVvEuR8QJpMpZNfQme2AtDZdgzaQJ29Mj8Lozbm7?=
 =?us-ascii?Q?aXXPfzmaI7zt6HiQsiinCyjTzoP9pg7gwOCQ/xAiqSjdsx2px6a1EzoafoWq?=
 =?us-ascii?Q?AHEz7F6PkAU+kRNSCwrgOawtKkolQ21Q/2WWsAhhq+v++OzQoOKfcJ1avX9T?=
 =?us-ascii?Q?K3LicS6ppj5e60HgFB03ZRe0vEiwX2v1hxb8glvIw35koKa7+0TIW761Lbpa?=
 =?us-ascii?Q?Obm95ixpq/rL4llR12fbg9Rp290/hx8ihxNdn0ud+ykiuz91taN5kQAk0zvw?=
 =?us-ascii?Q?WOvSq5BinjrYwjF9L+FT3kpwU4FHCGypNNMz4u8cfY/BU4IcLgvYpXLh5lD8?=
 =?us-ascii?Q?vFWXLhD4rR1MappZ3d9cg0E5I7fQxKbQZ6iErW4j50WclzG3mWjofihKyaCF?=
 =?us-ascii?Q?HHoDv6/1sg25ZyIU3kVob8mRNdS1PUjUngLYuGKow+HBy7ELZ0v8PllNxpyb?=
 =?us-ascii?Q?FRGikp/mnUYGLB14xNPsb6MEa1rxipwa7XmzYsg+vtgs7+K2Ruixe8A/J13H?=
 =?us-ascii?Q?FLWLtBfA2dPkYHURMDjKIAJHYJG8aLsIWZSvGekiwxWpe4vSnpjzrhTTgUXe?=
 =?us-ascii?Q?BOcMl4ooaf7ysRwsZghdlXP5EaDwgCXrb/fhOAR192xIGiwpggvZ3nwByK4Q?=
 =?us-ascii?Q?CfxNM1CjBVB9RUEKw7xLjALaEkLYi7FwXUTZIUjhzaY5PmYDpSSMvKtw/pYn?=
 =?us-ascii?Q?zQCyCs7+sl9dnH4zjJOfGjaNyKVl8kucZNY713h4DKMQyIxu30v6dHFX7V3f?=
 =?us-ascii?Q?1VyBMhoUUvizbjL5hRrGH5lh1c7WC89hjkZDLHo20AShTDedoL3qBkmixOuI?=
 =?us-ascii?Q?87MGyK41y3JM+Nl1PggCyKEsi3WJ1pyFKNWJJzLcb9iUAR6fy9vrShFbHq5L?=
 =?us-ascii?Q?zcvGeBLd04odICpQNRGTP9m+64cwjFprQAor9+zRHdJyhekh/mQxI8LRJwkp?=
 =?us-ascii?Q?twSC1HAw5Q6Wc2zb5/AKmDdllDU1r+hXUi4hkqOBtcoSRuNLIjp0e4Qkax5V?=
 =?us-ascii?Q?WXc1k5fcfoFMh8Kr9YWAoX63SCEFUwBTQhFjIEtvo6uC9hwg9uYfpLcpY5HK?=
 =?us-ascii?Q?EAMhRtighQs+lzMISv/I8kc6kDav6sBKo2kuxZdH0dGWbK4RYAYXlziPbvER?=
 =?us-ascii?Q?I5bDkml6SgiOfhUtoThMkzkabr+XDwRUp8jn3wu4reicKuqWMxIIGD3ivJCG?=
 =?us-ascii?Q?vOXLm9+j0o8617uFJ6G0a/3WTqLCF8lENEKPwIgs+LrLcs0RidsNOmsEwOH7?=
 =?us-ascii?Q?Z9xOGtfPw4gWiSCO65T/J8cHOCDgswyhO4KkpgyiwqkqIs1XpeR61LJ6kza6?=
 =?us-ascii?Q?mAHmIEKreHIRZ544pCrG+UZdBcgQ2PbQNLN9LqDABkc/qsqeWwAkJlBqIsy4?=
 =?us-ascii?Q?BjFNRJcTWnhsj8a4vNIm6I0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65AEEE0301FE1343B9C863B9F339ED0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XxXIEPPTxbgQUS+T0NXZ4G2OwiHn/yvvfa2zgGJxUl1Kc5lCi9ZAFOyqGyHJ92O/XyGm4K3tOZ/BxkD5Rabwy9iD+vZPypvLxd2QnaF/+PnYTiuDLWzUC4Xc7L6gQulK1IWEWhDzFBD+iL8nkRJGNE6K0QFNfzqcAmFATwWh/seRII7cAr9hE6GUr9lI9jaDCA4zM7dqB7qyKQRjzj/DTMfEkJI0/GfsDwI06tnS1+onXShQXKhGluvfwHgOQw32dxbq6PHWW2PeUG8jF/4bYPGpHI6tqZPpcLdr4KLQXwvwZVJuYFud+ZUw8BnUJYfCGajKhY3Fzybxf7/921I/sdcmKAtGj/PmtPvJvOxTy4AyDewrY4rJJg3JLrCs8QBGINU2sEXRoGMJOry40+mya6UJ9EGqey1/6AUN/eUcwauADuPQDPZmJX4fsZpA+nNKwFNFGkN0jM2CozIb1hVRrw5Y3FFLOLD1KykaRBZlYSTsi/D2rFE4gqw3ufIvFNqaM8NN0b6Ht6LAebwzSx0WdvZ9YlYUDyG3WAk8Y7pqz6UgximJHGpOmDwHEHMuYtKEVlL5Ie8nztutR6VEr9qFyR71IM1Sb3Ot490tQlSlZVzqkRvj1HT9BFn/ZIuSOG9p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce52749e-eca8-4a61-06bd-08ddaa799460
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 12:55:31.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nk8a4UZoBrziHVRYOAdu4EF50kAGX1p/cXv1+nB7yYiC0ET9KohXG2KfI+P3+1TCMC+yYUBRGINXWR6eRejOhCy7U5Q2dH2yvRhgNnKvrFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6425

On Jun 12, 2025 / 08:57, Bart Van Assche wrote:
> On 6/11/25 10:16 PM, Shinichiro Kawasaki wrote:
> > I'm afraid, no. I'm thinking about this kind of test cases:
> >=20
> >   - it uses "set -e"
> >   - it does not use subshell
> >   - it has clean up code in test() or test_device()
> >     ('IOW, it does not register cleanup handler by _register_test_clean=
up())
> >=20
> > For such test cases, the clean up code in test() or test_device() can b=
e skipped
> > by error exit by "set -e" regardless of the "set +e" in _call_test().
>=20
> Let's rely on source code review to catch test scripts that use set -e
> without subshell.

I agree. I drop this 2nd patch.

As to the 1st patch, I would like to wait a few more days to see if anyone =
has
opinion on it.=
