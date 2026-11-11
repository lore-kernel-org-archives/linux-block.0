Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794368949;
	b=CPAIZ7N8EzXpWNhRkt+YPH2HwSY2iQcA/246cAFZHPH4fDcdUPJUDiNt0rC6XA3+eZQG
	 SyODE33KjNCF/tecOHw60D4sA+bv+zKXQnid0bCVitGOlGV519Xe+xvo9djk8DeZoz80z
	 MYZMNMYMNL+dUYCrxXxIhnyhp0WIrQwTfZ3O1UrvJELtm598WZHlcbtaYJLkXHmqDUEFn
	 Jjr18jvcfZal886ZW2QQ5HKfmheftq319mnC/XNYTXwn/0G13wPWGA/+tuNpP73TNodd2
	 31NVCgjtOR8EPYndKo3u6zQ4SnFFIPLaw30J6fi28wgf3YrggIAWwQGFeRB8EwH6OpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368949;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4qwK9SPYuI822/6UvNm4FUl7xeTVlxM/3/IhzfU4bBQ=;
	b=ucZtTW6GmIEd6X/UTwIgIOBQDaONtIQiTMGVKcPZ3Buf48J0IKwO+/vFGhAxlgYNoJd5
	 Hzr+MpBkELWciEF05vFbuD5i+hgCR1mqfsfOJ0MurazhPk/6JNQaYcRR/kVYkgnVOYjmi
	 2NqY/ochRCXENPME7JKMf3ZP3fgUWupnNvflOLwvd/D0I8hGU4QSFyBISO1lXXkiIuODi
	 L2tH4T70ztsKZtfz1ChB3ZrRqh+UGyQ/10UhSlc9+iKf3exVI07D/jqv7K0+mmsIsks52
	 +bYGsuIy0svSBXG+gDHyhLo0cFGNSlw9aI9QueZzHZLEK/L8M0kXsBvbH7Y0Jdqz5Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=JiHttf4N;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="qkuh77i/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290E606A32D
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 03:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7290E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=JiHttf4N;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qkuh77i/
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794368949; x=1825904949;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3XSpNbNKS+jW+HTPhBDSEWF+1p2fYoLjF3fbPJivat4=;
  b=JiHttf4N84j1mizVfGOVf/GXE3/iMrHKre0W0exEZit+9UqIkGYhzPdy
   rRmSXOUFtx/QKRGBVWk1hJll7dmCE51eUFPn/K5DAIrkMzqiM5x8IShpz
   TMt3gNyG0EHtTehXqn9qJU01bHLXWAbFBPC7H4v6dJy2RYn3k6IaU8Sou
   //Ms0LOqA0Or663rHQKoOkhh4nL+Fcp7IljZ4GJA1VQaGXSSAGEfLsXAl
   cPzVg5DURGYiZvqPTjk/4tg0lzomO6LudUhdUoYB4AjrCHlwPVaaBH9JT
   VJA/3lqdav/lkNw3qLDV+tZJJt5dC6iGsunpS9vdx5b8hyVqMqqqCRm/h
   A==;
X-CSE-ConnectionGUID: /CwGQfjET86HjvwywTXD+w==
X-CSE-MsgGUID: X0fvpxRjSA+EelKDII7w/Q==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; 
   d="scan'208";a="160527718"
Received: from mail-northcentralusazon11013047.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 11:48:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3/kgFAKBg6xGd0Mu9Tvm6gozHvwNAjLzG7lEXEDK+1yZlgheRK8qWbHyejhVnutV2MC/KSOOq5PLa9OSfiJbt+rQBDQJKGZF26o5jL5NQlhF+ojKuUvOM9KfiuEl4CSq1D+4Pa2RAXofoDPuI2zQyTU86FjnvcEcXITTxaNXt9S7IKV+q7tA2cWPPwKwN1lcEIAwirKmbOoxaQQNBUt0x/yNPDOGkWMgv3pSRbsznRdWjsLGww6Iw9bEqJGYQ1e1g9L48Bl4qp2+qWHeptu89NlvPm9L5Dnx/xOd6OBPUWlJVJWqWLEo9M6Eu/Tgt3roggM2efLAWBe8PEJY58mgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qwK9SPYuI822/6UvNm4FUl7xeTVlxM/3/IhzfU4bBQ=;
 b=lrit5ZSfJo0roGLKSH3id3NIW8iGdXFCtg1NQVzv9fHGdyHofvLQx/3tN0eQg5PXobFoJsfMwbF2shI0lpM5VoCq/iggY5uMLZU6n2HPHuyZbymhNEz0Z31JmbKNwgdBgYGwe2a24ERsjt85Uc7zdUygbZm2l6ey1ZhHcMlVEavosV1DiuiMP1cqbGg27v97jvuF64H7cYzTWbuLAux5JrjFikl29FVghy/JZGiF/67RzDW9Er2wWS/g8QpOG8HLGdhd7yq0aBKZfaAELpluhJPoHNgr/6Skm2llF/HmipPePPfWvf4B5/5PGwChCFjpy6peWBSIbry+B5ibH0HI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qwK9SPYuI822/6UvNm4FUl7xeTVlxM/3/IhzfU4bBQ=;
 b=qkuh77i/nok+2lvWtRxKh56yB6b32J2av1KnfedPpHqzzpczRYZCPXvadOff4IgYfcO/j1OTmUO2VpULMcMHL/losnbosxRgicfF7NL3ikePRc6mVO+m+xdxBmPyu4HKPt2bCsEftBE2fXjxoYUHlz4RgtcoEA9+CTsQFJudEfA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB6570.namprd04.prod.outlook.com
 (2603:10b6:610:64::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:48:57 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 03:48:57 +0000
Date: Wed, 11 Nov 2026 12:48:51 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/6] nvme: tests for fabrics queue mapping
 and isolated or offline CPUs
Message-ID: <avPchJ4rj-xrgH4G@shinmob>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: d418aad4-0152-4919-3348-08df3fa6b683
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|261026140227099003|261022075727099003|261028144727099003|261009223027099003|261022105027099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eByReahXYLSy5OmzFUTj1+MRcvjROq5ingh8BCp6KMDH5NPlpRpX+PizX1kpn0VLcx8v/6Or3OxJ7F1nA8vtrIUlqiUtwz08jfJT1BDZT0JUpDgi9gbCh4038ZSUPeQY6lntjVOQWkH0Mo04sZG59V8SWDdzhMyCkoi6U2Inm5m/HoWszsQhbLCSFOhZam9trx9TI2/eJ0JbMpBUf8Orz77BJjdhr+I7J1UFeoq2NnQpH0/SEfNZa4DBSUveLNbo6OQOpU4C2UiwkE22vmLAjItMAym9xJ35Siaodf8RXKEom9rFDjm5n57K69hfwteJtK6QDl7MQtbBUhYJ8l5DzLCRW6pkA8fdP7+9dpmACs/MYJtJPz94yjI13pirmK5ImL8xfC/F2S+lP6kSZgi9xapnY4wYS77NCzIQJuGktxHNFgeCLcQJT/C/4FIcoLIZAnTTsbOHlj5WV2w7z5Iut4+gRbBXM+euW/HKOjVGtOkXGoDlgvMFXTC5WszCSVyDfROq5CYk++TX00Y91D9MmipmG8AwCHyZ+UVt6a283GS4d3A7fseHznOYcvmBHpRtWq6EtVJMGF+HThXaG/qsby/Lj1ZWeD4S3brm7W9cZsjqiC9VhHD0ydsOk5lEOOMc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(261026140227099003)(261022075727099003)(261028144727099003)(261009223027099003)(261022105027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TVaCT15infnwyZGoOBBUzCuq3uMDDP5qyOiY/eHQ3J8akhzmDahH5SKJ+Pi3?=
 =?us-ascii?Q?TrPTe6p1rV49ddYbLqWt6Zz9GPSN5uCOAD+p33sdamYbZiqHzKKqKIJARZHm?=
 =?us-ascii?Q?KV3mzEPFz+PyG1NTcyvMPx3aQ9iDDnPXfkYu0Bk7nycC4b3NupO1/EWyIcKg?=
 =?us-ascii?Q?EiVXPahYWUzxn41c9lEQ9gQuo+mtS5uNi4cVzkUEgnzy8zDWQfmm6Oag3O0H?=
 =?us-ascii?Q?hlEwJA7jdEqpPK5YZG5bU9jeDup4drEZauyKMWe6qbjPuX9iPIiKXB/9rlhH?=
 =?us-ascii?Q?H5hUQPtS/rG5k5tzIfXn1cVd8s4D1xLKdJxpOsAJXzQa/nbhCUzGxTyyw65x?=
 =?us-ascii?Q?cKZiCjtMFcPfB7HTNHDrz1blFF+WFBbibR65xpuUBys7SJK3r3yBuH8MpwCe?=
 =?us-ascii?Q?JT7pBGZ/Efya4YGAPqOGyy8U4ZMl1v5Ktk+cUQw08IPz3iJkvMo3H5Oe1sus?=
 =?us-ascii?Q?lGsTxcv2hJH1oAa5urzUd31oqIu2ns0oZTcZs1383HyS7GfqngGrNzjVmQAW?=
 =?us-ascii?Q?UI8IOZ1TUAQ57Ly+YMTla9ztxlBzW0ojmcMIVHJkeq/64TmUnmXZqbSOmFhQ?=
 =?us-ascii?Q?9Sdue2DE45qwDVsttlmtm3EO/DTyVHQPiGorbG84pw2ojZddNt5uaozf6srX?=
 =?us-ascii?Q?ijfm2N2phN2FQuDTuEj/iOGY6logd0wjKUKHUTb8zTkgn+8k42e0fNCgmBAc?=
 =?us-ascii?Q?OLkIClw00HcFb2wluLJHPMPYEdI/CMe/EHokVdM+l/3HPFH4Gi7U5++Xj7O5?=
 =?us-ascii?Q?8NDNTlq8qPNZoyrYPfd+Xru70lSLFr1IDlW/b9Dn/GRHJ97TjS377z+Gfunu?=
 =?us-ascii?Q?7bvaXb9oC7Fcpah41gfWt+iSTeo3LUC8Tr2Ys/duN90RR3/l1ZPo/nHPpuuB?=
 =?us-ascii?Q?hbaj7/GfeSXakaZfvAlw6rQmL1V8CUtP905R5TYEziYZdqj3yu3ZfoBrkCVX?=
 =?us-ascii?Q?mjiWmXWh8LtK9qa9k8NRDRjodzRgwUSxQtLY50AnqafXqvnk3DfIFi7f/2uB?=
 =?us-ascii?Q?cpIvEGW+SggnZFXm4YzgPFHSE7Bw/p9lz/ExrZOcgNlFTqm1gaXZyjcD0Uwq?=
 =?us-ascii?Q?MHUR+KiBJ0NVRUbEZGWgkynuQ4z5h0DNN4iOuO3lG2qkHN54b73BdwZGqO9H?=
 =?us-ascii?Q?X3AxRtnZYgQrSBh+IYn1hYetr30YVKPb4xlKj/G+4NtnZ2sRBEDpmysOu3Ip?=
 =?us-ascii?Q?WpdsnkJSUjblpRyfHnOI7nEPxnxvQuUksedz5Gr65gbXXRBAgwkHToNKi09K?=
 =?us-ascii?Q?BQGhnjD2M/5cWf1xxj8wdneZ2Ot6ZLBBlDTKMeN1RenHw1qYFhv91kCF+/c2?=
 =?us-ascii?Q?nBaRlU2O2v9WVi6k3nxyqs5FXfYEHBWyvQc/fioTO+FMOHsgbiX3XP0OJ0Lx?=
 =?us-ascii?Q?Agd/W6GioSghQyc0Bscg/mJCultB8ewsPQQ6qAXTo/D+pE5LXv8BLKhjuz9P?=
 =?us-ascii?Q?cHnq4793ODfR1rlt0dm7RWtfXVBhQHHg3C1bJtSZQlqZjmOmeQ4/ycHtgXfF?=
 =?us-ascii?Q?v7mT76XNHBit4OVr++TtyTFOTQAsAATr2DoOjmB769GYNPlC29vh5Cb1OSvk?=
 =?us-ascii?Q?AyTZKj4PG1fAU7dB1NmalJnYESQLa6ThZWhrtrR9gKGi+gboaDQotJG4UP2X?=
 =?us-ascii?Q?1ZaO6NNtxQzXCeu5Q5fP2mZupEV7I3+ViLCt92ezRPYaT4PYPU2Ia4y2kbjQ?=
 =?us-ascii?Q?jnCZgnhUcm4AyfHd2eL7mCBkAAtqbs6JSpEGt45Jq7bv5NmjMwaHdPWF+yQH?=
 =?us-ascii?Q?iGyMXrwwWStZjaXfo17adBXSf52ZzL0=3D?=
X-Exchange-RoutingPolicyChecked:
	UzBHjFSWyM/UbK4CYyO9HTVXC25Z+BQX9IIfDYAdWk5CNlquoeRJILA07UU5/dQWCKf+xqa38Mlu5i4hveS3vMyXLTsjUZARGrjX2KPxu1pzgl8BUM+Ee12e9vsQrHKa7BIYSRbaPqk+f/cc/xjS3UJP7HhgdDCd5C1v5a7PIErHiE3aaq7YycQ3T3hx7jBhXcIhOwFhww8A0SagWr+0UkIVsdMZZUU3wa3i3QMl2ZLsDzzWtHhlEkmNXyaRBG3HDEpiUk+HdpYt53vMyX3V13X3n+ihEpjoDY/b5CHKNEWX3QyjiuxIbfTLof7QJVcYudMRLcZ5UMvwSdmphym7ww==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8h9oKhF1Ez3wix3czPxAnVe1hKHIGhb2vtvPnIfSSNCHFzLBLanJQoMpjFV/vewFLfiHWQhE8hbxDBHxjwuZOK8J7G4bEECEx3PJA7MtEalzWtPujEkNNR8Lsyv1nfWmTUACHm16Q+WbuE9CPPyzQP1+txRlxNwUtZXGzqVqS445U8cvelhIT9tf4YaiPo5NbymXwXW+s5gG58eY6ExZbTn/4hqVPFS3znZCeD5vzpUsIisu/4/OGfeZCua0o8C0QqfV7EWTf3AYXEigim0sotZAS3Fw2GdZ12XDLiv6XYZM2XQ9gIFd/J2aRqNkQUbtejyAVHU9f0GWmmdN3reSAnpV/9eOx5/LT9mquNyiNioK+lof4D8Ifs5x9XNyH2liBATyO2png38A2z/3yccT+elLiIsiof15QqvRqr70ZFLg5PSW6aGGhpxqzPwRsDGv0Y+Aj2Z9kjrHbaxoxH7AiGFqTwbmIfVQ9+AM3fiaEmnUyoDxRoxxDiR+9BYWhuuixN19etXeVtcM/way0HqvnjtPrW0AqU2T3HAjQGKy8xdBzhoK+ug3NUyKm/RlKEzOSmVMtlKt2ILfYROb54AZEXsu2NSwdWbgTGrOalH9TO8b+pt/y9tXVcKIEf7LYtpM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d418aad4-0152-4919-3348-08df3fa6b683
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:48:56.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGApexCe7vpxgaYqwXn/Wji1viUg7ZckD6kRKE9WqIDkyjFK88PW0mYUPwOOImYrcOQ+fF4sX6pwKoHcy9Eq2GfofBEauQE/wK9tcI5kU1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6570

On Nov 04, 2026 / 15:25, Daniel Wagner wrote:
> Connecting an NVMe over Fabrics controller fails or crashes the kernel
> in several cases in current upstream. These tests reproduce each case
> and verify the fix.
> 
> Queue mapping bugs, fixed in mainline:
> 
>   nvme/076  More write and poll queues than online CPUs requested. A
>             queue type got more hardware contexts than online CPUs, a
>             hardware context without CPU failed its Connect command with
>             -EXDEV. Fixed by 99fd0cbae849 ("nvme-fabrics: limit each
>             queue type to the number of online CPUs").
>   nvme/077  No queues left for polling. The poll map kept the default
>             mapping, the queue claimed poll support and polled I/O went
>             to a queue which isn't a poll queue. Fixed by 36ede1aa85d5
>             ("nvme-fabrics: clear the poll map if no poll queues are
>             mapped").
>   nvme/078  Reconnect with fewer I/O queues. Stale io_queues entries
>             mapped the poll queues beyond the hardware contexts and
>             blk_mq_map_swqueue crashed. Fixed by 9588769af5fc
>             ("nvme-fabrics: reset io_queues before computing the queue
>             mapping") and 36ede1aa85d5.

Daniel, thanks for the v2 patch. I applied the first three patches for
the test cases above. Please note that I renumbered them to nvme/078-080.

The other three patches look good. IIUC, they depend on another kernel patch
[*]. I would like to wait for it applied, then take another look on them.

[*] https://lore.kernel.org/linux-block/20261104-nvme-fabrics-isolcpu-v3-1-41953b5dfba0@suse.de/
