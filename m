Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEB355F21
	for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773989261; cv=fail; b=rmMmiCjiWoeyiQ4Ql6GR5/KjIJSlzC0kOavczsrzn+wDK8tzZhbEhtCLJnjkIbyOKNwz6SZv2b0YTttsIMwBr3EIUjqwZ3akamMZrmHh5I/d+jWpzkYaqPwQT+rbLs74blWp+mfuBWbkMauru9cpYDdt4vRxXu1DO3PUGEJb7Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773989261; c=relaxed/simple;
	bh=7of173tzT2nPYwXdzxfXD2q3EAmxBBQ4mNX6vkP7yRY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EgT79Fh7ISmlFKHY4X0Fvsc+IlJRol+vJlL8+bv+56HjJCTU3qavbldOelBPuu45+09V3Fe4cDqYBC5+wbDvwEupd0k8Fel/mQrPPv6fsG7e5kwC4DxjNzlOn+sUu5wRLrtYL8Q6dRnX4wX4ShJo5Dty0wQNHQNIMAOmh191MuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OL86lVJb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vfXqWiw6; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OL86lVJb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vfXqWiw6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773989258; x=1805525258;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=7of173tzT2nPYwXdzxfXD2q3EAmxBBQ4mNX6vkP7yRY=;
  b=OL86lVJbz7RtITx6ks0WroZOJK1PvK07cIs+kLEHQsif+Cd4euEKjkH/
   VF6ej3WLqTjnDLIxPjt/kK69POAaZVw/YbauiiZaUF01dHziXKaQAtB+I
   v+JjXQ9gGmpWG04uvBD0s/IQ6NWP3CgM60KXSAPD7j4Hp3J9z0wWqa7cq
   0mr7DhLkKVd5d9ReMRXlfvqKlOV/ZuTHYhXs8uXecgQl1S/5sItliDCI2
   lSwK2gY9UgIdQO9qlZguv+PnJsw08M+DRpysbZMTtOnKS1WM9GgBnxqbs
   sr1/WhiG+5WQxWekGAbxzrjmR+rDvC7XP5/ODiXriZho4Hk/N1Olw3V9O
   w==;
X-CSE-ConnectionGUID: HFzGcQt3Re6bBY9fT6wOSw==
X-CSE-MsgGUID: LLBIDhAxQN+D8vd0JwXPqg==
X-IronPort-AV: E=Sophos;i="6.23,130,1770566400"; 
   d="scan'208";a="139229249"
Received: from mail-westus3azon11011070.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.70])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2026 14:47:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTk1hGT8QdI7VCx7x7lnXx7ezPvyBTNu6dDGyKiy3ABy6xNs4asHU8ExcBJ2pucPYVTreeE27wOf/cIZa1Fl4WXj/b/MGh+izTfgokK0JUg4miB1B+srDNdIdfO4VoURUVIRBUoycOex366t513blLPx0Is2u4QOLenaaVjiZ3WJFiYP1Le/ZqnO0CPE7WHDkyXwy93CXuo9g33DTQKQmVujWnx4Kri10wtMNBNCMAQtcXJMFkTmzzpdd3ZnUt9MDvn/cnJIZcBOxJbP9CjqOUiLZ5IFgcks3khc+SJXlTvbveSfQIW85uveNBD/QfBElvftbWXmBxJhH72+MfMFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7of173tzT2nPYwXdzxfXD2q3EAmxBBQ4mNX6vkP7yRY=;
 b=yDIIKeXRneOaWacjfvDq7Y3hHnqRn5JLh9BZ05ZZXatT7gQ/o+qKenwz6Rl8Jlh9AwrXi6Ztu+Sbw008q+4AhCRGMLP1niZxPu3QC/25hJqWfgKj5rMkX62boq3exlP+eSO9Z59ul+95ZZjixv5qRjeoIv60ytZ6h/nRGeAaBfJwLHHgvMxskha9sf0ZBdfBqC0iihwJrZmknzSicQcWluOtwFAcNelLi9Lv/2TZv7TLyLfdqE7MYMfXNBho7iVamOyCjTJcyEH7WT+5o8QekCyYlZYeZpI9eCO3GHBnFtnS8XwuBoCTPxtzHTpymFvFaUsqatn6w2TmD44EYy6HJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7of173tzT2nPYwXdzxfXD2q3EAmxBBQ4mNX6vkP7yRY=;
 b=vfXqWiw6PGX7x2CyKcYABWX8jLB8ns1AnFQl6wKu/dlHa8wn+tNiiWEKxg1pPZSit6hlUBl5CQqlAg1jZRTWKntxuJ5GbN3XnMUKsgBPeYWy3V3OLmsyJOXFw3maJ02G2OlXVg6gIe72+CJIwW4fBTmMUuHaa3MUI/FzSq8pcaU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BL3PR04MB8105.namprd04.prod.outlook.com (2603:10b6:208:348::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 06:47:19 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 06:47:27 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] check: check kmemleak before test run start
Thread-Topic: [PATCH blktests] check: check kmemleak before test run start
Thread-Index: AQHcsuOUl1piwUOXcEOAwy5L8Ut/HbW3BQ4A
Date: Fri, 20 Mar 2026 06:47:26 +0000
Message-ID: <abztIkelWzNHC1jB@shinmob>
References: <20260313121855.3666215-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260313121855.3666215-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BL3PR04MB8105:EE_
x-ms-office365-filtering-correlation-id: dafd843e-41f4-42a4-1d36-08de864c8ce3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 9Tc0t37y6OpKCBduXFup/uJ2MOJk5PW+7maDFrj5oOqzNx+fN7hm1RJKIm1v+ikAp1sRdGSu99ItUUqWG5Kj/T9n9yYOVCrZydh6wJr5BMmqaKYoKQNjWeTvh+eCPa4R0ENTjopTVz6XqV8YaE/su8yoKdDjhK1Otgf2RpesY6I2zfbgDmtiTcXubXhpbE5Z+R2FKaRZSbVbXz0+HfP0mUSxHgbxQCerpxIHan1ALsHCGM/tokfiu/O/oHPd3tB4WdN9bvLigP3QTqrTEOhxK+L4Ur+4Zbv1F1pOLWWv5Ynv9iV4hZ8d3G9IisMwpKww/htb2CYMQqtiimQPfXgCRvtiWIjoP/rWSD3kBK4Ij7RzDGtBJe4+WMKc3mRs/oqc8W7fUrrLi1gWg/CdtGBb4Zch0D+pVEZZWq35Brhg1OOFeMi+jsgMbac38KmPUzaGlaifm4nBygZr4TlpEidbGXU5jcTLIb1VbuGJDNVbQwya0rVNAr2Z2BNb2IZ2lr8lOkURGpxqokRVoXNKdzupFNPTDF519VsYkYU/JI6dtthQZ7xgCca/D4tHG+XqUndTpSd8ZytiVTGid4u0ef8sSZA7QxggaoOSfIIw2fw3NciHgjxDK6EfRQatb9ucrJ1EY67NAWlIQpO8DoabQNTcq3KwXAtJgCtf6KbnF6IT12c/X3maAzw7FRFhtkfaR9NnKoup48i2i1eMZ6ZsiNctN2HSOOIZ4P+WwzOGEqIPKZ9Z5k5/v/UeBbCO9nXouI1Ktv43h7+LviPHsGSG+6d2pv+9nFfvSDUUrVShHfoJrhc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?88PPrgjgX/cpGhHNJRmRvtLezMG1Fpf13O8qOcNzVXyfyA0sUz+04u6ROZ4m?=
 =?us-ascii?Q?WZqLl3/Vhxq+lM9J5WIp+LLDOZNwt1pMHEt7ob2s4Geyp1e1q+5VjU8LansR?=
 =?us-ascii?Q?y6acBqGczZ4iDa3MxbXhfBl4Wa8hI4VaaxEnl77B4wTmznHj4Dm91nnkseR+?=
 =?us-ascii?Q?ZYg4NDO4qjowKyjg4n2HfchfdCELNaEPFUrypMcxyqppWKo5HmXlAEeLHv39?=
 =?us-ascii?Q?Vc9bZJHSZjrMAOD2AiYRj/Mz+0Ak8q7sTMESdh+3gDZjDDWokRNQ8wRlLndP?=
 =?us-ascii?Q?qrMLoO2TGlU9zKMG5lk0YCqoR9B88NQRRLgmkUi5lF8ZGMi81FFxHAj3uKKz?=
 =?us-ascii?Q?ghvKV5seEsemqxx3C/8TU33oE2HVub5wVywNmd1MBBRyA5rK5FQg1JWp4G+V?=
 =?us-ascii?Q?pLOlsuEiQYF99FPd8MmsE+FffIS1Qv7/ZmtBO1e05Yy8BZOGX1gNjKxEsfY5?=
 =?us-ascii?Q?bNum7NKjCAWank3sq5W8/4R3kcGOzxGoQD10X5JeKaboql1QooFw7zL287FL?=
 =?us-ascii?Q?p1nvICSQVEHYrsGu/1+EZjebbVKKO5+5wGU5uzEBiULp1/kPho0NCM5zfYU3?=
 =?us-ascii?Q?3ZdIdM2Rl7FgwOE9Qqqgn9DwoDjERQa5MlEALBpxndFhnsQLAriojDlwAalA?=
 =?us-ascii?Q?SaFg/EVKPpmH9wd61jp35Xy0zaHE0Fj4Jr5q/1x/1iUrCeE4Cj+wQGch8zkH?=
 =?us-ascii?Q?PZC1sXne9fqG/K34l0nLZf17hSj71gLwPeYkyndEeJTaATT6MeS4IQMzVHZ7?=
 =?us-ascii?Q?umeXRJw07qDVpb+gi5lY+yEkP/37IwP45akrrHU94qxfDLv6qKGcGC6tq8PK?=
 =?us-ascii?Q?CuEh5YAFjJ7XoN155mmboylhj1sWOGaukhewzheeJsYJ9+Spn3LFVBTj+dZV?=
 =?us-ascii?Q?OyhWyxOXjW/N9A1FB3Q/EhtKOUaTE5dV2DVA1cwZKWmuL+i9nOKUL+0DAiSu?=
 =?us-ascii?Q?7tgpagUHaIFaKGHBiJ3IVN8Zjy30pQNp3ftk3C1CtYbDIfaoYO2RwnGoXZbc?=
 =?us-ascii?Q?3tEmiW3vkGA9nOX82DIHttPSbvd+oL+6CU+E4fY1D/c1AP/iSyuhWNDzrdXt?=
 =?us-ascii?Q?uuSYyUItV2JXawNHuetzqdoW1xUCKLb5/HcgYEoG9zO+9UbDZgA3oB9MqE5G?=
 =?us-ascii?Q?i3nSZOOf/dBGW191pZidCUXSn9XrU4s+hn0HpM/eeWC6GkXUYoIqzj8+lbE/?=
 =?us-ascii?Q?Ch/CSwye/50arBQylkl67GrCBoS9HOyQ7TISMdwhAWy0HACYIm3wy+I47oLg?=
 =?us-ascii?Q?TBSHK7OrcY+yRZQP7Xew/EXUKQAfCdZT6SmnUCq/tFJWXnYl9BXl5F8+zCmr?=
 =?us-ascii?Q?3zEF12Ymt/M8W3f+Vn2qwuU3/lDNAUEhjEjR1TiDcca5k4Y/dOrLU5Iq263p?=
 =?us-ascii?Q?TglrlbS+DsJO4Ysa1SvuwmetrT1j7BLgwlHjkjv3HYoeqd4P5LJvOhmUEXr8?=
 =?us-ascii?Q?5bDZpcKrk+EjloY0S2d4upXT/kXD9ZCiOSCnVZ9BQGTNgCD0WrNf+oHMJjL3?=
 =?us-ascii?Q?YW4i46skLqPvKGQTQJULdfYcyivuLGqbMpL9swkQKPhXBPGwgWwj5pfiy93A?=
 =?us-ascii?Q?/DmVqlrL17qmJXTt/4vEd4zIGNHCnfysjIs5vh4vhaPW8f5AYdbImbErgYeF?=
 =?us-ascii?Q?5BuKcbKZbBnLIxxTVXyToPwGNYGg6h9IN26NM/9Ra7MabxlxFQ4jypzkX4xV?=
 =?us-ascii?Q?G92XQE+4fkA1Bc/Jv1jBVvtiXIAlSjqyzd4mKj0BKvtZhYf/bnmaVij5e/vg?=
 =?us-ascii?Q?NhWOS0Io1+le6R3sVqMuIet0K3m0HxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7560A6E7508E4C4884E01DC3FD70C4FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VWoHeNaG1kZh0WjCXeTD+SaxK9cGGOaC31AgsxFUPIt2kZN8ni7F2XtbRjVaTp6TKhDRqWYeZybm/x7sqMugWAVU8SBzuEc4OFw2gGPAYqDTZ3t5/dHqNRfMBZ7Rc/QCJ+uLnFljQOxTqrWoIwCa4J+GhP/XC3AszRSiIx0u+O7LZiAOKH6c4xdcMo0BnvCPqNC4StIYb0FlUznlmAoDszcKSXXRL+kq2pQxEQcObOtAVBsMhThtLfS0nR0MV9Yq45XxkuHhMFGXlhBHHGcwVkn52JtLBBCoQkskDEEuDJX0TnoAWjFGXqY74ccy6/VZ3vMMSw6szHalm1AQVc8Yzw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nhnx8zAy3kD6mkxn/PzoZKUYIWVGESCqLU0uxg4ZDK6+xWLGBs15ExVBgzNN8JHSs8AfT/vwIbjhxz3p1kIRyAIVTSTnXSUkDshmv8MZJKiX9+vpAnsISpZTlLalRfeqyR+ZNDrtx77kintyvLzwSo2XmlPWYgD1qlhoq8gm1p7iuFyE35F+hKHHCEHjfIPFZz2kXz7k/ggDV/qBff2avd4KP8pTnVk2+mAChKaNxN+YXXoODn5wHZRDBlCrxQIsCZBhKNBkaIljJICvliN2PdrnKO0F44wvbhIpEtFPitA8HTMyN03xOb4YJtbPzRJQfKKpWuy9pXwXlMAN9uwQePSxCYS4kVPOlC6srdaFHGk1L4uEMqutM5kJKus1NaY3/mpaYxJcRMgYVwOT8/zFQN1moxh4+RrGTQjDBaprpJlJAwYbS5QRP1+d2LS/njyC8LlQPQxXUfdSNMaI8YkNU7u6Qvpbl/BUnGssq4JUFtugxHdVesMKwuH+U90ZK4DoyjToSLvPSjikF9XWdtNOQWEiy6A2fn+hfYqSRpTf4nCjk3snRwJiVmM2+pyRFg5IDGthFhX2waeCXbpLn1bCaG/Bou5DhjOkru3oQknf8rXQkuGQpL7V799HOPJkCIZw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafd843e-41f4-42a4-1d36-08de864c8ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 06:47:27.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTPOjoLeT0Wzj06u+wUMHx83ZOPD1Y45LJf3TMat5RgueIu/rM7iiB5Y74JgCb6i6T6rk1FCswd27TiCNkuEmKXY8PHS4dMLVgNIHaq+qCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8105

On Mar 13, 2026 / 21:18, Shin'ichiro Kawasaki wrote:
> When the kernel enables kmemleak, the check script scans for memory
> leaks at the end of every test case run. However, if memory has already
> leaked before the blktests test run starts, the leak is detected at the
> end of the first test case. This makes it look as if the leak happend
> during the firest test case, which is confusing.
>=20
> To avoid this, check for memory leaks once before staring blktests. If
> any leaks are found, report them separately.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=
