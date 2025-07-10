Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C9286436
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126927; cv=fail; b=RYffpjwXxLCmX5CP8a4VPk15Srps/uo3sjPRek2S87oeNIQUFUU0zdE1vpDkWsO73pGkPJuZpzz6uTYf0f9nm609vNsrcs0qyV+JGifFNX1/vp61EJz8FU5nr+UGcsdkoQvkHAk2T9uTnZPJpM0BZ3xPBo9JJq7ycjbYDuhnV3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126927; c=relaxed/simple;
	bh=D6quuc6twspWWGTocD9kiI46DIypzkkjpwQaso37RZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4XWqVVIPnnn8OZ0Mt2x1K5vDx94m9GArcEF4SnrG4hwDUJCDIzvCs4wU2i9n4ZhFY8oLgrC4C75dPudyzoUlAb1XS9erjj8Gs4TuHBVRNr1OqbPlJJf67Nf51GeFyP2k5q2tBXOduBWs4h8j4NF4nHOTUlaRlrE0S621pmLWSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Vz92OdzE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vCYpj7D3; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vz92OdzE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vCYpj7D3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752126925; x=1783662925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D6quuc6twspWWGTocD9kiI46DIypzkkjpwQaso37RZ4=;
  b=Vz92OdzETm306fDvUllb9+gKEhqT6vK4FfDj8fll9Y+ZLmafoHJ1f/tA
   N9cpVwEVJvcrW62GfKOQfZ+fAyyEeEI7wakttE1L7rKmFguupGyfPfYT/
   qBQ2Bh2Ta8eb4Mh+jkbIh0dMc3E++xmYbh9QczXryf0yKZJL4lqGQZxF1
   eZA302uWgC19pmjmdkPmiNdi/quwMMtcCIoinFEmt7H87DeBmAgjx2Wew
   hbtXU7vF8/KIgmcWXztIWZVsoifcyolLYZOhjalLQHaUd28/QBRPGX+KT
   ax92cTNUiNRQeY4G9ONSovMV1xd4e2iyrjAkd4DNEj9ip8uIIzY/10Hq+
   Q==;
X-CSE-ConnectionGUID: o1OpKjviSLGxA6MUpNJ40A==
X-CSE-MsgGUID: 1kBi2SUjRfCpfeiga9S51w==
X-IronPort-AV: E=Sophos;i="6.16,299,1744041600"; 
   d="scan'208";a="88514091"
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.86])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2025 13:55:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWZm86F3mT5bYSJGcj5ASJYDQdShOPJTXhccAKkTW2IndHMckmmuf29o8M8OuqmBe3xGS1L9RIXiFLfrDslVqGUszLGdnw5DdDJGt4wC+BeFFPnPBdC4/PdldW5x1F08KrTLlbMmxT3YFyZHak4LRe820PFdcofSmnWnLczuwYS31EBbX1BZdrfRy78dl2Dm9r2epqMaZnB6Z98Qqt2+1/FBs2RN00+aypFewVmqd6C6y0FshMXgFyMfGEGgMFoRcB1bFCEFmSfYQLEtjmuKbXRLTOPi3oLkE1kRpkHD5CBUMNPveXvjWZ26DLjLBGY7d0ot2vVimeZ3kcMu7j92Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6quuc6twspWWGTocD9kiI46DIypzkkjpwQaso37RZ4=;
 b=I2WrxUGc8mR/IU9ZY86a/1/mopDAg1Et8qw8J2nIrNeFtLqE935fey38v/bkaR45+GwjOcfDFPqBDfAeu6ojDYHhNcGK37BwsRw0XiSOkuPApxTX5vCSGu6UCNB9VqIunU8SePe4YlGlNeT6D8xQIFWGzhLotQVI70QSn53069qUOzpYPyzYFHm592MG5TGq1XbzMUhQbrhi78iA0znOVS1YtxFa6I0yLlotcTl6iMqkGCJx55k2Ihd0rmnspiP5Fj7TkJoTwlouBx0UpECFw90pmIkX25HZWoALJM9BYvuIYK494XPlg7v2/BkgGT8pKzuFC8YbzZY3PYUYHmhRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6quuc6twspWWGTocD9kiI46DIypzkkjpwQaso37RZ4=;
 b=vCYpj7D3cS80i91HZZtZHdZhiqHZ4bnSxRdPLYzpp1UK3vFmw0OyS0F/GxBRgKVH6S9afxgp3tuwLorayp8UA3IFxvEr5EQCQBDaqH4B04eNXfqhAiKELRMxKfTjYaneyxo5E9nVfxdmOx3NFm3DydhnQ2KbqDf4jHshF90YGoY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7315.namprd04.prod.outlook.com (2603:10b6:303:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 05:55:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 05:55:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: Damien Le Moal <dlemoal@kernel.org>, hch <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Thread-Topic: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Thread-Index: AQHb8Mc5SBDvG05QgkaafWBcWGVVyLQp61+AgADxhAA=
Date: Thu, 10 Jul 2025 05:55:22 +0000
Message-ID: <07fa0a60-1541-4201-b4e9-b02a994c915c@wdc.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
 <de8c6c73-3647-4cc7-a8a2-6848b2f4607e@acm.org>
In-Reply-To: <de8c6c73-3647-4cc7-a8a2-6848b2f4607e@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7315:EE_
x-ms-office365-filtering-correlation-id: ae75d7bf-c23d-4684-fd53-08ddbf765be4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bU9mYndadEpVYVlHSkdZY1o5NWl2RjVQUzZvUjlqalhFRitYRDhKSW81WFFm?=
 =?utf-8?B?Rk5HaSs2c2t6NURSUFpHdWduektoUEFJRGRLbjZaeG1VV3Q3YVk1YWtrRkM5?=
 =?utf-8?B?b25BL2tOdHB3MW5pYThnLysrdlBlbWh0MXZvMmRnanlyd09jR2dRbGtMd21v?=
 =?utf-8?B?TFJMR0x4b0VSYnprY21ZR3FwUjB2K2RVNUxRU1RDWFRtenk3SkdvVTZlYVAw?=
 =?utf-8?B?S2tLeEFDbFE5VU5RWEZYcDJ1aGlnUEpHMTI0Q0VzQXhTUCtXaFZoYm9OeFZz?=
 =?utf-8?B?UVMySDBHc0NpUFZ3VzZGMm9yWnpOZUtnMUlYc3RJRnVRd1plN3ZUTS9iQ1ZU?=
 =?utf-8?B?MGM0c2Ivb0Q4SHoycFZKSFR4c2w1Z0ZpeU5jQzhCL1poR1RrNGhPeW1vbXo4?=
 =?utf-8?B?dzJrRERKT3ZSYXZrNDNNSXo4dmY2WEFUQzRjOVR4bHpoN3pBZnlidW1EaDls?=
 =?utf-8?B?YzdZZ0N3VVdaemxUUHY1dkFhaUg3T09zcUZPZitCQllTenJGNXg2TjVVNGdD?=
 =?utf-8?B?S1RMYjI1Y0pVdUtpaHoxUFNVVFFhZnpQRmNLZVJxN1NOZUN4NWd3Z21pdU44?=
 =?utf-8?B?VzJWeUtxUjdITktDenhsSElpRVBPMzRiR0dnQ3pZMk9oUFdDL3hhN3lDRGln?=
 =?utf-8?B?ZWR6YU4xT1FVSmhobTNrbHhtZEh2NUVud3QrVnA3YWtoTzEwaVUycEpXWGxu?=
 =?utf-8?B?UE1uczlsdGo5aXhSYS9nNkE1cHZna2ZjcU01ZWxTbDRqdlN3NmttZGlTNDRD?=
 =?utf-8?B?bnk3VG12cHhvZEx2dDhnQ3BJdTBodHRFeWlBbmRpSmpOVjhxbFhSTUN0dnM5?=
 =?utf-8?B?SDg4S1U4ZWZiemE2RVdkc1BrZ0NvaVUxYWJXeXpPS0hJaFV5UE9wNHVRS3Z0?=
 =?utf-8?B?WWRCV1VWTUcwMjM2akhBVWZPc3JpWHlsM1k2MkpnQm92RTNlako5bE9RdSs0?=
 =?utf-8?B?RnlrSmlaakZoN0tyK0wyNk80VTIyOEdCUXIyWlgraDZMa3VyRWJYdzFoU1dI?=
 =?utf-8?B?cnVsM3I2eGlJcVVZR2dQL2w0bWlpNkJhSHJXVHhsYmdXMk1RU0VZY1lzVm1u?=
 =?utf-8?B?Rlg0MnZadlc4akd2SHFkYnVDZXFaSXpESlpMMFdOUERFeUl1UGlnRldONVYr?=
 =?utf-8?B?KzVNU1ZkWlhUUi8wUTU3QjVRZUMwWkg1L2ZUOTMzU25IWFFYKzVsb21rSWQ3?=
 =?utf-8?B?NnRpMHlrUGF4NzZJR1VQd05MWFRWWUY0MHF1WWpZSUl6MFJqWUFJV3RmSDRq?=
 =?utf-8?B?QkwwbnRPVjRtODRDZEQ4K3ZhT0hlMC9LOGtYL3B5NnZCbGlSNklOMlJ2MGdB?=
 =?utf-8?B?U0lnM2Z3SFgxZkxkbmZXbUtFUEVHRlY4SlBRQ0VVNlZNZmhrdXZsTGIrd01W?=
 =?utf-8?B?ZThzQW5Wb2diVWFpSTY5OEF1c3dObXVqejlBMGdrVlhLVWwyNmdMRkVMTGxl?=
 =?utf-8?B?NnV1VldrZlgvZnNvV1FvTEs4WWRBd1lRR3g3aTFiVG1XclE1bGlzV25FclJS?=
 =?utf-8?B?NUdIdFQzN0p4MzZFSnNjajBjc1RJZXNwWWJHZXk0V2M3RHM0dVQzQmxZbnlC?=
 =?utf-8?B?Nms3VG5tWUxpSlBteWk2b1Y3cElqQmgrMkRzQjNaaVYwQWlNTzdVNlo3Zm1r?=
 =?utf-8?B?R3VhSFFDb1hmYmgxVThkRXg1YzVSdjVmZlNQVXNrL0Z6TStPTmQyd2RHeUhx?=
 =?utf-8?B?NW5sTTUwK1ZEaDU4REhmV0hQeUVwSld2TjF5WkdZaytMemVQRFE1OXA0bzRu?=
 =?utf-8?B?bEhmOWw1UmZBNndPbzBvK0Q5RHBhT3ExVTVPaGliQlZXQ3VCa2hwUkVKQ0xQ?=
 =?utf-8?B?TFROQTJpOTNTeGhLd0RBb3VtaDFHTS9GRCtONXZGVmp0RWRlQ1VBMUh4bHV6?=
 =?utf-8?B?R0VFOENIUy9FQkc2ZFdsSzIrd0pZanlIV3ZrT3NnWXQ4TWgxQVovUEZsRG1o?=
 =?utf-8?B?a1BXRGx5cWVoTXArK3hoWXFhN0dEc3hHZTA1QkJNRFlIMXFrcTFFVkNubVNa?=
 =?utf-8?B?ejB0QmNXcGhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1hVaVZyT2VEemQ5QjFqbjVlSWNHT3JGQnhTRTZ4cVlEMjhKZFltZkt6d1hs?=
 =?utf-8?B?SjZlOHVmeEhTeVlSa2VpNzhOcFVyS0F5c0lveU5LQWV5QWpwK3dlalAxZS9C?=
 =?utf-8?B?bEpTb01tMS9YdjdkTy9XRFFPaXd0eFozM2hRcGQ5cytoL2dkL3BqSTRLc0dm?=
 =?utf-8?B?UlkvUENYWGVUZ1kzc1E4NmkvWm9yczZLQXp4NUZUQ0o1SDRCWXB6VjRGdStC?=
 =?utf-8?B?TkFjSFhldG1UNEJoa0YrVWNHbExRdVE1eDJpQU45WU5waHBERHkzbDJNR2ky?=
 =?utf-8?B?MndCdlYzaFlMQXd5SlZiNlBtNDNzejF1dWpma2txM2lhL2IxYjhQcitmM2Qx?=
 =?utf-8?B?OW9oNmlDeW5BSmk4aWR2MWxQbEtWbkVmUTRZc0swNHppTmYwV1BUaHBjWmZq?=
 =?utf-8?B?azAwWG52bUc4UHd4OEk3ZnJVdk5pUDJoS3dGZFZGSEEzQS9qS2lUaTBGWHl4?=
 =?utf-8?B?MWp3QUxDb3docmhyeWJvdnFOTzRCRmE0bmcxR0lTRC9na3lTakJlazBQODZn?=
 =?utf-8?B?UXNKaEt0ZHc2bFkvTUNUZjRFOHVaMEs5T01kd2FOdHIxNk5McGlEdGd0dzhC?=
 =?utf-8?B?VHJEd2FQRklKTXZteTdhdVJsR1NWS1dCdEdWczYzVE1SanlVRW04TEpGL3Fa?=
 =?utf-8?B?OHd2aXhOY3VRVzFwVmFHemsxUXI0RW92SEtYTDJvUUExTHBndVZrSU14dStS?=
 =?utf-8?B?QUx5bTk2UUtnZW51V0ZONjQxUnJwR2JaZ2VjMW5nSDNzZ1JnTWE0Wm5VWDVy?=
 =?utf-8?B?N1VKSjNVRytxVCt6dEFWZnF6dWU0UXVzR0tyZGNSVDlXQndUTnl0RGJCSE83?=
 =?utf-8?B?M0hEdGdVYkp5S1A5amt1QWdlTy92eFg1ZWxSVkV4elhlajlUQXYyTHZJZ3BM?=
 =?utf-8?B?TXZLcElVTk82VVdrQnZQM1lJenBDMUdmczJvV1JQY2xVSUdhQWxYZW9HRnVt?=
 =?utf-8?B?VHRuSElNMG5maTBycUNuVWthNXAxQkdLa1ppelJSOEEzUnU2Lys2dmloQThw?=
 =?utf-8?B?YjN4bldhYndxNTFkcHFkSEkyS2hudUt1Sk9TV3VYRDhkMXFNUkhnVkVvK05Y?=
 =?utf-8?B?YkZEK3FEZUM1YnVVWkEwMFhYNjNCZmJZS0FjcDZGcW9IaTF3WUxBdFJoL0Zh?=
 =?utf-8?B?anI5eEhpd05ES2lOSklGdmpIZEFSbk55ZVhKbnExTDlNdm5VZVpyOUhFb0pk?=
 =?utf-8?B?dTNkNVdaTmFDVWJmUTNaaVRtUHdzODU3MzJBNU1XT0JqblBmdE83MXpoYlcy?=
 =?utf-8?B?VjEzdHE1anVSWXllT0hzc3FROC9TcGFRMGFEdzdVRTA4Zm1XNUxKVG5GVnhL?=
 =?utf-8?B?VnNvZXREYno4Z0NtYXhSTkhkcHZzQlJ2SnAxZm5Qb0tpYWZBSDNad1EwR2U0?=
 =?utf-8?B?N2Z6VlJuRm44ZDlQclFTbVZDemlDbk0zZ3E3YkVkV3p5d09QL2ZBV3dXY3Vw?=
 =?utf-8?B?alFyYkRiK2tzYklrY0JMclJQWG5zR1MrZWZpT084NVgwUlRLNThwY0NpZ09W?=
 =?utf-8?B?ZGU2N0FZWk9DWXBtMDNhZU8xRFVQM0RkbnR5OUhubjdwSDlnWE5pOVhzRlRL?=
 =?utf-8?B?VzhkbXpGMGZTb3dYOFF5VnFlSXYyTTZIalgrS09ueHZ5bWd4WjAwL05xWitM?=
 =?utf-8?B?S3hPUVRpVm5uU1N1WEFwb3hUYnBJSEx1TFl6VzZxM1BZUTRkRXh2NHBkbmlX?=
 =?utf-8?B?UmxuRDBzcUNzazhYaDNWVVRFWXoxMHRoRlJoeFJGSWQ2UGNVMVhyejR2ZzJ5?=
 =?utf-8?B?VmJUT1lmWXNLdm5yVFVLekRoM1pNcmpQcU9JazdrTXBER2gzQjBneUNJeWF6?=
 =?utf-8?B?WDhBZlE4YzVsRHVNWXBrY1R4RWpNVkw2dVluVlJ0bEhQdjNSMnpFRXUwVXhi?=
 =?utf-8?B?TEFmTW56a3BNaWlPa0hiTGtCQSttSDZvcnVva0xXRlZHbm1VWXpQcUxGZ2lx?=
 =?utf-8?B?bFNHbm94cXRycGZVb0JqL0d4bGhid3FTblpmQ2EzNG5Ub0lVSThLdXJRbURn?=
 =?utf-8?B?ZUdBNmFsZmhtOEdrMmZObU96RS8xNGdUTUV2UlhRL3cwVFFJSkVFdERSZGlE?=
 =?utf-8?B?YkVPdjFEbS9wVXZPZTNSbHRXUkI4VXl2dFAvOUFNM3oyRkgrQk5zYVhseFpU?=
 =?utf-8?B?K2xFQnJBTmRQOUNBSFdVYnBuelY2SU0rZmVxenpmc1Y2dTZRdW95N3BMN3I5?=
 =?utf-8?B?cmU1R1RpeVM2SXZyRDY5VmRuRk1ZMDBmeEcyUzVhYjFRdVNhVWQrQ2x0QzNx?=
 =?utf-8?B?YTR3bW1IU1FzOXVHTmVURldrSlhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEAD064CB6ABB2438F370FBE494B64A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yPDzNbFg7tNxi8iKkH/GbERdxMYKRg+ug4ZoFwaaVOVzXymRl9e45B8PL6oL71OPOUG0ZDAJd1rh81grLjZbAqoJBNFu0MHha/e1pR8K5MisZNKsJVK4MeE+HrhgFzcTwugsZIztz0TBiYZTICmO0MvUYFv1pmqt/JEUUKG4NWXcyDzmauiJlJpDuZtHNOCwJzD17kehe+Qa47PPDEl2JR66NZq26shq1prmSytgZWTzbynEMfqnkOClV9ip6vzmojTc+3yJK7GkCO0GXj1OnSA3uVC3OVa20vYKNPLIYjZFoiqITT0fMoPST35Bc63sylhzqhOd1XQF1PYbTy3Kf4L6s5kB2xyeQll//z7O+S8gOvpuiukQ4ppsbMxjv8pr6jkO6kouHuIN74I4Qxptd16rimzfBH24+20I3ey1w7a9CqZWK0NUzWiX8VxApXXCe4RhZMfXOdbQlbsdqtMeCGJEkW3BUxfcnomuhPWsQOxpLH12HXkZb6KUe0T/VQ/1quFkZGP1ChYd84DZ8WULRandgNIiUpIPZSIb9gZO/erMduzrVxF7d29gYhAMS0nc7QkwA/cF3T7y90YbBmJB0AeucfjuVontGa4NDpAJ87ZenIXjmiYlA3rLg7gVkCHb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae75d7bf-c23d-4684-fd53-08ddbf765be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 05:55:22.4908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKC8HhVoh9S5QMQxhLi63gc5YXUlrkJZ4kJuYs6X/4agI9ZtM2i9px0h5kRgVx9H51xZx//gc2AytjeSJqm+8ExOGfRB7JpxhWZQHkTlyvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7315

T24gMDkuMDcuMjUgMTc6MzEsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNy85LzI1IDQ6
NDcgQU0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEFkZCB6b25lZCBibG9jayBjb21t
YW5kcyB0byBibGtfZmlsbF9yd2JzOg0KPj4NCj4+IC0gWk9ORSBBUFBFTkQgd2lsbCBiZSBkZWNv
ZGVkIGFzICdaQScNCj4+IC0gWk9ORSBSRVNFVCBhbmQgWk9ORSBSRVNFVCBBTEwgd2lsbCBiZSBk
ZWNvZGVkIGFzICdaUicNCj4+IC0gWk9ORSBGSU5JU0ggd2lsbCBiZSBkZWNvZGVkIGFzICdaRicN
Cj4+IC0gWk9ORSBPUEVOIHdpbGwgYmUgZGVjb2RlZCBhcyAnWk8nDQo+PiAtIFpPTkUgQ0xPU0Ug
d2lsbCBiZSBkZWNvZGVkIGFzICdaQycNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgICBrZXJu
ZWwvdHJhY2UvYmxrdHJhY2UuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KPj4gICAgMSBm
aWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVs
L3RyYWNlL2Jsa3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYmxrdHJhY2UuYw0KPj4gaW5kZXggM2Y2
YTdiZGM2ZWRmLi5mMWRjMDBjMjJlMzcgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvdHJhY2UvYmxr
dHJhY2UuYw0KPj4gKysrIGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMNCj4+IEBAIC0xODc1LDYg
KzE4NzUsMjcgQEAgdm9pZCBibGtfZmlsbF9yd2JzKGNoYXIgKnJ3YnMsIGJsa19vcGZfdCBvcGYp
DQo+PiAgICAJY2FzZSBSRVFfT1BfUkVBRDoNCj4+ICAgIAkJcndic1tpKytdID0gJ1InOw0KPj4g
ICAgCQlicmVhazsNCj4+ICsJY2FzZSBSRVFfT1BfWk9ORV9BUFBFTkQ6DQo+PiArCQlyd2JzW2kr
K10gPSAnWic7DQo+PiArCQlyd2JzW2krK10gPSAnQSc7DQo+PiArCQlicmVhazsNCj4+ICsJY2Fz
ZSBSRVFfT1BfWk9ORV9SRVNFVDoNCj4+ICsJY2FzZSBSRVFfT1BfWk9ORV9SRVNFVF9BTEw6DQo+
PiArCQlyd2JzW2krK10gPSAnWic7DQo+PiArCQlyd2JzW2krK10gPSAnUic7DQo+PiArCQlicmVh
azsNCj4+ICsJY2FzZSBSRVFfT1BfWk9ORV9GSU5JU0g6DQo+PiArCQlyd2JzW2krK10gPSAnWic7
DQo+PiArCQlyd2JzW2krK10gPSAnRic7DQo+PiArCQlicmVhazsNCj4+ICsJY2FzZSBSRVFfT1Bf
Wk9ORV9PUEVOOg0KPj4gKwkJcndic1tpKytdID0gJ1onOw0KPj4gKwkJcndic1tpKytdID0gJ08n
Ow0KPj4gKwkJYnJlYWs7DQo+PiArCWNhc2UgUkVRX09QX1pPTkVfQ0xPU0U6DQo+PiArCQlyd2Jz
W2krK10gPSAnWic7DQo+PiArCQlyd2JzW2krK10gPSAnQyc7DQo+PiArCQlicmVhazsNCj4+ICAg
IAlkZWZhdWx0Og0KPj4gICAgCQlyd2JzW2krK10gPSAnTic7DQo+PiAgICAJfQ0KPiANCj4gSGFz
IGl0IGJlZW4gY29uc2lkZXJlZCB0byBhZGQgYSB3YXJuaW5nIHN0YXRlbWVudCBpbiBibGtfZmls
bF9yd2JzKCkNCj4gdGhhdCB2ZXJpZmllcyB0aGF0IGJsa19maWxsX3J3YnMoKSBkb2VzIG5vdCB3
cml0ZSBvdXRzaWRlIHRoZSBib3VuZHMgb2YNCj4gdGhlIHJ3YnMgYXJyYXk/IFNlZSBhbHNvIHRo
ZSBSV0JTX0xFTiBkZWZpbml0aW9uLg0KDQokIGdpdCBncmVwIC1FICIjZGVmaW5lXHNSV0JTX0xF
TiINCmluY2x1ZGUvdHJhY2UvZXZlbnRzL2Jsb2NrLmg6I2RlZmluZSBSV0JTX0xFTiAgIDkNCg0K
U28gZXZlbiBpZiB3ZSB3b3VsZCBoYXZlDQoNCm9wZiA9IChSRVFfUFJFRkxVU0ggfCBSRVFfT1Bf
Wk9ORV9BUFBFTkQgfCBSRVFfRlVBIHwgUkVRX1JBSEVBRCB8DQoJIFJFUV9TWU5DIHwgUkVRX01F
VEEgfCBSRVFfQVRPTUlDKTsNCg0KaXQnbGwgYmUgOCBpbmNsdWRpbmcgdGhlIHRyYWlsaW5nIFww
IGl0J2xsIGJlIDkuDQoNCg0KSWYgeW91IGxvb2sgY2xvc2VseSwgUkVRX09QX1NFQ1VSRV9FUkFT
RSBhbHJlYWR5IGlzICdERScgc28gbm8gY2hhbmdlcy4NCg==
