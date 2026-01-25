Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B63EBF2D
	for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769325468; cv=fail; b=TZxWbAmkWe+znBZ4PD3ewj+DS/2a5drJqMEN4Apr1R+fmPFRZFIT3VO/dg0WviAhv0GspAdTzDkq6GHZkSN07ckDLLPgv7+fAqTOzBRzspKNNCM032MZD/tsXn5PMjNusxykKNAM2YQLq7y1LP0REgTen/DmJ3CS0I7kWl4lgy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769325468; c=relaxed/simple;
	bh=iNwt7aDQXuLrRvjcyjDD2+h9vvaYoHRdDVG4vyni09Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+2RYMypjymox40P9YtLtN69CV5V6A8nySZO+zrRoHxA0EWJgQ0e4PtDyeQE7GFJU4VV/52W6Gl3kzq+FWptAKHPGfyIDsIcsveLPFtQ9k56qdNKH0jm8tPcH83hh+6MSbpzsN6F/vd/MCu8rmfqOXT43wLAeURKWq1yn21wM8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K62rMnh4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=i4ytWzMh; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K62rMnh4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i4ytWzMh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769325466; x=1800861466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iNwt7aDQXuLrRvjcyjDD2+h9vvaYoHRdDVG4vyni09Y=;
  b=K62rMnh4YZ8lWsI9T04Aq3cHCgSYLqxYNCrQ4mbzEeL8B92L911eRgyV
   gl5ld/ncBJddOxZcyBycQd3bNHFPjDNU1t/7NLF0ehXtMkmzuaIqz7yGz
   33YCDK+/Ev0Bu0+EYFxlUcwGng5tYxLpta4wTL29NVFq0/589dUPBfcti
   X9gqEjWHRx7d+/IiylJDwTbRc/8OwjML2pdgu+DYRt2DCv0ap316LHCP2
   DDYntGQVe2bqtSos6/kdGDr9HitkrA3MVxSsu1kt0AwOKiRpwHG+/S63B
   MKYwD99mdPlWy1RTH7ZcKL1L5vvWzDU9HRjYGWQmasm/zqwG7a71gxTWe
   w==;
X-CSE-ConnectionGUID: S0Mo2C/tQf+UZZbbgm8SMw==
X-CSE-MsgGUID: 1luq86FWRvWw6DYsIKEZ8Q==
X-IronPort-AV: E=Sophos;i="6.21,252,1763395200"; 
   d="scan'208";a="140599332"
Received: from mail-centralusazon11010046.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2026 15:17:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfO1+Sj8wJXQf9fvTsmIV9FfOWMTHeTu0P5mWBwSLG1GA+TsDHoatrooectg5qSSJcXULejuyhyhvQ0Se+gONfBocswUZ1HR7H5bxr8WgeTJ0Th6eb5IxUCtwoWXLEmhEZYDVx2e40nommYEyq54eFnQOFTXMIAsFVyyTQv8InoFSTT1qtFpFjuEe/sp4Ov/NZQzKTgM7VUnYBZ18h07kVqqw9fixyacMu8eZuKJ6SmfC1zFjQ+jgtpSdYfwpWtN7WykasDRzPDX9jStDV81SC73xl8d/IyacGeHcaRgUMY9X+C0VuYgj5hP4qxTjcviEQLwHbWqrYKgRchUAZOlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho6BrpJkN/zf52i6uh8tIY7HRln25rnx7DVy4/Mzxl8=;
 b=T1t5RvRwxlTLeamhxMcEs2EHvGWqnuyv4o/oqVAVSLyOjrttQFZNfBX0SyVoaznNRsRF8D7r/erKVNeD4pxddnbXSGHXbjIoU2zBhX0v73JYPx9dyH0yfM0IIDjtKi4XkcNlcpzJmM4LE1TiBIEb7TbKKlrqyJ/2Na+yzrw27RKVVXEMk063rfQAVOxRXiNCOLtPAuJp6QSDcCypuc2fwjiye2vs8bD6vHuG2OEHBbjTJItkBgA/t3PckyfpA7G8P490u5HrzS/ta+cdomdmzOSAL+nEuIS4ub3vZMpwiw8qTEpY7FKNq8qmMRP0W/caUP50WvFiA7XGbSbUCPoO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho6BrpJkN/zf52i6uh8tIY7HRln25rnx7DVy4/Mzxl8=;
 b=i4ytWzMhrFf7unlV7Tzpfw0bHX5t/FNWsW9J0qaort2FacOpHFaKJWtZtRrvPYqOkxDw4DTVUWYRH+lyFcWech4HLaCl084+EZFolWSpZFWLs2PZCqLvwNJT2J7qSxpQF62rGqQ5JIQSg5iUiV/KdjsFwuvI+tDpTNb6OFNAMeY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA0PR04MB8834.namprd04.prod.outlook.com (2603:10b6:208:480::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.5; Sun, 25 Jan
 2026 07:17:34 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9564.001; Sun, 25 Jan 2026
 07:17:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Pittman <jpittman@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 0/2] blktests: add ability for multiple dev
 sysfs checks
Thread-Topic: [PATCH blktests v2 0/2] blktests: add ability for multiple dev
 sysfs checks
Thread-Index: AQHcjAiMlj3eXFcVbkeUnpPAroo08rVifUsA
Date: Sun, 25 Jan 2026 07:17:33 +0000
Message-ID: <aXXDa4hYNR1P1OS4@shinmob>
References: <20260122193133.3087906-1-jpittman@redhat.com>
In-Reply-To: <20260122193133.3087906-1-jpittman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA0PR04MB8834:EE_
x-ms-office365-filtering-correlation-id: a6e79b1b-b487-4f23-754e-08de5be1cf85
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PlSMAmJ4HpvWqUD8SoT5GkchkYCMTorawwUJ6RKVjGa9RXditMBoX8UhjiB2?=
 =?us-ascii?Q?holvVd2xcuTdDxQhx8czGTdLPhUssTiGDTiYmtfI/lVM9tNaGCZu0M52A9xf?=
 =?us-ascii?Q?Jm4FklXv6G50G1xQ73gNM9tt5Ujy7aMAqUcJs43tTmEv5UUS4DMuZ/omPX+9?=
 =?us-ascii?Q?vFqzsV7DqGkLdpXtAx8wfcw9XDFVejFl5IFtZSG6FuVHE+oz/sxgVbF5r+i8?=
 =?us-ascii?Q?yO2BBumFU+vywbn48ZeFoPtLfVsacA4/tR831QIGgKDz14ZQrQCUsxg5kkFB?=
 =?us-ascii?Q?jdilI6fjf9SWsYB33Oh0R7HtcO7lHsDGvI6wwvyq6xcZTjUJ7cC+E/58ZFtw?=
 =?us-ascii?Q?7Ct0ZuZuXpWial42JZnF8uIbRq6aT1fG7SzXD454Wprm/HLRRHGoZdz3jmTD?=
 =?us-ascii?Q?cePq2sbS2/4cL9Pg4GlPV82CQGJA07snH4GmfzAMkcIK7J1vX+Kh4AeVl3CD?=
 =?us-ascii?Q?Qg4EpsQ4Jx13JvaFYNr9gOVOshRV8gWII0ZopCw2UW16Cp2o5KKw0xcH6qVe?=
 =?us-ascii?Q?Dw3XPIjnL0HiZZEgziO7sYXrc4mfM+7hM4ZuU3lLtwx5JbQYwVwZ5WxnhNSG?=
 =?us-ascii?Q?886WbKAuq6T9o0N2R4e3wvFCdLJ+vujqZaZCZQ3csPjQ+G/sZwwSc9nJ8Y3d?=
 =?us-ascii?Q?ZgoixdtenLMK79SzMtLNvEEvJwMwnAwZdDDYIDq3ed4sklCS4F11GbQjjRkm?=
 =?us-ascii?Q?P1BqrsuZu3KOTEN6BB/5NyPBuKbekwf3EuSlpri+xHgyTzTTr4WBadroRmi0?=
 =?us-ascii?Q?t5ZbyMsdtnpaVZX8wIhjpTayfH6cesrAlMLQWFnEWUJuqnvVY4iHNqByMHEy?=
 =?us-ascii?Q?j28Wghsr2wd8LQucD72eC8QhNFZZ501uSVnBgpSu8mnjQTglgAiCWP8HO6on?=
 =?us-ascii?Q?+h1TFg1wkYKLkbyo33vXWg+q4dE6U5Ie7zUItE8Ky8g75lGtpZ6VQz1FFPjN?=
 =?us-ascii?Q?OcrX08zw8vFWWCdmaF9YpWvu2n5ytS5JijJKHBuTI3WwlZiYnaWX4lykTejS?=
 =?us-ascii?Q?rVNQtAJwvXm4luEE+rhZ7hsiBZNgvrOzWJXa5xkiFx0wl857ablQFXkBipH7?=
 =?us-ascii?Q?vW1VE4gLBXFXzbQljA6UJLrayhTVLZdC9ucMBFJaPJrsfsalE7n0pf3okY0T?=
 =?us-ascii?Q?cu+h+ZIJiVm/q3u1JaMuBNxVZsjIAMFSOhdMAXEXtYUd36l1kMHX7hashvx+?=
 =?us-ascii?Q?lSNGA7UzWwW5lu/ucjVeoP2VUQMDXvDgbjjfIw/H+FiBYrprfqNNTFKE3RNP?=
 =?us-ascii?Q?PPGXPAwtZvl7aV67aMtAaemTn87TAtdOdRWuCTw2cl9+JGYIEYgWeP3P9LPD?=
 =?us-ascii?Q?Op/4U2oFxZrnqUaYQwXJebGtbbROsOoNB8s2ChyfIBSEId5tb9rVYmHzSyEu?=
 =?us-ascii?Q?A6pXYnV7CBDDtIpP0AlaFBb1I+lixtpKEomU/4cLj/YsXg93yYNdmwliwXcs?=
 =?us-ascii?Q?VFPmPW8lKTvwKIg31iY7MxCZB61Vizcmm5OLLphVapGStXSGhVD+6cpssccI?=
 =?us-ascii?Q?6SruGoPb6OeDS/uFCpV3mj/lsfXc5kLkDebSJQinnJKZ0qHhqr4Q4jBKKgHU?=
 =?us-ascii?Q?wulTwh5Wga5qTwp0mqlhHynQKoSPffHxn9Sf9WEVxzhimht9CWYCo/pGDzbz?=
 =?us-ascii?Q?pQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?igYRT5M3tl7xq4/t18ZCYwfONTGccbIPvuydlCj0QV5p1XD8uvhrw/HkAtPB?=
 =?us-ascii?Q?/dH2jrzDUT8Q1geCB9WTvdMnkWLhJIjztlu3c4IoYI1gJP5h02tVaET/rQxK?=
 =?us-ascii?Q?NX0w7hcmYPtt6+u902J8Pr2J6jHhx4n9DpRejZDYdzbodAZ75kB2/ycPY73Y?=
 =?us-ascii?Q?qxoW7drCkDQrURGT1zoW5aSD0p3eBl6qaTBt7B3+WtXqTf0FE4IunM0FocGn?=
 =?us-ascii?Q?65cWLKmexrhDQZ1emCLv3228qZqMZ0YbM5xHPggZahF1QZ9lzKZafPEb0FuS?=
 =?us-ascii?Q?rASKGiSTICfBx8g4Y2JRE6PfDSVzI3/K1BXCbwfNnkhTl9Xx0S/U+HUdcik6?=
 =?us-ascii?Q?yRj9yQEQpGZiN3ZBfTuXz1pYEhZXCfw3oS2yth9ky3moqIJZgQNqkPOtRGdY?=
 =?us-ascii?Q?DDc6JJpQ0ldSzH3+wK3IXJG87EG7fdoZqip61W8I/lNSgJKlAEFwFzhfzRtU?=
 =?us-ascii?Q?xiwpebSbXYzdo108p/n/hhpKvuOP6vg11g1b1EAlo3cdbLPphrUD7AQvuzuq?=
 =?us-ascii?Q?kgFWxR2P3Q6FT5oTc1gzspURJm5hH5GEbsRERr8kEjenhpCJq/XDxDidf9CY?=
 =?us-ascii?Q?f6jd+ivnq5kesx8PrctWyiO0zAmHfyYovRo/AHVkomdpmf8kjSDgU266V7ns?=
 =?us-ascii?Q?tpMQg309N3SXNuYwWKC/PlGUAt5usXUKLV7ks2igof/RwqWf9tD/RiBlDz1D?=
 =?us-ascii?Q?oSX6slbT+Sm4qxtNTW+VaVvrYakV3AniR72qr3QJDU9tj2l1dbTL/wLr4+Fc?=
 =?us-ascii?Q?Iya5k83ALhz37TrzPqVMCYNxwUncyVuazCzVsv94g2hKfYuLbuLOimpH1a8f?=
 =?us-ascii?Q?jELHh7iqVARziK44qx2x/Mf7xtLFGI6aHIx8OT5hTXuVBF5zOkqD+cBI6Gh+?=
 =?us-ascii?Q?b8y70Xm5YPG+riTDBQ6HHbUkBJ6PPY6yNk9HkCiXrjwE/6McW21tPI/71Kx+?=
 =?us-ascii?Q?9EzQHS5k00rwU59ymtl1c6NkasAr8e66I0tMR3ue3QP9F+4tSZphgIqW40vF?=
 =?us-ascii?Q?hCWawkmWWRecQFmOodFkXxPvyHpds3eU2aMoJQGfZSIojn5ae1w2IqQKNaF1?=
 =?us-ascii?Q?bPXNC9q0o3W3bfpWNLD8CcNs+MFyurum7jXJ+aFTepjSgOilsgG46zdaYYdN?=
 =?us-ascii?Q?M1Fk8G5q/VYeas/3qAS2lCVzfSsBLKoE8fpaKFcRAm2X7hF/AijaA5VCfTZu?=
 =?us-ascii?Q?HlztwCxy52rrqkliV51vKRf6id6o/sQR/i9Xl3j32605ajNp5RQnsfexEhwT?=
 =?us-ascii?Q?WJ9qHkF2aSD7ka3lCBdbiPmDkuMdoJDprn3gcjXg7mnYJDR2ilRpCZCWei2J?=
 =?us-ascii?Q?m1f2p795ZiAjYYJse3mO33BIeIFNQt4g1xG0VqYHwuPcrKNwWM/BFfvyMfkI?=
 =?us-ascii?Q?miIE2Q56bUouRoRNp63IWK9FS6uo3+klKQ1ssEx4WFkL08XtV0LC6l15TxQw?=
 =?us-ascii?Q?CJgNpl8wnbkemxKqsCtcc5MGcd56v8VlfkbcYL64TgBwcnz05KTnqSXgA0lQ?=
 =?us-ascii?Q?8uXypa2uCyORuMPPVt4Pir7qyY0orL2sYVOR4wQCNBGhwsfNZTmT0Cn2Cx7Y?=
 =?us-ascii?Q?fzp93TsOJcG8o286ybbQhHboOcJM4tUnpUAz9A2/NlmiccxeXZ5PUfTUfaLz?=
 =?us-ascii?Q?14CmeQ01jC2QyjaFmjjJcujzJZSwIoZmMUODjfoMKc//aLOdszHLzJuZmpJQ?=
 =?us-ascii?Q?LXQpYrDAarosICWClSTW0XX5blfPN2QTd0iyNMQPOiq1O2gKvRjbUabdP53l?=
 =?us-ascii?Q?dfOPOEWRhwCHPKStOXCNJtS24GENZJs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11797BEC2446EE4F8856833B2EDA3992@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gmhqj0uUqV8FclYizHzh0ld3B6DhkF21I4kjCtcSY2PbGLV5m8ZB24+od+xaEfg3AF1yZoUaDOGmktKOhMegA2+51uOAx0OZvjs+iIqy8V6dovmXXiH9vZoldmQWdFSRvmcHKZk+yNDVURZbugjDubgODjGJGDhpbnwud34lM7jKrYUHsY4619ZkhnLG86VVBV54JqgPBSHzuCr2shXGnowxCSLc/zlPueU6kd2wx4EiwWt1WqRRXlXHp3b7QxsSsD36+zB4NS6CqlobTZLjTSm9uGg0CWdGLxX6coeUJbOvc8W2c5srHA0RIxPvUuKDtF+juuHzA+DS8C3GUpmcq4QcctYAMG57QZ0AREU4HLJr7PAi3HIK6fCFZ2cUnvttMd4qyJtXJwV8gvx/EpeqGUTO4196bD4fQE3RhgomfaA4g/qVpwK/UO6xVyr6oU+R8BRP7MmtLJytFfwCvkwX3kc+oflYH58F3kH2oq+KGC7TvRiw8CJHPid6I8u7KVNQ8whvlHhxxTLiGMMTsQE2ZyG3g6Ee2z2QyPoG8c88WEeTGgQ2hpmUXGpTKbiSvZpYAGwvCMlZwiRsKe+fjFhOBdTnopMaJw629fjFAVEuTnibth+htypW0/MLWC6/MJvR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e79b1b-b487-4f23-754e-08de5be1cf85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2026 07:17:34.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5WsD3C8j39sUCF3Mxn3q0X99krM/gdUCqeiXOMsPryRbCitQzarDomRrmMxirciCIIX15deRVWjsjEc8SOpg3I7OjW6qhRYHoUYSI/+Rqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8834

On Jan 22, 2026 / 14:31, John Pittman wrote:
> This patchset adds the ability to loop within _require_test_dev_sysfs()
> and check multiple sysfs values rather than only one. In older kernels,
> as we've seen in recent testing, its common for sysfs values to be
> missing, so it's good to check these files prior to testing.  We also
> use the new format in block/042 to resolve recently seen failures.

John, thanks for this v2 series. I applied it.=
