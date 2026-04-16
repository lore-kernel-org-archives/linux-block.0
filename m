Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45121256C
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343833; cv=fail; b=BNiq/Aij2nZ7m9Twi8r2k123LW5wraIpRTST/wHP5vw0H+KeqM8je8s5srX6l2KSZYOxak0/gzCD2bhgfMm4o6r3yTDrC1fIazbw8pTMZki2KlQQaYFq1jr7hwzvTqmbchNBXiLQyjh9rSI25HizyB4HmzMFhHJdiIk47tWFUs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343833; c=relaxed/simple;
	bh=t6IHb2RqQBzPsTx33c1mmvpQnbd59fyzrbuRp58vCeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoiY+8BEN6NPHMXsyzA7s4dIVT6JFRWG04NWDXGTJF1fr4FIamwf1bsOJ9USKXEjAm4jb6lQMm5NHSJ3Krc768ROGUC+LPHMY9p1F6lIGO+8N5jHcS0+CbaRCo71FBWs/vvBRo8/gPYXTLuTmFCBk3oi5cWT4m8O6gaffWDWuBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KFUQ8Zwv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Yw+sUOz6; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KFUQ8Zwv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yw+sUOz6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776343830; x=1807879830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t6IHb2RqQBzPsTx33c1mmvpQnbd59fyzrbuRp58vCeA=;
  b=KFUQ8ZwvC0Eot/iRzAJvXRkBArqMNBUUqoWyPxh8+C/hPDwWu+YXAre0
   Qc3KAeVhLL4E5I0iz3QUDjsvAkrJhMWnZESr84/tXsWgVKjhIIWuDA2lN
   zBDV3B+6QvgsnOHn7iQ8AKMZkd9+4Sfcdmbci2Oy+S4ZUAKM8CjWNr63D
   sAllClMGQBluk3b4xb0UPNjwT3/cuVlJ3uKGfHAx4sBpgnrMjgMyCkTlI
   J1T16F9cISSZioHsXbFDHFJh6GyPQ0OHoJvx2Fx3POYyyz1vHbOn/5B1u
   yPO1zX34MkEZyk4AXeJ2wWcWqQBHvzBLRaS3HtBYy7YN7DeH2WBGz4zaX
   w==;
X-CSE-ConnectionGUID: ASkKxyNQS9KoLWPMk4HGjw==
X-CSE-MsgGUID: Nko3BLhYQ7yAJ6C8alvBRQ==
X-IronPort-AV: E=Sophos;i="6.23,181,1770566400"; 
   d="scan'208";a="140892567"
Received: from mail-eastusazon11012033.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2026 20:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJno3MilHsFx/I07+H11zRvsttCp4S2x9mSzvgIvbf1GyP+pB5vkYIBosxXuOyozQnS5F+DFAIu2ygts1SN24WSu2xXIYJj+t3uXIo+oM5R8xQVhhbdAVoy4FtIWTQ2Gvt3uOM52JZwUExBuDiVORJnbcBAzGBOKx/16J56/l/vZXdKrz5U6lC0KS3YtXhNcEcuvuh3CFyoZwtcZw1tkrDEc4btqNeKgsV+Ti1HtwqlmViNFtnfAleVUKLvlL4TD8TXIZ7EbPx/2mcTrzY2vhU9a4Rnbj5aF67stMqTmNMAJeXC8MvSPp7B7AgDK/kQRYrOIuVTwy6wwspdrD6GFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z4ZV0mwcXbKwWKQ9JzugErelAsAH32pWIuUcFX4CKw=;
 b=fDzcZ797pdW3I3JtjmqM0rqr2MPZhAlUfSIxZuriODGX0QXn2/xJv6KBbtaMeg+VcgTK3sdPA1L8Tf8JQgAyf9yeg19bW3e20h0+P2pzkkULWKmnrmZ1VULPgwXNKKafbh6Q7dktMjn3MoHvIy2EzLqLS5jctjSrnHfjn0jj3U4eI68iqF9e1eYC+0Ft4k9sqPexak4oG7U5wRXb5Zy++aIiEUCPkD00hFdrnj2x5duKa/P1DhVbARtWRIktDBDew9/hc+3b5PSq6v6w2ZyVfC6mWD6ftZwY4mK2+ZIFYyBUgEAtHF9Klh74+GUjobG4BZJw6Fm+IuSRk/nLWEt/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z4ZV0mwcXbKwWKQ9JzugErelAsAH32pWIuUcFX4CKw=;
 b=Yw+sUOz6SevW0xkEeN/E46BZXOjDTCgOd7QTcUR/Xks5wWsDDMW9yAZ643atSRbUXx9N1bS4x+YEb33huF3+gM4PaCv8OuYUxJXYt41KnZF5fwdaZMosq4pIacFBwKmrNvq04qzXtErjPKc75qh+td7hQQfbZMwWh8wAPVp5qKU=
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com (2603:10b6:a03:4f9::11)
 by LV3PR04MB9394.namprd04.prod.outlook.com (2603:10b6:408:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 12:50:20 +0000
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::7198:f387:b58f:e3e1]) by SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::7198:f387:b58f:e3e1%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 12:50:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"nilay@linux.ibm.com" <nilay@linux.ibm.com>
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Thread-Topic: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Thread-Index: AQHczMR07HPDR5bpHkiJJCT7jVf2qbXhpaCA
Date: Thu, 16 Apr 2026 12:50:19 +0000
Message-ID: <aeDYE1BfumNvutvS@shinmob>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
In-Reply-To: <20260415104111.1439459-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8536:EE_|LV3PR04MB9394:EE_
x-ms-office365-filtering-correlation-id: f3e3bfbb-a203-47b2-3827-08de9bb6b7af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 9vZCAWxstWfA5lpu1Eaf7jPEajg1afGr/DFJ35nI+wo6pNO+04YQJjvw9BIYjKuiUmOD1JIQMIpZM25TGt0QCLCHNNLs6uKaA/KIRj5SErddejboKnOFW8s7hbCvtHzU1uW8ElKduz9KnHNLzBjziDjoMedRp8OUX0NmJAY4W5nXn1P/ITCRYL7otKOy2zPOsfZCSXlKzXbXNOAwqQsCx1enUaa8XheKM40DzRYgT0r0cbOh0K+4xmRrNXR/825wpR6rq93tCqW2GlFPjIy0SF0FRieOiOkBUEW/fwHtwRGwMujblcAZblyfPCAS3Yv8dktO5XyqjlxG5oZ6mVkgAGHirgb24ryDhXiJpmtteN622fIRzNsmv/s9F81O3qbkSOQy1UwtrlHROzjptkSHkV2DoRwe48mCIFmy6eKbBRg2F6M6K9qIfCTWajEQl07BDPNXbxAlAa8Sc+bww9goh9syYUGVbI5wXTpMbZFodmF20wJiuUlNCeghVKKnoW/N7UzHtrYv3/QKCou5zunvd2ha2Cwz0fhxYJfQUe/+udopA3QI+lXftd2xWbETYeM0Va2wbgrBfEGZqIQt2AjHA/qW3mzJYBBji/Gtzoe2E0lzzN+/lqPVO/yG2b6qTK5Uaogq8/MCJnpbEh++mFVgWF6BsgdeSbYqDFY42me0kv8Wmiq+UgJBCpUuSeCxVNNsqN26AFvy6dJJacNH369SclZvsRdLMy4l6Owa4zlf62E2nTlfGOLvlklZ//4HvD7ngtBE0AGkkCYPCDv/I8nlIa5QBFeKoyJTzx495JMXGs0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mONcMrPQObSKQueZNgWPCkHjj77okx1MwA+LK7ao8nQa777v7loYTB+8vUvd?=
 =?us-ascii?Q?NHhVzZ0IuB9AXhDMSTsMnj3Fypg/DuxcNvY094OEUcII0zFQgbfWNfAkMvRU?=
 =?us-ascii?Q?P5oABHh9/+pDJufd7XdDnri/052+9j9bzysKLzQ2Dyk0qkgNmXTUajg1xz9o?=
 =?us-ascii?Q?24aHe9VwMYBwx6k5MB888Z/wSl0pkHY8Cpa20vDnvGnCKiiYgkEcX8qqnLTl?=
 =?us-ascii?Q?tl06RRo6zacXcu3lWQmk0lh49xAmjrAnFc3TKVnDDaDtEb3MLJ0VaY/6ONM1?=
 =?us-ascii?Q?HU3QGmfceBdEKQaHohLcjSVlgLKfEFTveZ3ZUJR+VggN64BUdB3HleFkIAwU?=
 =?us-ascii?Q?6F3EpNK1YFQ72HsXVCjNubiSbGRTvxTNxv3q5KtBVtzlCE8MKMzPExHhu1Ld?=
 =?us-ascii?Q?fOFY7XsW4hm1f/jHoD5Bg4IgrZzfn4pdZIQFwGmNpiJW62K5f1/94SURL04k?=
 =?us-ascii?Q?k29KdhFds081464OHJIe4oY0O0/Affc9zNTuCYDlvyAosWUdWYB+7SXVQomD?=
 =?us-ascii?Q?IMgyUoguzKRdBg2kQ+cewPbgQWvf3zN51ksgX8E2uyFSddZZNgRkquLq2Xzx?=
 =?us-ascii?Q?ySgfTQaasLCElTZPPOc7Opil1GxVBE9RtPJ1FTF4khc+/OlX0yKcjylikzYb?=
 =?us-ascii?Q?oQ0AZM++Y7y6dGflx1qMCXcyEtZGd37pSbjuKK2pr+yE3R4Y44kyo77G4iNw?=
 =?us-ascii?Q?c+pfAM/Pd0bGhPy25MSYsn3YaoNfUK08xasjPcJ2u/jgDN1hzOI4zF+l7kvg?=
 =?us-ascii?Q?yRITUXK4EI1VkzBtCBj1YdqzB7sEB9XdBfA9rPdIsJPeQh2eXaEhq4oj/P1D?=
 =?us-ascii?Q?yoDR/uNPwOpFrR5fgXkR38+LHxDvphKmzVn/1k4p2NpjQxQ2uytnQTP7DlTE?=
 =?us-ascii?Q?lVzmz+v0LgazBHkg2jVP2YWwfS1jtX77D3228e17jfv2wPnSrbzn85rBC2TP?=
 =?us-ascii?Q?OCqG/ok/qX/O/yVdUK+8aEFn6A0IiMm586mqKsu4bTT1Rv5vFUkAlKyyKL3X?=
 =?us-ascii?Q?JYcP1Vj8qgRM2qxle8gqxFPvhd5TGYlsMhnJZWNqfeOZOjgLFk0lei2Y5El6?=
 =?us-ascii?Q?bESg2k6lW7o/8/3nsF6MhLoLX0O4xhIkLsRfnvJXcTks4w08QhVYEStP+BKB?=
 =?us-ascii?Q?8ccVK/6UO6HFJqBuZh7GQU4x9K2Hyp4lFQyDHQ7hnXwWuKs6ghZu6gMCM1w8?=
 =?us-ascii?Q?bqrb/YG9gt/iZeAvHQ9+EEFW22u2H7NZNHSesYxJZKtqRTV8BnZNqxBkOuVD?=
 =?us-ascii?Q?CNZqOxSSYe4BHTysj0UyJ6toSUw72blhJtykKP/34FqClbQFxqOP4MSS8CJt?=
 =?us-ascii?Q?/ff+ofGMBNv2yZp+9Qd6GJxC9soHXBXN5e+rimFfI0O/lPtz2ZMTtObupcVJ?=
 =?us-ascii?Q?NAZYxUGqC6hemripyWlyiekHspHkfhpOWHSuycNSU82z4zFZlmzIfPMmvNWL?=
 =?us-ascii?Q?5NR/cjJu6ctZkaFU+QOONPuExwBCRevAR5KHXO4a4CKlMbsDaM5NgpKk3T4a?=
 =?us-ascii?Q?RUmWQItKLHiRrybhPGZWN5Xtl03mE4ZtZc8Gqfc208rhiRneIudWzkO37+6+?=
 =?us-ascii?Q?WaIMgvhY1ZAwneMeeEG1CLDXCLWBsyNOJ4J04dpVo7cw2ikZ57RaaAdWs4T2?=
 =?us-ascii?Q?pXi78WEpGOs9gVQqIEaap5+9rRxwvHYFNBXeDeh+A7JgKgV7uVdFLBz+pCei?=
 =?us-ascii?Q?xtL1/xEKkr4Gxd3EEqtfPhkld6WTSqqoUnEc0QMYB3bU12/2iVOCREO5yyA6?=
 =?us-ascii?Q?1RAHGoZ7HTnIQ/6npEunS8TM8vt2Ucg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1173F1B7E93E6D4AA9C440E5B0C0FF38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	a0fhDEam1cPT/cUQ9wZRSXTgFtwXRO2piYYRBw/nBxQ0KlmJEtsvUq1trCsVBIESgqgsck1qTcUlGu0pvJa21wOpF09DonsdJJYytSFborwA+jFXbFayTWXNAGobOiA3wbDEqZhYAZI8F9WYD1GcqdNfQHc7p1aESxb0gT24NM+DIm5UPCIu0KhPpC+P37Bcqy4Xfe6bTVeWrz99khuQMcxsRxIoCkzx0Aa2z+hci/Oo8z7naltS5nQ3p4OEP3lEUxvaOcXVAtz4LITyuG+IrkmBnTmiBDnqm5er9H1nGxbuHgOwaxW7Vv7SbcpQ04fhUjboz46uIRmt90rApT3XmA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2scnJ3ipEELYZ5I6D57oxhHFyZ6/WaEKw2khKLFZRT+Gog5+zDnb+w6zMiqtR0cYEVN+dBfb0+OuOj/GMTGY4c+lv44yvgndVF4QKPQ12lYTMpyRKPns7p4cmyoZAq33DXEvl4WTeQIjeOudtCApYQYkD9QP2+vMcTzXm1fKAdivM6FGXQv5MmMDNR0T9J42m4Rb6QOH2zAthLdMT2GEkx2wm4XD1ce/epNjHQoSj+Pz0/Lc3wm2h1IFBEVthvzICjzHszNj7LWEf3PKlJwFy12K3LV9Q7NZH1NVoWM2PjPi6jWdoXfqmkN09/SJi9wDoCGJajqkxXMgzlFevLHDKqb4jjwzXPOGGXcXk5H3He+Bnf9OEc6BII1d25wueHWpEjm/82ZAX+5UKC6tH3uw6mdTxITTt6uBjlsPw8tsykSIUEkKDXzaLucyiiWjRvCcMsOpzkvAW4V0+bXyqgjgDUcCjOhApfIcekxoP5GUr/JIPepbr5Q4//AJzxTfV50DziHXt82m557rlNsbxejERzjTQCayBXLbELFmgzp4VirT8U/dQoAlPEzBtfo8TBYTUYmYAo6/fTZ9D+cqdFpfLDhBbd4tnaMOUJF0+yXFMaMeC757xOVHbv2ta9nRfTfX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3bfbb-a203-47b2-3827-08de9bb6b7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 12:50:20.1228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAJCJccAXZZQg6hjG/ko8RppxTdDEmiUWFVIQcXx4NVPQugayDEfLDU4R94MMeaWOKW4OcssGi8WfDXEdVGWikR64MNR9uzltA7oSucsLt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9394

On Apr 15, 2026 / 10:41, John Garry wrote:
> For NVMe multipath, the delayed removal feature allows the multipath
> gendisk to remain present when all available paths are gone. The purpose =
of
> this feature is to ensure that we keep the gendisk for intermittent path
> failures.
>=20
> The delayed removal works on a timer - when all paths are gone, a timer i=
s
> kicked off; once the timer expires and no paths have returned, the gendis=
k
> is removed.
>=20
> When all paths are gone and the gendisk is still present, all reads and
> writes to the disk are queued. If a path returns before the timer
> expiration, the timer canceled and the queued IO is submitted;
> otherwise they fail when the timer expires.
>=20
> This testcase covers two scenarios in separate parts:
> a. test that IOs submitted after all paths are removed (and do not return=
)
>    fail
> b. test that IOs submitted between all paths removed and a path
>    returning succeed
>=20
> During the period of the timer being active, it must be ensured that the
> nvme-core module is not removed. Otherwise the driver may not be present
> to handle the timeout expiry. The kernel ensures this by taking a
> reference to the module. Ideally, we would try to remove the module durin=
g
> this test to prove that this is not possible (and the kernel behaves as
> expected), but that module will probably not be removable anyway due to
> many references. To test this feature, check that the refcount of the
> nvme-core module is incremented when the delayed timer is active.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

John, thanks for the patch. When I ran the new test case in my test environ=
ment,
it failed. The reported refcount mismatch looks happening in the Part b.

nvme/068 (tr=3Dloop) (NVMe multipath delayed removal test)     [failed]
    runtime  38.579s  ...  38.770s
    --- tests/nvme/068.out      2026-04-16 20:50:21.228000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_loop/nvme/068.out.bad=
     2026-04-16 21:30:36.215000000 +0900
    @@ -1,3 +1,4 @@
     Running nvme/068
     pwrite: Input/output error
    +module refcount not as original
     Test complete

I have no idea why it fails. Do you have any guess about the failure cause?

Also, please find my review comments in line.

>=20
> diff --git a/common/rc b/common/rc
> index 5350057..6eae0e2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -117,6 +117,16 @@ _module_not_in_use() {
>  	fi
>  }
> =20
> +_module_use_count() {
> +	local refcnt
> +	if [ -f "/sys/module/$1/refcnt" ]; then
> +		refcnt=3D"$(cat /sys/module/"$1"/refcnt)"
> +		echo $refcnt

To suppress Shellcheck warning, please add quotation marks: "$refcnt".

> +		return
> +	fi
> +	echo ""
> +}
> +
>  _have_module_param() {
>  	 _have_driver "$1" || return
> =20
> diff --git a/tests/nvme/068 b/tests/nvme/068
> new file mode 100644

File mode 755 is recommended for consistency.

> index 0000000..e06fd6b
> --- /dev/null
> +++ b/tests/nvme/068
> @@ -0,0 +1,118 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 John Garry
> +#
> +# Test NVMe multipath delayed removal works as expected
> +
> +. tests/nvme/rc
> +. common/xfs
> +
> +DESCRIPTION=3D"NVMe multipath delayed removal test"
> +QUICK=3D1

It is guided to set QUICK=3D1 for the test cases which completes
"in ~30 seconds or less". In my environment, this test case took 38
seconds, so I'm not so sure if this test case is quick. How long
does it take in your environment?

> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_module_param_value nvme_core multipath Y
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +_delayed_nvme_reconnect_ctrl() {
> +	sleep 5
> +	_nvme_connect_subsys
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local nvmedev
> +	local ns
> +	local bytes_written
> +	local refcnt_orig
> +	local refcnt
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys
> +
> +	# Part a: Prove that writes fail when no path returns. Any reads or
> +	#	  writes are queued during the delayed removal period. If no
> +	#	  paths return before the timer expires, then those IOs should
> +	#	  fail.
> +	#	  During the delayed removal period, ensure that the module
> +	#	  refcnt is incremented, to prove that we cannot remove the
> +	#	  driver during this period.
> +	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +	refcnt=3D$(_module_use_count nvme_core)
> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"

Shellcheck complains about the line above. I think it can be modified as be=
low:

	echo 10 > "/sys/block/${ns}/delayed_removal_secs"

> +	refcnt_orig=3D$(_module_use_count nvme_core)
> +	_nvme_disconnect_ctrl "${nvmedev}"
> +	sleep 1
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +	if [[ "${ns}" =3D "" ]]; then
> +		echo "could not find ns after disconnect"
> +	fi
> +	refcnt=3D$(_module_use_count nvme_core)
> +	if [ "$refcnt" !=3D "" ] && [ "$refcnt" -le "$refcnt_orig" ]; then
> +		echo "module refcount did not increase"
> +	fi
> +	bytes_written=3D$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
> +	if [ "$bytes_written" =3D=3D 4096 ]; then
> +		echo "wrote successfully after disconnect"
> +	fi
> +	sleep 10
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +	if [[ !"${ns}" =3D "" ]]; then

Shellcheck warns the line above. I guess it can be as follows:

	if [[ "${ns}" !=3D "" ]]; then

> +		echo "found ns after delayed removal"
> +	fi
> +	refcnt=3D$(_module_use_count nvme_core)
> +	if [ "$refcnt" !=3D "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
> +		echo "module refcount not as original"
> +	fi
> +
> +	# Part b: Ensure writes for an intermittent disconnect are successful.
> +	#	  During an intermittent disconnect, any reads or writes
> +	#	  queued should succeed after a path returns.
> +	#	  Also ensure module refcount behaviour is as expected, as
> +	#	  above.
> +	_nvme_connect_subsys
> +
> +	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +	refcnt_orig=3D$(_module_use_count nvme_core)
> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"

Again, the line above can be modified as follows for Shellcheck.

	echo 10 > "/sys/block/${ns}/delayed_removal_secs"
