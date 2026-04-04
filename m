Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738C2848A8
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291764; cv=fail; b=pFI6i4szBPVsI35jOxEgtWAJ/Ac9QNKASiRtb63frhhVnXVMSefXZSxl2uTWC73ghffsSSWldmmWvDdvRXducSMm1EBcQm35QJIa1DcilWur7jqFA2kZMjmUbycY5hShUtl7vgg1gtV463VhKgt58xAUb9BA2rC3XxtLlMF6JOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291764; c=relaxed/simple;
	bh=dlazKMZpLf0gl2VdVTRKlRYVjjQcd88q89sTYsVKDGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YMpT26pN2pMov0k9OugWGGwA7hEqhsXU28veLpZPU6QEzjL2XhiPvreJWwlq/CDB0tlm2FWuew5VPqCdRo2XmMnHxXOq/3bRcRhoIspk6qX1JUnXGjn0CsJ6wgg8TKbJrn0YdYCyTk1YpJ5jKPu7U9Ayg3QfLx56CsUyvMMb8m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S6C2Qsqf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ug+Oi7JM; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S6C2Qsqf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ug+Oi7JM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1775291762; x=1806827762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dlazKMZpLf0gl2VdVTRKlRYVjjQcd88q89sTYsVKDGs=;
  b=S6C2QsqfQeyl+8xsT/0vQSqHx+34HLPKL+KkZPYOVLjewTzNU1P4Q8uf
   7RYskHHlJHVIFp0RrLIL48u3pvuMMSBvtq3ztgN1btpYJRTc0V0596+Q0
   YGRcDxO/paZ8SDaQIsZBe82s38yEmHOCyDY6d+wfqTFOqgN84mZDxmE+N
   /+u09HjEqndIlf9GsM7921h7Esf8NkySPxLrIhsDDxs9FAZZXDlGKOh4w
   9tUdKmbF0AhWJ4UGyH+KpEVC9KWz2GEtNZ2hK05W4ZjjxHknvar2vcN5r
   WxmgGyFfWj000uB+UU3fzQdYqd8rNweqlq06o1XYMyhOSqXW5eQW8jgni
   Q==;
X-CSE-ConnectionGUID: i83yszjCTnWT01Y8ZfvrIA==
X-CSE-MsgGUID: Wbq0xFTqTz+r7V/vjZVJEw==
X-IronPort-AV: E=Sophos;i="6.23,159,1770566400"; 
   d="scan'208";a="143864259"
Received: from mail-northcentralusazon11010001.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.1])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2026 16:35:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdeiGPXqclK+dWDdf3McMCVtEairFZmPGzm+1RMMjnRG1znaSUVNU2EqM/Vlb4lKvVJlN/fiJsuQwu1bKHi2J/RuVDlIEGNqU7U89iXr9KD3QTIhA/P8kT4ifO/A3FlQmX84w77Ez74u9f9Mb5vwwgWIc8Z3wPPkOvUZ93ceNc7wzRTFVFvI/hODFwt32K/e/K7M9Kc3+XKAPPyxLL2xfG2QdUx82o4PrzbtDiyxjDcVrgdepvT0ERQDxTV8xcTH+RGqd8Ids6N4aLijeCbOzbp8k9kxPEhSCXvp87W674CsSEgPGvf/Tw1fR7VeSyO2F2L56if9MJVXik+X6AxvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87i+/hiQPq4AOeZz2RsOX2zZXPtHcXZgDa1iW8+vp7c=;
 b=AYB8JuNo7ePH5f+QLRKDot6RSQaV6Sy09KyWkLgFJGENRDsJDeuYr//+Ag3KMYzZ38/94VylA1A7p/bnA1DAc58Y9H9UmxSwUnyzBNwELhbhZlyHEJnPoJOH6tKwb58SY6q3o1O1m75e3V6POsB0QmpDH5Wpal15p4jM0U31hugE32EuuhcbwGJ6e3SQOEshTXPw//Ot6YSQ4v/tEJMtq4QphGEfYwtuFRYRWp6SddRkBhKEM2zXCML5SSrkRCzX9jQ9EUMV+asBYeNxjUQBi4r6ukEOms7edVXKEeMWNBJrj0AgPr617eA0n9JWhxAVjE1VqYYowB/0nrwKiq9+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87i+/hiQPq4AOeZz2RsOX2zZXPtHcXZgDa1iW8+vp7c=;
 b=ug+Oi7JMaWv6RkkRVOcCbuWl9YLHarcinfyVkCauc00Pv7IaWDK1C/ikTS96K8k41T0IzOKLeCJnT/4p6I8NoLytpePDjIdZnit8Owm5aPYmow6qQbJjzDOuxz6v/IHFkRVkXSbfSVxBm/jv+3oUt9LHmyxmSKMd4HPusDEkeJw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CY1PR04MB9737.namprd04.prod.outlook.com (2603:10b6:930:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 4 Apr
 2026 08:35:53 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 08:35:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] src/dio-offsets.c: Fix err() usage
Thread-Topic: [PATCH blktests] src/dio-offsets.c: Fix err() usage
Thread-Index: AQHcvUcnhqOcQO/6mEuwrCVIigyhr7XOoYiA
Date: Sat, 4 Apr 2026 08:35:52 +0000
Message-ID: <adDM7QhRRlnntRB5@shinmob>
References: <20260326173632.3259254-1-bvanassche@acm.org>
In-Reply-To: <20260326173632.3259254-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CY1PR04MB9737:EE_
x-ms-office365-filtering-correlation-id: 198a2473-879b-4ca1-b4dd-08de92252ed0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 K2EaFurEU2j4tFYYNr2Aq46NaAC4LkvH0Bk4qPyR5oVD0epNqK0+8Ikz++fJNAPiW708LnJp8lDrtY0D9XvrEQdQE62Xaq5Vs18fUYj06OTh6py0XBVp1eqd91Nt3n7XW0DfZ4Er9UMd5R9s87TOYOAEaa2Z0M/M9KjbDauZMBPmjYVIpKAu73eqR4ZaQea/f+ekMMM6qIpDcmMLoyHSnDGr9JjADl+O+5FQXlKYxeIboeb5DHfREHkmfPHlYCuuIamuAE/lARXcjkAwBQz1XZ0+CgukqoadYihkwUhaTidoRnOx0BpzFGDl0srprBcqz5YZnPnv8JUffljhi6DZxrVj4BSF4clXHzB+5Yf5ItgYhArkI/nFsE3nX7GoiEyQrztGXN+/BV948fvqyZ6ctWw+RatbK1Oqp3r8lPf9FyMz36LYG3QUtB7oa0ZG+635/D/N5G7nZk5Rt2LLDJYvFlM42aRfW80mKNz7xeLb1DR7pWKnfvysyD1mogyMVshCC/58OIOj0N756dyTyqXZP7UBiqzhc95la94B0bKIegpWqNOKKPlL7Q7rnjuTmhdrF89lHbrGnenHRynUlNerZoRbx5UqnVJ19GKCyKW43DebUd6KXaPX42XQbIOvLYDU0WAoYI8Fd1vcs+r9n6HCxqRj84tK+KUh/hVLBeGKbunWD8JLtAfVRrjo2fCN7eKaK8BA4gMCKa8jIlWJVsf+9DrUwf72rLdQuoggGftArEUWj/8UQg6d2sUXu9Hc/4Wyabw9lPtr63+9sYopvb8kTMJSuGE9LJXFu/pk/jH/TsE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KQDGQQyRQcV7yq0MkLFw2BW1H6RoKv05IRPDYRwA98r2/wVniRJi7BkDWrEb?=
 =?us-ascii?Q?URPbt9+hzAC6FsDnd2Z0U0W/wkCog1mhKqVTsY4DO5DlI9TeSSlY70KWSKTN?=
 =?us-ascii?Q?7NMVYYvOOUHgK26qaAX11LnM63RG2bKHke1GV40ab6I36he6z8G001Rb5888?=
 =?us-ascii?Q?wUJgEH2Y7Q2xDaD2c1cn9nRTfIsRrOXqGpDSCjvxffEFeOFYFcW+gDSAZxxt?=
 =?us-ascii?Q?dDyCdm0QUCq/n83vy7j4SidUJX5LNgnKF/zcno5Zi1uaTcwSnB0cNC6qJlgs?=
 =?us-ascii?Q?HXV6XZjYMUtHLnVL6v1+bgbYET2ZmlxiBiewfU4l41wReOFw26zaU2ZSsKtt?=
 =?us-ascii?Q?TmeHXEMIDib+zi/LWJY7TeMWPsZMvKtZLA4oH7RCyh+UPfmgImntpmlp/IWP?=
 =?us-ascii?Q?G0SD4Q4kJ50H1XfbUO9CcBnMZu9MZYMg/loUkQuBZmLR2jf1eG+cEKvcfkBR?=
 =?us-ascii?Q?dNYcRVuCAI7Qz+uJF1tOaFcrs2tcHFXNrW87j8H4E/sTx5P4THNMjXlin5eu?=
 =?us-ascii?Q?NcIhWfynuatULu3lxAPIQMPRZIknasoQ2LDnjH8CjlONTjHUpm6w1UYdZZ1t?=
 =?us-ascii?Q?t7x1uXEly7VehekXga4NOxSv6qDqoYonKU3m0tlCbG3LaGYa07ykdNBFnkoC?=
 =?us-ascii?Q?MI86p9OkSupr1z6pfm+LEnFjzj3DU6vobUZ37zcen0cDQ1sjQgyYAV+l39Yf?=
 =?us-ascii?Q?L4kUEQIhzxDdPuyaaax/VVg6A5lCXHnlFKl5V4dQ1pxWXK+PaC3wuX+bUd+j?=
 =?us-ascii?Q?r4mjYjkPfSkKcXBbaLQZGy89lKMs4jKsB3WYbh0W8lkSX7suN2UJnWJZmX5J?=
 =?us-ascii?Q?Axf/yjg3yeNWv4QkhHv4ikVJZViQ8u/1U+Mk11vaVO7wAbDM3tib8LZxeozW?=
 =?us-ascii?Q?tyfMktYuBbyBlY9wIHm4O6KeEu/9LPkNCrULK5zWhu1ckwjWWG3bGtHQFJPO?=
 =?us-ascii?Q?+c8S+HZq33m6nYM3/DLC1hWoY13kGKhCC9eQXCUFqQRjXG2KV+UIGaastDV7?=
 =?us-ascii?Q?UT04zp8XGFTRfHIa/a71FnQVdIQ1pMpbRCWj+C8+cTWIdZF44H0VNFkhPrV2?=
 =?us-ascii?Q?WHilY/UjBBBtDdsKGB5ovBLfjd8odOhkO69zL73ad6elskpByjLrj1Ol4sUX?=
 =?us-ascii?Q?F9/Qhxlk/n0om4s4mVU40KD5SmaVvVRtBj62eVm5gWIjeplJnISkgk81rfER?=
 =?us-ascii?Q?shqXaxyMDCPUymZ1F6eOoqLFJmuZzTzr9jU93Cbnhwhc7kqChjJMIRjSIJ3x?=
 =?us-ascii?Q?t7eI2ktRFu1/ogshk4pSdDShT5MozunAYwycI33N3gJMni45MmeWTd8Tldgi?=
 =?us-ascii?Q?v+7V015tURhduJgu3l1OofWufRw3kkYC2i7dS8LEzH77obvsWPg6Q2g2yT28?=
 =?us-ascii?Q?EOiPBNps3DLy8NOcNBn20+8EnV5oobTA90D0bH+2FRzNCIuSzA96soVoTsya?=
 =?us-ascii?Q?zrqrIHNM5Ga/Trw6M+MMoi0ua75yLZaOYaJsU97l4dM7ur8WRJ+f4HZl5Q22?=
 =?us-ascii?Q?laXb6WqsjVH1pEvEWMn/IG+gtySItoLf2+KoYbRe+kXEzjC+rv30hhoiSlBO?=
 =?us-ascii?Q?GSYh1U2sbeTloAQ1b/vd+z6cA1xXNms//0TKM6NQf7CB23vsGLtW8R7To2oy?=
 =?us-ascii?Q?WPvW0j74o5QJWowZzBgNXUZHeEmkmHe+T7NMPXCirBEKes23Lj0YAZyQSKXV?=
 =?us-ascii?Q?ivY65nIW3LdD80ycCnVDPZ8POWkAFt/Og/No0XyOtg8hUQHCGa4M+iU2tJsD?=
 =?us-ascii?Q?+hAO6t8UYtRDIrUN5PmlippyfIhox60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3AB06ECFB3113941A6B72EE19621ED12@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BHQcjwBic0hnItpGKDRXuFDsWhcYDF5bEDPcFWz/biMHld1dzabNn0iS88r3Dlv2oQLo3IivZv7yw44DREVM6WJMPAsWeYxZvrYpA1p8cGHLlVwg1GoZtvHWYMSqFf65DVo0AUFWfhz3fOkgx/dTudS36l4i6bEGTpMlF+o1Yy5v1u+JXo8W0xX666sb1YN14J1fo6AeailD2jp4CV/fbs7+A3xIM8ThHxbU9d5s5DC946ykr5uMkvAthAAb4tfSa1/uGnxs+OWL+3y2f4w6zoz48HTpuKkQR8odUH1uLbpxcTBQIfb4lGWbF5XSV3ST7BdCUPYimX/8z9gXaQ5RbA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lMvpk/+iEA/T7zLljgrYyFL2VWOpj4bNwQFWKQ+sgqFBjbn/oKStwAmbr4ieSjkSOMbffYoVT0ALnGbqDhdM7Lrfuw0SyxWN711aQJnPhfiWs5A83lokXGxULbFsoFgv2/E4Yb4VkZGiMwLb9t9FYSVTWFnI8ivIfAWEMW9IIUSmpVuhF6gu4H+U/7BZBaLrbwGOcC31km2OFshA0ut4G6NHZ+5BOQhcLRr0rcF62Y2FoN6f8yHQfN963HY55tPJz1UxVUFfh/f/aMglmq33FQ9vbNLGCPFX1FDGnbB6QaVvjC/HPmK50OrwSkp2F38HeytVJt55beBF1btgNfa88Gb7RW+pDXggJUqQD9dt4CiiLou/cVDxl8vY2+E+GlDl4YViGGdpgkxTp+OWImdudAeLoTfTRbt5nsvPLZjQW9V2+ZU0GoIcQMtP6rzGn5E6U/9SNTA7yU9QPiA/nx01nk245kSO2cf/vmYzeF3Cg11GHLjmq03T3OVEcw+qicptQ89wLL8j2OkAlp94ldCGRSYsGWKd0WKePgoMr8QvI7u9PMI9nIUpaaAm+I2MO96fp8Dc7rnIYA8oYHJu0oJtUK7z5117nFRuG33m858d3gV/LFEaOmeHglP0AJVWeTwj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198a2473-879b-4ca1-b4dd-08de92252ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 08:35:52.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2gxth9yq9TuOVvTAdd1DeJt090SJAEi/VElHCKA67HvGNDxN1ZYBbv7ZhOWaceorNuQhD/Y0iGMkqt5qK0YEIFbuPV9DputW8iKG25P+8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9737

On Mar 26, 2026 / 10:36, Bart Van Assche wrote:
> If the dio-offsets program detects data corruption, it reports the
> following message:
>=20
> dio-offsets: test_unaligned_vectors: data corruption: Success
>=20
> The "Success" part in this message is confusing and is reported because
> the err() macro is used incorrectly. errno must be set before err() is
> used instead of passing an error number as first argument. Fix usage of
> the err() macro as follows:
> - Change the first argument into EXIT_FAILURE (1). According to POSIX,
>   exit codes 1 - 125 mean failure and > 128 means that a program was
>   terminated by a signal. Hence, exit with code 1 instead of -1 if
>   ioctl() fails.
> - Use the err_errno() macro to set the error code instead of passing an
>   error code as first argument to err().

Bart, thanks for the patch. Overall, it looks good to me.

One thing I found is that one more err(EIO,...) is left in __compare() afte=
r
applying the patch. Should we convert it also into err_errno()? If so, I wi=
ll
fold-in the hunk below.

diff --git a/src/dio-offsets.c b/src/dio-offsets.c
index 9fc7b92..c40ce68 100644
--- a/src/dio-offsets.c
+++ b/src/dio-offsets.c
@@ -131,7 +131,7 @@ static void __compare(void *a, void *b, size_t size, co=
nst char *test)
 {
 	if (!memcmp(a, b, size))
 		return;
-	err(EIO, "%s: data corruption", test);
+	err_errno(EIO, "%s: data corruption", test);
 }
 #define compare(a, b, size) __compare(a, b, size, __func__)
=20
