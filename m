Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C91AE86D
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427320; cv=fail; b=Dfz0L85o5B2CF5KKStCF3sEJJU+es8OMirB+O8NbejGsrPunCa3mOJ8sLkPL/MZqufbu5Q5uOnLYkvy/HGgjvXTQ6fSA2/4nlfnEKayIHeL897QehAye3ymGqUn9FcfuThperfz7UuEdq2MpEBP38/flIWkZmj+zt9OhOas2SgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427320; c=relaxed/simple;
	bh=NshwwwxoBA+IWhBitsSlBqm7EOK4mrZq0jqiyiKYUcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usIQmTWOKsEqVsRTZI3wqFQLaewb+ai23lIUxqy/oZXBACWPbFmCiFojg7/PMNTz0d4kOEkTDDH4BhGTtJ+Y9raTt2swXEYfis4AXlSzjD2q9JVzWdYK12+FFZ93ozYOGwQX9v4bbX0mLNiNq/VTM66RfRHm3jprvgnn9Y5J1nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NM6VEX0e; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bTGZaYqb; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NM6VEX0e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bTGZaYqb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722427318; x=1753963318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NshwwwxoBA+IWhBitsSlBqm7EOK4mrZq0jqiyiKYUcQ=;
  b=NM6VEX0eQVrfhdmqrfit1L97WHBJhuHG/n5v7VlcileVOFArRWnPQo2N
   l1OUqs/ei4Zi0/alKgXxjYJZU6tDMPMB9HeG30viunzw8YxdLf46lXtza
   jeDc10UYkxcwvoG95JsQqqwifkir6ow+/DrHdYxFrH3PUkDXga8czdd2v
   IIJN5qDWkdQqOggaZh0Vb1n/eVhWwMvdZbxy3vLuIze3S0KEB/r42VrWZ
   M5xfGN9hLWeAmld4WS0iT/AK1llsjnSx5KQg7W3flJQG0KluV71TTfqrh
   B39fe0de0coDf3AGr93I6/Q6Bb80lBekit6nipFY9WvxL7uZiWfZFvVH+
   Q==;
X-CSE-ConnectionGUID: eAaQvVOKTqqrzI/9DK0XsA==
X-CSE-MsgGUID: zFNXOTWoRLSXLEHYJ1rHtw==
X-IronPort-AV: E=Sophos;i="6.09,251,1716220800"; 
   d="scan'208";a="23182247"
Received: from mail-westusazlp17012032.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.32])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2024 20:01:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6Fs+2j+5MiJt2Ei0JCooAHcVieyIk/D1Ak2aDQjatNqG9jOXcw8QxjRoucMtDFdAZjjom2IoV2Al7ysRjuh2b7d3WjW4pz7GmTA7NyuGcZARqFxwkTYQMougEQymYdZCUzcVNiaUKSvR69mttPI1JjyoMxbv6FRaEf7Wwk++0ab6AXPR16fQ7KA7HWIC+HToD6fJPvyDUrYRrZuoXsLTUHIrvzPpgJXzYly0h9mrbEzG4GTWPBbN+dKtAucahWuyyhSpqI898PmBNYwJtwPj81tmxJuSs04oCSzavDCaQe965ZLBxZkeYV4FAem3UHoYXGKIgCnIsp1aKpQC5R+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NshwwwxoBA+IWhBitsSlBqm7EOK4mrZq0jqiyiKYUcQ=;
 b=kf6qaHySoyWhtH51N/iD6lqKdsmKu6OMul7UKzqeeETXwlwUod8r7RpswrieW5a6RwU/ii4hghsbTgOPrNGEXWyWOrhUN9/RpQhlH9JjDb20ccLytgEyoeEpLJ7DJ8/hyOBFzO+aT03mtx1m1jSBqmyxxfXLCPOrxe2AMJxlfDL+bR9+EdP7yt6dJ0Iz7cUYYbq6wRaEqXPJvXzR+gYHRqyI6xqbRpTRWObTUyQn9UHHJvsofObVmnZKd+GHW5rDFLC4MlKjFO7CN0ZmnFntIE8xLbYD/ztgFnNOOdMXzWe33XzmNpBR+/q+THfxxcvjLQEByfXsAyJvFpZv5biEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NshwwwxoBA+IWhBitsSlBqm7EOK4mrZq0jqiyiKYUcQ=;
 b=bTGZaYqbvLAuvof/UAAw8AEyMjvpcRqonRJI8FITIFGyfmHOxKLyYgSz0LWEiz1ylZVZWJBwNj61P8AK4fWbN6qlKndEnXa2S2a4PROZsRqbgHwKdXwFK3fGHBFJpwM8CVCoWJsFjuSrFcfapQ0oHkssLwhkuMq64hFhOn38iB8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8504.namprd04.prod.outlook.com (2603:10b6:510:29f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Wed, 31 Jul 2024 12:01:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 12:01:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Cyril Hrubis <chrubis@suse.cz>
CC: Nilay Shroff <nilay@linux.ibm.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
Thread-Topic: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
Thread-Index: AQHa4ztkti07JU5pQUS56LiY8/ivu7IQsYkAgAAK2IA=
Date: Wed, 31 Jul 2024 12:01:49 +0000
Message-ID: <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
 <ZqoelLy4Wp33YAGD@yuki>
In-Reply-To: <ZqoelLy4Wp33YAGD@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8504:EE_
x-ms-office365-filtering-correlation-id: b3091443-a5b1-41b5-5667-08dcb1588f42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+5BEd1C9SEuyJ4pJFqo/vn4Ly/+jM5M4JGfoaPlceE/XZ9r3wrxD/xF6IWNq?=
 =?us-ascii?Q?WEuysVGze4+bXV7CbkDlXPViOUPsSnRh4xSu+x5Hab42+cabFN+/GtkJV1Wo?=
 =?us-ascii?Q?e45Sg6OG7FOTZ/vfqTmJeaKq/6cVa1TbaeYRBj2HkEs3hKid62I+5sLPXsZ+?=
 =?us-ascii?Q?wqgps0IHTpfLqfux0RdBbPSOcHL7NBLMkLB7A8tsZt/ib1shEtcLFddzHmFl?=
 =?us-ascii?Q?3Db8OlpiLqkkRZ7cDD9wcPdQRu7MwNaV0enLTNvZmCvxqIH0x21EqWa7RBJD?=
 =?us-ascii?Q?KMzHzKJehMi+rwyre62FYN8X7nijkEK3dq2TCRU+VcnJfNtVnJ8oRRdI+WQL?=
 =?us-ascii?Q?sRgTqiKLIk3Fu1VAOXiwiJdaUeIdLIYRpWfWDFGU3IgUAbgRjxMTQW59UrV/?=
 =?us-ascii?Q?rs0mhyQQ106AnPTuXxOaOKYm4+1nPSzxXWSuuM8ELO1LCmOws//aeV9NRjpv?=
 =?us-ascii?Q?/QZREWoZMmcxtbU6FagqHEVOiz/pwthtDUe1KG1B97UgZYVCOHWx+wsM1iUj?=
 =?us-ascii?Q?jjime2S1EJdpXgozAO8lyhahqnkzp8oRDF3tJ8fdAqMGRJJTu4Q/PzsgWK7y?=
 =?us-ascii?Q?cXx82sS7clYq9WkW//UnC0EOJnbl1E8/uo4RYBMuCuHZcmi/2Hh++28jP/vb?=
 =?us-ascii?Q?qiQU90j0zWYz1SCBHnG9etixX1tWlA/kE70QTpHxHEohK1eZYIy6sza6fXhX?=
 =?us-ascii?Q?9ISkyj8j7ndA8uJ9n2CrkVgGJjaU33+BHd1VTsN9jN1IuaM7npMZvt1AJ7SW?=
 =?us-ascii?Q?1fuK53gLEs9IDqseCzXqrtIJKVFIQFLauMjhzsN/uUSMnvtDFEjqr41c+Jov?=
 =?us-ascii?Q?/N1/y0d0oVYqRpgfWdOusEUrR5i+oLlUjgOOJApCVhXeGW9brFqmX1zE/6W9?=
 =?us-ascii?Q?CoYW2mU3kAHw+XXYarR8ZvkwHIePWsOGef/hakyO5HPoG3IuX0EeDnLj3Z4l?=
 =?us-ascii?Q?U+Js163Tz5EFmzbqdpG3pLZ4TbpdqyoUMbHMocVHsUBRT/cDK0dKi+I0g5wQ?=
 =?us-ascii?Q?4/tp7SjHJ5318SY0Vv0vrlyoSWATtmo1/jf2qq6COeaKOCLve3cMMvGqPeLe?=
 =?us-ascii?Q?ZXMIFGsNQPZy3pktMEcxLTV2uD8PVPEI4pJd+743fl4fI0Qv43Czclh3jInH?=
 =?us-ascii?Q?dqPe7couD6Vh1yQO2sm+0GNLSog3DeP04chl1wsMv+5sUWT6nL4eBOvPMKIK?=
 =?us-ascii?Q?IeShtca2sEp4ccSX0bO6TJKOvycuvebkPpUGEhGR1NIimHJaLEoVF5pYurnA?=
 =?us-ascii?Q?Qz1eL51ssymjSShV5aOY0QP1aGVFLjypj5BY+2ArzRnzMRsDuywxXHl1LBMG?=
 =?us-ascii?Q?IVEYc4hpyB0bBJejH2sxGBMi2n7/15FI9lqEn1BC6roSL3mpATjh9KzndHFn?=
 =?us-ascii?Q?NTVyki4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dN55frEkbBFk5jp9wLflywo14Kqof/lWxDhBlwgWdjqt4fF1vzOwncvoj3n0?=
 =?us-ascii?Q?7qn4nRB9snzYbF2mJvzWhW2YY7yb4PkCZ4mvpQ2RThxRTNserxeIQlsxORCm?=
 =?us-ascii?Q?UtFMnJtCd2maIy5W+Oi0LLlHWw8xcMbLeelUPtDAmCQt5GxsehzGsZnVUk1n?=
 =?us-ascii?Q?JK3pHIW53bQGI8y4NUhnf62OWezoGcPolD5Wt42S8Kg/20Jw3YNu4okoG0VQ?=
 =?us-ascii?Q?sKyCKTBDbA85JxtiKq32eMuj5r62L5O6Mi73sKJndG+tPB7dXKPrLaGIq8x6?=
 =?us-ascii?Q?4dVVAKlA0uL8/asJr3D+5zcbFpHfo15tlgSaJMd7zKTak3grjIkYDBPX0Lxb?=
 =?us-ascii?Q?F6Km35WuXxlhUfJw7i8Lg7lRykTX/ZcBE/0HuhjpcVYUF0vtQMSGK1uYAdMp?=
 =?us-ascii?Q?/tJVR85K26wWQHKDTn9sgUxSuwj2Qe/BYtgbXKDfZ0P0kDtJ7+5hjGNq6Xq5?=
 =?us-ascii?Q?olt1wmSRQKi1SFeIRVhFg7IFOlZED5NlYc35sQ+LWFF9rRhDMzfUdTScPnAU?=
 =?us-ascii?Q?9spNJbRfwKXcozgCgzl6WkgMPN/XIbUHA17YLx/2Azrag9ODRQXnzs19PPqJ?=
 =?us-ascii?Q?nKnfa6FtO0R6LdCtFlz5S21aDEVldsHhpwKLO08OpvT0iQz6VMWqxgxbiaLE?=
 =?us-ascii?Q?z3YzP+TInAIh7yjNkocP+eGND0+wcYGhLCUVGk5n4zYS56hbkUROhK42xhIJ?=
 =?us-ascii?Q?YMH8U9El8KqJsWqTPAhjmbml5Oyg0A5bEpW1JjVAQxYU5wxjbpmipxo6Z+q4?=
 =?us-ascii?Q?vD1dJez55D55dDBX3o/rOqdspwt3I/clh8Ydbn6ie/Y6wclc8VPPeJfNkZex?=
 =?us-ascii?Q?EZCs/HGVQTpn0sijuxVNRjXzx7ipFrKWkpuomu11Lh0vC1unVIb+qr6YQ05/?=
 =?us-ascii?Q?F4gXxORRXlHLV4H7cAx0Y6+ms3PW45Zs+vEXml8h25otE5cCerdbmi18f/ho?=
 =?us-ascii?Q?EbkdKz0lzAJi+Bjgsbk6cJEtk+Wb2R+UcuMxKTVdBwgEI/iQGF+BfzU5Pio8?=
 =?us-ascii?Q?qIynbWPMiQJTrvgY5MHAvpOz2sLhpczUu/7BHb4+BsTzNkdIgKl9t0NcznF+?=
 =?us-ascii?Q?At50HW/jeR7i6d/YMMbxydRMLpBJA3f2u9IlF5/XmcW8o6nr8b3+0DteIH4S?=
 =?us-ascii?Q?5bgJ2tPgd6BWHOS27uiDcFI17HaR5VCDfR+4lhx+gJ/1E8Hv0KN0RxkFc5m6?=
 =?us-ascii?Q?ZjplF1R38y4O6atzhzTzKOsZGc8NrXWCTE+4JCsBo3Qw4SBHsRW1MYlQYKq2?=
 =?us-ascii?Q?zlzJ5hC4VB5Bbi9eHedBRTfbKs4+obneuKRxjwuglPqPmLVL1Y+ppXmo+Jyr?=
 =?us-ascii?Q?KVi9N6ls54DPH0Y1I5ewQKLxu0SRktsuOLI266gPZ5s/wTCBHE6FWMFBgfHP?=
 =?us-ascii?Q?cjc7exZJzFvJzs/6aaFTZzVgJDwmDuRsvgwIFlvMm47QGp80SqrQ6drs8Pu9?=
 =?us-ascii?Q?QKwY1bAQOKKPEcgeEV7iXgVOcmCOxBbesKU2wdCZmS5ezqCL5vTXYsvNi3oa?=
 =?us-ascii?Q?QFfZJe6mHI0prWgKifvuwzSC7oeXCgTP39iTqGevFqZe74ar4AS5jsnzzAWQ?=
 =?us-ascii?Q?D3ysjiTpJxiI691kCQ9Hmnr+wNbwPDhitn2xaFI5Qn46XYg1SE8aXi1RgKXT?=
 =?us-ascii?Q?6cciUnu7VsgL9BiRBj22NLI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A98D094A6D16934EA8ACD7C6E807345C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YbjCcWZ2PVneBj9ucT/E2JkQEDqKG1+SCRdEu5BMQLtHiHAN5j8DBF4tBjs+pq2rYuT+UAahWhHjTCxABduTuo441U2qaDK5Tj4MXbqYkVIRIkND3+ZAd2tjRtHCsyByT8YE1c4+mW+wMnUFKrf7vHOs5ZhzFXUaVZhjKzDwLjRjDxMZ/VGAP/nwta5yN+a0QS8paVPOegOxPfp92BD3L4t8QqdSqY7Qwh17fHST+318+V6dxVL4YeLpf7u2jHcZtZ1SUiaAuQWF167pG6KW2WEDZ6DLBEvITi4ft29k+R0jKJxnG7wNElX1eFX7QzBqwIwQO+JWx5G0OS2kvgjlyQcoJH37qV7P0kIi50dfOQw/qgJBNQ5iKRPVPhenfUruSHsb2YOjU+QhM0QyhL0iAjL3E0+oUz8dYgwX1Dt7dzago1di9Y1C8bmgNNFaFtkEdQovdAHmHFMQV2dFRpprOkJ5YSnvLSEfAVt0OqQPBGiyww9bpQLyupNK34I0VhTaMcBOfFhK128/MYrwVyAT5jBCdq3P3Fg45ft0PRKWfXhoL3YwqkiF/mpNw8VvEqaoZKkqBkuEBY/MxXv5CYFX9SIiHIinGxLs+Q4KIfH/p99PZmsnCqitufhGPNZGpI/l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3091443-a5b1-41b5-5667-08dcb1588f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 12:01:49.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLAuIEP6WkF6HEeBJtuU+pULxXEHinmTOEJEQebFwi2XK+SP4jBj8ad28lKBZXTepMsHchH7PJiCyZ4qHhzZxwIT2MISIE/OHzCNea6t9fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8504

On Jul 31, 2024 / 13:23, Cyril Hrubis wrote:
> Hi!
> > The loop/011 is regression test for kernel commit 5f75e081ab5c ("loop:=
=20
> > Disable fallocate() zero and discard if not supported") which requires=
=20
> > minimum kernel version 6.10. So running this test on kernel version
> > older than v6.10 would FAIL. This patch ensures that we skip running=20
> > loop/011 if kernel version is older than v6.10.
>=20
> The patch has been backported to 6.9 stable as well.

Hi Cyril, Nilay,

According to www.kernel.org, the 6.9 stable branch is already EOL. Is it pl=
anned
to backport the kernel fix to other longterm branches?=
