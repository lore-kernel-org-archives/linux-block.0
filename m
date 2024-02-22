Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FC17548
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574458; cv=fail; b=Zjl6um7podqvsHnw44BCyoQvAqPkLcNYjUg4kABrjulXKS4zPYLfLdWt7m9LX0xkEw4ctAuDc77gdtZgfwJU8mU3AAJK7WP2LmIWI8IjQIdgblvH+vxUw793HPpjDarokvfEyoqHk4e/E09nbsEsnTyKL2KlXgNW7GFbLUSThM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574458; c=relaxed/simple;
	bh=lgtP0pwpu6wiA/6IgqZ2yvwBn5ACyTJwTdy8O1ISwUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l6SSBuHNp/Lnx/dpERSur3WiXkiMdKXnRfFU31hZdbV/IyYPsqDf7CgdHhEnLj2N21TQDz3FUlTojGoDcqozfN7nQtw4ntt19JWnSvliXZb8/I1Ac772nXbAtQh+B/6ZjEZpch4C4kDXWLnKlneHAmlllIwAuE4inuxe2zpIYEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ROCNIYXq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Omcc4QpK; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ROCNIYXq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Omcc4QpK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708574456; x=1740110456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lgtP0pwpu6wiA/6IgqZ2yvwBn5ACyTJwTdy8O1ISwUI=;
  b=ROCNIYXqfM8tH97I2MHhLqY4k+QNe9WarvLsxCaOvNUJlGb/rIO2nFkx
   ZJtMslG9sCiETCZ+rTyVphoKJ32UI7Ohk/EGKBMXcrXW+9gon8Qql9cPT
   ddSnbLmMTiQcInwF/kkq59GNio5VmFwBVrRE/huFTgzYdFRrTaBn+UzZr
   OLiwlH9QuLEZM0g5xzZ15MRHpN2iSNTVBKBhlJc/WDIf/8Gn6Juv0bgpZ
   tx3OlW2rCgrtizlt3CKjD7ghyDBpahyslqUYHKmaXn9bf/6T9XzNWoNfU
   5gdXS//lRn1T48zlnU1dZ1eMGKuUOup7TImwUXLgerckckzob7hLtVREY
   g==;
X-CSE-ConnectionGUID: zDuQSLMaRXGLICAWdSeoOA==
X-CSE-MsgGUID: XA1m+nKQRrG7nUEfJANubQ==
X-IronPort-AV: E=Sophos;i="6.06,177,1705334400"; 
   d="scan'208";a="9879001"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2024 12:00:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWANguc6PJy3XDJBDewXUSF7PbpErAbmnzT1afQOpumJvbXfnEvBWg6HLNrgDiy/OwNo/YPPUhUfEkSr/2ExGSrWWMzJ0c/JexEbOtrkAO9TWyHWHqEI7sKsbl0SP7M2Hh4r/lq5rukyjwVsGfnDr0NZhB4HAqjgfYnTLvf6rbJKIXkDZo1+rjWsSmj+Kcg5ZVAMTNAyOHLQXmXV53sZSFSmtCgZvy2ZLfT9aRqBToSu3IwYoOLmF76fOLJXfs0tmVcC5CsrmNdJ0tpEMX5no8sNPFAWrvr3QZtvZ5/q2rTDCwbta+pMDglfs+IJQetD1kI9j8vp9wPZZZKQsquvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgtP0pwpu6wiA/6IgqZ2yvwBn5ACyTJwTdy8O1ISwUI=;
 b=BcQXc7oaiypPuh7SsSOkjJxlRrlxRtQNAyxspc+jpiI+5EwJMdDkOUsIaLaQEoIVO4yaXJz1Ty3PUnRsYsUWHirO1kLu0Nd9qFMph8ovjj8aAOqNYIXGyc4j9sgLjlpgM11ES3j/kKPt3o3MZ7b+Yze2LUxCZ63Luzup5zUm1i6d74PhjnxLItbtaAxjvqm4anRVFMfKwIExrndR3WJHKiNuMmOl2spUyXmStuKuotrnCYUoOqf+ktzB/Upgqt8UuAw4/s9k7d91GqNvbwGGTgdwWSufPRxQZ04nTykW3k+P+Og5UWwEe7xlmJesNbHAuHfLUNl0fLhtbSwG8ggotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgtP0pwpu6wiA/6IgqZ2yvwBn5ACyTJwTdy8O1ISwUI=;
 b=Omcc4QpKVWWEVZ2ihBj2S3w4RrWg1Nqr8lPkco+0fjMF306TDwqUS60ij2tWxqIKhgSm4UKqtpSYTiEe3SGpDz31LuCQ+D7NEhANa5e8iMYnGD4QHu8TIUdtg/fEgytuBW1/sLLcnbTxf+pXqRfw8BphYZYhdud3ioAP2cOV6C8=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CH2PR04MB6646.namprd04.prod.outlook.com (2603:10b6:610:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 04:00:51 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::fe0d:ba64:1907:5785]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::fe0d:ba64:1907:5785%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 04:00:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests V3 1/1] nvme: Add passthru error logging tests to
 nvme/039
Thread-Topic: [PATCH blktests V3 1/1] nvme: Add passthru error logging tests
 to nvme/039
Thread-Index: AQHaZPTCCrA3JZ6C9UOVWpRVf8dhDLEVvYeA
Date: Thu, 22 Feb 2024 04:00:51 +0000
Message-ID: <jjeihv5bu6pxsunhm2om24u637iu6q2ftdtaarh2blwlqzrxzg@g53uah55nftc>
References: <20240221183640.3432605-1-alan.adamson@oracle.com>
 <20240221183640.3432605-2-alan.adamson@oracle.com>
In-Reply-To: <20240221183640.3432605-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|CH2PR04MB6646:EE_
x-ms-office365-filtering-correlation-id: 06503cd6-e2b2-4831-e5b3-08dc335adc35
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S2EkUVEIie3gUrfQPL2nw3+vh9vSLNzSbhdV2a3pHN/vpaEJdccixFOwulTtUbgWJysV9BobNPF6CJ+IDOz3Ujo2dcQzkCc8pY11sxfEuwrs+uTlrDFYe/p5Qs94i6qu67IUoNKWonCINdsXO02pIF2ex2PC+LlVvZ4+8AOnybcC472i6iZpce1Hzq/04DSy6byIoq0CGwAVeG5XeDlnJF7GCyizjxrOr5kD0g70+QWbZx+jpmhM25/tRi5T8Fy+ogemXBtG9VrX0CCwo8QUFlJTTvMaS8BQpfDBHRf8bMPLvqAO58EwOEGjBfx5b5WN5ZvX1mTezMMIkdMFbt/3RbbXInD8oLgoNlBMhWp/AvOYFAagj6uqB3ZJ5Puc5fT4sKQiufArWSIaaALZaYfH9UK/HH1sEHmHxlk4w/yrqAIoMUN39DjwkCQLPeQsX+e+YuIaFpzxvl5C23ttj/HQ+8jbUQvvUWcWqNhr2mU0U9OGZHPs/a5NNf5P2h/zx88dOukgxBw7Cvbe9uO8oHr0AjifRiAIZbqWZzzmfgxOXh52Gg1PK4I2rjbGSh/nS0ovjPY57SXlVygaZ3wC53xZeB9NS9XfrGsYkof2L6elGPNVDKG1F+kKYsDBVDVbPNIg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jRxeoTSWDVKlojaBkOG9/PRM3rmm83eFIIr9NRb9SaMC0X3Wwy3qmkHuOP48?=
 =?us-ascii?Q?w06eZ1Rjl7xdUSv64b/u4jq0XU/uJXo/Vr9D/zKY1puJ53GIaT90oHMatqd/?=
 =?us-ascii?Q?/7Pe1zK/JeNLgulMr25ZLqj7/agyZsyEyekLuSM+ddhj42W2vH+EJcOMhU4o?=
 =?us-ascii?Q?3p3Dbxlgh2yDFcqJdtY57UW0b1Z35i6As2Ke/8BBPDfP73ad9pYTUM8ebPYQ?=
 =?us-ascii?Q?FoQ5VGT0fwnItS4D6FSxQxjpkGfvZC6vCwOXO0zgluPWPYJPKBptIosod4hE?=
 =?us-ascii?Q?IIE4iGPmbSbHrn/3zIsO3lxJwuASXQAOUgIpDJoKPb51lfYmnWFi3WRy1RJX?=
 =?us-ascii?Q?bKEOUGqgkDDJ4/gtXVMk8ThKxzd7qaw4i/V4fz2ldbBXBo1K43OD+ci/fyfF?=
 =?us-ascii?Q?uWc4mKJD39my717xPVG7ckqkzVTQE6WYw3smR+SkbAGAyFZv4E2KbdTTpuaw?=
 =?us-ascii?Q?TDc/7iTpQaffJZCLsP6cLorpy/F1Pr2RnnV9TDQpiT11Si8/hWnWLv+Svty/?=
 =?us-ascii?Q?l0ktoM4Y/AEfea0kknOgfOV2HbXoWQ7dLGdD0hmYFM3CP9ixu1YfTKgxeM2S?=
 =?us-ascii?Q?c/cm5bCsBlzWmbAfbJjUUxpDeZlYRuq78q6N5tARUWVcwunUObJqP4I72qZf?=
 =?us-ascii?Q?SeC3wDlgLftPxyvD6lfTAbOMumO93oe1dS9L8+6XvgRjDejBftvvzOhFVEoF?=
 =?us-ascii?Q?q6n3vMR0RE5lJuI43RZwmUnpuDqywwkNkBndMBHF3+XT6nsmEzuKy7rPCeHP?=
 =?us-ascii?Q?N4OWksgOKO2SZxWb8lHP6piFvJE0/uPEnUAZxahbaOl8V44Z5DCm6F6DQZoT?=
 =?us-ascii?Q?XAJrZK8fBHkDu+TqFfihU5Sifak2MLuljXxLMdafuMheOliRLWGM89JXqoq+?=
 =?us-ascii?Q?4OaYUi05MvXWwQ4wFGkVLuKzM0CH1NzOQdaq8IWW74pCI5jWE5Avn8yd69pB?=
 =?us-ascii?Q?MIuABvWyODyb2j7D1u1A9QcVUGqlgHavDa3N0ccv9/AnszLB+Y/wx/Qi0GPP?=
 =?us-ascii?Q?yGx3KWoak25c1tokQleD+51BNhHrfqospNcHwziYIq9NPwiS4zhJ7Er2fJy+?=
 =?us-ascii?Q?ZU5dmUuC9a684SrQaeptOTBXrjTjJDrqTw5d5wuF/DAhUnJmrWnR4+XIrOMl?=
 =?us-ascii?Q?0z6cosLZE6vjJCXXPwlqLU/GryeLeQayVkyIGPgIsdQa1kthlBynPwo+stQe?=
 =?us-ascii?Q?Kn9G9wqFzaW7+awS4aHXds76As0ZiWt3rc8SzAuen2VuRrdNVuwGZ83Rmz3z?=
 =?us-ascii?Q?tfSw3MRJBd9m3wC9B16FsES7rKrZw/nbzIEea6gWf2gHOVs/bHe1HQJ5UWFW?=
 =?us-ascii?Q?dnCjWcPQ5AKzeNoFqyJBVc17ssI7JP3U8Nq69wfhNF92mcWhpQjNF+b7wSDd?=
 =?us-ascii?Q?oBjBuRGvbAxU5SKHvQ/OHb1fJLe9/togk9qHt5Ge2GghrTcDGfjlkBcH0/uf?=
 =?us-ascii?Q?AVBgQhdb/rAJT6OKIFLsvQKkbA3t77nonKU9VZaeSahcOlAkPEoW1WSdWG6a?=
 =?us-ascii?Q?hLwgYY69kVluQSD5p/FAnvYR0gAZa2kzlbzvqWNSD3va3iUaBwip2LHMcANA?=
 =?us-ascii?Q?ENPhgBYX5vMBmy3/B2YXsWzomU5cvE4gKH9nMYttfTNhRDhvrbnOZnrA+9P7?=
 =?us-ascii?Q?igLZsXwitBeV3rKuigQ5kz0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DBC85911CF2CB45928017F4181462AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VnrZWt8bcBSeZqh8e6lFgjS4Hq55qUyxza3ATvGgvUTnNUPgBqaDOV0PACPqx49mgDqv0wz+t2j423lEHLykLiuWOm6z7G0nz+HWcpZwz9LCELZYfOkFgtt8V9fnOpNRrJ1dIlgMxR/BDrjE5o7h8Ndw/za/FA5MRhfF8j64RJgRhX9MD3mrdlBzMQeTvfJChvRNGcEOsciKTW3ilZDuNCnzirkrH1CeLgYbyo2p61qUPTJ07lkrFJDzPo6IQoLiE0fZA+SI80vfwt/ZEoWluZZZB7t4Pb7wg3Ep92yyRDTn5rh1jpBOJEeWIcFygMIb5aPOLJIbWGwwSTaunrZ3bS3igkChmepYm0JZB6Lzhb9K60oTQjVWK/bpyinCB2N3B+lL2VM2l7kTCQHTA7ChVDxACHH0w2FEEgpqHXgPJbx0pPp0wazKGC3sKWwRg8Uxg0UPuTlwfcRD7fLEO01HTibMig0kOYy1RlJ7nmSUMArLUhcJs8H5phFCkBqxyt5FFAQWxrT5A78HdZ6Z11uTxnZXGPmmk7qbmBdCx/f7W1NfY2sJLB7l2h6BelDsU+zok5y5U0ccIBu14P16sSceK6oEb/xqPiGhPBFkoM06nZSVj5PbboJQ+minsX2WLzGi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06503cd6-e2b2-4831-e5b3-08dc335adc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 04:00:51.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbKi3v1NnjPmH3QxuUGgU3CxmEoVa4XQrCvSeRU05uPIR7j0Nb9up5fKgMqAvNgVn6yUFkcA8jA0/HlKFOaXrr31O8zeH8P6pZ+vX/OXeoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6646

On Feb 21, 2024 / 10:36, Alan Adamson wrote:
> Tests the ability to enable and disable error logging for passthru admin =
commands issued to
> the controller and passthru IO commands issued to a namespace.
>=20
> These tests will only be run on kernels that export the passthru_err_log_=
enabled
> attribute.
>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks, applied!=
