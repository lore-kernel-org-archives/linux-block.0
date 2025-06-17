Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA972E401
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750132350; cv=fail; b=lIxAq9OCqUdltaU08nON6Oeq4+bsumU43JYi7HNCvT8a6d5tP0acYZFVtqxIBlRhq7zK3Pk1nlgnf/mK2AP7Y4R5Rl0YDsv+zkgS77bmnQJiu09jq3T3VDEIaHr2vJIv0Vi9M+8lIh22/g9+K72Edk973nYHAvHeEOPCRxpboLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750132350; c=relaxed/simple;
	bh=GMy68AA67bCTe72QDoKhHd5IvD9ZA/ehCEKARqhXA3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ewqc3IbCFxwbwBzc1YzgANPOHN5h6JyBOdAGM7ed6qhBgcmHGcrkGUGoJ7wToMUA9KnZICT44ukmC5I2n30lKzDcfTDuOGXS5MbAu6/WRQT8OnCbdrFP33e5NKg+nkHFa6p1ua1o/cuBBRq7b9dHALsbItp3OQF2+OuaPtnwg4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LsOaXWe2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MFMINI+c; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LsOaXWe2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MFMINI+c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750132348; x=1781668348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GMy68AA67bCTe72QDoKhHd5IvD9ZA/ehCEKARqhXA3M=;
  b=LsOaXWe2aVm5v99lhOlMwzHVFCQMjiBlfqVoNitR6PqARrbZ20NZxBat
   LBZfu8J0kGIvtPK4W2SYfunMfbEgFGfyhr7naZitLzAilktW89PvCQtvF
   WpZCuwhowC9aavyRhOL42xqLfKcTXKFnViWZagw1Jl1dK6Hz/9oK2sZk3
   48o5ymLU+RPWEQqQNuuKg2axT40sOT3jIJYiwsj8v2x4J13KdAmEQxXV7
   q9716ctEuxw3zEtSBHIZUxYEir4cjvJG+YA61DSr/JErQdpCfOvL+7CPZ
   HcEwDuUdzCaLooEO0QzcLYzb7p33sJo8lEdRiq6CidHOpvH4PrpEN9/hA
   A==;
X-CSE-ConnectionGUID: w00bolxfQfSaCPIgEkCv5g==
X-CSE-MsgGUID: jZUUSxoqR2i47kJ+Yg1WmA==
X-IronPort-AV: E=Sophos;i="6.16,242,1744041600"; 
   d="scan'208";a="89628250"
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.57])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2025 11:52:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw2hmH0Eti+wJgARtx1doi3Qb7UASk8l06oKplGHYXO/z01SHb/lXaiqWvHLsQ0coe4kTG3OiolB/KIC0TWcUb7j3g5Pop5TUMDEFfvtJr+2PM8xBRf6uEvoy0ndCXoHZxl9kqBddS80MI84ojqFWA+vpY+4yIOdtPTj3EdR0PH88OyZy6ewzqYDv1X3P9NRdo2azMw3ntOHv9TEV3GhF2azo2bHPgLuECgUb2Z5BThwb2Uw+B56hdKE+XWBbQG+Iaei4g371cmB43QOmwu348UEUvqGLCQZhrt1vycs3opdOsvmILP002ITwEFlF1ZnqRSZWwahIg9ZHrPtL2r8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMy68AA67bCTe72QDoKhHd5IvD9ZA/ehCEKARqhXA3M=;
 b=gPdNyrMK+3PDO1UE3EjUdm5pUdfN+iXV/ZABUxxHX0nJyFNPIMlcUHo8G0h/tAzpMljiXN8g9BpjkN3nh6f+7hXWF3Xd7ozVQwFfTgmSKnD8Za/M7k44JizVN5pFGOuAU6rlhLCRZkrOrE/UtA3WDLY/rKPhGI9B5f8DE5HeX6hcoyAEtJq9oQnXbsSY2OgYrBDTK4cfyxF8M6X4VpkOzV6nrxgDlGnBz2CCwUMI7KQOU88XrP+QKIhQQGGpIK006umZMzDNuI/JpPG0bhv5zCihtqKTp564uoOCLHerV/9C2F6W8a8EqC7JieS/B9JsMK+TpUd3An2r56x+moNAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMy68AA67bCTe72QDoKhHd5IvD9ZA/ehCEKARqhXA3M=;
 b=MFMINI+cgd66LzBa2oQu5WcVAeppp/sHnMid6oHvQBnpLVhfcxfZf3KN7T5oZVEEIjQ6iWvEy9xQY6vmbM5jWFm5ywGl3NWNMqLvqqsUnAWNVa2Np7unNv4pZ9wKZTjSEijUYSjan5X67IpCnpa2UC25S654UT4eHhjjJFq++aw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6858.namprd04.prod.outlook.com (2603:10b6:5:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 03:52:25 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 03:52:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] check: allow strict error-checking by "set
 -e" in test cases
Thread-Topic: [PATCH blktests 1/2] check: allow strict error-checking by "set
 -e" in test cases
Thread-Index: AQHb1pcBzh8SAflTjUi+qPdGusBQrLP7G+kAgAutYAA=
Date: Tue, 17 Jun 2025 03:52:24 +0000
Message-ID: <eoa35cxhdxtwl4ljlio3x24fufjyvu624tpx5hoenk5p26q6bv@igqzjdsa5vew>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-2-shinichiro.kawasaki@wdc.com>
 <b3d0e986-9e6a-434c-b73f-3801f0e8c49a@acm.org>
In-Reply-To: <b3d0e986-9e6a-434c-b73f-3801f0e8c49a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6858:EE_
x-ms-office365-filtering-correlation-id: 2d1e8637-b394-4d40-9eb6-08ddad525f2e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0GJvHSJ74hdn7cQeTfJFXPpGEs5agcSavL8A7MXUUNKwkakX1cp0BPKSRn3F?=
 =?us-ascii?Q?FkKmDUTBLZRSSjShJG9fQiKE9vg0GQCOcw5nGxxHpj0/zuWwjS4EsCfOqqfG?=
 =?us-ascii?Q?lgUf8yNkNzWSu/sy+cRjat5oP/oqfsvWXBy+j1mAGMfQdO6JyDpvGjyW+E73?=
 =?us-ascii?Q?iyemUTlxNiyIKjHQvM8vPSxgNAuZLYgiBLZecdYbXnrqJnf7wkTLKz/uQ6TW?=
 =?us-ascii?Q?gGRgw0Sngsh1nLJpstursygtf5bmDmzTa0Mv81lLLA63u/OunlCZcqatm+RW?=
 =?us-ascii?Q?ca9iOGCwuQn5jNQraCnyJlA+Mk0n1d9NtZPm98iq7reEZEdWQrTZ0j7GRGdc?=
 =?us-ascii?Q?vqVHmxXaWfb9WfeOOTw8oVx2R2nNshZZoZKEH2wZDlwdm9V/FrIcqD+fgxu7?=
 =?us-ascii?Q?AMGDf6B0fr1A+NlMjRJ+WsOmAXfqWZoMu2AI24rjbfKV9y3BYX5BXzs3wUrx?=
 =?us-ascii?Q?m2T5Lm7yjnALXRN5XL4WCZt9sw3RcItkil00yKyKCaQ3k2InfD5DrQHzMpkW?=
 =?us-ascii?Q?LYk2FNtz38YNchjIwEvxRY7q9uPjDfA1Ij3RgYAjdO5L0uL7q8SY+j8PrRj3?=
 =?us-ascii?Q?PuRCnqwq3bi38/6z6VixdE+hwaeSTLYznmAp3RPA5/eAWf35eNtvun0tPy9P?=
 =?us-ascii?Q?Vq3lO2GcMjKtfQkmnRCRJw/WFQbQ7C/TmiOuT2bQcnmiNqFHhSVwI+T3sCCu?=
 =?us-ascii?Q?mVTK9nsFlYQ6AOj2RNOBvy/zZPVn2gGyitfPFsX1H1hyQUh0B5Rsh/x4SPG7?=
 =?us-ascii?Q?yPkRXYSche9YT9IJuLa5Y/3sI0I8FvZ0K2hhejHIIaEFieC2KMSNuiMGt//o?=
 =?us-ascii?Q?xA84e6YMCumZGBRQ2IZZjwuEJQ7rr/nyuyplgleY5PqX4rzj46NDUeqydbjq?=
 =?us-ascii?Q?5wLQWSnrjfpPJw/BeJ3fsfs3QRBsuSd0kGSAHyuQ3yYD61WAysJNY3Qdi18I?=
 =?us-ascii?Q?UojKKjbhWflPPK1p2LulFPi7/0mIdaDSV73iLNVECv0ro/YaUuh96wW/HpnQ?=
 =?us-ascii?Q?L0vI9VzcD5i32VZ0WqHfzXfUC0Rwm0raKKncZ4y7m9IgD1DwR3cEwk7LEij2?=
 =?us-ascii?Q?fdM0qMa3ogooN6QSkQj1zwrPmTuxQyBaRMWYpt377919uIgYQfYevFF5i09b?=
 =?us-ascii?Q?4mk99wT2KaRw54Un1uyYC6MlDJVqT3PApLCP6PONYAdgMsxImIJcGhulKn0w?=
 =?us-ascii?Q?y1LShVnlppxNCS/Xy6iYg8Df82SYQaKQ9CCe6UFpFl6kRJy8gbkKZhdXZpHb?=
 =?us-ascii?Q?ZzwiTxcg5jjtGyDAOd4Bbl+9csaJxC1A+cdGT5MhcA+81F5D1gtExLJXgTsU?=
 =?us-ascii?Q?RmFiYDYWGaFQubaEB1o8JQZrRy7HYM39Li/vTdAtQPvd8ZnXvitJbxfCeXGc?=
 =?us-ascii?Q?EKQoE5LLPZ63gQ38A3CqR+SrTXS/llrvc8/O/iinIJVtMWW5sp+H9IlsYfO9?=
 =?us-ascii?Q?q0d/N5UOt4o5FuGo/L0SeB2Okyl+3yQpm5upxbGN6g2BmcPSSY9KJngLs/Vb?=
 =?us-ascii?Q?qjocLk5DyHG/6zw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TC6yuKSd+HG1g0hY0G9PNaxpLiJ9y0+VRh92pWurZ2gN/UehYjJ4jqf6Qi+e?=
 =?us-ascii?Q?Qadv1Bpm4uDwb+NOFhRyVGvclgWb093vNF48pfj08avV+qdQqE9ds14ocwv7?=
 =?us-ascii?Q?F08870ZjIlaE7NZIfluYiCTQTfiARkwspJ2tr2QugjFEO584zmZbjJXXf54k?=
 =?us-ascii?Q?jwVj2C7krZ+wX9qu8XJk9o15gwp2/E6yAn08EdC4d5HUQLpq1S2LfMLYP81Z?=
 =?us-ascii?Q?9CZ1ToxZlyMf/TNz0EydnrFQ5rxonG8YrwFXD76j1ZgoVVEN2QxW+qXaHmXi?=
 =?us-ascii?Q?T6XXJ2uByEacPsdcBi0shJiNymKCZ1kigt4zXJ85YlOud0zI+FILDwcE14be?=
 =?us-ascii?Q?VyexYxyOm/D3zt0lYRWCHqFv9Lu0PL5wn0mulqQxvqMg7m4DTeqnjEwtCEsq?=
 =?us-ascii?Q?vtTECGMj8htUt/DB0bg/0QXahzZDcWhS+Vz7kvz9okyzkpCkDzs77lz6hC4S?=
 =?us-ascii?Q?Keze73SO9lrSS12XxHkymvhvTJ1yk9KVozv4GvM/EH7725i740w3RS31oIAT?=
 =?us-ascii?Q?KIdzcZOwCVV2HDWCFlK9HfT+ywnPzfYJiPdmJ0rOo3e2m3Bs9dPy9Rrp4tdF?=
 =?us-ascii?Q?xbE9qaz6XrSVtPRCA27Z7FPSH9F7OZ5W9TlKgEKgR7gL9meAtm+2wiDdjrPo?=
 =?us-ascii?Q?wFa363Q2UbfQeU5QSMUSe8fCA1OEaSeUrkmRziCR4xuIhqY+itAnK1euN95U?=
 =?us-ascii?Q?Q9rOeUhQ3rIhmYbD2k4VSK0GU4tDgxxJiZLOm0CbNiL+OB7bWnrx+RavnqWK?=
 =?us-ascii?Q?duqaYKK743csyVrsp6NlMCuPQIcdukE6IE6sWSeLuoewyGU65ceCwKbD9cRx?=
 =?us-ascii?Q?6LbYa9psEfesKrCmM5iwzTCvrFGl1yK3G002UwbsH8EdCZZHLS+e1mC+EttP?=
 =?us-ascii?Q?bO0O8mbnOrZEuFXx2afslfkegGvBHoOQT0imu5pt0iQLoASY8Nml44LFFkxH?=
 =?us-ascii?Q?FAkuy3GL5IV6RZ0NewPoAT92mmYom82RvuHBWJHjT0xk56aWb3Vv3ImlG7kj?=
 =?us-ascii?Q?h/vrHKYhGzwxSE9UCpGlyRrytHLZf6aUl2AJ76zTwGoU/mahFB9/J1J/ozxD?=
 =?us-ascii?Q?ONaorOLhJoleRmA26Z86Yv4MXUy0An6xCj7OeBeYlH5vS4cGYiH8FrFA0Scl?=
 =?us-ascii?Q?jlWtn0cjb3rOJOllG8yi4jMHa+V5clssjmCuSmUl/cvsgAlq+BhR/TDZaiFV?=
 =?us-ascii?Q?XAx94u8xUd0CVT7M24+9uZdOeKpUra9wGlzIPC2joIhp3egGOSxYCbP9+zUa?=
 =?us-ascii?Q?4hPwayM/ieXZlV8oqr/LRANG+/ipNMzlo8tOQ5qxpXOhHFJUrUq/5ay59HyJ?=
 =?us-ascii?Q?GZ/PZg9ZrCyVh1lGIBwUxzzzFjYuR1smE1jQbBEK66ONR5ewX8Qqu5hdcK7A?=
 =?us-ascii?Q?MCEwz92Mscqfp9x4m/sYNkPDsnzCQ57A9JrAyd86OMdM1pXC8yqihDSaAD5j?=
 =?us-ascii?Q?Vo39UYXdz+PN/6aq/14K7wxk1WRbzIuFxgXxQJGTbM1ZZGf/dXe5dyOnHJzc?=
 =?us-ascii?Q?iOesA3d5EKKx8ng37OQV8pVlbWOyy+LBSLJbSXYKsKBgVzo2SX1swTm8Sq6G?=
 =?us-ascii?Q?fGUD2/WVT1OlmCS64TQ0oyQkP0fLDLcR8s/LBLge6lJWnfO7aPTCogO+4yHO?=
 =?us-ascii?Q?IKVmNL5truXbOd+luEjL6Sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76EB76334A27F74D86C43B99A6C70327@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Olcw9olLtdnfCE+s6zNdHyjfZEQrU7XijqPSB1mrDoY3cO/cWb+9IJ8VuqjDUcfoYrZc3sCEOtxPRPePJgeqdDKzfrWlF/PT8Y3X4Jw+q682tzxlad9/Og4zOiJiIKw1N547tKmFmZFUxfZzb/N2Q5BJNnReTq8c9oUjXnMD1wX1IbkEaFqagHdimLx5anUiXZl+ULGVWZc7F88EV5tXYxpxR1g7pKCt8An+2B4oBoHbLwAmESruvbIg0zCO/bWOyIEGdJAW2024tNh1RuP++RUG6GW+rEDAzDYJOfRq2zJetekZdVye+jXK9nUJ45YtcZC2THIif6341guNuexH7ZXj3x89x+NwF0MA/Cw+HjcZQmFuLZstbpUpfknfjJIzsYRrxwT5G/qEyHm+1V7Rj28TKxMNhcyPJfiXcqfOlpfil+gDNfqQdHq5lmT+ykM9PU0HFx3J9YUOJB9Aw5L674dXTDUVfjkoo6ZY+1Txs9e/J1JTgiGiECnBg6shT6T+1hpAcr0IxuwYxjBcoej0pxt5TzJPSEfhGHpG6MT91b2oaRObVpm9OVB9CN/TE688funTwjnNBVj9TmkgGn/1h5Yqv9Ne19Aw4sUioqSBUApUZsDODlmBzFpcZ38Sev9R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1e8637-b394-4d40-9eb6-08ddad525f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 03:52:25.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5NHo4a48s6EjgwIGXRnN/DC2uVa9EtJo5L1RQEkbwg5xE4YPRoaErdl0/BuqiSKLHx7k/q27p0uro5IHjjFPOJlBLXCO1GhlXp9sT2o/R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6858

On Jun 09, 2025 / 10:33, Bart Van Assche wrote:
> On 6/5/25 8:56 PM, Shin'ichiro Kawasaki wrote:
> > In bash script development, it is a good practice to handle errors
> > strictly using "set -e" or "set -o errexit". When this option is
> > enabled, bash exits immediately upon encountering an error. There have
> > been discussions about implementing this strict error-checking mechanis=
m
> > in blktests test cases [1]. Recently, these discussions were revisited,
> > and it has been proposed to enable this strict error-checking for a
> > limited subset of test cases [2].
> >=20
> > However, the error-checking does not work as expected, even when each
> > test case does "set -e", because the error-checking has certain
> > exceptions relevant to execution contexts. According to the bash man
> > page, "The shell doe not exit ... part of the test following the if or
> > elif reserved words, ... or if the command's return value is being
> > inverted with !". The blktests test case execution context applies to
> > these exceptions.
> >=20
> > To ensure that "set -e" behaves as intended in test cases, avoid the
> > if statements and the return value inversions (!) in the test case
> > execution context.
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

FYI, I applied only this patch. The 2nd patch was dropped.=
