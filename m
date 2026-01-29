Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83632B9A0
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652454; cv=fail; b=fMh1QJKPNpk8RGQKLQhwJV5/ntLYkVKx/989FCtf73PXOUzcHOLzbp2NFw1gVN3/ZoBNKOUqqMe5GaN4ln735LCoOrTQ/iqGZ1WpA0/IGOYmXzdRvdNUsA7QLGfEcwX8mkte5SKFR8QAeQOk1K8B+pbKIR53n4cI3LViFflR6Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652454; c=relaxed/simple;
	bh=5rFAJdnevU3953A8Tr+iIEJcPrFutHqCRWkS8vVFy+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIUR0p5pp1W05bsqZSXetiXPRFheaHlrNG7OiKZJgyRUPMa0eSup4MFwXmeSygd6QsNbZj1njpH/pQrF4xB73UouHVNWHPxwWOzQQc0IzEfuYoN5HV7XqWQH/TBq3iUX+R1TEJQTLi5iN9ib/sFNHPKN05z/tLj4q/l1D1/SAQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hG6O3bEk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uzSoaWVL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hG6O3bEk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uzSoaWVL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769652448; x=1801188448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5rFAJdnevU3953A8Tr+iIEJcPrFutHqCRWkS8vVFy+E=;
  b=hG6O3bEkW4Od/AEAVT8sZKNoutNEIB4pm5czzeCycELMWHe0iRsgXmoS
   2ehJeJ9sAVo1wM+A15zmFwOJxaqSmN6cjY7CKCe7e6O3Jrduit9Cbwbb0
   I1qyhlnRv+JECFE6PZ21v5XJC3OK5Bg+od7V7bKXxlM5nz9yUbq8NyM4E
   8WUwS4pSCZQ0ZIiNtwcDzr5uy6Tu1lwI8Qd4HiAT7RLNOS0Zn7la6jY1y
   7MQDEGfiz2Z/Me05kOGphArwAYGqbt4dZLNP7fqXj2e1Awy/JJOLAZwx/
   xhUec29UaIID35mj/9SP40HVfQ5no/ARt1kQ+2VJEEJa7sEVBq3brh8Kq
   A==;
X-CSE-ConnectionGUID: sJvwJkogSBC0M+Ytya3nAA==
X-CSE-MsgGUID: JDO2wUYrTZysfj4HlaLY7g==
X-IronPort-AV: E=Sophos;i="6.21,260,1763395200"; 
   d="scan'208";a="140330797"
Received: from mail-southcentralusazon11012047.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2026 10:07:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZVSzSUyfIieDTse4cYf7mqs1SekqhyKhqxdH87yTeKiWJNCQs83J7tVkd+OzQ1wnDceaYWeJ5vDa+EcpxOoMMgQ+7WIs9RnUy4pMNBW2VScFx0ElNwYFqB9FLENu1SBDWbnpesiLYJxl5LisS6m9a972SK5E9fOETjLvGyMrUcGj9VUKw4OeVrMRHPhHFVReUDxm5hQ+8MywQLMUAIg+w3eHdCpIztR4qFQKXKvkJf+f9uvSXJ50RK7lQ1fSWdM8LNYM/UgEubSGips35WF0F+eQg/XZMl3h7KpLD14464cWAyd+gektQlRKMAajsU/NslqUhrdLkH3ZsbzVuhJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsftSJMoz90c9338SFmRLJLRsy/gTQCucJsEBz3TyZY=;
 b=fhTwv04p/iSmiVI80PuJg5Nck2dlRZx8XbxFcvp+RO5JiV6Q2XOyvER6VhabYsO4vjhPNELnhazgdrp8mm28J6StKsmB/ttImhOyZqzcebT7xtbbkB1OmzmQ/CwIiEJgeEYUpkVPosVGS8y2Tg85UytT7GRGrnCtz5YgZ7JdGCZLcfE7Y+WUl+05EXKn9zrQL6uxtzAw6dgsAqdN+eNTlgMxDop2a0ewWfwI4IoT52JzhTIXPryuUjjlggm42rYkHXCFscF2ocT114knpolm7LZBYwin9v3Q44UKCnVzGZM0HhCoc05UDnp6bP9p9vSeSQKNRM+rTbmEXvbfOMTjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsftSJMoz90c9338SFmRLJLRsy/gTQCucJsEBz3TyZY=;
 b=uzSoaWVLTrDMXtihi/MFFywy4k3a9Cdup2xoJoVkyuBVwWTGl5KLVHjkFVj7Da8rDS4oiu60UriZK6l3yQAVCIA1P8c0xkIRStNuueA49GT5IxqHGnPGuXzoiK0WnwAU+i6rQkZv6EzY2FGbppstWPjMOE6Ykm3QSCsRkEFpxuw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM8PR04MB7975.namprd04.prod.outlook.com (2603:10b6:8:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.5; Thu, 29 Jan 2026 02:07:18 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9564.001; Thu, 29 Jan 2026
 02:07:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: Aurelien Aptel <aaptel@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>
Subject: Re: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp zero-copy
 offload
Thread-Topic: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp
 zero-copy offload
Thread-Index: AQHckGrZnE51mDmEGEGmNgL6Luc7GLVoZyUA
Date: Thu, 29 Jan 2026 02:07:17 +0000
Message-ID: <aXq7nHT2FGEIQn7B@shinmob>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-6-aaptel@nvidia.com>
 <a19ae203-bda9-4034-a1f0-7528e942d7d4@oracle.com>
In-Reply-To: <a19ae203-bda9-4034-a1f0-7528e942d7d4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM8PR04MB7975:EE_
x-ms-office365-filtering-correlation-id: 733302fe-8b6b-4330-88e4-08de5edb2105
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AVQpqBC0c6MDumNvFzXhfYAoq3ImZEa0wCAamizt1VaHUnlLE34N/huSRv39?=
 =?us-ascii?Q?dtKnGAAZYGNeVummNluUw94jjC36ALoCUNlrNNmmjcNlzOtU+ydFL/kkGrdG?=
 =?us-ascii?Q?XJlQrKpEP1DwQBY4Dk+TRwReON/NMrvqwliSB13QrG0V3TpcflOzYkCYTh+U?=
 =?us-ascii?Q?eZvmaGdlKRqjfS0/7Y/AxZF2E0R/mMhZT9kVF6PPWrO72qU2SibmgcQPjeEd?=
 =?us-ascii?Q?LtgT35hEQGtjMPr45DtQ3H1ip1punT0ZVQZUPy6zo8bkOIpfnQwbeDuCeM84?=
 =?us-ascii?Q?A6sMvxw3/dX5Nxtqm6rRqHX/kzmO6Z1bGlVz4NktUIZ4WQxJqzJ+JpOENZe6?=
 =?us-ascii?Q?+5CwGXyk3FNW71/96WVhMDsQ9txlxYK5prtqaJE0s/YfblpeYQmZIoOF8Z9h?=
 =?us-ascii?Q?uerUiZfCmSfsrkQnqfGymEX1wlE3S4bjlorDGhNbd0tBx5Syo7Oy0ODlzc8A?=
 =?us-ascii?Q?xq3aVRMmdVpVr82dix0+j8/pkuKIhfipktMY6D9e+TJJ6WLPEz+vykwrLKuT?=
 =?us-ascii?Q?uQmPsjKCnPx4XiNH448pOxTI2jzSoHrLWQljubJqVivP2MOCr/kEa4ePCEXr?=
 =?us-ascii?Q?EK37JLpwGYjY9LnMkA8tMwBxkqc2oBJPSsacd9FSlB3cCIJ/rdpiosjJP9Hj?=
 =?us-ascii?Q?s4cOMsspuqdMVrhBO137W9LRLM0XLtKBcqpa/2mVI9T7sWge8D/pjENJntAh?=
 =?us-ascii?Q?YLUWUYE7Xpm0RQjzOTwiBPBBNLA8lT2QJuR6PAXFA0fN+JOpP9UCEsApwDw7?=
 =?us-ascii?Q?mG6ZSfVofv4GHQs8Ezv5yFQGJBY5hAFszNDfpwYw7dCO7S6ZKMEuCbddpqyS?=
 =?us-ascii?Q?XKNq0RaRZXagDKzLvyGFRXQCgguwUhmZ4YiTxbv/KXXOMLZMgv1ObxOnWsAM?=
 =?us-ascii?Q?S5CJKJZw/n9cHZGE3yROZ/xXPhc9qgwN5UrIBjka4eR10oZRSmnjNxBy1wPK?=
 =?us-ascii?Q?fOKs3Ru9oiD0KQ8hrJiMAlX2cQBgJ8A0TaGrrr7zrU9gp65loCIs4oKm4VJ+?=
 =?us-ascii?Q?2GYgTv5lmf8V8KSDFUMeFCHI2rs5FJ6nq4rmWhc01Ln+Vyd+IFsC72uZCWK0?=
 =?us-ascii?Q?YAdSSLYMAlTQtkHlRPvoOoJOij3TCGcs0N2GbTs5xmUa3cLsL2FlV/LUcv0N?=
 =?us-ascii?Q?p6E4QLNOAbvIj9TQRlpannWC6NLihdGu4L7R7l9gHE0ezY81KyXUM3/1sE7C?=
 =?us-ascii?Q?67rpLyUQhtks0gcbXMEGLFMqOkssra7OY+fTj4WD9yipAv0qQYXIeVT1MZEU?=
 =?us-ascii?Q?Pi083JeG8ozduI7zYIasaPW61k1JSOwYGOOBHgc2UBj3B7TaOT1KwvW+ZNxd?=
 =?us-ascii?Q?E5CbUDa0IemLINiH5sFg01HXfpstl3d54+WAYTk+qQlf2ME/bfOzZTZLnnMo?=
 =?us-ascii?Q?2nUSAzzM5rtNENBaekj/7iNL4etwzoAp+7ywuXYud+hEN4FzH10kaUQrqB5q?=
 =?us-ascii?Q?t6VRBFtopCPilSSnksepehlNOaPYo/Ll47g4vTV5FU3n+2iOwo/Y19psWH5Y?=
 =?us-ascii?Q?4l2gZBtGyKuGmuksLJYyReuRN3jwHBIfDXl8UPE+9QCtAPLts5eOlNf/Ze2P?=
 =?us-ascii?Q?tAphMN1tunTwKq7UMWG9kWiF1LPAQZho1fdsDQofTd2Kq0hv+jGjE3RA5Urt?=
 =?us-ascii?Q?SdJeoXa3eEHpTRBdgl5dtWsz6bccjSpaAhYSYMm9R8ke?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tgaxAOZnuY1gHeI2Ev6hkoGjUnCYZLWfcGAJpvGW35liGZEckTflqZgYcRWv?=
 =?us-ascii?Q?4PohL2m+GrFKYlrCesqsjT6mzCsaUxMpx6XzkbGQHEWLRUf0En9hj+OdkMFd?=
 =?us-ascii?Q?KJNrSysT2Qy9PgDPDPwxGpeAvnenmfSOC+C0O1OyDPQhsdE0avNQf4hJo8Wq?=
 =?us-ascii?Q?z5G7KRrxTiMqzs/oV7bAT/Z9laHLJFeF4D09dow3o+2woQQnr9rF9+cvn6Uo?=
 =?us-ascii?Q?vb/RSVGdCyFxtdw62+WwHq/dxEe/nFqQO/zdux++XWfJmZvlO0ippgm7zD5f?=
 =?us-ascii?Q?uaXsRNVViS/asCPSKimgx7DFcnvN3qsGvk/Q9yQLaTrHL6Jzk5VY/5flGTP+?=
 =?us-ascii?Q?0ojD4Wr6lV6JDYFNLOL3SVYwbTWa+9FBJan96PhIu0TNc3JefJ6T59lWcFbi?=
 =?us-ascii?Q?6C5/17l9086Gh+S/JnRYpYtIZI/qKiCGN7+15TXMgON9oY5WGgLtNCLYNCDU?=
 =?us-ascii?Q?z0XqQzHnLiM7/7dHmg9JWsHOzdUFJkqis/uF6pgUATKzjQQg3YMcnMkhRDaL?=
 =?us-ascii?Q?5psl8SIKOQfJllKBcUzoFTCJEGIPXF3EWpf10hm7K3w+wMVNJGLywnr7Svqp?=
 =?us-ascii?Q?RctWUL1ccL00LknWQuCdm+R2zmwTqvric8SdUoKHkjJPwXPBYLociLKccIgw?=
 =?us-ascii?Q?2r0lzUsk3pvRF70UbRnRF6wasR7aSt5zWkDXbXA7UEVM2f+peTwHbvEaiwr7?=
 =?us-ascii?Q?bsDylbQN5jcHFNevvd2bJFy/stml0vW3nRnkRu4CwuoFNatD/iU1jCFDk+ZE?=
 =?us-ascii?Q?5wYLy80J/BR/zvDQOf9ihDibJpCc70iFrgOeNyVlpd/3RA797Y4p/CDT2fMd?=
 =?us-ascii?Q?5pC66D3JNa3kDD0hTIvIeGz+bgCrMK99ccnYsVam8WemoEZ3Es2jSOzOAzmL?=
 =?us-ascii?Q?MmMtxw3cmUGAemshWc9QzhhKF3XsvfCYunBiBMQ/tOvz0NZEFgMwikUY2LmQ?=
 =?us-ascii?Q?ZJHuPvWWdsrrv6Bl2b3GqD9QCJX1vNQvM+mQxdUb96qtXpEdLMm8wexDLSNj?=
 =?us-ascii?Q?/dMluN4BaK0D6G1w/6Zzhg3zTKT4xHAyNvzpjr2s9OT1S96Cu0EQvJtSE9ef?=
 =?us-ascii?Q?i1vP2qQcDRqRrfKcbksWeO/uwvztpvJrbk1rpqln5bmR/HuOR73uQnfnwbjj?=
 =?us-ascii?Q?i5j1J+xuObxHAAo5dOj8L90ydvpxH7HKS6C5l1N3M9JeV3z75zx9DHkfmSaz?=
 =?us-ascii?Q?WgGvOU14z1oblyLdjiIhrzeWY9Ju7Msnswt8QEvszhEcCaMCDCnXw07632eU?=
 =?us-ascii?Q?yRtzYSL90RMoew8ngBwrtERqwbW3UEGHqyK6pT1yDrcxtmZAYEqfuOikQBNk?=
 =?us-ascii?Q?ClnkzNQvMryECVcAOQaiLFYuQaCJ24REW+vTFthhzS+qiU3GH5sSGOol2i/p?=
 =?us-ascii?Q?uEYVXP8xNo/TXVVB2NuLyimb4Khrgm9uk/MD46rDKJggWYcgm3Wm4A6VH6X3?=
 =?us-ascii?Q?5E7hO+74zWCYf7rMqlN+Tg2PRbZxfFvUwA/NzI503+9E3hLlhmECPjoRCkUh?=
 =?us-ascii?Q?1kHtGVBUwaiRir4qW6XhAOK9eVdlvjKHBjs0v9qjuSjKc4+lwH5zGQLFzh9B?=
 =?us-ascii?Q?64l+qdbW4vQagF+0uSl5KG+e5ehiGbjRBks/2ybc9tMT2lDF/HY1U6gwaqZ3?=
 =?us-ascii?Q?vH9ucn+SW3dWLCUUx8gDb4nGhzAP9Kq2OBA8YUyvb9RbcQEMhP26X4o4568s?=
 =?us-ascii?Q?RpXdPVfbXHiEh1jYiqEFGKSjImmoCVpKb3qZP6unsdOvLhxVgFgAPbY3fKFl?=
 =?us-ascii?Q?NJjd9/Hac0Ofzp1aJUZvyDHWMidH6nc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <069816D038FD0C428137B9FB4C8B5440@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qBHHq89OQlFspz9uTBucaD4tIVw0d2xZA6JHlPym57b6NzAlUBJsz8dr8yJ9B4soaxcK2V/aig4oBKn52JO87V9DoPpik2/LXSjntY8/yOfsu6qa3CXOmgOk+Ja/4iazMgGFHFCqlDVSpZqSa2LzCq7mh9JRIH0WY6gxoROAKfT4tK2PfC61g2ADk3CJT31BU1amEYmxLxvOz6hwNQTpj7o51OZSm5SNfssgNktNaqfyYf1z0jbjjhIBMU3GDTTFB9G4cM0N2XBNAAhVrpt6mFdm6kX9vAHiSm9HocHef9C5cb0aHJrXxno6BJRgc5o+rwyoannVSyqZf2N+L8HbdE7QnGha3hBH2yt7z2J2uxT/YttPoTr4FKMwwcf2YDkX6NiNSx/C8MSjX/TjZ6AwjZZQG4x0xT9lXlhMtWoW70APZsFOJQvHlGM7sWWQ/c3PCC49GZOsE59TpWnaox9yAoa8U0juQmp3kethDyXeeX1enVOlvUggfUNQdbZdhPBKugV3C+LyCbkTfNMHtg9jqVLz+RIwXUDhnhSADIlTbgMtTKPngNZdf/r+zmpbpLm5MGByDMBAc1I4kNtEqFIwKeb8V1l1tEU1xc44KGYaiMtdjDzxlKCTcFchPH7/FqQQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733302fe-8b6b-4330-88e4-08de5edb2105
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 02:07:17.7840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqAfYbc5AdR/4JiJVQYk2fZGeJre8ZMloAgoq1YbwhrcMKL6R1VWZDoeIPOq0+izUFNwQyVdlYu+HqtZ1I/uZIa30ByqhEAXM3Aa0WqZpq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7975

On Jan 28, 2026 / 15:28, John Garry wrote:
> On 06/12/2024 13:51, Aurelien Aptel wrote:
> > +++ b/tests/nvme/055
> > @@ -0,0 +1,268 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2024 Aurelien Aptel<aaptel@nvidia.com>
> > +#
> > +# zero-copy offload
> > +
> > +. tests/nvme/rc
> > +
> > +DESCRIPTION=3D"enable zero copy offload and run rw traffic"
> > +TIMED=3D1
> > +
> > +iface_idx=3D""
> > +
> > +# these vars get updated after each call to connect_run_disconnect()
> > +nb_packets=3D0
> > +nb_bytes=3D0
> > +nb_offload_packets=3D0
> > +nb_offload_bytes=3D0
> > +offload_bytes_ratio=3D0
> > +offload_packets_ratio=3D0
> > +
> > +requires() {
> > +	_nvme_requires
> > +	_require_remote_nvme_target
> > +	_require_nvme_trtype tcp
> > +	_have_kernel_option ULP_DDP
>=20
> I notice that this kernel config option is still not included in mainline=
,
> over 1 year later.
>=20
> It is strange to me to merge tests for features which are yet to be
> accepted.

When this test case was added, I was aware of that the DDP offload feature =
was
not yet accepted [1]. At that time, I expected that the feature would be ap=
plied
soon.

This test case was the first use case of the blktests feature
"NVME_TARGET_CONTROL" which allows setting up nvme targets for testing in
flexible manner [2]. The test case was useful to demonstrate the value of t=
he
feature. That's why I merged the test for "features which are yet to be
accepted".

Said that, assuming the DDP offload feature is not going to be mainlined, t=
his
test case has lost its value. I think it is reasonable to remove the test c=
ase
at this moment. A patch post for removal will be helpful to confirm consens=
us.

[1] https://lore.kernel.org/all/2537c8iv1kq.fsf@nvidia.com/
[2] https://lore.kernel.org/linux-block/20241206135120.5141-2-aaptel@nvidia=
.com/=
