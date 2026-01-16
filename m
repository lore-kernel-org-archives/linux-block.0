Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B721576E
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568675; cv=fail; b=rmNTQGvjhsTJfBX1xsjcAYJQ7tlIOPBwvDpe78arFtjApUEgMAuw8XvilLQbTzMXgY9s5y7GUm29Wwmb5fbULODCmDf8txvy16liAOUn5/seRDep72t81xEgpcbv6kvNxpcjKdRil1YM4m55qz3zWC0Y5fLRfxwkida+z7oKQfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568675; c=relaxed/simple;
	bh=2rj11n2NyQMUMA9y/R3TYsobM6bw/Mm4eVPPpNbHK/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UnpDJfnA5nNB1iQ6nFwxUcS9VdJJWKGmKxVOeaL8nYjrKOHBG+qfU3FmAsA8snTEaRiay0xX2+ccohiytxGsGd76+QwilIDbwg1dXmqkWS6nvgJwZshIiA+UCxq5LhUnScdb+Kqa6ieR7Mj9hpQ2rMwiP4IXd29kyNazEkEU2zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Dr2w/Xa+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kH3z3bjW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dr2w/Xa+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kH3z3bjW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768568674; x=1800104674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2rj11n2NyQMUMA9y/R3TYsobM6bw/Mm4eVPPpNbHK/o=;
  b=Dr2w/Xa+nD0vCIKn9PqU5JHZwkuG/zLYdBU/mHaGpsQjiO6RV6g27Gss
   X+P2mWJWLPqkAq4PX/qLG0+wai2ekw7q3lrW6oyLTOhG1RKuV72dqodPk
   BeCNsqQF0TOhu5G776j3U2Dpq7V8Y3j8QioL57Sq67AW7cglMThRHmVfh
   QkiusY7nZ8zCb1TcznPBXRWS1k03/ua3YviXmkvyysW1UFh7A6q3pPr+X
   IsaUhr1p/evJB2QZtw3phO+6DN7YKADwkiO4ydMFbArp4oG0DOxEfR+Xn
   b+eDKuo8NQNChbWv9lblNE4F6FErsl3PGgMLOWKeroLNuX2iW/8H9aSYT
   g==;
X-CSE-ConnectionGUID: 26ZL+zGqQ1eKZem0qbMDbA==
X-CSE-MsgGUID: 0erMoJ43S1iByAuIVnuZYA==
X-IronPort-AV: E=Sophos;i="6.21,231,1763395200"; 
   d="scan'208";a="140107412"
Received: from mail-eastusazon11011050.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 21:04:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV5a3STOxuI5e7hHf9PeUZUdZ2Vms1FK37qheG5fa5dhwoiGLFuGQOpx6ju+u15oEiwDxeYdqDso4XZA8P/C/NKDo04r82aQFzJC/6Vpgozt1/0cshiN6w9mMkQvOVj7d47LGNPZ4J+1OAa8/G0geWpcVgrlqX9PdtYyeIScKEdeS5YD2HlTB9M9yi2Of9RXda27PZNmprYM+dz8TYYz3Ymkuc+8aTZSVdhY87idMKMaqc4BupWnLE/VhT85ZRN7u5e0CrAlqg4giJ6x4PAS2qqcAbjzT7yHXJi4wF0UKzorccLDBN6iw7QZ6MerwcCGARmqWB9RoO2aI8q8zIZHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+Ev3G+IG0Xnk8woVKyrOxJRS90SD1dG5j+Z+zJakmQ=;
 b=b3jHUQh69MSEZJusQzBw0n0X+zO3C6cSVxDb3fBorMK4FoDjjKFM7xEGmibO5Qc6Dp0pX1OJkkt3Fu877AAiNAu0spNpE6qtpl4KBbNBjx8gPykndq3AWacInylT6kIuXkKlp+bJgoPLIPc59hmOcciVvawhGu7LqJ5ThErVVvzMsl5HyNpIgLNsqjdow+CtJ+0/Mk6xvLWl8fxZkG8V4QYSt3tAvtfctp7MovuLA5NLk9sFVarCbTrSf00IeoRBPDhIyEEE4DyI06bgHQjvB1uf5CHYOMOifEQQghnGqDVBFu1lHS9fUtAcVMBe1GuLV50AfaTdGHYopzopkbhBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Ev3G+IG0Xnk8woVKyrOxJRS90SD1dG5j+Z+zJakmQ=;
 b=kH3z3bjW/4JhVMhMWjzsfpTPdVdV1A+mswV60oS1ZVQ6RwqwzMqG5qvx5BAqzyNGHhoVIPCgt78YmMBd9VRG09VVRgksuWn5CXAsbMamWZH7zG2YCCaS23KcJWs8bXeBUb4CdQ4pSyOaLELpPL5Y0qq6cyQmk2jxi2ZJx630cgw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA3PR04MB9160.namprd04.prod.outlook.com (2603:10b6:208:518::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 13:04:29 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 13:04:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Pittman <jpittman@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] common/rc: support multiple arguments for
 _require_test_dev_sysfs()
Thread-Topic: [PATCH blktests 1/2] common/rc: support multiple arguments for
 _require_test_dev_sysfs()
Thread-Index: AQHchZnsAcmrLYjZ6EG5ZEz9oHpE8LVUxhWA
Date: Fri, 16 Jan 2026 13:04:28 +0000
Message-ID: <aWo3H2Lb2E8K4pIY@shinmob>
References: <20260114210809.2195262-1-jpittman@redhat.com>
 <20260114210809.2195262-2-jpittman@redhat.com>
In-Reply-To: <20260114210809.2195262-2-jpittman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA3PR04MB9160:EE_
x-ms-office365-filtering-correlation-id: 1a27a387-3da7-4cff-edba-08de54ffc837
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bkSfoLOF44BR2SSWTlfKCmmwhz0ZOjHnet+Vu7dZpzI4pelVBs+EqRiPho6U?=
 =?us-ascii?Q?cmelOOTlSIUSCTTkGF85kA5Tct4rWTNXV6sECXaabffMseeUZ4gxeMPUPxxd?=
 =?us-ascii?Q?4X9aBRoQfQpJzf666yDR+U76XFkVEZqSm+uZVrjh9WxmFb7pcT8+Unu0Zpc5?=
 =?us-ascii?Q?x6P5NlpjrpWHUCrGE7EkzyqC43rAtjsSxMjifg8LeCG7i91QBB7SMbIGsgf6?=
 =?us-ascii?Q?L0qA0C1rFwo16P5zwx1HUwAleCvhEps0QZ4Zdkpkb9GLuR0jzYm8qN55qKnv?=
 =?us-ascii?Q?3GEVmEvwmZjnMID9H96MGu/sZpuvcg70P7eEw61emmBaWy+ELrnSR/v+AaaU?=
 =?us-ascii?Q?qBodAwMwHiAPFVJAW+mXCiZmut4ZA1R0xYnRoD2fQlxg2jkiwWhvhAk3zfv9?=
 =?us-ascii?Q?hc0uenpFeV83aWQPv3nSb2Cz13/go2nc6WDPMpDx55JZRNGaTs35ot7GR8ih?=
 =?us-ascii?Q?qKMMtpgaexdCdg1S6z2ZMeJykjl2AsyhzDtEWXEqYyoR4kAcLu9FhwoNXLXu?=
 =?us-ascii?Q?jPKz2oLNVo+rnNqt7+Vpa1kYODNfpLtyT9daHT+Bx+KDx3MRUcluFdsq1inj?=
 =?us-ascii?Q?cC06ZZjIFVcQ9SLEajEZeRxp2fym4GUhWxBDbQj8GLqNFqu/bEGMq6oDoJOi?=
 =?us-ascii?Q?l3uFP5rt0GFGHQaXyntMq7ticH2zlngII/SojhSj9IUT+kSgJTCnVWOIdQA8?=
 =?us-ascii?Q?E6YSiGrbVKyZFVxz+FIf0enmBR/0Yc1W0URrysQaJDx9Tx/V2wsbqb208N4a?=
 =?us-ascii?Q?YE0TYdvMhJhH77GhJNlM5lbAi2VLNnbW+PKuNecK8A7d1+SKtBg8ZzUNf2le?=
 =?us-ascii?Q?2lzh7Ig38lXaBLHj5Bq8ZtaWLFhBGeyVlsvDLBwRHNcnvSOGa5oAcy1WfMtG?=
 =?us-ascii?Q?eJ/0UJ8CHDp/DcdZSv1fvFmjCDiwdBJDuglWUJN+lFxU4jEM0FxtKvRXmMrs?=
 =?us-ascii?Q?rgLymQql8BuapI1r82EdsqePG2CdGf23lGqO/9hQsFgIwCXE3eZclksl8o6D?=
 =?us-ascii?Q?i/MFnTs+Hi2Tf0/7gJliqk17ftyZl3GYMF6MwcrFQ6pxB0Lq6kKNfs5d1fco?=
 =?us-ascii?Q?Rpb2NXoEQuYI1vVZuciMROPwy9iYmBZpncfg46uF49lHpoKAkUHCcdL5+UAg?=
 =?us-ascii?Q?FlFkErbB9ejdTl4A5xRcgbIXGOwAgAeOrbGviMt1FJ/5lSWRJS52xzKdTOSZ?=
 =?us-ascii?Q?9VQTuXr6VDRHWUkWH2AF8yC198K5e2VwhqAyCSPB+4TwOBenEktVkHN8wW5Y?=
 =?us-ascii?Q?bNuY9ToFFFoXTxydVAkg/WkD9Cw1ICRprawPWHrHdMK6d3kCXDXppEZa+vUh?=
 =?us-ascii?Q?fJyk1Y4WJHdsf06Q2RHefdLJbJxRWlIbCsXvTVjfQ7i64v4HLspj4hGxyeyZ?=
 =?us-ascii?Q?LXrwoAy6O9zwYPnApHxH9777+Uz7yutblvfOoOCgC1C/7bX5Mmmc6mTpRlTo?=
 =?us-ascii?Q?RfK9g6th1KrVJ4oRStntLzHQ11ymPfOmr1znW9KQ7eXxz2y9G2RxUXVR1gW8?=
 =?us-ascii?Q?mpHKdzYuWM0HDccyC2cxC9MMwrBDurdkZCOveS1DS426s9IL+gS9ve8/erTt?=
 =?us-ascii?Q?yEO5CjGGEtTQTohf4CRR+8ldXItFjyQRu7rYbGOdtcQBLXsZO1uFANxqS6Hr?=
 =?us-ascii?Q?DhC9rA1HGLrWAjUWgnZGWfk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ne83DXIgBR18q2MEA2S1D0TsxlwqibFyyVYwiBTB+JKEyWMgnvzzK6AzTq0G?=
 =?us-ascii?Q?BYc39MsN8dm2QYS4lwcQKpVaceRjzVl2W+dwzqBKUmsUnKoOxM/JllWX7h4P?=
 =?us-ascii?Q?BHSIUHLZs6r6KJuHbZzwfnF5edl7JzU+ks7gcaKE1Png9EyeOJ7a+/DFGiW9?=
 =?us-ascii?Q?VmcKPM/RlzTiMfeJerRjcMPE7/bf9xPHQeGL0ypd8NhEUQOa3ff6MUQyj9lN?=
 =?us-ascii?Q?oOBpOz29QvzolYw6F4v/rlKdzOPxkGZtaQ73ygsOENADLOL/C2C5Jve9yDDp?=
 =?us-ascii?Q?S6Ft/IPEh7aXmBwzsesSkyGfUtfibe0JULDzNAlsgmshOZN1hTJ417Ka2vJL?=
 =?us-ascii?Q?ALmUck3XUHbWcqjY/hWUtLw0QAimaZVIEhD7F2QnaErCqxxe0pqL81ukB0hl?=
 =?us-ascii?Q?8KaBOIWp3Fb2Bnbsnmtwsis6kXBnKw40b/Nhcm/WGBfwVjp+5ptSJ/Jqg/t/?=
 =?us-ascii?Q?QcoDLwkM77JsmY0E90QAglQU+xBaHDXLXt7ZVqSr0HiU9fwsJh7JHi3hr5re?=
 =?us-ascii?Q?Rjr2488Umi+wFQtDZB3oY2N9lj9gPoI4N8UnmcHrqgJpqgpLPaw+BCx3FhJt?=
 =?us-ascii?Q?r5l0+P4t+oX93ZrQ2qab9mlQw8ZU99d52GoHlaECa2HfEGmLtrnvsWGu3csi?=
 =?us-ascii?Q?xeEEvEjmiB//NBV+h1+A3W1zbevlLKDMFrHnxgOL3MxB/LVYW29Y1qnZWdtV?=
 =?us-ascii?Q?Goc8A3zlwN1i4y9s4kUe9vF3zIGcGFW4JyFOvrztkQAn+3QILLDtDkoffJ1x?=
 =?us-ascii?Q?JOvskVKBPypDfonOJ7VMnDoFI9KOoFO4Liw0gs0jLS8ZiqDKSNf8dEeOYTor?=
 =?us-ascii?Q?VTYQNn6BitL5nngY9920p7FZYmErMofDVsy7oI74N7R4/FdFMOxmW1Zxgwhl?=
 =?us-ascii?Q?amII7zyk3vugsLI9wfracTXksiZjBnVlpkB0BoAkO62P1wVkSxWOVm+s6czA?=
 =?us-ascii?Q?4Xxva7qNj9RQe9uf55faZMOXTxPH9ztR6NoY85hWDehK6pQMqzQhuzU+Q8y/?=
 =?us-ascii?Q?AJXCxK+EOwJmv+IzGzkb/bXk4Y3a2UW5osIOoNcWm9v537X2su7bIMVw3rwz?=
 =?us-ascii?Q?/2/LK7ahwBki6VYLvawEyE5hmQe/nzvMtb2AgVbCV0lCU9Y8yuZFjSmKj15u?=
 =?us-ascii?Q?Xz3Zd/KqMHxr37qMz0y4f9JYBTe6lFQvZ20+a65VFXPVZrD13GxcdwZMsSNb?=
 =?us-ascii?Q?ikMZwyHqx1/LEx/6X4i1xYIaLXn12S62P2mLRGixtz3Iz11rt6gsmkbzEDTn?=
 =?us-ascii?Q?qQwrCL3B1T9jPPh4aKkpaGhwIycjcfHPdCKhiAyGr65bOdZVZwUxwfY/861b?=
 =?us-ascii?Q?mKJlPTTWEyhvfe/PKprPsGcNaVEsvzaIupKG0gGaxYL0P8Ug2cLmrWANZ8wi?=
 =?us-ascii?Q?vLMTGNqdd0f57jc0azuQLJNGyS9y03aDz0Pfm/VA9lHBhAcg9UK0KWYuwP3q?=
 =?us-ascii?Q?jsZfMbeVD/n7yMlQnVp08Nnjzkw+ahKdBaNNXJZFel5lYQAz2nZ65+87jJdc?=
 =?us-ascii?Q?Er2OtwWho8X+R4axJiqj/htHh78e3ifUOoofSA7y0Yl/ZKHUc3xUvqvFVfAK?=
 =?us-ascii?Q?9qg/0AKPvJPyROylS0FlZEqo6dI1bqU/W8yIa7Ugxt1miQYD3dUG6IGIB8AO?=
 =?us-ascii?Q?+C4XtIzHAJacdaxAW6SI87Ql2yJgxMExSZNQfviJEn3gPoYSmD8XdpbOQ7Wd?=
 =?us-ascii?Q?LEgazLCKIiAggQnTpx/J5bC+EDn19NTULtqnVfH9xAVEmpZuzsUOtWoEBGgr?=
 =?us-ascii?Q?dHFgR3l0wdaK5H4LL2i/+pVJ5mI2Wjc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AECCCB403C390840A9134760FD7ED38B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etgb8ZiRz+Luq5dk+KfxqFaulLrqGhj5CCCxH0cKO4noYaSlL0Fi159FhIWxaLWpiz9APDAUUb7aF+N6UzdVrmdqhjB4pBFSwXKwLZqhfEOF6oZp6pUxd67dTUHN4YOTvWV0DLmhwPxz9qLVDdq/LvOZS5McaT9GPKU3KwhvGSjhP003sr8Sr+a3SzteeaDOS0oPVJciOjrHBbGLW/AW51LvKWpKKAsM2Zm0RFlyYEd1uExTU+tejm0yUBXru0HervHJC+qcIKHnpIVqXD1KBK8c1L0px/T+Z1AQCguiORThplzCEAWydJD0NI2ReCyS+v+di7MVekZQAHH/g5+D/PLsh2jo06JIVlKr4FpsgL8xNDicG/8KHwdB0dyIibbvPBhQ9Y528tSkjflQtLjurdvcHW/rLOPhBcMWsiqnagaQmFFcCq4nWpoYs9UZHPb6tCNz91XbUFH9j6qqS0aFT5HkZfwOdkK63RIUMy86zc7qJcZS4I1fonSuIvnZj8KP5LGhl7p6kMbOGEgx2R8mRIwjOz5p+B4nNykHM0BSMlmG8C1Ajo7NxyETX6eaUdln6lUCorsl+bEkrp2iV+pQ30aXSpxUrCE/X74YidWGqHjRCyCgcF7rNKVKAyzdlkbM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a27a387-3da7-4cff-edba-08de54ffc837
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 13:04:28.5656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6caDVKXv/IJ4MgQ0VYNZFBQ0AFtU99RxVdKgvR3xYGlI84vG9Yvmo4nTmUdbe3yuWj6mCnLDlkCpNHDzZwTjh+WSn1M7MwPb165BL2X60Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9160

On Jan 14, 2026 / 16:08, John Pittman wrote:
> In some cases we may need to check multiple sysfs values for tests.
> If this happens, create the ability to pass in multiple arguments to
> _require_test_dev_sysfs() instead of having to call the function
> multiple times.
>=20
> Signed-off-by: John Pittman <jpittman@redhat.com>
> ---
>  common/rc | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index b76a856..e4b5196 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -326,11 +326,14 @@ _test_dev_is_rotational() {
>  }
> =20
>  _require_test_dev_sysfs() {
> -	if [[ ! -e "${TEST_DEV_SYSFS}/$1" ]]; then
> -		SKIP_REASONS+=3D("${TEST_DEV} does not have sysfs attribute $1")
> -		return 1
> -	fi
> -	return 0
> +	local ret=3D0

Nit: it's a bit safer to declare "attr" as a local variable here.

> +	for attr in "$@"; do
> +		if [[ ! -e "${TEST_DEV_SYSFS}/$attr" ]]; then
> +			SKIP_REASONS+=3D("${TEST_DEV} does not have sysfs attribute $attr")
> +			ret=3D1
> +		fi
> +	done
> +	return $ret
>  }
> =20
>  _require_test_dev_is_rotational() {
> --=20
> 2.51.1
> =
