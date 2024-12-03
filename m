Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010E257D
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215607; cv=fail; b=RcbCzC8TZ7A5v1l5095MIDQM0uM0WqYcMPUg4zaatMuSQIHcSKz4ts4BKUA/ZujBWdR48vJtupJCUOP0F1pK6zZHm8WUXM3nh47rAcrdIKR+TgtNE4dYk1EVpVzPFrqrRnfT0LaKJ0aIYWr6o0ZMpq7SisnlI/1hpBCid3TLO3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215607; c=relaxed/simple;
	bh=no/gof3lLq+0oIr+zcIr+BN2BIkog4l2I78e3HeZ2J0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ca/OZwa/TYkuttSBRGCy0kNGY1rqQqSsxgDihQVm1LenkllOqYo91B30KUeAclavvpzQQsPhVYNowxYe9BxsNKYiiffaaduJtVHbS622ZUGdTqOqX8CC6yuEflNbmMgb82pGZrOEFxtHeVXEV0iH1v4QxspJW9CyMHIdChwO8VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ILyaI7di; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rVwAbj8Q; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ILyaI7di";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rVwAbj8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733215605; x=1764751605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=no/gof3lLq+0oIr+zcIr+BN2BIkog4l2I78e3HeZ2J0=;
  b=ILyaI7diNC4+3xXxMYSNvj7cr/fgAlYbIsHDQToQoV+Z/7CH3NSwyA0a
   4d/GspdaLC5U1UNPMw2pIT56007Q7IXi0YIOV7wbj8qkLQQBAICXJRKhF
   VbtW1fzex2gran8cDCTk4lfR19v4odR/omKcgapXjqSHwsJeoyxWzyi7l
   rUTp8DUMViW6QLRjZ3qIxhlI3FjwSHI04zuDLyEl2QxJN9lB23p85Ju4h
   RvCXFZrRVDOHz6Fx9OsHM1aozbXpiM1K6jTCTBRJHeCvz63KTm+IgmK/Y
   SbFSfqiPJi87FsyAhh8ZkGp5LayaG+G1iephpnYhdofjMJk9tCTvZREqR
   g==;
X-CSE-ConnectionGUID: nActU0SAQdSvtdadVTde+w==
X-CSE-MsgGUID: OLYaT1CMQoSF0p9pDTyvcg==
X-IronPort-AV: E=Sophos;i="6.12,204,1728921600"; 
   d="scan'208";a="32796633"
Received: from mail-westcentralusazlp17012036.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.36])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2024 16:46:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unXRqG3my8WSqB/4pMC9K20qk2764m7dRB7qrraJF1MrhbECOWHi0JT23yJ9ECSKUpR8+SIerXPnkPRfZEXw2PVlEYqHk8sIeLovcehj3ScrVLGIw0lKBsIQqs6/PlHLB8yl4Kb++WSIt4llBtt8wMu2hXXiO3p38MjKzHMs+ruTAorL0RO1SDWCwcgGoP8SAhU507HgbfUVHwSAKkL5zxz8iA4NbDb4xkcUjDoO5d4Vv7BFQlQj32BQPy7/YpcpD6fKBr8b95iA0ZMwjuCxhNhUhVwTHWliXD19wZ2vpdOoxV8JvKaIxrFtc2hAHvsVIlqGL5rI2KyQFhXdvbEwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyu6UwrjyZX8kgvoH5oyiVluT+DzeCpS59Rhwck63i0=;
 b=cUd5JDx/e8KnaHx0bdLTR7T5jZewdFOQFCec3fREjN7wIeme6DK2R/gFmyqP+wZpfGiykZMi76Cf1oxJEOcFyPVRcCHEfD97ifn9iUr7T1UE26ehfoejWSvQ4CYu5f2IeN0kXa5oVNM4rEAsVcOH8tq2GfB6WCIJMW7kO9vFuAdKaO7ThNgqKh32HYFoB8m7zPyoBrYgJNcaZSoiRB6ZRCIE70bqwv8dtryFds+j4PF7GQVa+FkswwvUvunqlZL7fVnA2X0WMsNp5nrLUQ6HmYd2Tmg1Us5Epmfrsr0A7lzKXqNsOlTebIOIIKiCE4AGem4EX99UNne+9oOlCYWCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyu6UwrjyZX8kgvoH5oyiVluT+DzeCpS59Rhwck63i0=;
 b=rVwAbj8QF7sF5dQYlHLAxFnspR3olNYzIPZ96YEO0wx9uZ40lUqcZb2pt9TNweH9vlK2qoE6qpjpW2c+uUaN6L7W41hg4m/GgeZjA/nmPmHcokBSO53HB5C4RcOOkldTGYXVGOeBjnZnf6tEMB+Vd6OBtWf0OVwiVRG05H1ldL0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6477.namprd04.prod.outlook.com (2603:10b6:208:1aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 08:46:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:46:37 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Frank Liang <xiliang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, Changhui Zhong <czhong@redhat.com>, Ming
 Lei <minlei@redhat.com>, Libing He <libhe@redhat.com>
Subject: Re: [PATCH blktests] block/35: enable io_uring if it is disabled
Thread-Topic: [PATCH blktests] block/35: enable io_uring if it is disabled
Thread-Index: AQHbQuDYp8OEfoAKz0ycAO1EWMPqErLReC4AgALByQA=
Date: Tue, 3 Dec 2024 08:46:37 +0000
Message-ID: <vgqd733ezrjkr5ubpo7aq4fhu4eu7iwnvbvvbgrhudmj33wspw@zsfwgruvax2q>
References:
 <CAAb+4C7EK51kXwTMz3MfrvK83A8ZqcpnV4Sgp1MXRrMJ7WuhoA@mail.gmail.com>
 <ok2wvd7gkc5jileqw5bi5oz4ecs2dkwxu4vnrucit4ewj2pavo@f7jxdivpuuxe>
 <CAAb+4C4rH70h8ALUKktWqkyvkoij0P=2rbYUtjSzZSQ7vFoAsQ@mail.gmail.com>
In-Reply-To:
 <CAAb+4C4rH70h8ALUKktWqkyvkoij0P=2rbYUtjSzZSQ7vFoAsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6477:EE_
x-ms-office365-filtering-correlation-id: 99ed449d-9d28-453f-d755-08dd1376ff92
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?32xyOP+gh3tgUWlhdf31pWlUs4RyIwyjMXXI7KOTHLyI8AVtg1Yp5o+MTBxj?=
 =?us-ascii?Q?tpowMkwpe9tVkkHDUfHDFteD7KZ4xeshEDKPsugk4c6gvDwTURIxdH3o2qYk?=
 =?us-ascii?Q?TC6WAjUtQmO8KIwRgTzQRiG+wive9+AQD6O8EsCWCWwFJ14L5OUb47JJpB+a?=
 =?us-ascii?Q?Fw7tSYG27KLrOYOF9NWIhtNkSQx1FU3D6uxxiEx7Ou1c+KLA0si9uT17WdFX?=
 =?us-ascii?Q?f7yVhX3GrMyGT8ejwy3ZaKMbahvXa1z0ZyV4BJiOean8YwK2gvzP3mhV4Zrl?=
 =?us-ascii?Q?Zl5VaActTmC01WszdM8KUWRomhHSUP9HesJyX8nZABRdu0g1x4jSM5yjyuc7?=
 =?us-ascii?Q?WBv9SqTtrpVILLFNOvg0od7Qgouz9g8JtGPYIyJMbs516t4ip1h+t3x4r/l/?=
 =?us-ascii?Q?NsctB7bmXDmkBOt1ZEXIOiBGQDn37U27XONfW0xPST8G2YdA9o0Mlw7xLv/k?=
 =?us-ascii?Q?0aJ0rGP2diuJx6rNVLCjikJWwuJSLXlAw2d0Lb5JxHtE3YM69emINPuHueM4?=
 =?us-ascii?Q?TwfBVEiq+BGln2u8+uwl2pry2mAtqhdRLguLEzpzMcFJJAArSV+EXG5ddkEL?=
 =?us-ascii?Q?rO8JBLWuAJCys0o5RDh186PyBMulGtPYX4dv1tRwMOm+ldMvUGOsBoGTozfK?=
 =?us-ascii?Q?kDc+pRNRE3gcnKxreF+YxvIoFYo6dptALEQzQsBa0MsPLMoEwymA0cVLw4i/?=
 =?us-ascii?Q?Taf8zeE/RvUUCd1fcI0h0O2rC/mwbLqx3POPS0AwJANmtJFMcqul2Ltu4OLu?=
 =?us-ascii?Q?dv9haV5iNhAcWnUkEsotPOCKS8j7Ovsu0bwkNgTSKzXt91araSp75tMWJ9Z9?=
 =?us-ascii?Q?BrArwNi+rl2MiWN2wA56SKidDxlAvqmsyTx1xo8iga2Hgsy7VTl9vMaWbAY8?=
 =?us-ascii?Q?gldsaaDAa1V5AIC8MNiipeW0kgXZ3jWeNsU2enqif+OHAQCpo5e9I7YcSvWO?=
 =?us-ascii?Q?yM3qTx89+aRoH2bQaD7YlAHrF++GfHIr/P+VJ9gwJ+qkIjUYxvaq3auINL92?=
 =?us-ascii?Q?rzTDT+/h7YLAEfa+Hqnp5OVe2352xvP0GI4dJvuFKh5IEh2ypdH5LhBaTWx3?=
 =?us-ascii?Q?hmV56buFLsTrnWi378CjG7ckEszIgr5GgcraKB+x0YT3IzWqOHi/qh9Ja7wF?=
 =?us-ascii?Q?AdceZSgaldN8nriatymJK6bZfuL87BuHVFe/CiC8bIUeuS2DKxJSwaNTRLky?=
 =?us-ascii?Q?rg2snq+EO/Yyog8gsXTdbV8Cj2CkxWN2X1LCHv7hLRY0rnXTXh2h+2+fO5VR?=
 =?us-ascii?Q?iP4HPEEyqemOYi/NTbZmbnM+2a+R0D057j1A/gRToWATbTPD13DbRTRjZHvB?=
 =?us-ascii?Q?jA+k9YyIZVNujDKZRK1YSbl/GnENVuWxby0+nNyGEgE6Kj85KNpgYUbzQ54c?=
 =?us-ascii?Q?U0EMr3sstC3vFB3EH/eZLRoATdT6+NLKkx0Y68xoOjTCqNT5OA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OoK71nE+inOW9px50+hPoWTDmsutELFjj7xSBIy3+S9LDg7fI2qSFPbaPgOu?=
 =?us-ascii?Q?U6UtBgPFElxXTuFk6JClj3shJHbZz+YscKKh9339yZK7FGO05hgrgwEzbTnz?=
 =?us-ascii?Q?9O+A0UexrrPb2UmPX2eqSwM4GRELXG5yZEBjzByXQP7s4Bg/xIDNWWg8zt1r?=
 =?us-ascii?Q?ILdJvgCaJaUQdxbwDrFOXvZdSqEXOVJW/8RkYQOQi17p5zU3127bHHhe+s+l?=
 =?us-ascii?Q?alXeOwU/G8SHuYg1PxfDmeH4sI8VuBo48Sa58DgPFoobG5MTRq1cxGRGVnVL?=
 =?us-ascii?Q?FIE8HeNr96Q5NaV9+2958v0/OqWYMGC9qAsGmsYXlUJFUP2P29P7jZyBsmw0?=
 =?us-ascii?Q?cq1IoOtbaBMzFwJUnoerCiXyOpBln9D9GcmQvobKE4vxnlegwKorSoALuvnu?=
 =?us-ascii?Q?eEUkaO1IGoN0QSfojcGYzCHtYlsh+z2e9tdFelC8Sq6Xnmuu1mj/RHjIfRiS?=
 =?us-ascii?Q?WvbX0qO40lILLOJYXzLUY7R65mYOsUE1rn1/aY2osDEcSmoYBfB93krxPAbQ?=
 =?us-ascii?Q?Rgv7+Nod1w+xrSCgsQCJDtNoa0sF8DjqnpLBQ0AwhVrKg6/oVezBkwuzqLI4?=
 =?us-ascii?Q?vo1masos3RcwH4Hobub6ObNIeqY9Np4R2lV/lny8Ow8jzweFolo2E7QyVhCP?=
 =?us-ascii?Q?jwm91JHm/T0pTom99VtCfutg2/aMexC96OS0UzMZFspiM0e63hP2DoG+TDdw?=
 =?us-ascii?Q?tEw4Gi4LHHnaJClKRNAOTivotgFRi9Dkgn+YFHZUWN/bRLcou4szXXyM+8Q0?=
 =?us-ascii?Q?n3YvY8+iTmejORvUrosagYqtl2JjgNQ1xym0b0TNz8yw18nN2bQLf7tZ65e3?=
 =?us-ascii?Q?xXoGrVud8KBwU/ybAutYmckAjYrNucl/o7hL4s1BDoxcdRIGq2Xbc0QzhsTw?=
 =?us-ascii?Q?1oBkXacCD4+wqrQzxvfyt+2r9ZPKVwQpvxup0dHHKuM5URfRmr5RLNaFwn1/?=
 =?us-ascii?Q?IGnS8FMmTs6mGmbzuWgkm4KGg75LHBcraciVIenE4HOFyv6pyiPgbUtlUYYQ?=
 =?us-ascii?Q?VFwaXPFCsUCqvYN+cSdclZXQ+lt4kncHgQJ//mKWxKZ2zpZzABJ5Q1ZAEfKJ?=
 =?us-ascii?Q?fJu+mmTfFQ0vfLt2qcGVJPm6ERq2ludz9/Pqtl94BnfiFh3ZGcBn+fiOv60N?=
 =?us-ascii?Q?5b1Yw0Ob/Q2P2uBQvc75Fqf1aKPkp70ylUiEJQOXoeL944VQytqCthbrfGpD?=
 =?us-ascii?Q?UPk9s47BEs7v30sfO2EeG7NPnB3GjpdEBRtY3xbBP59QMEPAORugOdU6Z1x8?=
 =?us-ascii?Q?wLM/u0/WEK/gkIUTXNtRuac3iNy4eU3uvGVM1losYNo2UWoepzWmS6eDOspN?=
 =?us-ascii?Q?M+7bCXk7UEF3NSZXrPW1oLiFNr383giQwUIAmDcraa3bKj8X/JSg+NSQ/+RM?=
 =?us-ascii?Q?gNp2L/AEcTIJyoTZqaT1fCkdB3ptOMQkd6RSvZ7g6lYxI1inF/fyyB8KKUCN?=
 =?us-ascii?Q?DIylxvyBiBR053e10RFhjaqyCYWpb1k8S0bDAetqktxTq0/4AJMkEBc9Z+BT?=
 =?us-ascii?Q?6Zr/HwpFr/+V971jMl2HFUYCCJXcuLvPpy0qI/A1vNsnoyxx4Rmn7PTKBfCU?=
 =?us-ascii?Q?eZ5ILoRS5m5lUGBw6Eph/8NGOTZHPIAj8JsGSLUU8NkKxAxzcKjvaYZ9hYZE?=
 =?us-ascii?Q?hBywkm+ypm/dbOQzed8Q55g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAA95FD34F018440BDA0A12C5C9CC924@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vhEvO65j9mU3o5lMPMS0M69fvQ1HtPnwcyO7jO1T5dDZaBUL/V6VwoP9PHxcndhWUPhr5muVh4+hGbn2Sp7x6QlDIZ632VsVJK9f9P2uHsY1rkqqgbNQI6BPlXGY42qJIUMdUjwiX4OICKrCX/V9LJDSb5TGkyaqPATzRzQnD8uJhPVwuACTXX3F1BkZFL7CaS7xUvJdi8APk9hAijxmTVqLhYHJt9YMPFOmPENZsCWn/bCRuJoapsODvuje+wdbacNa4jfRF+Sz9ErflvljMIOHPLoVOSRWGkJTP4eDJOsjhaGJlos8ZTD2skK2rmpQzz8UvBZ5NVkO0YzHYe5YDJbSLj4OmS/6DaM56oYpPvrXzm5hIOxKp6aWft9vavwg40TdsqUHLIEmQdQHT8xBQ7e5hNAwJr8SLtJLs0OW5WTj6CAUxx8wDSYLFK8V21GZIE6Sgk1e2TFtiTyVxd+IkxkuQKuWwxr/hXm5tkjX3JMESk9MchlKIeLwqbYGIqlgzkW7C9yb+x9XzWHgCSFha7TiFfkEWXvzu37uGCyy74sebHcEovYTXighKtR3dCzQu0FhYiMxvmcJLmrKMmq3QK7pjgvoDwP+3hMNHDd0NxYWZ+lM44C9Nyq6yb0x3B4i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed449d-9d28-453f-d755-08dd1376ff92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 08:46:37.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvLw5MJnIUfS3uFjFPu76wNZnkeHIBi4/+QNk459ewC6NMxi/5VcKnsHn+htlGBQaRRhZrxvrgt7G9Mr41tQxuKZ+6Mey2ySv+THeQGSgIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6477

On Dec 01, 2024 / 22:40, Frank Liang wrote:
> Thanks, Kawasaki
>=20
> Please feel free to amend the patch.

Thanks! I have applied the patch

>=20
> How about keeping the reset part after the fio? It is good to restore the
> default setting.
>=20
> # reset io_uring setting before exits test
> -       if [ $io_uring_disabled !=3D 0 ]; then
> -           echo $io_uring_disabled > /proc/sys/kernel/io_uring_disabled

Yes, we should keep that part. Please confirm the the amended commit is ok.

https://github.com/osandov/blktests/commit/dadbcb0e681bcf54f53a79785dae9ef2=
deee1952=
