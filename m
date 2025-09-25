Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396821ADA7
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789600; cv=fail; b=X+OQJJknXH0sR3ZBH4L07YgylrTHE2F61/Lo8s8z3rFt7D2FOsCVG1+VFUBo/F17rwEVQji4qeMGeEa8vO9YVtJFso5G7P03RKs9/zGLCXgpmkI+Gc6E00au9Eu2/3AN9wUvbyebs301FSMBT54jFYVsQhLTiszr9Q+1wTctkSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789600; c=relaxed/simple;
	bh=AtXl2LUHwEnf8QH5dt+0jOzOFFqDDwiiFV/nq2AN5Gg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n3fCsaDSy0FIg4I/k11K2CaY1omF4A3KrXE7g+pWGPENgwvJ4kdJBk877vxID4wMC9mPd+4VQ3GpyXygshq9xawEuPNVS1gARm8eN+24cFtISz/F7z2y2HMDvIStGe8s5mq9ruUU2+/CsTXBbdeB9ZFAq3rZHELwqTTgppV16Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l9DpFBLT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VyghmH20; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l9DpFBLT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VyghmH20"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758789598; x=1790325598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AtXl2LUHwEnf8QH5dt+0jOzOFFqDDwiiFV/nq2AN5Gg=;
  b=l9DpFBLTGu0fNRIDHOaq6FiUiHpJ83hrlPkY3IhqVSL84eQrsK0pLSKy
   G6CWkwujWni8JGLK2ffyKjXQAOCvRyZgGxYnKLuO0CgA16dLMjfV5msgy
   VZQ0AsWUHzi7pUuVaP/+O65h3CVEHBFgierFmrK4vl+CzbnQnlS+44CA9
   FF1M12GH0vsV9p6+fHyaEEBibZYN3Vw9TCkZdBJpruDw4LBhKN1wVaj5o
   vsA+qzugr/RmkUg/9srSY68pxL2XmXK7iK0CmVn5jjR0lv37OXhG/PoIH
   HZAEvJZEZQ2qCUiUXpuxjBoN216CpK0hCSQ1eacIK/jOpwtHQVio4Oj/p
   Q==;
X-CSE-ConnectionGUID: VApgWcO+TYeXWOWlf/KZ/g==
X-CSE-MsgGUID: c5fymciURuqHKkoRqr6d0w==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="129981211"
Received: from mail-eastusazon11012058.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.58])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 16:39:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J83beC8TnopdpDU/v8dky1770WTy1BFVWUUodS2X0n+onyFTumnwNRWnYEEeXJfBR8uyUFn4wwKmrUB98LvSNIVBFCZEw73q2tOr6jEI4MHOzEIc7bVdOjsdrIA/5RGBFTDJx4guCQPSGE5r+3vrAEcoZLxIlOJiJZjvR9ihPt0pb5oNv2XpcThX43anfY4+UArc5ZlZthcWFUgSieJm6SkwsZPzhzohS9ibewehdn21HQjLA180h+Wft2Z3kX+niGEZnX4Ij52Wqc1+I+8Co19W79FQRnp1z/kjHFU7RUgXs5MxmTTPdR/KgYunHJaWGZ7pE2zKOWTVQEnumHuwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqZVq0pRWj9jdb5KrRx5p4Bd/BnEN82pr1RPFVj5Xf4=;
 b=vV5UMJAoPjzHzd+/F9/VH5lfi7qIFEYgEKmLgUshlzoiSocuHGUSjqj6l+z4c5jubSqvhhAUHdEPzKDd1HezsSNKayZ/oyJP/lfmp8qk68Buf2QOH1jGPZpK0bPz5doqRB6nKbRmiSVGT+nMsH6MguvBhwMh+eqmgZyRbWlpdU3C5m1HYKeftssq9DO36HcH4NyhdyJW9K35it7lhHsYvqF7NjubH5yLGcBXiDpD+E3zAbnG3PXFG/scC3v4Sbq0gUqmUie8WwTx18tOJpQ8wogBPzx4zMA1hXalxJQVwIJxan0fEFkig/IB5d4DAw1EDBsRU5GPSRT53KJD3J8e8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqZVq0pRWj9jdb5KrRx5p4Bd/BnEN82pr1RPFVj5Xf4=;
 b=VyghmH20O2F1zexu7B92snWQ53AdX4nLOexYVl6U2K3w9QYy4UkAVBY+o9cSLiohE8ff4OjXRnP0aR3YJ23I6XMSaU7uaDmeS82cd+4mt9ghydKXRz9fZwmTibvWbjGnhTmiye6uOo7eTh34BpqQLfq4ZrCD7ojNI8vqR3Bmd2I=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7851.namprd04.prod.outlook.com (2603:10b6:510:e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 08:39:55 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:39:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Topic: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Index: AQHcK6sug4CvHkcG+kqFWi7gggf3erSjmJmA
Date: Thu, 25 Sep 2025 08:39:55 +0000
Message-ID: <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <20250922102433.1586402-7-john.g.garry@oracle.com>
In-Reply-To: <20250922102433.1586402-7-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7851:EE_
x-ms-office365-filtering-correlation-id: 12fbcf56-30ac-4786-bc88-08ddfc0f1aac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cxb0UqJ6Qp6zfpSvjKCQcPAbm5SmxBVtUTu70AqZnPFMbTR84zzshaWq3f4q?=
 =?us-ascii?Q?ON5Ow76JYPmkZIYYQ8Mmv6k4O3De60eykir060oSTv57NI303O4XB5otjYtR?=
 =?us-ascii?Q?acP0q0m/8yBSF9UY/aYfTUBvQxCpn1uNGNLgHSn0tWjyBRyaWat2VS79HyvG?=
 =?us-ascii?Q?xXgrFokfqEBevaZNTjentGx67SQiHkvIryof1IlAx2votqGqUCPwXYr4yqVs?=
 =?us-ascii?Q?VGbhyTaUVOAmUDyrzFUrKldB6HPY5UsAIuINcsK3v3yTYC4bZD04L/Aj6gFc?=
 =?us-ascii?Q?qfyRRmYUTIwcv9JOdMZq/BQau/hMI4sb3h7ZKcuq42I6lJ70AtAkE6rnzyne?=
 =?us-ascii?Q?T40jFB1vLZoF4yZWR3Pe1hePdQQpw9ZvA8GwP+LR5SXa9BryH46XatMbqWgn?=
 =?us-ascii?Q?sNPyLqQLZxNBMFP/+bcaFMjsPSiiHfzInYNAYJ0z9XiJHO785gBxMV711iFn?=
 =?us-ascii?Q?ps51lkw4/PKZDq2pjibfKKhxLKKxZleQTs2IS1jm0UzYxlbJ7ReldBdhFpmi?=
 =?us-ascii?Q?h+wAw9WyqV5SaDOUaAtwE1jBGJ4RBjk2NK/32WLP5bESCjXU34sKWEUZZ6wb?=
 =?us-ascii?Q?6v3A6C9KX6/uKGwWU5walTDecOTG1lXeilVRvd33bMjO9ohsIhwkTpTqR5Rn?=
 =?us-ascii?Q?DuP8GxiZwjZHgA6tufNYLPo23azFEcdzCwFnwU4jr7kpGaqPBJ/GDfK9d0iA?=
 =?us-ascii?Q?Q/1qqGvZ5njIn9rMco2z/lnB8Lwk/FCFKy8Soweei0uUX/2CDtZXwwE4P7ik?=
 =?us-ascii?Q?pIk3TDGfTVuxA4LDeJ0wmTeEJ8NK3yrqhIIOBlEpgug3+40TmNtIiHmgeMyu?=
 =?us-ascii?Q?nJQqB0X1GOeacL970CIU3DVbSvGrSR4Gc3jrUiBF9/5SzbYs7wfzwPXy62h0?=
 =?us-ascii?Q?abUWkjYfur35DmGHwHYIbnQPSo6BgK286QIjQ9eyTrw6ewEV0C2v7ETPLMvN?=
 =?us-ascii?Q?ff7exSPWTElcYkhwMVCJytvhiJlmc9Hph0EdsHoEhSU1/NF5VimvgVeWL255?=
 =?us-ascii?Q?z+W49gXd0AZ70WkQ0+40kFfektiYPQfYNEL8tuKipUu6AIipAEp5LIaEkAPS?=
 =?us-ascii?Q?Krd9SmFKybthGWeTVpqASnKxJ1R87MRJlvQosw51kWnR5THaQDYT4cw2zrRA?=
 =?us-ascii?Q?XeqO5Vjsi6h734mspQ3C3LYih+rrdnK83VqpfxyDAGrg8cSTpbvkdwAgqcFK?=
 =?us-ascii?Q?xv2GIyVyWD1TwiXCWRTl/7vfWpgq2WIXkRcLH6R9uC6dbdFrnMQzjEu2I4N2?=
 =?us-ascii?Q?l8rZ/iCB1jsiJ/mfAmmEk3tpy8Qu9YYh2bfkMxyiXeXkjeXYrNlWKcwd2vx0?=
 =?us-ascii?Q?Ysvw1q7jzM385SLbqMVVmRKo0h/DWX71CsF06pz4wm1Ux+p1UQHLoxSRcrye?=
 =?us-ascii?Q?2IYTGw0Gr+lx5ccYoPemJBx/qPM/4URFZuJ/DIo/M+QH5dwsq43lWRZ4Z4Z5?=
 =?us-ascii?Q?NgnOFX7puP+nb2bdd5i6mKk8Lw8b4kiB6pmvfIDr8HW5zkN6mFOve4/iLceO?=
 =?us-ascii?Q?h31iR0nCbpH0XWw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XI7MhNcxiH+n+EzHS2g7GFsgWpSX3QMQPI5xhUDNLoZCwRxqp9aad5ECYiQu?=
 =?us-ascii?Q?rsftwrrRgvaH6obPWxtBE0+VUgZ6SJxdAam4Vj+isZiJyI7/yByZMspQptP0?=
 =?us-ascii?Q?I0IBaWdnrQD0S7GsHQmzzJAcBu4LsuKQ79CKbwc20j8FzlQTdEup2oFvrM6k?=
 =?us-ascii?Q?J+6gKQCjYYl+vOFNCZkR0Ju+130qQHxfligwq7LNwiGkAWo+etE/LmCUKJWF?=
 =?us-ascii?Q?pISWR9GQV1ozezi2EKBYj+IShtUWaxvw6rVdqMIUIvaukgWJp35DbZlE9ej3?=
 =?us-ascii?Q?c/VrtoVk7xmKQLzPMXghF3fmYbQa+U4V89mz+sukGXcUMOz1JP1I4EwVtQup?=
 =?us-ascii?Q?XITfbVepMHG0By9b0iv2jI01KvvkEStJvEOe+5W6TTb/aPxHllfdjxldHKkt?=
 =?us-ascii?Q?CNHWr+DBFyiHr6kzGDZad0nZhRFRhNPquKX2PHiWK3myX6Hv/o9zfm9y41FQ?=
 =?us-ascii?Q?Sla7fKOM/t9qFYea/gN1KTWmCKhF2mSQiKuIjOLnNSIDn6QPGGXl5zDsTJNk?=
 =?us-ascii?Q?lwN1TrkaemsyheWyPlib4dRdMLXSsIRC8DK76Bsih7WNdRmj/SyORcz3iQxI?=
 =?us-ascii?Q?IEkWSxo7Pnh1f8UKNSgB98eFeOBTyEe2CFtmledU2Q5TQrr06kLinJRHXCKV?=
 =?us-ascii?Q?8OF1l/nCQSmXb/6+3r2J95K7lNmSCEdg1GkmPovSaONrjzem5OI4BwAYP7XL?=
 =?us-ascii?Q?UWt0JkzBfK3n9mofQaCVWGyELSd72IAq8Oi1eFXlxAC3d0kQtAUYIOVwkYPt?=
 =?us-ascii?Q?UHmo0MOgjk4EwgTOg0+gx96cc4PwO71oKOb5vq0Kqpr0ij3MxbC2q6eyDhjJ?=
 =?us-ascii?Q?Jg/qF6CXWS7a2dJZCZWNa+3QdW6pOuJSKVnnG9BGLCauUATKmx2S6+kni5oF?=
 =?us-ascii?Q?34bwF7nM+YQF2+EryJmNo2e3BLzayZ4sZEvI2udKbltFHNoaZKsmEQ/9P5As?=
 =?us-ascii?Q?sywzE0hHPOuWdXA2MzetBSXWuIiNOkq6hBHobBIZum5Aes8xs3M/8GG1D9xU?=
 =?us-ascii?Q?LhgoLCsthJJZ0ADB6d/EuF7Fle9r9wUcu8AOC5HTSfzLPzFvSzbdgcovh75A?=
 =?us-ascii?Q?H1XtfzF32J4W9NERukCbBGbsqq/EhtAJxMyhqssaicabJsbqMusmpKRyfTvM?=
 =?us-ascii?Q?aKIHWJ1cifAhRGAg6KDT1dHtIZFFdc4H5ifs6LgNrwXXwGUxy/VNG4daTxnp?=
 =?us-ascii?Q?6IFRutk1KsjpG4Ddq//L4M6aOssX/OfJQEFg7nYaBjm/WIzb+y171yGCqQdj?=
 =?us-ascii?Q?AN5dkH+ApNQDAXqTU1WV8P+SZUNf+//n9Osj8XKfmPyMZaDYdnTqQOz7ItF1?=
 =?us-ascii?Q?gEdDgdzO0UvzxSLGeMwLRSo4IrskemYcbkC6gpIa2HLabPjutaN2VWpckofx?=
 =?us-ascii?Q?FSlS7hrQxY2smXKgleot1tEJlmJSw3MFFSUHKwFuxksoNbMEd01O5lNouaGJ?=
 =?us-ascii?Q?wdzGxIAh+9j2yJPVU3E8h4PdNhk7tIHkAguzlzDxg/xoFSS0bNg+NKzlWmFN?=
 =?us-ascii?Q?DybYvkwn5En2dV7CScdC2FHTxvkNqeC7jglKcepRUisDK+6NsWRKYdx7KCSi?=
 =?us-ascii?Q?LjEpM24Wh71FnN1hQ3GgkJiFVSzatnmXl7NC3Pp//cXHq4kEBlh/pvI9sXos?=
 =?us-ascii?Q?nW2mnX9L5zWW2uXlOzc4A8s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54EA1C5DA788ED4B97556EB2A7A3E862@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OivE4Z3irXKSq3qamvXkEGatD7mq7/Va4pyO1PZQAmdTkX2tprNAvM0qWrrR+UeHVpPzciuLrGARg28ct9AdvO2ILojJZDeuM+Z1lvVbrkRCpadRKNSpoW/NjyoADBhy0oGlro/uvd18khbmvJiCZI/kxzHPv1Ol9konYlCPla/8yj2dQxhW+Hnu08c8nFl1jx54zksH42N0yIioprr8EIrvRs3mH6szgukoL6sGL9Kqle3o1JFEbTcw2QeEMeBHLojtl8KJejnoe+BMqE21m71fUQb/Zco4iUrlp9ELJJEKE6iKzSQ+8+HwBwn87XRSHJCsJiqRu2Zg/Nm7ydtm93l2usO00LY5cSdsuk9LcQqAZIRJywJYDnihOSI3J28uDrL7wK59wIo5/qixBcX+c1aMpdElZgYBRAdb6TEwwq4nRxsPiB7W7ThyyCjSrQp3tZjn23dmtlBSAKO8SIR330gZi1y6vGzV58C00MeSShXD3SHDpbG+ciEHgshPlTAivLNS5LfVs3xmrrawSCpf2wFxRFJQ+LkpVMIsCpkC9BnMaBLnFG7RP262FqY579kCk4mepECjRp66LqxaTT20pgeZ6BuUUNqMj16Vmab44KDJFoGkKSjIZva9uEnE03Lj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fbcf56-30ac-4786-bc88-08ddfc0f1aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 08:39:55.8649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd8oN12qr+dbAuYucc7mSi6e2t///1TcJpgAYqKRLhN1eMpFH2OyVdIuG8V1viqmrFGyOgCK/yvbAECbgSzpP41SjyrL4WeUJRmhC2nkJ50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7851

On Sep 22, 2025 / 10:24, John Garry wrote:
> md/002 only tests SCSI via scsi_debug.
>=20
> It is also useful to test NVMe, so add a specific test for that.
>=20
> The results for 002 and 003 should be the same, so link them.
>=20
> _md_atomics_test requires 4x devices with atomics support, so check for
> that.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  tests/md/002     |  2 +-
>  tests/md/002.out |  2 +-
>  tests/md/003     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/md/003.out |  1 +
>  4 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100755 tests/md/003
>  create mode 120000 tests/md/003.out
>=20
> diff --git a/tests/md/002 b/tests/md/002
> index 3e9c1fa..65a5fa5 100755
> --- a/tests/md/002
> +++ b/tests/md/002
> @@ -25,7 +25,7 @@ test() {
>  		per_host_store=3Dtrue
>  	)
> =20
> -	echo "Running ${TEST_NAME}"
> +	echo "Running md_atomics_test"
> =20
>  	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
>  		return 1
> diff --git a/tests/md/002.out b/tests/md/002.out
> index cd34e38..b311a50 100644
> --- a/tests/md/002.out
> +++ b/tests/md/002.out
> @@ -1,4 +1,4 @@
> -Running md/002
> +Running md_atomics_test
>  TEST 1 raid0 step 1 - Verify md sysfs atomic attributes matches - pass
>  TEST 2 raid0 step 1 - Verify sysfs atomic attributes - pass
>  TEST 3 raid0 step 1 - Verify md sysfs_atomic_write_max is equal to expec=
ted_atomic_write_max - pass
> diff --git a/tests/md/003 b/tests/md/003
[...]
> +test_device_array() {
> +	local test_dev
> +	local testdev_count=3D0
> +	declare -A NVME_TEST_DEVS_NAME
> +
> +	echo "Running md_atomics_test"
> +
> +	for test_dev in "${!TEST_DEV_ARRAY_SYSFS_DIRS[@]}"; do
> +		NVME_TEST_DEVS_NAME["$testdev_count"]=3D"${test_dev##*/}"
> +		let testdev_count=3Dtestdev_count+1;
> +	done
> +
> +	if [[ $testdev_count -lt 4 ]]; then
> +		SKIP_REASONS+=3D("requires at least 4 NVMe devices")
> +		return 1
> +	fi
> +
> +	_md_atomics_test "${NVME_TEST_DEVS_NAME[0]}" "${NVME_TEST_DEVS_NAME[1]}=
" \
> +			"${NVME_TEST_DEVS_NAME[2]}" "${NVME_TEST_DEVS_NAME[3]}"
> +
> +	echo "Test complete"
> +}

I noticed that the function above can be a bit simpler using TEST_DEV_ARRAY
instead of TEST_DEV_ARRAY_SYSFS_DIRS. The patch below show it.

John, if you are okay with it, I will fold in the change below. Or if you w=
ant,
I'm okay to keep your code as it is. Please let me know your thougths.

diff --git a/tests/md/003 b/tests/md/003
index 83746ae..f4f35db 100755
--- a/tests/md/003
+++ b/tests/md/003
@@ -22,24 +22,15 @@ device_requires() {
 }
=20
 test_device_array() {
-	local test_dev
-	local testdev_count=3D0
-	declare -A NVME_TEST_DEVS_NAME
-
 	echo "Running md_atomics_test"
=20
-	for test_dev in "${!TEST_DEV_ARRAY_SYSFS_DIRS[@]}"; do
-		NVME_TEST_DEVS_NAME["$testdev_count"]=3D"${test_dev##*/}"
-		let testdev_count=3Dtestdev_count+1;
-	done
-
-	if [[ $testdev_count -lt 4 ]]; then
+	if [[ ${#TEST_DEV_ARRAY[@]} -lt 4 ]]; then
 		SKIP_REASONS+=3D("requires at least 4 NVMe devices")
 		return 1
 	fi
=20
-	_md_atomics_test "${NVME_TEST_DEVS_NAME[0]}" "${NVME_TEST_DEVS_NAME[1]}" =
\
-			"${NVME_TEST_DEVS_NAME[2]}" "${NVME_TEST_DEVS_NAME[3]}"
+	_md_atomics_test "${TEST_DEV_ARRAY[0]##*/}" "${TEST_DEV_ARRAY[1]##*/}" \
+			 "${TEST_DEV_ARRAY[2]##*/}" "${TEST_DEV_ARRAY[3]##*/}"
=20
 	echo "Test complete"
 }

