Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CC21770A
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185907; cv=fail; b=NiffLil+yuwE9Urq5dHA6I8ppEmnki/GYX4QS6ZHIZ8h2k/zL8Pk8uUUYiyQx9zLsohfGVSZkgOccb1OB8LHhj95x1pjz+AP8RO6XFV9BfUEnVT9ehhWNfP0XEPUJjwNUOrs7GSisAIFoTILL7hRVdEq1Af9FWGfiUzUXcSvXVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185907; c=relaxed/simple;
	bh=eqNW8fV9y/lVdv3QuKd+Nr1vBrV80ka/NP+HlnzFjus=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=guT7PQ1rklwNltvtMKkm1vrsedtu1YymbObjbJWqPecBpibdOtBZQNjD8uHax1el2wB+tq5mlcXMakCJm2Mf9xUdWXWz+Nu02IQu5S6JcZWAU0D2UMDwdxv28fPwOq2Cnr0eqDUq61VsGM2fS20NRtVjlNPnJnAIa/L7kOQqMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LXkQogGp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Twbo4IMB; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LXkQogGp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Twbo4IMB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772185906; x=1803721906;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=eqNW8fV9y/lVdv3QuKd+Nr1vBrV80ka/NP+HlnzFjus=;
  b=LXkQogGpenhqq7iMmrJZi8EqfPhvyS8jMJ4XZannmX72QqIBlPxqzYFt
   TVVK6aSOBAuhXsQWhDs9sl0Gy1ot51un9OZ4SV7yEwG8b1JyWzrwvfgR7
   suJRmED6wAxMc3/Dp0PXVwuiundOACVsofkIKiTgozDoD0yor07gTjyOy
   JV8rMH0nkbH7e0SyfqEgRiG8cvVJon/qR/MtTXGWaoKRpB/yB8Ncrhcn2
   swn3mf2e/QcMIURFVD0mQ1fDeZnOconh20jrHWjn2XXoVsh8jNCjEhW2D
   CgfAwg1+ScoZdacgqi9E2TBuIN2WzTkyePhbU1sB3/94qT2GQmFojcD4B
   Q==;
X-CSE-ConnectionGUID: iuFid+d9TkSCJ1wjdwuzgw==
X-CSE-MsgGUID: QBvEoeeCQVaQYwUvHIvAOg==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="142709588"
Received: from mail-centralusazon11011068.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 17:51:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCWLaQ8lUoeuBY4a7tNM6N8XX2HovNaC7C7OqEQYn0JrJQdiMYND2TgdTWBEmCW3Pe/8iE/t3bnuJkeWNyAoVkfJ9llJYCZnLhYU7lII3epo64D/1NJ47JCxpZudIq5kJoG+WgfKnxG70v3UKSO73ChINWWWcBpAjCOjlXKAyDoL46driuwqjonNjQ98Xd1nZChBLt0ygeQ4BYd1vNfFc6rB1o7x0D951wJZwL9F3DTNqrXU7xD0NEGVWBsrNlHSIp6kED6CgpqquGaeJwOONMmxhScRtZclREnQTeY9jAnEkDWgiucSxlaufYrem5ZpEQ/Bw+uuskd+gsconXV33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqNW8fV9y/lVdv3QuKd+Nr1vBrV80ka/NP+HlnzFjus=;
 b=tZRMaU9Vf9x7km+bnZYKXObI5oUDO25eNa01V3YKJC5UAs8n4tnfFDJf0prwE2v3GrDjpHCVJSNl702OdwEXV0SR6ICDpx+SSpsCwJMsnOFcrox7Iu2b6aMQiey5xFYmceooT9YyEYXbm/ZNEfmJIIr3vG6DAkQHcovqvcetU9UzXxtw0HHTQvWyn6O6GvanQG6p0mD83dRQoUdkfCJHvHqqvcsFxBG944WjyFEyeVQcMPSQPJkxbUB22dew4tPTrzy8ozhHmQ2CW0GJF5QrYeT6pFY2aICzXsp07r+/se9ZWWVvnuiVSO35bMDYmACT3iqtOWHQOGpW+CkaVew3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqNW8fV9y/lVdv3QuKd+Nr1vBrV80ka/NP+HlnzFjus=;
 b=Twbo4IMBG65Ola/6b5QRM1sjHtKcFBwoJbLLVb9QVZv8hxz7J3OV93JAw6alGQEgtyApAm6JiFSZM4qNQw/DcOwthnD+HTsHdkIbqDIjAlPhLhQODaA/FNvR24qG/ZiUzgn5wHLAnM9/NmPZZh9aPEosMAv3hCepCnG9UQNqEKY=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS0PR04MB8620.namprd04.prod.outlook.com (2603:10b6:8:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Fri, 27 Feb
 2026 09:51:36 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:51:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] Documentation: ABI: stable: document the
 zoned_qd1_writes attribute
Thread-Topic: [PATCH v3 8/8] Documentation: ABI: stable: document the
 zoned_qd1_writes attribute
Thread-Index: AQHcp4xH/kfBLDpK1kSgG18ElfYPWbWWTjiA
Date: Fri, 27 Feb 2026 09:51:35 +0000
Message-ID: <31ece3ff-9b33-4d1f-bab4-40ec44ac5c80@wdc.com>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-9-dlemoal@kernel.org>
In-Reply-To: <20260227014951.2327711-9-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS0PR04MB8620:EE_
x-ms-office365-filtering-correlation-id: ce52f04e-e6a1-45e9-8146-08de75e5cbce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 W5z+rGv5P13gK8mZZRP6DKZda69A6wLBCymabaWpn+KiRUvvZv/c8cT0qN3q147va7mYyXxwVQNYMSQ5dyL+ollPJFl18ToTfZwUUvkEs5vG1J7PN4M7A8NtxHjt8FCAN+lnnaSjQmND63GmPxv+tw4fmSr1GN4xFvHhguaIwdO/u/PD/1krEInK/G4jdTn6/iGkck6/KTnmAQev5ABJrWcsAxuXy8dl7kxpX+4Jgtga7SBLx/zi0blbmo+pBSmOq2HBwPmSkw+5TNFKB0WzMBx0YK8Rtu7SLHMBH+cEfDMKLCiUzd8SYglj5OZD6952qqYvEWZH5u7GDqhwO1wD4+gZ+KBp7QljKf5UAEmhWWkuYWVz9HLHiral/qTtgiIuARCZ7ABajxOaWnTVk/XS4xmJO3JyQeOtRtOv6RJ1y4Ghm1k/KxZUwHXxXKUrmldXlpyA8Ku4Bf4u0I6/vE5ISGuB52JmBzsIhf37PggDftkNeFh0il6Ng1lXHicUpjcXJV4iKnPeHw94B0LfmfWIb4x+k95+8V7Jzjh+tLQft+YQeeuSqIlqNiMdRGDr9dyFW2pUAIS5Eil0qwoCcvDsGhWX1RC0E4q8R41ipN7TH2+5NQFmjhvV0+iWGjQjxwYq2cNuUN38r9yGD/fOKZxP5krwIbrb/b3jspy51NEU2UTIwzSmt+6zd4KFmlKMpTrDqTN04OxWGBtbYrBcfPOEUae/DBGaoztinetb2Le2tZz5c3aVmfSD275Wq8z7WkN8LRCP7oo9zc0axg1pE60VEUmTReyNklp1Ws6P8G6DfpE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHYyNFdRazZ4ZzdTcGhTNnFYTFQwNVlGdWpla09yeFhnbkxpZ2ZFa01HWE51?=
 =?utf-8?B?Uy9KK3ZOQVQ4ZGZBNHhoeDc4OWpvN2MxYzFLVVhDeFpTN3NvVXM1b1FlaGhD?=
 =?utf-8?B?OW9GSmlZdEYveTBQWERHVGViV2FyVVBvVzBhV2ZsbDBBRnF3ZnRpUXl5U0FL?=
 =?utf-8?B?dnBDWTY1c083Y0RPdVNudmM1ZVY1QWFKZlBGcThuaEpyVTRYWStPTjdGSm1Z?=
 =?utf-8?B?dXYyZjFWODArYzdKbnozSW9DTzI5V0ZmMWtmVk42TnE3Wmp5a3ZvVmllMmlh?=
 =?utf-8?B?WlFlS0ZiMEh0UkpEQUtnMVN4MDF1aFNXb1FoWk5nbjE2bUFLeXhVUk9RU2VY?=
 =?utf-8?B?dnp1aGNwTFlNUUtIWmZMcWlzaEhHcGo3U3FvKy9tbys1YnEwWXRxS1VWdVVR?=
 =?utf-8?B?OXlNN3NhMEJYenA1eWxwaHFlK1BWSGY3R2kwTjJEN2ZGS0J4TUljekw4YmZk?=
 =?utf-8?B?Q3g5VTM4V1pUSzdsTjBaTVMzdHQ2QnNNMnRiTE1NQ2lCUzdBck5oL1loTDdm?=
 =?utf-8?B?Q1hSYVlwZi9ZajYwRFdoQ3UvSWxNTC9Wd250bGgrOTBSUHl3L0htZHpCK1RO?=
 =?utf-8?B?ZjZ3RHp0OGRkT0NZTTA2Y3JpeEhZNkp0cTlrT2pLQXVlNmpTTm56a2tCa2FX?=
 =?utf-8?B?c3RBZmRONjA2bVN4S0kyZ05qbGlONXZOaUFkWldLeTloK01DMHp0eWF0c01P?=
 =?utf-8?B?SnkrK0hidUMzVTYxQVRjTndnQ3d5dTBubFovT3J3QWV5ZkRKb1ZBZVBFaklC?=
 =?utf-8?B?US82ZzdkcDhZckJvd1dJbmNnRWxKdC80cE1ENXhwdXY5RFEzTy9sSFpzV2RK?=
 =?utf-8?B?dldIeVVSenhBZ293QUFBaVVnZVZ1Y3NTTGJxL01SenRkU2JPenQ5Z0U4UWJy?=
 =?utf-8?B?TmI5NUZQZXU4THlBTW9SbWNZZXQ5ZHF4VS9EOVdXM0FlbHJXNE8yWlNmVk5K?=
 =?utf-8?B?RHJnbGJwcTZvWnh2Z085VC9aaEY0ZStnRnNJanZGOWtEOUU3bzVNMDBKekg0?=
 =?utf-8?B?YnJ3UWVFdDhTTnEzMmx1WFp2cTl2eGhLSWx4Y28rM1A0M0tDY0ZMbnZUajA1?=
 =?utf-8?B?NHkxdWwrZWJSMUlRZlp4MCtVYWFTZEhuNjlJSXFWcHF0OWVoU1hKcGxkcDFm?=
 =?utf-8?B?aC9Ld1BWckVvOEI4VmRYNUZqK1RvaXFwbGhJbEtEU2Z3RFNSVnlzMzh1WHVp?=
 =?utf-8?B?bWQvRWFTVjd6TVY0SmM3dzUwTEwrL3ZFQWRGWFFLNHVrMEN6NHYrcWtpYS9N?=
 =?utf-8?B?clBjQnhFNGV0dGQ0ZitQNGZEY3J4Y20rajNZMlI4NXBxeDI3Mkp2MjJDWXU2?=
 =?utf-8?B?Ri84bE1ISHdsYkN0YTRHMVBnVjlxL1F2aFFpSzdjRGtsMnNLVENWZk9mMG9Y?=
 =?utf-8?B?V2hNem1GOXBkM0R2TW4wZkFYRFIvM09pZS9kUGUrTVQ4VlpLUEtYRVBoTTFK?=
 =?utf-8?B?WmVVRk15MkJhNW8wU2N0YW82VmNCb1RsKzNOR0ovQ2xDeUFCcUE0U1JZK0xH?=
 =?utf-8?B?ZUlIL3ladWJuVVBvOHRZUHlBT3dkZlFnRnMyMHRYcjlHdExsU1h3amlVMjY5?=
 =?utf-8?B?S0p3aU1Vc2xsckVSSldaaUxOYjAwbnVOdEZRZ1I2SXc3b3FFY3dnSjlSMWpG?=
 =?utf-8?B?NmNydE1HNkYrUFRnL2NQQVpzWCtWcVNtSyt6U3NxeXB6eHJ5WkFUU1NTcDM1?=
 =?utf-8?B?VGU0THhuS1FMczZsTzNmYm1udmtxWGl3Nm45M1hkaDRXZElMVGUxdExFVDFl?=
 =?utf-8?B?M0JIQngyalQ4TEpCNW5zT0kxZDlTSWRBMkYwb1p5MTlmei83TnJnNjNIUGJo?=
 =?utf-8?B?SUxpbStOU0diNU44SnI5VlVXYWYvbTdpc0xha0RkQVl5ZUV1cW1OQ1ZuRHVS?=
 =?utf-8?B?MmtWdTluc0VnUzlVKzcwRzFJK1lGeWc3ZzdiZWtZZzNkSWxzQUljSTcvcFY0?=
 =?utf-8?B?Ry9MaUtIR2duanZ4WmpqTyszbTh1ek82WFQrNTMzSERpd1ltWk83WmZ4Q3pM?=
 =?utf-8?B?QmtEMlpTN1gvTWdPWGhnbFZXbDRHZFMvYjhYaFBJUjdubzJtOWQ2SlBxcmQ5?=
 =?utf-8?B?eDFIQUpMTmVzMlFqek5FQTRuOXR6YVR4WC9oaEo3U1REZGRvRVM3TkxEVGZ5?=
 =?utf-8?B?bEdLbFIwQVJKdkFnSUZJMVNQYkhERFpENkQxWm5MOThic1o1enNwbERIS1or?=
 =?utf-8?B?M3JlZC9EN3JDMjRodWRmdmZxVTBicUlwK1B5ZlkyaWFTZ3FkS3hxTHc0ZFgy?=
 =?utf-8?B?MUNacVhWTDFWZlZYQlU3K2tMYnhSd2VJUW9BK0t6YnlkSlBVeTZPWWNqd1I1?=
 =?utf-8?B?a21LR2NGLzZvc3hrMks5SEc3cE1rVDR3MklZb1lKamRGVkFzUXNZaXB6aWQ2?=
 =?utf-8?Q?a24IF7xQ0ioV/DWE7x+6ikZN8FJaYjIDZLJlnY4Ui8uVk?=
x-ms-exchange-antispam-messagedata-1: cuqaOj0UQeWJ20TWmqf0FY3uMVIIQfJI+c4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6895A463D8C2C4398567196BFB89EB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pR3VP9Hg5oEPODCNPyaPJN0xA6SzLOSKYb7yJOIa57JenEGmWM36vhyELzpWmjmPmbn6cRAbhNTO4FVAUhfZHfeJGziARopNSYI6JDLDUoOBq1eUJ02EhYrY9kDN6owlc2Gv/Qho6CjQUW73NNK+BpTkcB8AJWOtr7UTNKZgoEqw3OtVP7Vg8v1G3DBvjUDBZtby0BTKpUCdUMvyPJ5L+ROdiZBLdbz2rPDuYasowd4H+GhjL2+AXv0GROHC3zd3rU8aadzKZwqTR7yxTlCX8ABs+RiooMeK/68cFdgkx8VyQZBHGytpCGCzgm3JKePshxivJLw0KSx7LKwFlsUc0SVfljuvdaoqJJbxE0ZVMmSn8WKAsHjgOcWvZNNjplBYaAYkhTo84UkZTgD7lyZhguTMkqzikI/bHDejAnikxqD41HeHtIIFQIedX6JBFPXtVBeIEFW6Na7BXFU4a/foMEymJ2rEs2p8bv3hTkAbNpO2snKZMI0qqF11fwGci6bad8qcwc23Zx1ZYkG06LhE9KRZYMu+O69i5FJ2pUhemBT12vxiF52RTE/sICSDB12mj9tRWqoWZL6sLpGQCT6/Nhk+JzeqlPIdziIEsnYMn/LnSGPgPe+wBhIJPj5QOusl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce52f04e-e6a1-45e9-8146-08de75e5cbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:51:35.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLLJp0mLLum6RkB7yFx/NyB26YN65OQOBjzj5ZyTre0Nyk7cC9CS0p1wiIkz/dAonnK7UxQbYDbPZUPIhAULbJOIhF+j+g9sSFybs7bLBTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8620

T24gMi8yNy8yNiAyOjU2IEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gKwkJW1JXXSB6b25l
ZF9xZDFfd3JpdGVzIGluZGljYXRlcyBpZiB3cml0ZSBvcGVyYXRpb25zIHRvIGEgem9uZWQNCj4g
KwkJYmxvY2sgZGV2aWNlIGFyZSBiZWluZyBoYW5kbGVkIHVzaW5nIGEgc2luZ2xlIGlzc3VlciBj
b250ZXh0IChhDQo+ICsJCWtlcm5lbCB0aHJlYWQpIG9wZXJhdGluZyBhdCBhIG1heGltdW0gcXVl
dWUgZGVwdGggb2YgMS4gQSB2YWx1ZQ0KPiArCQlvZiAwIGlzIGFsd2F5cyByZXBvcnRlZCBmb3Ig
cmVndWxhciBibG9jayBkZXZpY2VzIGFuZCBmb3Igem9uZWQNCg0KRm9yIG5vbi16b25lZCBkZXZp
Y2VzLCAnem9uZWRfcWQxX3dyaXRlcycgd2lsbCBub3QgYmUgdmlzaWJsZS4NCg0KT3RoZXJ3aXNl
LA0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbT4NCg0K
