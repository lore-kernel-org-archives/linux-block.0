Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2E2C9A
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739148757; cv=fail; b=UyKVfCy6VNR0qmOReY1kYYvOL3Moe8cIssa1TJKBDKrqjVHDliZ5/RebntFrp1kIa+7xWO+dz6ysDSP3iqp+qk6g9HH30BrT2tQP/ZLTiczddwoJxWE4LUNOC2ov3szeqPzOoglY2TSJsrzm2HtBXEHFvgvlV0p1BN/53jpyTe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739148757; c=relaxed/simple;
	bh=zFsHIw89yJ4lxSdnorkkxUGC1HRLcOpbXvRgweOG1e4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BijtcScKNgbd4icPz8wpCHuhvZFBRJsvGP09r8N0JyyP9NWfxk+DO5JGPR8y2ANY1KoURaKBuGsS22SgfCW382bolXFqf7I7eiqRPAeueNX5x6UZxG3VBFJNcxR+KSZwtomi0D1KdyOoXVPifZmcwOMvr9GVwP7VxwcV3GRTVwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Wa4XVz5g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tRdhMe6S; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wa4XVz5g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tRdhMe6S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739148755; x=1770684755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zFsHIw89yJ4lxSdnorkkxUGC1HRLcOpbXvRgweOG1e4=;
  b=Wa4XVz5geEsquPeq8uzhiYW/RNyP+YtGlIgPl9BrtF0SGXkiYk3IXL3i
   En+2Om962D4ag0wQC+ZRA3zJBnOdJ1K6vhvQlCTb4v/wDW35Bn+b7/MgE
   ls1HLd3dKUUGLI+pSJKlNScHj9AZ6hSHK3+dM9iyFosLGD6BzzOMGms1C
   y2579UCM/uOlq3Pxp6jMtr57iD99I/iywa2/9usqOKtrqaoj1M4g0HK2o
   riZCc7m/J6iT8/wiJBJS05fMOWzYGeaOE8PZhhFeVyyYWOmTWT+fl9XvG
   0P8OdiykyQGgpqb1o/c+LkwaCekS+asc3qXUreSAMLTsSipQpRIIGwr5d
   w==;
X-CSE-ConnectionGUID: GO8rbKIbS5iHwc0CicIDVQ==
X-CSE-MsgGUID: 24F0rg7VR/6JXAA6W2VdDA==
X-IronPort-AV: E=Sophos;i="6.13,273,1732550400"; 
   d="scan'208";a="37408268"
Received: from mail-westcentralusazlp17010002.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.2])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2025 08:52:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLpEOfclPQ6uRhwZd+xwz3O3ATVwqWt9GrXKtnjvlkxy5dS6TjHoqfRMwQpAc5TuQD5JM0tcljCsNiiQKa/lCj70M1DBMz7Cwhjh44iO5xvEi+FcRF+ZQBkBEsttE9ngQKv3ffqo/xHXtO2UPvnEMMedCK8hdFOwYt9MAnUtigRfHRohDaCZccb5gvbn7pxNdO4cfFFU4NKRxhd3VKzF7cTBa9utgCBnqd/KL0pCt8BQ60N/+fDH2Pj+bEQmh9vPiuPiTW0Szv7ALSiXNKy3MWO2qoDzFcLPIFygM/9m6hp+QMAMrjeRHv/7hiNzAFAP9CA85WRrEZSds237AHUeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Peis7Rz3oELAWVNqIAtqtlrpRcZmzE8D5q0tBV4WsPc=;
 b=k/5rSQ+QV6wI6J8PsNXLBkS+u9uVLm29yHF99NvxF03S4DojxAEzYaJGVzxAXvMKgDPTCOKus88Ukfpk4ygp+VVQGxqIk8Hy0jJ3omTr7UEm7xZMESjdxfl8wQhsnVZssYjI994wRLxyjR+gzauzSSuni5ioDcThC266EBsYoXMZKydYTQf652UhBLs4l61MKMojbvn5tlYINOMk3kvZ26/7mkpQDw90c/x30dRTauEJLTXE9e9rGMZ3VvrEyIKD+cAbbK2nLBYSQLo+LXzpBUXvqIYnm5pWTXjHCABuTjqcAd6YArCWjB5nE2gxo8Cgxmb94QFK9I4i8NyzWZ3TSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Peis7Rz3oELAWVNqIAtqtlrpRcZmzE8D5q0tBV4WsPc=;
 b=tRdhMe6SumapfgnAQX2usLjSceGtsIEjsnCQ0d6TCqUXPo1NmRVoBdjLJwgp6mOaFypy/PQrFY1nD3DHjvcvOHp6sDcTEZSglcjmKeAICTGaMHLlxeB6a08jdhGgcrn+XH3o/UcQZMjwjOFL/TvSDzMmznZlTELats0fP+LbI8o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8434.namprd04.prod.outlook.com (2603:10b6:510:f1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 00:52:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 00:52:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>, Nilay Shroff
	<nilay@linux.ibm.com>
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
Thread-Topic: [PATCH 7/7] block: don't grab q->debugfs_mutex
Thread-Index: AQHbeu0quoDO5EIfzkKlon3LPhzPzrM/tjkA
Date: Mon, 10 Feb 2025 00:52:21 +0000
Message-ID: <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
 <20250209122035.1327325-8-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-8-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8434:EE_
x-ms-office365-filtering-correlation-id: ffc1ec90-96c8-4df1-1e76-08dd496d2d00
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oYdF3dyPokOJeybrmtQuL52q4LSJkGg2PXUrfkTYJ6i3tBMoKYZEAIezKnUH?=
 =?us-ascii?Q?3Oah+MgqwVfOB6eb7mz8FbAT6dD4GAZ06UM0WBUUSv9BetLgG1izblhwM7I4?=
 =?us-ascii?Q?1k1EiZwOT9UjTAK+VyJbRSu08pahX/Rgu7rGj/FAqumQtJbkFnKAROsQAtS5?=
 =?us-ascii?Q?EjzCWqY3cBzWHp5JTs3uYsYLqua7QFueES4nTSBNFXp72LLtDp9eZtrbSW7R?=
 =?us-ascii?Q?jjWBRbTlwwy4+bHbmOdWDjDlsqkUPHo3JuvSecym9Lg/gPNZPoIluvFQYPuu?=
 =?us-ascii?Q?/yqjelJMuHFA4jcjpDawF9JHSaRBaGTC41uwqnLAS2xBAFE1TPZEcAocROjJ?=
 =?us-ascii?Q?ROD/+/zchuRjoqpZZMb1qJQdo5kvdovun/doRECLj2EZZJb/PF4IetCJNXjS?=
 =?us-ascii?Q?3fzGolcX3raaQw4rCcY5XxqLlI1F9ZyqJLfbij/+4GmOLZSZrxOPZ8Ew9faO?=
 =?us-ascii?Q?wA1/Eyo+5OIrUtaSRXSG96LcInCruFvZlcnpxeQxCnLz6qndMXGAHCulVUrK?=
 =?us-ascii?Q?iTx6WEcwRNnfyMo2QDx8ebf2TW41rc8sNQltaEmh7+gVLuadCHJAKTLgmEFR?=
 =?us-ascii?Q?Nh9XoQk6B0icIiu9XXnUvIgXIOrwds1t2gND16Fxk5lHfKdlThErbAcJajbH?=
 =?us-ascii?Q?3Kg+YUdTuJyBIpCDD05SEdnzqruXzH3tRypxgR9Qx8L0Tk2iBazBegNnjHE8?=
 =?us-ascii?Q?P/5F5ccw5pHUCDOuPTji6QPxK5PpSB4LSFrIrZpnw6WcLPy6hXo3CzpopkTI?=
 =?us-ascii?Q?UFjYvdv2g8ckoSpnG8D2yd0es4SGc7WC/pAfkYa03j2cOeMSakGfz94SNtNY?=
 =?us-ascii?Q?GpJqyknpHF/9Iu3Q+NtlI69X7BnmQ7sgKLlYVseF6+QnFIiK98glXQuP8l9q?=
 =?us-ascii?Q?XmMq6LaeuCxLWAaOIfd1/s7zol7039U71ZZaJxysbTJmcbOWEFvVj5gMjENa?=
 =?us-ascii?Q?TrNHD801Cw+0FS8kp7Bq45tXinYPNNkICTJGJjcaaDellX22sswqns+lBfGO?=
 =?us-ascii?Q?VuZ06TO+MQeHSptRa6WHRCopKg5DeU8zscrltdHDHxV1j8lta+29zYBImBz8?=
 =?us-ascii?Q?Dmgo/Oztyav/nJSLFQvX5I4NcCR+d7+qjSGNKKUdVOzl5bA/vGcxKpN8wpDs?=
 =?us-ascii?Q?x216NyIb2MqeUm/R894apM8vmPs1uibQiwk+Uqjqy07dHOUbei9lolq8kJYi?=
 =?us-ascii?Q?9ABS6D1Hk6qi7pR5nDiOYjI3OcWSfdZ1zM11j5rCNz6ukfzJDzEisx9a7htd?=
 =?us-ascii?Q?56XTFfu2hK0MWMQsBbWwBQvBj8wWp5A1jQmbFswCtIZVGHVsCsAyDHC3rP2Y?=
 =?us-ascii?Q?ny5YCB3AL7F29R9zUp5H9oK4+mjuat8nS+55vr/TlpJkSr6OzmadJN/Zfwkc?=
 =?us-ascii?Q?c0rTo7wypyqSaOaHTRvKSg/qt+jRTcFPpNF5ILuR1Brkld8GAfFz5zvHdIVl?=
 =?us-ascii?Q?fpzrnhqaQ6DyM9u7LglAj9fONwQhl5HJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UIFezsWJM0u3frZzRjF5C7TJqA9eUKrKHsBrUghodHTRU+226J+wS02Z126Z?=
 =?us-ascii?Q?IKCK+2C2VGLUSb0N7/w9WRqU6KUzqX8v56pfhbfa8Ci/MevieqMk60ARPb9N?=
 =?us-ascii?Q?QyeWoFn698TYHOY3MpBVHWsRKRhcqws2CQJWUfFLFH2Jqk03XDvUPwXHP272?=
 =?us-ascii?Q?UL0ePlnU/9Jkx+OKVYiqnrUYquUkgqzOrCZvCtkbKp0aoZ5wxQYppluML7zP?=
 =?us-ascii?Q?gqkjIOOrdZl46HlOUVUSVRtJeKgb3CvVMqVrYVBmnGat/k1CsAzxv4Z9pjWe?=
 =?us-ascii?Q?67XkaDWVG2fee3VZKQ03VPGXvFPb04HbQxcT74q+rMfrIQHmu3U8uCz33VaA?=
 =?us-ascii?Q?VCjlMvna+gy4cve2G5V8Zc67yVxMlRVhKt6coDH3HtAC+VnuCNTepekZmKxl?=
 =?us-ascii?Q?rfdb0/5f33OMzOzHAoOfE9wAE05KqVMKq9XIB/L/aJyGBc4HKdmWO+TV5b6P?=
 =?us-ascii?Q?um6MWvLxHtdil5e7iMIyX9TyADQthJobjXEp1S+1zHsq5BFEGEJX5i4Zw1eD?=
 =?us-ascii?Q?u7SX32VIq1XvRZ/Hj84ZR99gPKjxqRxLUODD8rIwqbt7BSgDQxbEbwrr8tL1?=
 =?us-ascii?Q?KCMHxJyAAQmDB2N7pRmWpxfYQekVgScuIIvTPlW6GPniaM71l0RcgkdFsLCV?=
 =?us-ascii?Q?1dkmCr7VSAg88GLCJZPlxNFpXbP1h3lAMK013u68PPRnV47G8a2ZSXEpoamc?=
 =?us-ascii?Q?0roWVe6mTq/rW/+yvGR1Bk/bU7clRiHgBBgXOqqbxW33kfgQFKWlbsPBlOlI?=
 =?us-ascii?Q?jrE77VXToZDMNP5ghWpAEnrZcyLJZjmkshrmCf0uoBYozFk2zqny33Ci/gNP?=
 =?us-ascii?Q?Id82fYtnbQOtPLm+/JqT6GHFc/2Lti+XwIZcgQ/kNsndoip292iR0JMNvUvH?=
 =?us-ascii?Q?Nuymn9EaboAQpVEgf1plTYLm8xWxa5Ri3+XTGMb4qtBm0Sp1qjSzmbU/BeWg?=
 =?us-ascii?Q?pmeJx0+ld56pj9O0g12mCQv6XCsdaN8QHPWchE2gkpoLFerKXOZlBjWc6tx6?=
 =?us-ascii?Q?MG4eRbqaSEASNCQY0TJcm7ZQfBiUrYTtLohOgWXhNSE19iJ+wIyeyaBeBKQV?=
 =?us-ascii?Q?fpMX3AqyWNy8jb3gc1kzFYf74EtEhn6yUqox3aQAIgUDmlTEOBo7PRtF/taz?=
 =?us-ascii?Q?Hxl5dqIy+uQyu+m29qspoylR+Ucboibp+lwmDW90D7SI+UlKpZQAUApHroUE?=
 =?us-ascii?Q?prW5tWCJxOWeTflC9xf5fmvrIEyl+AFfnM7RCcTZlpBplnHWk/AfIS8I0I9u?=
 =?us-ascii?Q?+ysHYYofhwMK6l6RlE7M8w8juDayaBbW953eGJKpoOcal2ZP/2RlaXdyUakX?=
 =?us-ascii?Q?L1vzBf5IJOjS6nAaFL7o7dgzY0oaKZcXMXVdcGdkCyNBt2oY7mS0KQTvr1um?=
 =?us-ascii?Q?5JRja7WHda0dJg3aZIEI9lb5w14kf5n8cxLHm3jSihpZc/HXxIOxTMvMHmBH?=
 =?us-ascii?Q?rhOCINmxFwc51EOtknT5Zu+0KNrAsavZ94zefGq8/xSVJGDjYYk4trX3Gab6?=
 =?us-ascii?Q?8MdFxEjlZB0qRu9fo731u4sVznc9CET0Gelg6pRo/DSvv9LikEjPEz4et3G7?=
 =?us-ascii?Q?Ba3aTDNjtrHSlsueDS/EUyf2uqmQfO5X3w+UaH7YDa2bJCes1XQ8BCZCg1+V?=
 =?us-ascii?Q?6qd6XNHNm2+Xg+a7lYRbPE4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F87F99F9DDF98A49AC2B882AB9013AB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzZxmeBUVbp3T37/fiEOcC+XoPRnntm7rBj0YI7aivuEwjxIJqYiBtmc797LXXMHGeDq13PgHrZVl+1q/MboH7YAz88Hbtt/juya4v0FP+5Qk4OwyMJRsuNUzJliB3Iy345aJFO9hDLd7QiU6ZDWFFgfVeIA/1ZRxejyZXy+9kuyO8EaTSeJvmrMQIssq6SarU8lOz9wHvxb0ohR2limm937s41mJUwacB5hrl7yMtx3mf8dLO2NwLQA98e/OkOJMmHsWB2/qA9oaTaDdpoA0jLFVZ45igSISvhlnw3OusuRz5oAujTVbj1paGNEjXKNAZQ9BtZXJy6DltSXPdUfMo30Qiv/ruSnDWwM/pKnotRoX8hQR7+BjY1RFiYASKZCXgHDd1L39jSyDXfRSRuJqadTWyEjP+VZwyabOHL114QA9HeZIxthbbAqNDhSkUq2fuhRyzTFeLp7HVk8OecRG3aQad7KtlvEociVg8lVt96Rq+hV+b8VA/R8KWJexpGfsfwT+JGiqQlArrOhUu8sP0mXMH5DRFSqceSgHmVHqPUsYbt/c0DuadQRuxKzLqvREWvzOI5mGiwrApesKr/z8FsG0W/I8XaYzxGTvEdxGnihL/YA7XoBoE6E0vJJGvrY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc1ec90-96c8-4df1-1e76-08dd496d2d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 00:52:21.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEI7MU9znlc0quwuwBQDF0bcGvjgQZ9NvWoJoPyWPc48cLBArh5ceBL44K2GiUuFn2rkE5lWL5p0ewlc0V60PtO5lzXCFy20phYucEypTv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8434

On Feb 09, 2025 / 20:20, Ming Lei wrote:
> All block internal state for dealing adding/removing debugfs entries
> have been removed, and debugfs can sync everything for us in fs level,
> so don't grab q->debugfs_mutex for adding/removing block internal debugfs
> entries.
>=20
> Now q->debugfs_mutex is only used for blktrace, meantime move creating
> queue debugfs dir code out of q->sysfs_lock. Both the two locks are
> connected with queue freeze IO lock.  Then queue freeze IO lock chain
> with debugfs lock is cut.
>=20
> The following lockdep report can be fixed:
>=20
> https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q3e=
mo4gwuolgzdt6@brotly74p6bs/
>=20
> Follows contexts which adds/removes debugfs entries:
>=20
> - update nr_hw_queues
>=20
> - add/remove disks
>=20
> - elevator switch
>=20
> - blktrace
>=20
> blktrace only adds entries under disk top directory, so we can ignore it,
> because it can only work iff disk is added. Also nothing overlapped with
> the other two contex, blktrace context is fine.
>=20
> Elevator switch is only allowed after disk is added, so there isn't race
> with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
> previous elevator, so no race between these two. Elevator switch context
> is fine.
>=20
> So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
> adding/removing hctx entries, there might be race with add/remove disk,
> which is just fine in reality:
>=20
> - blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
> won't be added/removed at the same time
>=20
> - even though there is race between the two contexts, it is just fine,
> since hctx won't be freed until queue is dead
>=20
> - we never see reports in this area without holding debugfs in
> blk_mq_update_nr_hw_queues()
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Ming, thank you for this quick action. I applied this series on top of
v6.14-rc1 kernel and ran the block/002 test case. Unfortunately, still if f=
ails
occasionally with the lockdep "WARNING: possible circular locking dependenc=
y
detected" below. Now debugfs_mutex is not reported as one of the dependent
locks, then I think this fix is working as expected. Instead, eq->sysfs_loc=
k
creates similar dependency. My mere guess is that this patch avoids one
dependency, but still another dependency is left.


[  115.085704] [   T1023] run blktests block/002 at 2025-02-10 09:22:22
[  115.383653] [   T1054] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
[  115.641933] [   T1055] scsi_debug:sdebug_driver_probe: scsi_debug: trim =
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[  115.642961] [   T1055] scsi host9: scsi_debug: version 0191 [20210520]
                            dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1,=
 statistics=3D0
[  115.646207] [   T1055] scsi 9:0:0:0: Direct-Access     Linux    scsi_deb=
ug       0191 PQ: 0 ANSI: 7
[  115.648225] [      C0] scsi 9:0:0:0: Power-on or device reset occurred
[  115.654243] [   T1055] sd 9:0:0:0: Attached scsi generic sg3 type 0
[  115.656248] [    T100] sd 9:0:0:0: [sdd] 16384 512-byte logical blocks: =
(8.39 MB/8.00 MiB)
[  115.658403] [    T100] sd 9:0:0:0: [sdd] Write Protect is off
[  115.659125] [    T100] sd 9:0:0:0: [sdd] Mode Sense: 73 00 10 08
[  115.661621] [    T100] sd 9:0:0:0: [sdd] Write cache: enabled, read cach=
e: enabled, supports DPO and FUA
[  115.669276] [    T100] sd 9:0:0:0: [sdd] permanent stream count =3D 5
[  115.673375] [    T100] sd 9:0:0:0: [sdd] Preferred minimum I/O size 512 =
bytes
[  115.673974] [    T100] sd 9:0:0:0: [sdd] Optimal transfer size 524288 by=
tes
[  115.710112] [    T100] sd 9:0:0:0: [sdd] Attached SCSI disk

[  116.464802] [   T1079] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  116.465540] [   T1079] WARNING: possible circular locking dependency det=
ected
[  116.466107] [   T1079] 6.14.0-rc1+ #253 Not tainted
[  116.466581] [   T1079] -------------------------------------------------=
-----
[  116.467141] [   T1079] blktrace/1079 is trying to acquire lock:
[  116.467708] [   T1079] ffff88810539d1e0 (&mm->mmap_lock){++++}-{4:4}, at=
: __might_fault+0x99/0x120
[  116.468439] [   T1079]=20
                          but task is already holding lock:
[  116.469052] [   T1079] ffff88810a5fd758 (&sb->s_type->i_mutex_key#3){+++=
+}-{4:4}, at: relay_file_read+0xa3/0x8a0
[  116.469901] [   T1079]=20
                          which lock already depends on the new lock.

[  116.470762] [   T1079]=20
                          the existing dependency chain (in reverse order) =
is:
[  116.473187] [   T1079]=20
                          -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
[  116.475670] [   T1079]        down_read+0x9b/0x470
[  116.477001] [   T1079]        lookup_one_unlocked+0xe9/0x120
[  116.478333] [   T1079]        lookup_positive_unlocked+0x1d/0x90
[  116.479648] [   T1079]        debugfs_lookup+0x47/0xa0
[  116.480833] [   T1079]        blk_mq_debugfs_unregister_sched_hctx+0x23/=
0x50
[  116.482215] [   T1079]        blk_mq_exit_sched+0xb6/0x2b0
[  116.483466] [   T1079]        elevator_switch+0x12a/0x4b0
[  116.484676] [   T1079]        elv_iosched_store+0x29f/0x380
[  116.485841] [   T1079]        queue_attr_store+0x313/0x480
[  116.487078] [   T1079]        kernfs_fop_write_iter+0x39e/0x5a0
[  116.488358] [   T1079]        vfs_write+0x5f9/0xe90
[  116.489460] [   T1079]        ksys_write+0xf6/0x1c0
[  116.490582] [   T1079]        do_syscall_64+0x93/0x180
[  116.491694] [   T1079]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  116.492996] [   T1079]=20
                          -> #4 (&eq->sysfs_lock){+.+.}-{4:4}:
[  116.495135] [   T1079]        __mutex_lock+0x1aa/0x1360
[  116.496363] [   T1079]        elevator_switch+0x11f/0x4b0
[  116.497499] [   T1079]        elv_iosched_store+0x29f/0x380
[  116.498660] [   T1079]        queue_attr_store+0x313/0x480
[  116.499752] [   T1079]        kernfs_fop_write_iter+0x39e/0x5a0
[  116.500884] [   T1079]        vfs_write+0x5f9/0xe90
[  116.501964] [   T1079]        ksys_write+0xf6/0x1c0
[  116.503056] [   T1079]        do_syscall_64+0x93/0x180
[  116.504194] [   T1079]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  116.505356] [   T1079]=20
                          -> #3 (&q->q_usage_counter(io)#2){++++}-{0:0}:
[  116.507272] [   T1079]        blk_mq_submit_bio+0x19b8/0x2070
[  116.508341] [   T1079]        __submit_bio+0x36b/0x6d0
[  116.509351] [   T1079]        submit_bio_noacct_nocheck+0x542/0xca0
[  116.510447] [   T1079]        iomap_readahead+0x4c4/0x7e0
[  116.511485] [   T1079]        read_pages+0x198/0xaf0
[  116.512468] [   T1079]        page_cache_ra_order+0x4d3/0xb50
[  116.513497] [   T1079]        filemap_get_pages+0x2c7/0x1850
[  116.514511] [   T1079]        filemap_read+0x31d/0xc30
[  116.515492] [   T1079]        xfs_file_buffered_read+0x1e9/0x2a0 [xfs]
[  116.517374] [   T1079]        xfs_file_read_iter+0x25f/0x4a0 [xfs]
[  116.519428] [   T1079]        vfs_read+0x6bc/0xa20
[  116.520904] [   T1079]        ksys_read+0xf6/0x1c0
[  116.522378] [   T1079]        do_syscall_64+0x93/0x180
[  116.523840] [   T1079]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  116.525467] [   T1079]=20
                          -> #2 (mapping.invalidate_lock#2){++++}-{4:4}:
[  116.528191] [   T1079]        down_read+0x9b/0x470
[  116.529609] [   T1079]        filemap_fault+0x231/0x2ac0
[  116.531033] [   T1079]        __do_fault+0xf4/0x5d0
[  116.532461] [   T1079]        do_fault+0x965/0x11d0
[  116.533859] [   T1079]        __handle_mm_fault+0x1060/0x1f40
[  116.535343] [   T1079]        handle_mm_fault+0x21a/0x6b0
[  116.536915] [   T1079]        do_user_addr_fault+0x322/0xaa0
[  116.538409] [   T1079]        exc_page_fault+0x7a/0x110
[  116.539811] [   T1079]        asm_exc_page_fault+0x22/0x30
[  116.541247] [   T1079]=20
                          -> #1 (&vma->vm_lock->lock){++++}-{4:4}:
[  116.543820] [   T1079]        down_write+0x8d/0x200
[  116.545202] [   T1079]        vma_link+0x1ff/0x590
[  116.546588] [   T1079]        insert_vm_struct+0x15a/0x340
[  116.548000] [   T1079]        alloc_bprm+0x626/0xbf0
[  116.549396] [   T1079]        kernel_execve+0x85/0x2f0
[  116.550784] [   T1079]        call_usermodehelper_exec_async+0x21b/0x430
[  116.552352] [   T1079]        ret_from_fork+0x30/0x70
[  116.553751] [   T1079]        ret_from_fork_asm+0x1a/0x30
[  116.555164] [   T1079]=20
                          -> #0 (&mm->mmap_lock){++++}-{4:4}:
[  116.557848] [   T1079]        __lock_acquire+0x2f52/0x5ea0
[  116.559293] [   T1079]        lock_acquire+0x1b1/0x540
[  116.560678] [   T1079]        __might_fault+0xb9/0x120
[  116.562051] [   T1079]        _copy_to_user+0x1e/0x80
[  116.563446] [   T1079]        relay_file_read+0x149/0x8a0
[  116.564851] [   T1079]        full_proxy_read+0x110/0x1d0
[  116.566262] [   T1079]        vfs_read+0x1bb/0xa20
[  116.567591] [   T1079]        ksys_read+0xf6/0x1c0
[  116.568909] [   T1079]        do_syscall_64+0x93/0x180
[  116.570283] [   T1079]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  116.571781] [   T1079]=20
                          other info that might help us debug this:

[  116.575369] [   T1079] Chain exists of:
                            &mm->mmap_lock --> &eq->sysfs_lock --> &sb->s_t=
ype->i_mutex_key#3

[  116.579323] [   T1079]  Possible unsafe locking scenario:

[  116.580961] [   T1079]        CPU0                    CPU1
[  116.581866] [   T1079]        ----                    ----
[  116.582737] [   T1079]   lock(&sb->s_type->i_mutex_key#3);
[  116.583611] [   T1079]                                lock(&eq->sysfs_lo=
ck);
[  116.584596] [   T1079]                                lock(&sb->s_type->=
i_mutex_key#3);
[  116.585646] [   T1079]   rlock(&mm->mmap_lock);
[  116.586453] [   T1079]=20
                           *** DEADLOCK ***

[  116.588484] [   T1079] 2 locks held by blktrace/1079:
[  116.589318] [   T1079]  #0: ffff888101390af8 (&f->f_pos_lock){+.+.}-{4:4=
}, at: fdget_pos+0x233/0x2f0
[  116.590461] [   T1079]  #1: ffff88810a5fd758 (&sb->s_type->i_mutex_key#3=
){++++}-{4:4}, at: relay_file_read+0xa3/0x8a0
[  116.591720] [   T1079]=20
                          stack backtrace:
[  116.593166] [   T1079] CPU: 0 UID: 0 PID: 1079 Comm: blktrace Not tainte=
d 6.14.0-rc1+ #253
[  116.593169] [   T1079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[  116.593172] [   T1079] Call Trace:
[  116.593176] [   T1079]  <TASK>
[  116.593178] [   T1079]  dump_stack_lvl+0x6a/0x90
[  116.593186] [   T1079]  print_circular_bug.cold+0x1e0/0x274
[  116.593191] [   T1079]  check_noncircular+0x306/0x3f0
[  116.593195] [   T1079]  ? __pfx_check_noncircular+0x10/0x10
[  116.593200] [   T1079]  ? lockdep_lock+0xca/0x1c0
[  116.593202] [   T1079]  ? __pfx_lockdep_lock+0x10/0x10
[  116.593206] [   T1079]  __lock_acquire+0x2f52/0x5ea0
[  116.593211] [   T1079]  ? lockdep_unlock+0xf1/0x250
[  116.593213] [   T1079]  ? __pfx___lock_acquire+0x10/0x10
[  116.593216] [   T1079]  ? lock_acquire+0x1b1/0x540
[  116.593220] [   T1079]  lock_acquire+0x1b1/0x540
[  116.593222] [   T1079]  ? __might_fault+0x99/0x120
[  116.593226] [   T1079]  ? __pfx_lock_acquire+0x10/0x10
[  116.593228] [   T1079]  ? lock_is_held_type+0xd5/0x130
[  116.593234] [   T1079]  ? __pfx___might_resched+0x10/0x10
[  116.593239] [   T1079]  ? _raw_spin_unlock+0x29/0x50
[  116.593243] [   T1079]  ? __might_fault+0x99/0x120
[  116.593245] [   T1079]  __might_fault+0xb9/0x120
[  116.593247] [   T1079]  ? __might_fault+0x99/0x120
[  116.593249] [   T1079]  ? __check_object_size+0x3f3/0x540
[  116.593253] [   T1079]  _copy_to_user+0x1e/0x80
[  116.593256] [   T1079]  relay_file_read+0x149/0x8a0
[  116.593261] [   T1079]  ? selinux_file_permission+0x36d/0x420
[  116.593270] [   T1079]  full_proxy_read+0x110/0x1d0
[  116.593272] [   T1079]  ? rw_verify_area+0x2f7/0x520
[  116.593275] [   T1079]  vfs_read+0x1bb/0xa20
[  116.593278] [   T1079]  ? __pfx___mutex_lock+0x10/0x10
[  116.593280] [   T1079]  ? __pfx_lock_release+0x10/0x10
[  116.593283] [   T1079]  ? lock_release+0x45b/0x7a0
[  116.593285] [   T1079]  ? __pfx_vfs_read+0x10/0x10
[  116.593289] [   T1079]  ? __fget_files+0x1ae/0x2e0
[  116.593294] [   T1079]  ksys_read+0xf6/0x1c0
[  116.593296] [   T1079]  ? __pfx_ksys_read+0x10/0x10
[  116.593300] [   T1079]  do_syscall_64+0x93/0x180
[  116.593303] [   T1079]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  116.593306] [   T1079]  ? do_syscall_64+0x9f/0x180
[  116.593308] [   T1079]  ? lockdep_hardirqs_on+0x78/0x100
[  116.593310] [   T1079]  ? do_syscall_64+0x9f/0x180
[  116.593313] [   T1079]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  116.593317] [   T1079]  ? __fget_files+0x1ae/0x2e0
[  116.593321] [   T1079]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  116.593324] [   T1079]  ? do_syscall_64+0x9f/0x180
[  116.593326] [   T1079]  ? lockdep_hardirqs_on+0x78/0x100
[  116.593328] [   T1079]  ? do_syscall_64+0x9f/0x180
[  116.593331] [   T1079]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  116.593334] [   T1079] RIP: 0033:0x7f9586b50e4a
[  116.593338] [   T1079] Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 7=
5 f0 89 7d f8 e8 28 58 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c=
0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 82 58 f8 ff 48 8b
[  116.593341] [   T1079] RSP: 002b:00007f9586a3ed80 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000000
[  116.593348] [   T1079] RAX: ffffffffffffffda RBX: 00007f9580000bb0 RCX: =
00007f9586b50e4a
[  116.593349] [   T1079] RDX: 0000000000080000 RSI: 00007f9584800000 RDI: =
0000000000000004
[  116.593351] [   T1079] RBP: 00007f9586a3eda0 R08: 0000000000000000 R09: =
0000000000000000
[  116.593352] [   T1079] R10: 0000000000000001 R11: 0000000000000246 R12: =
0000000000000000
[  116.593353] [   T1079] R13: 000056218e3f97e0 R14: 0000000000000000 R15: =
00007f9580002c90
[  116.593359] [   T1079]  </TASK>
[  116.687238] [   T1023] sd 9:0:0:0: [sdd] Synchronizing SCSI cache=
