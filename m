Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7E132116
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345029; cv=fail; b=NpuJM9xmTzQmpaj8Mr5ptKnbiYIzwO/pxLxq1ofWAsLGZDi/EyQ6n9bOuNfwsbBzeQVVzHUsbX8ZakbLLm+Fy1H6OLq6YhFZT/PXFES3S5RcuRSkiHxHR1eRehNV/lUaQ8XneU4sg5HjT5cGE/3GjYrRakOS1Z1d1MgcZzptysc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345029; c=relaxed/simple;
	bh=LnkC/yb71eSZN62iJDm4rliAowRRg4WIv19rVJqt4hU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMh2al1xV2/i8W6LCxYyMCc2pB5fqM7VTVJBWwHgJ7giQMBauzlDbk6QxpaxMFl5Jd+QDVJzV1ytLTr7ebf3ovzdazlCOpz5nMD0Kow2VW/jHZ+vhQ6OaxZ3yuKE0aMc1pW64CR5I6YDbpTUYOiLm+tpQ0MPbQLviLNy0z8woNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TxnySzjQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yf5guvz8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TxnySzjQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yf5guvz8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718345027; x=1749881027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LnkC/yb71eSZN62iJDm4rliAowRRg4WIv19rVJqt4hU=;
  b=TxnySzjQ8NcJG1F29V4uZe+n+LIrZCZYa7pGxNwLE0zW9vvBPx0dZ0vj
   894wXKzVy+9nh0jSOS4xO/uioRkf52oWIRB+on64b6pe1NH5C/fkMamP2
   4Gfe1rp5hJUlRAXSYADVNxYUJ7f/ZwkVusatkDl88tRCr9VCtG41yYB2i
   E3nx53sUo/ws70vNaAQFUQfdxkWi8kXeVfw2HDNmkWWD0yEFfhgWrzvSK
   wSKaCEFxcOv8yWnFRC0sxHXLUzI/Gptl5MqBypEBlfnpqyoamWFjy+86i
   E1di/y6jInSaFYUXehALbUJHjTusiNwrpvx0zQLA0QgcE3UXB+VM+5xOv
   Q==;
X-CSE-ConnectionGUID: sW9ZZ+e+RQeF9qqw7ZksZw==
X-CSE-MsgGUID: x0j7AIHhRqeNdm23nFTedQ==
X-IronPort-AV: E=Sophos;i="6.08,236,1712592000"; 
   d="scan'208";a="19090219"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2024 14:03:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L96xWibgxfIalYSSBpMQQB8hRyGttdDfglOzaq74vTYADU2Q1TM6ec3azIDfN8f8doj+elWVOZTmBO8gGjwrUEgTKC/vwh/rsej9aO7oWYkwv7aVcfL+AT5787Kb4MIVxG41kH1e69gfGD2SUeIZCWtcYGjMb52LerIzCcJtiGGcGOW5RTfO8/lS/1xUnh6jJgByRzooaSlnjx8zozEFtKyXOII3ocTV6kNzzN5aht+qCJ5PUa+shYjFaEkMllIq6MJKDxR67QkjsZwXwfUzSOw2GV8I1g5fJyLbptAahlydGDNizmN/q7wQpShYIs4bPFlvz5zVLwduTeUMJkgPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+bbPxAnXAG9jQojhxtk6Z54iOD4THthOTwmrqoDWVI=;
 b=AhPoctqaUbPB6j6dW0x4RRrahAsfrM9N/gtvDerJ3suI0tEWMd4oHQWN7aMq0hr+YuI+TDljw/lDcxk+ceGbsZmruOfIQwt/NoBmkvKo623C8ev/WRKwJEq/ZtxSiavL/0A8dKHcqs4L87tL+eWRzdTcE31lX8sQ7vkjvmycDQnMqYN/OHUNLNrQqmPSW1c7esN8P32Cse+RU6y8wt2P4Il/qb41fbxEmXfMpusarPqFqSccO3L+jfv4tOSJ96ZsTfVEYbwYQunJTIy1nBE55l9NPVZLCHkgZiF1TY9y0TPXVROvnmLxpefkftH+19KD28WWUnArmWA821d+ZYb18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+bbPxAnXAG9jQojhxtk6Z54iOD4THthOTwmrqoDWVI=;
 b=yf5guvz8NsYd+UHKipnrfh95U6nZ+Ogidy5tOkRXm+zHLYBG3jOCC/QmFoa/O9k8ZtWg9hT4eP+jx2NG3FFfjix4GePBwEkBiGN+uxU6nB099BbtvGUNq8e2gO8yBiV1MoxxSHCmloMwP47444VXD7md6ckXJ8lniHKvYLVJzqQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7823.namprd04.prod.outlook.com (2603:10b6:a03:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 06:03:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 06:03:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Bryan Gurney <bgurney@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: blktests dm/002 always fails for me
Thread-Topic: blktests dm/002 always fails for me
Thread-Index: AQHavWqPXCpPMpKn4ECcCs6HQBvzjLHGxlmA
Date: Fri, 14 Jun 2024 06:03:36 +0000
Message-ID: <pysa5z7udtu2rotezahzhkxjif7kc4nutl3b2f74n3qi2sp7wr@nt5morq6exph>
References: <ZmqrzUyLcUORPdOe@infradead.org>
In-Reply-To: <ZmqrzUyLcUORPdOe@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: 4ff221a6-5ba8-40cc-11d1-08dc8c37bae6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XDT4Se9T2K7IZBKgn0rUjfXYUZ704ydwXGJ+MGB9w0qI2D/ZDmTTtB6URfIs?=
 =?us-ascii?Q?Cbzws1ltl6/pOT8M2DKGadE56mJxCaH5LW8GIJY9msvXZLQ66/9W38+9B3ik?=
 =?us-ascii?Q?eEq2PW/VRWS335NfoumlIk7wgyo2MVDTKibWMTexWAbWco958g5MaPisUzEE?=
 =?us-ascii?Q?5N5YopwSyHCdlrJG1EqpINzYDPkP2bRCevX0bSd8qdlu4W7q1TheGFl68Srb?=
 =?us-ascii?Q?1CgiR4f8/v6vUUJvAIxWO53Hr0EVrWl56MDghdC4qLxDHdH0i40xAfrItcLj?=
 =?us-ascii?Q?aZQW5Cd+1muixj+1Bg0z2Rdd+F4hxS+WFEr+wEdsYmdeGeFHfgBvXIJSxYhn?=
 =?us-ascii?Q?fMpHtLicZBpyh8a2DlT4SeDGAMXPZeEA9GIt5f+555Tf981jWvPTMcpK467e?=
 =?us-ascii?Q?JtUo1Tq2H3gsFjHqE9MBQ9SoFXS6+jD4l7fTduskEKMMgGos3o7rKDhObohw?=
 =?us-ascii?Q?VNvOuU/awbMtmW857Ft3bL9eeJjYmMnka++YTLBiZBtV+XRn3g80+yznp1p6?=
 =?us-ascii?Q?xR9aDQyroejyfBumb8n/TKDEw+nV04RhYNbuzeggA/iu/SHQ9vWj/B5Ht42X?=
 =?us-ascii?Q?fP7AlCoLUmh4qcuXeFrvp9gZC0bgYMPZF3IPoe1+ZdyjmnBtmCvS47jhcXSG?=
 =?us-ascii?Q?9mLq93HDKBLl2nYKC3Jbj2uvN3Hth6ODXBbicCIyKIRj4m7lruYitcdiH1ck?=
 =?us-ascii?Q?LvZRudShioyE64rWo6S1cIjDVsozIhgGM8zB/VcnJqsGd3YRCFVDXqZObJE4?=
 =?us-ascii?Q?Z8dscpLgaWQfz4NgwcLc5cRhlCom9tsZJBo9WbDXThD+Ff3uHgvBPiap4+or?=
 =?us-ascii?Q?LGlWNWgTlLCo3vUgdVwO12JhKeijoaV4WatXLgMBBLzPnu4AL5lxzk9WREz9?=
 =?us-ascii?Q?+vuZVJlO1eckSxkggRlVQlyZ+JU5JqBSQ56rVXaF5ZSDHjQRB+jMovX8RoBE?=
 =?us-ascii?Q?QWUDiUKmdaIJk5BVAwPZAQtOsmtS5s1JKHdxwJxYx9OBnEVtMf8CnAJaxtqf?=
 =?us-ascii?Q?RLUpAtbDNwx/amoVgIvjivCX6LMft5H5zyNrwpAoPDwkGpbKfCOaOt5hs+Cr?=
 =?us-ascii?Q?lw+QSSeBZDEqe6IwhFkMgvA/TYyCfTluLH8YADbbokAYEPKMGUgb3RbZ1KG+?=
 =?us-ascii?Q?rbyndhiprqZiZ0gcDlcfsHhm+jLeh8AARgGxLbgvipih4aXmBL0hBiABe0Hk?=
 =?us-ascii?Q?8thH07PnTiaGULLM4/ugqvVzW0dRSSJbyrrrWfA+ox0z1BX5j0y/1dJILBx1?=
 =?us-ascii?Q?CWuHtlX5xJTI6Tpt0t3SPKSYrJUwCQOnxLcE9sLqhqoQrWvZ0UXFYnOJ5cAj?=
 =?us-ascii?Q?JsawQhPosFC4srnL6o4OUW/OchW9s0Rb+oUHnbZc6mEHjPn3qfapsD7/qB1W?=
 =?us-ascii?Q?UG3qVP4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GVLrx+DLqCgKGAaY0X8VSz/LCMo2M1SnztOn/dG/n07f4GuL6dkovb0dZVuY?=
 =?us-ascii?Q?NX1XlExVbRgq6ToFJR05qiHxy5AgOWBJIxmP7NoJ1JO0I/3XuLESYVVdREGv?=
 =?us-ascii?Q?c1N15iZVXq95cq7gw/Mku5Gos7MrFaocets0BnZRGBxxsqN3Nw5aE1pc2lU8?=
 =?us-ascii?Q?rSV+HS1/KOF+32JU+TDPJWlQaczpbNS2zwIVcYelZcCjUTeTVsO0ci0Slt4o?=
 =?us-ascii?Q?kLnk4V8a06eljrP14V7yg8zp4Zcg1kgW3UPHnCQJouxh2XaKqWf7jNIRLoDL?=
 =?us-ascii?Q?NiMrhZUn3Yy8TpuS8GHsjU5NE6EK7syMf4RmJdes8JoSjm3CJXyjs63ylqnf?=
 =?us-ascii?Q?Ayx2uHehuZuYtJv6Bho7GqJpiSjT4vyoCTlfBqMC3wweP1CviarVK7eWPS98?=
 =?us-ascii?Q?dlasSmOWjFMAo1BMPPp62EjDyREdh070FXv+9RXHZERJSLvF74sXFFI3+VWP?=
 =?us-ascii?Q?GZRxJG407Wb4LnnWDG7wQAhuk7twX+PIu6Na86WMwfuATHPTxwAyQt/df1hi?=
 =?us-ascii?Q?UJ6anVwrIxBaESFwmqX0CjDkjQcIDQpL2CNTGtEXzF2OK/Si4/I5jRs7RegW?=
 =?us-ascii?Q?8LghL+dWjmfaIzTmv0wz6rESX9x/epR2XrtThAe61Gugk5nxEWV3WP44HbMl?=
 =?us-ascii?Q?opMUsm9jMg+EuZyjrFHsRxBJrImSMSwRl9BFunPK2qGS9KGVX5iZ4+RXTX/P?=
 =?us-ascii?Q?Kf4BHpqWFoG3YW9DFt2nqa/yj7qQQ4kQLDXoC4/gbucK+yZ8uAOibgSH8G/4?=
 =?us-ascii?Q?qjXBQX5GyfpvPDDI60oI+s2FRGvjG57dYuk9eghMGE1UMiG/eT9VIuFWogmF?=
 =?us-ascii?Q?PVRFElPnNqPz0Nu/zUS9YPfK44xIPRtO+gB83yqwmoXqzjx1YCDHC53ivKEA?=
 =?us-ascii?Q?HsE6BWaw7wjeMtzfLWOCfAmXDzAmZ7GzwscSK13YAGixuac7AFeWXS0vDEwB?=
 =?us-ascii?Q?o7x4/tlI02/JZ7EeKOL9FyfURofZGrkJR8l1qDghMlSRf+6RUvTi0k6h58aq?=
 =?us-ascii?Q?hNgKnQ5fctWYtzaF3SB1J2hzhYqoJgm4QI82q+XFmPjCAiWLEe5WJpafBGCL?=
 =?us-ascii?Q?3pZ8QEnueKy3Zfnv0o9CVMcUuUOhqiPRSQK6CGliF6ObkJpyWt7UK8H8duJ5?=
 =?us-ascii?Q?vLZV0wlCU23E3IuAYU3PbCaifiF4iHS4XqibbzalVwkrNu1ap7YvMsqebzBx?=
 =?us-ascii?Q?NASFld8eJyhld6CbRZxY0wmkDHF7aqsbq16ZuB8bicSmkwUDnkK+zyZIYoZM?=
 =?us-ascii?Q?1UcRrDKyrlTrCkGzXgbhY8at0lFINuMIVPuO8vZWOAnHpDmYBfleDwgwayNX?=
 =?us-ascii?Q?dpN0foTb6MT4IyQ60vdl5T/a988/UlWid6IKsj8Lf2xL0JiI7r4lAjKQdqNT?=
 =?us-ascii?Q?NLJErpuGVW0Q4RC0VVUCHmafVUTeoVJ4ErAOT/2zmEx+OpzWAkqi3oaXq1E1?=
 =?us-ascii?Q?R2eKFgHqhSJOwsUHYZajZ3F2phaqVTevzQOXeaFkcinWS9nLdbSUqmMPoQf4?=
 =?us-ascii?Q?4YGVZa4yZQq+iVwxTkTDZcwDjaocw6QCph2srvOFUmEQ9mS0dTP8exq9flMw?=
 =?us-ascii?Q?4sN6JFBpC3ubxquo6fkg0kWelL+QOzZMZFBpY4v0hL9AchOqvu7i3LoyPg31?=
 =?us-ascii?Q?weRuoty1f6LYL9aHKL/PcSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EB5D22FAE173A43BEAC8089F1D955DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oOFRX3Y+8OoOiQ3ICJ3L9zbt3CXGWDA3T6w/Vsi5nTQnxyIpyk3y0ZqZY1FgjPikZ2ZLhvhrPdXGrx2AdM5Z/ZCNEC+xMFcY1Mf6PY2l+N2mCGzABnpMkqK1r5HD1GJUU1J3Jh2Fa3deOq2pcMB/uhash9K1GSG1Bchoun00QGKj/MZzNdLqr+omsoBtPnF2AbQQoGHey/PsTPw9Ghjwh/nQbCVNwPNx0KZRLUUrrrB9dowj/E9y+Nuh9m2FlCMbd7DoyjNVpDIF/wHJmKTlmNSwJkxUCIAzIQh502qt+l7Aq4mqDNudZ99piXMdiogLgHUgMMjwr4INWnzT455PZRn1xNUZRaSehAwXYjDGtwUXAc4O07iYKMhRfgCm5YNpAJsiM3yCzWzPn5g+3ADWWY3OvkcB6+ZJCe5veZq+TsBWA05/gMM3Lq83TrtrwDiE0t2oSk6/1HVDh9gZdkTNyNVTtAmW//AY6KkwxMO5kOA3swi91iZglqKJnIApYW0zRMsimjn7vGYc8MnOKGPYmqQX5cra/tf3XudO1tq0S3xfEZ+5c+FMlEydD5EaHHnbtlwLpLVgQOF24C82cGjCImLDowrss44R9VXg6A8CEXPWRWeDaRnwZKWeVe+P0kBe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff221a6-5ba8-40cc-11d1-08dc8c37bae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 06:03:36.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Wq6GywRdFpaWgvW6JHZQPtjlk12TMuwvFoHLJGViDOiV7VQ0Z6WhBsvvHOl1A5w8crCRC/1yK/6TVVWSM2DZ/7QQzJacDudcit7lQcrHzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7823

On Jun 13, 2024 / 01:20, Christoph Hellwig wrote:
> Hi all,
>=20
> every since the test was added dm/002 fails for me as shown below.
> Does it it need fixes not in mainline yet?

The test case always passes for me and I did not expect this failure. I'm n=
ot
aware of any changes waiting for mainline, both kernel side and blktests si=
de.

I would like to take a closer look in the failure, but I can not recreate i=
t on
my test systems. I wonder what is the difference between your test system a=
nd
mine. I guess kernel config difference could be the difference. Could you s=
hare
your kernel config?

>=20
> dm/002 =3D> vdb (dm-dust general functionality test)
> [failed]tors
>     runtime  0.044s  ...  0.049son dev dm-0, logical block 8, async page =
read
>     --- tests/dm/002.out	2024-06-02 08:38:27.252957357 +0000
>     +++ /root/blktests/results/vdb/dm/002.out.bad 2024-06-13 08:19:31.526=
336224 +0000
>     @@ -6,5 +6,3 @@
>      dust_clear_badblocks: badblocks cleared
>      countbadblocks: 0 badblock(s) found
>      countbadblocks: 3 badblock(s) found
>     -countbadblocks: 0 badblock(s) found
>     -Test complete
>      modprobe: FATAL: Module dm_dust is in use.=
