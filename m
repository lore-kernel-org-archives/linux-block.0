Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50672617
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772411549; cv=fail; b=OXcqmkd0pelTFZ3dYCGVlz2QfSsedEroEsO1mzGD04M0rbXz8JHOKfRiD9dOgY1P9FoOUTJqpenn4fRjDkiUuG3Mr1VkjY7rXQcDdlJdCXUHh2j6N0fnktnDtE1oGwphPP6ZswYT116qGWunwp+lb6ds7YQ+BSj+BPINHohGzx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772411549; c=relaxed/simple;
	bh=3sFOE3+NnuLnJ/HZkfpVSJhTMmceOdUtlymzGg6cDMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrLO0CJKIeRopDCBgSL8qGIp/3Fy6/1l/FNK2EkOo85bSDCWHuhwZyJNABxKdOUkXuvFBkvaNEu7G3MHgOuczl+F75oNa1HWsVnkf+JTVJ23GHnHjwkeoXGjjIq7EJgWPoeq+fhQDMPZBKpFQSBwjHJEgVX4SuYbI1ByFF30tgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JkEeT5y0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=v5yv872R; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JkEeT5y0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v5yv872R"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772411548; x=1803947548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3sFOE3+NnuLnJ/HZkfpVSJhTMmceOdUtlymzGg6cDMk=;
  b=JkEeT5y0BajMy1i7+UCULrv7cuXF+QaDvo/YQ8eGxbwRlNKL3tRNOWjG
   zA0shApbruVSrzqG1mS4jNze1VQVdBI3OzuJ5W/aDQZE/X0Lo5y3dhUx6
   yr5umOp5oGXsMmvHbZG+Xg26slI5KU2RVvODZ131K56aF5/jvxWgZlDH8
   P0E8YTOc81esji3T+Al11hi8ejC0ZJyCRFhPJicNwfvIfBaZAwhTORpci
   C2AQUPYfWecOTuBUQphyELGx19cagOIMvy+FNJP/cXIEssnURtOL1OYz/
   dzUsIOpMIxBT9e53OG2onwR68usBYPnx+gSkx9fODtzxPmdFtwCTQQVAl
   Q==;
X-CSE-ConnectionGUID: v5Tjy8LwSOuLntJ38fdH1g==
X-CSE-MsgGUID: Nc6FoYYZTWuu7MO1Ye7/vg==
X-IronPort-AV: E=Sophos;i="6.21,319,1763395200"; 
   d="scan'208";a="138092715"
Received: from mail-eastus2azon11010003.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 08:32:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqK/TgoEygozwy/UcKT6q4DYXhS95t8KWhSMZcQAI4BF5bOWPfiLh8sj2ts1xyK4jucPv985OD98YcKqoa2DUJmCe3Hh8Qg4mMaM1t9GmygfU4xO7hVv/q2/Q9J2QOPKPxpaEkgQsO7cQl+b8SC8bdAAutvdO+X5XGi4LpMzYk8NXb+BTsTwETLkLhZ/hxH3cwEyls/kZL0aAcJOIUvfFY6fkQZg3UXbABxSrOaR9Oh4+HPZLuyqcgFp00IjVeh23WYfkqhrMOQoAb+MaF6PHRiL0DPcL0AxApiFcbC/WiSmcFEUzTpbvGEbrN6qBnWUbokooGuk4q1nq3fw46lMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sFOE3+NnuLnJ/HZkfpVSJhTMmceOdUtlymzGg6cDMk=;
 b=CJuJzbsIihoY2ETSh2xR4P1M3aRRuvJsT+9chVw9GIx6UGBn2N/GPu5XZe7VAa///OUWLM32r9ghDtlNWELovZzSS+/WvdbJ8wXPdugem02yig4QcfO4ib1QdrWp3Xtp98kvi1q+nJHZtiz6n5idq6APH0R/6cx1UWxT+L+1tXFzC0zZ4gZZU2W+nLBcSBtaeDFplJjz4dgbUKWDAHgCEXsk8S3/3lfI5p62+zDA4RggwWVDuEYc7+Z1wOravr6FSf03i339qxulyd6NGOgswa3A83BY4sFYjWdmwUrO6bfsJhQ0NSYPVAxjSEdGI1q75lG8HYcG0mUfEsqDJQ/XoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sFOE3+NnuLnJ/HZkfpVSJhTMmceOdUtlymzGg6cDMk=;
 b=v5yv872RBf3luFypTbIXKjwLbgjmzhwQ7Iaz+WTNCpgoHMcYAV3n1espEqwAGII2dGEKsdB0y1gvNPzQGLEpDJ9c3Cdv8X+7sQ/l34/CMvSbBy3emYZ+/oz7PVnHGbgDov4prSvtczCEiGBAsXlrdvv1GWhw3TdVDR9loAmL67A=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA3PR04MB9377.namprd04.prod.outlook.com (2603:10b6:208:514::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 00:32:20 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9678.011; Mon, 2 Mar 2026
 00:32:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests 0/3] misc fixes
Thread-Topic: [PATCH blktests 0/3] misc fixes
Thread-Index: AQHcpJfL/x0qvS56d0mTe1w7NrqPdrWabt6A
Date: Mon, 2 Mar 2026 00:32:20 +0000
Message-ID: <aaTaYBwArYL8kL9d@shinmob>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA3PR04MB9377:EE_
x-ms-office365-filtering-correlation-id: 5021c74e-138d-45ce-34bf-08de77f32a3b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 jXHfRUNySKotphj0TsCoPfd/0k+BlFTdu/OVj+i+1zRH6zF1g7+CL/XCH3hl3q3d987IQNyhcRpE/zpQ3HDYh1qcWvhbbSlUoTuoo7wnS7ly/TQanPEicvwPKhsPCvLf40UrQRgLOv3HB8B/6GXhsbQhNcEOJn2fJ7R0pkJR7NoAEs0W9L502P+w3f8i1e9ZGHdo9TrE2sQHXMlESOQI1hpDzi4J/uMO298Hat2yuVpFGjDrvAg6aix0w82sENLrgtTPsSgKXDB93U7xg+ja/UeMR8DUkIhudqaJKXxWEcwFIGMrhPukxjcEnAwF9PMuUZhyqhCq7tFbWGV6scjJPEZJziWuBG0PvVb5ibsw/PAyfGEzRGCuOZTbPhrLah/Y4RJrgIQiiNw09Qn3Hv5A4JFR4zOOTJ4b5H+W5CT2e+Gr3o10KYkAg2tYzrzfPWhXIVBjSl7Mx2Gl6+ypcp3kgupK10VC/PySfKaJ5+z1kk8zyT6SwWKEOPhTki4TMdlWQkJcq7KaDYxTVwmrplhNFxXBhPSHWg/+omhhz5X0ztayNTKzH1SXeIgiDXS4GEjMg22tyq89W67MQ3ndphHAmpgGgsoxXJjGo6oM7pM5GkbMJckS7S6j4op85R5FUyN7I7+87Q6sQEFKpakFZmfnHC5p/vioQ4bMFFGsoiI3ZqO21mWLi14vKg394KW7p7HOYdoZZVvR3j24+oDqzn/4Aq22d3IpPABqKXZ8BoYOMlRm9RvPsvyx3+RLKVDHy/hf8iUuOibcG+j1tNCKxLuNPpoCVBtl/eCDUWLslN5GaaM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LHdxMG5IHN8Bq44WG526xZHDNViB9MI5E7oOxsuMc8/PzZu3ZrfWixx+sXN6?=
 =?us-ascii?Q?6sEPQmchPYmEmRbG1kWJnQ8qe6dxTaHQt+emScFy8dpajE8woDLkhl0mwtoc?=
 =?us-ascii?Q?xqFyvphwnSqAEpui6o0ajWeOa//cLoQBIdrTrsix0qKNvvBK6aqiP3X9Kp5N?=
 =?us-ascii?Q?TPDrzet3a2ALH56UkLBThfRZESJyT4vSilSomO7siHbZUwqj1RQeBBUcZCCR?=
 =?us-ascii?Q?ZDDMxB+/1yqKSSw3IkxuVX+cl4Bz+3vloFy6SIAZHmy/5oZYSM88gL3gKENI?=
 =?us-ascii?Q?7kBpUMM/dCo4UMAjkRoHAB9SXxzPH0g3HF9/aoANMGEr4+3As+tsRCXS83kl?=
 =?us-ascii?Q?GSFmwVtB7pcMqAb5anT9vVg+ztiPYhrZgtk08V7b8Kinr6H2i2VsEYtN19GC?=
 =?us-ascii?Q?0tbebyt6+JS2upNGIPkWO6F+vZJX/gOBMuxswTRP63xpuSfenWMhGbaAYglo?=
 =?us-ascii?Q?Fbld7J3q68R9AETRxQBAhbcqRiccxEQeHqG7xsnBGTrrou5opsSvh052DG60?=
 =?us-ascii?Q?5tLH2WQO7CbNFqCJoMUMP8DAaS3A/MXl3fPSrn3gJ2fl3ELernpUDg2pPQ5A?=
 =?us-ascii?Q?HoG3dzemV9/dZ5oOSSo5GIn2cFSOYjgyrUd7O/8upJOPoGA61aGgID99BU/k?=
 =?us-ascii?Q?NYe0bIvadydM8ZnRIuoJtJCqclCW2cPW+BUc2I12iLnnIE+9hBOjI8dHnW3I?=
 =?us-ascii?Q?r3fqEXbbMBGlD3/sOspIsMKqhfoKR8j1q5HuHHN8JDpyDoiiQjWq8FzAeMMJ?=
 =?us-ascii?Q?FKNebiwIH80bnVgfMUgyI0+yeX3FT/vxiA/yRSDglzMKkTv7pBuhGNX20+B6?=
 =?us-ascii?Q?NlsF9XYl9F+647InE/e3WJYHTDdED6iFbIsPhYYyaligEv+NSPVnOgWOUel6?=
 =?us-ascii?Q?UqmvQuPszz3938E0xwjpvY63Xg82mpVjTZfdg0N42Z2rW0DZXVbV2IpQBteU?=
 =?us-ascii?Q?Y7xMDa50BcYh21QK9bPj9nXnWsrvBlPjukOLbyhcOat2pKbEnps0nOrmtfzI?=
 =?us-ascii?Q?4KeU6xjFApGc98l3lx4ugSMy7irpH6KVoH6nmGg5y5eGA9ztJieKyeGFnxMV?=
 =?us-ascii?Q?dxpSbf4AGxxWqq0jOvm3PIGbfOBZr2MYdgKxo3iDh0I7JQ39cOf8OZhSXzK0?=
 =?us-ascii?Q?aAKavsqHgxIa5eFJ8BKs2O5+joNWDOAt3kg6XMtcEjR7iM518Jk/5nPnBZ7m?=
 =?us-ascii?Q?QQR1iJvjqvtCuE7NErKrL+sh6s0p6MYpLhFgAWGdYkr6toJ2ZN5rhQ5fojRt?=
 =?us-ascii?Q?+HXLKJR7BarvuqPGxU46XOq6y9KXj0V75gpUEgqK+XWT7+STheuMFy9G397X?=
 =?us-ascii?Q?tay4P+R8gofsidtbk5wkYiKqRI/FJUH5/YcBz2yuu3oaxLs3IaaGoP/jULmm?=
 =?us-ascii?Q?iNZYHjNbWHsBx+YIJMJ0gBHLMQ7ert6+FvLC+rs8aJllD8NTpQLp/765/I9R?=
 =?us-ascii?Q?xRoMiNqnqnR61jRTdEmvXypoLnpTN1I2dYNGcmiUFA0k8CAVnQvRK50wL/Du?=
 =?us-ascii?Q?aq9PRO549qf5antpH2/+/1EMlu99F7TPLXnrckT2EkDfaHSNqHkgBbyuyUUH?=
 =?us-ascii?Q?KX2DmB9GONjtVk66JW0y4g3rZdK345VQJlneYo9+oOiLAjDbyl9fCSX49Jfr?=
 =?us-ascii?Q?YdRkIjuAzGSwPV+2oPzwlvYkIwMMqzjGFYeRfVAuYQL9zLuO87S7I35V+GWh?=
 =?us-ascii?Q?funycjh3p2aBFHjMbNS8FDjtjP0Hz1I8vcLTniME3BSV9FKOKir8r4nY48FQ?=
 =?us-ascii?Q?jtM/Zr9Mnx1/Vm66hjw8a/GX8q+Bg14=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC3919CE53745D43BED8CCCEA2C45234@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z3fS1FpaDCZQNLYtEJWROBuvIr4Nzyvq4Wc3+5NkyDfK7hahYYKKj20qCVs/T6bBamx2JB1Qql2lFr5Ln1haEGbuf3aYSFvLcnsLRD8yf1VOIK4Ap/wMBknswwwl/ftOvIJX734eHCmeS4ZICpVnlrvxYd6VAdxlHTG0fgm0nkvbpnHzu+BllA8lkrUTisTz/DerYVWVKbdhL1hIA13YYnmZanS+EnJSmf9wCdQl1yVjeY4nM1//bTga4++8Vee42cYQK3Hmmml+Y/Mn9WbYMWu91efi47Mye/h1GqIn8sRhvDsZR38npJPw1xdbcXcCnAaPLm0Q/wtjKPQUJuRC4bmqDFMak6RgBdgHHpIw8E+PL0Nl02iMOQ8rCpS63GqYN7p5mpXCGYlSwJQklCpnrBGPN/0kVF3PS3FDul1abfySP5uHdcfcZRy0pw/eMe3IEHQorV5HhbUer9nLKqB+SDC9w9bAjU9aAKllQ2XEpLSsBP/kDe3Og8DIod5iKuF23A5+812S/y5kR8EjjEfjj0sP5Z7Y/+2la33qM+zcGCsMnsuT65ImsUlbWUNbIZf4Pp/ZjWSXDEUtoY9ryBcf7fzDwijl3YWOCpGi6n8lgp/s0fKQuhnneiVSpCg+rFV8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5021c74e-138d-45ce-34bf-08de77f32a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 00:32:20.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ou4XrKtAIj9rsZYq3itmLV++K0JZJT7gIT2tywJ79lEEgr9hGIPQmb4A3CMTp+DK5eSg2/38pkNeXSysDZBVGp77eragxqAWi5tlUw5KvOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9377

On Feb 23, 2026 / 16:41, Shin'ichiro Kawasaki wrote:
> These are miscellaneous fixes. They are not critical but worth fixing.

Chaitanya, thanks for the review. FYI, I applied the patches.=
