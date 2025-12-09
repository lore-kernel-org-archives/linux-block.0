Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858652248A0
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265793; cv=fail; b=PrxFnMmA/m4QVKEfHb/5CsYPTEvL3c1cbZW83gWoh/VvP9meowsMoDikzCHqBaiVPzNT3vTHqGf4WRIGqeqPFXxopcq3c5q0PDuTBXYT/aB2Q2s6QpiuvupA5sfmqjRWkaY0rwHZMVtV4bsfX4vV8kpSaUxsUu+MGERkqt0NrTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265793; c=relaxed/simple;
	bh=z4y3dyM3uS+W2Dor/c4/envoJxPZr5qx4sZVETEfHCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X4BQ//hFptHO/L2fWZw7SN3XhWZQB9p3Jn2v5QyUuyRZp//KWisFVexHVfxViEE8LPZ/u9QYtK15pcmag/EB7upYKYzQAQXjxxzgTpP+Y4hxJY7Jw70DolrbwY8TQr2LxhcZ0IX6/5jV2IJksAbDVItXXLTiYaFcnzNtaVEv8bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V7kz/xvk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VCf766mN; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V7kz/xvk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VCf766mN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765265790; x=1796801790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z4y3dyM3uS+W2Dor/c4/envoJxPZr5qx4sZVETEfHCQ=;
  b=V7kz/xvkZqavw06Tc9U/uoWlyfYqfRBt1+NB+mS5hmfKYUNtG9g+GbtY
   Fhl4hc8tj+vu8g+IPHNbEb4Fd8LBYL1IQDVGzTNLVQ/5iBaoey0jvEAwO
   vMnY7db8GcnK7JzMPa1GaIfXvj5a8/80brIiM8QoHZaTE1XUXKMT7pJbO
   a5HDV3gFvsD7pS2+aBIC5LtkkIKZHSWwAXcADpOpewTh/Kj2Fiy+LyIoU
   2pdD7ZabA+77EXNK7KjEay5rf2PJqCylCGf/2FSy8rRzuwMMQ+9kyNTMN
   v9h9qmEicYLs9255AamDzQCYw5Pr/qRsxT9JSD+fyCDb99tMqKiYOr0NO
   w==;
X-CSE-ConnectionGUID: eDFI43ojSV6mn8KW2QpOSg==
X-CSE-MsgGUID: izbd+pKSR4exT21J77N3sg==
X-IronPort-AV: E=Sophos;i="6.20,260,1758556800"; 
   d="scan'208";a="133517830"
Received: from mail-westcentralusazon11013068.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2025 15:35:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRtbPJQfa8U8HMube0NnY5nBx8fu4FxUVOQW3aODEYDBiP+1rNtRRXRfels51gen6/NSjpP3yzdqfTDwpp1guC8AcY6ksCuY7ENvprX/IAMAE/IJKB4FwQ3L0bnjiNoCtKBisfvBhu7ZK8Ap8PLdYH5FD69azTpaSn9f/6cM2ZIk5wg9t3JWvzGRhB1qd+D2vIPA4zWTzAjsTvfMvEJFeVG9Oq1q8hh13VUQk4roZsYkLgUdYp2vc501ewYXE4UdadLJIRFBFlifIQKz85PzUhjl71qSP2a0Eo0D8yWA/UcPDcS0cdQkBKifd8SDMRmxeMSKPoXqStiOAsvW+5nhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQS6whe8mbx3gn3xCqoVjG7ifaxXpFqrvWq1/071ZBI=;
 b=m0GRZ2L7U8rthJafqqxiz2MlCjLo5wnScOPQALs0KNgTInYv6zYdHDSX2X1M6nJMyeWzQfaSrmU0iZ5GHowujV1NIz0+ag5ZCAqpbOaZaLcwb08KQzdSKh4hlf9wTwXRVmLXmXVT5mUtds/AdMdtwcGtKHSYmUyLIFFaOnGlrwaY6+T4oaVZRqe2vqVizGFMof1xS8DZb1y9Cdzl6uAdHEEd3XpLmikXHHfK5GcSN1x9YtvSin964yVntHZR5OQX09OnBeH+Dpf/HjsB3M7AqYJUp5YZ2B/qxNjywzCPc2stxdmW9x9j85+TOoC67p2f+Q/gKiYGUjJNEQ/+2Ep5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQS6whe8mbx3gn3xCqoVjG7ifaxXpFqrvWq1/071ZBI=;
 b=VCf766mNxR0w8sNdYUpLTNnzFZ9zmwExhXFqijp4bRwNBnASU4jpI9dfsvNlZXDovRSRO1uJpYrOSGFktCPMlzB8LnKIiJTurOWzcts2MwbnZNXl49zAHYGtFTWsCKsD1UBzuErZTtH+lKe5oS0tvljhbDBh2UOzu+PZAaJ9FPg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CY1PR04MB9761.namprd04.prod.outlook.com (2603:10b6:930:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:35:22 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 07:35:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Li Zhijian <lizhijian@fujitsu.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2] scsi/004: Remove reliance on deprecated
 /proc/scsi/scsi_debug
Thread-Topic: [PATCH blktests v2] scsi/004: Remove reliance on deprecated
 /proc/scsi/scsi_debug
Thread-Index: AQHcZZRwGhavkyIwHkmadFUZt+aytbUSZLcAgAaM2oA=
Date: Tue, 9 Dec 2025 07:35:21 +0000
Message-ID: <bdxp6xep7werxnqhvocwf7dz5sxozio2jo733mnf5tbywz3ays@orqajzwporj7>
References: <20251205031053.624317-1-lizhijian@fujitsu.com>
 <08b497a7-4b05-4282-809f-bf9e2d6f1e22@acm.org>
In-Reply-To: <08b497a7-4b05-4282-809f-bf9e2d6f1e22@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CY1PR04MB9761:EE_
x-ms-office365-filtering-correlation-id: 34bf7b07-3067-4f99-eef7-08de36f58261
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QwRNnwHfQcdKcCstCgu8M2tTHWa4EzBj+u/hsQCEZ9j4Vza9zcJvSVPhTV4/?=
 =?us-ascii?Q?vxgMlAHrH8gvj1FJ2hlZUbphb2s+pZjf3+YzBiqTWBKchXGf9WQYbGBgJXoZ?=
 =?us-ascii?Q?QGRf8QXq1LMORXy5L2A5CAlcr6v0fPbxFGQMZVknaGLciZsk0BMUaY6c7GbS?=
 =?us-ascii?Q?vyE7MrZ6XgzqvPzFrGu4BxIF/6jTNKK7t5odQvMix6C9mupGskfrwbwhfLRp?=
 =?us-ascii?Q?vjdT7PGO1GDEDRrI+fZiPo355tV8x8RqH68wgIwWSqxkdchaTPPz5Mi/kOrN?=
 =?us-ascii?Q?o+gkK9PGdWkV4DQAks1JsDGmnFg1PISutXfBqd70aFjXjKBFeo/XrsVtbkRu?=
 =?us-ascii?Q?mAR430fGq+c8zAEEKEm2V/hhdCrlTTfKE486oCgQjbDWEL4Dw0QdaQk2soIn?=
 =?us-ascii?Q?5CCjxlGNyxoVluNg0iRsyrshfd3SLTXIs43IEROQ7p/hyA6HUXO1Ruu6lrM9?=
 =?us-ascii?Q?shs/2w+6sIE7gsvONANpra5iau/lBtcZ8sQXHSZsi7pO5zTOzG/OV3H0ExTz?=
 =?us-ascii?Q?ODCN4j+rOKMVtOGnZGlHU4P2XjPFHgLwtBCdxNVh2NPf7QdkmZyVFK6KD71O?=
 =?us-ascii?Q?W9XgxRLliBpEVGHTAhoNXl79larJkhQkUr3tnbxfHz3gaYbUnWwEKync4c3n?=
 =?us-ascii?Q?tcn1UoQDFMnLKgFqdGvwwzhj5fBBLopRj6yHlZg7E8GNQTvCcUUeTNe33pVV?=
 =?us-ascii?Q?Jfjk0He6ztlB9RjXZS1Dpzvya9tOLlMpLs4NdbxinfwRmuSZLaLGYd5uIVBr?=
 =?us-ascii?Q?tuyWG33ex7mULgVb489M28NJFHo/VrKqQ59Tjnf2ax73f+LeDBlk1TNDPDQz?=
 =?us-ascii?Q?BCxtwn5o1/PMmqi5l6HY4T5Ed3jDk1tr1kiKSe2J31YBMMF4owJPQoUDpJzJ?=
 =?us-ascii?Q?3xUrCsQMVg87TvCkzRJy+NHDhvd6VoZx4GyoSKqA7HD+5c3T/UQIUffGfP1H?=
 =?us-ascii?Q?O3bij0ryvqcvUvmcNn3lbTTGp92SLBhlDSsjJgsj6I5yeFQ96g59VmscJUq0?=
 =?us-ascii?Q?WMwUG9QqKJeVEsNdqFXUBrXX/ms+kgA0VjBYZvP9DDYv/zKQHkIyUyQFeMRU?=
 =?us-ascii?Q?7Nl07ieYvDKYbXHDnMh76AGEqMM1zODVjwUzSa68rasPZd0eVA7MgQ5maeFp?=
 =?us-ascii?Q?FtjHn+uuoVlyXQMTdFCXOvKGDI7E8HgSFapMtp5TWfYuZyaUd3rOhEMvelFp?=
 =?us-ascii?Q?8BQul4FUhR2kXWC7/ixNwCI+SgRBPYcoTqoqyt6A9mY7mVH/XyGb1Lov1e4x?=
 =?us-ascii?Q?wZ0YaKS4r9yGQAFb8QFoFB9zW8juFEjdbFX/1SCZWIlhCg0uKosCwo9AUGdO?=
 =?us-ascii?Q?56sYz9cMujFvZnUzgQcga0mtGyAgMufKcsMBTT/IdI8/IvWEdM++/lKgBapJ?=
 =?us-ascii?Q?3iCukPQ4EiLhJ+hz4jAr7x6co4LC6Dwi/HA0XCXkd1/krmFROMXeXpFCower?=
 =?us-ascii?Q?P1xlS5n+DetdrtrgoXW10qMM6019p1wAoSycpLd/6hpgY+Xterf7M/VVoQDg?=
 =?us-ascii?Q?uwjFafEoo+2mSWQsF8hhXkvW7zg2kaHl2OEe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wkrmSVnerUq/cbO/s16mJ2AI2bfyZxEr3jMatQCwmbGagI2VsBYQ7d66pyAH?=
 =?us-ascii?Q?hspPxP5wpuyks9kIxp0Cu4s6X3wMyIiLPd6k+BMZcbsGaCkpRed2gPrOW4Uy?=
 =?us-ascii?Q?YS+iBOknPWh4wNhMGEiL0jsjGVPA/vuBzCrEufCwyTazT73t8PcxPgTqDtDC?=
 =?us-ascii?Q?nUzPtIp2x/mRvbyYaYRMs4WXcQEke5YVNbCzv4aoedvGpO4H23237Ehgt3jI?=
 =?us-ascii?Q?zg5IjWJxi6v+cdNuVie0zfhDIyxX8cHP/EgsE9L/SYtvQep2PQHk6uGHB5Mc?=
 =?us-ascii?Q?IPcmFzRK8HN+Z4oErxZ5R9lX9PslSQerAacfcSLsImLDMKkGajDZi5V8v2Ao?=
 =?us-ascii?Q?/gRW5l4UPGCKZZncJApsTjNF5S5CogCpXgICYzSYCFm4FQESdIhVLfCHaBRn?=
 =?us-ascii?Q?U5KXVtOc0dwv7Gux/O5bA+JonIRhf0ExcHxu+5kEdeXRsUJJJQP1lswNEk29?=
 =?us-ascii?Q?BE9YdTmm4HppNsMGsF6Zh3QBOzwMzLmEfI5igv9IPXtQTW713GsGNnZo2Phe?=
 =?us-ascii?Q?5WdcKICXB7vRDQqWhKkoL4ZqMRPXHtuVJAADJfxm5tTy3HNDiMvF/lKxE8U1?=
 =?us-ascii?Q?2qjbvcQXGK0Vfj4Zz3JWmXj9Tzni1jrEgINn5PoHBRQ2T5NeiWy1XOjzYrp5?=
 =?us-ascii?Q?cEC8+1ajF7c+oI++N+LFtOJPIjyUDwmJHBEnWYldG4xSMnkyNOYe6BTTRXGN?=
 =?us-ascii?Q?dFWt3WPo3+Ak3svHv7mFcBPA67TyxD9n0+ztcaDmydciCyUicAAftZvbKzze?=
 =?us-ascii?Q?+lETf53rQf2gIQYkfNDjtZtiF8AdzrdNLrD19gk4uTRqKIJYuBQCM1x1lKVY?=
 =?us-ascii?Q?QIRw+eKP8+hSIGSKGd7a6SqZC7k4gdUou/GeyU+RLCa3Y3FRJftXrsAuRzky?=
 =?us-ascii?Q?a/G8UDnQpyynEZKtOFp38CVP1Xk1ovBPf1Oy7v5GrXEzW2ZlU1mWqytLZVBi?=
 =?us-ascii?Q?wl2m7q7VJoB3cEzZ7fXMOkGnLSAy0AGcQJ26pbpPzn9168TyRVAVDF9p3Gp3?=
 =?us-ascii?Q?6/wBgwkdB5HRC4nCHRrLrasmJKNvYNAO/UUlOf21ORaK+FbYBOtkRmxr8ono?=
 =?us-ascii?Q?e6JF+/ZIesJgHM/nfCJ2yiw8ot5gOvBZ+nAm4uyDDyTqjrVwUgHn6CfRmovZ?=
 =?us-ascii?Q?+h8gP37OdOR70rzG6oko9XTyp5/B0WRiwInLSpxpmObbyuQpMMxoeYEHfNtl?=
 =?us-ascii?Q?EauDWgiybrwAEM6iMBcLiD5TwCwOrvOQQ40W5vTt0lGavzPx04NX8RbqwEAL?=
 =?us-ascii?Q?by1JktZRmhJIa4FvePEapy5RXVumlXFDbcJeME1Tx//YhkCdmlx+d7cpYyrH?=
 =?us-ascii?Q?LVBBt7mOX1KCALZTxOR/CVzGAcP0Cm8xrEAxP5rdYqdaBYDOaZt5O2ueoWgB?=
 =?us-ascii?Q?TTDoxNR6CMKPxMTjkh3ZnQdECHXraGv33R3Yfq26hz0VcByGbiDs8JKwlExs?=
 =?us-ascii?Q?UigWV1jrJFEOapw/dxD4YOqhkGmIuAniSE7uVHdgqVBT0bHpvErEuPZmo9C9?=
 =?us-ascii?Q?NuxhT+eGBEdZTSkxmQp5twuPavPTP/AYHGCK0cPzTm37ldf3hCEpuA2RmCsY?=
 =?us-ascii?Q?6HLLG/W65+9kBNIrEnGdUBE+VuexcVp1kbAc3uiPMGWPnm7X/s41tFW4P2Dj?=
 =?us-ascii?Q?qmAd2xPAISkhynfeswgdbd4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D2193D8B0C764488BA05EE398C8B33C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6/bYmy0ghEFKeLf/ooW8Laeg4/zHiCeo86Ih2tQR/pjuV73jLArTsOwi1YhR0F6KRuxYP+OjUl+OtdlLhD4YdtK4j7HivqA5feDGeyGNP4fMw8b0Vt3nE2m02kwCkb0xo4bsdJMtV0zfhrupRwHnWoiVu7uNHODX/i4lNbXuSF8XKqTrvFWr9NZ6qM1/qt+CLb+6xVqogoMOnkeY3xQ1JT3rNvhSENGTOPWZlMYEbm6Nzp6dIoWiYLLN5giwiIIdJCgfB8ectlL1JIXRAdfymW8ZMnAa7iEclX1qKL/Dxg8n4lylsSwmNTOp/5EclPAj/Gqnz7ZFwYdv2H1aFKcMQUzIyNNAUEhDqe6l0U7LXLwl4VBQk82l4RHiZHr7tXIGMsxv9Kg5m+dlSg1JJDeZfXIruFvudLXx2Ph7mtnzHWz51YBVTK3BAsnluuImCjvBPljGxfaOfBucPWUhkGGRp9D57wT7VxdPwdjnmXSYsuysHWaO3+1ItOIKttmst3IHGrOs0+8CJaeEpqylmQ+pWAoZ5HuCc/bv39CsrsuyB/tEEMiwaPRZNFoeAuT/kAwcYqgzMX3SEnIwk95r+vpxD77o9PqgpIk1ayGrw/hlv0gwwS1QzewKzvVBLLYuH8Xc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bf7b07-3067-4f99-eef7-08de36f58261
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 07:35:21.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFMiHykqb+04y9eSnGkEHnCBVKsVCCbrqcHZtOuauqNj0P7qdik70MvBpHA8DbaZ0NhYpa/GDzM+utJ0AGsfJQa/e0DYBN/2OlJdg+9wvZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9761

On Dec 04, 2025 / 17:33, Bart Van Assche wrote:
> On 12/4/25 5:10 PM, Li Zhijian wrote:
> > diff --git a/tests/scsi/004 b/tests/scsi/004
> > index 7d0af54..72c9663 100755
> > --- a/tests/scsi/004
> > +++ b/tests/scsi/004
> > @@ -39,9 +39,9 @@ test() {
> >   	# stop injection
> >   	echo 0 > /sys/bus/pseudo/drivers/scsi_debug/opts
> >   	# dd closing SCSI disk causes implicit TUR also being delayed once
> > -	while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBU=
G_HOSTS[0]}"; do
> > -		sleep 1
> > -	done
> > +	# Remove the SCSI host to ensure all the pending I/O has finished.
> > +	host_cnt=3D$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
> > +	echo -"$host_cnt" > /sys/bus/pseudo/drivers/scsi_debug/add_host
> >   	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
> >   	_exit_scsi_debug
>=20
> Although this change looks fine to me, it probably is more complicated
> than needed. Writing a negative number into the scsi_debug add_host
> attribute that is larger than the number of hosts works fine so the
> following should be sufficient:
>=20
> echo -9999 > /sys/bus/pseudo/drivers/scsi_debug/add_host

That is an option, but I think Li's way is clear enough. I have applied the
patch as it is. Li, Bart, Hannes, thank you for your efforts.
