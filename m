Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F791E5705
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751952967; cv=fail; b=fnhrFLSqcrxiWflQ3RleS751POaqSmJZKHjZWPfPqgl/wmyu8akdhLUWR7rIqq1tq3/uVEl1S8IYVqEuOaUkKflEvvSvgTmLd2jGegZD2jsaxRBsjAMPRrV3NmRN/auyfylPCmwE2WeOEkJQ6c9j946jReBfEzneEM8ttQ/oLgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751952967; c=relaxed/simple;
	bh=NK8n7dh602J/IvI2Fl94BqWnFE435epkly8gyu0CRX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyWkEXkjPzJ7o73RYG1Ksy1EHrWnWaHCo8dvlRcgtJOUZTbG/vP0PVF7U+/EzaYcaHlABAEc0xLuWQuTlyw6kDEuY+TSOM8jyfYsiayqoFDbo9u6DlJ+ydgZZpH/YLoqyZieVUKsEtVoXTHqqnK7yT/x1MNRuzoFe7t6hg0Cv1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Tt16p+sJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fBCklp9G; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tt16p+sJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fBCklp9G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751952964; x=1783488964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NK8n7dh602J/IvI2Fl94BqWnFE435epkly8gyu0CRX8=;
  b=Tt16p+sJt47ne0RZaxZ6yLqmS4jiEnrgu+MCaoqyYkcVowYNlavqlRGa
   sDiYmsMSTmP7a3HxolQ/yZU3IsYx69srCvxUAS0ajuE6+689AvwVz+myw
   hRkZMKiJF36RxRm482LWsPym0JF9cFkpuoj+qmkmasgF51VuboI8jJhtP
   mBhLrGQgqt6zPLHsYi50TFvHishufFKlM9KI+qHHSqmCFKSqsZFBjd4RK
   gLdNVvBf8cx4ikz51iCT4dWK5si2FdX7CZFEu/YsDI96/cbhEXDriTexf
   HsLL6JsUzWdoF5S8wsuPeFxbOQAIzOCu/RYeRLpaGkxR4r1J0yVlt+I9N
   Q==;
X-CSE-ConnectionGUID: JMWnuZMeSHmzc6zoxu7WWQ==
X-CSE-MsgGUID: m+jW1EyVRlOi0+Emf0h1iw==
X-IronPort-AV: E=Sophos;i="6.16,296,1744041600"; 
   d="scan'208";a="85991829"
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.60])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 13:35:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fulv0hnC6Prmgbuw+qSAGMbsjOr1XWw8EE913IVC0jHS/4yosW9i4ijb4y8QaMEDvRq3RNMqIXhLnD1Day/m6QcDxDJ1EoVkeHdzffHN8SVJTQCVML+LrAxUE1Xj+OHY3RR7QSDsery8t/PxPLp4KsufkNbobkHNWiArERRXBah5ebacr76OoROJJuwQ/LpYNVFzXpA+wL+onLHa+29E9Dcbx2WyJJxQqKbOulnB+3Fb6pd27lsZrD+W+vjIr/S5+b6+VogyscDVPn8l7Gl2a1E4zXSV0Z1p8hbjzKtoaafU6FKO56G3tHvb2riJTEsjsMSafKeIUXFKdAzR36ymug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK8n7dh602J/IvI2Fl94BqWnFE435epkly8gyu0CRX8=;
 b=qYmygu4KmDKYZk/C/4MvTqUKPhBsDCmH4CBNoG2Uq/kdpxd0x9UpSJqSp3eI9/pJpyE/C7ZcJWXW3p6VcA+aBL9de3A1DbsP1xEWbk9y/hQhRoSUY/IkxC6FtZWKwPX6JQJNFTFGWcnORjNirWIn3FT1a1sDw7bXxS6HHMyWC2Y7BoDIynISvrqSaQ5zEAzF665b8fekokUDBCjYPYmPPGTXIsFCTKSqxmuc8wDcc0UITtroXC7vlkjk45hHjIxY3VWgl62Sae2Jc3YDmieefTREXukX5K7R1obhN4gPpnT9mO7hmY9RAfQC3m5EbNM4vMjN1o3xLywZrVtRgMHKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK8n7dh602J/IvI2Fl94BqWnFE435epkly8gyu0CRX8=;
 b=fBCklp9G+gTgN8oP8L8xAzfL0UZbtF/H3kCabI3qs520AgeytAMdYR+G4XYNBdUjuSPL27f3XbHzLlv4RexqcWJRgUHJZ7WgN998Gtv3AZAwPcT5pr34vYlUfy4inmUHZ91GH/+wAdBe+uaAPxfOpD9j1onXJxT79RDc/jO6M2c=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA2PR04MB7595.namprd04.prod.outlook.com (2603:10b6:806:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 05:35:54 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 05:35:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v2] block: add block/040 for test updating
 nr_hw_queues vs switching elevator
Thread-Topic: [PATCH blktests v2] block: add block/040 for test updating
 nr_hw_queues vs switching elevator
Thread-Index: AQHb6zlr9Qq3Tl+Ae0uaFtOjRCGBD7QnveSA
Date: Tue, 8 Jul 2025 05:35:53 +0000
Message-ID: <ps4jetorwolaf77l3hg3syucovfiy7ejfrflinpy45nrstedbp@qjt2occmuhth>
References: <20250702100932.647761-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250702100932.647761-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA2PR04MB7595:EE_
x-ms-office365-filtering-correlation-id: d5463cb8-598e-44d6-6c40-08ddbde14ea4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Cwy8FGIfPeDBSGEH90INE9iY/esBUCCAyfMYIcDeeLY3oX1WTDVVb+yJlZtI?=
 =?us-ascii?Q?Y7De4ZT6PSBPvZBVrUWYOjklbMIlvTioRB6hTzT2gK00wN/Df73uB5WvqxN2?=
 =?us-ascii?Q?gPgGTIOOVEfo5+i1DoomXy+b66wvrRgGLqo7nbDTQd0w60Wx8YokhteIeSmO?=
 =?us-ascii?Q?YpKIw5hegsAT0k7QikI/X5N5UeBTRch5X2PYPv4DCeyPurlMAzyzFnQ/gGrz?=
 =?us-ascii?Q?XHMrAZT8Tt/tFaF7qowtrX0JrqfSH0Hzyv96tR10tZtehFjm8hD3yhO/1bPM?=
 =?us-ascii?Q?GjEI1kd6NgX0bzy1W0VHrcclVyg53p97sItVSHEg/1mvpg+ReNF8kfTsnvKk?=
 =?us-ascii?Q?2F5ljS/1Bk3C8Bd3NXCqUSlqkKttsYOVpyNEM+xm7i/XekMkjY/WS2/Qt1jJ?=
 =?us-ascii?Q?m4/9+973e/p2uBUHTGTFQhIkTSp5wYsMK3iMm11VlDYJ7eXozTQNUOGMq3DU?=
 =?us-ascii?Q?HHoDqqK9Vy0RwIKd/LOFrgfGAWoIFLfCHv/el8vZ5du6YVHfEwaj4olm9oQh?=
 =?us-ascii?Q?7QCprkIKkwHQAfx8xjC1Nm6I40kVLvK/rjK2L90Pt8TE3ix0igHcSt+VPJqd?=
 =?us-ascii?Q?u5n2WPBlDPYwR+MvHjMPl9ZwmQtQ69kUgQRHTtKwT1XiKR5kYNjLnAVwyZtO?=
 =?us-ascii?Q?Uylrd6ZSXf3tJYtSouzPga4lnKPry+q5j4MkzREDyVxoOAz9c38vF6uNH+6M?=
 =?us-ascii?Q?0KaLDuYq74libGbtKV4y+WS9DKjB+EuG6qAzxCL6JA7pJcUFqPbT3aiP9YGQ?=
 =?us-ascii?Q?HnRXy3tZJ9T94ew4NLhDt7KFijOpgAEbILOz51qWxKq0f40GB6fwrWGj+axD?=
 =?us-ascii?Q?aaNXckLTcedyk8NfARoJEn503CTr12FCySxy4ySkq3zKkda0zqPMEzGQcU3S?=
 =?us-ascii?Q?WTpObZGWNhTVOnejh7/LkQq00E4r5fZJcfusCNneVJeZ+zrHtu8vx8Ev3yeE?=
 =?us-ascii?Q?MmV1njJypExfOH9qFqhh661dZrOv2+f8+gDWgIpue3soQh5F6ikSD+BcC64g?=
 =?us-ascii?Q?SWP6mdxMlDrNEisueRFaruq29fogWO+OpBr1ZkVStdyy3RYQ9lMFW5FWy8T/?=
 =?us-ascii?Q?awp058SmyVx/NeIAqeoou2TzHFuUjwiMkQO4L0Ot/fGFoP+ewLugYhX/xJjp?=
 =?us-ascii?Q?3BTNBmAKgi7pGQxF1EBGOOlkfr6IV5X8r5DFQdzoZTdMtEPDuQ/9pr+ZIYa3?=
 =?us-ascii?Q?m6rqaYUbWDTKiXMmTzJMGR8cuMWiw/7Vo4ancL/q5qhIQsIB/TqNGUHjL6HA?=
 =?us-ascii?Q?N8eqDEtvCnsZ2H6pwsn8oBk10WrtciDJAgOfzVCkaP5JJgGP/abPFWwcpF/R?=
 =?us-ascii?Q?wIeISzdVFgDXE/2mgfk6hrmlRApCRqjN+UYZnrunL4MXjv7bC/4+eEWYAxik?=
 =?us-ascii?Q?ibWn74LsLwkGuXlTk8/wwAub5T8JoYbiOAM4e4lQmnPLkjp1fTRc1YrnBzNc?=
 =?us-ascii?Q?lK68KeCgA8eX5ICMs6vC0lVS5QKUFu5P2F82B+aiSNHrR0zVJ4W4rTYMfvGM?=
 =?us-ascii?Q?liHWnYIHTnsu16s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zQm9OAIFnRx1t8qylf6kioL0dxjEZd4EQMc5ahObMtgdQsg+2cRxqz1/u8D3?=
 =?us-ascii?Q?IFs0dCPI4/bhwvGRmbOM0ebti+Y2ftYseP49+h65+aEBbTK8h7Hr18xLR9wC?=
 =?us-ascii?Q?ZNDmq7vlADYGFqUkyT/kOaWeYZic6nv/IBtX98Ow7icgdfc7ZbBHFqnjyrEw?=
 =?us-ascii?Q?kjcJ2xHoeCe9WnXMi8mgGHkXePDOVT/KwCLFEPVR2UONdow+EPihgUw0LzkD?=
 =?us-ascii?Q?98kF+ETTeWqoH9udM9wTbiNnfwVEM3izH5FKF4T4BJvxTs8fQG22uJ3KaK3C?=
 =?us-ascii?Q?t/ijLK8KkmkUYJtZb1Uiw6bqgfMhO0d+TM5LrXoCrM8B+s8LJGbPiixsIalE?=
 =?us-ascii?Q?sbvM+oqXDVWcQ/yYvqCjTtJgDlJYwa2HsCYduTm+mF7tN5ZN0u2GYy01dEW0?=
 =?us-ascii?Q?JhTYnYQY3DG29HS2W23YP9bd96IqwZ6dhMu307MJ5gPXMrOwwsqqqerSesq7?=
 =?us-ascii?Q?g+F6bKTqnOgAPOBCxNq/2X57MTZUxVqrt6391JpjDSzExhGuZ4ZtbWpmrLit?=
 =?us-ascii?Q?iC1qc7iwMTT5Su1e5Z7UKyUrw9IiFaleNk6004PSh9SVYPe2SA12rSnqEyn3?=
 =?us-ascii?Q?U4ufog5pdut6ENTBgbFv05MXshVpMJ9zMZnPyLopUsZiu1psEjmW2olflqLc?=
 =?us-ascii?Q?5bWFW8UaW5slxCPLw+f8LG79MRnoXgI4BsB6L8Wh81tCQjILpbkHmxY6GvBa?=
 =?us-ascii?Q?yFHwj6b8FztzoEmiuKIVeyYGM/xbr1h3h4ZzF3hyM9ZMPgSVtyPAfGrQIibd?=
 =?us-ascii?Q?oLlBokp9Qe3C/C06sVEJkzcSZJjeWt0jKwue1xSFOyYQ5fIYTvm2R/npaqy4?=
 =?us-ascii?Q?rz3IxS4IopW8nJl8WfgozicqcqPrL5jWQHLskCVInlSElJWeCJs2HyyAZOWP?=
 =?us-ascii?Q?RhWE5utVo+dfGQl4gdI/qSb9ip0bgJr6N2G7ISLW5gYQsfN2PLDYnzuhPCAc?=
 =?us-ascii?Q?QuUQLcbjgpISKriTHCB35QRPmvm4XyDjXkLYjfmDRBlLBEKygMDOIDyrdVas?=
 =?us-ascii?Q?JLr+uGWKlW8WUPiI631GxBiZrJSTXhwKpkqrleYUomsCMpogFbcOk3EeNXKk?=
 =?us-ascii?Q?7PGEEVi5t2VWtNJyBisqxchvW2vavIpM1II9MejxqoVNPc8HeKVpdc2EPDKm?=
 =?us-ascii?Q?2hWtNNhml+0VOtL480Ce0PCvsMFjVpYrI4RaMfiDTLMw8uVFpzoIFg9asJBb?=
 =?us-ascii?Q?KVTNJw9PTNTWpb03T3jRuowA9dKiQ7tYr2taG7xil7NXc6/cBC1JqXlbbXsi?=
 =?us-ascii?Q?yg7uOZ3fN/wuIBmyN+yf9YnGff4FSin5Ccr8Xq0kzqB1C55TiKxH9UWzav4z?=
 =?us-ascii?Q?huA8vB+QDhqqLlP7Vff7bgD6NMjR30dIKT5g2V5HwsGf2a8ddC3YOd6T48Yc?=
 =?us-ascii?Q?HyMTmJU5Nli82U2N0xJRDjaWiUWFEh+RSJvmRrBYaJ0hCJ4ZQNc8ye6BtSfO?=
 =?us-ascii?Q?UUFxv70MXBR2BBUL19f2A0EdcU6YOSgn4efGWEInnx8M3ltORypcw92n6bG4?=
 =?us-ascii?Q?Obz24cNDd1LWAzNz0zSYtxd/tmkWcUFyDMwH9yT32IbEe33W5r2rqM/tccTM?=
 =?us-ascii?Q?qXKumDrB/Jk/wMEDn5PmnrhNnCUiXJJhIVZcqBtUB3e4UJTxpN4usbvPBFS0?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C9B5EF10F162249AED64B431477A9FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c21GASsSJus53KlSb2zUY8Wmqw0xuZwCax4WfYrmdXYTLMto4t28B7zMlvS+bd2eQkb4i80/pq6dQqVKV+NVmI38N4c336zxTU6JBgTz4kqrjsVeYAbulCgKae+C5gZ/li2/lvpOoWc5g4kfjLMqF0vSDwnmYWc0e1T0LaUq4HEnpBEajlfwCnT2sAN0F3AlNvfdYo1DFXHgfljf7GwLot+P/Woutz37VoihanKcI1ES4A838xSkknfQB3lvKYSc1ff1mRnguhKOJVyysRLwAR9Bzn+LwAI3KdIxhPAuWt7mhzHxz98yCKtYmd/7cqzcwjgFyZXYSB7o8plzZtAuZ+uKvd4N8rwK/nZ8YGbTQEEtE1+1YrX9IcYY3snzswgnPmZq8Ms+CgLSZw9Lor+rQxXXdXiylKehmWOmiN3KBAem3O0dURVg1SNNBofxPSA4mXQr/iHJW5X0wygbBE4o5UWF9m1pyQvun6w4z5jyIyzdNpeKmEJ2MDNkcxRfMBtiuVkQaT1jFjemHWspzgXu9y3Xw4IyWmCslzaJj0FaGJBdqo+UvU35SuTni3CAuPO7PfjZ2Mtz6PyTd4etfzbGbQizO4zqjp1YR8H+VSSeD+0sLC7mKrwSamjwgR7urvTt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5463cb8-598e-44d6-6c40-08ddbde14ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 05:35:54.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s76rJfgW4BOjegiWQVASTxcbLk/1GCPZQ+a9VNNzB0tR9T+/4Ktv8JF+F15CkMJ08082ssWI349LkUt8VpXaCSjThSj2odEDdYrR7iXnP9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7595

On Jul 02, 2025 / 19:09, Shin'ichiro Kawasaki wrote:
> From: Ming Lei <ming.lei@redhat.com>
>=20
> Add block/040 for covering updating nr_hw_queues and switching elevator.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [Shin'ichiro: fixed redirection to scheduler file and skip reason check]
> [Shin'ichiro: renumbered test case]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> I take the liberty to modify the original patch by Ming [1] to reflect my
> review comments. The new test case had caused hang with the v6.15-rcX
> kernel. Now it works good with the v6.16-rcX kernel. Thank you for the
> fix work.
>=20
> [1] https://lore.kernel.org/linux-block/20250402041429.942623-1-ming.lei@=
redhat.com/

FYI, I applied the patch, with tow slight modifications below.

...

> diff --git a/tests/block/040 b/tests/block/040
> new file mode 100755
> index 0000000..fbc433a
> --- /dev/null
> +++ b/tests/block/040
> @@ -0,0 +1,71 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2025 Ming Lei <ming.lei@redhat.com>
> +#
> +# Most of code is copied from block/029
> +#
> +# Trigger blk_mq_update_nr_hw_queues() & elevator switch

I added some more descriptions here, especially about the relevant kernel c=
ommit
b126d9d7475e.

> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION=3D"test blk_mq_update_nr_hw_queues() vs switch elevator"
> +QUICK=3D1

I replaced this "QUICK=3D1" flag with "TIMED=3D1" flag.

Anyway, thank you for the contribution :)=
