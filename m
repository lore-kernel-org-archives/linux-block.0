Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016723BB3D
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406252; cv=fail; b=Up3SSEAsy5AUO7KhTMxzMLyugBELcUETWs/iyPS8R/0DDkRewG9m4azmQwn3eIVABRKPjX8ATQVNhQuG6Jd6FtPFZ3Tz5FjkK4rZIBb583jzP9b0veEQvKhP2zMOazDZl+MjCfSaZOyUkQsEd4/qj9LceIuBEbJIeOoluvvn6Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406252; c=relaxed/simple;
	bh=oiU/z7dLDUMpq+NVJ/C3FG8rcE+f+8bvtECi7xX+F4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnhgDflJvpJDdmQNxJFH53MhbDklL60yYSfjAWlRAxFBBdMirp5m6VaOgweqviUeIXn2QkkesME0/8h5Rxr2xAFBJbSTdOTZQu68XiIrPNBM4CKJTpXbx88SJ0GTKA4nNiqwc1hVodDmF2/rElvBt7hoRQXcMzsa6Nl3KmWU26E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e0hjB0RV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eDzKUbsc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e0hjB0RV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eDzKUbsc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713406250; x=1744942250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oiU/z7dLDUMpq+NVJ/C3FG8rcE+f+8bvtECi7xX+F4w=;
  b=e0hjB0RVCkhPBKK7jYJbgzxhWWrmElybTBazuUPjCfouGN7RMX0U/Cpr
   NTUxOfdyHJf1HrIu6WftRYMxufeUdkFnSr6gCcu28vnOCcIyxmpOzWG27
   pMrUkOBgFT5khw1FEHVseAJT7SFqG9reXpD1dniJ0N/161VONE+Ojdtjk
   TdP8je3ChGrZrePN0iE4TdiRD6Zat3zk6NrPruOEdjOd8bn4r1gBiHUqa
   nF5bmRFfYDuEJj5e5/RZbzjNz1C+Bt0zxfwqAXT8f7A8cZgQPBs6jeOr9
   RkSRd3c9uJelAT0ACKqS7U6gB7yRNT7H8V8SKYSt18UjyEc1DazFAq7mL
   A==;
X-CSE-ConnectionGUID: srcDI7oQSU2gk3eOt1PKdg==
X-CSE-MsgGUID: 7ZF8A37DSW+rEbZmPnLmPA==
X-IronPort-AV: E=Sophos;i="6.07,210,1708358400"; 
   d="scan'208";a="14520046"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2024 10:10:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqvjpdVKV6NB9mPC7H+fToUXUYxQ6h7pbIJCH+sznYwSVL54LO5y0AdwbERw8SeRwlZzinbbnt2Hcnl3tnCrr4bZdWS36wg906ka+kjhKNk/TL5kyyy/fhJ+zl1eJMkTvpvNElpao9dQE9JE1jw4w75fQMoKXkVenQSlxBm4mwdIvyRXQHZHjUPQ6bucZiz5AuP4yz7YlLmO9lmYZG/diDgVgnl6hVmfbJBlm1DoVCU/TkmrM8PE4tjDBc4/4kZ/TBfbAhEtALtuwE9YkNo0vxmEigflgTty+MpLu7wU7hbed9feiviLp/KQoMUzmVe32BBnhnVeDZY35PZRX61FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XntnHsF15jwr1HZRLF6WO7uIk2Fo7aP/hJgd72W4Lw=;
 b=LxwcP82BmBMr+EHtIJOe2qcliAhd4okPXMP5t6bySt906aCbqLL1oR0RK/ERa2QwWVzOBCwJDXkLCrBjotctloXWSpXs1+enbDkvEIlXqTHSHzBBTb90z9/yvFoJytu7bJe0peE7gdG5vqn9n9+z8QWVEVE4BKpXtSXGBHxZZrgkyGzW8d4ketXRYHlqwfghhXW0NX+a+7cxfq6IM7zS31RimpGFc66WYfbW6KnnTxGCTYB9mLOzVPAL/jp6JowpZtjaXuLcPWePZpGgIjChPwoTF3veGxAlhDxvA8oUNY377w16gnZtNIaDVH3/5Kf+4Lluk+fcHkoThoPT5yGJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XntnHsF15jwr1HZRLF6WO7uIk2Fo7aP/hJgd72W4Lw=;
 b=eDzKUbscLNEXchpbUmdTBW/hgPdUlTZ913DkRIMFhtqvuKjGWyFBMqUl3v9PSN5btb+gVtGdzCvDAvc52Sg+vZnb40DPkn/zT98ixLdLjZjriW9pAKNY/eVsgjYNTQHZhYZFCOmS/neFHLk3+mvG1m0Z4kMjvpu8/d7MoxFRXI4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6517.namprd04.prod.outlook.com (2603:10b6:a03:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 02:10:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 02:10:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "saranyamohan@google.com"
	<saranyamohan@google.com>
Subject: Re: [PATCH v2] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Topic: [PATCH v2] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Index: AQHakNY6hcgPjI/jf0CUF7Brua5DO7FtSYsA
Date: Thu, 18 Apr 2024 02:10:41 +0000
Message-ID: <qesqv34uides7nrgyz3wom2baonvte3j6alnpdrlnvbpzechrp@4v4j6wqut4q6>
References: <20240417144743.2277601-1-hch@lst.de>
In-Reply-To: <20240417144743.2277601-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6517:EE_
x-ms-office365-filtering-correlation-id: 3c000da5-fe25-4a3c-19b8-08dc5f4cbf6c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x70NvR2+xEc/T6kNTjg+ja75+EmcKuku7V/IfvsvRzkhbpW1NI6NAhyYphP/rDHJUpyempnALp9cPfY0fMcDrpdglKvRg4RkaZAvq3y6JWyt3Olk9q2GZBuwqPPO4yO8t5fYPyiykQbmRd+QdAGlaiuh3rOtchjFU9tky6mbdKbYkZszOPv4DaUXH5SpghD2Pn0wLifDPHahCIpu4NEpMN24UNRoQjvVi3sS2ZCmvMyhTSbqwYMH3RIjzNBFC6Db+axDfuCIkHRrz+bS5fqmiNpRV7iZxwN84LwYh53+H/JhZyx7U1QenJh9t4DgyfrNNtKA0smGcTNGZaQGzZylpUljEt071BOma9v16FDVZO15s5N6q3z+ZzDRWLdylfK6wTLJZM4+7H22obvTfoDqKaYBUB8/AoQaE7EmSlqSY4qAC/vqcJ+HA7mEEpYhDX3FU5qJNHbmPwZQGt98TUVLA/Q6Ill5cUllK6sPtQUsQzbpdkTo7dLOhA3CYm/WgUzVCjlocGAWsltdFKdgYWDFiDGq3Qrwg+kKX5QCzJsWtYH+xagfkASAKm/ocwPo+/tCTq60rySq6TiKD8klJ7R5Wphn7MlTKCQU9pIfmeLI5qS3Q3VuoF+1bDFvyQI/1lTWsPpdwf3/kevbVH2SvXG9G53DWA19JOGSXiU2eWi78KcpVROV0byjZGJria9Znf5HjL6vy1I6r8hLJOtV4we3L8aEEOQkIoAEf4+owtbQwrE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?utJBd0Iuii2HeWlVbM/jsuSzVdyVEdaxyAD2gBBnQNfTaVC/Bkw1QdLbWfiZ?=
 =?us-ascii?Q?DxJLv0iqR5+qMkA90AIyW14P6O3iAPlTodWt5r46hxTodm+vwoRg6lnLNrwh?=
 =?us-ascii?Q?j3+sURKbHIirhtW5d+kaHTH4XER59nFSz5UPfMAFT4Onv/p1B67ZcEROApC3?=
 =?us-ascii?Q?BYfVZlajc2U1T9x+69nHmfwxiwzmD+ixoYHCSgek52Cg9MuLjeilN3Wr7x9w?=
 =?us-ascii?Q?3WXyJmP3ZXqxmSy7H3zcEw6sCJSy/btFe0EG6o3tZnztZz9rmzCIkKB4lPo6?=
 =?us-ascii?Q?q3Ka/rO7rzXcMYKX4lo1PLETq+c1E3UwOIOZv39yvWXj0bijY+R3JYKbqYZr?=
 =?us-ascii?Q?waQMFQYVkozt185I3uYp01IvNStHgYVSiRJdey0HH2EM4p7K6qka4rbiHWuM?=
 =?us-ascii?Q?2Qly5orgtLcnwIx8o2MLQurziLbUC5GrYintS4n2zOG16YX5dNgbyw64gSCV?=
 =?us-ascii?Q?L1xFDi+/DyNTkb4M+9+F/87zQ2z4VslAcNonrptAly+CWRzaQp4VI8rLYI2x?=
 =?us-ascii?Q?MYMhwJuJAhrrMM6OJjIVyQCigAW5SIBo7eZFSgOJ6oap4A35F6tbQhNvSLSm?=
 =?us-ascii?Q?PxJaqdSXmPeGPE9wT+8GfNUOOvzyb8lh8HonzQYvAgyeKXRSWHrg7Xc+gfSu?=
 =?us-ascii?Q?yebq7TYaiaNa0V1X3q/n+fWqP9HozND7U8aIvhZa48p21ML0VhxnRP9mKEoo?=
 =?us-ascii?Q?9nasCjOumwhduJdRwP9VPoodJMYsisT2cBVU+8zHbH94QkZkw/tFiwZXG7+o?=
 =?us-ascii?Q?KoS9l3zHbSG5ZXUSEEdzXlrSTa1v75g0ptzhCoKxyrCxayAsLQE/ZgRQ0zsX?=
 =?us-ascii?Q?FEUU9QHJx3UetaExJH/iPmXu1AIRlcdlWaLc4sPrfK4SeWGZ9PgIPFoTxQ3r?=
 =?us-ascii?Q?/X9e7wyAv2Bv8OEF4q8lB48en4x5NtefqNz8bgXXWtOTkoSTngxQhs5tdn4u?=
 =?us-ascii?Q?NIazOFOKXkZTn/QGf9cDyFjcgvcmYnZ96i37ygytdCYyVnR+/ILQT+0jI3XV?=
 =?us-ascii?Q?clM+al9xtHaPVvX2DD/p/E3jFipx1SmgQHEeAiEHoQKM/Td40Gu7Ojrd8Rq1?=
 =?us-ascii?Q?ofy+tUxI6Zmw9ft6EGHDMGrO9conSczOp74y0zoBLc0dWmJ/vJ2BUaDyfkeM?=
 =?us-ascii?Q?MbmDoyOXqdqYKyrfL0Vk1KJGypxJc7zfWVCIih1HKUchtq9Cr6YAfBUrqUoK?=
 =?us-ascii?Q?x31KRW+df4rMmzJtHdy+mxbG208+XnYRzxm0B7sp2KAMAXDa56MGmDUvZI+k?=
 =?us-ascii?Q?DtFBZitRs0MfF2N/DWTUUG637ilyhHBP+ZhXSXOHjHwG7APu4Sw0rbRUxrV+?=
 =?us-ascii?Q?LGSwlHeGdqDA1MIfZQYlrjjYIaUL7U1Rekk+Rq50bclbfHo/7CqiEL3BbFjh?=
 =?us-ascii?Q?rx6+DyrBzR4loRffPygpHjfzXsg52gUl0XfSbwBHr80OslHgys2/pMblMku0?=
 =?us-ascii?Q?1ueCvsjGRmfzjUvnFS0Xj2Tp5ED9wgOfCzvqpbKwNUv+2+A14Etju/lx+EMQ?=
 =?us-ascii?Q?ZpEdYv0q7Adjq+IuyXl84r2fMOK9vHrKZL0RVxqZoCozDOSvWWnuN/U1ONL1?=
 =?us-ascii?Q?a7kw9FufTRDsF806h7MDPenxcAo+vozrhuH4FfdJqZ0m73MP1/s0z4vOOda0?=
 =?us-ascii?Q?C6ylb4kgr4rpq4WS80QCXSE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CABD78749E00C247AA00F8FCD50E6BC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rX0Wj59MJ22g4KBPmxeXV2kUPiMcev/41vBUjFyustWM1mr2JFmECbLZUOnMGPUYXbrSz/iALg2Dnzi+97qldqq91CQtaxy49F6umcfr3jtUZP4RwAmk3s8aW9s+upcC66TLxYRhoG8WAu3PWXDJ92efreZX+GTErAQphg/q+ZzheHI1xyi/AUpT7YQfMFRNqGh98JShEkkeETwieearqRimrU4al0jsEtKBN/dug2uSchizc6sGsF/knT1sgs5wg53lYQIunFGATxHqOG7/pmHvX7BgTCGulPMBIvxgR1hHjw7tuGZhJJS0jwXqlDas1fc+iOQfcC30lBH3fG4Vr+SSYGX1ktol98SB4WVPuPlSaZs55z54rEKbu4dlHih/esPdMdo/9SXDkIrzeikGn6xGqrLcQgD00whVTj0xgglkw3DcGJ0cNDS00ZyWPJMPEL+HvT0z0mw/dcKek0DoWwMnA3C4zAqxgXZSAFdzUgF6IriAlLF1XX3JcL/JVyJbUE4ze8tX+cisfC0YFl9gSVtcCAQITlXS2/o22T6Ia/IbVYvZ1JR7MDHKEHZPf2fJjmbQ4Qvyj/yANA4g6UonWVNcPgzdeNOsPBXhE/xe+lqfrzqXdaG12z2brRRYOUz2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c000da5-fe25-4a3c-19b8-08dc5f4cbf6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 02:10:41.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ORxlrooc2WYbiXj9Xbh3uUAwdIjTUycjFB8YbS52DuqQ0qYVwDPVmB1aP8vhfCzSuuirMu1+J0mfG15GwTjGKV6JZI0pOxw04mVZAXJGfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6517

On Apr 17, 2024 / 16:47, Christoph Hellwig wrote:
> Commit 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> lost the propagation of I/O errors from the low-level read of the
> partition table to the user space caller of the BLKRRPART.
>=20
> Apparently some user space relies on, so restore the propagation.  This
> isn't exactly pretty as other block device open calls explicitly do not
> are about these errors, so add a new BLK_OPEN_STRICT_SCAN to opt into
> the error propagation.
>=20
> Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> Reported-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>=20
> Changes since v1:
>  - fix the rebase error that causes the flag to reuse a bit number
>  - fixed a comment typo

Thanks. The v2 patch looks good to me. I also confirmed that the correspond=
ing
blktests test case block/036 passes with this patch.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
