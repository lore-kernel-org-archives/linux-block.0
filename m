Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57453A4F4A
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286468; cv=fail; b=hXL9UIJaErqUB/GREAYw5rGk8UoOyUbR4cyFJAJMZDMbKt8sIgIBa0mwf+S7J9dX9eP7A5hdlz1FCgfk634CminSPrxd9YvLio+xjyXdhWQelXtZqUCSxXyzf7QSmaj/PnUz1GnArDnuZO/v23obz/RyPE2z2OU02TqbpQJMFzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286468; c=relaxed/simple;
	bh=1zfCD+KLxtdA7lC4RwnPsusJBixRWbE8SfHzTy8Guu8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5pzKmxYwq/efS0qSzB5ZPlbljd9onUN2sR4T3eiDhFP+vMgHpexPBJHWfoF6xNQ+oCX2QpRgWudGdOrAXSXwm6LRt2eMFqYfbtOrXTPEx8jgVLw23lXb091aTwRQFyvRMetoW2ZKDh4pZQLqs9aZMtNQ9KYFFww1X9lHeqTUlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e6+muNF4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OR83Z1Gf; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e6+muNF4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OR83Z1Gf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770286465; x=1801822465;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=1zfCD+KLxtdA7lC4RwnPsusJBixRWbE8SfHzTy8Guu8=;
  b=e6+muNF4vOerVrBL1x0WNzi4E2XOaLXfr26gBJabAYnrvzVedK722syf
   sY8P0wEsNo5J00umOM5Q4Lru4VCkTbAN9KRgkAte8vHNgDP4orBwv6W16
   66fy0kKyS90Lm/vtRD6CqMBFcd0ppsb+oC4iBhfukQj5dev5vRJIC8tdw
   4dy5gVQaWb6uC5H/jUgshNa89zNQd44Hy3phwpJVSPN6XBYX1nVI7WUGq
   mJ+ls/y/W59c51pNC3sVEiyiCTmCnFxDEWsdMpw54+V8OIvwAFwLptjV+
   ITMt2hkfmcR4f/B/+4VrtK4TmIr+Pa95L/rJskopB9aDqavzeTQwf/dkX
   Q==;
X-CSE-ConnectionGUID: DPpnxpYyREmwNCCpXk4y+g==
X-CSE-MsgGUID: ekouW+mYRrybUvF7amCOIA==
X-IronPort-AV: E=Sophos;i="6.21,274,1763395200"; 
   d="scan'208";a="141314995"
Received: from mail-southcentralusazon11013026.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.26])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2026 18:14:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnHs04w4kOxykQW+5HMWR6rRFLt2JYVEmsTr0YPf5c2t2biAZCCBiMvtk8Dap00++DX/E9+ex59lTOuvH45PyQP4SfddC7yP+3LNw8moSULbPgmm4AZ2Jo9vGdE6tA9Mk2FebgR2NJxk+Xmkj28deL9AD8rModjZhHCpZOfDHE95qweM2Nr4IdEy+m5c+ZlaS+2cyxWKwOYXk2/ldLkmvZ8DMJZ36LWEOOTwXCqQ0UrpBSoQ8FbAtKuATrKO8eGch+XO/cJO9s/qAuOK89RCr1+TMD+7v+AIQuETr5tDe/6Qo6qRjd4/mG1kZ/jxpYC/+ITec+OQKW3qLtr6naojBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKXzYjrwZy0HqcapLn1ZBdrOc1wUu3IypRc+ghINjQE=;
 b=X9DOC0ZJOoxOt5c5MDxixY8S5e7UjALHXMAu3DAVc7+8HFpD+HVZyE6nmv14FHG7M9bfKJivdZwEQDjRKg6In9+01CZ0frCfUnN1at/iixN57FXHv/ffTVXveSBrDGDZ24QuOuuwdavaf6oCPhFQiRSkBAawxLh0kb/yYPQIg7lE89UTHHurrCoZwj1X6m5S3ml7fG1qJ3dGF8QxTAmz/A5odRFsucNPZA+Ma9uYbHly0/QQCEm2XygvKAhVfRap2+pcFu/CFSZhXcw6f/X00E+HoJMVDLA0S/I5Yuulj+e0faU9lLMj0GYjC9IJOB7ZScvts0lg2zA6uFmRLslgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKXzYjrwZy0HqcapLn1ZBdrOc1wUu3IypRc+ghINjQE=;
 b=OR83Z1GfOvsYRFcpWJDlmSPzX4k94fPch/OMAxpijW8lsAgkvbnSu/ggLydmNUqyCX9p3ArO3bcbt3pK+T8CXLqOHX8eZTfa2HjFuImXBU9GXMTL+Gsu/pK0hUAdQpwOf/S9cocfYaBfB71cZK7G8c8dnCD4sBOkha2TkLly4zo=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6826.namprd04.prod.outlook.com (2603:10b6:5:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 10:14:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 10:14:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/fio: ignore fio messages about random
 generator selection
Thread-Topic: [PATCH blktests] common/fio: ignore fio messages about random
 generator selection
Thread-Index: AQHcj3S3skyqHcYpn0G3LGEhe5IhbbVz8XCA
Date: Thu, 5 Feb 2026 10:14:16 +0000
Message-ID: <aYRtZtYZcXPUbz-8@shinmob>
References: <20260127100710.383851-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260127100710.383851-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6826:EE_
x-ms-office365-filtering-correlation-id: 41b5cad8-ea94-4e06-cffd-08de649f51fd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uAik3R3GPBbrpNH0l6bNn+AEUYuKNEybgoTBHgh0anmIaTCMcFkTbDX8yWLp?=
 =?us-ascii?Q?98dU26OJFW/vnybNGKPw3d1Ao9AgGvYTmBtCtk/jaHvItiqJ3BKTDeD6YRsJ?=
 =?us-ascii?Q?a0pNxhXvSwCz9W+hqxsLtuRBQJbwm970KzhbSWC6YoMKxK+IO3LfXfdZcUcf?=
 =?us-ascii?Q?gud7dMi8ACZ5GzszL/MoeeM7WCb6D0Yb9Bo0xgCddkYTAgwQfiIkaw9iGuyU?=
 =?us-ascii?Q?9OGaVfeFLM6FEHONlxy9NyY4q88wOt+ZrqYLhyc2/WRR7Y0RJKke/fjTVQt4?=
 =?us-ascii?Q?3qj/HLFakm2LOQ9/aA4SigJG3Lpcot3yIVMSZLS/5Cl+XkfD4WFQfb1sPZZr?=
 =?us-ascii?Q?wBtXLBGO1d1cdOYB6RXhVYxaMkuB/7UqjZsPxARaKMSlcQcyaTG4vvsskBso?=
 =?us-ascii?Q?sZT6hIr15Nx8Rnr8HCEPn+YjdYcmU8QnGEjJdbYCECGexuI9ro0FSvz/nhpn?=
 =?us-ascii?Q?6bQ3+mP1SgpQ+QUOxvUk0tvNObWiin15CAfD8SNsy6NI5t2o+s+LRFC/6XEy?=
 =?us-ascii?Q?eH2rEzxQgjdJwOiSoRdsMLDiYfXVmqVJZTPDXhfqBW7QQaPkr44ug1cjy+Ci?=
 =?us-ascii?Q?QIosDOwikK3PqLJ7oLSSjmh3KDUVllBqS8yEQd0Klw6V/+Ks143CawHJW22R?=
 =?us-ascii?Q?FJVU1E76vxulTsseEy498CZcYlpkmsnC2wF06aOD3xSNNOwpoO07mtxGlfJX?=
 =?us-ascii?Q?su+II50oBTs1pXGmbFRkD4ek6Z9StJaqvdo+xfOz30zlM5bVc5UA1+vp8Tnn?=
 =?us-ascii?Q?zes4tlg0MqVBPf2XUzPqCkjWg6j7gGcp2/ak+54cuSnkj9/bnFrOU1NhNaM/?=
 =?us-ascii?Q?mmshGY1qyFCTkjLM+zvjFHgRnggljibR8HTOknY3l7zygDy5D+1fiHAzUy+T?=
 =?us-ascii?Q?NdZMvS/5zap3LtsJ8zAxcY8Z9vG3arFtKaOzbn4BeYOtnrxmycgSot7LVQJe?=
 =?us-ascii?Q?N3Gk8rAXrE+JjIE7IIsfIK65SLIFN+Zgv+EBERkHyG/DUIUP/saUGclOK92f?=
 =?us-ascii?Q?Ied+gho8Yv+fN3TVhnghxQWn6wTlF6skl9uMjOYA2mCfBw4T8sHYfsP9NNYx?=
 =?us-ascii?Q?66xnBMhRU7xwOD2OV0Cq3H8rZocf2fuu46paoBwLxgsyk5DmRr7Y/b6tqh9S?=
 =?us-ascii?Q?VQS0OErMcFNF+4akM/4nG7JWRjUwJcKlaoTTSbse30WTcoEb9Bhuj4cJSmIH?=
 =?us-ascii?Q?cA6KS2Khio24Fvtp3gqVVDr4hwTnR8SBglKteH8RheaiempYelxPy/AuinJb?=
 =?us-ascii?Q?bT9ITkr0HpA/apVrDdmtPweJIPuODJsC4+b1V6DZNUXptsGDoBX2krZRTueq?=
 =?us-ascii?Q?gOvv9O7MZiY+QDoY3hE96QOHycjumXU595He8GN7yGFvASdZ5/RM1EI181PX?=
 =?us-ascii?Q?JLfAquHjSOjbw5PRTylNoCmWpgk4uxj3mrMJ83P7R/g601X8LDqQpE6CEjia?=
 =?us-ascii?Q?3ka57QZ65yMZU5SErRDigKuYcq9TxWIJLOofmoNsBrYDi3DcCcday0GgydFx?=
 =?us-ascii?Q?TCNFBfMvWfCSNuoMMAJsrtv9b0Vw2ev/h6D8yxbcfnnVlHVb5yfF2qxb3860?=
 =?us-ascii?Q?wFoHAGAEZmnE7HpGGI6uYGQ9G0nNWhgIKm7D54mu09TQCL+gsbgbe2/4pV88?=
 =?us-ascii?Q?/nMopGyp+ZMlzYjc/bk5euQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6gL5+W7+Fm22tjKcys7aa71jzeTzuMYwrzkUXPQZQ3Otp7/1xpL6EZd+mmc/?=
 =?us-ascii?Q?8VrWF0fzVcaa6Z+C9TKmFX+qvSfLoz4Gsy0NOSxSod4biFTqk7sItr0aSdAS?=
 =?us-ascii?Q?R8VXaKAKVx5pxcvnvk4EyiLVHknNkQSkhWE39Z7eI4NqGrVjJqhQwamg5yiq?=
 =?us-ascii?Q?Ut9Ehnba+SDkeYljuJ728ATrwtCRQfkLWz5x+uVOZ+qS9SVuQVZ0br1SnQZw?=
 =?us-ascii?Q?w7tYzLCenD3qyLjuSUOXO1evoFvUpdqRJAGzfaJz5nqf3t8EqvKRhiGaau06?=
 =?us-ascii?Q?mkOQWSIHrBBsyuAyzBjweZZDhRXFhwLecn7mCN/shzpUt/b+dfLW8OVr1kZ8?=
 =?us-ascii?Q?PjVPjLqYq4jbvwie3tY+CUAds0wxTGZNdwTt8c7x1d8kykCG9DhNt9lGzPYx?=
 =?us-ascii?Q?SLTjYncB7ogCQ7v64l/zFTxH6lVzYdS/FP5NVu/yrA0+7AARP/9IY/eKpRj0?=
 =?us-ascii?Q?EzpBTnGzpwQq0Gip4gmgXaAgn3y8s18B9/oF+AIyd2pVL0u5kbdbGXL+Lq/T?=
 =?us-ascii?Q?BuV5cCUX0xtq1TK75oHlGxS1D45L6MWd4OU0UCsE/6W7JF9/SKCIMpaOTrxX?=
 =?us-ascii?Q?7zjT6xB2PetZVniwkHDnICei0zp+Z1YtjFclFjiugfiHEDOKX62fYCrOtTWt?=
 =?us-ascii?Q?EKwDgZAirL+dxTdnX7lk82sN5DpJplNlgArBJ1j/DKh734SQdkplALVk555l?=
 =?us-ascii?Q?8Tg/wneY9d5emIFQAAjCnr3wH5shy9M6Ngbgm3firJNKB8A1RcEjUEUYV71E?=
 =?us-ascii?Q?zfb40A/43YB1lw3ub7Q37AvCNheWthUhbTa0r3n1juhUrUzIe1F6Vrhf0zZh?=
 =?us-ascii?Q?1gg1COg7vadeya7REG/1yK4GHGSyEsUOWD9z3U08ah/Y8v241sbDYRwbrd/g?=
 =?us-ascii?Q?vWHVRMK5RQD97dfD37YYzur8Lv1mmDAMxhQHAlQBzFYd7+P1dF1ZT0B8/W3t?=
 =?us-ascii?Q?CWJ675MeRaTifPDo8MgIgBIF520fTAXt2pkYunDfYoG11Bte8Iacanu8YNVC?=
 =?us-ascii?Q?64ys1ihnq+4cvppcUQO3FbnALj/BdAilbcz3j05P2yV+zxWfD+Mj9cG6B7QT?=
 =?us-ascii?Q?xkFJF6dAywejAhY2XtIHdpLZy4z3fTRgnXUNloPDhECLwrGjN0Rcy1jD0YqB?=
 =?us-ascii?Q?dkiWkzK79TMiMKcqSosi6F4jPcr36tQ7ymQmKUmiAWmYGljcEsy7zdD+g8Gu?=
 =?us-ascii?Q?rKLCUqKvxNSr2uFQdt7/EIiX96zVKgOy59kAuNPdaLCj2vkpQ1G8nBS7nKiR?=
 =?us-ascii?Q?l/NMT4DlvrfOGKLQYd4UUBezITr2jh3KnO3kI0vN9lOYxXgW55CMoGOz7c3V?=
 =?us-ascii?Q?tedvGITIFcRmQMB9UbRNlirEvdiNyFUQcQYj7ifqwYRwYjfG4bzFtFLlQqVX?=
 =?us-ascii?Q?svpvmlbp0J0Os5K66Jj01CEHKDTvCV53IwaAV5LQAAxaJg0B4PJYzT9FyJ36?=
 =?us-ascii?Q?nuRIWUC6ymaxmxrnzvsxjV/iQpfOm816oqvQSNgViVYVYYxb0p8ogBqtI9Wn?=
 =?us-ascii?Q?UaKB44G0sFJDCd07uty91kV0cXvsRUYDQIp29e9AJ+ysnkwnUUCOORqU3jDJ?=
 =?us-ascii?Q?cZf/maWE6qm1t+LJH57mQ4fHM83dUI3fSxo2+kEaswgoa4RLV+I65Nqx52hL?=
 =?us-ascii?Q?uhgHOOnOcLXNYhTRizaMExMTkJql0dfxo3a7sDtNViPxviKl1XZgLOL89s41?=
 =?us-ascii?Q?dnuhCeJxFUh1PWR1NEbE0BIJF6v7qq9XvivlMsYyhOTbAl9LNhzwphpjISfa?=
 =?us-ascii?Q?3eJ0SbC0wVW20Dkh9ZnnumjxUYoforY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE0AEAA9A792C94CABDCF586EE01560E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wXj5IGRtaHNb+6cwkWmtr5CjccoLM4ATYOHJ9b/JoyufKjnVpHMO5abjzhK1lqw726aFHwosynecn8WCjk/OaQPRy7vi922GG7lu7qht/NHePlJ4HBMO3fnzd020d338CmqIY9zKQpp7Yi3nM/VNfhrtaXmgjZshrjSTKmf457BhTDB4dhJ50Dc1FgQWtP2jpjKABo5cSTBtwNTvEY72NSDBkYsFOATO41V5apkAZ0DVgMp+Dep5HuKdkJaZ/gwZIsBAwaEjxNoVf8R8afw46BwltiWPTXgeSMRwi1ANL1wkSphnqAoDlWqZMBoVwfR3lsCdZzo1MynvOwIRyHr9MVTgDiKpNGGP/EBkNDXjKcnQYX9gtcOjpDbp4Z4xGm9EmFSV65U7zQEJ3iGBi29If8NmwCDD8P8U3xfhzbDEDSnVHKwQ3A5ZCLEzPO74hzotrCntKKNHZddSLQkltaHG9XCNoE7sk/HIsscBBaU1Z6gpYvFIifFDWfp7GbhGkgPLTzGTv8R7mqnXskxYywnzGeYX/nwnyje3tdCH0BzPpDx28iqCMEOh4Q7ozz4itvrC8OJFAeIYf+mDqww5ubhKv0tclf95fFYRnhQZME46SmdI5hL7sI2r3h6+dN13928X
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b5cad8-ea94-4e06-cffd-08de649f51fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 10:14:17.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV0ziOdv3854IRZPHQuvS1sigtITVpkscjXiVIfc2nnyofA2JmLULI0tFQTpkbWfFZoZGQuPfSFF52O4KZmckC1ntW8yzUhCNwEsBRMh+08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6826

On Jan 27, 2026 / 19:07, Shin'ichiro Kawasaki wrote:
> The latest fio after the commit 1d282baecd68 ("fio: make sure that child
> process output is comitted") often prints the warning messages about
> random generator selection:
>=20
>     fio: file test.0.0 exceeds 32-bit tausworthe random generator.
>     fio: Switching to tausworthe64. Use the random_generator=3D option to=
 get rid of this warning.
>=20
> This causes fio output parse failure at the test case block/004. To
> avoid the failure, ignore the messages.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=
