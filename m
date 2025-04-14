Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE529CB39
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632645; cv=fail; b=OxVr9708EoLhJfqArZsvKZ5l4W61E6WzRXvGADASYy1W1ia86tvyq7I7IjMohUQ5IkizeR1mY9N2FOdILIf+HLXu3bNMDgLs+nRvUUKZowNCICbj2/8J2ktHTqH6wPDuTwdq7DrdO6AIRts7s+TXDmtK6ZBMmy64heC3cgyxBl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632645; c=relaxed/simple;
	bh=kaI/huqIUELdRQc9UAN4Y3SYyZgK1wj9sgATtyRAme8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OH0vNxjP5jHvQsn7ytkFr2cN0Fg+ejvqCKqEHFsTY2bEbZBWGTYHMEuNZ99dH7Aytm0TS2+5PgXccl7tK6hcJuXWeB9ymw6/fYl9OSClNUrVZDeKodDDBQzp0bgQ4nn3jCJwQTdrfjqzj3Vgc+gm0Lvz9t9ZWpHfmJfI5B2mev4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ojAz8usq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vvDOW1nK; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ojAz8usq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vvDOW1nK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744632644; x=1776168644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kaI/huqIUELdRQc9UAN4Y3SYyZgK1wj9sgATtyRAme8=;
  b=ojAz8usqIoo9pBZYs/yjJDMuAZXfRQ9fMh5PKoTyq+XKFZAz9IlEGOQR
   SL6FB33U/5HwoWJVt6tof2InDrl3NJjlt/lUroSGSWP7iqM4I2u/dByoA
   aoQDQSK1r8bX6GfaSdvH6Ma2L1dWAtubtkYONJSK3GA+ULSQcx9YqJtpG
   zTeXAsBDa2bjCFYK/25eYb9CdFofcSXEHB0Hv7jxv9fvl4kCrgFnI53r5
   GGKva+VsC2sKk0Hh+wMuTTTFU59yiFX0a7WeS8Wj9DFlALUWLM9KfpBPd
   Y+9sgwNHWnoRGYBUn/tyQPkxCZvgANdOflERO/F9tfAjJows/W7nx0cC/
   g==;
X-CSE-ConnectionGUID: JzgaOKUiQ9Gmj/E9t6OOjA==
X-CSE-MsgGUID: UMMIpi97TVy4jShaqOiR9Q==
X-IronPort-AV: E=Sophos;i="6.15,212,1739808000"; 
   d="scan'208";a="81236753"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2025 20:10:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHV00e8b/GaO3GpV/XZV41sr9lC5q9pq3jkY+P1Rs2e4M17CJcZKm6mXWL7VuPsMCR37dfPlg52PMGNwYabLs3SD72lcAM6/Em2yJPj/YzA7qXK7oylYbXes0HH3U0ZQf7ljQxmJrjLscgPOh9FJkCXuiGNDoLPST4G16SmhimdxcdzsRfz8Mtm5YL+bIDkmuQiIy20y206kemXeJM2yG9BNP3ho27CzZnFTC2ez4rchqY9ZnAeGmcS9KjcK9cYupZq3PhxXzj24I1n5oQQx6MH3fIlopSNP/fsYL5hZIwAAMjzQZ+SBN1DHEkdYxhwGYeExJptLmbaE9KFtm4O2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PGbRE2SyYUU2+DE//qcYb42olFE7nrESKbePIg00sk=;
 b=ntLy1QYGylFOtbw+FxCaCaOIV+EWhhtC1qoaLyWhyyl4l6GzXV7dTD1nJA2TMGOYBP4oTk7HKQ6JbA9zz/wo4zLQaTQ7AFr/k5Nb7DoH19FFAMc6a5sOzLrhWLZgVp4Fx7Uis3nqdY6rfqGtC4xAMqKFgNoW4ELNo+TbDudZFn3+KAoOth1B4C4YOWOXjqVOs7XCkzDimBiXlQrhhFp3U6VgonwMTweGgqsQChNlM+2TszSbVLq+X+EM1HG+UaKbjYlRY5mAitZ5Pbr+ksmb8PV2lwoWT1k5RIgKbcmMygaynFgH0T9Y5dRgGpnv2s5Q2o+HvWN4ClDntJP805iQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PGbRE2SyYUU2+DE//qcYb42olFE7nrESKbePIg00sk=;
 b=vvDOW1nKaMi42I1QG5BlOgB4Jd9vxhZuwn9feTfgwq4O9wlo+DzT7+iU6gCSweGWd3ccWHEsDZ0TAVy358dZ8T7jhvG3tmJOKqLq2OqaxvfG3M7vpQljhP686tlzldHaHQg03i6xGAzUIY8DtRZda8EMZwAlXbe+fBWP4oJb9Lw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6872.namprd04.prod.outlook.com (2603:10b6:610:93::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Mon, 14 Apr 2025 12:10:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 12:10:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <kch@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "asewhichexercisesthisinterface.@fluorine"
	<asewhichexercisesthisinterface.@fluorine>
Subject: Re: [PATCH blktests v2 3/4] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Topic: [PATCH blktests v2 3/4] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Index: AQHbqKL8T9sjdUQfMk+zsUGAeRi7I7OboQkAgAd6KgA=
Date: Mon, 14 Apr 2025 12:10:40 +0000
Message-ID: <ylrzlovilgmp3xlkxuemoyjzrxjcswsvm3g7ircfjbklejvr7y@ewypfp2d4i3h>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
 <20250408-test-target-v2-3-e9e2512586f8@kernel.org>
 <4f62bf2f-1512-4d5d-808e-b257adf29eb4@flourine.local>
In-Reply-To: <4f62bf2f-1512-4d5d-808e-b257adf29eb4@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6872:EE_
x-ms-office365-filtering-correlation-id: f255b60d-bcd4-46b4-54fc-08dd7b4d600e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MdzTcwhJPkANXRPebfXs9dNo/bv4VZLIVp6fReejwRozDP5ydbYbZKvOYFWw?=
 =?us-ascii?Q?hy/H8WCb4ydCjwfc2vwCEJUa6eaHmQZUb1dwlKRAX8EZFOg3gWkPgtbbVrkG?=
 =?us-ascii?Q?RV4rMPegDYjyM5NqIcZeKJuiYSU36Ps3iLxlJIaessodgU4jwwcDPo5LShUZ?=
 =?us-ascii?Q?kkhQFgo3ycKPl2UiXa13npHiwixxNFN6+hjxQ8Xw6fjhW68ch8Zc93PzDvlN?=
 =?us-ascii?Q?MAdh19G34Pv9+57+x9GRJPZkkpbcP59qEvoQoN7EroyGJwsFOobt1qJI/Uxl?=
 =?us-ascii?Q?uhKym8fDTQE9RfC91Ns/1sQrvnr50swjfqdwVrsBZlspFCJk9LkIxuhyjttw?=
 =?us-ascii?Q?XjLxXl0JxOfVHU6jT1v64hhN/rJPW+dZ67GV61w7xhFWuklGH/KsuCkCSpD8?=
 =?us-ascii?Q?clhPdYzR7zg5NpBAE8BQT1zIdRZf7IURsK0vEui8HGx4t/FH9Zq9HlVuFW3v?=
 =?us-ascii?Q?CQ1g6jy49IYp/nojOikaHiPUxWBu70VCQgoXQ5GK6uWtf9dMfbwmQtxP7jCU?=
 =?us-ascii?Q?no6ueg5x2vTzPE4B+c1JORnLYdsUjFXcqjUMew9lFFe6AdxtmJbgjrxG//Ii?=
 =?us-ascii?Q?yImRekz6LOG3zsHyLY8RbneTwBYrd8y3223NhdpVnw2eZDigjMLNcXETK9UQ?=
 =?us-ascii?Q?lgyC4UAximfFhnS4hhuOlEVugb8eXolPsEucjd2cIpobGUXbzu9diLPwmLYx?=
 =?us-ascii?Q?EG3cNKBzpWOrq56vRy+Of9nMTqrFKnS9bD6EJ+VaFNig7qRaTSDGJBxjMfpw?=
 =?us-ascii?Q?ChBul1tCvJUSPfOASsbDOhOtw1IvwxCgWhhqV6dUAG5Gc5GFtP3B+2hIJxv4?=
 =?us-ascii?Q?NlBbaprczSkdRJnJW9I3f4sF6tlEDt53UC54w6qZkbpEIZfvMsYTTZoZAlpS?=
 =?us-ascii?Q?3+EduIuZoj6OoMs4HwW2dczmrK3QJv60/tzdm9iHPaz3N+tn4O40sQpOUnsC?=
 =?us-ascii?Q?UMuHMcZVP/mj3HVCfsvp9XD7wPL55egGp7CoyvZEQlPTOYp1x9Jr9mzhaXGv?=
 =?us-ascii?Q?AEk3mZmX9qSiWbHMN6VRyLLN+3rjwiRRmmg8xogxtVJxPcKqXZQLPhOJeuwO?=
 =?us-ascii?Q?iLZfwOV9pQ38hpDt43tcTm4NnzmcEFB3MrN3DEAX7oqqZsQ2MAGDogJE1Cn8?=
 =?us-ascii?Q?+q1zRr90drAUCu78sNq058pjQ6GCohRbe0Mvugx7boqEsjottujJBWsIN/yz?=
 =?us-ascii?Q?XIOKSlgYKkZ6RZ4hwy7pQHmAo7KphAmgm4ct83hOuTAyZHJeLPvF/ppvElOR?=
 =?us-ascii?Q?QRptwiyyYJw4cU8IgAulrC0VBMJWx1UyP/IleR8GO8AbHdoDArgcp2BeCgxK?=
 =?us-ascii?Q?4xmUGT0XgoCS451TPj44UOJWfZ3ti49oAmEV3akZ0i1SzdNbdfBuqvY8oSBg?=
 =?us-ascii?Q?9JyYOJqxzceKlDd81qgiqIkn6hzWckDUe7d97TpP/YnnSEfJbeXHqjdiAXTd?=
 =?us-ascii?Q?pMEAFHjRQODCs8hlwOlpFdrMsMtnZLstOitk7FKTpbl7U2kUWnqv2A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q8u2gYWH0twcPa1LJ3AcnxFvnfngJUMlaiVmYRlSHbF0Wnj6qOpb3wtdpBuk?=
 =?us-ascii?Q?kwfq5414Csby6RirqcjearLA+jIajPcRr6bZrEA90LbH7tGrEaiqJPzN/58f?=
 =?us-ascii?Q?zOUiNK7VTM2EfZwDdkVLgrISKoT7xAJ2t9nHz0F37Bcfgu5UyY7KXbJ8FJ4Y?=
 =?us-ascii?Q?JHYnkzg/9UxEouEzQ/8nONNXdFDSJsTm/xn+PaljCScdvr2PgERD/og1jWPh?=
 =?us-ascii?Q?1uPdNT4vViBUulWIyGJaRbwr8/n022CeaPo1p4IfRYniSHXfdrg9ZJzWWQVD?=
 =?us-ascii?Q?O8Gicy/RWAUOuOahphjodMOEtu8AByI5da1suEPuTmDnAgROUjID9gEn4RJo?=
 =?us-ascii?Q?ImGo/K3odSzxjhcdN+gs4ogOnoTchdqHow/LSsi6UL9bu7h8pUUv851byPc4?=
 =?us-ascii?Q?FKDdUQRaA5NSz7sCmchF4yfRBLaSlfdB2xRj/13skvw183kLieaF6CQAX800?=
 =?us-ascii?Q?gihyCCTwy7isWbW69GxFtAA/phkEcQjjjgEq71mEmuZtZK++y8IfYakZmeMs?=
 =?us-ascii?Q?qUFlFxWANWB/7SYScri9CHTdqR4mbFa115aXNKHZAwD1ti3dRQY0KqsaVAFd?=
 =?us-ascii?Q?KuvF+lRnl2SxqIu9bY3HNY+VU3pj+mbpO5jZgnZ8gSBabH8PtO0eQQBTcxDH?=
 =?us-ascii?Q?Cq3K2IU+o+E8eReP4/sc0vbbSg06X8zsu2c9Fva2YwINln10zqaaW5PvXJpB?=
 =?us-ascii?Q?xogq3GtrRnXpoy4Bt22RjWdxMYdDK+OMw5Cczf8pOIHqhP7FGYDgKvCrd3QT?=
 =?us-ascii?Q?CiL++x61pyC+nBzeWiWa0lwwRx6z9lt80j/Fefu7SJpDSSEd2UMtvc2jirTK?=
 =?us-ascii?Q?t7qbbREDBiUcllhU2exMs3ExtzKtTy2LS7gP106LqbUROpelsKMSppy3TSJX?=
 =?us-ascii?Q?+85gMfVmm9OJztracJfovBm1V/d59dTlcwK42kCnwSpY5PJl9G/orbfwQwti?=
 =?us-ascii?Q?dBTwm03nfrSLjY3AFlgn1cgQ8v+kseH5qj859XhungkEXvfHo1zWJ9bPvsTL?=
 =?us-ascii?Q?cZh63zbaB3kvm9hrzvg+Gl7/JBcGexE2VJpKRr7LDm5TBimQLYmheNiQw+dC?=
 =?us-ascii?Q?5qgr98IQRoNMF4l0jSMBnOxrDvf3nIpWJyi+OP5Rd3h7XYaw0b753b4g3BKE?=
 =?us-ascii?Q?xhZ8JUT0Wx2goBbVxhyMq/DeOWIHZxGBkxplmuiqQ7x1NrgtK+AyNSND8R78?=
 =?us-ascii?Q?JMrSUDH/sfBIM0Z92CrH0x3WdXUo2DLODbK+dabvK7vuAtjbmjtC95JB3uHm?=
 =?us-ascii?Q?J7TpRTMyEGu9WrP6Ul4UAlZS//WzhCKdZJlQF0tZE2tl9ONY4fV6kphCNDkL?=
 =?us-ascii?Q?msyfvy2oRWXfsRYrzjMLDDziRu2l28JEv//M4HjWs/aiF3+nHGOZPWcktzd+?=
 =?us-ascii?Q?ljw9O3kLL5/rmcQ3fPdi0XZ6PhJr7xfzjm6o8nkY/at1Ea1JL/f/jJjbUTeI?=
 =?us-ascii?Q?D2mtM+gj0yShOTylsSmficPxOyHxPIaZ8Sdne3s8avaKSth95JHqxlKHgNkS?=
 =?us-ascii?Q?YyuFFViADL/MPQijcfXJChjZ7q7pfEP5LXNPzDAf0YgylAT34c1AX4HcX9EX?=
 =?us-ascii?Q?jWgsdkMi+wloAVMWfmjNsVB9dKwbLfUpb5/tGJvUlJII3f4aOUufoMBmHLOL?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F0F3EB4F115924DACB061DFA85C4018@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mvD5kW1tkWA0WyaswAWIGIKF+3TWGpGrhb2cOASi7TJgad7lXFpwcGIOzI3m3fGmu2mxrYx7s6uqV+G0tdVF7FMH2FeZ4UpyJitBWv8GJOr/l5uLryHIu8LFUbdSjaC4DWxtUAhlzyGMlzv8anJTDECNCzgGCyx7f1O/CXHhWzFQoOX/RYvIZuhtNXxHhs46q8b8E5gxr5n6lKWQ4FDelq1MQOyWaTq1Lyve71hG1ybgs52oTeNbSjXTaIK6YoT/XGRbBgO+8wN/9mwJ9a8xELf48m0J2FTyZpcur+olxznF8iVom2fC4aNcjQKPPVkwGJL5LHcr0vS7BD7Vpq5qeoMiY16wYHXvKksF1zaE7MfMykFfsaiNoVIbk00ZcYukeQV8ZwrDEXaTr2CMY5Buz8o13RMNTp4wIXCenHi0nQJqkTy9XDkmUOhZQOYOs+mjSUg3MpMaf5Bp6ApzODWjRreUSMnXsMQlHot59rq+zTauDX3QlgX17ViYWuOsLCYCGguuNjH9PYHd703iLlv5gNLwWQ2FEAJkG79i9VMCBoajdAABhfRfiqhHAqjWufMWhMFrku7iChr20AhvoLdzvK4lMdAlmV3mzYXTwzbA89XcjZCeELx8aMnSkg8J2ezu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f255b60d-bcd4-46b4-54fc-08dd7b4d600e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 12:10:41.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aR84i8i42vRSfFVww01TOZwCzHH25CrCdmW7+tdN2NwYIgo5GAsZlMZnvMCz7EaMESBAgOLx2ri+rLpQ9Jm0zy5IXNsNYW9wuz9kNl7Te8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6872

On Apr 09, 2025 / 19:59, Daniel Wagner wrote:
> On Tue, Apr 08, 2025 at 06:25:59PM +0200, Daniel Wagner wrote:
> > +requires() {
> > +	_nvme_requires
> > +	_have_loop
> > +	_require_nvme_trtype_is_fabrics
> > +	_have_kernel_option NVME_TARGET_DEBUGF
>=20
> Typo: s/NVME_TARGET_DEBUGF/NVME_TARGET_DEBUGFS/

I can fold in this change.

BTW, when I ran this test case for tr=3Dloop, I observe the kernel
message reports "invalid parameter" errors as follows:

[  150.907272][ T2312] run blktests nvme/060 at 2025-04-14 20:59:00
[  150.947249][ T2367] loop0: detected capacity change from 0 to 2097152
[  150.959649][ T2370] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[  151.009708][ T2382] nvme_fabrics: invalid parameter 'reconnect_delay=3D%=
d'
[  155.626630][ T2429] nvme_fabrics: invalid parameter 'reconnect_delay=3D%=
d'
[  160.158015][ T2476] nvme_fabrics: invalid parameter 'reconnect_delay=3D%=
d'
[  164.745460][ T2523] nvme_fabrics: invalid parameter 'reconnect_delay=3D%=
d'
[  169.161893][ T2570] nvme_fabrics: invalid parameter 'reconnect_delay=3D%=
d'
[  173.766537][ T2619] nvme_fabrics: invalid parameter 'reconnect_delay=3D%=
d'

Is it expected?

This test case passes for other transports (rdma, tcp and fc) and they do n=
ot
trigger the error message above. My mere guess is that this case might not =
work
for the loop transport, and may need "_require_nvme_trtype tcp rdma fc" in =
same
manner as nvme/048.=
