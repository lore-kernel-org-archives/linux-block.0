Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DB19644B
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266626; cv=fail; b=lFuAyALfRmH2lOZIVfMm+1YU8XEgmAvpW5s2AYI0boUuIUcCVYhPzeY6KiFMePLp/s1KmsyrH/0I2dg1mGr9+cHG/74qSdSc/P7JzZjYiBkhX7Elx2Q8F/HNpQsBHTaWqAKa0MzWQp8JtYjwwLoylyS3yrCgMQ7FUUq05UVOs48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266626; c=relaxed/simple;
	bh=UjC/NA+3zVaR/W3VvhDuPrFQ4B71RdCABbMmrpTErXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fIyMRCLAqhnC+yPnPCRLSh0DJfeM6GkOnpopsFOjHHfEDlwRYCI7X/yYz8KXmkc0XwlXiFf/NYqQP9EqwjdHauPCuCbiTOtkzgVMRJQruDCVVkxYD4kegIP0uDTnFW31J5/3w0npg3RXnzLtjSJ0izIIDHnfseiJnhlj4bLg28Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=REulcAEt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QD4biAg+; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="REulcAEt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QD4biAg+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765266624; x=1796802624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UjC/NA+3zVaR/W3VvhDuPrFQ4B71RdCABbMmrpTErXA=;
  b=REulcAEt3lun2Uq+sGsUxM9oCScIdig0z+9YvufJSItSzHdwoCQzY9iE
   rMwmhqP8qUgBvCz6d1T9A1zyTJgFgs1EpELR9nK7dDQ44I5FLiwaQhfNh
   OxJ6IM82nMa5n1R6kAcD+UG1KS0vetmkenOHC+wLAdYdrGPO+ysrPxNiS
   SdFF/AYv+SCJVvcdtioACpT+ttMaZLHDix0hy2HE/SM/oC4I/BS/sXW76
   /PLOUqcYVLLnhlsO1qdBi1ZVGIo40CzD/hb8BXNfDiwbKCV9dJ/PXiPkm
   q3tfILwkJeUe8Ope8SzM2CUrc95nW/uCVFCz+Ic6YxUpxYzTzdDggJ7TT
   Q==;
X-CSE-ConnectionGUID: GEbuY7YkTEqIbs4uM7sI3w==
X-CSE-MsgGUID: XCyJ100WTz6/In2OrKAfbA==
X-IronPort-AV: E=Sophos;i="6.20,260,1758556800"; 
   d="scan'208";a="136599928"
Received: from mail-westus2azon11012039.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2025 15:50:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYassvXZsocsHe+xUSul+XX7mOH8SLtWV55Ow8wlQEjTEZnkWe71HrKD5nYcf9hOdbAt/0VOFI7G9E9Tzl94EfQNF1+cQraunC74CpDOHxILky5G6twRkH4Peixgt6W/XytBqLQkCqMffBiWf3qmhpRyqNJijD06eJRDCGgtknSMQYmaaDXXDkv6WttD80owgOp6aYypXJErYrJSCG0EyHK5LLKDWEwUWC5dFW8I2R9PkoEePGvx9C8/2KA/pL/DXzTisx9zM1cytLQ7xZBlkK22UE7lyAwDiCKEcFbacgpGHxkPNPOMRB8VnzvqfqYixJWmxq5P29VWNiEaQHUklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U003NeyLg+wjH4wyxZvlE3pAUC5yTRlTyRUW95LfHbk=;
 b=LYisTh/BRGk931INApSMC2fq4lvF4UeyQtfQbvkZ5oIBKVZyg0NR3ngwE9mw5tKTUoho4xh0zVfS0WKIu0z9/A/tlfp9puktIKFE4qzK9r/aCvCU2mGer3l2MocrfX8zBbp8ugiucM2blj4TmxDmTzYfvRPGfCVoXAPkbUVi+FwzxuQUcQ3RnoUHolh3GWlFi+Xmb8URsN4DymJ/P/ZHMVz/ZwJGaetxb6ZvxZXcHfYiSaWP70NBfP+/+jJEMFqjl/ELsswqnfHSb3AEOBaYy64bB60hS2r3rxFA5l47SD0XpPtcXgO5YO/YaXbC46a1SKAi4Ss04732mobuJeh/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U003NeyLg+wjH4wyxZvlE3pAUC5yTRlTyRUW95LfHbk=;
 b=QD4biAg+fYRGlhl8Erful9Gi3txY5pR9DHDUEd/Iydpzl/4Y75ApkxVIC9WZF8mWyavKKb3wS5+K9yHkN/+Awq9AYTo+Yg7x5MhAaMCCAd1JAh6RxT243Jr2ahqMESA8m/vnGWTcHaINewWTf099h5Yi+U+T5zphb73uGzr2lw8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB8369.namprd04.prod.outlook.com (2603:10b6:510:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 07:50:15 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 07:50:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Li Zhijian <lizhijian@fujitsu.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] scsi/004: Remove reliance on deprecated
 /proc/scsi/scsi_debug
Thread-Topic: [PATCH blktests v2] scsi/004: Remove reliance on deprecated
 /proc/scsi/scsi_debug
Thread-Index: AQHcZZRwGhavkyIwHkmadFUZt+aytbUSoGaAgAZVV4A=
Date: Tue, 9 Dec 2025 07:50:14 +0000
Message-ID: <al7jclvyxhoavgbqtjz4v5skh24qxqagd3hdsxczjkb76w36ac@enkykswsrbi6>
References: <20251205031053.624317-1-lizhijian@fujitsu.com>
 <89f8fe1d-bd1f-48d7-b056-333cb176260b@suse.de>
In-Reply-To: <89f8fe1d-bd1f-48d7-b056-333cb176260b@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB8369:EE_
x-ms-office365-filtering-correlation-id: 312f9d6f-f1cc-4af2-6e79-08de36f796fd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pM3u4hmK98j/uoBFan9R/7j47JQUfhm8gX6Cdvuc/1BhGExHRPDmChrl15Xu?=
 =?us-ascii?Q?rcme8YWRYAm/1WWmY6t6UOYFLjJY4bUDdTLxqOUCosAXA64U9kpGQut5xM3G?=
 =?us-ascii?Q?QkqbamRzeGKBotsWnH/d4d/0O0IXvg4Y98wN5lkR7i7FK9twDgsmKAfOu5EU?=
 =?us-ascii?Q?lWDMwKYsHm1OdutcZXgDQjJj5hr8474XSLJBMNOsTPWho0hb/BxqoHQYb35K?=
 =?us-ascii?Q?rmn0THxWSKmD5xLXbismeBxH1L4emyz3tCX5SZIHmg33TNJg8o5N+YjTVlyU?=
 =?us-ascii?Q?EJs8Hg6w1IaCrInx7GrAdq44eSzxVcB8MEFEX0oZSDsmJPle5/Fh4qkVu2h2?=
 =?us-ascii?Q?EiEkxTEm8UvnxUybGsx8j5alQIDBk/K9/PLix6W2qzE87l3pSSBwym0lJXQY?=
 =?us-ascii?Q?qNerqKA5MG+gDPytss/b4/DElzp7dn1VZHbHw4G+J301NhBjSmh9KnLk458I?=
 =?us-ascii?Q?VnzCFkGFWNKv71aQRvuBaN30RqWPyJ2vkm+q0D5kTJygVht4/lLL6NYVVrXp?=
 =?us-ascii?Q?YDaHLJLlDcjlmhRtHPymNVXEMS6F1GcXa2SNEjlG6DhtGD5uvIXM75aZn0Nh?=
 =?us-ascii?Q?yE29eD0vgJ19+2g+AkQlJ5HzMn6cv6XTGSDI6l1MMRjRyFHosKg+nDI/VDsI?=
 =?us-ascii?Q?Y3Xrczzel4PsXUP3Tuc5nKdOm2tRpQuFvI3f1lnEx/RolRQf82WJlNvUxnXe?=
 =?us-ascii?Q?NecoFhunIrtnOOEeqdYNHsuhxu6UCGYgin16hP9B4nxNIljyIrgc6nmMAWhv?=
 =?us-ascii?Q?o1b9jrK/VBi45SH6+C0b0FAm4HZrQ7a4KviQ6f8EAEkk5sx7Ur6ZnahstD3U?=
 =?us-ascii?Q?bnUfkLyS27sorSQufOXPxrVwZim/VPe5kkrfX06d+3a9GkQkNFLbwoMwxO4E?=
 =?us-ascii?Q?KX39s5znaKZzKa55ohmfHzEPYYbF56BbSzkPTKVjE6odtG85341TrkUU7PNi?=
 =?us-ascii?Q?PJabE+K0B2n3eATJZXig4xWbWOWFYOyinL/fnccZ6vxOKmj2Q+ZEI4HKGG/E?=
 =?us-ascii?Q?ETuRfMKm7kT6VsbtgdYwI/CSc/FW9SJ8TA7vENgdoA6N+j1c28UisX8NAsTy?=
 =?us-ascii?Q?OI1tHOxxnGdcRMcUJq2dFdrJWPKJcRpVX7xDyNmC2XfmdKenrMqFFt/bwZpn?=
 =?us-ascii?Q?fz1vKmQ5GpmJpJ9l5VPrWGFvqDlAOSiPZRRFn0w4b97vKjHqbkkKvW+JGgdz?=
 =?us-ascii?Q?iaiOD7HrkoK95ozOOup1ghH/rtCqWj5oQUeQTNU9hY9Z+TGHP5+UAyvf2RQI?=
 =?us-ascii?Q?dI5U35pMzlhajJ2gXcG86olH0M0uDtBLo0N5yBZNYvrj+4/mTSCR9xiNOYu5?=
 =?us-ascii?Q?//eB4e3nkBKdQb5lCEECp8aFKL8j3mKeYWIe+IUlgyWh0PuII8E0XWLoZwUW?=
 =?us-ascii?Q?EhFuXBKReQ2hGqu7Sp10LiQQdVku/yPf44O8bowa5eUz0PyZnp3HwBse1LV2?=
 =?us-ascii?Q?HMB9XTn3WXIlRD1BxQdAbgH9h7d017WJScsDxQZdItw1twxtNTGb3uhMUSdt?=
 =?us-ascii?Q?eMQiIQ+lgywwQiU8YcuOyMXpXZ9kcinX7SWo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VT5rmdafVgFRt0xstVBYUemctvAdEb2uSqxcCkErlLOQkT7t551V+FCemQur?=
 =?us-ascii?Q?gR8ADiM55AEksTaxSESZLEKY3+Q/PxZqh/LEZwVRebrzQEiQRxCISTX08W/B?=
 =?us-ascii?Q?dgHxHZS43Qlm6JOZXeTvbmlcQEGsQcQ8N5+EufBLZty2zo73uPU1OsmMQdpd?=
 =?us-ascii?Q?Xa3jmIDNg8JqVww/Sa+JOl0XtXXzj39OmPpCmdh0qO1BmkpUkcNWWjazYUzt?=
 =?us-ascii?Q?YddpqgovzE8Tw2EU4WmGuogvuB2X+ejgfbbGobVDPH1+4bY69by34IGc58UY?=
 =?us-ascii?Q?AcHLdI26SDGO7gmgRLxj9Wfh7TET5WpLAImlt6CiK/8EL5by0asmC2QX+N2Q?=
 =?us-ascii?Q?0XxKPBVjXcTmQvMD9Ep6/brqtbAhCf4CQf4mj+A+Dt5TRFpJ+MoutvlnhfOU?=
 =?us-ascii?Q?C7eq9PqcTo0D4gs6Vd3bInes+IqJ3jwsFv1cYKyDtlb0N2M+klrlUPyKiTlE?=
 =?us-ascii?Q?zKxrkw9lm3rtM+BBsJWLNvdtIqb8Eq1d8oYpMYhB661lFDIlt5U7XD7YHzp7?=
 =?us-ascii?Q?x/6K/TfQvqZrm/RGFbHThc1lkyhk4Lm2yW/jA52NgnSMLa0LRpLMoTTptvzR?=
 =?us-ascii?Q?Iiku6O1LFEQZ7hgzAP/cf88oEiRcABFygKck0REbb/724KinaKdiPczX0wEV?=
 =?us-ascii?Q?Kle1Cx6le1+GrkjvK964jHd1BOR1OPYYJEvkM/RuAnzpzMilebeNhDx57Kp2?=
 =?us-ascii?Q?/BFFINJazRaWobj5SKgBvHdc8dTSQfXVHNGMMDz4F4TJJC1sGA6Y7fYBGe+u?=
 =?us-ascii?Q?Q/S/yw1CQWKxgo/pLbrSZCgq9gmDklLXgfJD8HjRDiJ5MRFrzJmRHOYpzgTn?=
 =?us-ascii?Q?W8ZMPNOJ52a0ouApL7qa1Dhbm2PalAdAbrFQ3BjCEJnaUE+w78pDZ7GsjslP?=
 =?us-ascii?Q?3wLLENAakGaxejOGqk2EztVugvnTKmXK/DLl3eR1MY5G0e3C8WJVh0d6CFAZ?=
 =?us-ascii?Q?STIDP8OKYmIqyyWvWu2qbM1mqLQUSaD7q1ELW6hlQM2LaLKHPWHBsOj0DGJk?=
 =?us-ascii?Q?vTIOXFwKicGSaNCYfMZHIDXzP2d/hYSxt4AeRThMX6ECMMtUCKv1GOkxDrAJ?=
 =?us-ascii?Q?LVgr2MIrKvLdf1hClSWULr3B9d3PgvXV23uGBAfEBQdrN2b/w8bHHBoBZKx/?=
 =?us-ascii?Q?LUb3kghBsTbjF1ewy9rJ8EIokDQFD9d7mKL0Fx4f1wN5LPDjGfVgkmviAnyW?=
 =?us-ascii?Q?gTs+QzPIoh+ab03GKOlahZvkZ+cAmLQS0bu/kQnzubaO4mEpZfX6WPxpxv7t?=
 =?us-ascii?Q?iYZUmcLXOHeurYpHgAimOPmk3+3uswYvcUcX0azIvaOtAycLEO1jPwLbXFeS?=
 =?us-ascii?Q?M6nVuKWgaaQDar7P9sANCqeCBn4al6JI2NESIzQL4mSGiLOEqWRZguDG0jR5?=
 =?us-ascii?Q?1PvzkxWMhAe8hCl4uX+IGNsrVZYVwx1IyNrXpam6oyCe8OQHcpTmF9pn0qqq?=
 =?us-ascii?Q?wUUb7A/atInul3laapuEg1CiwXAh1kUxjAwsmUfWulYydxh5WP59UUIWj+MB?=
 =?us-ascii?Q?Z8K3rY69nbnghBLNet+Oaqpe37V21EDWvXK8dsPK/GzhBBtQxxrgp2CqTdN8?=
 =?us-ascii?Q?mmz1Oes6t4jSMZH/7GBi6oX3HjKuCS0ymnOzAHSiuRADbm//Tog1gxirK3pb?=
 =?us-ascii?Q?CNthr1oknlZQGeypBmD2xrE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F8F2939D7F4DE43AB59166AE1DEBBF8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pb/R1rWB/v/504N781Kcz67RmMNg4YwhNVuyUiwyDXZSSy8ShTim5geLK4Hjg/gmLQI5iwvjL3cGiNR3B5jIqzw3RcUpjRjp2kqItAD1ngNr3o+dLnMPfOKOLZy9l0KaQ8iwnlBehH2AGDfcW5764kkK2XF5o6a4f6nsGDkbgdwCXK+GCciRF/zvFRxYWJczcmCJ7bGO8+lUS3TGURVVEaYtxlpuGrzzglW3ukv7Dbg7qM7CE/IJvvDGrNrS+E+/TZaTx3/ZysZi/aPxEENbfY75ODbGi1KI3bRCF4Cb559tpY910Hk2ryv8aIVcSwTUSxrOYTKiMbQRLyCX4G//IzZgIfgFHqHH8VVQMiHmqj9ZyBwT4Lj3OBwVZ+TchdXeZulBV3E1RBq6aCI2cUGeSCAohEWcQ7CDLzqMzMj+OexYWIlfmdj5kW2E23xyjcgDqGy9Wos0V1NHyaSbZAfDOfp2w++xen7xeB7nN3hKcP3kugRkbUNQT7586Y30ICcPKwrCAzNPrifCZorvdWfA/q0CpSvuKT3sExDZbsIHdLrG5JUMwUrQp7fdNann44vV+PyMZ6ntd2v9K8meiBOtxC4nXiBmFhJ9LJCRRSYWaXg+sO7hgw4xKBRUkSPAhOe8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312f9d6f-f1cc-4af2-6e79-08de36f796fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 07:50:15.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUIDkbmZZHvS3eagYxZDevRNIWrf5wF5w7xSb0jTuIzNCcpKGxIlmDy6V4wNvPUTUeNriUo1IovwTdFLgUPN66NZtf7YqRhekKT41y3qZeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8369

On Dec 05, 2025 / 08:07, Hannes Reinecke wrote:
...
> > +	# Remove the SCSI host to ensure all the pending I/O has finished.
> > +	host_cnt=3D$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
> > +	echo -"$host_cnt" > /sys/bus/pseudo/drivers/scsi_debug/add_host
> >   	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
> >   	_exit_scsi_debug
> Hmm. That will remove all scsi_debug hosts until that index; so let's
> hope we're the only user of it.

When scsi_debug is a loadable module, scsi_debug driver is removed at the t=
est
case end and all scsi_debug devices are removed anyway. When scsi_debug is
built-in, there could be a case that users may have other scsi_debug device=
s
that this test case does not use. In this case, the code above will remove =
such
devices. But I guess this scenario might be a rare scenario.

> But can't be helped; scsi_debug doesn't allow to selectively remove
> hosts. One could do a patch for it, but not sure it's worth it.

Agreed.=
