Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA127876A
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502293; cv=fail; b=HkepkVrSPBU8HFuC4dNRnBREcwJBs+PgQ3DtruKLw3JR7hNRYwgAhJFfiO5GTIO1bepZP2ZAWelfvJT5hQtvNggdFx87++TVxcikj4vXmEc7Mof/yPw2Knaqk2Dne2x7Cf3St0No05VN1X+mftA+iJoKTfblPK26+XfwAV/XHHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502293; c=relaxed/simple;
	bh=nCgFqnqPy9VkwKxSEMQT2+ZWRTOtP3cqEEVCEb5ej1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAnA+QqJFY5h3mwZSVUrwypwjBmcwT/Pr5Qc2vUMfwXT4eYixcD6ZZmbN0by1kG5pxtwrXC3i1dUdNIC9H3hNM9ZGuEyQEapKynWHyZelRlHoaxxkuK3aeV0QkemCAufbFPZvhr5LWkJoYxQ1LkXR6h3nENq5MKWWE/vovjFKcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YSPe34Lm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dtA0xf1X; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YSPe34Lm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dtA0xf1X"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757502291; x=1789038291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nCgFqnqPy9VkwKxSEMQT2+ZWRTOtP3cqEEVCEb5ej1Y=;
  b=YSPe34LmjILb0X6+NFUdVq8VpSYspMcRJQTQ26pgBGm6MfqZ7uh1qQfy
   UVBU85cUtGk2Lk9K4CYIyJc9mKaKDlDEbRCEAHRqLE39tByk/LFYe1cdH
   UcHQSqNiSRh1Iu0OsHrpb6ET4LfI6WHuJdpxlkRfreRoKG8krFoRHLWcy
   +PruQN4U7yvwxa2fjrIWIT3JcVqG6TY+/EUq6nbNhbV1PXHTXoYgayVvB
   PTNwnB1Ew3XTn4r9ygES9hXC9c0TngNPsQB/muNTktegx7LPkAGQKebYV
   9KC/qnumhcKnen/bdof/9szZIGAb+yvozRFJYwHNgdiS3hjxh8mC3YeoK
   w==;
X-CSE-ConnectionGUID: 1mmfW9tEQm2a1aUD62CeXA==
X-CSE-MsgGUID: M033STy/SFelzDRWOpewMA==
X-IronPort-AV: E=Sophos;i="6.18,254,1751212800"; 
   d="scan'208";a="114269774"
Received: from mail-westus3azon11011056.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.56])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2025 19:04:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCyvHZBAt+sp0g4hGql753v00E90OQ8QwdyCaaE9sRrMw6MdUwPYCX5HTxEXwq+/oYS0aK907fw33rschwJgrgUKa9HUTmB552h6SyXNdvSKaGCsOZ2kEWXmuqoyn2BK8/uzC6856h2A2xt9OnYkc5uw9VYmkWUM/eGtaM7YZ1yK/ezzcwgkczKH95qTxHrSBo/gwqF3AoM87CemTpjwrZw06PhZrIu5YehTuGzuQQ097psI0R0NKAG1mjZej2VKBhhxYaDboMUyj9pNBClQlKdlrDYSagi0kg3kfxEMjcffxYewnxzqsflKyUvUDwWts5mJy4m0gUSElC1c7sHBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCgFqnqPy9VkwKxSEMQT2+ZWRTOtP3cqEEVCEb5ej1Y=;
 b=pg9055FhJVhV47LizCVVeTpC3qSdQq5DMBRAkqIgnLK6it1SyX7+464s+Cz0qBQ6MDyOMcRDnsbC5aU/4m8MbjDKIEuXdlbjuUWJE31JKpaYRgEKqFB3Gc0L9qmy7fA82V8LI6vMYyYsDmUu54t0aKpEbpp8mobeNwqsIVjoSqNOPM3VJ7WVJ5A5GgcdERz+e+tsJ0RGmWY35xqC0rQre79n+bfJ9sTPefVlk1yJiM5X91GoTLtlKnNLHuMucG92xvoXCUKKvVxdAi/TogDeY9zLHqaiPg31LG/AgtCkmEzEyDk/1tZC1mV6WJweVNr/hz1Qj0HjVzREi9VdlnrRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCgFqnqPy9VkwKxSEMQT2+ZWRTOtP3cqEEVCEb5ej1Y=;
 b=dtA0xf1XlUYAdevUbmSEDb0iV2+82ByUmath3vCFt8Q7xr++1Q8fkYNsQfevm4fs1xUEfvTG/ZcAhWdiTDwq5kqdKWjmOAla3nmI9V+jfTvGoUMwABAGCBAanS0utjBBHtZ2N0ack+OB/gIIYHaDXD/1w9/xApxu1X2PJ1EDp14=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MW6PR04MB8871.namprd04.prod.outlook.com (2603:10b6:303:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:04:43 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 11:04:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] md/002: add raid 0/1/10 requirement
Thread-Topic: [PATCH blktests] md/002: add raid 0/1/10 requirement
Thread-Index: AQHcHjgSMxVS0yK/lkCOJm0UIk4KB7SMSPoA
Date: Wed, 10 Sep 2025 11:04:42 +0000
Message-ID: <ndx3ifrheepipf7pryjms3jlskpertkdmkc5mqqv43romormh4@jrezewd67ath>
References: <20250905073804.3981762-1-john.g.garry@oracle.com>
In-Reply-To: <20250905073804.3981762-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MW6PR04MB8871:EE_
x-ms-office365-filtering-correlation-id: 663d645f-9ab3-4f33-5c6c-08ddf059d893
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aF27f/NV+RryEkrn84gvmGmJ0D15mMjFCcloVnWV0OjCcmE+Lb27B6sqQQ/p?=
 =?us-ascii?Q?8oxAEF/Uxr5wyqxYLkzQjQxVpMyDsaBg/xcUL/PPJE6F1rqYdK3lxkNEA0i4?=
 =?us-ascii?Q?QeL4xzSdXX3XUNkYWxHaOqDA/Zwd7iIQ37T9jyt6Itdk/fFXA23YYsWq0F61?=
 =?us-ascii?Q?Xg6YeX/Ey/Xl+ut2uY3obE175YUzIUGrVXqDLTZKwJQ5YBHgai3PTBl0b8D2?=
 =?us-ascii?Q?7hc2kcxr847qV8BskO2v4DrdTH8kqWzrXTurIuHHuoJhcw2W9nGMLOOYBqLj?=
 =?us-ascii?Q?glSJtitZwijLmGNPSyVq4MsvA6AFdRuqGaJxom4GKNrrZZUcvBWzy2tKOFT8?=
 =?us-ascii?Q?ZqUt2ahyrvBB5UdZ1nX5c1VjxucsbzfeGzHgFQhmRR/5qulTbGuJxOvhCilt?=
 =?us-ascii?Q?D6hQD4OPgJk4tct5JaxtgkXAhFyOc81Aj1iOMgHRj5iSE1JPWOdasuKIEmMV?=
 =?us-ascii?Q?NNxHD0aqTGSI9+ZqGWmuPEEqaEKmJdsMEXVJN5FR/JL50al+MW68pAdCVxUc?=
 =?us-ascii?Q?D7a5iHzgv6rTl/sysIDxsGA/BrwNRa3f1FXY2UFeNsm+P+7Rdq3zoZloYd3d?=
 =?us-ascii?Q?YD80LNtPiIuyUweC3WB2/0UYwzfXhd7T2mQlhgaT3QC8///cvslTooM2rnC6?=
 =?us-ascii?Q?mihglwMFx9OnC3DWCY7XCZPTQEBGOc66gBTsgEDHama65T7t3RX+fvIBGuqa?=
 =?us-ascii?Q?hMJW8V3Zf54J1mspbu4L4NPpETB9pLv2/Ie6MhtANerpOad2PvQQrPvu4ydc?=
 =?us-ascii?Q?RznamfTJhldemz/Tuyj2FsgOPH3KOA/x6nhw7skIweoxuqM5JSbNyfzGm1KO?=
 =?us-ascii?Q?ulvtZjN6StAig9h8MrnfsSzvzOYXF27cy762RQ/lSE4NOoaVhhh72MhytYNy?=
 =?us-ascii?Q?knSqIM3hIekuXAZsUyEdPMmClLPl5XZLA1RVeawmBe5Xd8Q67lpWukgON3qT?=
 =?us-ascii?Q?5gVolOYerDHX9Izv8ZkHcQhls3A+Djuw7neiD5+/Kdn3He4fcKNKA713WBo/?=
 =?us-ascii?Q?KmxwxUDiikEQ3EamuZfE7e8VzPp4HrO6GMx24mg8+36MbaCO7V73mR2H3rxP?=
 =?us-ascii?Q?MBYBuGaxNPj637pe+aRAueXCVSll8HtkMaekWc3J/T/EKiTc7x9W2YvGgMJH?=
 =?us-ascii?Q?SSWEqWXYdqaal23+4tkGSQAy/t3DHycO/2DVK9qlB3H7dHiE8m79wbqTiC7m?=
 =?us-ascii?Q?Yf7OqLzyXKa9IsYsXrS1Uv82h7wz9IHxOmPQLPvVxRBqEStlou5GTq8kMLwJ?=
 =?us-ascii?Q?AIfm3HBMtYE9ELcKYwTj+baF8CoF2PRg8ulGBalbzbYG75BCJCIyki8BU0/J?=
 =?us-ascii?Q?VtFfI+SYwCkBpJDwpFkRTiRfBWeQ/2TU5zf1VlhOB21Ydyemqs8mh4SeefGJ?=
 =?us-ascii?Q?TsbkO1tuzZGNJDTl9FNOesWQTFQqFLgAx1Psd23Leex+BT+SzUnOdn2gKXkR?=
 =?us-ascii?Q?O3foyJdcc2bFciiu0yBSWQMDQBQqrScb4yOYUsuXZwii672vlS9kH6c7pa3A?=
 =?us-ascii?Q?rUnIKa0bUvT62lM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uCvWI/z3u+7D5eDhLNqY3KQgneK5NWPDndzgRvSUx2+aVUeaesqoUgCDX2H2?=
 =?us-ascii?Q?REdNHpB8BtUyFzTRCyvOF+KBXdTAt7Z07XVdzudEA7KqmGd/rU6HfySwMgl6?=
 =?us-ascii?Q?sdT3dmDtPtkDAVtjitGlQqQImUBXZ3+WreOY+fgRazWPvK5hDGFs3gGmunUf?=
 =?us-ascii?Q?bie5eDEfbYy9Nr8M7lNM0jpQnQl6AFrr667HlzdqtY8bCy9M9jpaXUsU05Pn?=
 =?us-ascii?Q?JSfjlvMoTBeNPVcnx4DT7smOXJDtPTErjAulJjHu14h5/jSURPWocfNkKUZa?=
 =?us-ascii?Q?aAKfT/cKLlKYLOhCuI2cnQi3FTTh8kLG2o+GEz3cNxDC/JGSVflkG0ViKM0H?=
 =?us-ascii?Q?ZaBn+XLjyEjQrJac92wPHjnOrqmotURFhS8JYMgmUU9cNEeA722MWwioCgQw?=
 =?us-ascii?Q?lQPRleZ04BWCm73h2Bjy4xRmnFaPf0vs+V7YXJxaXh0LYOFOkxLKGh/YhjYH?=
 =?us-ascii?Q?xOlmLzqlboONiykaoyFS4gsIKx+hrzmH7CAaj+AJWIQS2Uw7LaOROV3SobWp?=
 =?us-ascii?Q?Q9fUeZk6OJQyWrmeCp+bJHaZN97bJN14Vxe2sW/XMGBTwS8dh7ct92UtkvwO?=
 =?us-ascii?Q?SLiK9GFApeQNWOedBzfZ01+5gLH3uOBbyokU+BIJrIy4n7We43mWr3rAmbzV?=
 =?us-ascii?Q?xY0Ojlm4l5uCq1CvWCDFTavnbkol90gw9ib40k3LPSxT4Xdh/hr/mfXZZOZP?=
 =?us-ascii?Q?uPtN3DsYM43epb1n+1ZD9wlzenzoB2xeNGCt9jKZk/gsYF+ZGWKKE0kiZ6Ym?=
 =?us-ascii?Q?oIV/DMyrXSIgssVjNPvi9rLSUKepwVsmAsBGSY+6HPfff/KlW5FCehcuxviH?=
 =?us-ascii?Q?UHX2sA/WohZiGj08y/Zqd1zcPsPL0YYmd3K89gWB9ccDVlkOHNe25jDLvmyE?=
 =?us-ascii?Q?sDIg9ocA11narbfuGpDY1lj4GM9WNODd0z0MW7GSbUifiHp5QESco+M6U85s?=
 =?us-ascii?Q?+cJ7Fhef1glODJopRoy0C52rdJBSlmktpGy3mM+MGadvAyGk6xq1emYKw54A?=
 =?us-ascii?Q?7qLimW1pMTCXXnaOAzOJKW4/jJMbb2NHYKQBUqWS0uSTImi4lCyppHr+h19M?=
 =?us-ascii?Q?FD7anEc0SQu/sduU02+iNJ7uRjarg9qtkEmAZ0V3EZTUycYlVaIPPch9biN4?=
 =?us-ascii?Q?SZh7UeI6o/mQlxxI1chFyz62wvCo42bvjkeF6u+48CVCb8qImHe4oDdhUUS0?=
 =?us-ascii?Q?V3SERhBap7LSkV5wRKHQNrL4vW+2WTDsG4ws3pKEePfmfAdzx8YsBwRdQN7V?=
 =?us-ascii?Q?iYZypNA6alN2e5ijOe6Xts9nY+fzpabeOPF+tdC2JMhMNOXcN+JsB4ZU5zPg?=
 =?us-ascii?Q?nPXslAlxqnBfNL25zUL0tk850rh0VEaGmkI0m5CnLDuYIQnw+wpLhmkcLJWm?=
 =?us-ascii?Q?nVKgXCstGcA0qhdQ9Bic6FhIPYqe8dGrmbGjQ4LgCiIfRzPbGV+OO9/HNAuZ?=
 =?us-ascii?Q?YKBTLI/T96R4Uh8URpdNsEgQKL64VzxCcp8s+4srdSTNpLixecpr+wbNA9l9?=
 =?us-ascii?Q?EpOQ++kOWgtpk/WXWEpIj56iAQulSUh0QokkGtkbTCwgf38FUckjh4mheP0v?=
 =?us-ascii?Q?tepIwgfmylukB3PFLWVFRnpPnZDpOb98jv9OXLvwxtwxLCvD7T0asHTyovdQ?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A427EE262EB1934F882632F5B0A52EB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+S+FCo0xasDuOFezbeDvhmqpj58dbd0a0M7wAGDrnkwzPgHFztFLl3iTRG41gkJaNPnjIYIyWNMZRn/gKFVIM+z27NZI3861v6EpmyJBtoDWg10J3h9H4GIb/cvIoUxSidQTdvRy+bcY5lBC91K03s7bQ92jW0qw6sTD9k/7uruQT9fYHbScIjv06G2uKapz0jvdRRcjqZ+NzmFdQQ9avCwehxUzgDggw08ZiQDEXGkmnZZKl6We4UnisxWkjIkLvGYsGaPHHSEsZyC7QoyuVuYArVtsxJPpJhbRACckTfjPTD3l1lJustE+fjyd109m0pGkTzGuY8C9tW3fYRPCj4wM+EA9Pfkq/X9lftRHSSm/ElZZu87jALElMi1u5FPFOnQw+H8h/U93daT+uioqIUTfvJNkl/hWuQPf3811TzPF/W0zJy9g/Vo2RTiNJuipLLFguYEAFf21bSh2xqkEcMBe/FhEoF8235/KA/uQJRbl4bWlfXvtQILVpmqShssBzUGJPzHPnt/SlDA4GAoGJtK3MVqZsdRg6wBcXL0g327eQaGMNnEgPZ5reO7kdZi8bNkOZbLMuemqbp7N3NVl7tIaKtvano7J2H7v1ca27VzB4HwMHPm1T6snMrgI8gEa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d645f-9ab3-4f33-5c6c-08ddf059d893
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 11:04:43.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4igzdE4Bc4Bvuo29GZziM9QrkeaKKs5pzIQqleIh/1WntZqpp3QcJmdTErm3Xo8e0KMyTtGNoP4+UAV92kATWzBxGvMoxy5KrMB42xFoBQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8871

On Sep 05, 2025 / 07:38, John Garry wrote:
> The test requires raid0, 1, and 10 drivers, so add an explicit requiremen=
t
> for this.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I applied this patch. Thanks!=
