Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B810A1F
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754978; cv=fail; b=IQfo7+YVfM1Wnfkf8u8O1t9kkxFhRRfuHpQ0RhBxrS3wPh+EKgwR0S+PNtBY36S2HPdXj5b+KE/I4rMOU/HneIx+Wi40kpMPr8F9i1ITqJxi/GHAb44VXZ/DqjAIboTZYQfW6/a7agniTT0th3wlkhJ0kFFyLFKBgXIedHLeUyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754978; c=relaxed/simple;
	bh=AZSlYc9LJqERKdPorRlwq8mNr+84mCVOT7Djb6TOKmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxnZoCUJ2A2VO2Db29aIDDN6a793QnCGURlvbiZ4jTpCNtZZVRdiDUl8Cue5vk6fSdhegYQ+nB4bMNVSRJ8NodUQUYBOV6HPLmdzvPQibCsHw8dLWI7DCcAbLm4G/Kt8rBIA9jTiTuUn1wqvPo6zoxCN42VP0TbHPpKDlLN+K6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FbHMiO5g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0ESvl0T6; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FbHMiO5g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0ESvl0T6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743754976; x=1775290976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AZSlYc9LJqERKdPorRlwq8mNr+84mCVOT7Djb6TOKmA=;
  b=FbHMiO5g3wYxdTDQ5W7jzx33JAZNCONNzghQzUxRpILU9+YaUmmrunjs
   MkM8fhvO3EkW8S9twUu2956iDbXaucArseJfMejMiMTx4xUCDvPbJNPVA
   9DSdm6FvAZE5V+id/LqjQuuXJuvHq98iljmPgW+ERNZEf9haJc7i0Pxfz
   2vd8iFui7zvRHMgPrs4JhPumRCjpsfAdNbDsbPIX8bJQc92HchUpbUVHO
   vzQW63tlGVE62xcltr22syCBbTMnSMUlylzGq+UCuPwo516l5mODOsAqF
   TZ2hN1kOVioTpv35hNyAQQBbyJ1bPc6mTe7obRpOlKuiS67OX3HFnXFxY
   Q==;
X-CSE-ConnectionGUID: k3zVhdf6T/SaJ57JgWjzrg==
X-CSE-MsgGUID: G4yG57fASnawS1xT1c6lkg==
X-IronPort-AV: E=Sophos;i="6.15,187,1739808000"; 
   d="scan'208";a="73727786"
Received: from mail-northcentralusazlp17012051.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.51])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2025 16:22:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjdR3gu+lkUyRjL3PjMVxru2BZFRaVW0wmgjD/Fw0TUHregbXbjYDYbb6VeXqgwxvVoJiUzAV6MA4M29qOZjHmjGXZtaKiVHnTwFfmLDoFsUbHklP93S34JyxqBWn6QtUrM/ttFnwpciIsoRVp2A+8b3OrRXTWd4YrpUY5xDQP4MpDGN14adtaZ+2zMaxAPIKxzu6WLRgbAdsWzl2YoOcsekfeLWCfPJr679T8mH/P8hU7jUYhiyBm5atSltzYJl7WuDAl1mYmZgLlagTpwoN3YS4XlhoiNPwToNBoEQWSAlmfQwexo1HmHQOgOZWPYX8nGsNerkmybGfOh6nzmBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gwqn7EIpsOIf49u48gQN5rFDXj24l3AiUUFL2wCFUc=;
 b=q2ZI44MKSxqY3mhwpYpMSBaPZRa6RL7haCnevnXjbVsvdqzTAOen7ZRosd37ImdKAu9NvTUQighq/QhjITjTjKNLOenyT44h/CHA1sgM79FFQ2veF0ywrlfm7OZ/XrkG7WCxFLTxJNsyUXdJ/35AIf1U82pC4rb4gBMxxtz1sm8yqtS0IFnitF2tiKj6m/fc2tQIyn6bIn0koiHuU5PiOJJTRmg653pzv0ITkw1K/1++7ZyDEloEO69hPbbnkL2tUWIUklOtZFKq0fGMHTZtQknx/5PGt6M0WWuB/CmdoqEhqHYsk4gUcL02n4zPK/3XPGqU7YRrpyluE5UJKt8kZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gwqn7EIpsOIf49u48gQN5rFDXj24l3AiUUFL2wCFUc=;
 b=0ESvl0T6BWXbSNFj3Uq3MMW/jpCrcK8r/XXBAm9XGiu0VvlaErr4/HSU92Vrl29r5uDHl2q/aUdnD6mxXCWvommCqnQ/qgE5kW3WVmNqQDQYETdxsmyvIWX6TFGwnscz8wHw6fkLj7k3ZJ2vpD65DBbp+k8rOsYKzaWaZ8e5ZMg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW6PR04MB8871.namprd04.prod.outlook.com (2603:10b6:303:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Fri, 4 Apr
 2025 08:22:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 08:22:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] nvme/061: add test teardown and setup
 fabrics target during I/O
Thread-Topic: [PATCH blktests 3/3] nvme/061: add test teardown and setup
 fabrics target during I/O
Thread-Index: AQHbl/IF2tJdANKc1kOKYg52otWKmbOTRZqA
Date: Fri, 4 Apr 2025 08:22:47 +0000
Message-ID: <hwhnca7bznamhw7xqdjcxp3tt2b2ssgnvtigv7kbj5eg6k7kxh@pbakdqqb6k5i>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-3-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-3-01e01142cf2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW6PR04MB8871:EE_
x-ms-office365-filtering-correlation-id: 9c3ee7df-2b28-4240-8127-08dd7351e216
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hZYtgC+x0GYNZZKXayoPyRb4soG1Y6Sh8yOurPpH4j/t/WDuDveJn5pnpyK/?=
 =?us-ascii?Q?jOHUAMqims5wSzbX0kZmWzichMiqrZebeoMiGV/RucQCmXByRXoJ0oJzsuz7?=
 =?us-ascii?Q?jX2CpAEL1WpWgE6NMHg614BBjbm61+pqL2AQr5V317BT5bZwAnS1wn0FoZpn?=
 =?us-ascii?Q?pW66DcnzCuzCx+b4+fg15T1xSfcvZY8UG4lIBTPNL/xaZ1s3erTQp5WMU2ku?=
 =?us-ascii?Q?z3SLUpvGG3WN0biOHpOCZtuRK1C3opqkAIlo5kYx0/Azr9FO/iwNu4LxcaJ3?=
 =?us-ascii?Q?oVFgmH8VCLLw/JWbQMYzZEvtpYJ5gBSyqkrltDOHlA7S6cvgzPslo3JYNrqo?=
 =?us-ascii?Q?usFvwkKk9YnG9x9KLYUXQH6lntI0QqvJBeWl1ugTl0Y1A3CUg8ieZDCbDrCi?=
 =?us-ascii?Q?g7aBr1hiebipUZVyIlnUjMZzCaffO9vTe5EjJavEX+9ylkn4JsslkfYCLLi0?=
 =?us-ascii?Q?ECM/AMo/eBa0Rh+PGj6fB7iY+1kzy5+q0CZbAjBpnzR7O2n7ywWX37BojhVm?=
 =?us-ascii?Q?AeK48aggYc4j5eHzOJ647Kf0aliJsMmFJYrxzV+LUw6FM1Ko8YHdDqTT2pm/?=
 =?us-ascii?Q?KXhEOqABb64+1YqI0gaFGrPFOc/zXt+DPpnN5PD7uPSsX7eSTStDdO50OVAv?=
 =?us-ascii?Q?6MLr9VmJj+bQzA6b6hEombYifiviga92YJwxZNvIEHOeDI9B38kY/BqMnD3y?=
 =?us-ascii?Q?2zODjBRp3xsMHsWF3QgcrahG0Os7/+/2rNuLMtk9b+3sUXXTQM1uJ36LjBiH?=
 =?us-ascii?Q?Tai5nXNsaPGo9PxLVloGGHMLmwFhZxTim1+z8HCj510/Flw1Ri+mdZucQbEH?=
 =?us-ascii?Q?ldGbIW3TCi4COVKGuzUBmqxHpqjT98dRV5Y9gKG6go53qhLzNimled1QZYWZ?=
 =?us-ascii?Q?wkmef17Fj3zC0G8P0ExF85k1vHqhm29OdLjsXZ4kJfT+8t9clwGObFHGhYwn?=
 =?us-ascii?Q?5dg2xei3SaM1q7hNDHEj5HBAYHqBaM1XJ+8NO8vJCbeCIk6EGk2o+BP22n/g?=
 =?us-ascii?Q?Syh8HOiT/lfgSumBsdHXNUZBDpqtRp0J1qzUbS+I6+zg5xQ7Y6mGwB5qrVOf?=
 =?us-ascii?Q?3h8gchNZvy/L0tw8Mp9ivTX3aIiffAm1GTMPWfuMJNDjcsxffdF7pBLoioc6?=
 =?us-ascii?Q?tmsV+VvSMNneyohxK2/qQjWvWSvGhsgFigHiM3ONWOD0FaJAIomYnva73RWT?=
 =?us-ascii?Q?GbYqyqf/TUgzze9QkVno+JMoh9wcXoE4u+XaQJkng5Pez90bSXMtFpGMXJeD?=
 =?us-ascii?Q?7YYu2g6N+gQ4n5pE2l13RfWi69O/cypsMsDPTCOitQBxV68ab9EGPFA/+pj0?=
 =?us-ascii?Q?SCM5lSaM9E+K8mOroPPpYYF91QkDABlvxruj2+Iz6+0gxRicYyQR93E9/IIX?=
 =?us-ascii?Q?OV6WjHtu4cbJkwxF4Sjo0DMxAK/wTXLSuiXa0I0kpDgUc1yZ9mKbTXitk/vG?=
 =?us-ascii?Q?yLc7q/5VH/NfIVlGtmEEuebhpeOYYa9w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VpUoczfyty7gi4nKSqYHf8IDIWiH11ki3+MzN6Ua1X+1Zb9nPQ7lO627K/XN?=
 =?us-ascii?Q?vpkwpBniE8Nmpv6EYnLJLZX7FmrGS19wcUsbleavBmN4OOjQCBCMtafBRywq?=
 =?us-ascii?Q?+ZEFgH9nf3Q24JJ5y+Hqy4mzmFQJC+ahYbkrWm6qP4DPThIxi3NHvSXen+Js?=
 =?us-ascii?Q?1MeEBuvfwyzrUnesexqchCFa4CU3gsILUpokc3SbvrWKmWEBjMoKLhVS8H1C?=
 =?us-ascii?Q?jAnsQyat3XqBtvDhY5TEjJ7f1afuoxTEM7JYdGWHamE7cUuju3flQxvyzJ3M?=
 =?us-ascii?Q?28wQfRXiNVJVtHyrCi/owbhlpy4kvEABPrB8uzwg4hKDZ+OPG4unoO78GCgJ?=
 =?us-ascii?Q?miWG/XwSBiy6wNJWtVBj8JWrQpuqSE6Zb+iXSamiGpuiYoieOKT9+0Om1EOF?=
 =?us-ascii?Q?nLuBH97T3kuTdKXllfpaG6/86oRPiGyWwNGYj5jIM+4QT1pA+sO+zfCGR/QB?=
 =?us-ascii?Q?fVusN+fMw+1V4hkgMbES8wvjNEdw/kdx0km1jYl+YWG+0AFbTJHrsAww/rP+?=
 =?us-ascii?Q?6GGchGxA2CXEE6QX5TQs/7XN4NM9+wCsryZomIXEPVM7PxXOV9k69aA9DlVK?=
 =?us-ascii?Q?vZ+uSw2fh8Gm30lz6xyZQEBdaa/zG1gqYiQezCV/giC+rftFZU709Ne3mhbo?=
 =?us-ascii?Q?s4R1MQJOqgAdl04GOjcKxgkKSyZ++TTA7KWp4ZuKaN3bW2rR17zuqB5TKVqN?=
 =?us-ascii?Q?qFWu2JxsMk7l5bnXxEOKZyqekq8WbPlJ/hDrUH4Ck3AO2jmMeusg0tMoV2Cm?=
 =?us-ascii?Q?mT3ijWkrXUXeETpL+x1oOmD+msQaDza7EEIR4Bvv/neCIfdXRkMSGrSEJodJ?=
 =?us-ascii?Q?X12R1gJLTRyDPQ9jo/M0SyN2yyto8RCUsjbS4xpdEWHlZ1mswjRKy5k6fV7f?=
 =?us-ascii?Q?XspY6Yh3ZYr86iwLgjcFb9cW11hHDmEFNtbL7YLv1rF99xZZehG5Kve9JMqp?=
 =?us-ascii?Q?gHrGC3HCBOSyBcZ4AW/V3CHzamguN5wP+k0ePCvnS9JGVdjguSXkPmrV3qcA?=
 =?us-ascii?Q?peWpZCMGxmsJtrkta3p/zqDnCXGk33YjEkUofDHyTqM7rrueWZd7z/dod92O?=
 =?us-ascii?Q?wqm176NPdaY1hRFDArnUrHF4ezp96t7Zqjgn7mB54cwUgg57AzQKFhlzXoUX?=
 =?us-ascii?Q?JN5k8wu43vinxekPBTBRo69vgSfT5D+10RumEeFhV97lKimNXdMiwradY5Wq?=
 =?us-ascii?Q?ZZyFxl7h/ITco0jOvPb8+gW3pEtJduoIXDPHjHu2LDDJr59xIhSLWGImODTx?=
 =?us-ascii?Q?vZ6ONPiOS+7tTs5kaYAKRQYmKaWCw7gmHWf8TO0P8b4/09lHwRvgNKsiKgH7?=
 =?us-ascii?Q?FHFmu4o3c2PlN0ldXZv/lxxILm1V+37UWTNt3w09dPFyzwahG6xXDEwz9oqn?=
 =?us-ascii?Q?RBXGRIVR9TYfGwzwChvePN9DBCtlvJdNGSuFX1UAjhiDPgjVxqH9a88qnSSC?=
 =?us-ascii?Q?pWX5ijqB5l2pnorMB++VLormZgiIshpafvVI6lPHKQai60I4+GNbWjsk+0JR?=
 =?us-ascii?Q?g8B0J+hC9dUK+9LhgIrvwWhR8cAgtlbG6Iqi1evvPbvhfJsEHkqfAXAlliw+?=
 =?us-ascii?Q?Z9pxxW7j+g0h4e8GZYgQ9PB1ngrRL1vgie8/IX+b9DoktOLTAUUi9N9v8ul0?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65100C83EF4E4345B90A8C207E9611D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iZqPENVQMDgaLjviTKJh8j8rihFeLQRj+b+6NO+AmE9vJBV+oJ0Fja/y7GYUvE0pOYWcih/MSjvRwL7xyHnTG13BCoS08cG+iQUIcyh6JIZewAxY+0RwLAS7cl/wthDRfy6py5ZNls6p2ONB7snrYD6J1b62foafLT9R+9rR3COeSq+5Hd7IOiUYmHqygi1YDCIFHVp4WLm8KJS52YJzCw+2Omf6YczsfzFwtQ1HHmUMW8XJM6VcY/ZKIFsHtbQuA2Vbyv2aRf0sAHbbuWcZV84gkl9dff+QgZNWEFhcnk5xRA5l60OAAZ8HJLtAuqpB1cNQfS634IJQYIOxwcm/xcceZ024+WZMTAXbwCCPGaOtkESh0lE7gyh4CSoBvdDKQXwUHn0virHdB6JAANoIP4y/xZDPRbpmZUWwialXavD2Ge46Ty9Sadx4wCG4QxuV4U83QeJe9zzEZZecTNiig2GABH8VIGQ/dI+lxS0nVG+jBFr0xEvu7vlTpoknXVXzgdBCSo8Fnbq+JekhwG/smHEKi5fs3KFt/OMlS3/xGxyvc/GppADn7MXYJqNKHLsnmgib2BkxNcRU9XtPM+YH6yIe0C0WMrPtoQBthRZVk7F57be6fCmKXeg0xxRMVWJx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3ee7df-2b28-4240-8127-08dd7351e216
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 08:22:47.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkaQihVKRFdTCGGr5ssJxuMe4vG2ZZGLzn8EDI1AA2+wkSVEQNtkFS8WtKYv0fm8HiN0yjsjHpjiIBvlUtdsPLukf9ToIDscIT4Qx0LpXk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8871

On Mar 18, 2025 / 11:39, Daniel Wagner wrote:
> Add a new test case which forcefully removes the target and setup it
> again.

This test case has a few shellcheck warnings.

tests/nvme/061:63:3: warning: connect_args appears unused. Verify use (or e=
xport if used externally). [SC2034]
tests/nvme/061:84:22: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/061:89:22: note: Double quote to prevent globbing and word split=
ting. [SC2086]

When I ran the test case on my test system, I observed it failed. Is it
expected?

$ sudo ./check nvme/061
nvme/061 (tr=3Dloop) (test teardown and setup fabrics target during I/O) [f=
ailed]
    runtime  8.567s  ...  8.896s
    --- tests/nvme/061.out      2025-04-03 18:21:40.829107999 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_loop/nvme/061.out.bad=
     2025-04-04 17:17:45.246929857 +0900
    @@ -1,21 +1,9 @@
     Running nvme/061
     iteration 0
    -state: connecting
    -state: live
    -iteration 1
    -state: connecting
    -state: live
    ...
    (Run 'diff -u tests/nvme/061.out /home/shin/Blktests/blktests/results/n=
odev_tr_loop/nvme/061.out.bad' to see the entire diff)
$ cat results/nodev_tr_loop/nvme/061.out.bad
Running nvme/061
iteration 0
grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
expected state "connecting" not  reached within 5 seconds
