Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08702319865
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521418; cv=fail; b=GcKh/WSbr5OC3DVhYATUSqpyoae78XVt9aqsr7UFLhgUxVm3tj50Ndhw1aTjoGK1eKWkCqZUBQEyATAm6x/5Z4Gn/VVMiBFIzoC/3kyMEZn2fRBY4+FnYq7Geu8djsW3LT82lFVifh0OHNQ8NMKy1tzMkq/S272KMBuSBylfO2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521418; c=relaxed/simple;
	bh=nUtymLyskKikdDBHZ0m0EjKeai5+0EhxWNV+1sWtAEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RbAi6cQoJHTNDMuex9Gu+Qt/UVgJeDM0S4tWg3+GrOC6N9ng9Et4vurSRN4eH4c+mUH6Y++q9sKU4jKTqKraRwz75RgM5TBuATybFyktsB5lt2NBuNZvwaJ77vmL6I01DGD5IC4z6ZkNlW3iyyBcUfldHdnxrvR0lpLYKurDcC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FWVJ/3Ba; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EkL7mOpP; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FWVJ/3Ba";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EkL7mOpP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760521415; x=1792057415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nUtymLyskKikdDBHZ0m0EjKeai5+0EhxWNV+1sWtAEU=;
  b=FWVJ/3Baive8zSXYyCzjMYoGkJUnPWiTWxZ2Vih8bCrZhO4q69dDRVz0
   +z54lDgwRcDWRj6tVktb/BNOpwEke65NlOrEgJcEJwtZHB6EBsqrPmKcA
   DW+E83giErYwibpmqlLcgr5d/oQKJSDvpCt1ZYw6yjJgQ4COf/QeEE31d
   EntSRssOwly6UQFiVKc29l/RF5HvWOCN9EvAROfeVlP70SxlmVtjod1v8
   Ngw71LRbSlA0tryAaAt1STldyXH3z7czjfbuXXIJFBUljUG+SleN+p3YW
   xc6hz5M9fTFcfnyG7Keim/8/qUlMdYuqBZXkkHzFcNEyLMDnppsXh6EBT
   Q==;
X-CSE-ConnectionGUID: uRFM/GSFQqWcUdTyuD7Sig==
X-CSE-MsgGUID: QH9qRwFtR9CPYRyxr/ZIcg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754928000"; 
   d="scan'208";a="130262236"
Received: from mail-southcentralusazon11011033.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.33])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 17:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnfBkUNtvxUsjxfLBgUkPwEdKfaTHkvgmsQxVZEoyW4PjP9uFcyBtOKZ3U2IXQz/Lqk6QsI+w6der9i3ZSZJWavUGrqC7kzhpyXsAsmJJFlTM6W3FrRJ2cltY18E+xiQS3pwGGievYa0N17Ra7Xi4WVggdNduSiyVpkUpx901kX4YXuLYlD3GvV2EoLO0bHDH7hAxkOIblJ9ORsRCcFCSO/mp0YJmYVAZQvjqeTEkx/pWOrIqzbvzE9BSsze8uxXqpsLZGanQ6e4Cm/p9zDeEzptLtECjzDqCMIYUGyDNPMVhDg8m5S79+3EGgILbcgz4eyhtB22Jb21pFc1rTtuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFCBZv47+xU/NKwHob+gy07jQcGDpmWf9Hj7EY58YqA=;
 b=QjjkXgqQAK+hALLEt8l9hpXqfHAfMcaqPqeORWJ4jSdgvEQDh8dDreNjp1QZMXWP+I+pHxAG64Pzq6wCQ00uZmJNe6WAFk+DDqDCGkLSucfk8/64HN047xaxxLbOvxDps2/uQm5HNmZsamz/NYYV3DAFdXeyow9THHKtwZxOigpPy1WD0VQc8oQYWS8/B2OF99CRUtEyWdKMesnm9OnzGoE1Tenzm+E36SVq0JOsVndw/hbAuKc1+MA9uFy8Pg+wQ1Rq5UtUeerI6XDxs/0a1VGeOFTNRMC5zq1CugBzSnpR/Ded+x/craoF56F4JPMREQNzIiCwF+amjFVDxCs+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFCBZv47+xU/NKwHob+gy07jQcGDpmWf9Hj7EY58YqA=;
 b=EkL7mOpPEmup38tsOb69W+n+Dn6awLxL/t+eiKbUod+V8agZ1Zztt86wLAxLDV3aWVVB6cQbGGSDSsA+sQMqeqnT7Y6oY9A+5EjohYZx26Zt35MfIezIXgIUVrBikJy0bDe/Ph8LUCmIFwxDD21vRC0vJTbQh2TjL1yxX+cpPWM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BL3PR04MB7978.namprd04.prod.outlook.com (2603:10b6:208:341::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 09:43:25 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 09:43:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Dennis
 Maisenbacher <dennis.maisenbacher@wdc.com>
Subject: Re: [PATCH 00/33 v3] cpuset/isolation: Honour kthreads preferred
 affinity
Thread-Topic: [PATCH 00/33 v3] cpuset/isolation: Honour kthreads preferred
 affinity
Thread-Index: AQHcPP2FYW/K6d9blkyjRKmwP66/S7TBjvuAgAFnVgA=
Date: Wed, 15 Oct 2025 09:43:25 +0000
Message-ID: <pcsxpsr7q3wylc2dagr2y7aupiljkz5yut6dnnpxjy5ildem2y@baavojpszuwa>
References: <20251013203146.10162-1-frederic@kernel.org>
 <720e46cccdc88a111ba7e93c9de457ed20d7a8fedef8852db292adb63d114d4b@mailrelay.wdc.com>
 <408ef850-e0ff-43db-8827-7c756cc7490a@wdc.com>
In-Reply-To: <408ef850-e0ff-43db-8827-7c756cc7490a@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BL3PR04MB7978:EE_
x-ms-office365-filtering-correlation-id: 62f796c3-f430-4e6e-c183-08de0bcf4999
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N+f3Ys/DB3NbYALp4A8IqJP3whlKlIhegWyviXWIZvhCLQidMrYDluQ9jg7e?=
 =?us-ascii?Q?7N9ov6oB6+ym0MgEMAdi79II+UYElGmcYzb7zRvSOjzWLz4/FS1Kmzc2mOrB?=
 =?us-ascii?Q?lYI0JqYwyhWghkm/4n38A5jBy655qBmbVD3WnRB7udf9Lwytsxz0SaqZL2QX?=
 =?us-ascii?Q?mDL2BejNl1Nk1g52asf7esStf2yTh1XH91jdqFFF1yPRREkdmusAKZrHNrUm?=
 =?us-ascii?Q?UyLtavGe6gV5Wxso4lPFCw8xSrj5+TilV9h2c1QDs1tb5ZuSfZtH6RHXGNhl?=
 =?us-ascii?Q?dI8XkmHj26sSg/bIi8iTlgoJEQbT41VskQTaFrnNh7nRiDPZgq7qZsMTbx94?=
 =?us-ascii?Q?CrPPqPzu4uYY/eEEiral2bFZTopUqfPAYHEOhGv01bQbJPk4rClqs2ozrWO7?=
 =?us-ascii?Q?reIEKOzZOybQeXOzoABWjgrNVqU3c394/DsJ4LFy/L1uaIR8Z+61YRsJyrek?=
 =?us-ascii?Q?NJDP5L7gnOC8cUiNijqLaGaRlm5xsCUQ/A8y5h9JSSxGGngtGQgGBB53EMkA?=
 =?us-ascii?Q?b3ErQA7kP+javpoUFOZVzqKsVr5egpnwKs2/IRsxosH5PYvPi4aAmti/pND5?=
 =?us-ascii?Q?6t3VEdiRAxlNNXeIuOHWpaloYFbjNkfIwF5FIOccm013Re6in/Yz1n8IRcgK?=
 =?us-ascii?Q?ywi0yZotywDymh1cyoJNHI9iE6UgUXx0qFdJs91jL/W7brnjtVFXdaVbAyN+?=
 =?us-ascii?Q?Njvar+xX8/kABu+bxIQEVDEN8eaRNAv+dEM42nOTw1cHmzbWjRHaMv2ENc66?=
 =?us-ascii?Q?0gtL2faZe+A1qrIZ3KjRGFF+TnuLqkcbF0BtETY5hfVvMI0uwoIdR2QCsbJg?=
 =?us-ascii?Q?XPXm0a0k6F8GbVBUDD+7jHjwGPlpnPAiZBF8gnIm/uNtXfGEy2k6UmGH52Ni?=
 =?us-ascii?Q?sy6B2nj3kY8rGJ7decZ482L22hkFZnfU7sh4ZlwopEwQ/e2zxJZAQNB5TS5/?=
 =?us-ascii?Q?uf8xbCb3rVvOel1sJsv/YqyWITVKFcp3N52N0rvHQqe/gXv/q0JoKjjkfwSZ?=
 =?us-ascii?Q?OSDEOHfoe1siwF2xaWWszlcXH4iu94RGOpP07PzK8tch9smogpXfnSUDjA/M?=
 =?us-ascii?Q?nZKs+aOSt5ZdZnzpRLLq4lPfCJ0XFnRrM9IQiw3YWpN35xwFJSMDM4YhHFyK?=
 =?us-ascii?Q?ifixRl/8FLLMiATO8ymWY6rmYJafTSCtmOP77upfb4yWi3W06Wfqkx6gNURs?=
 =?us-ascii?Q?fxDlEjGAKeBVrbI23vWIlMoXZg0GuHQ3H/u3rPOfOvRWxJrPXIFB6mdbZrq7?=
 =?us-ascii?Q?Q+B3nZvwKVDJiHJWCD6Jn0x/xc4R69esYIaBBXOnQOiRi9C3fC1sN0sdWfcA?=
 =?us-ascii?Q?q7KwkJ2d3SPNBEE1GHkUtNjns6XJyklSiIoZOP4U7+WPicUTdlwc3XCTHDF2?=
 =?us-ascii?Q?hkKsa3Y3SfM6Z1O+25PlTFwP6/xBMAO5eaRcIE1O5rZ8m8TtNEmNNZ73shg0?=
 =?us-ascii?Q?UdUzRo/4d+7+hIryiH0pfQFcsBD6fs1HK/p9XcSk3DUq1z+SI8/CzktPCZmH?=
 =?us-ascii?Q?veOlEIQwSouiefbpdkm8RTK4qaz3aYMQSpaqy7omSpakSsUdmAed0aCdZbxU?=
 =?us-ascii?Q?2S/5lzY0O7CS+CNmkKI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9XgLpwdD0d2V7RGThofZXUBPDIDJIiIOnQWWLI05E+VIp2XW0uHAiU1rS0Rf?=
 =?us-ascii?Q?rHLfRgMaIdC/sKO4/ONHebVteeiOBEDwO+r+09GOTiZb8Q1kBEeHpgJoJyFx?=
 =?us-ascii?Q?OIEiTfmx2+v2Z91FqbYYK+dm/oUk6Nw10PhJtEPEJd5Utn4Nk9ol6jJc0WA2?=
 =?us-ascii?Q?WU7noZOpiLpc4M20AtbgGfv4uWO32L5PPKPeYl1S62QmtkwqbtXWoKUMXyZ9?=
 =?us-ascii?Q?t7Ee9Hku5iaO5rpUy57ERYFaa0m+6uKaOzkV7kPmgAZMWh545NimCoBHU5Yy?=
 =?us-ascii?Q?FB5+DI32ecmtH5jqJlEyREGkdjGI8iv0VoNItMSE+xLV02TX+ZWHaTHGnBxt?=
 =?us-ascii?Q?oHYPBgJvW5A0SGEi8PW0tmLxyJzEfbnizKsdan4lCoxBB3ib+8zPvt2jS7rO?=
 =?us-ascii?Q?xCWSCcCOwr7oDXz0syot7kjK8vHWRESbKH4ym3Rzej6wJ2ihmYIrCtawtt/1?=
 =?us-ascii?Q?Ytbu0jn78G+naOP3FOijRlwW520lJUIeplIWs7/DWOBAJaEMW/AMhhi5Yogz?=
 =?us-ascii?Q?u+TOdzHwFpYcQwqrbP9FEgRrOdCOZpR8F6KlxkSqqKBjBYsvHZTxe1z/qyiy?=
 =?us-ascii?Q?opKuj+uFM1F0lfHYb0Hl/GQKgDIvNkIVAjc75/HGGVD/JFKw4iM87SANLTnZ?=
 =?us-ascii?Q?fAmdqinqeLbOviuT3k1bK6Xf0D3pEGPw9q664ygOurQyOwc1zOYrOWuhcMDs?=
 =?us-ascii?Q?tqskXwOGQ5yoBIDjS14QSUILBOyr7VzwynLwCjLgGVBo7ELASUofxGHm4IQn?=
 =?us-ascii?Q?KSLb982Xlkbo5uN+5PYKIeM73Y9Zr3c5zHV0hqyw5VmjMy4K7rirddOSGB+s?=
 =?us-ascii?Q?N1ORVPYQzHvZlps2udj5x5Wscyh7pcT3YRGLOVEtZWqhhB2c8MpVM+3Fk04H?=
 =?us-ascii?Q?sBUiieE1h2vn1QXQwVbrBShdce2vAeX5FJxMIuFX9DuCjIc/8di95fq/LyAB?=
 =?us-ascii?Q?+9Q44zeaOT9u2+1vknbNImdx+YYRXODwX2f1e9jpqzl5NTBYV+dKKimTYmzj?=
 =?us-ascii?Q?keEnCxFTKLetzHQ8EJ1cdLMdZsNNAdBVN12KbWBF4rUWvCu4/TYIUSq+PCuo?=
 =?us-ascii?Q?/uNZ/eaYcMPQ/cXrkCNC2G1opsYfi/Zgjj0NL0sVrh3dy4KBy4F9d5BJHvnp?=
 =?us-ascii?Q?MaYgO8Y5itd7VLnm2E17myxkUGYpcXQudrsRfNmJtxRW/Ls+nvTHK22ns2Pb?=
 =?us-ascii?Q?KFy3J/EvNpe+POu9jED5LE3MNEhof8Y+1RlV3NSmeJj7cvarnrzpHwjnD2PS?=
 =?us-ascii?Q?QfRy80m4uELWGORXh/iJp7rWAakGYlie2IEhdk7ERSzvbR7tYt/cBARQl7Uh?=
 =?us-ascii?Q?gJLw45d7nVrGTYZ5c0JT3nDzEhF3hk7cdHBG6xasWSAfouyE8JKy1dlnHh94?=
 =?us-ascii?Q?eg0tKQWcld/bYpBa7wmyKnSNCxV8Bg4W+agOvQdmVLXL7xEVTFoxwUdItE17?=
 =?us-ascii?Q?xWBVAwf9QWrBcE9EKrahlZhD6SbCw2opZoSMuIekmxHh/Ql+q95ezBnLMsGx?=
 =?us-ascii?Q?2thJf58UnysYr0ZPD+2CuaS9VTpV/GG87yipHysj0xFTvVzMaC2M+9WGpe4g?=
 =?us-ascii?Q?M159Zk8Aa/xfe9Lm8acSdRubjkGqreoNxFh5fv4t43luI0hIZDfl3hiJZzvw?=
 =?us-ascii?Q?wQ1ER8OsUvkwIgLYLWStwKM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D11602B8F71E140B99EC9773AEAE4AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QV2mGOGjtjnXdnGqX0tPbrzCgYowbLNbEACKbV4KwHN3Mwfy5fiHUQZ3vvNolOvDVYqWbF6RCL//PdiDI+OYfLe+vTxhEd3ACoGtJqGojCZX6O7X0JqgtuuUAWdZ8VjoVdJzVgHPE7viPTovqAHrNGLSb4ud3cVm3+jyN7m7Q7Vu0KBNpQVrUWqmZB3PCPFfmmWMRBIvphV6WOSOEAWaiYKb6jqo1VhyJ3PGQ/o5qM9re9s8MIWkfudjuq6zULW5uIb1/BFlNOcETQhg8+zyhUufHLrTB7HucdRn2lLKNl58WkPLFke4xZ8PWM2Mi+WN53d368RI8SRGZe2vqjdI8oNozp6OoQyUWZXoX91vT2I1BF4R1hYLU0itPqzXBxG7dw21BKm7R12+1r3tKxZJuvrmAKVuy36IqfGfXg+zMK7/df+1ePmcHnXZVQE9wM6HMe3zOB8XNLR/aCD81NLhY/1/UsIdd+nWnA2KGUjBNZGBrJ22jtoEuvsZAhr81uTzviQ0dLRox/8sHm88YPA7CWclSI4YhlzIFZ9+KFFawW/yzSWqaKOgjJKF2ir0P+zwZNb15hh5VZfqQQOz4O3m53tvVnMsQha8ONbB17w6P6vJJu38z/nQjYgUuyxkA8QD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f796c3-f430-4e6e-c183-08de0bcf4999
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 09:43:25.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMG5pN4miVfi7uAUTgl582iwzmUsamftLqV5yTZFM+LHcSWqwupD7z5aA10oekAo24k5GS72YqY7Ozo9IJ/DQH5ZqX09HI71K4arENStPb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7978

On Oct 14, 2025 / 12:17, Johannes Thumshirn wrote:
> On 10/14/25 1:29 PM, shinichiro.kawasaki@wdc.com wrote:
> > Dear patch submitter,
> >
> > Blktests CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [00/33,v3] cpuset/isolation: Honour kthreads preferred affi=
nity
> > Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?seri=
es=3D1010948&state=3D*
> > Run record: https://github.com/linux-blktests/linux-block/actions/runs/=
18488587693
> >
> >
> > Failed test cases: nvme/005
> >
> >
> >
> The testcase failure looks unrelated to me:

Yes, the failure at nvme/005 is already known, and should not be related to=
 the
series. Sorry for this noise.

The failure happens with tcp transport condition. I will disable tcp transp=
ort
for the blktests CI test runs until the failure gets fixed.
