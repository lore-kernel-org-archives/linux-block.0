Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E62317715;
	Mon, 15 Dec 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767621; cv=fail; b=kdCw4TELoN1g/+DAfjmZ81HwdB8k3vEDnJqtrq+s3eQ3VLs2q/ww9fGFGrgnkgnuAZNyMLKmRROKh8wJMDFI9NelPQ5S+tjVRACx3XvKN1PUOv008kI9ltWNtjKAqO1d3v4I2/OYqMdfb5phbq1iELsLDbu0mct3gYnhUfMxAVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767621; c=relaxed/simple;
	bh=fAd2FjkLX1jKfGv80nOSy/XlqjFv13t0a25dHZJvcms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rlzO+BYVzCYQ8wyd+cMNHa50K+HQhpFmTWCNBIDNi6GFr+8kjjVm/v0utkf4qc0bTiSgrLkqeNMV7spNJKE2dslHOwoA6sYEwsOnNVhoXltKr0dZui3RRbdNexI7dX4LjPHoD8SilVBoxnpRPkNs0rnoAVG84VPfiBMw8oISygw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nVn7ER9i; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nVn7ER9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/1Kwa/kG6RNSqivp9euHvPLt1FvKdRiC1tGAA0xPWeYo5KLnFK0HnYwAUvWd3B234DAcM6gOu1ejCkwP0PXssv/hRmLKvffZK8ZK+OTZyb0BJIBRtdUHAzUsJ6dldYbkByx5W7YIKF8VXJ5jrhkNXqIuyiwGvbSRvpcWJ1H6qWwqIObLE97bTDpczU9rV9/ApzIo/iZNYTOXNVymXenwHDII1VrNeiKYPBHDd8VhWJYWaEArCWMArJjcTxINbUxDaECi5eybNeu7NKgMw0+yiPFP/yjvuSDD3sVrMqoF3fi25++gnF1sh+nXucUtQb3a/rxZjPOREufz95rQqLJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAd2FjkLX1jKfGv80nOSy/XlqjFv13t0a25dHZJvcms=;
 b=R3nT9/GrNUi+NcanJn0+PdNwQgFeVULfL0oosJcOsWVHrhR4eZlGdDvbspsXzOZUggXPuwOUPCUFjbzJUdCdMtCwR5wyQR594BdkKSjqhw9kXFoMPIPMOhkebtmUouFn/oqAenV7IyqUz42VDtXyVKI/mFwKC7377ek36lVIxaS+wH6/3zbBpt1OkN8K0wZsjFtjXEEbI8Zz0VfZfFj58i/b2XnMJldObKGhvP9Beg6VGt0HyGz0mVfdiJmYFnMk+gqFNbYPJ//HpB+2wXFxnddMMA/X1FRDBddZ3VmI2Nv8zmVm7UYhJyCdpKhfeTCQtmcfmieUYZYxH8Fq9YSbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAd2FjkLX1jKfGv80nOSy/XlqjFv13t0a25dHZJvcms=;
 b=nVn7ER9i3lD10qZBCUz8HJchrFprDlP+nqvnpfuceyNy6w0yI1hygjL1D9YtR5qOptQTShlAmuUQl9hdXUk5ZXpMmr3cJLbFQdQJkO7hC4SAaQZyqGvIHudKxkAHw1d/7CxukAOJavVNUvLSv3bLkpJy+1SHcOPcFn4yWYoMi2qGjY5Gc+i3oMAedCOLaDbNRb4svBaFf03hx2hs64g2Tr85sRVTHg99CIgwJQt1fDrMD09QHDssmmmKTrGQ+6QpW/QEAgkNEnCStDN5YP3+lrZVIbJGoVg9xe08aAsOndjYrfM2v1tLRy+TzACxJysDvfcv10o+/8kREfoemvPBRA==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PAWPR04MB11646.eurprd04.prod.outlook.com (2603:10a6:102:512::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 03:00:15 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 03:00:15 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Avri Altman <Avri.Altman@sandisk.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] RE: [PATCH 2/2] mmc: add quirk to optimize certain Kingston
 eMMC secure erase/trim performance
Thread-Topic: [EXT] RE: [PATCH 2/2] mmc: add quirk to optimize certain
 Kingston eMMC secure erase/trim performance
Thread-Index: AQHca0HIukzhGMUg7UaHOEMiqVuyy7UfJ+oAgALe8eA=
Date: Mon, 15 Dec 2025 03:00:15 +0000
Message-ID:
 <DU2PR04MB85671515360F017E9D7DBFDDEDADA@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
 <20251212083246.582806-3-ziniu.wang_1@nxp.com>
 <DS1PR16MB67539E6FE1199DA045DA614CE5AFA@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To:
 <DS1PR16MB67539E6FE1199DA045DA614CE5AFA@DS1PR16MB6753.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PAWPR04MB11646:EE_
x-ms-office365-filtering-correlation-id: c4014a61-889b-49ef-c4f8-08de3b86124a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ae3xUvJfomB355/9t68GUBXAXTIeB0GBI211yt7gg0yG8TFuV64dzfYxcJ7O?=
 =?us-ascii?Q?S8oGoY9bb4G57Ba4dJiG0h6AVL6gaYqw5CVwkgsRQBiH2pB0nRYAYPlJOeFz?=
 =?us-ascii?Q?8HLOxpUEPtwwuv22b3f99hSx32qP6DaHw3ZNEir/S8vq9q9IcVD1UoFDRves?=
 =?us-ascii?Q?xLRHIZVMzJhaRqgoZBazDQuQdvN7mcQ+8eEhvFkeRnI064tSCRajAUpFIYH4?=
 =?us-ascii?Q?gN1kvpeGcMFkdxczJzl9xfQA3P0H5AugiiqQjpgmZ+VGsqEoXOOziUpV/39D?=
 =?us-ascii?Q?8FQTi3PYZGZQDB99NObGsNfJUtT/Urqm5I5DKXGNy5VSO7KY7LeR1jsMoU2Q?=
 =?us-ascii?Q?7LRfP9chGngifflN2yP+RquN8izE2aCxUCqHFf1Of67+Nh5JyTFtoFx9gxxy?=
 =?us-ascii?Q?hyi09tcvFSI5/dJ1wJl4hrlodHIr/wAmH/PGdliIRCs456+2kYlUsGYlx63h?=
 =?us-ascii?Q?bvw5HR+6VZglPH0HvXMjs6NiG5y++zR9Dshnjk8RCmjsr8+Bsi1wz0SeCEMF?=
 =?us-ascii?Q?8r1Upv2oUfm/EAaBs90gYEajp6moqrqWWYjEW/17ZNosKcLwxWeGjjbPAO6b?=
 =?us-ascii?Q?gpxLxxCEPOxnnR8XayROjxsHpfOByAqIwd2EGiPHdCSpZjvCs0PudIicx93J?=
 =?us-ascii?Q?AINueyhtZtX9oKVM7P9L33r3mFNR6GIgty692pqMqjzBsUjGKmZD4GVhVnz4?=
 =?us-ascii?Q?iytkvITynr76oURKXDQdFoaLEfQC8rGasKpi7b6g6lt2FkrtLZaFd7rZBtN8?=
 =?us-ascii?Q?QRIldO+/FAEE9ZP8tczz5yxql286Zeb6AsANUwhpEFAXco3pkwy3MyNcM8Nw?=
 =?us-ascii?Q?cYRvTt4bOUggHgLINNxCYRBEQVOLwpxt16sMdZc3GZ4UdWxSEOsi51jBmbTk?=
 =?us-ascii?Q?OUzZfoh5eZUbG0JXZ6prG8L3V8p+f6AV8xTkDTZR7R4DZ9b9pyMliwtyqD2j?=
 =?us-ascii?Q?G/wCNXIuYf61sFH0rIVxc6Amp/61q+0K5pimlKgiESjTwZ6aXo8z8Nlu4BwN?=
 =?us-ascii?Q?Y7wt2fC4brndCZOGoxqRfxbtCct9R9ClTBpQpPlximIcr3g+dyKdYe2cPrjj?=
 =?us-ascii?Q?bupkSsO3ukJqSmo13flEiF1wtmKiHxOZSopxx48rYmVQcCRtSlLm5tAOmbvS?=
 =?us-ascii?Q?63icYfLjdWhwwfMmted6RD6/xZjtSE0qspzoBegbN4piYbSoQFbO5iAZ7jhc?=
 =?us-ascii?Q?OyPMogkii2rXiCA2GZ3BQXbXXrrndg/m3mp83B3ozfdyag3/aMDm3u7p02T6?=
 =?us-ascii?Q?ogbhcofC13o0h1jMGqlwmuD0DFQzsU5vZKKnHa9ssjjgNH0canDejKsbXsH7?=
 =?us-ascii?Q?bJSJoK9rPZD5XykrFR7fUouvlEfRARcVW6D8BB+mfC3JnjbX82onYKIaN/DY?=
 =?us-ascii?Q?mtxiLGZcg1cNIVYJdUk81R6T/p0yhtndUh6m92hCFr19Z6Xwlz+oPHhx7rBF?=
 =?us-ascii?Q?FYQT9EDgHfeiWbdQFOWgnE42mKRMESrrey3yqdDRYzljcNwqhyfNZDANFIoL?=
 =?us-ascii?Q?QGsoHrPg+Et/ioXqI+kcRzi/ipIWr1sq92uJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jBLPIIc0dGVNH9JNhA7uAjIXwNAn67RjTiFfSpiVXiZAS4xVKrxE8NmzFV6l?=
 =?us-ascii?Q?3FXKTK4bi5IkXA/ywjvsJ6W/8PiR71y0FzHhqWEKkFJ1xYj6lPrAmN/IFpgZ?=
 =?us-ascii?Q?NnG1i1FKKXplgD1XpeWh6NZHtbwXkEOSm/pecEi4yZ8RhaWfdu6QjHDMWL3r?=
 =?us-ascii?Q?iWNg8zS2MEJEv5A1rCNU3G00tI3Vge75m6OQGf8rr797xjkLn7+7T+4l3rJO?=
 =?us-ascii?Q?XQ98szmPfOF6eapkEp4X6rHA5b8bU7Ivze5/6CWRgQ+4JheNTh5W6dMX4bzb?=
 =?us-ascii?Q?OK/2UndyPgIf9dnwNve38bU8FoECkqaeNRSSggpRFm0DnzCw3gRFGeV7BShq?=
 =?us-ascii?Q?g44tthQtQflyeeG9SCJ9fL07aiVbABgFoWx/RYXI2AdlN0OIIVxaDVfKbTog?=
 =?us-ascii?Q?f47qaMzPBKzda2YrXyBFn55PJ58pTblMFGX32LXu0LCWFUV4j0+g00ZW16Y5?=
 =?us-ascii?Q?rKnNdsrp81g1Aj9g6IlTunVj8/y0XDM5YMvR969ih48+C3NGdWGnpb7RpkKT?=
 =?us-ascii?Q?7QkUkR3myOn9BO15dwZJ3CgjRi+NAp8yPpIUS3URIQ7OG1D559cBiT/lbqHT?=
 =?us-ascii?Q?QCc3KUQsiWj/k8D+pUN/nafWUIz46JeiZ7VwB2PWus4OXWbDjq33jRTjNPbj?=
 =?us-ascii?Q?NAkQSnMSyliOk3ISqA9OXTYZrM/m/jsXgO7RGKwfqByESdCeTakWE8BUMk1o?=
 =?us-ascii?Q?QX0rJnZ3yRe27jd60vyScW2pVGBR562X+6vCEw8EzGTP+UVCegr5iGhDSaMw?=
 =?us-ascii?Q?b3fPSp9k+1xPQ7PAaK6XHdLs3TwLagLEpGia8kENyikZQlP6oNe0dAKgcnXD?=
 =?us-ascii?Q?k/y+Ta+QwGkFA+NuTSM2Sd7ygDznjZ9N21cBgIpU0mAEetccwqUIDmfiuQtH?=
 =?us-ascii?Q?Ey0QcuKhjbEj4xi4Zx7seME6mWOBhn6+XVIlWllTbYJqpyvFlkQXvGulC3g1?=
 =?us-ascii?Q?3wTJ/BQ63il9tPpkrVB/iQ8DfpHGPMgSqpwPAr+XH3I4izXQhLv8hApie+OM?=
 =?us-ascii?Q?3lfwZOhbGM+Vwa2kPZAskN0NfKVyEzUGJXwVUwXgIgyhbalyDE06fe5Zp39k?=
 =?us-ascii?Q?lMYvmAYhw8pvaDooZ1vZ8UrA74q9kBYCPQ4PUmop52Hm2Rwx8dq1NpHppUnK?=
 =?us-ascii?Q?fpmKtaIPjBY1Ptn2oBQQ7S3IrfL+faxAMD+0YPbCM12t0LSRn8yiWErRX42s?=
 =?us-ascii?Q?bU8hoIQWQJ8XLwtQKCzNimo9YU4JxGCoqgbZHbW0MXePLYlEE4TcLnn74N0f?=
 =?us-ascii?Q?OdRDqwhejXIsyapxP/yATMU/vzmb+A+ICGN/HdD4i49syi2Om/+fdF2LT04+?=
 =?us-ascii?Q?apWV+/gokIq1b1qT1dkMO7HoacstlHzo7R9884891jKZgz2vOiWpkStO4pJm?=
 =?us-ascii?Q?gtb5qrjr1AgvMKh/Ugirf1WO+n5TsGFYEgUDOiPBGyLAKPLByL4eaaYbKcCb?=
 =?us-ascii?Q?D46YlTe+A/fdMHVA/3NykEs27nzKKhUnOQosLO8XDTOCy6U6KYelvAq54ahI?=
 =?us-ascii?Q?ntbh2+d49P9O2iUPUCAFDuLw3ecm0CyDW0fPJvGjymzdF6WyMzYu0jWvEGPP?=
 =?us-ascii?Q?KkpQxuXCT4S20K2XQn96utVdRxa/HemHjwc1pejD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4014a61-889b-49ef-c4f8-08de3b86124a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 03:00:15.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VquZ9gj5guDCVQGoY/ho8ScotBu1FDJtCes1wYOflablE8BI63OHs0SD8Jh4XNRZf0GUNMtUYkDkoEIWMzhBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11646



> -----Original Message-----
> From: Avri Altman <Avri.Altman@sandisk.com>
> Sent: Saturday, December 13, 2025 3:08 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>; axboe@kernel.dk;
> ulf.hansson@linaro.org
> Cc: linux-block@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: [EXT] RE: [PATCH 2/2] mmc: add quirk to optimize certain Kingsto=
n
> eMMC secure erase/trim performance
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> > +#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<19) /*
> Secure
> > erase/trim time is fixed regardless of size */
> Maybe you could rebase your work on:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Flinux-
> mmc%2Fpatch%2F20251128052011.204735-3-
> avri.altman%40sandisk.com%2F&data=3D05%7C02%7Cziniu.wang_1%40nxp.co
> m%7C5fceb03d8f644004e23d08de3a165de7%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C639012064900475164%7CUnknown%7CTWFpbGZ
> sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DFi%2FpL3MH
> EmOdwAvZxs%2BTUYI5k9hzrIyqcdq4Q0eYNw4%3D&reserved=3D0
> Which is expected to be applied in v6.19-rc1.

Thanks for the suggestion.
I will rebase this patch series on v6.19-rc1

Regards,
Luke
>=20
> Thanks,
> Avri
