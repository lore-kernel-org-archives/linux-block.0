Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A762D739C
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512362; cv=fail; b=Z0ZiuKoS6+4lP4bDLd570UfoD6itYKr6tNBQwMBOp5uv8ezI+7O7j5vzwOcR9a0B+DsFO6Tq/sGmsw0Iacl4NZpYDNBdjWug4waVqLyLVkAZaWcUrOdbr5FJDghpCVO+XtpsABhcczP0Ppk1FBy2qk1PqTOM2bhYKqvtFBSRJ3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512362; c=relaxed/simple;
	bh=3oxXlj6gk7jRugLhK90EsMLYAmO6CTLQdPJtuIrhvxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vETQgmjhrPtxv7CrEhf/v8q1d9uCNMxEpYp2ZsmmXTARCHeuHAmCRH/f2nJM5oFvj9Xm9Uq5CoMbo0+FzJlvDGaB8G2KsWsJyAzhPq/iJ1iVTKm7kBXX5yePXy4jR1/CNHB06Bgz38aCN3poYcz8RpW4J7aMopV98GRA8lZ07Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kWoOQmcN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V7bnLiok; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kWoOQmcN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V7bnLiok"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774512358; x=1806048358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3oxXlj6gk7jRugLhK90EsMLYAmO6CTLQdPJtuIrhvxY=;
  b=kWoOQmcNMyKFrCBZSJziHI+mx9o6hDYaoDpLpW+MBMxM2ROLUrgmhlQr
   GUbRnPHWFh2DF7EcD0Y77GAsSCrL4lXEVGd2bCvF8vZwmBX8G0HxczICz
   oZvvj8lyILZvJuEnJSCXKKG1CMNbgr2ZomjUC23JJrWyqNxCkhkyEgxYc
   sCU5xy55K2rkcvxgFFTOS6Ouzv+pDGd1CPbLrE2btLL9DgwXaI0C3bcyV
   H8qvCCiRbaOxZIrkaIFeW1OZ3q5NbBAZUAHd1bvWPPTMQ7nnFu4upqUqi
   BFkJ7/9CvsMxTiEeGn6WLk1Z9HZSxDUp/1Z+GWFMpUvHgaRWvk9/jhWc9
   A==;
X-CSE-ConnectionGUID: F8YFm/gKTy6Sag/EabE6Bw==
X-CSE-MsgGUID: b9Mr0+HoTUOcrvRDJVMQqA==
X-IronPort-AV: E=Sophos;i="6.23,141,1770566400"; 
   d="scan'208";a="143772638"
Received: from mail-westus3azon11010029.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2026 16:05:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJB7UgAELZD+yc+HHT5HMel5NPCNKkF4zz4WY7bT2KvjjLtZniI7Q8vjI/VB3SZxN5/WwL9/GluO64scJClmn9dfyZxNHuLJrdg1KzPhmilT6br1kImCdJo4DFplhVY03Byu0oQA2K7drbDTtqKq6GHDsR+frgPzlpEoS708YdyhpdwbnC9nro8Fpq0BoJ8CaFi+ccSYWaBrWaqCHlyU+xBnAKWDinX1f9oe1L4sPirXxX6PV+sBMblj9m1fiXOvyFudE6hI6GoPAzStTpxReICIzuEqCPMhLJ5hAuhTvj9RbQz60BFa6G/UJyQe/wRW2Etzu04Bgtr6tMEU6x1O3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oxXlj6gk7jRugLhK90EsMLYAmO6CTLQdPJtuIrhvxY=;
 b=Uxx2u1ig3tLYxLIfzR0nw9DHeq7p6bpJ6tpOZ/JIOhyrcGYG5yfF9/bmh5e/l5cs2+RmgYuAh9dzKczV+wPu6eIRYPD2qi9bRae6Egt8rID7HxYkR+JPW/WDJGAIENLLl9K/4xwFvWUl2oESb+uP7HPfoKb/FC6hBwKhy6sIHXX+Edxbr0J2WH7h3fkRKSNn4jAHKQAAEkNOj6jB4qTJwTnmNAraRKqUhloUVq6yZHKuJroQ1Tj+mry9Su6rrIq1S09+XW25Lr6qHxlfCzehlksJ6IhvShGEGGKu5Y5AuURhYPbCi1xzX/rcaLQabsgObKyREdlFWkhArEGFwQr2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oxXlj6gk7jRugLhK90EsMLYAmO6CTLQdPJtuIrhvxY=;
 b=V7bnLioke1so3ImwH/OuEtLz/mniDGqvaN2JWVwVOW/+DfFTvpcapjZ72/kwwvYlsOVlW6XauLflISxb7ju6ZwBnYWzEzmmHUmCz+ehEKrl5BneAdydhqBVHXhNft4w9UqW+5v0jduz0BpnLgpReZNGXLymx/hrjx9qF6SOYjK0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB6279.namprd04.prod.outlook.com (2603:10b6:a03:1f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:05:57 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9745.020; Thu, 26 Mar 2026
 08:05:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block/044, scsi/012: Add tests for support for segments
 smaller than the page size
Thread-Topic: [PATCH] block/044, scsi/012: Add tests for support for segments
 smaller than the page size
Thread-Index: AQHcuwDB3Fan/XQyokC3oXPdsGqiKLW/JZIAgAFTKwA=
Date: Thu, 26 Mar 2026 08:05:56 +0000
Message-ID: <acTocO4Bm-eAo1Ag@shinmob>
References: <20260323200751.1238583-1-bvanassche@acm.org>
 <acPFQ3laJg0MDRSM@shinmob>
In-Reply-To: <acPFQ3laJg0MDRSM@shinmob>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB6279:EE_
x-ms-office365-filtering-correlation-id: c7616767-c1a8-48da-867e-08de8b0e82a6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 OgisrC4/sPqwJW2qvde4+egf5B9IzOaS9A5tm+YX3orLlYeedhoJV3B9SHlPkUr8xsYmUQ34dEfSaCybtgT6CYZN9xKG5uQs8cxiBxEgBgqabzlV1F96Y5IHnvjGzCt345O1hd0OoXUIuhp9kaVpH537Q/Cp+VodW8buSE5yKp74V/uWMEy98awG1NplWySCV4JjTrAp/mdt72yQmHivSS9e2uOKqLJEVplXPfdPcxTGt48Ghql4JcdKcomTviLjSBL4Nwjn9948LpOXcumrtie77IFsk8csal1A8U8Le1cA5GG39qwPluhzMz88qlKHguQmCqYhXfx284PQFK8u/pu9VdVgBJEd7JUOnt4ggxfuGS7TgmReMbngvC1Ne2Y+n14gf/vZEdonaEmypQmVbcoQY3OY7kNFX0qoaqyfDnGCy5skWKFnY7JD1TXZszgOq3DSB6Jz4L0eLRP8Zz1nb8uXeTaXG0ykQbkNdXcARxF4weN9W0PPl+UQvAR8Bdgg04OXxY4djma1olk1yMZNc5l8tZP94r50PnuwWltPczgCYkYuyB1YWyhPUiq3okAHuShQWkx2EYFnEPyYuoPjo2lPZmGrN/cdslT1J/bbF1neKHO63a8rCWem4LWrLUa7sMOrr7h0Rz9iy+Qi8mMdUjc8/YieRXOrDMVaN5jN2x7VYt9NJGRGqekGEB41nACL/kULJasCbKAnwhiPCTK2+tUDYDOP5HXAymmFNW+/ta1QlRf54pC6TGYD2Iu4Lj7kP0WOHim1jpfwUnOoyFfQovexImL0o5p4s7l3U6wqihE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WV7aPrwWC8wEH2D/rbHlNh5Y2NNxZMggQX06bQzBlewoVzDs8AV7S0V2yVL0?=
 =?us-ascii?Q?IToqULns0TPdkyeKRlnQc3GyAWv5yD7bWubuLlcmr6ghoxKSz/7d8q9G48ZE?=
 =?us-ascii?Q?zXrf7azKe9OdMCqoeVRcrSJ2H6fib2pprBOIfw4xvVkohxmEAsZvqXq+CppD?=
 =?us-ascii?Q?/VWaV9Ep4cKeDqskH8O+4KfNAtgYJLTFzYCoVnl8UsE2HNOwdWY9tgDvBWnt?=
 =?us-ascii?Q?x//3nGRspsxRaLDozY7ODmQPKSesZ2BApa0EHi776O06FVfWr08JXqezg6U2?=
 =?us-ascii?Q?kHY2g5UHVqj6ns5J7ExLz5AaTaRlkXsmBNe4j4d9oKn8JTsoUVtzuOHbkmkl?=
 =?us-ascii?Q?Yz/vC/v8Hxs5QenpVvf1EoQvFAY7omp7BqdBgl7tdIinpIKUWSd3qUtagWkB?=
 =?us-ascii?Q?zyD3V2g9XjlWonXVvh/CXWCY36Zw89Cqht5AeuaNIJeYD5h9HeJLhCg+3heb?=
 =?us-ascii?Q?V9bVQd0Rgmk8uLYk7BxamRrudLGHrgB6BUqYl//dhmctHrNO/m1HpA3M+JaJ?=
 =?us-ascii?Q?wBo4zGgUvGZktzIzvXRyH0j4V56aavhH3EfTiK0nzTKNFMDWQl06RqqX9ybg?=
 =?us-ascii?Q?DC5k7jIHc7pXRpywqqUC/0tE+Zs1S9LdzPcOTH9UiMppzqa37xGMfAA5q/f/?=
 =?us-ascii?Q?rNN32ECelrIjtCootYqj6yqNHGDuCSmOm9R+p9Lih1UNJXq7SQb4N5WXiucv?=
 =?us-ascii?Q?j1pvr+Tx/CzEK8LOInxaBbU2h2a9EC7Cn281oShsxliPKKrzCwiYqRrfppxu?=
 =?us-ascii?Q?Wbj8LjaFooDtzVXNjL6drcUXB4wJuNeXi3APLPIYvmeoDrbFN3j/nJe//qTP?=
 =?us-ascii?Q?1IJ/xYjznOGlmrlWAq6xDhjGhVj9o78oaE65QeMtca5xcJh+EXUB0FKQycJK?=
 =?us-ascii?Q?hpIdnzt1JgpR+qcBrhwPgYN/HomEKXcOQ0OTYv7LCYUfaU7CGBUIfEcFwvZN?=
 =?us-ascii?Q?E9ZZWMpujR1OKzfY5Anke7w9GpKZvbyu77nId3EDQsDzXN4iUx6SEBTpnsa9?=
 =?us-ascii?Q?ksfzOr1HKu+PPq8QuDjS86c74YxXcNbKASAPz4ygu5cyA23sh2zoTb0CmG5y?=
 =?us-ascii?Q?f4AuIylWPIqtG0xunG/DWr0nTEHabErr41sZZ8RkbfFVVzXG7VDnnHOFcRFp?=
 =?us-ascii?Q?oWOlFf1+M3ZMuj5VY+ZWKJGI9WYtG4C7PYzj/9Gih4WayJ2NbwtBi2nVRhjf?=
 =?us-ascii?Q?muMUeEudbehRPGN6wXXiDtxxoBldajwGKsB+27HHU3MKxw+kMvkTBTJXKndm?=
 =?us-ascii?Q?r3rat3Kjx1/CeGHR8VEbHLtE4q4D7LiFDTpdYIyexwlrm0SRyPE11SjJi8NA?=
 =?us-ascii?Q?mjHsK6pjtzp+aSeXCP6PqVh9Ys1htVGL9zejffAvCyhxdjRqS7w0bMtoCeIu?=
 =?us-ascii?Q?0WPljlrLUeGLovalf7PzOcUm+75v60vmXN7RhSMeXuL3xNBuY7IWHgzrb5iJ?=
 =?us-ascii?Q?eYsb7g4b4dxEW/jvfmtURQCqWTvDYm8T9qer/XSO+G1Gg7NF55OkluFQufhb?=
 =?us-ascii?Q?v4pW6/St9NjDZqxvj0q9sKsdcG6Y1xM1A+FFURtwjoudX9Zlxc4uitoFZQhD?=
 =?us-ascii?Q?1cSDEAcRnWjeK2O9MS90qmshvoTIPvoUimLGcSpIMP5ZE0QowngFHEohpbmq?=
 =?us-ascii?Q?FEpyELH30HJpEUhjym/zr+sgV1XTnN90xJDUyNKrd5MPm2ixqCQ+LSo7+FBN?=
 =?us-ascii?Q?8qmBWNVYEC8ZxgRV1WP8k690Y2dMARS8DEZV34Cp+/3WoMTPB66FmtpfT8do?=
 =?us-ascii?Q?FW0TNwTqgTvTLOYWcqYIZSPXwe8pVeU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E88F605E1FB4204CAD3C3F08651AB702@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lyZhO/Fod569n8RJK30ZOWe3YXS8EnPAh6jTsS3bCwkyBqpTjNpUbrZhWv2nZ2hXs0MSfh8Rkme5xmqnhTVSLvS08R8TpN5v/v7iRao81PWg8mQ6kQPsACCrLgD2WPVZ8nUXKKGhWZJ7e1ML73LkNSJNCGkRivIxETjsIbAlsowcfDnqUfsFfnyKTYy1bMhrWCVGNYNKtXs6cSxKRuhQkdoQjvF8nTsorT2Wjm4p3kXaTta1MLr+CQxo7VzK9HCV4WYVo0J+SdH2Tbr2BLqJbFaQW00VfQjEwPGFCPXdEPxQIwDA1TsMzrP6CaXVFlDOKsWmXCv8O8VjtnQU6SGZUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+PAPeoBdTwBZRbdUOXBL1u6ZlWqfrdZktasa0PBP79+zMiJyp1PAs19918m1vBYeIhNXmCKcsdYwHN4qvBGJd2lwWDFR/W2r/1SQ0/Ypt32IG3R3TXb+GXniAPMismxH7oq8CppRFJkvXHIR3WRTamrUe2e+ld/HfgZYWrgaf3SCbG6plJB+SI+mh1gbWCoZsO1Ffy4qNEnj0K/+jjHQ9uwUAKWIDbzb23gUe4EW5PVVWKgucrjox0uvqReEMc9yuVFolXr6QU6GvNwzV+cvjtmQmP7TCn+I5dBS+h5c4mvk6GeiUC0S7r9P29GsQPuThGtZWhG2Q/ZvAMVtUX2BxSecUdO6Erv3aEO5Xi3xYj+AGHMf9rRiUg2yBSX5ZEt4vcCThHI47ML7P7lVFBxC+jRr8q8NoOzJnU6vx4mYhyD42HbUxwzZvrsE10kmEn295Xl3MnS1gxd9GFvkM78YqK+lWTKtMGAwdeejUmuza7qeNtLJpW5dIKPw4hiKJWVlrjxRHwAA8IlyVxlubn9ZZNqCJrO2Zsv8+3Kj9s+1unpg8+RizRZlODpdyf4Bjhs6sZ9lo7CMuyIltzB7XZ3vmCF9qFBtEcXjkfvkty+V7cF/c0IRLXEOSHY7FT2UrfzV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7616767-c1a8-48da-867e-08de8b0e82a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 08:05:57.0768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMW+oFZ3zbuOYXiEzFdCL1QE0oFlS5Pw+IRj7YkzlJtzmWPWkjSqtlhltCxOPWu+tKuvGd8GOGSJhLf54ozWriA2gPUObzFFlas6pKR/YKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6279

On Mar 25, 2026 / 20:52, Shin'ichiro Kawasaki wrote:
> On Mar 23, 2026 / 13:07, Bart Van Assche wrote:
> > Linux kernel commit 889c57066cee ("block: make segment size limit worka=
ble
> > for > 4K PAGE_SIZE") was merged about one year ago and adds support for
> > DMA segments that are smaller than the virtual memory page size. This i=
s
> > important for devices that do not support DMA segments larger. This pat=
ch
> > tests the code paths added by that Linux kernel commit.
> >=20
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>=20
> Hi Bart, thanks for the patch. Please find my comments in line.
>=20
> I think it's fine to keep the two new testcases in this single patch, but=
 if
> the kernel side patches go into upstream in different timings, it would b=
e the
> better to separate this patch into two patches for each testcase.

Today, I reran the new testcases and noticed they leave fio verify state fi=
les
in the current directory. It would be the better to add --verify_state_save=
=3D0
option, or use _run_fio_verify_io() helper function in common/fio.=
