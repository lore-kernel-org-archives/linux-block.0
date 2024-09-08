Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699C3A1B5
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838603; cv=fail; b=qNqODuX/2kPPPYjcGAdlGyCNWsOkQdv65qDaIDz23jzYAvKJIHNnidEqLduSalLrYqLBsy6l5fCpbWkQZTM5C2/J3zbLcM6lpLFwmGFeuAoWQWkor1BtVrY7FI1j5gi9kS6NF9SBWNouUGzuXXBcmLZ5TKjp1rbtm2Z24v+Ws+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838603; c=relaxed/simple;
	bh=RQDlJV/SGFR1jxyNy6JZdk3Hczk6EheJwpAt2gmRnno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4/oyuBj/j4oBIR/dsGNt2xn4OuKv1LKQw3KJzWr2z4vl+gfr1isugO8id99+VQmUxjZ/W6Bg8dqpMnwXZL7t5OJ2HCd81aMW0WbcMTAUwzVZPu6eAJnkS9yDeLDtbK4VPVOLK873UkRecMzasBdsSdrMjOW08hDn4tUU8TbOvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bkVcU122; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IE9ymZPY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bkVcU122";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IE9ymZPY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725838600; x=1757374600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RQDlJV/SGFR1jxyNy6JZdk3Hczk6EheJwpAt2gmRnno=;
  b=bkVcU122oShUi2+wMcj96zYVxG/FgaT9ycZ5iMTvsfylDuWg4NjpqrDN
   47+XoQ80RZGz1snL0IFZkBpfmbPGRREJr9rqMhB/Mzajhn45H+kof39iS
   RlpeZPuZ4lkPzRPWCkKuFvTe9lZSorISiSKZtaG/zPHqfGM04Spig//AD
   XI9shDioVr4VqxvJsZBU3jX4I0MBFcGuizPN3Esw3BXRGXSjG5ciEwOtN
   lQWz5+Sar+8ahHIMWT+POMCi5Xz8LaX012WeJFxKfPP7ldlZnX1X7x27Q
   G5vxVYg76Twc6aYMeOPqKpuUd/smJAUv+/Vkt39dr3HRDfv3D/qLKSrxy
   w==;
X-CSE-ConnectionGUID: vCLul440Rb27w19DKtvgWQ==
X-CSE-MsgGUID: y7RyS6qdSrWhvil8rzMaVQ==
X-IronPort-AV: E=Sophos;i="6.10,213,1719849600"; 
   d="scan'208";a="26574521"
Received: from mail-bn7nam10lp2043.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.43])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2024 07:36:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPRDk7+wqIqKDTDyQAUq5/0iZAemHDsGCf1sKCS+AsVWrrNL6AIAG+5iccc7un6mM0OLev/DouEjEmj030w4WzjoSFmcbEenwwlX+SgCSEv5SPl63anrxIuDYlM70f+U0mcDL35DLN6xnfnXopcfqWf53m6hb2+uvje7aSf29RYDbOBHEi5jJ2YgzrwvVyVcv0JKcW9xw1N2PJxDMVCsaTAQkf0IHfXD3Pu9QMZk2RQfwvQdFwGfBjjr67jRtKTW4ZoDTcvA8ZEkEpNfuwC8NPJ0hKpcm1BRFN10kdDRkKOKrbv8zEEMU75biPrh7Wdh3BkZ5rTq1dz/mVtQffwuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQDlJV/SGFR1jxyNy6JZdk3Hczk6EheJwpAt2gmRnno=;
 b=hzFqRIB01MgvqisX3Qa1jKsVFKV9vCY+PIFrt5kR8+G9ns3hUJ0SeEuSFR6bYJMkkEvXq94pyUlAahlzYsbVF5s9ffUUBTK9IJiYV/YcbL0roxI7Egntwlfp/h9eZJbLZE0ScndS6ADV9dDxxpwXWdZHskkRdXQxQrgAkaNtaIgYR40tqmCxG5knblqjFBH4fNuJESpLFMQKvPQXYLUvPuNOpEwA7DW0s5vA+/q7Q4l3uL6UrBDFxCmLE8uMgWLrXK3yU1LBej9qiJvzzoGBP9PFC0MR6gB9fiSIfW2LHV9SZpOgF4babUKHs4c+okyrUMwmwrMOthJGhf0AS1nm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQDlJV/SGFR1jxyNy6JZdk3Hczk6EheJwpAt2gmRnno=;
 b=IE9ymZPYbLfKWPnseI4IcbiqOW/nehlx7uoSS5rdGMjE8agcuP/brI6JkXqfKXLeysuots1JarX0qZW4pxyf3Xhaiftpp5Igw0ye00RTBJuQgyS3JVLJdaC9BV87jEUwAwzS8ULJZQ/xr/U3YbTTHIUFFnfpDY4MHBetKBw/zwo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 LV3PR04MB9417.namprd04.prod.outlook.com (2603:10b6:408:282::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Sun, 8 Sep 2024 23:36:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7918.024; Sun, 8 Sep 2024
 23:36:30 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nilay
 Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Topic: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Index: AQHa/SaPfgUQna9pYU+FKZSzxQd41rJKcYqAgAF1BICAAq8AgA==
Date: Sun, 8 Sep 2024 23:36:30 +0000
Message-ID: <t25va2rox3irprvsjvtgdnu34glc63zjq2m63hf2sr45vhrd5r@6qivmgilfmus>
References: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
 <x5e7cl6iupvspx6eadustxbzt442cprye77dh7u2rjl32xajg7@egnrpr5b73so>
 <CAHj4cs-hhV0S+BmLyn++LSE=V-hgE7JTqQDJYtxRjAExfRwuMw@mail.gmail.com>
In-Reply-To:
 <CAHj4cs-hhV0S+BmLyn++LSE=V-hgE7JTqQDJYtxRjAExfRwuMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|LV3PR04MB9417:EE_
x-ms-office365-filtering-correlation-id: 5625d163-a50e-45cd-940b-08dcd05f10dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2JsVmhER1d4K21NMm9ZOXBKRUM0RWpMMkdmNWFmWW5WYU9TOFJZR05UQ2ZW?=
 =?utf-8?B?eG9wYUZ1VjVpTVlPTHE4QmNCTGFOMDF0SkhyMWJRNnlhdXAvVDNUZm8rSUVa?=
 =?utf-8?B?aXYxaVZEakJMU1RoMEtTVDl0S3pxdSsvUjBzWTRLN0g1M2t3SmR3RG5jTVFv?=
 =?utf-8?B?TENFaHFLTFFSbXE1b1R1d3AraDJaTGNYVHdRQWUyTlhOVTVZMEFreGVWdURr?=
 =?utf-8?B?dE1EUStLaGZZdEtUT3N2UHd5enlVL2tIZ0E2QVJqc0crMEk3Wmh1aG9aTlc2?=
 =?utf-8?B?Si95aE85cEZXT2x0R1M2VW9XVTExdVozYkVWeDVMTWk3RG1XSHQvRVZuVWhH?=
 =?utf-8?B?YXVDVmtwSjRXSldnZW1LMVhwdmN0a2FDamQxVDZHR3R4WmJva3orNGoydVZY?=
 =?utf-8?B?MGVnQjlmdVovdVNNbnh3bWJKTlN1YlVaVXE0VTRHVDBVMXBqNkl2V1lMNlIx?=
 =?utf-8?B?ZExOeklRTFl1N1NHdlk5MjhyblA2cG1FVmlwaFc3NElsa25COW5qZE0yQ1B4?=
 =?utf-8?B?NkxLdjlmdFU5Mi9DOXo0ZlNoK0htL0loR212d0ZxMWU4TFIyTUMzekRyQnFR?=
 =?utf-8?B?VURUZU01M3YxOTRkNVpsMzlxSXhzaG04U3c4L3pLalpMa1c2WGR5SVl0S2dY?=
 =?utf-8?B?dXdZcnhwTDFGdFhBT2lRZmwwekFoR0VZRGlZS2F6UGFVWG9VdGs0M3pJaXhZ?=
 =?utf-8?B?OVlRMUpzVnY3b1YvSmo1ZDg1QndpNjhZUlEvQ1NNZWxuYmJrTkZlK3VOYm1V?=
 =?utf-8?B?UTY5dkFxWC8xTEJ3d2pwaURvd0FvR1QvRStvUTEydTI1TE5mRjR3bkl5YUVu?=
 =?utf-8?B?WTB1Mjdtei9zREJJQVpIR3IwUWswQ1Y5TVNXWFlLSzJWQitOc3Y4SVpUaVFY?=
 =?utf-8?B?MXRBZktlbXJUYzVUdHAxcFRUeVpiRGtIZUtycDJJaXJpMGhQdklkZVhyTHpN?=
 =?utf-8?B?L0wyNUFQN2h4YkpwNW1BSnZCczJxTVYwSzVoUDlnQjRkWE5ETlo4cVZGQzA0?=
 =?utf-8?B?L1pEVGQ2cG9lUEVRTmF4eW5abGRzU2NneGxRWXYyNjFxTWRxWnBOYTRrNVF1?=
 =?utf-8?B?VGFJaElrd2JkaHRTbktNLzRmRWs1ZzFVM2oxZFlGTkhORDhQc04zNDFyRWpj?=
 =?utf-8?B?WFJNcHJiQjVFaWdycWJPb2o3cjZOTjJlUThkdlRJVncxVENGYTJlaDBIQTZL?=
 =?utf-8?B?TVlpaVFId3RVQkliS1gwOVBDaVBiczRHbXN1azFaTG11ZDBnbzBkNHN1cjJY?=
 =?utf-8?B?UEJrOFZUTG1TbVBYaTRrYWwrbW5DdlF4V1c3RkdHVEh4ci9IUjNDYURnMmlq?=
 =?utf-8?B?V1RGK0lneGNtcWgybXEwd0szTFpEVHFodkNMNTN1bUxWS3NDc2JweGhEaWVh?=
 =?utf-8?B?cENuMFlSK3JKSWt3RmM3amx5bFc4bFdxTzgvZHZEVVpDWk1OQzR1MlRQUm1v?=
 =?utf-8?B?QTNBTVc3U3BRRjlOWWp0c0NTVnNQU3BUcis3OEVrN21ZeDljRjIxcmZuOXFE?=
 =?utf-8?B?VmdNM2p4Uyt0aEJtTlhmQllDZHloZFpxYkZ4YU12OXdwNFc0bWhLYzc4ZXVV?=
 =?utf-8?B?UkRMOGVoWmtoNjNJWTNRQkFJYnRIM2pwcm5EVHpCbDNuU0hSUUpxb1BqU2ha?=
 =?utf-8?B?UXlUVFdUK2xmRkNiZmxUeThGZzJDR3AyQ0Q3bUluM0xwSjJtVjV2TFpSZTUz?=
 =?utf-8?B?M1puZUQ5ZGxRZmV1eXFLNzNZampLUkVuTXlKaHdMeGYzeStHa2hONkZOYm1V?=
 =?utf-8?B?OHBxQXBKZWdMT1VVdmxGRCtYcVN3VmV3UXNKWVNWTmlHdllPUE5JS3N5RG9D?=
 =?utf-8?B?NjVRUDA4SjUyY3JXU0g1T1hRSmJCMFRlUWpId2lZV1JwRW5YM1U1R1RvS0RZ?=
 =?utf-8?B?YWtvSGJnZHRLTldlc3V5dm9hWVQ4Vis5bVY0clllVytFU3h1RHAvQk1iUVN1?=
 =?utf-8?Q?vikVVxnH9DE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTBuc3hZL2pTc2gzTUw2c3dGOU5WM1hQL0pmb3pRbDRvMDNZd0NSK0kwQjkz?=
 =?utf-8?B?WGRJY0pwdi8vWWJ3L1RrbmFyZHc0cS81VG1kUkZWQ0tjTEtuVnhCRWU5SlBt?=
 =?utf-8?B?bC9HY2lINVZXS29KSWw5SmYyR0hxaFRreHdkU1JOc1RlM0NOa29FbDN6SENZ?=
 =?utf-8?B?Sm90ckNaUHJMR0NQa0taRGQxYjF4SWtGUVJqZFVCNkhiTlVyci95dFZDai94?=
 =?utf-8?B?cFB6azdzUDNIbVdYZGt3Tk1tREFadmJXZUlVWXpqQVJCYVVtWjR1U0ZPdXk3?=
 =?utf-8?B?SDRyOFRESlN6YnFBOVlyMWFSZm1KeEZMSGsrbSs5NXJLYi9xNkFhaXBHZ1RR?=
 =?utf-8?B?SGJzdWFrT3UrQUMyUFZqdjkyM1lNZjF2WTlQVWJBYnArRXN0UTM2aWtnd1hj?=
 =?utf-8?B?VjhicWExZGJGejVVcS96ajNVZTg1YUhsZ0lMTUdLNVk4SkRCcTNLcVZ0bVlS?=
 =?utf-8?B?YWFmTko4aDlzZm50UXo2MVRjajQ0WFBWNjJ6WFZLUkdFM3p3eGtZb0VNNmxH?=
 =?utf-8?B?TXRKaGgxWkZreVNXZzhPU3VjRlZYWURLL2p1Vnh3VkRLRVRzY3c5SFpOajZQ?=
 =?utf-8?B?dGt3U1JoZEgvalc0MFpvTThqZm1EZ2h5SEVDM3BWUnJFd2hwejhkRkJSSHZI?=
 =?utf-8?B?QzVxY00vbjVObk1CdWdRTlhGcXJqamx2UFBseHo4R2FDQlc0V05zSjY5Vmgz?=
 =?utf-8?B?NFhYUDd6dWM4NGFQNS9GOEhQUW8xdXlibHBSdW1iKzEwNGkvdGJaL3JvaHFJ?=
 =?utf-8?B?ZzdrR2NpWEoveDJrL2xrK2hhQ2QxU0pWU1ZoOVhUQ09jQmlYVldzc1hvOHU1?=
 =?utf-8?B?VVRvdEphbG1uQStoS1Y5azQzdlAwekhHWFY3bWVDblNyeVFoQURxMnFtcERo?=
 =?utf-8?B?aVlXSkVXL3V5U01jVTc5VnNZcitaenRRRmdncDdKTDNvR2ZpcXVwRDk4bXJY?=
 =?utf-8?B?dVJ5cER3bmpCYTJtbEYzMDdFc1VoQTQ5aGNvbXRDVnhaV1FLdE11WVJRYy9r?=
 =?utf-8?B?SXFYOCs4UXcvWHpTOTBkTE94YkovaW5wOWYvSU9lZ0dlRFp3MzcxenZta2hk?=
 =?utf-8?B?WDh3ZjNYUGVmNEZ6a1BQYUxmSzFwdGpSL09pSFhDNDZZY0lxSXN0WjBVYjlv?=
 =?utf-8?B?bThSZmprV2o5aFVlZ1FxL28wMmNBdTB5VU95cCtEajdWNTVxOEZCOFRRcEN5?=
 =?utf-8?B?ckZVNXJoWlhjT2RMbzdRL2tmbVdHQ3lNRlcvRVY1MExPSUlCOHhqRCtrNXFJ?=
 =?utf-8?B?WGxkWEQxQzRxYitiUnAwalJjamZvUGJiZHpsUHJGVnBBVmFUMTArVlM4NXJH?=
 =?utf-8?B?bS9SRi9TR292cWlkWjltSzJsQVQxaFZsdndWcjRiL2w4eElILzNPT1lyaXph?=
 =?utf-8?B?a0paKzltZUFNVmRDY24xQkVldkI1RzBVUUl4aUJkSnJjcmhWZ0txeTQrbkZ3?=
 =?utf-8?B?bCtyZmZmZmI4MDVVKzNwRHNBVFFwMjZ1c0piU0RuMEp2WmRQTDNVQTRNUDVU?=
 =?utf-8?B?elpHZEZDeUJrd3Y5dzUvV1NpYVcrc3ZwWHlGUjhndTVBV2NQMnJCRDN1M0t1?=
 =?utf-8?B?SEZneWdBYWZkVGN0MWFrT1pibHlheVNtNEw5eGh5bWNGVHFCWkxOdlQzMXNs?=
 =?utf-8?B?ZHpuekVPTFdVVzlnSjZDNFd0a0gxOW0rSDB4UmlVcm05cE5RSlp6RVdBcWp1?=
 =?utf-8?B?d282TjhOMjFOVVpLQnFSak1MbEZHMXdDTkYyblVqZVU0ZXFmZVNveEIxVzRI?=
 =?utf-8?B?RUJJYis0WlUrRTcxclEyTGowSzhITjZ2dmlMUHA1NHdpQjg3Z1BuQ2sxMGFI?=
 =?utf-8?B?Z2VCMm12UTFZanpQcXZ6bWxtTndzUmdNQk9QL2J0QjhUYkVFLzJJR2QxbTBo?=
 =?utf-8?B?OS80c3U1c1ltMk51Ynh6ZVRoTTFZWFFUVm9nQmgzV2dWUnBMYmtZbXFSSE9R?=
 =?utf-8?B?ME9jb2NCYks4UVVZRC8yaENiazg2L2U1S3RXU2tVVmNDM0o3dHYwYlcvcnkz?=
 =?utf-8?B?YitrMDlhbzZ2OXFhM0IvK2pidytaYWVNdHVNb0xZbHRFcEZpR2dWTkY3L2NS?=
 =?utf-8?B?NzJzazRBU1BJc2JMenZZc3k1aDZUTmkxdmJvd1o2Y0FCekhTbjl4czBEeHIz?=
 =?utf-8?B?ZGtSZHNobXIrUUNsb0RkekkzRS9rK2x4TS9nelEvYkgxR3ZyVk9XTGdjL3Qy?=
 =?utf-8?Q?0JO94IDa3KW0kUsXj6I1NM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <697A682ED5621047AE7E85B603BE7220@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5wJrKvyuMu19/iCyRMLFez0LBb5i1rIIYd3VRql742idMSILt1M+hxMo/S6d6AMt5GDHlfN6CEPLr/8CqFPRp4tqu/nsU8L/UyFaRgI4ZcntKMRdi2iiuihtbqQG+kyDJ1gvYalxub5aOkQLQftIY69hYyZzx9vtwuEN4xgO8eI+GAUS8WTr+YXgf3nc7pI+09mF5aAVWFItanOMXJ1G5zTjRaB6iY8Q51bsaKTCTi6jNja8uFFg17Fm5aEGOA0uAPNYG3LV3tTyLU7/lOabjilRxvu234GlBrCA7+BFest5NulU3R0O9QgKSomYM4FVko1/g2km2s7RQhJ4GJ/qtT97Gebrl8ihDQIy+hm6zlBbzrsX9ht56J2IIRKGwAIM/63Ot2uXu1CDHz2HxHArMVRDwijwiOloVTcoXSJzWvOR2gqFzctd5Cq+/mL/dGQcftjJNQ4fQ8xnqe/IE/JEhyBAVLg+Lw/GYgvggMBpLCXH4jkHoiSr037V9wu5MD7saGAkm4lSTn9MCZOw0wIjG3WvrLERu1WZPwdxC8Joq1kzG4bXyn73tc4gbJJWvG0nK692ze0miSNxi+bsbzzedG+LVWobrION1omK3PKi2GJS2t/sgPMkpKHiuNlna9Sh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5625d163-a50e-45cd-940b-08dcd05f10dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 23:36:30.2905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXbO0iZw245u6SeE7U05zf7HOYPoZoRJbkQyP4IoenE58W8crV9Nubq/DS6ZLCH3ChMWq/3O7tGVqsdWoqohXIcN6couBUpevtocwjt5VRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9417

T24gU2VwIDA3LCAyMDI0IC8gMTQ6MzcsIFlpIFpoYW5nIHdyb3RlOg0KPiBPbiBGcmksIFNlcCA2
LCAyMDI0IGF0IDQ6MjLigK9QTSBTaGluaWNoaXJvIEthd2FzYWtpDQo+IDxzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gU2VwIDAyLCAyMDI0IC8gMTk6NTQs
IFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiA+ID4gVGhlIENLSSBwcm9qZWN0IHJlcG9y
dGVkIHRoYXQgdGhlIHRlc3QgY2FzZSBudm1lLzA1MiBmYWlscyBvY2Nhc2lvbmFsbHkNCj4gPiA+
IHdpdGggdGhlIGVycm9ycyBiZWxvdzoNCj4gPiBbLi4uXQ0KPiA+ID4gVG8gYXZvaWQgdGhlIGZh
aWx1cmUsIHdhaXQgZm9yIHRoZSBuYW1lc3BhY2UgcmVtb3ZhbCBiZWZvcmUgcmVjcmVhdGluZw0K
PiA+ID4gdGhlIG5hbWVzcGFjZS4gTW9kaWZ5IG52bWZfd2FpdF9mb3JfbnMoKSBzbyB0aGF0IGl0
IGNhbiB3YWl0IGZvcg0KPiA+ID4gbmFtZXNwYWNlIGNyZWF0aW9uIGFuZCByZW1vdmFsLiBDYWxs
IG52bWZfd2FpdF9mb3JfbnMoKSBmb3IgcmVtb3ZhbA0KPiA+ID4gYWZ0ZXIgX3JlbW92ZV9udm1l
dF9ucygpIGNhbGwuIFdoaWxlIGF0IGl0LCByZWR1Y2UgdGhlIHdhaXQgdGltZSB1bml0DQo+ID4g
PiBmcm9tIDEgc2Vjb25kIHRvIDAuMSBzZWNvbmQgdG8gc2hvcnRlbiB0ZXN0IHRpbWUuDQo+ID4g
Pg0KPiA+ID4gVGhlIHRlc3QgY2FzZSBpbnRlbmRzIHRvIGNhdGNoIHRoZSByZWdyZXNzaW9uIGZp
eGVkIGJ5IHRoZSBrZXJuZWwgY29tbWl0DQo+ID4gPiBmZjBmZmU1YjdjM2MgKCJudm1lOiBmaXgg
bmFtZXNwYWNlIHJlbW92YWwgbGlzdCIpLiBJIHJldmVydGVkIHRoZSBjb21taXQNCj4gPiA+IGZy
b20gdGhlIGtlcm5lbCB2Ni4xMS1yYzQsIHRoZW4gY29uZmlybWVkIHRoYXQgdGhlIHRlc3QgY2Fz
ZSBzdGlsbCBjYW4NCj4gPiA+IGNhdGNoIHRoZSByZWdyZXNzaW9uIHdpdGggdGhpcyBjaGFuZ2Uu
DQo+ID4gPg0KPiA+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2sv
dGN6Y3RwNXRrcjM0bzNrM2Y0ZGx5aHV1dGdwMnljZXg2Z2RianVxeDR0cm42ZXdtMmlAcWJremEz
eXI1d2RkLw0KPiA+ID4gRml4ZXM6IDA3NzIxMWEwZTlmZiAoIm52bWU6IGFkZCB0ZXN0IGZvciBj
cmVhdGluZy9kZWxldGluZyBmaWxlLW5zIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNo
aXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+ID4NCj4gPiBJIGFw
cGxpZWQgdGhlIHBhdGNoLiBOaWxheSwgdGhhbmtzIGZvciB5b3VyIGhlbHAhDQo+ID4NCj4gDQo+
IFRoYW5rcyBmb3IgdGhlIGZpeCwgSSd2ZSB2ZXJpZmllZCB0aGUgZml4IG9uIHRoZSByZXByb2R1
Y2VkIHNlcnZlci4NCg0KVGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9uIDopDQoNCj4gQlRXLCBh
ZnRlciB0aGUgY2hhbmdlLCB0aGUgZXhlY3V0aW5nIHRpbWUgYWxzbyByZWR1Y2VkIHRvIDdzIGZy
b20gMjJzDQoNClRoaXMgcnVudGltZSByZWR1Y3Rpb24gaXMgZXhwZWN0ZWQuIEkgc3VnZ2VzdGVk
IGEgY2hhbmdlIGZvciBpdCwgYW5kIGl0IHdhcw0KZGlzY3Vzc2VkIGhlcmU6DQoNCiAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMDc1MDE4N2MtMjRhZC00MDczLTliYTEtZDQ3
YjBlZTk1MDYyQGxpbnV4LmlibS5jb20v
