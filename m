Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09B302142
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857226; cv=fail; b=IKTYp5WTzgvSnJd8wNm5ocW9Z4I5WlDMOGHGrk37sx86TMRJNKpk71ziX8/YbTgicS8Df1c23AEphWzvSHtTiIYFJ6HZPMpyF0laUC6HBFRn9MIjyuEoOE3Hv6ClWcQl7RY2Y8AZeR9TbaSNGsfd7hfYqEyvauRm42L3gds1/+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857226; c=relaxed/simple;
	bh=T2MGKuETQ17YfSx7iLE7VV5ziegQbftzNy8tCIe3R74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iU66FlFLg4rm7BmrON3lDUU7o0n22hPm+ag6TTuedaLJ+rlFviLNBmQcWjsfU9hnjjmKcoRWa/3XPYupVBHodgv+TS78xSKvFrx6DM3XWW21Glrq0ZsDY0Sei4QbvZDtXcNCwUCxKbUSlPCTTqVDjW2EJd++KQDD8Fa/pT4RZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gP1b5cfA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fFyLSCbK; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gP1b5cfA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fFyLSCbK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762857224; x=1794393224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T2MGKuETQ17YfSx7iLE7VV5ziegQbftzNy8tCIe3R74=;
  b=gP1b5cfAzLUpfBMroFfwzmGzGM9mPtd6hhTXF87h9UxTlLX3ZIzI50mq
   Yp+HGw8Bwnju/ZyWfNvRdzIxUc2je48okUqjMdPa2Vo4S8M2PUv3Ll+Df
   iHWj2utnoZAI80PY8TfXQCf2wGpvokN0CIgTQUfN3O6HqxGxp7e2M8V/M
   l3rRyCMPQb3X9GCORcXRTR+YhX1OMHhb3VKHQjtj/VNESV77ICcq9V7QE
   DzKA1igyMFngfyG4ijGKTfFtYCeOBxd95/1dsP2gNzqFHMo+5LtMVRv1j
   IZL2li/S9etxjZCt7yFtazq65c7Q5Ww/OPd74JADL1HVDT9bTcpcpBqc5
   A==;
X-CSE-ConnectionGUID: qw9Af0pjT0ayF8CsBypaLw==
X-CSE-MsgGUID: OzrR+mdqTXS8oXA9mFMWCQ==
X-IronPort-AV: E=Sophos;i="6.19,296,1754928000"; 
   d="scan'208";a="131885806"
Received: from mail-westcentralusazon11010004.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.4])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2025 18:32:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHlMWZFZcQaie//uo3XAh0RPeaBQdpGffSVipjN5UALNY06BuGzYbXIDA2oOa3dK5EESRlVP0FO5hLJmCrmhh3u+KKhfNbzwhgOoXjGQu1UCQY9SuWbTtLj7Oy3r3yWbPmhwhiAKCmvGL6sbyn96yzquiD1lLK740NbbFU83GXSKK/8mweBBC8wanBMJVEeJZUuKGTPk6O8KMc9d5pwxvTyB0UbO/nb/Ub/MPg0jvQGCnkbdRE26S8cF4w+Dozoh39Esa7auxELDQNwQcD2/kCYe8nVZu0L3xTb+a8Ubj8b9Q3G6cKuCL78+OZXym+4W62MfjQ4IjxM7M+UjSGfsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwEw1Hi3I3oG0MMhDaDchZjZTGueoc+HYPRB7wYgmho=;
 b=c8Re1bDAWHpQjJ/XRY+A1OESNB/3h8ntxb4tYnDLeOxCFmY8cCYTyGsQGYV3gqfnqnL5cTfC66fMWhwRAcWvWtIl8GY8H1BHsNwdTaxmVq/TcFv8YT23mco/5NQF5M57AzL7Iub1cBnR3FfJyjpkRmpygSbj+t1jdCEQmYYBTR9U/qqjZ0YWKA4Olh3UmDesqYLwgUt6QvxijbCoeORNECgG1NNChAY3/KtL5ZOW3g8zwY3MhJg0UWTENFwBaHBOMZlSIzW6PDUry4OvcmA2cJUUJSqlKQ1OQBf0kIdaKkmGDcoZfbZVOUsx6avEv7o6Ugt3VhYtY3ySYvxxjr0YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwEw1Hi3I3oG0MMhDaDchZjZTGueoc+HYPRB7wYgmho=;
 b=fFyLSCbK3UBca5XgE1koBVqisAWhijjFpF6YTIOcbQTaAhViwpatcTaaj2jInAuA+uZXDisn6hvbG+4Ehkwv3inDeTGQQLj4/EwFVl9DrtGLRkDen9KDqTcv7316S6/uXj6a4KXZL8ePITs08asIe1sFVuadJczUruRjRK8KAvM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS1PR04MB9163.namprd04.prod.outlook.com (2603:10b6:8:1e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:32:34 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:32:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "wagi@kernel.org" <wagi@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 1/2] common/rc: add _have_kernel_options helper
 function
Thread-Topic: [PATCH blktests 1/2] common/rc: add _have_kernel_options helper
 function
Thread-Index: AQHcUJaLfADf3J1+0ESHKtu9lSQvsrTtS8wA
Date: Tue, 11 Nov 2025 10:32:33 +0000
Message-ID: <357kwngm5y4lj7qxkhnx3xhqb5vtltwwxodvg7slwwmi7ppwiu@uzgyu747o2pj>
References: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS1PR04MB9163:EE_
x-ms-office365-filtering-correlation-id: 51de92bd-271d-4a21-0ae0-08de210da03a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ITaIOuidNDGQX5Ui8EObfBcCKzDKb4cdJaFc6yd1eFt4VfbQLkJQIcLfK77I?=
 =?us-ascii?Q?di9ZXryaRjC8MAJ2odsflpwX+xbMJBf2T5LrFrtn75+85P+4VuiHfnwcRe/S?=
 =?us-ascii?Q?pN7YtGKAOUQ5Xs3jFflxIUDdI3jGAMxm6sgI6qRR+l915ooLn94c++7wbwTF?=
 =?us-ascii?Q?8LO0G08AAuc1XK82fPbjibcJ7Rbst7WDUL1/6HoXzVzmsPswU4MubgZAtTSR?=
 =?us-ascii?Q?6jnh8ibHeH+r6jegOex/jPccEYop+sOheqahs/LJoMpA3XBI1RPnHZvGyMiP?=
 =?us-ascii?Q?cwqkbeURs3G19avH2VrxBtqVf51vmOpba4LN8wO8v38NisuxUvnBQhMA8RTv?=
 =?us-ascii?Q?ZV4WW/MraEcNxyEzNBfHn4G7wBpDJfmOmozAn9HGZ6We5qIcFh9YMeQjR+wG?=
 =?us-ascii?Q?82veMczNIcnetuggtLeYw9qTdYZHamvaFDR5+e7J1q0IQT5qXUbB3pmycuTb?=
 =?us-ascii?Q?mapBi9Lhn2g43YnF6iYl5CBQDtel1uvVqk0S57z2A+4XE3AFc9EcLNaeAj2s?=
 =?us-ascii?Q?wNv6lodIz52oD9SlryDLwVPq+Xd2gAPI3f98iX244yF4mbYnepuqgNb6AhRP?=
 =?us-ascii?Q?xNrrFfM1/qCFQM46ytqncYJjc8r8kqfcZFOaUAUXQnV5w4r/im+qncqoaG0N?=
 =?us-ascii?Q?Qupi68O5OkufoGzKZH0hIybBTQWw5X4CYwXlXhGZDLgaaWq8PbEzkUPQnh53?=
 =?us-ascii?Q?AhrAT6Ta4GkMMXFBta9GT1YWF7MWlPv1srNPOM86e/TanvtP5WdSarC15FAY?=
 =?us-ascii?Q?igcvwRQF3S77aani2BHSZnqX5zjSRZaIhvQGexmCZoJsh+sDLOLsJ87BLx1h?=
 =?us-ascii?Q?4k0DisM/qj2/VLZN+dMR++pesWqpEkuIlcov40JxsngWv3nfy7t8YkBLAyha?=
 =?us-ascii?Q?AejCO0TnE6SvIlM1Pa37ifwwuI7yA8baTeKb/ec/TDnCdRB1RikM9DSr5405?=
 =?us-ascii?Q?ma6+O1PZQsxyobcfvbxu/IGmg8VYP5eP88Ao84hRU09+BWT7jDZv594sn0Cm?=
 =?us-ascii?Q?crl7QrWRrk2slJhdBAosabA+Q0GOhOokowtEDho6VleCgn3a8P9+veF2Z2KL?=
 =?us-ascii?Q?jXIeI6clVp1lpFV/isvmrNomB2QJ97sdgJCXjHX9yLtm71V52SJQeWA1DH2J?=
 =?us-ascii?Q?MH57I4tylejDxu/lIqSxLtqo4n75fR88z9OqIrHgvKZf71e2KTQCE44gxfCr?=
 =?us-ascii?Q?QK2UrYwamSDul2EYF/7g4vgRMhoUFc+m3Y0QERITeG4jBSBA7qQrlVOTVEDP?=
 =?us-ascii?Q?mO3mgq37TUfS6ZRF8w9A9ycR2ZL1UXAmiJoDvzLGtdQ+GtaxTVyecD9AsAyY?=
 =?us-ascii?Q?80buSCGPSBTsA1lYwdumhC6mRpw9oVEg6iuE3m+EYEMmIRcFLtT7vetOObuh?=
 =?us-ascii?Q?7dobCaZQTzAmz0mf9FElTgElv5fLnhdU46NKzWEGVrhsVZm+/Rz+OpSfTHwC?=
 =?us-ascii?Q?rk5zcStRlir8mDu2AeaAG/yP5D2yAN2ts2cc2NgBamr2XvjVJeRkeIBEEWmY?=
 =?us-ascii?Q?BTosQUpuHZO/FkBaplmI9zytXptiw7/Xrz2r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?67IRynY82nsic0kF8sfV7CtrZNPhdFWQKAa3bYpOsgjNNw4jXoQC+abjMW0v?=
 =?us-ascii?Q?wGuYP26dfOFEUbE84JVt5M2S//JfK90kJ/rFWvTx9nBK+cTI9EnQSvMT51U2?=
 =?us-ascii?Q?1S9KoHeXCAF66bHtF/Cz7Cu8+6hlpt6MrV+ugBDXXY8cgNhhbZDrXPbKRhso?=
 =?us-ascii?Q?GijL0oo2lqkzPTt9ODfBJ03oFacTsoCnVQPeGhLQTCBsdqh44nN3DjHSP0tU?=
 =?us-ascii?Q?ZzT/JaKTTMYqllzoYB9EVzU3oG9lv7V8MqVPc08kpAtQAnQ58mZ1BHR+VeWf?=
 =?us-ascii?Q?ZZtwVFFP2jOMjQnyjF5i+AEA+CqIcOcDz2ek/jXCwdBJYEnNNbt56u2q4TO5?=
 =?us-ascii?Q?uuLbH0ETQRY5lm1253eLPIvqClpOB7jQ5PHrR8NHxJtjOaZcQLDCk1VYNpd/?=
 =?us-ascii?Q?BX42x6teWrEGg/I23Hz7hCk1r3oo60LTWuguoiIuSb1ThUfDnaRM5B1u9PSF?=
 =?us-ascii?Q?ViI8iJjRTGX5XwCBrFSyr7D6q+DYNkUdHf7d7d1vh/Rr8qJ5zGU4RaxgVGJh?=
 =?us-ascii?Q?ZMJHYLEoSxbHaNutmxPMiYeW6qvBCcE2xpbXrzLpjKJsaf7+o/oI/g9wi0Kp?=
 =?us-ascii?Q?/EtTDBMEu1+0RMH1yNbuCTSkotMGgUxKZjHr0r8beqICK9ZD4drQP1JFtPLA?=
 =?us-ascii?Q?lNTcRsO5bTU6zGiuezuw1wGVjoAJy87Am8g9Q/FKAe40O2heOQrM1hjVK7Ym?=
 =?us-ascii?Q?l7saOuN3R04t2vzQi1mErEZLTBSQb3lfj8Q9mDen1eYeFCN6iQnVF838A1m/?=
 =?us-ascii?Q?Y6JdXSb+hs8z5eIlSICM5PQhahn1MtEmn5DVywJF5KdRJtF0MV2Xp5ZFKo+f?=
 =?us-ascii?Q?rCWmTVWm/y/yoWGvwiMDw0h7uPBc2euLYc6YIjvM5fpZIivRsybV2WdUv2fe?=
 =?us-ascii?Q?WH8JxCyhzOXgFLuj/1S/mgTbupQgtcrepHXUAbmtukq/o0pqmlJDp8UhRbHa?=
 =?us-ascii?Q?OE1a2DbTlYoD61h+digNz4qtDuUzYgweqUKiR0e3a2weOyt1BpHi/K2+PH9s?=
 =?us-ascii?Q?w7MKzcBY3BuZtNVNj1OXe+A3YSpuW82ywktxC00xlydij4xwl8HPu7d4JfP2?=
 =?us-ascii?Q?jyAYLNY62M+Msa0WPPAWDExeoEKuHXMno9sj/yg5SkNApoJGmC6sYXFz+ZAX?=
 =?us-ascii?Q?YvcdtXwL3CUANPLWsrriWh2uE3vBb/B4oDNSNp909FexvCYlYUp5MbagAn5G?=
 =?us-ascii?Q?U0sCsvcPkx9TKl+Pk+JyG8Y3IrWW6KCAgcsn9q9DdcT9jgjUNBhubTFdiwc0?=
 =?us-ascii?Q?yOs5JDKojpVQELeeH9XVFKaeLqlkfLMwoTNHUFEQ4TmBH15hjDAcmZDkc9Yx?=
 =?us-ascii?Q?FxEtksK400Rav5FQzjsYYKD0YC/qgM0x22waumIxiM3IOfKyn44uRJ9qqNI/?=
 =?us-ascii?Q?wnFHkknrW6FdVwQlmFhLTnk97IpJEZAndeRlZbgLFgF6fV8HEn9Z6HzJOn//?=
 =?us-ascii?Q?fI/B/rqtu7dwyPHTkZPUNL8ow7mq/Y8IeKede9w5h/gd9KQ1jhp0x1dv7dtE?=
 =?us-ascii?Q?qWpX8Thikdoqq1zcHPq64E+0dpZI5ONHHJlXO2j2H4H1BtXKu7X4d4OFx59r?=
 =?us-ascii?Q?nsm69INanRDal4mzJOCKoa5Ju+9H0maOyfR4IK7qoAHJmpcEp3Vmc6jU/pGH?=
 =?us-ascii?Q?fHdtgKNin6pp2mKu2YELruA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06A9FD63407FAE40A7F0C7FECAD2CB2F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DV423dTbJjm6jgXn6ZIoPdxXtYzrbVzeEO0PCPgE5EAUDuvvaQiy97t6wWQTVaELYx1Vrm11W+Ihw+hRuBLRKC0hePX9pkZKcX+K4OXEi8p8lBWQK1gOKUCwVPBBehLK64xA6QA1uxvPd2rSjp7biLP0qZnMFgTYtb9ywsZYSpPsGhp9niYivl24ZY3mRN7P26/KOUR9b5slYNYcV6/3wnIMPkxAUZf+InW/mTvlHgmhNp6DtfL5DlXvlxTtPL4YlJkVXnONad9qhmIumIso5SW/s4AHYIQXpcUArx206pafsJZg0pXXsOsE7KwV0h4189fuP7FpXbmxkeUhd3gmVpa89nhnYckOi0Ag9V6A/kfIPSU2Z+ydkQ4M0LJcYxXxzd4nFxLf87kfO5DIRujqOrMoBPkzBzXnk4cRECqd7t1tfxrU1Rc+EQzMDgi0rfJhNDdPtPZM9PlGef8uwfYCzuRJOwOI/R3FN/3/x98j/cDXexfuTEbQvUQ5bdEK+QBZcSzYN8VTKuf7TMLaWrWS2+BuPxdQXWs+tgtRgtr8z6hpGqs8D1OtvZDibXDd+mwMG1lku0N/hL/C8DXEKpSeoekyK3Izvcs7Br5h8El9pK3hxXmiTkLbPib9W0MH30gE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51de92bd-271d-4a21-0ae0-08de210da03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 10:32:33.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+raCq+VkLW9a12rnAVJ54oEttnvLkmtBIP0DYHPfoLhZlPrMNQioolV5pVJsbTenTprNpc7HqUIh1r/4PkyzMa26MOGTkkXGxvUJ6GDF5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9163

On Nov 08, 2025 / 02:00, Chaitanya Kulkarni wrote:
> Add a new helper function _have_kernel_options() that accepts multiple
> kernel config options as arguments. This allows tests to check for
> multiple kernel options in a single call, making the requires()
> function more concise.
>=20
> Example usage:
>   requires() {
>       _have_kernel_options IO_URING BLK_DEV_INTEGRITY
>   }
>=20
> Instead of:
>   requires() {
>       _have_kernel_option IO_URING
>       _have_kernel_option BLK_DEV_INTEGRITY
>   }
>=20
> The function iterates through all provided options and returns failure
> if any option is not enabled, maintaining the same error reporting
> behavior as individual calls.
>=20
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index 86bb991..545da61 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -226,6 +226,12 @@ _have_kernel_option() {
>  	return 0
>  }
> =20
> +_have_kernel_options() {
> +      for opt in "$@"; do

Nit: spaces are used for indent.

> +          _have_kernel_option "$opt" || return 1

This early return means that all of the options in $@ may not be checked. T=
his
is not good. Let's say there are two kernel options disabled, FOO and BAR. =
With
this implmenetation, only FOO is reported by single blktests run.

   "kernel option FOO has not been enabled"

The user will enable FOO, rebuild kernel, run blktests again and see this:

   "kernel option BAR has not been enabled"

Now the user needs to rebuild the kernel again. This is troublesome.

I suggest to check all of the options in $@ and report all of disabled opti=
ons,
like,

   "kernel option FOO has not been enabled"
   "kernel option BAR has not been enabled"

This will report more complete conditions to run test cases, and reduce the=
 risk
that users lose their precious time. IOW, I suggest the implementation like=
:

_have_kenrel_options() {
	local ret=3D0

	for opt in "$@"; do
		_have_kernel_option "$opt" || ret=3D1
	done

	return $ret
}

> +      done
> +}


Other than the comments above, the two patches look good to me. If you are =
okay
with them, I can fold-in the suggested changes when I apply them (assuming
there is no other comment on the list). Please let me know your preference.=
