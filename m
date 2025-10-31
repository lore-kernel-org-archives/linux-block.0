Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46B35957
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896598; cv=fail; b=I3EZKuHgSjeVaq0HPhW5XvSiSpEnL7MQfk/Vt0PC1nElRx6X6mHXwiFlb7Pm7ywxuK1SU2yIjQvISmnWZlnBnn45Dp1V3v0ZH+IChz9CgXsRmVyyUpP5Xlz7h3/K3bOiWVLDFqHksjlaEPbajxr6WfSyhUMAApb+C2hQVdN4cS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896598; c=relaxed/simple;
	bh=ZnCklT5dbEsleflmjE3cRdjVnqyIG5BL3x091ezTh6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tz8/hGZ1+Ub99smzMR9IC7GtWtnKaCVp45zmsLvfGi3yUNMsYKIHXehf7HVhB+kZxXowcdgphwg0RRD3FG/G+b+T2SULTRCh2g3e0V9dQfRWZAzQ1mzMpBLyhRsr0BGRjfZjQIZd8JwnYDDEggM7+A1857Qxpf/wyqvo9DmwMfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c2gDcdv0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gWP35hCX; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c2gDcdv0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gWP35hCX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761896596; x=1793432596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZnCklT5dbEsleflmjE3cRdjVnqyIG5BL3x091ezTh6Q=;
  b=c2gDcdv0bH1BG2b7YA7lwXCW2T8PYY8IEOfZ2tlORDeXQADYD4Byg2Vl
   xPxdxbBTLQAdwRnE7DeMSWN7Bk3LUDRTG0XuDUMd95UwEEQh5gx3mBgdC
   fv1rYHhEZLY9x7Bk6kGypN09d0+cLuxk2UUN61tKnCGxMm5tepOy8e5IS
   8Ix0ds4JEatos4k4hwKt4MPrRPqcBjx6FJC17mc2R5EnVCILnvmwS+ISn
   8NkNrx4c/Pwy+mRxu/MT/y0eOkeqemPeU4gvTfeywDlc1rTTh2BnNiPzo
   Ep6QONYU2ZRW54TuA9c+qt7fmVLE6ZWlCaoqMALfLifIzpvRFjvb8o6m6
   Q==;
X-CSE-ConnectionGUID: qrRYVTKwSVioFCfjtcFowg==
X-CSE-MsgGUID: aZ5ZT1hOSi2bvG1rVuxryQ==
X-IronPort-AV: E=Sophos;i="6.19,268,1754928000"; 
   d="scan'208";a="135520532"
Received: from mail-westusazon11010013.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.13])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 15:43:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3D7DwlK987uyPnIT1NV3OHCS/c14Mw0RGmxUc/lNOae3uxAGcVF1C4w9IZvQk4I2dWZkDZ1h81L0ySlqMSYdrLIx5/Cko16iRfbmVgC/RynuJpQsnfeAFX22AiecHnv1hDGwC71UVY700GoX+pF0LAADgBCKjesFgZ2Af2WL/nmVlR5N8UTppvM4bsVyswDfU/s79AmzUuMW1n2tLbBstL43uqlbzZJ+XorvJofnmdZ9EYSW+FgIvDO2amrsH+tiftKFQMIZUCToO/4yg6q2nYnmIKHzTqlX1vN0GmdJKwbHhzwWywx/r9ODBxO7iMGa2Pcb4tEJ/6uOtVjkVW1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zutFOsxLYoJslV2dKrTT+PU5qG/jbWENqjANtxnUdyo=;
 b=a5HmYe/mhy4HJMAIrv1H3jNPq/BIxhmG2W7BBsVSKTP8ZLqKRp3xpesDIbQJKqyzTZxD4+iOvL2l/4Wo0MEB6KdgTzRFqW/9i7O4dklo0TTfcMntfdUkx4bJBhJ1seJAZVDr3pn/P1vLRsK/ramrzu4Q5B1LvEKQ7b6Y9oCzAgJWGJv6k7LGZck4iDoDqibHM2YU9SDzyE9LrMIKHrxCXdz5W7OD7S3ybo1xJy+lSUu4j5jQEzdqZzlNfDta618stqEf9gratdTHzj2vRWLEC3FcPRsvoMD9knIpBlMOqW06WMcJzZq77erdS1jbr+nYOmlEh25lhqB9iCf9BDYeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zutFOsxLYoJslV2dKrTT+PU5qG/jbWENqjANtxnUdyo=;
 b=gWP35hCX6zLo8H3hKLmarJmjags53xlD0hAEKYPILVL/aOs1FMd+ldAvjWzt/WiASY70wd9lrPFNEqm5zhvp6Jbj0NOf5a1P0f72Ck3eFPbOwmjRFlli5wm+9BvZNhq6JnMZvHibnD7n6ddl9foEqVPBgTp3Xqg39n7xDabzvs8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH0PR04MB8097.namprd04.prod.outlook.com (2603:10b6:610:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:43:07 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 07:43:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] blktrace: add blktrace ftrace corruption
 regression test
Thread-Topic: [PATCH V2 2/2] blktrace: add blktrace ftrace corruption
 regression test
Thread-Index: AQHcSD/9IN42+FssnECt8npHmUO0frTb430A
Date: Fri, 31 Oct 2025 07:43:07 +0000
Message-ID: <lx6ec37izk67e25t553npy7bpgerbopjuisx7yycv542jxrgcg@vovm6iwqagjo>
References: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
 <20251028192048.18923-2-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028192048.18923-2-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH0PR04MB8097:EE_
x-ms-office365-filtering-correlation-id: 64ba9b62-c09e-42f4-7c29-08de185121ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?33ltC/Xp9yVPI4xi366wClmA0iCZkY7xHl9/s0pVDbqtDkI6i99UBW9pQUDh?=
 =?us-ascii?Q?88eRJCZn8Dd/g9JgVPae0YcnJM+PECiCHfKrxmnaBO2+qobfzn7y7DpL5Zi8?=
 =?us-ascii?Q?a0lcAgDsMxw91epvTiuDN0imf0lREBi4OynII7XnnCzUleJdyu9zzBy+i+Vc?=
 =?us-ascii?Q?i3utyHAPR8TEOGNZo+cZVOh3kbEa7S/SfscHPDtScaBvRAxgzHqQuDIT5GR/?=
 =?us-ascii?Q?9T7Hr7EIgKgTFsymAtCS65LsQDWIfbxVW+xcOXxsvWqJ4NHooxwsl+a3FRWz?=
 =?us-ascii?Q?1efOro8JpBRgz2I8Ov6gbRZWp6baUILK6wN11Hl1D4DUQPDG402xXKBQ8MsJ?=
 =?us-ascii?Q?SQuzRwUtdv5cZ4fE6hdKlUKEy17sWG0A/R5zs3100XQ34ieM3Qg+sezCy7Df?=
 =?us-ascii?Q?PKN8jBR6sf2CzcrNC+sUepw2jrJ7rUn9QBkBKjvTJ7oqjXbINxXuNODBXguy?=
 =?us-ascii?Q?IAkSwHGBwM1mChXQS2BpCvaE5HwDsqaw+1uSSSGauNmmhX/U6A8kGcTVsgIi?=
 =?us-ascii?Q?cWPDRrc5pn0NI2p4MXqZpCZinULzezszbwVUdQT1QusRShMLBWSjhnm+h5Tn?=
 =?us-ascii?Q?qo5oqd8vxn4TzS348mVlx1D3QEmi4hh0lqLAFDniEu8poFrUrWKQQOcuO6jy?=
 =?us-ascii?Q?4oH9/L8FMT3AZlF9nCG4rOEsSov8zuZl6NG4TL5aNZdDQcmR8pu+HEIeeEM1?=
 =?us-ascii?Q?HltjwC1zjWroRvfyE6LPP9Y2bIXjUFKSEHuhjYpRdka/ODt7iVnDhSUDNpkA?=
 =?us-ascii?Q?XjdUhIhYuUTd5MnO8+upZDLyxDBhYwQ27P24fOEsorbTk0S7moAhPUHjyDc/?=
 =?us-ascii?Q?9hqnnGdtwjAY6ueyv0SVbCm1t9NVDGrJmEUDoEXq0G6XWB8JIMLVt0O6DrqN?=
 =?us-ascii?Q?HoGCMooS/CGfAZ/xO5Z7YWd3EH0NWQG5sHcWs7CkFMQOJvKPTXGri+d1laNu?=
 =?us-ascii?Q?6R7Kvwy03mEbaKtiEMB4wHD7etMMX424rZrQoisIWUbFCUN42V2/xl+A45OV?=
 =?us-ascii?Q?ph8VQmcGMBWe8vPTwpJuDxY4a3ofma5E4uwglvVQGhVDexf9gSPYJDfmwMiq?=
 =?us-ascii?Q?qkb+0AcR/l9UPa+jqc4kvMryRzNjYFOjIWFq+6pJdTgq93fqOPotMSJ7fd77?=
 =?us-ascii?Q?rndgBFhQaSyp/1z+VredUkEFOuhGuPaqUFImN+UrG1FP+VA0G7/jnKUJwsQQ?=
 =?us-ascii?Q?iOL9lp91I6w/1MOn2FqEP3H1cSnxxeeKdiAvON0Nzx+8KacG5nEbpotiWIA5?=
 =?us-ascii?Q?eo1Y+RsUAh03+0fecMVur2x99lxJ6vN5atRFodarPG2SyOf+UuywLYLG6RNa?=
 =?us-ascii?Q?LtiJ+3ce0W7fY2u1ZsuTppXlzwBfvLo0FbkZgpHBsPGyXq+gE8eeV7KBISjG?=
 =?us-ascii?Q?UfBjwjYrth3bQV1G39F+KdqW4Hll37CxGKa1HyscS8i9y8eOO3TMqF8JBWNJ?=
 =?us-ascii?Q?1AyocFH+TQbjBmxyz20IcPqt2uHYqmV+ONSIPzWetwtlgO6fK0rufvkp9XI5?=
 =?us-ascii?Q?4Pt4H28uPByTZBA18Ol/16MjMF8mZJbKx5sf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ssJwhllIfwceiCjDaLyLt8Upuynw/gJQ14M03kUQfxjkuXAl93WVHoHE/q8c?=
 =?us-ascii?Q?UAgtqyK13D3WjmoIeVuto7DwebLs/zjVdzEC3G7FDCR4YwmMgwXtsdFDeTaw?=
 =?us-ascii?Q?cthT4j8h9gZeFqF7T0BULJ3VWTBv6rVeSf0BoVlPAiH/ZnNksBXgMASdomBb?=
 =?us-ascii?Q?m2zGMq9Isy0JIcdL+mHBOcVRttKnItCWWZNuSzm3pX1KsUOH0jrvwV1j7epP?=
 =?us-ascii?Q?zrSFiPbmzM2Ohqz+0MOcLZ1rojgufhV+CPZeJsrMoRYsmXykoEcAMhV5xZCk?=
 =?us-ascii?Q?uk+2uu8rVKOaq2ZaQtzqPRAT6aKqAh7UZVwoPSjPPoberO9gvR4FuxfKNoTW?=
 =?us-ascii?Q?NIvt+v2lTFnZoyC+BlrGw2HtA/MuX96oFTdQKDG5Zlbn1/dn7X7kEbY57C+i?=
 =?us-ascii?Q?JO6Kq7i4AmhTRv0f5WKcmRD+L3a3OAnkzosvD4IRhhub+atG1T3Rr2ZmpOqc?=
 =?us-ascii?Q?laEl1LPdAp1/hKTMwWOpe03TJTfIi/Fsmnb3g3UNHU8daWM59c8OwsrlwwGO?=
 =?us-ascii?Q?r9QYYwdVYJy4NY233L+gV7d/gX7t43J6MHAZSbXTn4f8mxy6EDkWDPzLpeoX?=
 =?us-ascii?Q?BL4R9WiNaCMm8vWmGyPmZN1uHrql5fOsq67c1xtf8ZpARdBG7QDzonhfzWF3?=
 =?us-ascii?Q?XoHTYsTmCsWxHtJHNx/wUltXa3NoKFKqrgUv8K+poqca1RfB0dS3y8gkcLh6?=
 =?us-ascii?Q?tPpVkfiE3onuh06TtYJGhiIXFGdtQneOaG1D+qwUD4f2IXf8rJ+4FWxCw8D5?=
 =?us-ascii?Q?/dNzZObVh1hAw2zY0dbjsIUAv7EAuNOJ9X5kfL4bkZlLysxTZMK2nntZvGak?=
 =?us-ascii?Q?GdhB1qV/noNuVZ3qBybXEQX5LjyVrCbQkq9uceBTiuYh5ZzUHD77o0R2lWGr?=
 =?us-ascii?Q?FGbTt7DK9n+e+hzMoICDV5LujM2RA13KyvTUFf2ARX95HPfuGMylJYQoY32/?=
 =?us-ascii?Q?Ew2L/rFEKWN5oUXxvcImh8aC2PXdM6sx+5ORxNE3yNgwtIS4K1WxCqv0IB/R?=
 =?us-ascii?Q?6kdXlvQjo0rpq8awxwx+adm14KTbbT7lCVQ9gWFqfCdLDvBwCbz47su4Zgp1?=
 =?us-ascii?Q?0NPGyGullgMWW71GEmc3DeiBsVUf38GRHWBEfasrAPG7vi4B4zcuAUx7XrfI?=
 =?us-ascii?Q?Z4kdzFOFbOI8vMwPuCAaH7nSPez+jCUZfrTjJ+vD+aU/7clT2BpJEeyndGp9?=
 =?us-ascii?Q?RL/IPkNssQ4/FmHuH50aIIiV+cyLXrDmSqUARMXeCXnl+eRKdSZ9SDU7CfpN?=
 =?us-ascii?Q?pH2alZqJJdbR0njn2TipdHTiR0f05KHWmrUGe87xarNpI0y7yaWw5hSg8inr?=
 =?us-ascii?Q?jPPE2gwAoms4wzAmpJu9PSplxB2Lt/mFJhLfAHiho2fFlEvq3IP1515njqNS?=
 =?us-ascii?Q?d6886/k9Y3EFrJOBzM/pdWdNhsY1jemCun5gmTbfuKGG0zB2tnQ5t2pf0OhP?=
 =?us-ascii?Q?XwbdKVK54ZyVdeHOkV/qigofPZJhweWYkt8SLNekIPPPr2/KnJjl8QCAhTe4?=
 =?us-ascii?Q?FzJQJ3DBrQa4d9HlFDo2sQlEeT4/fDmTbbP/GbXLDiO6wVlPwGTSJePoPV/d?=
 =?us-ascii?Q?HFwel9BL65Ac21Lgo0cL2unrJbZ0OxRs+/Etq3cknU8XgcBc9qgxel2A9lV6?=
 =?us-ascii?Q?GR18WBB2rU9/RhwG/v/VRl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAF1F469763A164DA67008B18E147767@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lndvFtuaClLsoZPpaf5ZcencXRe9v5afRAV1Zxe9PwVuBi1X2zzouIz5J2CxwYiUyrt4CaHxjceBpgChcSDmQWmuEFt6IgIWR7icdBMmwk+IWXes2SsfH2JqIXPsjFo6XMhOMqru/spgD5CJPAbfyRwYgF1IHm+qqbxuTHftDYRlEY2Lykq1JYiDU8nuVWNA8fkVvKeq6QNzqoRNNMjh/VjauM5GXJ9K1Y0635PvbHwJSy5aFNjkOkuq8ovfbUCZ92CSz+wZJ6CnQr6nKjxPTcS6u/PvweuWg1OqSm+exyaLtZjiyqA0mRwHcWfraH4TuC9qM3bahcAWRepc8MDANaiAZsqABPxU2Ej5o6xbpXZ4WP1fOaU1hDKnYp61cMSGgHDST8KkHAlM9G2jqSGdhwKRapZaR1LDTlbgiKpakCkVH0EzAb2BLFHcmiSL5EYnVQvZXf1rnRycGjjvw4PLTE+GhubImwoiGmnqeWpPXkeSpmR3bAsR5O844Uos7T4qPMko9YxU+MOEIPzUDXYbWAnE10T15Nj9q8jBflvqv8lHw7TzZUEp6WYfOQYGtOZ6SQxsBu2PEHrg4BnEAzwTRgJvvwkrzV3dWvusCJAR9tW5E2mc+SWP11EOHqg6ta/J
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba9b62-c09e-42f4-7c29-08de185121ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 07:43:07.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXBkNALfkUr1YW/vboHHmKIF2gc+IuX/u6tn738LmIvk6YSU5tMA2F6g7YlWwagJIT4PQMf6IGr09OQg8hgZG4FkTiPH36iW4ynJ9zufJjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8097

On Oct 28, 2025 / 12:20, Chaitanya Kulkarni wrote:
> Add regression test for blktrace ftrace corruption bug that occurs when
> sysfs trace is enabled followed by ftrace blk tracer.
>=20
> When /sys/block/*/trace/enable is enabled and then ftrace's blk tracer
> is activated, the trace output becomes corrupted showing "Unknown action"
> with invalid hex values instead of proper action codes.
>=20
> The root cause is that ftrace allocates a blk_io_trace2 buffer (64 bytes)
> but calls record_blktrace_event() which writes v1 format (48 bytes),
> causing field offset mismatches and corruption.
>=20
> This test verifies that the trace output is correct and doesn't show
> the corruption pattern.

To clarify the relevant kernel side change, I suggest to note that this tes=
t
case confirms the fix by the kernel patch titled,

  "blktrace: for ftrace use correct trace format ver"

and add the Link tag to,

  https://lore.kernel.org/linux-block/20251028055042.2948-1-ckulkarnilinux@=
gmail.com/

>=20
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  tests/blktrace/002     | 97 ++++++++++++++++++++++++++++++++++++++++++
>  tests/blktrace/002.out |  3 ++
>  2 files changed, 100 insertions(+)
>  create mode 100755 tests/blktrace/002
>  create mode 100644 tests/blktrace/002.out
>=20
> diff --git a/tests/blktrace/002 b/tests/blktrace/002
> new file mode 100755
> index 0000000..73b8597
> --- /dev/null
> +++ b/tests/blktrace/002
[...]
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local trace_dir=3D"/sys/kernel/debug/tracing"
> +	local device
> +
> +	# Initialize null_blk with one device
> +	if ! _init_null_blk nr_devices=3D1; then

This test can be run with built-in null_blk by using _configure_null_blk
and nullb1 instead of _init_null_blk and nullb0. Please refer to [1].

> +		return 1
> +	fi
> +
> +	device=3D/dev/nullb0
> +
> +	# Verify device exists
> +	if [[ ! -b "$device" ]]; then
> +		echo "Device $device not found"
> +		_exit_null_blk
> +		return 1
> +	fi
> +
> +	# Clean up any previous trace state
> +	echo 0 > "$trace_dir/tracing_on" 2>/dev/null || true
> +	echo > "$trace_dir/trace" 2>/dev/null || true
> +	echo nop > "$trace_dir/current_tracer" 2>/dev/null || true

Can we drop the "|| true"s here,

> +
> +	# Enable sysfs trace for nullb0 (this triggers the bug path)
> +	if [[ -f /sys/block/nullb0/trace/enable ]]; then
> +		echo 1 > /sys/block/nullb0/trace/enable
[...]
> +	# Cleanup: disable sysfs trace
> +	echo 0 > /sys/block/nullb0/trace/enable 2>/dev/null || true
> +	echo nop > "$trace_dir/current_tracer" 2>/dev/null || true

and here?


[1]

diff --git a/tests/blktrace/002 b/tests/blktrace/002
index 73b8597..57d42f1 100755
--- a/tests/blktrace/002
+++ b/tests/blktrace/002
@@ -31,11 +31,11 @@ test() {
 	local device
=20
 	# Initialize null_blk with one device
-	if ! _init_null_blk nr_devices=3D1; then
+	if ! _configure_null_blk nullb1 power=3D1; then
 		return 1
 	fi
=20
-	device=3D/dev/nullb0
+	device=3D/dev/nullb1
=20
 	# Verify device exists
 	if [[ ! -b "$device" ]]; then
@@ -49,9 +49,9 @@ test() {
 	echo > "$trace_dir/trace" 2>/dev/null || true
 	echo nop > "$trace_dir/current_tracer" 2>/dev/null || true
=20
-	# Enable sysfs trace for nullb0 (this triggers the bug path)
-	if [[ -f /sys/block/nullb0/trace/enable ]]; then
-		echo 1 > /sys/block/nullb0/trace/enable
+	# Enable sysfs trace for nullb1 (this triggers the bug path)
+	if [[ -f /sys/block/nullb1/trace/enable ]]; then
+		echo 1 > /sys/block/nullb1/trace/enable
 	else
 		echo "No sysfs trace support"
 		_exit_null_blk
@@ -88,7 +88,7 @@ test() {
 	fi
=20
 	# Cleanup: disable sysfs trace
-	echo 0 > /sys/block/nullb0/trace/enable 2>/dev/null || true
+	echo 0 > /sys/block/nullb1/trace/enable 2>/dev/null || true
 	echo nop > "$trace_dir/current_tracer" 2>/dev/null || true
=20
 	_exit_null_blk=
