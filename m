Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03D2264A7
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952339; cv=fail; b=tDDZ/HinGa71PVWvn55omXnT04uYSWtLRgsqTIUpyZR4LVuvfkSQe32PdHb5ozytVZjOxrwd5fk8dG1tolBfxrHraSumqU7bCFA86fl0yD8FrkzIr4/ko6Xz9loP77miZr+NctkgRzMKLMMJxxvX3BUbciVxR2+5NenggaHD/+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952339; c=relaxed/simple;
	bh=b63IaNPdGZDy/Ct10rnmgsh6R3BouLs8osMw8vUSLUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRTE0A/fbOquxJ4RbBa6n7wubw4VoAUr3YmFgZ7yW+JNj7/ZGJfpfES16Fr53B4av0QOPwXnq/WNOj/z6ZB0fwXZ/iymC3xpoE39NcsNTSGDVEb1Lm6cof9bu7L81n5tMcGq0eMOHjMhRTEOgQYFIH2pUuX3m1p+x3KG8Ec7SKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J0lghq3/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OYMlAVnP; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J0lghq3/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OYMlAVnP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786952338; x=1818488338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b63IaNPdGZDy/Ct10rnmgsh6R3BouLs8osMw8vUSLUM=;
  b=J0lghq3/ojDx4o0D8ehWVdhQrB65FmCwAR4DVuHdr1JEbEJH17hTLwB3
   pMssUwMvAPAPHJICGW3OBkkQpXweJsHeRltIEo7JQALiSpi4OvTq2D8jP
   AYeVfoJWKNf5SFGjGc2a6Nm7vBUhZ8Ilho7r2qml9Nd3Bh2eMfIcWpATW
   JuPBiys7R3JDEXNMVHks7shLu8uun1CegwDhh+e/QCKLAtP2FSMUyeoih
   jB9R6gsZF2+yE+yUnldbVDaCcWU4VkR0skJyaTHGJ64biLARlr3v5Tk5Q
   TV1xI+Bzv3hutFcbaVGqv7byycVqInSne7OYpaAbN0M/nQ9ZpQ7YT4+dX
   g==;
X-CSE-ConnectionGUID: gp0WZHbeQ3mK4MOb+Q6OPQ==
X-CSE-MsgGUID: pb4rBTphSBCLIqyHdd0O0w==
X-IronPort-AV: E=Sophos;i="6.25,228,1779120000"; 
   d="scan'208";a="152353995"
Received: from mail-westus3azon11010060.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2026 15:38:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhdCwmLQ7YU5Bwx/REIQKcpM1uDtVAj1D3QHpz4RQ4OF8jnZQoYmnI1sfYG6//suLNpt1iQypBJRhf1hsaA3chKZ5prsWfGpdA4tOHUX5tq0wowKF+z7257V7qeAB94vstQJz5GJABB+v3wIONPQ7cC1dF3BN2D4gLqEOsoEZIXlqW659SNNnuEvfywqu3ZVGaavVQ9XtJOLTSqcyFidCtzTUFpIFxNqGFotZFztJlCv4KolsBUbhNyxYcVX1BjV2nZTwvx0mNOLS1Ippfvu+7OWL0SZKmRw+yWoEx/EFV5kWRstse2li6pGAMlwZJQOD5PvgNyDUMOp/po7oiAzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXuj1u/pGsl8hyYVBJsBnHAqg36CqLyWU5rcdX0q958=;
 b=JIRm5LDTg1lGMgxM+MbySc41sZG7RNwVkrg20DZmJAYh41GQe+bbgBRuR8Bp28BvGnRZvbc4b2ruvngXEp7V5dr03ivkLmsLfruQeBJFcYbmVImrGRqFIgcvx+DjosHzFKEKz741Q2WSSA9j+QwsBYQjqFrNlvI8Q9T7jNebW8WiNQuaXwqADk/ho0o4zVfoMIfG9II8yIoBSpdZZ68hQ47dyDjir3XQ4RE/a885GhT6EZSOIFPmqLN4Cb2i0XHOD0aEB3SMwmOVZnuedmjJbNq0rLunsa6EMzkA6SEcMkOwTdE7MI19FXwI/q51v68KZp7nnS4dp20fYz3vBPSBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXuj1u/pGsl8hyYVBJsBnHAqg36CqLyWU5rcdX0q958=;
 b=OYMlAVnPGYajlRlBtZ+1WdWj4l1eVuSusMniGjuwcB/RbMG9bxBLvv+UzREFHeyOfkdWAZuSjP9se2B1T+0lZSRl0b9ZTmqzGbN8NrOlvaHSlBBhxfs+O/v0y7JbI8bZhn4hVU73lc8POENu5VqgkHVqMlvInrV2hyU9rH7QIwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by MW4PR04MB7393.namprd04.prod.outlook.com
 (2603:10b6:303:7b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:38:49 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:38:48 +0000
Date: Mon, 17 Aug 2026 16:38:43 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
Message-ID: <aoK5sfNpxIUz7C02@shinhome>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
X-ClientProxiedBy: TYCP301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|MW4PR04MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faaf64f-f164-4860-b4e4-08defc329393
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	DmQ8MyDkj5VpqljMDzf+kGca/Hl5pLYdxybSUjBNLL8c5b1//k+oALoejNud0uJ+juQQsi8JiGdrsdt1HADyyvSElX57GtmDyh94Klmj9g0Nw7ldILTy9R40Y/sNtCOhxSiexYdNaOp8X2aa+AGZWwsTwHG66Z1azx4sqqPAnNzZ0nks8o1Lr+nQQ+ViJjykp2T4V/p3C9IKneiYD41zV5tuEo4SZClja9570jurn22J/btle+oyLN5yOiD03G72wdwEaLFTNLK/oMpXmu1Hy2+M6bl1Dxt8/PC56QnrnHltG3WmtOa4d6VUX6fM5kZ6qd/59AkvDuyNTKEcwR2jcne6UdBdmmdMRCQ9k0kJPEaPO05USE7j22T1FzV7jFBzpCWiNV/45bVCSjnX+I8RPns+4IGjNnMtYhAZRzv2H0Wt47hW9EerKlXyAhXmprYExfz2qJL6mMvRuWrAtZ9BwufGK7KGuv/KQOR0/Js6d0X3SfgytyCLC1TlzrXhBcEQ6DCdk7QZLYTM+ZwPGojh2NkjzlXFh98kFa+MaAovbnGjbewKOQ2NOpI2Qtof2myr2oUPhKszRyyAIW3fd8h53o6Xdqo9/aT9JtSyRg6bLZJBYNrr/Rx6TZsfNNa8JP3G+UTOI1UkReyVpuXbA3D56BVG5vByWwBVEB55mGwjXUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E46XBnxJkveY2yG7citNM0+2h01+WSfsmKElx6PWMAkNk5S2ssz17YyLpwjF?=
 =?us-ascii?Q?3yXCe0ghOSVp1j/ad9Mujpm0OApjSFNIOUvhu1qEBq2aSENJ0evs8urmrUZS?=
 =?us-ascii?Q?2LjejfcqS0RPezvhAAHfqR0dIe98IDVMCDnxETAR/wRxYbwo5bo9bKzBSWfO?=
 =?us-ascii?Q?Pv1jGL0kJNRD4KGFkJnDJXR8p2ABSnRPcD59fA6GO1Sw9CQBYaX+KcYWWsqa?=
 =?us-ascii?Q?Pd2opqcE5zH0GDmAMwGKrGcNuA9ZTUg69WlSxKNAz+VTo5oPGDzBFtwU61Nw?=
 =?us-ascii?Q?N01flAcA/pTGng4kLTeR6W9vwp/sgIPoqgJc0I1KZQhgMR6b302rBrWrp7mw?=
 =?us-ascii?Q?TUJAlqtYaZms0Bzi5+WXlcJ+PhMzI+I2u2xzbKxYZpV6vIPAxkfsKurXAL7S?=
 =?us-ascii?Q?J1bZnugEkemey3VMhE5PyqQN2BqIVMU1Q4p1YjN+J5OK999mXzvGmQaZwY0c?=
 =?us-ascii?Q?nzj1TSqcTsQpb0g4bucsOPrfhcX4mQLP775uxSqiZg4o4n/gG2GR3lkLJ8cT?=
 =?us-ascii?Q?Gki1pQ0NquCRCZ58K2Tar4by4xOepybRq0gvfyvMikf8nddesVav5vxSd9xS?=
 =?us-ascii?Q?pDUA7V0qr6BMONoCxbCuQ5Igk8YoHYYeM775UN7GJBty3AWmQC+mStVs1/ox?=
 =?us-ascii?Q?C7sJ1I8QQCF9AUKzCUpSWHlgT5m1QcwGP8RO3SKe7mqIFbalJ4dLsv2/jaHr?=
 =?us-ascii?Q?iHfIE05tQtiA66lM6+gFH7EKC/P3RyS3kkTnvOXIKtab4XAG5lLZG2r737zB?=
 =?us-ascii?Q?Rg1WmcdkMpLWPAbgcvlBfPQQ2cbgf/ujymPmeyqcgouR2qGNz0jUkePnME2E?=
 =?us-ascii?Q?7MJqDEl5Rk5R5EJ+ZHSIKfSPLmvthEdaLdy0OJPFl2Gs9R3es5+SaHKtlnQJ?=
 =?us-ascii?Q?STbQ8/YEJZv5+2ufo3L5GUIAkmh5wmu92+CAqCMwEf7cF1DYW1/ViM+T/P1A?=
 =?us-ascii?Q?gApfea9a3+jq762mIiYhzWfdML5eUd1v0eSV1FxN+zpcyTzn8Vy5v6Zd64o0?=
 =?us-ascii?Q?rOeyNj/P4OBfgItS3LQMuFhXmFGCBHy0JKNa1CD2RzkfKloycMGNZ5CqXT10?=
 =?us-ascii?Q?Jl70NNZVN4fSjTJQLMP5+3XePRUdUIjc3LyUYkUDe3s9NsreTrNP406HKKU+?=
 =?us-ascii?Q?V9YPxQTLpqzqf3T184sg6hSsMFGocAR9JqQILAmq+rYrRXukydUxaxW6D1eZ?=
 =?us-ascii?Q?qf4XktzZkFynv4NnVKn3nLh7/xyAHqYai52eE5WT1NEZ/uYpg9bQEZXiN6Y/?=
 =?us-ascii?Q?u86yk5SZfFuu533GOK5FMMMGuPjoo6TXOylYzqsDVCp5o11BOdZI3iHqdehH?=
 =?us-ascii?Q?7YfPcKpmVNLiuAtbaYL6C1rmw/wYlgv/0W8uTp4Mystu/GNQJoDKCy0yyv6c?=
 =?us-ascii?Q?PUGGL1dK7saL1glJ4m++NIVi0BzBgF+m4dyo3N0QlJ9KyJ1DIqdQp2htLEkL?=
 =?us-ascii?Q?ZxwFBAF1Dv4LQ7HUu2SY7xZ5PiXVT0qT8hhEe+AsSAHErcnzsUe0Y7gSflR9?=
 =?us-ascii?Q?/aFp/kGGtWsw0o/Mp+cxIUTt1uG+1BYAbgoEBgFhV3mdtWV0+WozCKYNPir1?=
 =?us-ascii?Q?IIgyFv3wZp9bCSgpmZbtfeiALxWNDhZq3xwnL21HF9HoMijs2fNvblVW8pa5?=
 =?us-ascii?Q?PyJw8g6yiEwiG3vbJMWxC9c85/qZsBOcJStOciGp1SUrrKkt26WB13ULYgIY?=
 =?us-ascii?Q?OBBJqBHMizVb2Mmbbcr7lzPHbIjJpGuoBUeDjfiV0BYXilBH2kL0tkS/BlLj?=
 =?us-ascii?Q?SIZhCXixPkMq0oLF6ztg+0J5xsy58os=3D?=
X-Exchange-RoutingPolicyChecked:
	oEG62K/e6BDR6XuEhwfQ58b0qpPfov/5cJzadcN9rPc0dOWZyhrImThHDLk89t6JiFEIlhoH504oTg7s5WS8vL++cKnkX76co9/Oeotw4+46YO8yCYan0Q/t344XkS5QhiEGYwwshQNo9Z3IkLr26cypl7hRNPY5U1o+4F5R5samtK+RhPQHghePJxQ5s3kOlE+QY9qoIhiQBv7ksK4j4vFxpyEvCn/w5tJbeJs3s0xHSLdPYUqMM7PC2Z35/qpKOx/AnBdDOv2gLM9Uh77ukSlIDZ0YQzI26yysjOg7COoiySqGZ274vFSdlcVMEOaVBiFp2KFxKX3LRe4iuDcqCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pU98zzvVYn9as+HK49ky02zEPbDvk5Th5TA8HncLyDlew9de+29sjavE/YUPiRhszXQr/L07pj8Blsua9UEN41GU14TMLPktawFEVVUzzeF6S1bRvboDvgtn2K9x88KqAsB+zOBwLAasNIUMADfposwid1xmgxEdKeO+UlCRrGCvkGzZtVhMEBz+DW+VVHXovCFQo6ndytmuW1ixUMhesoBc7JbFYHfIM7zoAkXXd6CQQf/PrmFyPDGlvFtd8EeaaWk06OZnUFjoYFrW0tBzDaPKhOwIED//dwPO9FW3ZZvcPj5H+ZpNK14Iquv61FZ+zEI6C5iie+6uiDsTRfSeP5TOWEJMY3Ut88cxVzGA3cAeL8E73ojGOez/WNXnJ3iVs5AKjAzkpamaWwrjP30gyHTmOXm6kQkB2csBLcwUSXgkbJ5cUQy0hl/jxA5u4uoQ2dU2XhfxJxb4FPa0VpxvQGQpE8L8smWSvMbE7eGlAcPFfnIBVPbpA7N7sz+q7AUk16MFDkrb04Ugg2j4S2zFdigBtaKFh+BY9/QsTx+wlbKkzQG7HWDwVhuS/f8XbcTV5F9r8piAvoKvKe3BYY5FWgZzd9fuoCK99ADmq6VXnPNAX+u3VgMhm99xm64Kaks1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faaf64f-f164-4860-b4e4-08defc329393
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:38:48.8680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLkhYrRvltm+v9wkbOeAypCVoeGpHHXDnTUfw/TnGFYzN8JvshiX6Cuk0PaOneLez+k1U0CqPRoZk8PpQrVofKUD1JznnGPmBXIXhuSyXoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7393

On Aug 14, 2026 / 10:18, Jesse Taube wrote:
...
> > I applied the series on top of v7.2-rc7 kernel. Then I ran the test case added
> > by this blktests series and observed the failurea below:
> >
> > nvme/070 (tr=fc) (test nvme-fc marginal path handling)       [failed]
> >     runtime  33.581s  ...  33.028s
> >     --- tests/nvme/070.out      2026-08-14 12:03:21.338000000 +0900
> >     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad       2026-08-14 20:17:04.731000000 +0900
> >     @@ -2,7 +2,8 @@
> >      Starting background I/O
> >      Testing iopolicy: numa
> >      Changing FC links to online
> >     -Set all online: pass
> >     +No FC ports are being used, expected atleast one in use when all are online in numa mode.
> >     +Set all online: fail
> >      One host marginal: pass
> >     ...
> >     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
> >
> > Is this failure expected?
> 
> No. I can't reproduce the issue either.
> Does this happen consistently?

Yes, it happnes always I run the test case. After I rebased to v7.2 kernel, it
shows a bit different message:

nvme/070 (tr=fc) (test nvme-fc marginal path handling)       [failed]
    runtime  37.200s  ...  38.926s
    --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad       2026-08-17 16:34:17.997000000 +0900
    @@ -3,10 +3,14 @@
     Testing iopolicy: numa
     Changing FC links to online
     Set all online: pass
    -One host marginal: pass
    +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is being used, expected no use.
    +One host marginal: fail
     All marginal: pass
    ...
    (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)

> Maybe the links are still connecting?

Should I try to add some sleeps in the test script? If so, could you suggest
where to put the sleeps?

If it helps, I will share the kernel config I use. If you want it, please let
me know.
