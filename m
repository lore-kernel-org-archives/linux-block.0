Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95852E6127
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847916; cv=fail; b=S6lzQsFtnkaZoObUTQ8P7XbCR/g2mLhny44onIiHzMQH/UbtKovYD2tTHIe3IXn+OIxo2WmyRAhFvpFYNQFOB94NNt6XzZJNLmDPyPjEoXEWBQCaOYVC3of0sl+lp5TCCBWNzhz2x+DPmPkWQEmd7abq8cCGO0c5jpaP469ovtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847916; c=relaxed/simple;
	bh=Q6diu4jMxfc/54u0NlVflv8lcXGotbARZBRcUb6W1xE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOfRRIImKpcd9swhrioA7YmsXMgEy7Sxy7QPvN2s2rcyBu7I3iYXemgJ4uEQRhM5gK+DlEgveIQf2IxrzQCqErq2arPFcoxempxUtErBMHEPuaDlCmDvODY9G33ma/5j+MZjF2kh5wyHfdhNyEkKSflEKPLAVqsVTGpnhbNGgyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Oy5a3i9q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DMKSKTp+; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oy5a3i9q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DMKSKTp+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762847914; x=1794383914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q6diu4jMxfc/54u0NlVflv8lcXGotbARZBRcUb6W1xE=;
  b=Oy5a3i9q/WvVU0kTibQgXoAUX0UMGkSAafHjt7t4vUl009/pj9ij+oqK
   0Bz/Hi5xVEyS322r3lipChQb7n78lrY0kopMQtMCeZbIkiuNKBBOHBtGM
   2vKgzyupJnbWMitHUSvau6ejoWi0TcBD941pHzF9qN/cTaLqAts2+XOe4
   LytFhSuTv7N5RlnfkqNhJnxwpvNFn73V2kEKqBrjSGLFvnHLoE0Gy6v4M
   HeFnDcPkcDCVhYRJW3y4Hwh2PY6IuKvNY66K8g+ox/hVoWOORgu9SDm6p
   AKZ3Z6wvZ1uGv3T43ssb6r0aZtORRP/psQ1lsjQENpGAO1gla6Xrh6cat
   Q==;
X-CSE-ConnectionGUID: 3nFZ/QmWQ2SWpxZrzlGW6g==
X-CSE-MsgGUID: OROz7hViTKaEuH6lTT3hmQ==
X-IronPort-AV: E=Sophos;i="6.19,296,1754928000"; 
   d="scan'208";a="134907026"
Received: from mail-westus3azon11011011.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2025 15:58:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR0zIOXz2VA8EmRRn3eWgSs9IcZ46GxkdQQUVbA5o1nc9HTgYEyO94k/Zr9DKaaCixOontLPaiLqozTRVd+apS5uMTlqOhWFyoYGjqsxzGWZDZmNHgowuWHsB+w6h9fTEcfyVr+8v3Oplxs8B/34rJGXt1QUKcICxes0mxCDXK4Q216groQVdCr8EhGO/GVmuJDCJ0rAzXtB3aPPL7wAVG5ljk631+6FEwPROYELKpWVJftJ2vn6VJMGdpmqgnkKfyrj0ZqxJZJdl+nKh1POzdFLz5xhFmTNeaJusGWY7NIRyHI6lgGJ9OUIo+6tsn3pSHXoSud4JPKR4oM0/NtBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEub105+DdY861H440FgtuyMJZh3HyYuAkqovZTtIzs=;
 b=kGU3rtbLtqgjT1Bv7Nv29UUff0WlCz+Wb0Qt6xX+Yfezp1iG2wvyQoCcxtEPdp4wF4Ev260nnq1xH43O4MsFrF24n2zzMO+WlC9PDEx3f/Ne114r0seMK5DVcBYklhpYbV02AYD/B8OAUAlzU36xHLqWa0d2Tk31fUQbj2R3PvPs817+qqTaoQGUd5EZbqE9tFYdO8G8NgXGjLNJjKuSoj6WlrY+QDI32zbpo2THXeVV3hJRutz9eW+lMBKMpG31L0DvY3S3wFNbTUVJuknh7XvmM+/qYMOzzjbsvhTHAOSqH1ovYyzwljcFsJeNA4EIgv9REfIBEkwyVK7v5imQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEub105+DdY861H440FgtuyMJZh3HyYuAkqovZTtIzs=;
 b=DMKSKTp+N5Sn7SuBzdZNBkuBxO7rhxckeM6l46pQStX2WcEZQ9saVm8eISg1Vp0ZZdKDNYS/0sI5I5Sob3F9ftnuhF3Ev1JsbO2oRk8XXY3+MqP2C+gT7YTLzSriOjnWoYJCo6kJ1XLEdRf2k2K3zz1qjHcODWOItaQQm1TjKMQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB9113.namprd04.prod.outlook.com (2603:10b6:408:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:58:31 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:58:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch
	<hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] io_uring user metadata offset test
Thread-Topic: [PATCH blktests] io_uring user metadata offset test
Thread-Index: AQHcUDzna4/RJ++lx0mUG8vIH5+XebTtIXSA
Date: Tue, 11 Nov 2025 07:58:30 +0000
Message-ID: <2gns47qyscyfz6bmcnfjmb5p5zgujpsxpsqwip46aktgfldizn@cqs5h6ugcvsx>
References: <20251107231836.1280881-1-kbusch@meta.com>
In-Reply-To: <20251107231836.1280881-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB9113:EE_
x-ms-office365-filtering-correlation-id: 2b8326ea-612d-4979-776c-08de20f81b11
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UjqDM6/gA0/8ORO5S22iI9bvs0SmtD6b7y7VidVZrnXmyKqccQyJn3W2ceqj?=
 =?us-ascii?Q?SEQlAqejUJvSD958lOC1pA2i+7FfDvO4USns3Hqfa0kZv2ewKVUoaDChlQUj?=
 =?us-ascii?Q?KXEuwUmCVY6s5ON9N+rEsfyzzi5FXQgr5jQZC9jr5l2jT4GPlK5YFkCnZ4++?=
 =?us-ascii?Q?cPDRFEWDV2yEyUzt1rIHwbjug9jmtXbz9lI+QbLfSnxjbdUgcDWLxV2MJKu2?=
 =?us-ascii?Q?YNIDzHoJuiJUSRHYexuyruCi6Bq+jzM4cUUMeLHPIklEn97P/60N2qlK4oPN?=
 =?us-ascii?Q?YuYtCbh92Xnu7CNxL7HdtzOcRqAFvGgp20bSvYeTZpEDtihKDtrLpr4kVnkq?=
 =?us-ascii?Q?Pbwdk/QX1sF4XlC7ufQv9fdoqnwEvXGkmwR3dVn/oql4o0UMnL1yI1Zakb/a?=
 =?us-ascii?Q?oQd8D/rs0WSzC5qhF9kiTaMhqZ9o0+vSKh2WlwZQ0IUbuvA04WKv/iWiy7di?=
 =?us-ascii?Q?rPuypCarSd1e3R+xNZUptF3H3PAjCO/1dp53+bmW2eLCGzK+7XYqmxgY1RzZ?=
 =?us-ascii?Q?r8zus847zayudAvwIKqxA77jvm6koHFohOg+Dhs62rwDqGtzqiWnWLlif+sL?=
 =?us-ascii?Q?jRgkUc+ONgWMQLSDWhvtjtOLL3YHTSKrjUuT03yklYWQlLSIe7IRn5+LQ2NR?=
 =?us-ascii?Q?UPhJKYF/SRqe+2XrP7L1QkkD29cjZoFyVU/Il3HsdqT1p40AggW3U+upCk5d?=
 =?us-ascii?Q?G/LulUiuzRcyrL99W5WzOHgivfn8Q6JhYnK5H05n1RR3ANCmahAbtraZc4Rv?=
 =?us-ascii?Q?SWLOz1OGl9xZyWj7bVZz5XHhMslJMznVQkWzqd6wEKllp6b4slDOp2nE4iRb?=
 =?us-ascii?Q?iB1Mw9dVgfM/eCrjv6acMyzkloW4b89Iwb3agajXvcCulS+ixY9eDkH27GKe?=
 =?us-ascii?Q?59g7tVTa8sIl+zT/oLWkykQYi5MXHap3Fw50HJZ1NzkClI2HT4D0QhmzmRJF?=
 =?us-ascii?Q?qG1lZli179yWwJBF2ui/guZLBTTei7g/WnnefzZfVV0UeKdvaQADyV1na/h1?=
 =?us-ascii?Q?WTLDNhBeFJxf4gwhkWF7hJMITv+wd2BXSZhc7yTFiW5mHwUu9oJ88rNopy6Z?=
 =?us-ascii?Q?yKs11ne3fIAsi70QLceoaxvWfLh5DCYiMgKI/+rEuEoGFgkt5AOlodoJZ6f4?=
 =?us-ascii?Q?kjnkHaq2oEXcBLTnUcgrR0RKnWfbIPxGbuhNBGHStvs2/4z8eo4G9VCrS+WG?=
 =?us-ascii?Q?Xv4SP7t4bfu8e24y51/fWv8mAuLh8OPXkuxO8esVYDiJIONcxwSm8Qe5oMLi?=
 =?us-ascii?Q?lDpp4j0s+YLp/zvgPRkkqzUFjlmbh3Upgu501c5ezr/oqzVvGIDcoA+gBMg/?=
 =?us-ascii?Q?sUrTP+VWs+v5zqogqwWVDhb5k7mcZMMFRkrcIPOT/Lr879W9PAnCDR8KzxhB?=
 =?us-ascii?Q?lRT898BRQ8Y7j/PCQldY2Ne1tYFLhBhilq1lPJUhdi0AWCdCf5nqnjJHFb9e?=
 =?us-ascii?Q?01qJ63FV+J1ehzbeh4r89bOsuBxDeTeUYvZVyECd9DBjyq+xG8KgM2Wr6GP/?=
 =?us-ascii?Q?f7gLmEpgFrywFNMy/hJ8Vy3FxI3pMP6lOjy0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0nYaBvu8+J/YvBHEOOkh0vBcoZpmkXBIUbggamgUTNhuqoR5+tUsAKEaXq+I?=
 =?us-ascii?Q?KEqJQ8gTK2SGUsjfv3g34sjjpA4gid9avf/V15AnG7v8DAJTsxDKPgzOWqx8?=
 =?us-ascii?Q?+NXc5X2qxzZQP1gGCHyW3rUhBR5dUtkPVK+X12lZWb/fl8CB3I6niz33Miwl?=
 =?us-ascii?Q?yQwF+/4y2R1y25dGXJMATpZYr8dV/0ykomAL3JYBbxWL8fEimPiJvGAWU4Hi?=
 =?us-ascii?Q?4tU3aHh4Lwv0527kC58knoKJN8Yyo2Gq2OC4Laldk8MpY71nYcQMPPDzEycn?=
 =?us-ascii?Q?WiJyal0iAzidQ2Pkaq707GetN1oUpkJFAHWWWwRURz2HPpIzCgnZK9tEg4DG?=
 =?us-ascii?Q?Ac1xpGvkUNx56ATKGDRSmOULPLhBcBI11MojI5sykrC4am1D1llhrRFlH1OR?=
 =?us-ascii?Q?sqZc40Dm6riuGXchpKnkHxQFg71A/BhOtWw1D3cg1YEl+EUHyr3GNt21x8mM?=
 =?us-ascii?Q?aZy6WbUIdI8tvxE0kfKu2xmqOp/7o8HU5qf1JRNpM9sw4w4DEObEaonqgS7L?=
 =?us-ascii?Q?pgVA+JzGuVhw42nZ3IDwI5otiyTfTrNTVNBZz0Pz6I/3jXDHUtBxI8v47WY6?=
 =?us-ascii?Q?7Zd/4mVSsVDz5r2BpuGsIeSzyqKcSVB7t/O5PLkooJNzW3gPg0BNTFwS+DHE?=
 =?us-ascii?Q?PzxwXL6CERGcRc5uj+ra4CachZCVnE/IqNoJGgM9js2hsq2B7V6cfFHZrxrk?=
 =?us-ascii?Q?xfudHLmFSOjtStWsiteu06/iDmU0LFEaBxR52z6ATRfdXTRVZf1sr4wgyBbA?=
 =?us-ascii?Q?z5vNl7+FDRo2cJDfc85Z46Zm833SyPSrZaLqcVxEqqfBDZ2wlSBCncYLNJuf?=
 =?us-ascii?Q?gspI9s8TDTkKgTulftj/RejCLtT2ZrdcvBuz1roI2Uw+Ej2XGgzE9EUji9Z6?=
 =?us-ascii?Q?CPi+7Nx+SRkOyzWZhN+FG6VHj/NOQxwCBqUArfzYH499byVYu/VMzmpd1w1j?=
 =?us-ascii?Q?/LhFRJL4HHWEOeMQzrWmSssQFO/RBJEApzPyQ/WR7pgFwyh18R7E0dVGB3Nf?=
 =?us-ascii?Q?ngu0rzuK73vXx5OMfJjStaF9HtQy1xpVVCKT5vidnMv7nv+/TUyowD5Jruds?=
 =?us-ascii?Q?WfEP3RdjtX4G6mKxCeNG5KJIbhOItN+13UUBtYtbV/Ef2AHy8lJbJTYT8P09?=
 =?us-ascii?Q?cM/5de+8MpmhTLJRpgGvE/79AcgrFpns8v1nKUthmUFRYT4v1k5PEt2ABMzs?=
 =?us-ascii?Q?aXxoiziQZ+Mshi7yyUTam9eYYlnDM/+il1iOkoCby1BsTVcAIvEtqqz/NiXG?=
 =?us-ascii?Q?yT2URT7q0/qTJiwjR3D7GDbi8cniK8/Y7Ijikz8/NlaP+PWklU7kDCzk8CBF?=
 =?us-ascii?Q?50DKCXATMERQDJlZ/yuCjzGA6KTMOB9b8tvzs7sbRroKzZjbJDS9NNewgb8Z?=
 =?us-ascii?Q?c74ri/XK9T1cBsmKtj7ZHBAKorfcdm8JqL/9NBAhr6RqT6EZTs/PzfiekvLK?=
 =?us-ascii?Q?sl1ZLepfddbzm2/PbYaf8MQm3RVvvAm3dPhT9ti9Sb/INjtVbgwg2hXq7FmZ?=
 =?us-ascii?Q?E9z9eSPqMmlBdk4U0Lo4+0lbx2RWwX+2OrecKM5aH2GLYMdXDtKBetst1FPU?=
 =?us-ascii?Q?PdZ/QtpyEJaIytKJFVmuAnLm7CIOZssrKCXYymlOjVyyoXnqTiRBYv6ifqOE?=
 =?us-ascii?Q?om39Q7xFoWIDcaJD3jrqQUM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFC4A9272314DF42A91EB84D8B08F91E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+I/S1N/1ydX69uy3ZJJLJwLUAoJAIoU6smghu5rLCgmD0LlUyHdCLqmC6L3jSd3VNtMyWZQibToswxOVxp9SAL4UJmVBZJHJG+AiNzUcL9WWtIotU/jpXSFImkpk4QJkUc3sjCxYFy/GqHXdeZtaBoMqYXJZnuQk7+sIU9Wv9QpE7yzYKLHl54wOwjkNkfmuRNxhZ31LZ4UZP1sAzB57XknJj3ddmCxHEOWF5sIHX+ssYeKO8hahiu92FsaU+MTK6HKkx134e+dBDMd6LyvGuSDseT9ulFnN05Bbu5p+QezAaHqbLv1420K0x7tWSH/rTeUK2+DpXsloy91yZl+/qRCvWKXPoPFP2ORKgeQA8ri8am87+m+hJOKRsA1xFnyRA3oe85/md8uYOc50XUyyPEd8Z880iH7fK3e80wqHfGQRM2r3BBvkRM6MDfShcslPPB5X1aUDjtm5yufx9FVqOy3tvx3z1KMnAiN60/qJHppuUkCFA4Gm2OnyWk0ZTc1AXb7lSgGsfxjiFQPUM+eWiq4BgOBLTmfjHxI+Us5p+Kftr1Wxev8ACQ8YTUoRITf55BPLAk4gLdwylAgdsTxhDKB6lJxzqm4HPVEYA0b5ErSnYzjPXSLHAugDgZ3SLeD2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8326ea-612d-4979-776c-08de20f81b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 07:58:31.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dEh2eA2dHNhMng9dkHgnHcFcKP01/xFw60iIjJxUV+iD/7KHaBYm/Y0W3e9w6GsET7XGpKBE2inY72k4x0XHoYYjWRdlDbuPscq0MAMf7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9113

On Nov 07, 2025 / 15:18, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> For devices with metadata, tests various userspace offsets with
> io_uring capabilities. If the metadata is formatted with ref tag
> protection information, test various seed offsets as well.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Keith, thanks for this patch. Looks important.

Just for curiousity, is there any condition to make this test case fail? I =
ran
the test case with v6.18-rc5 kernel and QEMU NVME device (mi=3D8), then it
passed. Do we need specific hardware to make it fail?

   If this test case just extends test coverage and no failure is expected =
at
   this point, I think it is still useful.

This patch added the test case block/043, skipping block/042. You posted th=
e
patch for block/042 last month [1], and it is not yet settled on the blktes=
ts
master branch. Do you have plan to respin it? If so, I think this block/043=
 can
be applied before the block/042 patch get applied. Otherwise, I will try to=
 find
out my time to improve your block/042 patch and settle.

[1] https://lore.kernel.org/linux-block/20251014205420.941424-1-kbusch@meta=
.com/

Also, please find my some more comments in line.


> ---
>  src/.gitignore      |   1 +
>  src/Makefile        |   7 +-
>  src/metadata.c      | 481 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/043     |  27 +++
>  tests/block/043.out |   2 +
>  5 files changed, 515 insertions(+), 3 deletions(-)
>  create mode 100644 src/metadata.c
>  create mode 100755 tests/block/043
>  create mode 100644 tests/block/043.out
>=20
> diff --git a/src/.gitignore b/src/.gitignore
> index 865675c..e6c6c38 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -3,6 +3,7 @@
>  /loblksize
>  /loop_change_fd
>  /loop_get_status_null
> +/metadata
>  /mount_clear_sock
>  /nbdsetsize
>  /openclose
> diff --git a/src/Makefile b/src/Makefile
> index 179a673..7146db0 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -22,7 +22,8 @@ C_TARGETS :=3D \
>  	sg/syzkaller1 \
>  	zbdioctl
> =20
> -C_MINIUBLK :=3D miniublk
> +C_MINIUBLK :=3D miniublk \
> +		metadata

Nit: After this change, C_MINIUBLK is no longer a good name. I suggest to r=
ename
it to C_URING_TARGETS. Other variables MINIUBLK_FLAGS and MINIUBLK_LIBS sho=
uld
be renamed to URING_FLAGS and URING_LIBS respectively. If you are too busy =
(I
assume so), I can do these changes as a separated follow-up patch.

> =20
>  HAVE_LIBURING :=3D $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
>  HAVE_UBLK_HEADER :=3D $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
> @@ -61,8 +62,8 @@ $(C_TARGETS): %: %.c
>  $(CXX_TARGETS): %: %.cpp
>  	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^
> =20
> -$(C_MINIUBLK): %: miniublk.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) $(MINIUBLK_FLAGS) -o $@ miniublk.c \
> +$(C_MINIUBLK): %: %.c
> +	$(CC) $(CFLAGS) $(LDFLAGS) $(MINIUBLK_FLAGS) -o $@ $^ \
>  		$(MINIUBLK_LIBS)
> =20
>  .PHONY: all clean install
> diff --git a/src/metadata.c b/src/metadata.c
> new file mode 100644
> index 0000000..4628299
> --- /dev/null
> +++ b/src/metadata.c
> @@ -0,0 +1,481 @@
> +// SPDX-License-Identifier: GPL-2.0

Nit: GPL-2.0 is fine, but many of blktests files have GPL-3.0+. If there is=
 no
strong opinion, I suggest GPL-3.0+. Also, you may want to add copyright not=
ice.

[...]

> diff --git a/tests/block/043 b/tests/block/043
> new file mode 100755
> index 0000000..0e6a6cb
> --- /dev/null
> +++ b/tests/block/043
> @@ -0,0 +1,27 @@
> +#!/bin/bash

Even though this is a tiny script, I suggest to add a SPDX License Identifi=
re,
and your copyright here. Also, I suggest to add a short description here,
copying from the commit message, like,

# Test various userspace offsets with io_uring capabilities. If the metadat=
a is
# formatted with ref tag protection information, test various seed offsets =
as
# well.

> +
> +. tests/block/rc

". common/nvme" is required here, or the test run reports errors below:

    tests/block/043: line 9: _test_dev_has_metadata: command not found
    tests/block/043: line 10: _test_dev_disables_extended_lba: command not =
found

> +
> +DESCRIPTION=3D"Test userspace metadataoffsets"
> +QUICK=3D1
> +
> +device_requires() {
> +	_test_dev_has_metadata
> +	_test_dev_disables_extended_lba
> +}
> +
> +requires() {
> +	_have_kernel_option IO_URING
> +	_have_kernel_option BLK_DEV_INTEGRITY
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! src/metadata ${TEST_DEV}; then
> +		echo "src/dio-offsets failed"

As Chaitanya noted, it should be "src/metadata failed".

> +	fi
> +
> +	echo "Test complete"
> +}
> +
> diff --git a/tests/block/043.out b/tests/block/043.out
> new file mode 100644
> index 0000000..fda7fca
> --- /dev/null
> +++ b/tests/block/043.out
> @@ -0,0 +1,2 @@
> +Running block/043
> +Test complete
> --=20
> 2.47.3
> =
