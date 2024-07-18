Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2640875
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306268; cv=fail; b=nfUbOPHk4KOrfZLIOkArRkhioS2lyPCJCndHVbuiB5PeXbJQR8XCCAltczAt3Uj7aZnGQjXH9/KN+K8q1Ag+xxE8Ydal9nZFLtMhVst9gTMOOPhZwv10y5p4v2YkJhM5DmJUt4/3B7xpVPO+u3KQ3hYCFmlKHqr1hLN7Ib487ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306268; c=relaxed/simple;
	bh=SlESQJIcyu6QdjGHS/jPjAMsqqP6vIMBQV7ftRibhwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHeOR8Z82xA2xwAZXEvPlORj7UuBKhOX/BAmKqMPO3BkYIu3nr4ZkVvxWpQUoalU8MgSTT2xBAJ9JqITPIISTtYon0j1toXh4ScFTytRkAXIUtw4JVNmd3RK83tiquxm5S1pKPPUjw3YrTI9vPP7EHCT0d8RvEispI7D8toBwMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IMYqd2Wx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Hask6gv1; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IMYqd2Wx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Hask6gv1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721306266; x=1752842266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SlESQJIcyu6QdjGHS/jPjAMsqqP6vIMBQV7ftRibhwA=;
  b=IMYqd2WxEXvDYJs7xzTUygNssfg5kmk8a1s5k2N7biqi81yiAUJ1sKdP
   vtZpmFCe+aJ1WRHB9BC7RLGMgVZRov40Njdl4TMGR/UyVh9Rqlqpfon4o
   xSNsdyJp6vF45GgAdBmVlYn4vQd9U7cOupHr1qieMRimZ5RNU2JNf8h1X
   1lEosF8GTa43FQkVHoa5uj20EFMDaVQ5kqB9sWv8F2a7jbwMRWLxZ5CtQ
   5ix90+ydAZwSrz7aTDMIM4FzaCFTE3+1QLr+sGF8KUNZFGPcHHwu6QDKd
   K6ZrQVloZuAt2NA5CX1BiZtab4WQBP2KAdrS5W33QqeP0Ybh1Q43BiVfi
   A==;
X-CSE-ConnectionGUID: Mv6c/cOHSkqA9Bbwv9QXIw==
X-CSE-MsgGUID: gGkouQaRQpCunHpRLvEEQA==
X-IronPort-AV: E=Sophos;i="6.09,217,1716220800"; 
   d="scan'208";a="22775421"
Received: from mail-westusazlp17010005.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.5])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2024 20:36:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUCW0dc9UWZ/fSpduiKfUMZvO60fsKf8V0/gwrcMKdtRPf3vZbPL/Y75OAVT9nxBYT8uarmDbyq80ufowpYhalRKLlJSK0G12NwBgZGCzHJKVqtaA6Qv+2z+cn/fGqDsEJVcxHv0E9PnMOaniSqmTgbIdApUuN7KhWQHS9hBAguLkBOT39dr0Qzzi9auF1VEBRRl/EIvV3BlgMwqj1+cpqGP0OHR2CBngcLo0+q3l52Xss3tX+DHoTeQBlW8Fe9j8uTg+0a8yDyWCANWp9j28639pj4bJB0y8jGqBVBx8yrzRDsupk/tOjsLR8OkmmGa1/YrhegOrqF1tgOekMFCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlESQJIcyu6QdjGHS/jPjAMsqqP6vIMBQV7ftRibhwA=;
 b=q/y+Jbufw2IxmmbA1FwoZ/ETsZAoHn1VLUViPCrZUTAEJPtYYLCjXXbfSVM+wyyJmP035nY5OF+2QsehM+SeixWagMYW0BUDm6/eGijO8Jslj9r0RznsyDwtYyMzfLSapiiGw40ZNm95y8PbS2neYNVX5nPKeDxPZ+a8Moxdbt+D9Ks+iV+wLoaOeV4ymPtIqCDa326zMNCTr8gNgy/AXeTxRbPw3CBcvKyzDm+a7MrBrMJYY1oiZc+X5eH0Y9Tc7EQ/Xw/6vU9myiTHK1gY6ItcMreLYwzp4/q484FbAd5XINYdabeqR7WBSI0BcKwRT/hUeU0/eS0C461apopdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlESQJIcyu6QdjGHS/jPjAMsqqP6vIMBQV7ftRibhwA=;
 b=Hask6gv1Z2VhO+hXvTyVOf599g21Rl4Nx4sL9OmUTQHC/JNyUIe+KtNdpEHfa64r5OuPXO/3PzsvNxgf3Hg9nvMufnasOscEVUwlzgWVwGz8INvMKMw3zMoh6EFjIj0LBBLYZQ9VwLLpTde7YfDZyHSjLDKM8nKRPYnxux/FfLw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8036.namprd04.prod.outlook.com (2603:10b6:610:f4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Thu, 18 Jul 2024 12:36:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 12:36:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Thread-Topic: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Thread-Index: AQHa13ZloNQFnpI10ESZaT4cm2k5SrH6iqcAgAGe6gCAAEXCgA==
Date: Thu, 18 Jul 2024 12:36:35 +0000
Message-ID: <kumwslbrccrhttvbjqyfznbcem7k5rryasppabgkzx6iw72uyj@rv4uu2o2jtkt>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
 <iviiquxyax5ofjcnd7g45wwgbjy7ikikfz5oqdnuz4kf444gno@xpaa42btwok2>
 <f6255383-88df-4aff-97fb-2504108e300a@volumez.com>
In-Reply-To: <f6255383-88df-4aff-97fb-2504108e300a@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8036:EE_
x-ms-office365-filtering-correlation-id: 29bafbe5-426e-409d-b131-08dca726433e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N5imBeR1+W9oqDumJ8xVrDlTRfLBQM/fI0CyRtpn1TUjmtftcgrUXq34roJb?=
 =?us-ascii?Q?NfDetAjnlP9sO5asSwGwjDpsqB0JQJjxkdpDTKi047dyMBx/LufhJKtAlKNz?=
 =?us-ascii?Q?md7Tt95C5GSJAxG04U291H06VYM9KuMYVG8qHOfieRun3GL7HxpXzMOfB91O?=
 =?us-ascii?Q?w3wZmwVFAd6CJU78aAXvUEloeGS03ygKXl0Zmh9Sn3abi+wTkC0QUdeRDQ0k?=
 =?us-ascii?Q?9iISqsdsJBRHcOkOJZpPAkyT4gjBa0svbkGj5CVqKEpPvNjUq5reUp6ky+ne?=
 =?us-ascii?Q?wyWk9zjiI76GJccBeSI6xLC1wFGmDwxkIBsv7TQ0YudHwZNxIWNRshBPaTxp?=
 =?us-ascii?Q?4QbwsfKuWLyDcptyZYInfRsbKFlBJyqFUhuExkW+byG/dokTnxHFabYV28J2?=
 =?us-ascii?Q?vsSJJiVO5jjoLn0V5jIbaPHHR46zrwGZjtPS00Ca7JA2QuZBCqNHxSljRIv5?=
 =?us-ascii?Q?yemQvl08k4V9e5rX8hzWklLaZnH806/gmnOu+d/1dSUJW/f12a2GsPhOR1Gh?=
 =?us-ascii?Q?ArKG7Ih7NsAGJeobw31rI1IOQABCXfLOtfqEeIl6szWHCG/qXh83jQ0ze73J?=
 =?us-ascii?Q?LDQagr8n/59pUWK1o1PYNYNEaHqHCEuHwT+g+xCyuuiwq6sjA26NEeyQEoH+?=
 =?us-ascii?Q?3aaPQJeIU3b6Awgu+tVwsDrFU7vuBDiW0JqS89qoLcW1iV5snSOe8zyoocDY?=
 =?us-ascii?Q?VknlsRLYl+PXtIfoL+wYJb9by2NbWN3R5nfAC1D1KrDaz+bLLv5+9ca2ubri?=
 =?us-ascii?Q?PgKDgZ4lTIcjFmlVY5jJFYvuLy8TvDq9QXr+q1VV6xAEANNxPyqdra3xUppa?=
 =?us-ascii?Q?1tiSuzhO05fxLLgEkDGCyeqXJDr1/eUfNoHrPflRkIHk+fBQP04mPEDaITFb?=
 =?us-ascii?Q?UJq0038507dQ1+vrTT89RT4utp2djWYECJ7DP/ntafmJ6GB6SKVcezQhxa5r?=
 =?us-ascii?Q?uIX922cWkxr12+HB1P5KdW5mZ0OZvTUM84f6cpVwWMXXCKZy5XoLYdFtq7IF?=
 =?us-ascii?Q?ycKFeAopqKvMt4211G8CCLOh+s2Eynjmac2Ig9gAQ5O06p8aKJYPM2IpWcFP?=
 =?us-ascii?Q?pPbcAtdB5xDuQxQ0xiJnaxM+chL91EbWmTevf6tCgyv1t1PVLx3QKba1iNhr?=
 =?us-ascii?Q?VlT2KaASOkQ7nFsvUR8MkI3zDQBNHU6MgyAgWT/zVwbySSX/PF37Z5ND9MKQ?=
 =?us-ascii?Q?2LJeIb8wUyh6qJuloTmTEnByLHqZXdEVwHMYXksM7SYfm8hhvYRsivtMIguE?=
 =?us-ascii?Q?1erycJUkL1vcIIQjjMiKWlFLvOQaE+72de7XxDg/kzJpKjvBaPIjDJywe6hX?=
 =?us-ascii?Q?WWgrL7hBDpiRerAZZ6MjQJ4hwkbQxEwS7tJzsVQg4PQTb6fZI9/IX2me1onT?=
 =?us-ascii?Q?80gU7OHBvIQuquF7gJqoZAl4QjH80Y0YwvqqjDe1jlNa7qB2QQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VK1sINhkFj0rIRgQem81yv0NkgENi6whKlBn1uZw4hFfNEISJ0vM7oLTeCyU?=
 =?us-ascii?Q?qeERTZoolc8+OwvF9OoeX6t/OAurPB65CZGe37ysIiqTJsL0ORRGRMx6NVGg?=
 =?us-ascii?Q?r0sPVeK6Gm74tNlOqCmNDa5TNzRAd1kWSjaHSMjvowReJIfr+ubkhnb1+a7t?=
 =?us-ascii?Q?cHdWdkoQT0iez46mqG9hDINHgTAgyof1C7MxoU/qtCrJuUP3m4plsyozsAq+?=
 =?us-ascii?Q?89JX14kCSiK5pjD6a9+cqLCCLHZuErgXyZB7QIYu0k8/o9XoWO59IKot1xWU?=
 =?us-ascii?Q?drCW0q+fD5KBHwSYo0sGCtw7p1OVC9v7UZfW1WPtLSWpWrEhojM2gDdIZImO?=
 =?us-ascii?Q?DtjWDzCEyAzRxOtuE/+My2q4FhWSar3Ioout36R1amtY3nBEsixbJKane+8W?=
 =?us-ascii?Q?N+On+jRMAF/yPvEVPZRr+8WQ1prg0CeGmxiZe0bY/R4+PnhO8+QKoPgJ6yo9?=
 =?us-ascii?Q?wOUcs7NTWRgHDg7yeh0bQSwtgf5CtSOKD1o1RXF6+cs3MX/12Z7lRRwce4fh?=
 =?us-ascii?Q?aZefb8YOPoea4vwTCsZcLU/bWW9YcyRXgnagZlBaEnNUxz/tTTWLyUKs0Qh6?=
 =?us-ascii?Q?LXC4JJhNCLA02Z+hbGlV2muIKaGezR0WqPEUm7Te5AtD4e65oeyJNEThTrxc?=
 =?us-ascii?Q?KU0jyP3g8ZEIWpfFkmsLzeu/zq/QOdTqyTDnEc7DQdoDqgrS41RM78VzncTC?=
 =?us-ascii?Q?tRVH7348PYDpf6GDgjtccuNh+Fv/35iOaSQFvuzhBHtRbuBLMLYMFLqOgoU8?=
 =?us-ascii?Q?Jq+2UGhI9sq/x1mIFjP4oB0vyaGiB9nFU6EIg7LaW/9GNS89F83FlWuLE+9P?=
 =?us-ascii?Q?4LXeGv4sQDFZ/blYgkjLP+FRQa1nrmDcdpDYZPa+Vp3OS9PX62TwjDCujR31?=
 =?us-ascii?Q?D2JwMT6dAd5DvZLJlBnd/i3JYCgVJRCGJAkR1sK82UgMwUCR0NE1WF8KgIYi?=
 =?us-ascii?Q?Mg10GUH1XLpDUCOyhfpm+W64FMJMEETKBSsiIsFP4FybCL4qx6VAlwWY9EiF?=
 =?us-ascii?Q?/5C+PS+jmpYm1licnCLdk5z3lCH8fcnMtA/jY5gZnxPOcSUbolBVJ1JLXivk?=
 =?us-ascii?Q?lpXgMYz6bRhsWf9DyL1JEsxQ1qb6WxTsxZj+HwqCvk5JD9lUQ0SN4fCqALfo?=
 =?us-ascii?Q?JuQW2Dt5vLuy6GcUsYbfTKNnVyhsJ9cMp66oJnISUHHI4CKRT3IppjZA7I50?=
 =?us-ascii?Q?Ujh1ASpvpm+lJNMvktR7ZJpUDvA1IkED9ztXq+lZmYV0H6DIpFfrZdMKdK+E?=
 =?us-ascii?Q?GggwmjexXLmnWVZlItKyuqq7uMRZY+gsaYnfGTbgdLqmtChq861hpDBRPC1i?=
 =?us-ascii?Q?4buLSxFH0IKNtL0Pxg6/EmfnFwy2gp0G99wWjskDD+Qt0mS+Eis6CngEpBNb?=
 =?us-ascii?Q?4Rt0AI6TUQZnXyuXp2nGvzlgtOYzmmBg84aEElUX9k+eHOWQbcy32fnjLjdG?=
 =?us-ascii?Q?ka/78qSkd9ca5xf+QYP1BM028qXklsSKnVVnMlpkKKNG0HYdwvWD6PD6Z8o/?=
 =?us-ascii?Q?ez+I2jMsHVWkG7Cd7gCjy03U8QEZ6IhCcOBdUIlPRW/J8VeyL4YQB5zRWEHp?=
 =?us-ascii?Q?sWyprSx6EUqqdEZbhas6UQJKQyLcCWHe0IjHN3YxdoKgHzUIZcuw0OIOBlZc?=
 =?us-ascii?Q?1RnNOIPsLSc2yyMwgrZllc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3B17AE647FA834B8143B2380DB5E3AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o8vDBT/1FXcVr1UgpAXgfAACGNXHB2GKbtULZSFp6PTUpoMfO+GJwGX6ukXljYopjvUn61pBlSzwmDGqWa3bqBh6l80bMy5UnRhEBH5hG6fYUMDPpw1cdZn9dj3DfHwNqNFUmzuxuOj9wJLNiHNETE/iznLZtcu9Xim721TqCkd0LRlumpIWLmTR8nbWtMoRDDNg2oJ3eYV2c3L4oUkpkb/UfJhVMq21Foe6BajFEso4J2W0PnCDCDZEzRq7me9eGOQ7MJfZThcLwVhCMPWMGcm0YxxRWIPtpNJtbggSa0C5jBJu5b35TyEhpS5rv5AJQridDLJzpy9MlLYwPLNTWR9Y0r0zO0cMusmEuHi9YU4rrwu/3VRzB+CE/EbmWkQOPsaqHsG/ky0L6Ys74TuEByLW1SuVxfvben4VZEQ4/SgV7MkB82jH+mUh0eR9lu32PmNGREoXRL50GQxiyeFf0neePGJoDUu9s4+9v2HJ2N+ndX5AmHN4NPqZxCCOEzVYPUvPrdtDF4sq2LP0zNyWRhI0dBNJZqfQHA/868LA/a+Pg90crp6AckAwzmbnW6TwHkXlhtpTyJH/sURK3LZihmOCsOlODb0iuHO/7puTf6qT63ny5Vd7GVETYazucs0x
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bafbe5-426e-409d-b131-08dca726433e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 12:36:35.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUrUQW2N9CvNcT+XVHVqY+ekTG+5nyYnIJeo8U/zuBWE7hQoMw2BeEciORFyeRFLTv5I0ljN7uGZY+GvxsJwxPrBIJ8+mnkW9CKWyyUIIw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8036

On Jul 18, 2024 / 11:26, Ofir Gal wrote:
> On 7/17/24 10:41, Shinichiro Kawasaki wrote:
> > Hi Ofir, thank you for this v3 series. The two patches look good to me,=
 except
> > one unclear point below.
> >
> > On Jul 16, 2024 / 14:50, Ofir Gal wrote:
> > [...]
> >> diff --git a/tests/md/001 b/tests/md/001
> >> new file mode 100755
> >> index 0000000..e9578e8
> >> --- /dev/null
> >> +++ b/tests/md/001
> >> @@ -0,0 +1,85 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-3.0+
> >> +# Copyright (C) 2024 Ofir Gal
> >> +#
> >> +# The bug is "visible" only when the underlying device of the raid is=
 a network
> >> +# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the=
 network device.
> >> +#
> >> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pag=
es" and
> >> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
> >
> > The cover letter of the series says that the new test case is the regre=
ssion
> > test for the patch "md/md-bitmap: fix writing non bitmap pages". On the=
 other
> > hand, the comment above says that this test case is for the two patches=
. Which
> > is correct? (Or which is more accurate?)
> >
> > When I ran this test case, it failed on the kernel v6.10, which is expe=
cted.
> > Then I applied the 1st patch "md/md-bitmap: fix writing non bitmap page=
s" only
> > to the v6.10 kernel, and the test case passed. It passed without the 2n=
d patch
> > "nvme-tcp: use sendpages_ok() instead of sendpage_ok()". So, I'm not su=
re if
> > this test case is the regression test for the 2nd patch.
> Sorry for the confusion, either one of the patches solves the issue.
>=20
> The "md/md-bitmap: fix writing non bitmap pages" patch fix the root
> cause issue. md-bitmap sent contiguous pages that it didn't allocate,
> that happened to be a page list that consists of non-slub and slub
> pages.
>=20
> The nvme-tcp assumed there won't be a mixed IO of slub and
> non-slub in order to turn on MSG_SPLICE_PAGES, "nvme-tcp: use
> sendpages_ok() instead of sendpage_ok()" patch address this assumption
> by checking each page instead of the first page.
>=20
> I think it's more accurate to say this regression test for the 1st
> patch, we can probably make a separate regression test for the 2nd
> patch.
>=20
> I can change the comment to prevent confusion.

Ofir, thank you for the clarification. I tried to apply only the 2nd patch
"nvme-tcp: use sendpages_ok() instead of sendpage_ok()" and its depenednet
patch to the kernel. When I ran the added test case on this kernel, I
observed the failure symptom changed (it looks improving the kernel
behavior), but still I observed KASAN slab-use-after-free and the test case
failed. I think this explains your statement: "it's more accurate to say th=
is
regression test for the 1st patch".

If you are okay just to drop the 2nd patch part in the comment, I can do th=
at
edit when I apply this blktests patch. Or if you want to improve the commen=
t
by yourself, please repost the series. Please let me know your preference.=
