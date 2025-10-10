Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A72F49F1
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105435; cv=fail; b=YpATamiTEOnHxKF80M1NH81GI8ngMskqz2Gy4E2uUMoKpzjAisRQFS3jtkfiydukUvhOpfPl73pMBoRmzKXjVrqJwdGLI6vZEV30bKfcw7R5wxye/SMNxqnvfDkX6RNCgqxTKmnatpwkwdCgejrJy7YzHgTVi6EUA810izPjREk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105435; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7YJmeqf1NwZK0G3nwBiL+lcjtemuOUPajph6D50R96iqyorBkArH4WhjUwrGrpRKSzEVqmpDWTpp2YEmK/XME/RSt3RyvEgC42/JvT8gfzoqAcBLzGUtbsy7aWper46J6CZByHimLz7mSw078CKmNmeh7AS9+7L8jOfnDh44C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HgT963GO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WdOW6Acj; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HgT963GO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WdOW6Acj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760105434; x=1791641434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=HgT963GOnz0Woj7yzSdbWXRrVQJoJJlaBPXj4aWjYKWkwP3lEi2ve2KI
   0IN0mWSrE+vnET5MBuRPtt5IEoc8ocU1JYGOh5McRiIWZ0LKoiaDHymmv
   +5w5ENjXagC+1mPSEotPzU38QWbYdSdth+0RYCdaYvyhhoUVQQ46YdTZ1
   3rdHdp/lQgYmVAMASloVyWTLWtbsLaqD0kjis9DhJX1eEMUDQ15I/KumD
   VGALAKiUEGNBnP2PXSZvbnLV5z8jTFAYxtNbg+RjvFe/P9dV27uUYEpYs
   3ya18K+FFMehGVz1Ler74iLjake7Y7g4advs+CUCgDzVho5Lv3fgNhlyB
   Q==;
X-CSE-ConnectionGUID: bpomz5RFTSK49uvuAsOlrg==
X-CSE-MsgGUID: pGZGaGw0SAiHd30MX/HzSQ==
X-IronPort-AV: E=Sophos;i="6.19,219,1754928000"; 
   d="scan'208";a="130002690"
Received: from mail-westus3azon11012044.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.44])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 22:10:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQgsUE/0j3youFsWDdBPpaeF0ZZxddV/WTfuKPyeOD98jgpvQU/kUyhaZmwLK4XC2NfIygYaep6a6zjWMfon6TO5J0+B0xb2j2MgQyVzBJ47o01o7io3C0qZy/SssWuei4JlB3wT0/EZpe6yH+a0EEOMerAVE4F0jA+xYEv8gy6jZ0CpxsBj2a/xscoteQJyvpdUKgERmxJ5k1H6R1tV3R75lIxiy55pJZ4S9w2lBZ2C+wMnk0VBMQnyOQjfRhUQVxM+6wvgTe4z5tZ+LRUa/E1lQBB3IujrMo1+ek/UUHm5FjYRxGlTJLFczGiQ12mFPfsjcmhfZcSfsjmVZ6dZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=M44qnNDdVKnmKQoMiyrWSH1hvD9TGvbFpA89FMMxY7IyBkKZBnI9Um8PnQJNh95rY94n7utPi/72MKQ2NjQhhgWzEmwsP8PZWvjp268gf676GftWE2hmtrPx+xkir6jFlG+MvGk+6t5BwB7+gUsFzB+u4nohwqS5sUJ+PsbcW47abrqhoxPdwf9bRsMas7adEF4uX8UBEfgMaUbhNK9lt6+AhqTkbfEnmKulD9Cox5rVlDxanbvii/o/02rwPL/mP4mcZ0ukabc+tDowJMM6BaEkRmXwPkW2PPfReTU+S0dX+nQ7EfhJm1x4H99SF678nZcsbJoxU/iYTF6jwZWCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=WdOW6Acj33C/WdMr3vTob2wloOftyMD8dvRk0FVHYGqS+36IZ5/wi0c/yTOxPFe1SVnEPKm2uO1u1b51cOiZRJ5Z8pMinW7KISE4t268YZOdXJ5JS4bNcVk4z3e3O2EcJIf9adULaT44V5TBYVQF3hZDmL3xVKmIM3NptvthTmw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8516.namprd04.prod.outlook.com (2603:10b6:a03:4e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:10:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 14:10:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: cleanup and optimize bvec_gap_to_prev
Thread-Topic: [PATCH] block: cleanup and optimize bvec_gap_to_prev
Thread-Index: AQHcOdYeTifsJJ+iykqPf7YSFIPzkrS7a5YA
Date: Fri, 10 Oct 2025 14:10:28 +0000
Message-ID: <37c99b4b-6813-48a8-a552-c70b3ac24908@wdc.com>
References: <20251010110729.3875213-1-hch@lst.de>
In-Reply-To: <20251010110729.3875213-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8516:EE_
x-ms-office365-filtering-correlation-id: ff36049c-1def-4035-a092-08de0806c3f3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVBjTzQyUkI4Q2I4S2hFbGExQW9jNHFFaWR0T3dYVWZaSGpaUXp3MHFobkVu?=
 =?utf-8?B?QTQxNWVHZUExRDM4TW5YNysxQnlLVjNxa1VzZ1ZwOE82ek5KOTNqd3JmL2ZM?=
 =?utf-8?B?NE9Jc3RHU1k1TEh3b3NPZFFzVTlweGlpYjBXcDBYYmc1QnNmc1U3ZFRPbHZk?=
 =?utf-8?B?dG1FYmhZMlNpa3NseFdtOHZBenhkTVpQZ2JKWFhMR3BKc0NpdTJmK1l5TDVk?=
 =?utf-8?B?SW9tMEdtaEtveGVQWGhLd0J2RU5JdHo2d25IRGZIT2tzUkYvb3N6dDUwVU1v?=
 =?utf-8?B?S0phZVNQbC9IRmdIRTFrcTB5YlY4Vi9JZGJxUmgrN2UrWi9rTGpzZkhEb3ds?=
 =?utf-8?B?TG9xc0UyemZsR2NlUS9XQkh0ZjAyL3l4Ynl5eEpZcmpTYWhiZmJKU1BndUh4?=
 =?utf-8?B?amd4SThKc0VWZlh4V3lleEtNekludFBETVg4aEtFTjNuRkxyT1pBZWNYSWtw?=
 =?utf-8?B?RVpoc3EvYnBuZUpLQ0J2UVdubStSTHpyc2ZUdWEwYTU4ZFBkTnJqemZlZDIr?=
 =?utf-8?B?anVVSVV1Z1hGVXdPYUhEY205emxoZCtLTGdSMC9Pb005Q0M3MXdiSjRMZ0FP?=
 =?utf-8?B?RUc3NDY3R3IyU1M0ZHFaNWNJVXJqT3dueXhsb01ySFdPWTdhZFZDaUxNeEpt?=
 =?utf-8?B?RFk0dmhTTkRTQ1pGS0dhVE8xbG5uS1lPc05UTjVNTXJ6eHBnV2hKbVZpRFJs?=
 =?utf-8?B?aForSGs3UGlpWHgyREtuRnh3TGorUno0aDl1alZuZlVaa2RmSktSRkt2RVor?=
 =?utf-8?B?TFc0RytidWVTQytWYkJRMyszNEg5SkpMOE1WR01WMVpCSXZGUkVGUyttcDdt?=
 =?utf-8?B?Qi9EbUZjcVJCc2FiNFlpQ0NVczV4dXplc2pod0FqamN4Y20vdUhRek5iZW9T?=
 =?utf-8?B?SEVYSTdnMG1IM0FLak11U2xzRHRuVGxUUFE4RVgyaWQ4NWgzK3BIY1d4aWFx?=
 =?utf-8?B?NmtUTHlUOEY1TEFSUWpYTDN2ZDVodE9KdGtNRkM5UFdieGlpc2R1TW1JazZj?=
 =?utf-8?B?WWZhd0Q5c3JKV1o2QURLaWJxL3lVRlZTM3FrZmg0NkxXMkw1cnRtWkZrTVQ4?=
 =?utf-8?B?NkFaUC9RUnF6N2pWbjlyTEtKTkdUK2RyL0RGRVkyVnpNT0c4UmJtSjhENkt3?=
 =?utf-8?B?NlQzUFFvRyt0SzU0WGZkK0hvZHJlbWJLQnBLV2xyZi9TdnU3dzdYR3hqNzlG?=
 =?utf-8?B?NHk2UFgrR2xXbzZ5azBwWUxvMjB4TGg2M04zMkExY0tZMTY5bENiRTU4OTZy?=
 =?utf-8?B?Zk1IYUZjTHlnZFdpdXpuODFtRzNzSzd1Qkt3cHBSRHA0RDZ0OUxwM0xydmVa?=
 =?utf-8?B?RDNiZ0IrY0VMa0NIeFAzYy93bll0UHBaVzFNU3lDWFZQdjB1M1B3WlMyYng1?=
 =?utf-8?B?NTV0OEcvMlNGeVV1UVMvMWhNa2Vtc25HbFRYY3p1ZzJ6NjRsVGhpMWJRczRl?=
 =?utf-8?B?citOMk9XemtTV25TWXRNVEFFbWYwYWxRdzVwN25jMTgyZ09ERkVROTZ4YXpT?=
 =?utf-8?B?ekU1dUltUFpzcG9mZno3cWg2SlF4VjZxVGJ0TmVOS1hTSGJSV25DR2VVTFF0?=
 =?utf-8?B?bG9sc2M3cGRmNXByUGFtbVM4SzEwakVVUzRZVW80M2lLWDI3ZDFSdnoxZVoy?=
 =?utf-8?B?NWZ2SEEySWI2cVp1N2lVTC9SWS9acllkaDNscDV3TmJ1YU1qZ3dZWTVmYVpJ?=
 =?utf-8?B?QmthWG9Vb1NybHJHcENqbHgyODlvZ09ZK0YrVjZaZVpVbEFXRnczMGZEeEI1?=
 =?utf-8?B?K1VDaXlGeGxIZkdpWE9oZ3dxbEFhODFqVkpWOWhzU3Y2QnFrTEdtenhVNVAz?=
 =?utf-8?B?TEsyMWt5d25DR0tyTG1wa01rUjlsb0xFUytmVEptQ292K3gzMVc4dXRKaVB5?=
 =?utf-8?B?dmZqVlIwWXIzeWRHM09JKzY3WlM5Um9TakRJTkdTN3padGw0YlU4akJHMGRW?=
 =?utf-8?B?RG5PTnB2RUFjeGNJUjBJUzBON0loOTJDaUY4eG9vK0YvUEVhMGEwaEVRUUVo?=
 =?utf-8?B?MkhuV2IrQ0gwTnN1YWlaeFlSNklleTRUR0FEYnRUcnJWOUc4dVowMnJCNzNN?=
 =?utf-8?Q?K2/3eq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3krNGtaZUdFSStVUy9Lc1NXSVFaNHVRV2lxMGp2U2ZYNGVWT0libXh6YW51?=
 =?utf-8?B?QlUyZVNyaVdhRFlyaW9ybUdPVlFNK1lDK2RHR3hkR1VEYjU4aTMxRUZDU3hT?=
 =?utf-8?B?MGhJT01abmdMQVAxdnUvRkJGWjYxeUZ4OHRVU3Q0UTFUbVdvYVRlQjI0Q0t4?=
 =?utf-8?B?NlpHYytnYWhva2FOZjVXUjdvVTlCanNwUzlza2VveE43WjJzcWNJcU1VSVlM?=
 =?utf-8?B?UUxKWDlaajZGZ1RjSGt1VjBzTzNGdHh5RW0rcUFsMk9SVTY0cVZCdjRmdTFP?=
 =?utf-8?B?bzRSMEg1Snh4NGJWcG1adkxlc0JBZ01vVW5WQnQybnFBMmtvQUUra1poYkJ2?=
 =?utf-8?B?NjdvN2ZVNHRUdUVNL3RRcWExZDJ0N3EwQWNJQVVEVG1aMHdXNmVkQWxHaHlD?=
 =?utf-8?B?UFBiK1JrNlBxQWVmVTdJd01oNzBWcUtQSk5RVVJDMXFBamRkS2hmU3EvWVJq?=
 =?utf-8?B?VzIwOFhuOG14aEZ2OUVSSmJRc1dQZW9OdTlZMWRlcExNRjVzcTdlMUJPd1NN?=
 =?utf-8?B?eUJVVUh5RWt3QzVkTHcxVFovVGR1OHpYY0hoYlIzanJkdnBoNmpDcHVOSnls?=
 =?utf-8?B?NjBMbmJrbEdVWEtWSmorQjhQdGllWjI2UXZqQTZ3NWs3RmtSMUord3VNMkhz?=
 =?utf-8?B?SnB2aklYUDFsWlBLaTRTSlcxQUdTa05qalEyMkRsQUplc0hMZFFjZUp3dEQ1?=
 =?utf-8?B?TjhGemRTaFM5dUJUS1NpVFhDaDVNa0VwbEJZcDYvYjBSQnBkd1FJWnZ1cS85?=
 =?utf-8?B?cDQ2Zmo1TkxXYS8yR3dBcW94TnljVUlJTnpoTjNPZ2FjT2J6MVNGR2YwQlZy?=
 =?utf-8?B?VWdaaDlNblJ5dXhLR2ROMzVFWWlNT0k1NDVKMWtIMWNpdVVlSitnYlh1TWNC?=
 =?utf-8?B?ZzJreVRkVjFEd1EyNmFRVzlqOEUrT0dJSm8zSkpBbThxdDZML3pnOXVRQ0s4?=
 =?utf-8?B?YnhsZUJiYUU5TjNablhVSUtvUVdncVllSS9MZTF2aFVnT3lhblMwd0NRTU9w?=
 =?utf-8?B?NHVWZkRZdkI5dXphanFTYmpyRUZmMmxrS1pZRUgyYjB6dzY2N2x5UWFZbmhM?=
 =?utf-8?B?c2tQcXA4cHEwZE9HaDVtQ3pYMHJrdnFlVEF5Tkl1eFhPaURwRzNVWlJpOHh6?=
 =?utf-8?B?dGFTZVJsOFY3MDdQbGd3VHFGZXpQcHByYURpeCtCV1RleHpiM2pnZDMwZ1BX?=
 =?utf-8?B?Ulp0M2pXRlBzL0xxUzd1YnBUUjlFK05LVnhHRmhFcm1aV1JmQ3kxUkVCWEdZ?=
 =?utf-8?B?RXo4WGtpWVBpbmh2cDUwa3VqUjc4bWM2VDZqVlpNeWdRbTNjdjVuOEpueW1w?=
 =?utf-8?B?MXk4cFE0YXEvSjhZTHQxYzZnTEhzQXVuMWVFMzVlNzJOdWE4NERzeFNNb01v?=
 =?utf-8?B?ZVU5YmVaUUNRWFFyTzI4Z0xJRk03M2EvVE11SEt5UDMwYm1jNDVRR2xIVUNP?=
 =?utf-8?B?Nm00Q3FoMm1yZVAwb3VNcWpBMWx4Y29PczIrclZncHJ3SHByaElOYmNsdTFY?=
 =?utf-8?B?RnRvbi9WeDhWcTVUcENYWXB3bmV0VkdjM004bUtINUJ6YWVyb1N2ODBlTGtU?=
 =?utf-8?B?WU9BK25jN1BZbXBaWExWL0ljQW00aXZpWnQ2WUZJZVFsT3h0WTRsUTU0R0VQ?=
 =?utf-8?B?K1JLWXBsd3lodW9hdnBsK1Jma3lISTNMdWlQYS9wT2s3Y1JSanU5aTJTOEdt?=
 =?utf-8?B?Njh6ZWVsSnFXNEhZNXdrV0RqSzJMb1QwWGFyRGZpN0c1R3ZZU3lDWlZKVHQ1?=
 =?utf-8?B?Q1I5R1ZJL1pCQ2wvUi9aQWpSdWpZWFB3eUk5SlR4dDBxZEdmcTA4aWMyODhp?=
 =?utf-8?B?bm9KSmg5ekUySjVqU3Vlb1BJVzduUmlEeWFGb252WDlyR09sUzR3bVBYYW12?=
 =?utf-8?B?TnEwUVBtbjduQ0tac2E2N1NYMnRtMTllNEJQbERsekppQ3FEY1VnSlJ2SXBj?=
 =?utf-8?B?bWVVRnJ0R1NtVDhDYVJVMjkzbllrTXZrRURSNkxJUFdZOEtpUzNiczZkKzNV?=
 =?utf-8?B?V3JBVGoyZ242emJNL1d4bkUzYi9FVmIzWEtCMVpYcko5eWxaL2x1MnNCdENq?=
 =?utf-8?B?aXBtcmdsMUNydXFVa2pBUDRCb1J5ZHRuaktKd1ZRSUV1a21ybHZ1Y1BuTUds?=
 =?utf-8?B?SVNaQThtN1Bra00wSnZmUXFOaHk5NkFpV0JUNmhBYk9MNzdLQ3ZjL1dRblJl?=
 =?utf-8?B?TkxzeVcxNkJpRnBvWnM5WHpGZktBb1JWRDkxUXplblVNaytXRlpwWmNnZkJP?=
 =?utf-8?B?QnN5MTBoQXlYWGVOMjV0SmYwR0pRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1B09CE53D34A42A357E61B19D20276@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bxJnfZPFL9TSZ7HChxHocZ0kgHywaR/2J6ws1ZZK3Zgx80XY+4+6tt9Yz6PL4TSRIj7Fr12M8hmKgXUsdveSq2p8+Kr390Jem3WSj0u6oNylTTzCKuSWBHTjwnaY7+R9W03CZnDLjPjuPTcqiFctqxtIEYt6u9rxXPRgBZ/VoGZT84f403rX4r8o+mPBq1qNyxU+G9HlseiZFkEuUdF3STQSqbX8HEUfb6J6T5R7+LUwoYpL+KHytQu7Eb6Pe0Jw4gMAXPnRpIVIz1i3VamEnRMWO5qfQ3FmQIsEsm3BAbWpBRvgtN3PnfBteYJk/ReSDjVuTBAY6n6sOHjV0yVkzFFssKyuWlNparR9k1OhUFsQbRBKHP6H9T6i+cfV6u9AhAUzsW4caPCJ9XInw3axQoq1kF0nEfT2zl/nawiuVXaGaz1mFwPUlXL6vC0XTiM6DisYK4DfkKdEJH0yqhoSDQkTgQ1d1JEIO2SJlGIpqe0b5n/RYN8t24wHzDEJNR7GpgVqS2vBPirovD62DFnhT2EOUkW4Op3pW6+xpPH0R46ANtpWMxav3rw1M4MI3B5l4wYTgmhk3fPvegHI0PPelJM8qoAiK1olgdhcXosU1AhbEkVycrVFTjqjW2B5VjyZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff36049c-1def-4035-a092-08de0806c3f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 14:10:28.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGik7kGm6BIXuofGRFTAZ1ww6RHp/t1Huq28/SIyl5EHPWLQe6EamL3euqJeThwgGI8dF8SjyzPVV7K7WF2J8uobjXuZTAPxkmDdSiob2bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8516

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
