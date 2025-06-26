Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB47E792
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750913120; cv=fail; b=cbLhDnZMIF/PQvtvqJNAAoQ0WPKOZuOStjZaPzRYpmkt6VbbT8CVHxZMYdEEH5nLZFC02pPP5IZIAhCh7/l+7MY40Wtx1FZ48PefOXk48tRdZzzndTBQptc8M7S3TEnbg2pyEnotccPzvCv6h1E54iW6o6f0XddbqB+1S6iJL0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750913120; c=relaxed/simple;
	bh=nQ8xC56sdh2yO3T17S84U7Jyz8vwbFJsahMt4cVjSCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSPo0FnarkVUMCTBBkIk4jS1zj6HK8m8V4IAa2VOiZhcNmt5kg/++LE8Gd4+/GWBIozI9V32Cz/r9VYtR3KhC2CzfrqINQA9uzcpfGgh9RqyhodvDiuHZeYwVm9q3tcqa0tvrnRvxSqsDa26o+ivWeTtCM3P59gQCN72Svu7BkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=moNADsig; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IvpsadHt; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="moNADsig";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IvpsadHt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750913118; x=1782449118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nQ8xC56sdh2yO3T17S84U7Jyz8vwbFJsahMt4cVjSCk=;
  b=moNADsigq1cA4eufTHAiUIUM1bRO5uArC+2zX4E4BobqX49vhuE+LXCn
   wR6HP1YTAUmSoWpztW6ON8Z8FqZTPnLVZcbApFrzJBMXw5lRTqkh90AE6
   uo2s9WnxxYGvImqBgWVO+BZBw4ZdUFvR6a7HplKQjsytYSPpBN4HkBWVl
   Bc1KtUTxZtOVvVAPUdMFr68O2DcjSHgxyhjv/FGPs2HGzBOl9e7Z4TjJo
   nqt/XmZw0JWtSs1Fg3zJOThE5qPoE1FLJSc3F0U4TLt7ULErltoi/ChHK
   ynAQMAxP6oAs3xIXzi+XbznydgH2qa8jALDvvTYbWbHyEHEJWie0dVHw3
   g==;
X-CSE-ConnectionGUID: g0MsiCJzQvWR3/5k+sO0DQ==
X-CSE-MsgGUID: YCV7Q/GUQkCnKNQBp1lBFw==
X-IronPort-AV: E=Sophos;i="6.16,266,1744041600"; 
   d="scan'208";a="86004061"
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.87])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2025 12:45:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReN405md06GhGa0Bvno5Xlp1P7ojwTz9UxR2DFi/OmGKMyUIOX0SleoLmKELF4csTg3g+N95BDTs+VjRlVYUGhGGDGHACR/gBqIJBodPujjeATuigokHWYWpUmxMb9Ugo3TzMQWC5ugepIVp0sWgn5szUDeQ5DZo4DAt/P8GpygMi9zn4tJH4VqBMl+8wUt7uRxdwpchsQ7k0Oj9gH8LmUMfEUEzKfZ+EUkXkTpPGUnZouOyVa1vMfNohFJYExIBNBZoIenTAzw4UPKmTvJ4gg6e/hHigtH2SuiaV86mY0zA1TI3b29BZPLac1gqAebvbtQwl5QOWERz552QXlm+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMZSwSwrBhPtvj+56u6nhC8pn1WTc3hi8+PiYXoeVcU=;
 b=cIeSYdHhHl2taEqIrp6cdmomtraFL+UgtVfyPA5U/+9IT7TbQrE+kCO4rNKyYjOJ8D5CCTUjZxMRc5nWtnzq7wsx7LApj1BVy51dy9OccTh1DJoG/ArsNxYzthMmR0yyxbihSio+M87DDLSAfJ/IzCu65Ge9cWki8637ZyjA7bdzL59tOp/oFCasRAzoUEua35HL4Sn4D5IEbSO+UqqpgQF3BtV8svbmFXPkWv6M8QB4VpwOe0a/PpW1AiGR3+GHWG8SaUibR5vWiEiFHCtwhgvYjDlXe8nMchZVcExIuJ+7GrfZIEP3UzL4vHSiqMoItIYi3AFA3UgJtUFtUxpfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMZSwSwrBhPtvj+56u6nhC8pn1WTc3hi8+PiYXoeVcU=;
 b=IvpsadHtajmr9BDcHH6YEIXIFSN6wZF7aM+kfKgUUwTeFuAlBXPc4MBCpatKrWq9XUFYUIFneLx1PEoFB3hiu7B39dOToI2qfj1PacCFsu0PpanIcjOZqknRu9QBb+4oFc3I3cQB2NKfiwSvpmdhdgwaWlNQBbR17g+AyhN6+eY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7718.namprd04.prod.outlook.com (2603:10b6:510:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 04:45:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 04:45:11 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Topic: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Index: AQHb03fJCWxsffIFEkOwzl+UxhDZyrPxRfWAgAFSe4CAAEUDgIANurYAgBRrGQA=
Date: Thu, 26 Jun 2025 04:45:11 +0000
Message-ID: <5zj7wkcqrqo5ug6omdzndydokkozoofe6px7cbvzjykzgkown6@tkjuemauvrlp>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
 <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
 <aEuviL5O2kD70Sij@fedora>
In-Reply-To: <aEuviL5O2kD70Sij@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7718:EE_
x-ms-office365-filtering-correlation-id: cac23846-c6c1-4998-6e57-08ddb46c3c4c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rxKGhKapwXuXPsbTJqhZHb9UR3MPcd/VstYP+87wdVkoDe71Y/8oUqBGDu?=
 =?iso-8859-1?Q?FAvqd5QphP4ND9IFPUkcnrOeOugfcfX1PG3Bna+Flgb41rXZq1BLpm+G9m?=
 =?iso-8859-1?Q?16oka43f4OAed4+gtP1DXEA/xlxlvGB7A6fndrr9en4HNIyJhKfpUALBF5?=
 =?iso-8859-1?Q?SlKsGRR9lBl6Yh4lScBRsuw16c9tpvxn5Qso7GFJGCtRao0gPmKcnJNzjF?=
 =?iso-8859-1?Q?7Zg1Rj642IQmEe3uFou0bc7FvddVid16N90gYkcLJfu+MW3JZp2x1pDxg9?=
 =?iso-8859-1?Q?DfJQE2Wmdnpo9TnCyJTnQqFUNC5CQf/p6MIAthi8HfuAWTgOdcFV4mix5l?=
 =?iso-8859-1?Q?qHvbuxD1gATA2RqY5K2wmxoK8mi4h8A8B0Y5kM5cX3NIEOADmPWXWx3BQO?=
 =?iso-8859-1?Q?Ib1jPLEeY5DH0AblSqVksULFXhE2CTG7erfLxP1VnJgtc2Z0jc14KDDhuM?=
 =?iso-8859-1?Q?hsMhjyzahD8IRvKvcwPvNyFUTeioFMLuKTiXrdWIcQmihNav8O3UG3k8Cs?=
 =?iso-8859-1?Q?TWWkjHhw1XZh4iMm/tow80JNoTzuIs3gxpUbCbtSuNKN4nmiNOujKhev3K?=
 =?iso-8859-1?Q?m0QhVHnVWAWmJoaxILqu7mpmlVsfWyELki3/ib6sTIdI/PzJ12YLXvbYpq?=
 =?iso-8859-1?Q?vh9sOhTdpvtp0NPsog62BHBUgF40iE5x97uA0ClsWWeLpyudle0ImQriiX?=
 =?iso-8859-1?Q?vGHETN75VK1v9mGK4HyyDPsewIVkNrbxzMXIUsDC+GG1fPf0xnPKlrn2yS?=
 =?iso-8859-1?Q?QOLLGLkf9SW/A2TbsBxFE8Uyn6VuR5LVH/QtRzVTXkg2ZCwRtc/OjGx6gY?=
 =?iso-8859-1?Q?rVLWzK2l1Gq66d3oTxE9x/PunJ3+RcLxHoxotLWPEKjb/Aa8yeHex081Jq?=
 =?iso-8859-1?Q?vrmTIkWWD5AokuUbyjmPw91RWd8CqqkZz0hhldyh+iNkZ9FeRiafRqWttE?=
 =?iso-8859-1?Q?knO/MeOcEqUyTf6fR0WRXCiq1iwxAfWp/3C0YtqOghkOySU3d/u0J/CB9R?=
 =?iso-8859-1?Q?NILKxlkS6lKQLYSiazLUOIez2/kSV69ZH3tVKEYr3EBK3Q8gx8k4DVi6wd?=
 =?iso-8859-1?Q?paZvQl8qZKQ5ilZWrlJIFPRiH5Exyun16H0kCWNa8ycvfQ/4yCjNPAawbg?=
 =?iso-8859-1?Q?j2mQ7s0BGjZF4firFjD6KbHBs8GqF7gyZaANq8+1z7NSKV159JiqXonNSs?=
 =?iso-8859-1?Q?E9aDqxZXfszoVFbnwBJ6+AefO71eqDqSNlih7XeuB6XoYCdChJaBQcsgEP?=
 =?iso-8859-1?Q?CPytPsdpYIykMNlPSTZ6niKSTzx0QGlcTLZYMMV80DUskIB5earDMsb+XH?=
 =?iso-8859-1?Q?hqXXaXWtVeaMoV6K6XZmTbeYDgpVSiLawddlCuuCkk7BIb+aNHzR4Q6NGg?=
 =?iso-8859-1?Q?V6GUNbPnzp8Ash4R/ywXYHx8GJ4VYB2Avl7IsuANsi0W3YlUVpiwROogFL?=
 =?iso-8859-1?Q?bN2nw8YAlpUMOKfwYFULDUew4Isd8NgdViCvQk7Ah1XVI5felzaEBBMZpl?=
 =?iso-8859-1?Q?curuLIHx+YWT8vR7Vv6jcPy8UT/EptVPNRxpWpxu+SMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8FOntY7PCaMI6L79zot6bx5MTjCdNrL0kgXFN7Dbe6arf154QXEwK2ztpA?=
 =?iso-8859-1?Q?8bsJGaLakGLVsk242Dyb0NtRP7sPefdd+1exiLpD0GDZNdBZGBwjwYWyP5?=
 =?iso-8859-1?Q?GBalPGeFA/kLm0hoDF7OfILPn/QUIke2lr2XzUJDBhhU+pWF3Ye1pbvw7E?=
 =?iso-8859-1?Q?YofadQZo91XIuZV2AfAW/bDPQJLn42bbg1LNLaqUGRfSMBWJds+K7XkQ57?=
 =?iso-8859-1?Q?4j001Y2PU3M8rsmRdf8qO2dcGVI7jkUHeMFiO1QQvytqO7voYOGCTGys+A?=
 =?iso-8859-1?Q?JbjG+z6li0/VU/td2JntA9teL9o6KaSN9JLPBQJm5AMabLHbDEXU9B+Zfw?=
 =?iso-8859-1?Q?HwsrLPjWkK9I6jWPLobt00ScPuZizIf6GiseSGimEJJRySN1BvGSNDS4+T?=
 =?iso-8859-1?Q?SCtlYUbxNz8qOo2RBv8oElG6u6lrMEBbfp7wkip1gOikmHtFy7kaNbZnpp?=
 =?iso-8859-1?Q?mG6Id4Q4qvKs0ahBC1rAHrPFfXZzboQgdzOQEyr1LXmtMt4nrNrI9JvStH?=
 =?iso-8859-1?Q?PdPgR2crn/w6vJkGZZ/PaEAyrNMayztiN9kEAemRuSnW0khDNEPxlcUYW5?=
 =?iso-8859-1?Q?tZvyWQ58XeKIE/bmNWEYLfGxmDFJfMzuvMjN39d7Bt2YbMERpxMMaZWe5k?=
 =?iso-8859-1?Q?JwJ38cnXGmUosqpFvU9DKdqyIPMUfNHjFF/PPXg8m4VJ1BAkaCO71sOzsa?=
 =?iso-8859-1?Q?e1Mhhtb4o2Ov3bDOIYrRlhdfYOmKcec1rv9MGzR/Ou1tgjODmYUYLqYzTz?=
 =?iso-8859-1?Q?Hw80gqUHuZXtjUEOj49bSJNEN0E29IKKZ2cNO9lHBtkp+qJoiqvJ+aHAer?=
 =?iso-8859-1?Q?Rz9CTh+SA369G2PC8BTO94FxOOfkBC5qcrpfxAJjNcMFRcdHnPxMp7fHtS?=
 =?iso-8859-1?Q?QuYoXF/dTZzRc/16sh7U94rVzGytMroqE776EjO21tvIjR4Zqw+58wf8Av?=
 =?iso-8859-1?Q?CeF+IiBhBk4MkIOo7NYWfaHQaIIu0AUAdOI7fEAFfYssTjSpO4AX2d8nOy?=
 =?iso-8859-1?Q?ThzeGkp08WdxFiZm/zG+5cHr4urSVNcCLXpO+vT6/mPwv6lHNDR+xftNP5?=
 =?iso-8859-1?Q?vhIGMKEJiBBZIrDvfdsOlRrPwhK0jHN+SJm/26kpPgMpolILMvMa7qS1dD?=
 =?iso-8859-1?Q?yXYgHkDrVTZVVkGJvkTS5aUYZqHZAMQNh/T/EcXPbIYzy2fL+vEeYY+Rz+?=
 =?iso-8859-1?Q?lKn3eXLFPEpoSWU9IlNYpN+dG7e0RmeXSzImNH4b7VDEFbVL8y8gp1iwF9?=
 =?iso-8859-1?Q?PBQDC7jCP0tTp2laJ+QWzkcDvywbny2qGCp4Icrun9ofDaWC/65JnW1z/1?=
 =?iso-8859-1?Q?sYKo4Ha+Pj1KQ+0wtuyw0DJNYC+Vx8e4LD27vKXUa+IbWpJwfmsH6tps5e?=
 =?iso-8859-1?Q?fN0r7BZs5LHdKTX+67xEplNorEPudnu4AfcGCoO7IWPCqWtNex62qfrrJm?=
 =?iso-8859-1?Q?gZE0XVOkIlXcQZfoJ2ht7lxKpB3OLdTbsIr1JsCwvJ200DK3Yn3eQVdQke?=
 =?iso-8859-1?Q?TuziAPp7QcDUxU0vsD4bIGC/GGfCLAQMMSWQ5mE7gmm+098qKCvgA/TdKx?=
 =?iso-8859-1?Q?gWRnh+4sJF1DfHBn8o+hkyrtUKkimWQ+4KykDLfvPpR1hpyzLhHkG9LvVZ?=
 =?iso-8859-1?Q?e2IG1Uqt1xZDpd2KGVdkofSGHJq7iGAULUqQBFbIYBEQfhRR+9EgNPb+c5?=
 =?iso-8859-1?Q?Qk+Lz/BIgFDY7pXOI88=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D7BBF25B9857FE4C8F5B95EE55C9BC12@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ropIxJ3CXgFwLsYkMmVYluJKwL6WT0v/Q5vK6YjVjq/Wx9/0cxr9PcB0PoHdNMdQq7JTvGjAC1+euAbwGvWHBW2qm0FxUj2tjlf2aGEk9vGv/djUFQv9zu21d0HNqF0lQhv3MFcg44kwun7EF7CaYzPBr+bVubM/jPNj5QwsZoQ+xIbZbztTC3/kIRb0Ttsv+fWo3gvk1ArxgSIUBIeub1dj/3uM63oDZ6jLFV7A4K8E91eUWud099uSxOvMBbng/JC5632txyUwEd3fkp+rjx0505RrTkVCsAoAnKe/rxTn7khZzK4/UBUea0gzN+ASr4So6DXZxvyXyzThbvk2UYwqWigsOuHnq1gwckzIC263yaaP6DQW546r0ACgzF2pqy94B8HFtyiMFWZXH0nkz0rXWb2DKSH/PLSM7wP/k35pA9ZSWcVlcWQdRI8xqkBOLdqtyjl/S/YqYb0iKPQpAp6QThgJe+27r4bPmW4ifkt+UOQ9u7ddaNJfJ0UeOeef059JzrqUVTrxrk9/SyPHy3dy1Na+FQjulgPBRVY9zV/VBIJdAX/AgDTqOou3FQDw8HDMaIbSMLt3H9Musrdp3gWQX5GJXrOgT6WVjcrp33+LPSNGZZbwGwnrLcgEXiDb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac23846-c6c1-4998-6e57-08ddb46c3c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 04:45:11.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZOS2jyIRmwnJN6LJNwQMy0/jCkctWBh3ZhgQ+4SzTB7R7WhpnkQxHeGEFvF/1k8ofSgELHvxAyIqxcPCIxjtCO22x5yd35SuPNhOx1zdQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7718

On Jun 13, 2025 / 12:56, Ming Lei wrote:
> On Wed, Jun 04, 2025 at 11:17:05AM +0000, Shinichiro Kawasaki wrote:
> > Cc+: Ming,
> >=20
> > Hi Sagi, thanks for the background explanation and the suggestion.
> >=20
> > On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
> > ...
> > > > This is a problem. We are flushing a work that is IO bound, which c=
an
> > > > take a long time to complete.
> > > > Up until now, we have deliberately avoided introducing dependency
> > > > between reset forward progress
> > > > and scan work IO to completely finish.
> > > >=20
> > > > I would like to keep it this way.
> > > >=20
> > > > BTW, this is not TCP specific.
> >=20
> > I see. The blktests test case nvme/063 is dedicated to tcp transport, s=
o that's
> > why it was reported for the TCP transport.
> >=20
> > >=20
> > > blk_mq_unquiesce_queue is still very much safe to call as many times =
as we
> > > want.
> > > The only thing that comes in the way is this pesky WARN. How about we=
 make
> > > it go away and have
> > > a debug print instead?
> > >=20
> > > My preference would be to allow nvme to unquiesce queues that were no=
t
> > > previously quiesced (just
> > > like it historically was) instead of having to block a controller res=
et
> > > until the scan_work is completed (which
> > > is admin I/O dependent, and may get stuck until admin timeout, which =
can be
> > > changed by the user for 60
> > > minutes or something arbitrarily long btw).
> > >=20
> > > How about something like this patch instead:
> > > --
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index c2697db59109..74f3ad16e812 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue=
 *q)
> > > =A0=A0=A0=A0=A0=A0=A0 bool run_queue =3D false;
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 spin_lock_irqsave(&q->queue_lock, flags);
> > > -=A0=A0=A0=A0=A0=A0 if (WARN_ON_ONCE(q->quiesce_depth <=3D 0)) {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ;
> > > +=A0=A0=A0=A0=A0=A0 if (q->quiesce_depth <=3D 0) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_DEBUG
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=
dev %s: unquiescing a non-quiesced queue,
> > > expected?\n",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q=
->disk ? q->disk->disk_name : "?", );
> > > =A0=A0=A0=A0=A0=A0=A0 } else if (!--q->quiesce_depth) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_queue_flag_clear(QU=
EUE_FLAG_QUIESCED, q);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 run_queue =3D true;
> > > --
> >=20
> > The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
> > concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
> > ask your comment on the suggestion by Sagi?
>=20
> I think it is bad to use one standard block layer API in this unbalanced =
way,
> that is why WARN_ON_ONCE() is added. We shouldn't encourage driver to use
> APIs in this way.
>=20
> Question is why nvme have to unquiesce one non-quiesced queue?

Ming, thanks for the comment. I think the call trace in the commit message =
of my
patch will answer your question. blk_mq_add_queue_tag_set() is called betwe=
en
blk_mq_quiesce_tagset() and blk_mq_unquiesce_tagset() calls. Let me show th=
e
call trace again, as below.

Anyway, the WARN disappeared with v6.16-rc1 kernel, so this problem does no=
t
have high priority at this moment from my point of view.


Reset work                     Scan work
------------------------------------------------------------------------
nvme_reset_ctrl_work()
 nvme_tcp_teardown_ctrl()
  nvme_tcp_teardown_io_queues()
   nvme_quiesce_io_queues()
    blk_mq_quiesce_tagset()
     list_for_each_entry()                                 .. N queues
      blk_mq_quiesce_queue()
                               nvme_scan_work()
                                nvme_scan_ns_*()
                                 nvme_scan_ns()
                                  nvme_alloc_ns()
                                   blk_mq_alloc_disk()
                                    __blk_mq_alloc_disk()
                                     blk_mq_alloc_queue()
                                      blk_mq_init_allocate_queue()
                                       blk_mq_add_queue_tag_set()
                                        list_add_tail()    .. N+1 queues
 nvme_tcp_setup_ctrl()
  nvme_start_ctrl()
   nvme_unquiesce_io_queues()
    blk_mq_unquiesce_tagset()
     list_for_each_entry()                                 .. N+1 queues
      blk_mq_unquiesce_queue()
       WARN_ON_ONCE(q->quiesce_depth <=3D 0)=
