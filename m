Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171141D9526
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688678; cv=fail; b=PndJYWVQ1/pFb0dhQvS6iEZL2icPR3MDY4y+7BPJr6RWpsrtRplcvwUYARjHivYmktoOLVOKI1D2yitCvqSeObT6ZDwZzSwF7mNTnx9cbFMZjGzysFKAalr8gLhMZNSMlKJizrbABftz73hqpo+20UPG6eNk8htVAUsQJPTIPhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688678; c=relaxed/simple;
	bh=IEmRgHo6A8xWX2HWBC4ZEM2c5ruef1vT5oGvhxS1kpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UeyrF+LlIAF4ItqhfP9jgNBtXfmool8fj5PpdohPdoV85tx5K0lZB4z8G+Y5y/n0Cz+K3AseE3zDQCt3+w7fjzqhDkyfjaa0VB6WHw5wH5N9Qx5Sk6VRvmeqzL0dPGXkuZBcpyl9N1q6mBXdkqIJd5IE4FjcBExCqKuw2P4DsU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MPYWuMd5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hFk7gYXa; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MPYWuMd5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hFk7gYXa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718688677; x=1750224677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEmRgHo6A8xWX2HWBC4ZEM2c5ruef1vT5oGvhxS1kpg=;
  b=MPYWuMd5IghxIL5ZFaxm8ZLzaQ3osTvTEATmT8UGVT0zh9yE36JlQUos
   fwF3S6pkStxWCS20A9BNgBiz0l5IN5mwbMxsC9KXTu6t4AhppzTwcUHWX
   9Mgq3xcRgXfhROFLJCK+xpEKE/h3a4tixGpjdWCtp9OsjXhqqb+kOKBlN
   nPHcHFj5B/+6CRoKX5SISB1WLnWkD6kvKvqBTcYXCO9E9b+Ek93wMFgUp
   rGlVOUbMxw67seOUw5ZxCDkRM7EDvcRiLYQuxadYYZ7VPkubhsk4QhRGu
   qwkEygPYa4F3FfVLwfBIwufqg04v1w708Wcw1PtWKpV8dskWQh5SYTHue
   A==;
X-CSE-ConnectionGUID: lKbPVTo4SciEpMuljmLHxQ==
X-CSE-MsgGUID: CfVd9jsGR9eC9yPzXZeauw==
X-IronPort-AV: E=Sophos;i="6.08,246,1712592000"; 
   d="scan'208";a="18615360"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 13:31:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAf8RjJHcSbuSeMprCrdijd3wo3sh/FVFyXBMyRCDuTkDwHpwfK5b5LAB0sXnvCtdej1i3Nfy99afqC0XfLlGxi6YGDFQeYP2sy12MB4d6UoAqZ2L8boheBY3+UbLrX7F27TawLbxT3PBxPi2YARf/xUV4d6R0t5idGP+aJ+Idr1N/nmL8BnVV/VICU/EvfGQti4T1PBTYVhaI6OL+mIOzU3eDyTwNRqOscYChgxcPz5heKnupqRw67CmyOzQZAI9WJxII1MznPIwLmZEayhF6tUrBPtiwS/kcEgUr6tWCeuXN9bFTireDUKVmSDs/wPb4mMAacEaqwCkI1kh9R8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEmRgHo6A8xWX2HWBC4ZEM2c5ruef1vT5oGvhxS1kpg=;
 b=P54GBFLojRJxeKA2kutisk5VtDCX2Jlj8+5scZ9Z0Adeh/9ffekCwxA2htohmxCISdYsvABtNIE9LOx6tSwJ5i+nE/IdlK+zCM38titwftP5CyBZ7ZtaBzWuJxnJjfxviGQudrZ12pJE0iOqQdu8YfaqnMEqGI6uaAraK3ardY1Ftgly067J88TLvUs42sgS1b5wDPBmaN7Vxp+vHWwtEhh0UZPlApWYDWIaLKIr64y8zlmSkY0nKKLAoM5YPfXcGIZJeJ74A82m7i4wxRLA5W7zfJZ96uK9BBk5c2PRsrMQJXbz1AX7NGZ60X6Vf5ncdcrzkmomQoCxk8wG259lSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEmRgHo6A8xWX2HWBC4ZEM2c5ruef1vT5oGvhxS1kpg=;
 b=hFk7gYXacgUYU5xoN9i6yAGwg5hJS2HtJVjwdK7QD4bIBPaQngD0AViGHyte3gbgI8ln9U+peeIEPlpKhkQL0SP71FfjX4/+FijCU41+Q3J/miX812mM8z9A0Xpa2Hm0w3sz+OJBjRBu5VIe9gIu7hF38+W52lczv3ztKk8IUiw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB8743.namprd04.prod.outlook.com (2603:10b6:8:12b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 05:31:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 05:31:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH V2 blktests] block: add regression test for null-blk
 concurrently power/submit_queues test
Thread-Topic: [PATCH V2 blktests] block: add regression test for null-blk
 concurrently power/submit_queues test
Thread-Index: AQHatuTvd0olZPDMMU2XR/h7zKqLxLG5D9uAgAAClQCAFAE+AA==
Date: Tue, 18 Jun 2024 05:31:14 +0000
Message-ID: <vetweqm4sox55g2qff3t5s4fpp3a3imb37tuk32tshm4s7h5ez@6yletkpsvkma>
References: <20240605010542.216971-1-yi.zhang@redhat.com>
 <a4djmoku2cxfxhxrhgdu6b7vqyi4idqdzza7fx37ps2hdyorld@ababkd4e4zzd>
 <CAHj4cs_QHjtLjsmZs2myDQYzzFfMeTQTCEoXY_huiPzUD7BoQw@mail.gmail.com>
In-Reply-To:
 <CAHj4cs_QHjtLjsmZs2myDQYzzFfMeTQTCEoXY_huiPzUD7BoQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB8743:EE_
x-ms-office365-filtering-correlation-id: 6eb4fe33-0552-4bd8-676d-08dc8f57df10
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ly9GQ0Y4Uy9iODV5bTJUSHVyaDQvM3NwaUtFYkZ1QjM2OFlZa2ZaSTQ4eFM0?=
 =?utf-8?B?NC9nVFJLUUhrb3BZVEdyTWhJVHRDL2JoQmhCbGY4QlNNS0V2eXhwVTAyd0VV?=
 =?utf-8?B?ekRPVFJhbXRhSW44bEZpbHZmWHB2UW42T25iemt0dlg1dWd6VmwvTTZzbjdY?=
 =?utf-8?B?bWZsUjlUS2ZoT0oyenFBYUgwSkNxekt6bldSeW5MdnFyZThhbndhRldwbXBx?=
 =?utf-8?B?OSsrKytOUE90R1VRVXpTTi9ocWs4OW84d3N5NHZjTzBzL0dBNnc1d2dxdVMr?=
 =?utf-8?B?eVgwc3JTTm9WK1EzUVdwSGwrbmtUUG9yT0VGaTBoRkVUMW0vc0daT0JrTDhi?=
 =?utf-8?B?ZFRkNU11OC9VTE8rRWc2YU82MG5mZEc0K2lsQ3lrWW04NjNVRDhPVFlPd1Fn?=
 =?utf-8?B?dXp5WlhFa2NySlZPZm0wekM1TnpjT0x6NVpvQkFIcFhHM1lNNElRRm9Fa3pu?=
 =?utf-8?B?ZDZXNUt0b2V2dVBJejRLNlgyb1J3L1NHUnMyKzRBYkhOaWYrOCtLakZ3bXUy?=
 =?utf-8?B?ZDJrYkR3YWMrSmJlUjI3bHY2aVdsNzFtdTJyck9KamdiM3RNNzE0bVAxdG9u?=
 =?utf-8?B?ekh2OE9aK2lUMmRaZWpjWmdTMDduRlJIeVhpelF1alQyZ1FhZUhicEN6OGMr?=
 =?utf-8?B?K3BXT2RybjMzUHE1Nkt5VzNyc2FrQ0pERWNxamd0aHlvVFNLRTFoajhNTWFq?=
 =?utf-8?B?VDFleStZMmhRQ3lRTlpYT0dsSjNrN2R6K0RqSE9sMXRFbllDU0JHcFN2UERn?=
 =?utf-8?B?UlE5Vyt6cDNaZWl6UmdTbkdBRTFjTUlGWFVUdWdvbDR5KzdEMGExRTJrYnNt?=
 =?utf-8?B?QmJzbEcrQmRzejZkUFVnYWN6MnZoN2xBQ1NHRXkzVTh2QnJ5NjNYSExFcklC?=
 =?utf-8?B?eGtkUUI0blZURkQ1NEIrNzNMeDJkVzVMYnRueVVhdDBZNGt3RFpuUkpWbkVr?=
 =?utf-8?B?eU9EKzAva3d0WEZQbm5OSzhqZm1xQzVyMVI0ZkFSMUlrTWVMa3NLdUVYSGdM?=
 =?utf-8?B?RVBzRDFBbUVoVzJ3NUxVMU1BSklic3V0UytoWDVwdDFHOHQrNm92ZEt0bkZ5?=
 =?utf-8?B?VjJSVE5nWDI3VWh2emFUVk5oWmlXQ1cwako2dGdlZTF3djY4TVBBa0VidjBX?=
 =?utf-8?B?SDh5b0o0YXI0SHE3TTRMRGExRXIySSs5cEVkWC9hNHpINDdGUCtiUWprSjNB?=
 =?utf-8?B?YlZZVHI3OEN6MVpFZ3hIZEFySHU0QnM1YTdRL0YzeHp3dk90ZHc3ZFkzTzNz?=
 =?utf-8?B?Wm1makxTcUpta2VMdkQwbzUwcjQxcGJjVmhiT2dOajh2TG9PYUZtQWFoS0du?=
 =?utf-8?B?V3h2OTlBMVRZQXNCbklhS2dCeXNkVUJ1cm9qOU5wSlUwWmxDL0V0dzdMNEk3?=
 =?utf-8?B?RS8yVFo1SCtGRHYzbnkveHJKa0RXNmRkaXRiaWxKeFJZWkhTL1BPVGFmTDJH?=
 =?utf-8?B?VHYxazgyTGQvcTQ4a0FyMFdOUnRTWUpQQkFrazZadmRoTDNmRHBDMDRmeURo?=
 =?utf-8?B?QzZzRWhJbEVsbERMZDFKcHhzUkN5dFdCVmZjbSt2MWU4Nzhha2plN0R2SWs0?=
 =?utf-8?B?UFUwK21JV0VUbEliaWUrWTVCc2JRdnpNbW81SWZDaDFyUEVCbFVzNmNrck9o?=
 =?utf-8?B?dU40Qm1VUHVtMm5PNHh6VlVqYmJrcFF2MXhxelR5MXdvRWJqMEZXQnA2dEx5?=
 =?utf-8?B?QUhSaDdNUEJVUmxQNWh6c1g2Nzd3QVNrZlRzNVZlZnZiT0IrVEhHSEdVT2pE?=
 =?utf-8?Q?2XXKA12DjrJGJu6I6u7sYqw5hd26yYEfL0BMhBi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cCtwUEhCOVBuV0drd3pvNzBZUVRoVi9zT1pvbnFtbjdtenVrdXhCRW52bGhN?=
 =?utf-8?B?dUswRUE0TFY4YWIvamNQZXluSnNMQk1GSEF1OWYrWGZGWmNrOGptL0xqUitu?=
 =?utf-8?B?cHoyK3o3Mkg3UThmb3FQdkhJbjZ6VWMrK2ppSEtMVnJnaVlzeFl6S0NVdWxm?=
 =?utf-8?B?b0NsV1F1NnMwRG5aQWNDMEFHTVVOOVJYd0hINXNkTUJKVW5oTlE5SEtJS012?=
 =?utf-8?B?ckpGWHpuQnlVL3BmQStXWlJzcGJlUlZhT1duN0Zla1I2L0diT2VXMUlNeGgw?=
 =?utf-8?B?R21tSEtSMTdCWHgybTBLbFRNZVFaZ1M1UjNicW1PdVhEVUFOdmZNa0ZGVlZO?=
 =?utf-8?B?Sm92MjBZbGxiTys4VmpGcjVPcThUb3ZmeUVIdG5YdEFXQWNXLzRtWkhSYkJT?=
 =?utf-8?B?NFlDNG9RRFRoc0hUajh6S3dJeUw4VXhzbC9tQ2g0MnpCVUdHam5hQTYxbUF4?=
 =?utf-8?B?bHFiNmhYT2t2WjJiNU5seXBuYS9RTmdmT0Y2MkpJS2JpdE1YWWRpNFZjaUdm?=
 =?utf-8?B?NFJ4VG5PdWY3UzUveEVxNU0wUnNrV25LZ1dMVU16TUVnaDk3akZYVHp1Y2po?=
 =?utf-8?B?a0JkdUZFeTZ0cXJnNnpQM0pFeE82cGZJa1VGenNqWVZZYVAyUG1aL1ZuTFRz?=
 =?utf-8?B?MUw2elZlZUhqMENRdlluREV6dHZ0ajJDdng2WGc4MGVDTWJkVy8rdWVxR3hp?=
 =?utf-8?B?bjhvdENwYi84R2o3aGMwN2JTQTBFVC8wc1NiVFY2bUd1Q2pnZk4reU9ZNUdI?=
 =?utf-8?B?WUJkZUxRelpoOG4vcVFHdUNuaE1XVmU3eERrL3hxZXFHczUyRWE1VlQzamQw?=
 =?utf-8?B?aW5xS2hJRzNzUDRTTHpDUEJFZE5vSmwvL1pOYjJ2QUR6S21ISm1nY0FJMmY2?=
 =?utf-8?B?TE5vcTBhbGZHWXNZTDJyMERudXhObVp6VjBWY2VJOGRiUXBibzFkUnNkTEIv?=
 =?utf-8?B?VFJTUTJQM01aUnZVSW9FeFBQTWV3L1RLME1IU1VFYjNRZmM2TzVCa1VZcFl1?=
 =?utf-8?B?N3hXWFR3OG9QdmZXa3NMWkd1WllDK1lvYlVPVEZmWEN6R1k1KzhlcVlScU9L?=
 =?utf-8?B?VDFpNVhqTlp2dkdTeUdxZDBXSnpRUWtNQ0h3ZmFrQjBwWjEwcDU4SDI0NStt?=
 =?utf-8?B?WVdBMWVDaU1NQzZFTWU3QmNPaFU1ZlhsRm11SVNHUCthWHNOOWNqeUVaVHdG?=
 =?utf-8?B?TnRwSitySUU0UGR4WkpNWTh6Q2c2L0lIQ3A5S3FtWGhlT2d6QjczZWtyNHhG?=
 =?utf-8?B?WTVXVDNLU040Vi9XSlVuRSt5NVNDZHdPNjcrZ01BTW9UaGZWQ0RNcE5HcnZX?=
 =?utf-8?B?VnczU2tjcld0S2hlQy9NbHNiVDRmZjUzUWZGR0w2UE0xeXpFRTF0NnMwcm1B?=
 =?utf-8?B?WDROcFlkYTVCN1pHc0JxQm52ZVpDUllhdVVtVnVRRTJlR2prSkNoWXBOR3lK?=
 =?utf-8?B?OHV6ci9DbzUrSlZSQzVKdmRUUGQ1UVZ0aUpOcFlYRE9UZWE0RXN1ckdtK2VX?=
 =?utf-8?B?WE83RHNzL1hJK0FiTXVWZDgzL2dxNkJBeDV1NXdvSXJ3bnlsd3NXajRLMWM3?=
 =?utf-8?B?cWx5Q0tRNHVhZld4b3VqN1lLN0JXQjJaUy9CVnV0ZG1Id1h2Q0JUek84WlBI?=
 =?utf-8?B?REZBRVJmWCtKeFZqSHZUVVFycVhNOElKUWxLSDRlQk5POTR1VHMwVm50eXo1?=
 =?utf-8?B?T0EyckwxL1JIcDNFdFQ0SWk2ZldHeEdWZVRMdHFWaDh5U2VlTGFiZlQ3TkZs?=
 =?utf-8?B?MXNXL0FUWEFxVHN1c0N0Y2hQMCtrR2FHRm9uY2h1TU11bHFYcmY1WncvTTM5?=
 =?utf-8?B?R1BjS1VHMTdVOWhEU2hodmpDSWJNV0RqRmJVYkRBTmxBYm8xRmo3NkhiVTFY?=
 =?utf-8?B?MU5jbWlIZWNPRDBnUXptTGwyL1BzV2xLbEk4Vm5MSldyN204cGp5cFBaazRX?=
 =?utf-8?B?SzhJTG82MHdsR2x2aFRab0ZrM2ZBeWxKREhTbmRTY21RRUxPbGJRUXZNbkFE?=
 =?utf-8?B?TXZ6ZmI3OHJtR0poMEdvL01YUkY3dXl1TmZQTElod1RnRDZPQWVGRG9WOTM5?=
 =?utf-8?B?RjEyTDc5WmxxU2hCc3RnMWRRQnY0NUVZSlVnRmZOb2J0TkU2UFI2NlUyYk50?=
 =?utf-8?B?Wm1QNEQvQTltVFkrT0F5NlNXNmI0Z2NObHp4b3l6ZlVIeGFhV0hDL3BJbXdQ?=
 =?utf-8?Q?6Hw4mjda1w0iQ0sf3l/ha0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91EC5B64FB8BDA4F891EB5DC3DE5E0A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t6Gbk25h7dD50oft4oXRteSJg9xi/5XwkqWBgWy8Wl6xsdhxDmZYJE6uMIi65qFKhKQ80EqmNLSaJDSd5/82ysJGqRM+TeA39/5goT9k2cvYmvME/sArSr2OcLJUexenJCRJ1easfOCRcuHZvtUx6lTqPAKC/7tXrrauETLJ421/aGIERNG9IxFBawg1jf8sgN3B6jn3+CRA2GilRyBlgTg3vC9gPyCuKCOBXho8+R5JNG6XHl2E8KRncevbzBONE8Hyz7dCUoLvgQiDKTDnLxCVHUZEV60lm3lm05APfc+y5vbbTkZ5y7F9JxdgGnSoDHm1ROj3docSrCFVxaC7rLCQ/1v3SKKi5OuL/bRBHh/axBc2KalTT1Rge//vT71nGkJBe/P5aeFuXsFTCdTZRwZTjyEn5X0pA3tWwa5MIdX7elLjzHHjhnuZAaGnPXEOWBBWzn4plucbeJOvtwmcFPq4lxze2Su+6oNOSvYLRVCHKM3KOzHZCiWZ0MfjuJ0SqLg0sN5695DiFjec9vyW6i7tIMQtWgV/AdQ5Gncxttq+j7V69+KEtxJPf+VyeAB0r+fysN61QpsvUzIG/T3jE9x8XZjm7aO2yxpqKSXFo4/gqz6I2lmjTFAXVg2IvYwg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb4fe33-0552-4bd8-676d-08dc8f57df10
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 05:31:14.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RH8YFVpXKg64i536sggd7Vz2w7DM+QTZ8z692gg46Wm2hOo08jTlcgXkOSikY6CsU0X0x/eVo5BU9V9VgJIr9TaxbZK0umYQjQfdRrq0wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8743

T24gSnVuIDA1LCAyMDI0IC8gMjA6MDEsIFlpIFpoYW5nIHdyb3RlOg0KPiBPbiBXZWQsIEp1biA1
LCAyMDI0IGF0IDc6NTLigK9QTSBTaGluaWNoaXJvIEthd2FzYWtpDQo+IDxzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gSnVuIDA0LCAyMDI0IC8gMjE6MDUs
IFlpIFpoYW5nIHdyb3RlOg0KPiA+ID4gbnVsbC1ibGsgY3VycmVudGx5IHBvd2VyL3N1Ym1pdF9x
dWV1ZXMgb3BlcmF0aW9ucyB3aGljaCB3aWxsIGxlYWQga2VybmVsDQo+ID4gPiBudWxsLXB0ci1k
ZXJlZmVyZW5jZVsxXSwgYWRkIG9uZSByZWdyZXNzaW9uIHRlc3QgZm9yIGl0IGFuZCB0aGUgZml4
IGhhcw0KPiA+ID4gYmVlbiBtZXJnZWQgdG8gdjYuMTAtcmMxIGJ5IFsyXS4NCj4gPiA+IFsxXQ0K
PiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svQ0FIajRjczlMZ3NITG5q
Zzh6MDZMUTNQcjVjYXgtK1BzK3hUN0FQN1RQbkVqU3R1d1pBQG1haWwuZ21haWwuY29tLw0KPiA+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyNDA1MjMxNTM5MzQuMTkz
Nzg1MS0xLXl1a3VhaTFAaHVhd2VpY2xvdWQuY29tLw0KPiA+ID4gWzJdDQo+ID4gPiBjb21taXQg
YTJkYjMyOGIwODM5ICgibnVsbF9ibGs6IGZpeCBudWxsLXB0ci1kZXJlZmVyZW5jZSB3aGlsZSBj
b25maWd1cmluZyAncG93ZXInIGFuZCAnc3VibWl0X3F1ZXVlcyciKQ0KPiA+DQo+ID4gVGhhbmsg
eW91IFlpLiBJIHJhbiB0aGUgdGVzdCBjYXNlIGFuZCBpdCBsb29rcyB3b3JraW5nIGdvb2QuIEl0
IHBhc3NlcyB3aXRoDQo+ID4gdGhlIGtlcm5lbCB2Ni4xMC1yYzIuIEl0IGNhdXNlcyB0aGUgaGFu
ZyB3aXRoIHRoZSBrZXJuZWwgdjYuOS4gVG8gbm90IGNvbmZ1c2UNCj4gPiBibGt0ZXN0cyB1c2Vy
cyB3aXRoIHRoZSBoYW5nLCBJIHdpbGwgd2FpdCBmb3IgdGhlIGNvbW1pdCBhMmRiMzI4YjA4Mzkg
dG8gbGFuZCBvbg0KPiA+IHRoZSBzdGFibGUga2VybmVscyBiZWZvcmUgSSBhcHBseSB0aGlzIHBh
dGNoLg0KPiA+DQo+ID4gT25lIG1vcmUgdGhpbmcgSSBub3RpY2VkIGlzIHRoYXQgeW91ciBjdXJy
ZW50IHBhdGNoIHJlcXVpcmVzIGxvYWRhYmxlIG51bGxfYmxrLg0KPiA+IFRvIGFsbG93IGl0IHJ1
biB3aXRoIGJ1aWx0LWluIG51bGxfYmxrLCBJIHdvdWxkIGxpa2UgdG8gc3VnZ2VzdCBhZGRpdGlv
bmFsDQo+ID4gY2hhbmdlIGJlbG93IG9uIHRvcCBvZiB5b3VyIHBhdGNoLiBJdCwNCj4gPg0KPiA+
IC0gY2FsbHMgX2hhdmVfbnVsbF9ibGsgaW5zdGVhZCBvZiBfaGF2ZV9tb2R1bGUgbnVsbF9ibGss
DQo+ID4gLSBjaGVja3Mgc3VibWl0X3F1ZXVlcyBwYXJhbWV0ZXIgd2l0aCBfaGF2ZV9udWxsX2Js
a19mZWF0dXJlIGluc3RlYWQgb2YNCj4gPiAgIF9oYXZlX21vZHVsZV9wYXJhbSwNCj4gPiAtIGRv
ZXMgbm90IGNhbGwgX2luaXRfbnVsbF9ibGssIGFuZA0KPiA+IC0gdXNlcyBudWxsYjEgaW5zdGVh
ZCBmb3IgbnVsbGIwLg0KPiA+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodCBh
Ym91dCB0aGVzZSBjaGFuZ2VzLiBJZiB5b3UgYXJlIG9rIHdpdGggdGhlbSwgSQ0KPiA+IGNhbiBm
b2xkIHRoZW0gaW4gdGhlIGNvbW1pdC4NCj4gDQo+IFN1cmUsIEknbSBPSyB3aXRoIHRoZSBjaGFu
Z2UsIHRoYW5rcy4gOikNCg0KTm93IHRoZSBrZXJuZWwgc2lkZSBmaXggaXMgaW4gdjYuOS40IGtl
cm5lbC4gSSd2ZSBhcHBsaWVkIHRoaXMgYmxrdGVzdHMgcGF0Y2guDQpUaGFua3MhIEZZSSwgSSBh
ZGRlZCBteSBtb2RpZmljYXRpb24gYXMgYSBmb2xsb3dpbmcgY29tbWl0IFsqXS4NCg0KWypdIGh0
dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92L2Jsa3Rlc3RzL2NvbW1pdC9lYmEzNWFhZjMyY2ViOTUx
NmE3ZGJjODU2YzlkYjRkMGFlMzI2OGQw
