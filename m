Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D124199FAF
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705407; cv=fail; b=FaTI6l2qO7uXQcXaPnNfOzWR0nNFZxrdQcBmmZUVTQUYr+OFYBFmWjpHEcy0wqRu5ZcdrHaCYmAV+Ssg6oYoIMxv3SK/RhRzwr6L1HrhRR70GgVImhmqtjnEhsB0JOevCQ1hmeN0gGLWkVoheEIir+iebf9qz2FD5Ii378OUzcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705407; c=relaxed/simple;
	bh=WFbW2EHCbrajiteRu0WcbhGvNCQWfq9Zbo1Oc9ViKKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8aOb+PYtxaSZymlwa+Qdf7qTLyLblivLcGR9QLOW7nLa5U5D8O8gXuvX3sQZNZ6qlQty6bb0bM0FE3FhR74Dxt4VvO0s7/9zWKVa1UvKayRa/DUpO5mtCr/SHVvpHSg9ZDwgaclst7MUCjFpfSV31RC/JXbtvZCgziS9NF4Dxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BJhJYCwt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uewfGmNi; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BJhJYCwt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uewfGmNi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749705406; x=1781241406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WFbW2EHCbrajiteRu0WcbhGvNCQWfq9Zbo1Oc9ViKKQ=;
  b=BJhJYCwtVlMJ86DweGARBzAWQVkKnjWVChMtR2DYnaVMzmBYy7atCGo8
   VAdZq5lmC8HDDFXGRywYGiBV9Wr9ejDoe94JEmnVwYVl10TZ+hU0+4pOL
   kX5wmdhS1cS40wxRBKJlNjsO/bzreL/K3G0PVmsssgbAJLLVYnOpLZuCu
   WYmQQs0RoZbe6q+cGugZfrdkTr3vmXINZXpQzSa+fdbTL6GN+j0pR7JSa
   VEA0w8KIB5mrx51iS03nMG9ifNg6KF9e2XfRUdBsEIZyebJ9TdGyUlDHP
   2bRlxchJQJY9paAEXCgH84GGkLU7ychiJ7NZqgraBiYBOoRLZbowAM+j7
   w==;
X-CSE-ConnectionGUID: FEn+ljxhSYKpZD2DxTG+pw==
X-CSE-MsgGUID: 67Q/nCRjQ5uOgW2KMLhgvg==
X-IronPort-AV: E=Sophos;i="6.16,229,1744041600"; 
   d="scan'208";a="86432219"
Received: from mail-dm3nam02on2052.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.52])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2025 13:16:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7C7l25BSEo9tnM8JzQMcgrysYiKAILHIPZM17mogz+SsitvsPLSqbaQSCfQs7k0ZxtpZ02bsvABNbhaUcfS/rDWToJKOnra1FeMaIRy8mprrsXqcAw8PdMPbyeJ0Um8Ukzc9S4N969/+vLqCa0+LJ0kBZUvl0UbIWL9JTM6TZdhj07Q+T1XRUR0kfTRvSE4jpPVTWwCB8yCQvLq9fLHPqq/TaVfAibg0OoJ61L2U88S/+TKRQVMZ8KF79LgsmK5QyHKptk5IBKaE8sfvdZVG05cstzjRWDCtkAmKBwN520x87GxZCFjmIzXR6+3rkKTDONSy9tFZ9aWqMzSeKNOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiRDfPPSkCVBGCjklf1OpKGCCiPUGFrPSLaAdH3HOFM=;
 b=qi524PNU0iPL1HU9IoApD2CRGI1ulo1XldTxcpruxNx1w7qrlYJEdeH+DgcqOLX9EramiFvS3nRtaaMX63xGk1ouhFusQDZE5EQU6F1BbBtup8R7b6cwpoat0Jxb9QqgEfF6+FwJTegv7mZdvN6rZ//jR0IPlHVfB2O/H+ESKt1+VgYhRp9FW04Ez4vY2CnxJ6Ba+mVmmPJfJ20sAkq4EST5hdYPS0oC371JyKFfdIveEdu0w4JAlY7bgHHpDJGKO8ROCDOCZ/V1k3ZmhuL1MFlbYXJNVt/lBFCm8ATcpqqlSoBcNt9XcGqJ7df1MsH2GCOIkL+HkB1Kpm0rrIhurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiRDfPPSkCVBGCjklf1OpKGCCiPUGFrPSLaAdH3HOFM=;
 b=uewfGmNinvyJDfNXRQv+Iw59IEfF2M4xMBywiLjhq7q12SxSL0FaXclus/d0CDrwHyb0D3QV4+zlqm7NJK9HZIRJM9scWZ/FbX/JYDJ3TXw5NoLsBn6YWMHYxcTgKwvWib+ThIwplI9iLl1LakF9jjU78w3WSK6twYuouNdkfjg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 05:16:43 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 05:16:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Topic: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Index:
 AQHb1pcB8XrHg5kcCUm1uP/dxccmtLP7HeuAgACNQ4CAAOYKAIAA5TmAgACtr4CAAOEOgA==
Date: Thu, 12 Jun 2025 05:16:42 +0000
Message-ID: <f7uik7sjmi4ta57auekhlzv56p3enab4mufidfd2mrk5zhpphc@tsvmhjkbiyvb>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
 <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
 <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
 <3et7jqzna2n2e7henrbr2foiopjqxl64pqxaadszrbmmuqorei@xinbpunqb2ye>
 <b36df65a-1b59-4c03-8d6a-d0a90729ad7d@acm.org>
In-Reply-To: <b36df65a-1b59-4c03-8d6a-d0a90729ad7d@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY1PR04MB9561:EE_
x-ms-office365-filtering-correlation-id: bfaaac64-c0f1-44be-9ea9-08dda97051d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pftgdmIa5OHb0VBF/mghvPbyPhi6AfXaxuSA5em8OKWfzLdnKn6dufYIhQXj?=
 =?us-ascii?Q?2o4gfWADVtZ3LgAlG1PJYpljvgGN/WRWGNiUx9Ka92XGJiGNS5HOv3BDELai?=
 =?us-ascii?Q?mB8P8zu1aEHvmOe8vZ/DOPqGLfyXMDCQJI5KrkOda5PxvK9GFLW707wPH8w3?=
 =?us-ascii?Q?t+1KJ6+ZzurBc6v5Lyq304uZ1x6YimtMZB1GraUVrAH5+t1k9JFfXWq4h2zu?=
 =?us-ascii?Q?YkeA6tIl7qaxPzCHTOCnuAFhV/4YcJ9AlG72rDBF6McT3DwU99CNCClhN5A2?=
 =?us-ascii?Q?xRUbUpuViLPaQOc0d4lDYO8AUnapIcCWaGiwVAPz4uU06rf1PI60R0fuMkIB?=
 =?us-ascii?Q?B1rXVgzmAuAAlNW8EvTqbQgAqhTg6fVoRJX6f1yL8RxYOTDa96XFCsHx3rL1?=
 =?us-ascii?Q?/kplZrvxBUDeJBm6sIucnJV4FDqqAS+mmoUd+orfuOYQjyT1VcZhUvUntGDb?=
 =?us-ascii?Q?whPp7dIVr8MfPAlCvc398zK0FYgLrqmKtcKySV0tFuI3M0rzg7TDtPgFl0Hp?=
 =?us-ascii?Q?bDbivTnDBWuK3RTwPjjaAP2cerNzd9xVY4rN9/QU24JgPoC5LoefJz14IyqI?=
 =?us-ascii?Q?u2pLwvVDXq+6ACnXoKD8r3k8KewxKF0Aq/fdRlomAx5tvOoKUaeWGqFdbNQP?=
 =?us-ascii?Q?2ITqopASrlRzeCk+5uSdpcaw1QttCd/1sifT7DcBqxdcYNp6+L42375yIFvn?=
 =?us-ascii?Q?pKYhNqsnII8RRzF1CLqDP6HajZ+dTH9LID2W9qsPdZg0whBeu+L2UyLt8dvC?=
 =?us-ascii?Q?wJ4OcE2kOjNQvRiXAEaLmFKcQEz1WutoQbZNCQiMe34hIVc8Zz19yHeWy+2F?=
 =?us-ascii?Q?YW+jMcjneLiGR4O4MBKBzV1MHATlbVU/VDmzvemfkGwUsk2ktciyMw3cfzu5?=
 =?us-ascii?Q?4J85lwtXcyUZBE+fkDOt5STh1NilcYO6EII2pkpBQ3yG+CiFKhZq6VmXqHl7?=
 =?us-ascii?Q?RrJ5hiyj+pqxn0gaQNMgw1agOOyw5tbp6+zTSmhOf23CIkAh55zIpCxWrxkm?=
 =?us-ascii?Q?NCvHPdOQLxyY4h3aGtpY7cAy02LeWfjsB9V0RLbMppI55jGodEuCAGhgc0i8?=
 =?us-ascii?Q?9lGAjENdRiQCu11+XEehCxIqxnkq6OlrBNR+9OaP8tuX/IpCH5tujWgIwThK?=
 =?us-ascii?Q?JpkydsxOBzRFpz7nuyaRo+kzGouIauTozAc6dBlzLpfR4xjaavD1UWG6rLll?=
 =?us-ascii?Q?/v/nMETO3T1PukWC743ZRK6zUZZVgAaTj4er2yOCAwLNnENZULCB9/rmS1Rm?=
 =?us-ascii?Q?E3Y2AfMx3CKqGb8IaAnaD+EfVd1WLnukSs2yeeTMlcpG1WxxhM778EIihyHo?=
 =?us-ascii?Q?NWCjG3jyv2uiqmdoiNqNP6eJdpY94t3VmM7qcMa6NF37sfWMjA8PWXSRxVQl?=
 =?us-ascii?Q?fr/XkEBEAHQlDtknMO2zcLcsI7dbigSfJbZeumqtwtimkwK4P3eOwT6aEC2U?=
 =?us-ascii?Q?ucETQc0gLZCSj83k9fIAxCpPfGqPggbUXOMqTdyRisp9CJ25Ou71rKK9souN?=
 =?us-ascii?Q?V3z70W2kfS2DJPfv+3TDs9Eui3s7zmvoz+f2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PaKq2m210v9qwR6gdUHic4c9rYGdt81gO8iUBr2KlYPlM/661dXvGhArCfMz?=
 =?us-ascii?Q?X0Xt/o8HU/dHue3L2pPfBOvUboGUmJtlJxJywYluL8Wjh35GHkX0OERWOeKy?=
 =?us-ascii?Q?3yqaLgMz44dAyW/wSQD5+RLbtpPAjFFM/GSatOLY4d6WKZmsDrRp5RmLzwBS?=
 =?us-ascii?Q?YwJS65SYFYKtpTsLCH3kZE+Nc1Rj6tzYGdTNkddshr7q5FRCx8BekANb+awC?=
 =?us-ascii?Q?BDlv/1ThudhRCD28b4qz8pwBYc3p1VLI2zSbWM+cXFdGC4ECNaewnsg/MPk/?=
 =?us-ascii?Q?fS/ok7kNuzNGkUn+ooxe5B0Gk6nKfCJjhKLtR+FbtY30kRWG9Fb1e2hGLgxO?=
 =?us-ascii?Q?NpYBkd0U1yn5sLYL1aa1e6C0u3fMJG7pN68to7afuTd6OsWcs+Nln86aYTSr?=
 =?us-ascii?Q?ELEyAnXmCsI7yq+g/4ncg06nMCVuHtSRzkjThflF23Jl0d7Tp4MHnc/d94UI?=
 =?us-ascii?Q?LANmyDMJ5S2vO4Z3tlq3QvGepNWa0R7gKn/bhiuVleRfogXxmAxFGmIz9xxm?=
 =?us-ascii?Q?4cW9H/PG9vle99+xLsJpI5ylXRfBB8G8omXgr98GwE8YKrfnVZdTTzhuhDGV?=
 =?us-ascii?Q?N28L/VIRJy3T/XnnKXrWhkTx7ncDM4CxnP1lM5a8FYUokPxpswa59/LXUNsv?=
 =?us-ascii?Q?dnjO0Ax40FRJXwQCBIMp+QWzuZjDcxYTxo97rZ5eP/45kpXImwaXY20gOgmF?=
 =?us-ascii?Q?1idkaH/6gumTiHH4uIyl86sSWm7ZKweQheNt/M5rgfS7cgfWWS2/1MFkuS8J?=
 =?us-ascii?Q?CEZ79Nh/9pPEB57iz4skokVdSNuFfbNqBjgTosU9vA3YTQW1hkx2VsFdKfzF?=
 =?us-ascii?Q?nVPJqTJCRUMIcqmC9bDrMagdR22VrtMvLKBCrRw+Ix1NuAKiclTZc8qfFMB6?=
 =?us-ascii?Q?uCck1JpQTg8jcrXXIPPWkPinclCaRNHkblpT8/XRE+oD9jD3ujVE2KX/y3DM?=
 =?us-ascii?Q?3XyuHoWBZWWMQJToUOKE+LIpXXAjNiWKXbyMqjh+TKDBLF05GX9Qzu9qXLeB?=
 =?us-ascii?Q?SHB7cquvsHae3sLTQpBWING8oDLRjch6b2yHYqCzHuqpdcwjhmBklb8/I4d3?=
 =?us-ascii?Q?Er9+2NZE7xnIs3nsC6XzcPz7t+UbdNx09OAXCICAh9uQJcW/C21fIM61T5Qo?=
 =?us-ascii?Q?JFtMP4PKv2XhDRM3/MHMx6xceeO467uEzuIbkfD6p5zw0jJtw0eFFlPhohdS?=
 =?us-ascii?Q?l0RjySiZpsgSACxu7kV2r+LZkhxkrN0d4bqW21ZWtpANp0ipPpJsVU7h7TP+?=
 =?us-ascii?Q?M5k7Rc5UswOPYUrI/A9RoY2tw96Hp3WCd7VHloCNPT/DFMPryaMHWsnaBItR?=
 =?us-ascii?Q?G7QVNeSbwkuHEc7suFqTRXRKfb9Sg9dNHsD8QSw3eZWGDgOud0SGgTN150Hl?=
 =?us-ascii?Q?GdmJEEC3u5JbB1DaTOOM8QmHwivMdzU3MLMfnrEZGOykILyIJggQBk0Bh5xu?=
 =?us-ascii?Q?6bJ5b9s6rbYYQaIiBnWER9yCvSSLonmqlOZ1WVDH5b9ZRWPa3wtiDVl1ek4K?=
 =?us-ascii?Q?/f1Q3F1VXIdTh2OsI00BSz8VdRKnBzZbRDOtOcXzy8XLn0akFoKSRSzhA89G?=
 =?us-ascii?Q?8O3V1JZozej1ySnqnxAH7/1X39MkCLmvtb1sk049E+/TN9Xlr1mAezL5Qrq9?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15BD4EC6F2C2F243992756EE09DDDDBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	efQM7aeYXikIMPT4pErSXMmZI4j0QsQ8NxGTkys7hMctQBih138GcqYX2VZHX8gwBEPovRzEdW8jWo87Kgwlo9BoViqNXBnGpCFIpASjQVi3kaQdK+GOIaCEhBMoALJ/gmpfExg3yDvcMVhJBCjJf04MKTskxMD/xLIXiB1xmsudOqrkZIxGINgMLbooA/frVCeU/lVMe9VwmXwBnxo+CRsiYg0hGxm+OXvBw2/NJAGv2vVvDU/RDozCzZbPIYm2b25Rtk08Z4reNfLo7S+vJeNgtbo3OJHMEIHbor1zjcy0c91ryMASOEP2nDSapJiPos4/4FrBWQHJrAtdhPoVTiflRHvajslU81XF+knKglU+gfIfE2vlX9AbTW4N5ug2gjFDjz7ocF4ZCq9etj8XyFwEsSwcn18UH2+VFg6xinRgA2sgzMnQZjs4amm+IRDDxg6HlxBYLWKM9HZ7UmqhG+6AsmAQLge6oty15ud4Ilfgn3K3zlPnenecKQCZEVVIxyHSYwoa6BgkBmLxW4o4zgCzUv6SakL/O+HKCeNxgRT0+AFIMLr71ySVQqbToqUmVgEzclhoEs7usf6n7fZyt8IXt9SIyku0CXGGKlR3qSxLIMKkHaRgZciCRF+VWKeQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaaac64-c0f1-44be-9ea9-08dda97051d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 05:16:43.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmekPKUE8YQVrxfe6bdPIbqBXR398XKVqn0hmpBxeEYY8tvuZRzBIdWo0O0iUXBUu+exadqKsJ6SDUZ3Y540u/adnS5UzwEkUF5RyKT4g7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9561

On Jun 11, 2025 / 08:51, Bart Van Assche wrote:
> On 6/10/25 10:29 PM, Shinichiro Kawasaki wrote:
> > On Jun 10, 2025 / 08:49, Bart Van Assche wrote:
> > > Here is an example that shows how a subshell can be used to halt a te=
st
> > > with "set -e" if a failure occurs in such a way that error handling i=
s
> > > still executed:
> > >=20
> > > $ bash -c '(set -e; false; echo "Skipped because the previous command
> > > failed"); echo "Error handling commands outside the subshell are stil=
l
> > > executed"'
> > >=20
> > > Error handling commands outside the subshell are still executed
> >=20
> > Yes, I understand it. I assume that your idea is to ask test case autho=
rs to add
> > the subshells in test cases when they want to do "set -e", right? My qu=
estion is
> > how to ensure that the "set -e" is done only in the subshells. I think =
we need
> > to rely one code reviews. If "set -e" out of subshells are overlooked i=
n the
> > reviews, the impact for the following test cases are left. Maybe this i=
s not a
> > big risk and we can take it, but I wanted to know what you think about =
it.
>=20
> Can this concern be addressed by adding an unconditional set +e in
> _call_test after the $test_func call and before the _cleanup call?

I'm afraid, no. I'm thinking about this kind of test cases:

 - it uses "set -e"
 - it does not use subshell
 - it has clean up code in test() or test_device()
   ('IOW, it does not register cleanup handler by _register_test_cleanup())

For such test cases, the clean up code in test() or test_device() can be sk=
ipped
by error exit by "set -e" regardless of the "set +e" in _call_test().=
