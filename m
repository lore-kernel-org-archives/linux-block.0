Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD61F16B
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749787850; cv=fail; b=dDTg1de5hdpdZGERcx9yELoUBatXMPh5KQGk4/hufyKAnYczmvuZe2s16ps/OUX65UD561Ps3xKTSfqjqgE7Cg5FnUZ1rgZ7pA7Qy6MvutiXIynkBnK9c3y2u6QOrHEd7UNXut9KTwXX1FlSjn4SKletrH3sc+LM6d2hmFVNWsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749787850; c=relaxed/simple;
	bh=v3rDYVQHm56LacgSw0onoaJcfzZJL0yNZaYRukLliaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omukMiUqLHoDeheOIm03TOY2uHxyXq2PmaxajffsZcckNeCtanqH91rWgdzVF2s6ijxIG4JI72ShCVSZVFSKTrBgnuZYvHTHuV0k0JIhn0th+sJzKsE5nHSVKhiLzXCqf4gMhEg3V4BpbMAQJ39yuE8dZRCWKyjQdC7DHEeRRCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G6ancFm0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oNO/gDNL; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G6ancFm0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oNO/gDNL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749787848; x=1781323848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v3rDYVQHm56LacgSw0onoaJcfzZJL0yNZaYRukLliaI=;
  b=G6ancFm0OmqNQ3jl2VBwDD/v3MEdCctvDHpsPxjvHhGkxYs2NSa2/Xr4
   kdUUC+wOk3AAnPuJHk7Osuwi7rHjqHbHCyAQQg9B2fnD07M6BNlKTmF7i
   6NEnF0qeDqCUDznSs9E1utGq3GxkPs6uweEsiKhRqf3iG7La/mFADkJ8X
   SeN4UHUS37PLN0gCX9Xaa2fg6kcXFEdCMwVGJByWHpSp9L0dmRlPLCbsW
   i+9Lhr18DRj5zW7R+S8KiYvooKkfBnwRC25/WEaNGGDCtSgr/bPNSqRTT
   s4dZtbOe5C+TgAvMWIEufT5BAxvrkju6UKb8E1qTSEK1HmN9zWOw/UgIl
   A==;
X-CSE-ConnectionGUID: 9izRI1+FQSGKAtzJrgA/kA==
X-CSE-MsgGUID: tUsL+gMESZKtula2XAx3cA==
X-IronPort-AV: E=Sophos;i="6.16,232,1744041600"; 
   d="scan'208";a="83959014"
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.87])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 12:10:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s35fQSDfoaHiW8PteBJpJochjEoZG6dpEA1VSVAsiqH+7ZaLO6+cKp7twdVQ9Oxf/9EOwh6egGF7PX7AL89r8VzVjJK8wZunhWsLIiwSAK6JZp3/eO69ijzmlwmAoP6kIfTIWmX3t7LihWdX9GkvzgnmmOMyIjyP459V3zwZ9UWyH21qWKuUqSkqYqLDElHqIuidD3E11wKXyUzhhFJRSAGP/38NzWGhe1gaBvTnsaeDyvMHL6Rsd6/Lc+uvlp645SYBuDYCNnxLG+3sGS/Ey7cdQoy0Q4C+llB72VZUJJWiPhxWkLrU/GRm8ZS6iQdmr2OOScG1KbG2qOeMQzk10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXiiGDWQsPoPtNBNgIrjT0WGNaVDjkNvC8u2tRalx4o=;
 b=eXW1lYOCLKsKHybkXpC1uNQDdml9lTaJ2bxtFvRHMLqoDOAAr2WojabPVibjWiL5VFLZEIgExgCnBCQP/W7QUgCzmuI2ZVJK3gIr9OfKWK1bBdBHbN0pgBQKYTJcbv6ggZMoYTQF/knDQ5GIc/ZzXE+MfltAItn4ybYGSaOnQtLzsj8NCu4rklZ5pnbAvyndtE/bTnJ5UtS981fRgUK9WIdEyp6c9N6lNi2907R2ab8GSuu32EI+LfZY+OBNiaJ2sTn43zwHGeHh3YJelVoDDYD7T3UxkNgSU3w+BILQZEBN17xQLAqrIrTpW99qQGG7MQuT0cRZMV3ar3cA/j6KLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXiiGDWQsPoPtNBNgIrjT0WGNaVDjkNvC8u2tRalx4o=;
 b=oNO/gDNLjpgV4Zh4fJExKR9VDXx/nZgqkg30gbaTGvsA0+qsQ7GVyt+oni1gmiI7jFnFnI0hV24EtOsi1IfKGdyrkvg+uj5kOCeMphUmqS8YkHTFMrJeWhbIaiWB+AsT8850KgwfMmzCLxISWM1fhufDNop7ZwBK1F6hREvdjLQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN2PR04MB6784.namprd04.prod.outlook.com (2603:10b6:208:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 04:10:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 04:10:37 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Topic: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Index: AQHb03fJCWxsffIFEkOwzl+UxhDZyrPxRfWAgAFSe4CAAEUDgIANrdGA
Date: Fri, 13 Jun 2025 04:10:37 +0000
Message-ID: <jado4qwmaljd3s2pddmofy26t2ytdo2bajs66xvpbilclncvh2@xrnwnvs5jh7a>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
 <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
In-Reply-To: <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN2PR04MB6784:EE_
x-ms-office365-filtering-correlation-id: 6e0618b2-4f5e-464b-91d5-08ddaa3040c6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Jt8X5vPXQ3WrGmerYTOBuh0tuxo/Y9mrel1ZIbkbI+3EAW8D4zEKqGdAz/?=
 =?iso-8859-1?Q?Ixm5ONgLwtxWqFnc45sEkw7JM7MwOB4LYYa7TPLLIyD/n8/JSiQjAiq4mu?=
 =?iso-8859-1?Q?uNkxcOzAhGOlWdbwFLzfL090Z6WzMOkPJ2/LU+kDUYJET2OEw3Q/hfcTF8?=
 =?iso-8859-1?Q?xoA3Z+Hq3RHu3xIsSe5YtgN3kinPsDYlF7KyBoqLjo89nC+q4v5QV/P0+M?=
 =?iso-8859-1?Q?/Akfh4R2DTYEKwq5Bu4Ju83/GUnI4554/aceAh/7CSVRx9mahpQrxBLWDQ?=
 =?iso-8859-1?Q?2fNNkhg0Am4HM5Azj/9d6jZ2sYYVJXP2qJRE8CcShPULr0wdiXhE8Kiyrf?=
 =?iso-8859-1?Q?Dgc/NlbOl+bvbs1RMeVYvQKKIVVENk6MYhylxsBcnca1j4baNL6stvC4VI?=
 =?iso-8859-1?Q?U3Os4FuajiCYcpIAc54HnbMDvSHFIQk+EB5zv/oxhELTyLResnzyBhjol5?=
 =?iso-8859-1?Q?OIsGxLaYq8ES9ckABYXSdDnD81KgkC9+cIgnP4E4ZQWy4DylVLDCWL/7Lp?=
 =?iso-8859-1?Q?ZWgt93dS/5CgOf/FfQ9QQsh9+10cxv4kN1eHPghwfCUfveUyIaAC6TktYR?=
 =?iso-8859-1?Q?7PsRjMq6oRF4VXl2vQGkPdjayUG2dgx07CwMIZ6O5mFeipQ8sdTuT2NUMB?=
 =?iso-8859-1?Q?2pvYb4JTaRFF3b55j4meXSgMhib4S8iBiIVyUC8CUVJsGXtgy7gGvXBLAm?=
 =?iso-8859-1?Q?kw2jrMY0p+j0LtMqEf5xZxOfF6W4oBRtRUgKZhKqg/N9rHMwgKbPkg4h7K?=
 =?iso-8859-1?Q?jk/8b4vEsfuB8TUxQWb85v0Zludqao8FXW13iITZoad24uGvPy0ci0cn8J?=
 =?iso-8859-1?Q?FR1D49BaUM4EIkOSgh5zAesMYr6a9i5dhfypBgz+JL+GAoDBdgJt/d/Iey?=
 =?iso-8859-1?Q?iMChhpMT7i+sbFIazpM4hfKxcAgMsaSkaZPxEaCt9Klv5rAzW2tC769PWv?=
 =?iso-8859-1?Q?84qB8wXQ8nC1ExrhnNtLAQtFkEKJqOziPPVZH5sb0/vRHjSkbkNUmA0LZq?=
 =?iso-8859-1?Q?jseoX0yGbbSngR51skt2R/jovdif2TaId9ydxu/+BBfjD1nuC001afmqwV?=
 =?iso-8859-1?Q?7whwK4RT9r+sQbNYGoDzHB6LEkRSMJiPLEOPN2D/XS/oLro897tmrBr6KB?=
 =?iso-8859-1?Q?aP9UfTsx4DrdlEY5JJLa27B8kNXG5x7Zw/p7kZuAw4o1jB16KhSzYfpxp4?=
 =?iso-8859-1?Q?jmGqciPtiDrwzp+Vx8yFgTwn52Ecv/R62Uz9ZSeKSeVbTZYx9PDfHD0ITv?=
 =?iso-8859-1?Q?ZmR55y8QS6nHPOfydnzrXSMvAt30v8BOiU8BIFP9LMK6SFfVGZN1USkb6e?=
 =?iso-8859-1?Q?4oncxbrRLU9uCYNFaJ0cXHua5GjmBMQ8V0QWmS7hJ8HgBzik2S/qgmgUmx?=
 =?iso-8859-1?Q?D0XsvnAwyvMHUbQMGxlbeO+r4nLW1Rl0gtGYLXiRwm1Ul15wT+KrdbxMih?=
 =?iso-8859-1?Q?5/ZCVw3O7fd1H7yfkeS7sOS71VqqbyLzI+E5tYc2nHX4R/hqyVAxIbz2DO?=
 =?iso-8859-1?Q?dSMr7ml2TQ/mQUfNSE2EYuI2F5H7J3k+uUixaXQ2pKgNrppFnl71gOfCHn?=
 =?iso-8859-1?Q?jTwFeMo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7g96f9lReRE239mgKhmv/ieVG+blGLAmaBX/ZGh7/u1sIknaA+EN8Sy+wQ?=
 =?iso-8859-1?Q?eeirIF45D/x96tklvDdFIMactqiU4/rZTvFcMvsA5SD3RYkpHjghBVW0KQ?=
 =?iso-8859-1?Q?1ArHZAxXFF5IhSfFzRTLzig51VUKyTLooS3YXhiBYGQ6xGMujpisg4ApbJ?=
 =?iso-8859-1?Q?YqDo+44tj+kayidm4eY7bDt5SCdZ7q0PRstFlwk50UwYEGq+mt71WyZx50?=
 =?iso-8859-1?Q?xttn3OuDfIT6hYlVZU0DQkdo0WWBXgVzlhibYW3HySvFdf9wYpZac0URae?=
 =?iso-8859-1?Q?qhF0M7IYlph3C+1pIondOu31iCkw8FClZkOTYYggEBGI6p91SDHUOwoh4j?=
 =?iso-8859-1?Q?GsPEw5YOIcT83N0BsKvWmjE/9W3WbA8gZBS3M6AeDKpxMHlPtHBN5Uyq16?=
 =?iso-8859-1?Q?0jD6lFU3HUBWlEhOWAv3BVYdoLRGhJ4aW+l5vZuphA34pJV9q1zWilSWjT?=
 =?iso-8859-1?Q?cIosqXVM/0utc/t6MQ7fmZGmoyR4mA4b4ED4w1rRUpwAlGflgZE0i7tPDY?=
 =?iso-8859-1?Q?wZA0runM6TVk7vRd2aaG75DdpwlfeTcCVWhTSAWik6JR5xFmxGQtE3h+bQ?=
 =?iso-8859-1?Q?evcRLhWC/WgysB4WgYl/1maia2g7jd8t7FYNkK3Hb+yQ2w2kvvEMaJWpQS?=
 =?iso-8859-1?Q?kz+7g3S9V51N05BOtRxwxvjV1N6/8ni6REHLdWYcteiJRObzpI9KLnKp3V?=
 =?iso-8859-1?Q?bpOQc7FR50psGA9501AsQCik6AsLYebG5jEyU4ClkrE5qR2B7MCXW/9quA?=
 =?iso-8859-1?Q?Rnicha59pJd3LBq0dah+J5/UXgF0s6M8ZAiuTRF2zW7EYfreR6n2w2gaay?=
 =?iso-8859-1?Q?6Rkqla3WlMJ6aOdg60Rc/gpX/f62HmmwnjAS/OGW57UCTe2AVE3ABogAKx?=
 =?iso-8859-1?Q?yuBlN2fnMJJRX3/Gkc8tVljgqsnh6QFmoB9BMQNWr1iuHySUC29S/fCo3s?=
 =?iso-8859-1?Q?8Af3OkRdcR/HP8l3Bb1SZSV1PAh/fxtRlEthXlV74vso08JPpCs4sOVw3t?=
 =?iso-8859-1?Q?+MoQCUssIjBZw3u1UUKwepshrtzLqJLJzKFUXcSxKDhkBYHE1lYZMCE8C4?=
 =?iso-8859-1?Q?1lIH6iptOlxOkf9Veof7TtCoFl3TyLgTAPKBatb3kBhgws+8X28yrzyFjR?=
 =?iso-8859-1?Q?JDhd292+VGWd7m6V9oheUmOhvoWdUG1tGmab3g2Z1weaNqLvreXYxWfsCb?=
 =?iso-8859-1?Q?AGXJ9xEcAyd/xwG2vGGQSTt3Lt8pkz8qeqqxSDOFGxVdQA6taXYcokzgcj?=
 =?iso-8859-1?Q?8d6Aw/rfE53ylZDGC09A5qrx75mTWkuBnzBB3xzWIaBdsIKsra5YHgY6Tk?=
 =?iso-8859-1?Q?dgMYEFozN7sM2VuKCQVg4W9s9yDL0qfMTEt57DQC9JAyLEvqN1O3uGKGJ4?=
 =?iso-8859-1?Q?d5u90qqoakTF2SntTTa2lDNUl2EB1eTmvhIEwGTS3L9EZEnKZoiXyzFuKo?=
 =?iso-8859-1?Q?1idGsPhp9Qz+pcgcG7HDOZGLLraSWJD4f8Wj7mZZgxAkG+PlevfwrpSd3k?=
 =?iso-8859-1?Q?FZq0uB4NpdyOFt/15ylPyawpd/o7VTGMwwBZR3Flewri2TtTdk+ibTBh6x?=
 =?iso-8859-1?Q?sJUJVXAaBVfRsua9BOeTlQd4eU646mtvAsM4ZNu5vZnoISq0LgQj+iTV67?=
 =?iso-8859-1?Q?7kPpdPfeQ3SGkfCYIp2lUgvmc+Lj8c+d5pRXnV33Z4GaHISSNHeaT5q+Fe?=
 =?iso-8859-1?Q?OK/szadUNTQQp/8PlJ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <38FC19AFC7C6B24DA8FAF4047D6DB259@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j6Kk/tHTVQSAURTMPC46UYELd3p2/9MhtISFMwYLOCG2T2gvg9PjLJrvo5dBb9vQZ93D3AQMEcksAtN5kAOXOycKOXIi1+0YEZbnnMaSAW/M6KD476UXbi4odjDDWwuIf6j7gRYR6DskgzQ/8pHqvIxC8Mn+UGkk1/MwqRLW5mgLDmiiIP9AcjGhaa9jhVJn0BSU2+NctvHHRYh09vIm1JgHTJobRiSep2D2l9CzER8eKXjgQxBWDOu4vFaZw2xNhaWYajIqTe7L/3RX0M/uzsXxARxGDCMKZxhcVhO9vH3O+BYyqFXznWLiz+DSEyvigvha1QRdUMwZwCkYnUqL6Yonzl70OA8NLUMTcdlV45K54yAJi8UlVq1WNdJO+D1daC2uNh2GHU8LfXRzGFv3vzUnOz6fAxDntreEkODCLYkzwSOuqCvKMGDg4+3MAKX5lYeSyyih46DZ53KeMqVbSMG9lioa70OjaGe4qax4vf9vt8fBT/tZFd4/u6aP7LWtTWBSm1Fm3TJ07uJz1UGpIcR789Edti9B5WDess+9uyPjSaO/UOVJwv0nvx73LccdQsewPe495YEKUq2bHBNC3KGjZcbHANtAXaGAQbuDPcZ4GHPlzTzccFfPsz2ZDb/f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0618b2-4f5e-464b-91d5-08ddaa3040c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 04:10:37.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVG5ZD9yfAk02Sek6nkEoThs6pc5WThRnbnwcKUjOf3i/qzKKnO4be6lOejP5WJWJ5G0ZMeIxafL5wAgv0K23xyQ+9WnCs1bCNh9qZAjnRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6784

On Jun 04, 2025 / 11:17, Shinichiro Kawasaki wrote:
...
> On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
> ...
> > My preference would be to allow nvme to unquiesce queues that were not
> > previously quiesced (just
> > like it historically was) instead of having to block a controller reset
> > until the scan_work is completed (which
> > is admin I/O dependent, and may get stuck until admin timeout, which ca=
n be
> > changed by the user for 60
> > minutes or something arbitrarily long btw).
> >=20
> > How about something like this patch instead:
> > --
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index c2697db59109..74f3ad16e812 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *=
q)
> > =A0=A0=A0=A0=A0=A0=A0 bool run_queue =3D false;
> >=20
> > =A0=A0=A0=A0=A0=A0=A0 spin_lock_irqsave(&q->queue_lock, flags);
> > -=A0=A0=A0=A0=A0=A0 if (WARN_ON_ONCE(q->quiesce_depth <=3D 0)) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ;
> > +=A0=A0=A0=A0=A0=A0 if (q->quiesce_depth <=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_DEBUG
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "de=
v %s: unquiescing a non-quiesced queue,
> > expected?\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q->=
disk ? q->disk->disk_name : "?", );
> > =A0=A0=A0=A0=A0=A0=A0 } else if (!--q->quiesce_depth) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_queue_flag_clear(QUEU=
E_FLAG_QUIESCED, q);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 run_queue =3D true;
> > --
>=20
> The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
> concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
> ask your comment on the suggestion by Sagi?
>=20
> In case the WARN will be left as it is, blktests can ignore it by adding =
the
> line below to the test case:
>=20
>   DMESG_FILTER=3D"grep --invert-match blk_mq_unquiesce_queue"
>=20
> Said that, I think Sagi's solution will be cleaner.

FYI, I tried to recreate the WARN blk_mq_unquiesce_queue() using the kernel
v6.16-rc1, but it was not recreated. AFAIK, the kernel changes between v6.1=
5 and
v6.16-rc1 do not address the WARN, so I'm guessing the WARN just disappeare=
d
because of timing changes. Anyway, I suggest to put low priority for this
problem. Sagi, Hannes, thanks for your actions.
