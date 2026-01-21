Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D33346A7
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983408; cv=fail; b=euirMy36hd7g/o/fFMR4zDjUrabDbHtdKm66LJcb2UOoFPahgcXzxsRznivZE0UEuf8Mu81FglF9qYW/zRi0CmsakmuF7BsHrHi3Y+xWklKDfmXKAbiDGG0mQNzsaUBwEv/nuRMHP9UC5w4+Ifkq6HT7TVJVQiPmNLbctJk/j4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983408; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQknL/wXPRt28nMTXc8an2iZAPszzUmdO8vxaRbsr1jL3lU9mJNGO+3QsgeUFMUtGy2gFwtcpVfkPlTfLKEsawhdBS+5ES6jW0XuY+3NyeWnPrTbQyOxsGDBHbZoASiMN8nKNJVmDkcHgYESfjvaV3hXCcEn7PluC8uw5TYhkaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JhU3Y3Fg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=evmCc0uf; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JhU3Y3Fg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="evmCc0uf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768983407; x=1800519407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=JhU3Y3Fg2LbCZshIUNob0LtS/z7us7e3V298L+8/buaZ5KYDDjlI1hIc
   lChF2Ko19AOWR2EVtmMGUgBndyNCQ+2cZbJBY/K8H29fGRlP6CyA00zf6
   VnLGyyfJcSe1/apuyTbryAxZ9+PMUbBBdQU4+vOtvfwW/kaM2jzKO8br5
   yBjREeGxeNNv/VIFGKx1Nk+s5xShnyDza4vYY/O44mO2MBI7xR9la/ZGj
   Kf2Uvwz50mR0lX+AIshxaOCvzpj46VYzigOUEF5v5QgXAtaaAgqWbu2iX
   toGDy1eoxbiCYvT5rMLUCAS7V3ZA3jI4KNeOviMhSQGQQC8tISv7ljMnm
   A==;
X-CSE-ConnectionGUID: eyiyLAv5R06SBMZrP5zjEQ==
X-CSE-MsgGUID: m2DzR0s/THaBQzYYb7WL8A==
X-IronPort-AV: E=Sophos;i="6.21,242,1763395200"; 
   d="scan'208";a="140364615"
Received: from mail-westusazon11010034.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.34])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jan 2026 16:16:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW4I34NLtgMfmuKuLP9cQwekr3JuC2BwnbUpzr/c5MOICi4yYZ4P0F1ra44SAdar5YtOatUCIwnMOQOGSAI25PqGxS08Tg+lW6q/ib5pRejx6rjM1lhc7sBLO2fRiOzQJzurkGcJIYQ6RaldHnkrVYmO+iVbWbPHqgaYX+Lyiv+shZtyhqlUGRttl7z5EKdpIKmRk9B6BRNJYpPyMzbb0zrMIKnjcrbiYObvRhWIqYudQ8dNTk9NVuozsNESltDeF4tpNSSZ5bOzSwy6utglVHA/FaxTelcKeqearqZA1F9yQrhN5s/TWsb9otRXkefrxgDHmfiyF9SFkEsuju7FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=FXteGTfv3wTr9vlAqTmPUX5uQ/6x4u7RbSexImOFBip9cqeq2uabUmRuAoDhaSuRINPXtpGm8xer96tCo9qrTzOKqL/s0trukqtj3VMGIISgCi5rWwlmRuQG8k7P50hEQtuz2KXwYocYWmVOqLlSsdt5WBvv/T02lYIoiJJiSQeMopJzYgKxVrB5/7K79+/vxIKgC7XFVhl+hB+TPchdB8KLwG1MhlncInCnqiabYgsH5R9Obmw896Ih3l8I6+xLpRwFWT1yuly9EJDnpqDpOmr/YQmpSQW1xpOPz37iHoDcIfezyoZJmwB72o1gfaTlVAW8Ncp4t3WXb9BSj2FkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=evmCc0ufnLo4TVkEPuCQRnR5iSGdbZtT3PPhmI0hrvz0sOQrHyDv5wgYnCH2Enc8lzff63FbG1UdxmZ7U2n2JEmqL1JFcKfxj77mGJKJymSvyiPnZD6V96t4vsTkLrsyAcbr/UxsYuI16BNVdsQvH8qvT7d682G7rO3h8di3HuE=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MW6PR04MB8914.namprd04.prod.outlook.com (2603:10b6:303:248::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:16:44 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:16:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "aalbersh@redhat.com" <aalbersh@redhat.com>
Subject: Re: [PATCH for-6.19] block: make the new blkzoned UAPI constants
 discoverable
Thread-Topic: [PATCH for-6.19] block: make the new blkzoned UAPI constants
 discoverable
Thread-Index: AQHciqghsMUDVsvo+0ie2Xq6LEEmubVcRz2A
Date: Wed, 21 Jan 2026 08:16:43 +0000
Message-ID: <249431f3-c2d8-4e95-919e-7fbe33968aad@wdc.com>
References: <20260121073203.234429-1-hch@lst.de>
In-Reply-To: <20260121073203.234429-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MW6PR04MB8914:EE_
x-ms-office365-filtering-correlation-id: 70bd6d3b-a0b6-4b65-ce47-08de58c569bd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWV1cVRJeHlCeGJzSUs5R3M2TjFwMGFCMm83RW9xMTcwcWpYWVMvTnhaOEdW?=
 =?utf-8?B?aUlURnYxd0NQU0h4L002T0Myc2Q1enc2Y0pNWVl5L00zTFI2b2wyZHhpb0M3?=
 =?utf-8?B?cGVjZWRudnRLdHNLdFh6dmV3dmdJQlJmVjMxbXFpK1RDOW5jQVA3SE9uWkth?=
 =?utf-8?B?TVlsR09GRzlLNWlyRnowSG8zcFR3cEZWaFFYRWpYdkl0cHErKzBXRndCcEw5?=
 =?utf-8?B?ZkdTb0xOVWxQUTU3VXE0bGtSaWIwdFU5R1IzZWdmMHFvb0JhVzZ2a3VTaWIy?=
 =?utf-8?B?Y25oQ09XZi93VUs0ckdLR3lWQ3hDZU5seTBUVHY1RDlBWkVUazF2bnVKbGg0?=
 =?utf-8?B?cGwwNHY2YjY3VlRUWGdxZHpOa2FYc1VjbGtXczhraUNjT2ZJd2xFMDlJenBV?=
 =?utf-8?B?K3dxRytadHU3UXZJd3paTWZBeHIrSzZGbEI5VkpyNGJ4c3NFcjZvYS9sV09s?=
 =?utf-8?B?YW8vdlRmazVia1picE1NdTIza3gwdVkyVTBkR1hydUs3THVBbmVxcFFpbE9E?=
 =?utf-8?B?OEVmRVEzRERzOTIzbTNJdWwyV2QxRW1lRVRVUHNrYVFsNTRhUkcyV0NSK2FY?=
 =?utf-8?B?aC8vaHAvMTgxMGYzUkNPT0pFR0pxNTJlNE4wVHpVUHRJWUp0RFJ1SnV4U2Jq?=
 =?utf-8?B?K2l3WEd6TEZ0YjAyYkJJaStQUVpUTWcvUVVUcUY3ODkwblhhcHhJUnAyYWtl?=
 =?utf-8?B?MDBiYnhORG5zb3JiOEVxa0Y1TlY5WUJXcURBemloRWJUSzIwZVVCcHR2dU0y?=
 =?utf-8?B?ZlA0YnVxNEVLazd5M3F5UHFITkgzbFRCRU1mWisxQ0Q2UlN2MHFvTHdpV1F0?=
 =?utf-8?B?ZHM1UXRGbzk4eDQzUjFDSFhqZlVLWURIOXV4T2IyMVJTSjV3QVFVYmJhNFlU?=
 =?utf-8?B?blFNQmFoWFZNbGk1dmw1czlRTXowbndacUxUbmNsSW9DSVFkVUlOWmdhTWNY?=
 =?utf-8?B?NnZKdHp3OWN2aWZNVTcxMGluWTBSWFliL0JZYzh5RTRVT3JNODdyVzNLUG1L?=
 =?utf-8?B?eFlVaXBIV1EwK0h0SHpya25wc2hpc09tUWcwdlVmdndLYXdTWFMybmxhK0pV?=
 =?utf-8?B?aEM1d0pjalFLN3hPZXp0QnQxVklXTTJWOHVFazhZanMxQnlWa0Fjcy9YWENu?=
 =?utf-8?B?U20xWFp2MDZJSlR0aG9EVytXdTkxZXJ2RGVwTE50b0JnbElaYktZakV5ZHNB?=
 =?utf-8?B?RHRzQlRkSExxMDlySmZYOUF1c2JtUncza3d5bmNJSXF1UG5lOU1TQUZTd1py?=
 =?utf-8?B?cmJoYmwvNHJDOVBmM282K1NDam9ubGFybCtRV3FPSGZ5VkV0MTNuQm04YWt5?=
 =?utf-8?B?by9aKzhXd3UzY0dZcjhWd1VOdUlLbDIyOGlObklkSmxGMFBETkV0Z2o3VXls?=
 =?utf-8?B?RXBqM1drY2lxSVlSNXBrT1JkbDRXTlhyVC9BcXJVQlVmQzRpbHhQWlU2Q2Qz?=
 =?utf-8?B?QlpWamRURzRQeXRTUnZYeU1seHNSRnE4YlBkbWhZMmIvdjkraWI1Zlh5NWxh?=
 =?utf-8?B?elJjTVEzVWtsbmRVYzAzQ3MvMnhkT3N4WEJrM2dEaG1MWVhxSmthZDdGZ1RG?=
 =?utf-8?B?Zlo1Q1hEVjRGdXJjOGUyWFpISGpPb2pHMDNYZGZ1ckpmSU5QYVpncURUZUls?=
 =?utf-8?B?YnR4cTFVdXBYQzBITzNqRHZObzdDbmZiVEVNL212OXptVWd2SU5oenhVQUNr?=
 =?utf-8?B?cVBQUDViVHBwbVJOMXNXRDExcFhKWDBCVlc2SVRTLzJSNmxabzNjT3h3Tk1n?=
 =?utf-8?B?dnVZa1I1WDM4S1FDYW5ObDVmWUpYZzFwTmlkQUM5RnZxaG0weVkyblcxalV1?=
 =?utf-8?B?VENKdGJmZG5iM1lFMmZ2bEgxamNyOGpOdG0vNUFNL1A0TW5YSGhZMVBTSHpW?=
 =?utf-8?B?R2M0STNNT1BQMk5zQVhZNVRBcW42T045R3NZN3pzSnY2eWNzSEJSVW92S0ll?=
 =?utf-8?B?RjF6ZDNpcTdEQ1lYSTRjL3Z0cm5hdW41aXAvbHpGalo0alJlMzBuRDVRdmxB?=
 =?utf-8?B?OVN6WEZIeDhrTHVYRGJpUFdmVC9UL3k5Tk4rVzBSN0t3azhVNkM4bktXekdD?=
 =?utf-8?B?cCtBRWZYWkJOcnZHQllXRjE4QWFiZUFRUmduOGU5ZzNaLythaXZTM0lnUElK?=
 =?utf-8?B?VzVsZG9ITXNxU1NIQndsRXZ4bUY5U2hDVWdKb1U4R1VHbnVhZ1pHdTNFcldM?=
 =?utf-8?Q?FrqOusN3HG87jP32l5T6Snk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0xpZUovNDFZTG1vazEzRTZOeHNkT0REaVVLMk5lZ2U3eVlQRzVabTNPYWF0?=
 =?utf-8?B?RkFYWmRJaFlRL1VCRGtxWmFpa1dYMnZXaEc1cUhUZS9JZ3NEQ0ZQRnkvZXBI?=
 =?utf-8?B?ZHgxR3BORDFWMXUyaGxYZjV6SVNXdkZqM1BZbzJKVFNCVEhYeWV0am1peGpH?=
 =?utf-8?B?eGZaZm4yOUtTcUNwejZRWE9nMGQwTGVTVlVrMHU0aldHdU5uZ3Y2THdBZzE2?=
 =?utf-8?B?eUFWb2VRSGxxdVYxSHAwSHl4YU9hcm5VVXhZbkRpc3FVTTdPMnJMYWJmeXpV?=
 =?utf-8?B?enl2YTN2Z1hvT2hBUDl4dTZoZ1ZZWWp4WmU3dC9GQTltUEtTYlRIL29CdG9N?=
 =?utf-8?B?OUw0dDZYMDZCV2FiTm1nRjZpbUtQQlVxc3FhNkhGMm1pWERadUZnRXRuenFh?=
 =?utf-8?B?cndHclRmMHJDenY3OFd2elFIbGJUeEpUNlgxd0JhSTR6MTA4M1FGY0s2ZlFq?=
 =?utf-8?B?a3VTSS9ZL0twbkp5RnZSZzI1MWNrczZ5VDVlUmF5SWJoOVd5NkE1TVdic0gw?=
 =?utf-8?B?Nk92SlM3UlVJUWs2Wkt3aytLK2lGdlVQOEdMVzVnNGxvZmhhNjBqdU5jOUhu?=
 =?utf-8?B?cEU3ck8xemwzcmNQSHh2K2l3NUx5eDc1NWlnREhobFJJbDJJWENPdjVUVDlr?=
 =?utf-8?B?TXU2TW1PalpOWUtEWHBRUjJHaW5OdVVleGx4OXJuc3VsZTZoMnB3SnNmOFJh?=
 =?utf-8?B?ME8veG5BN3NnMitSOEFLYk95ODhjUFkrV016amtxZC8yMGpSL2hwbFVNbktu?=
 =?utf-8?B?TW1udUo2ZmplS1A3aVZaWWYrSzVGRzNhTkVIbCtqSWlFbXFIVTAxVHJJcmh4?=
 =?utf-8?B?MXYxNUZTaThPbjNrbm9PTFJoZi9RYWlHRlVTU1BWcUx2czYydkdyMTArNHV0?=
 =?utf-8?B?LzlUelV0RlRwNDRldGJxS2JMOTVWSnBUT1hlN1MvR3BOQ0VySVBnTjBkQ1Ew?=
 =?utf-8?B?UEdhUUNXYllEVHZhaEdzMURUd0RGZFBIUG0wdTZhZjVuejN1STdpN3cyaGMz?=
 =?utf-8?B?YUtlbHhGK2FiTTJwaTdzd2RRUml4SFAvczZxcU5pMWNLTHhHanA3QVRDbENy?=
 =?utf-8?B?blcvNVd3dHRBdXMwYVpXWWtFUGFWQXorNG9CdkJXUlFtaWNBRWUvOVdjcEN5?=
 =?utf-8?B?WTJBcWNnUVQvd2p0a1l3YlJ1YmEzOGE5UC9NaGlwdmZSazJ0bHZJNWpUcjlR?=
 =?utf-8?B?a3Nrd3ppbEFZWEZQdEZncEYxbG8wMit2aVg1OE5WY1JyZlRvQjRxNXo2Z0hi?=
 =?utf-8?B?clJrakt0L3pBclRkLzlOTkhwcG96NklLOXNhSWFUYTg5NmVzaTR2cnBwaWYz?=
 =?utf-8?B?Z1l1bGFGcE9BK1BOK3hqeFpNSGRLT2g2SWFld0JwblNsbE84ODQ5ejhsRTNp?=
 =?utf-8?B?K2ErSk93U1hIZ01JQ3dCdVVLVmxtOUNjSmg5SjJuQUYyNFI4dzg0a1NzVHZR?=
 =?utf-8?B?OFRkZXdIYVl5K0JLdStheGl4VytINjdKNVBhazl0UTE0S1l0ZGFyOEtqdStx?=
 =?utf-8?B?VEZJdXA0NzJDQUd6YzVBdjRPU1h5QkI3eGpqQktFVGc4NmZGbEN1cUdJNHdY?=
 =?utf-8?B?WThQeW1GZlZsRzBZdzNRM2R5ZXBtMVVZc1JPRW5YMWk0dU5kWFVtemlNTGNq?=
 =?utf-8?B?bTVRZExRSURFZFphTnBXUXNBQ3dJQ3FaWlpQUlZZVU1oUFgyWGdQc29BOXVQ?=
 =?utf-8?B?OTRDQXpxWUlOdGVSUVJLOFBCU0hlQkIxSGZGTjBRT1dFTlRIT3NOVHBDOVpu?=
 =?utf-8?B?QnBWVEFsUnRTaTNnN0lvRjZOd1NjRjlrYmNkcWN4N1RpTk9iMzVjY2Ird1dQ?=
 =?utf-8?B?M2xCekd2NUcwVHlHay85Nmt2aDZFLzA3ZzAyeVNseWdZdXBNa1dadVF4OTd2?=
 =?utf-8?B?SjNGYkwxZzNyT0VpS05EaVZzMVpyNWJSY3F4L2pubkxIUVY1eGwyRHJMRzA3?=
 =?utf-8?B?UEFEeU9zNm1kbll3K3ZENmFpbjZna2VRUjRKN1BsaGNzQU03Z1hyOURwWXUz?=
 =?utf-8?B?M2Iyb2tDMDB6eVQwVU01UmpKUFdHeGkzZzRrOERaT1NHWCtnU0k2NVJTa0dE?=
 =?utf-8?B?d2lzSXI5UExtbzFXQlVUSDk0RXRYQTFwK1FPQ1A3ZWpqM2d2YkZEcFpPZTlv?=
 =?utf-8?B?RVZBeUNFdDE2SDdlN0RMVXlZVlk3aktNZXFBUE04bnRCNVh2SE1DRDQ5ZlJU?=
 =?utf-8?B?UWU0MjI3WmJJTXBmMzZKcXgzeWxjYmtMV3M4R01IOWV5Z25nT2lQSkZ3RUZm?=
 =?utf-8?B?TXRqczR2SFY0eGlzWlZJUEQrMTdpb1JyMzQ3RWNEeDd3YUxoSnBIVUZmQ04r?=
 =?utf-8?B?SUlRZUtUMnRvcXBlRVVLVk55eHREV3h1ejBxbEVsTnh3YWdPcDJUWFNRYzMv?=
 =?utf-8?Q?G8bI1LE9y4K6J6Q549HHoyvheIcSGteEw96cfNuZX0yAc?=
x-ms-exchange-antispam-messagedata-1: CUnDeMWYeKMC8hWMSxSvSWDKF+foj0F+irw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE02331452BA74891DB76CE53F5E34E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0FGZudwMpYBedUCJz4o4ZjWvzxg5GMe6zE8McQGtUhBv0U9K0a1wcElBhNN4MRe3xbVDHYgl9Of/B03fJBjIMfOrHhp+rNb/6rPRYJLUapjucIeR1B06XROEeTMzk8+7XltvqqPIVjIZW5xlIPJJiVAApIhd/Z5M5cdMubVFVxmM2VV+eR84FvIsim4IbF0j70a7sr8mfDOymc9ih4rqSPxm5x72Cs2COrjnVb2inmWDn/JXtPGYO4/qSlL09g/CyleI2hS57qSeNCxSGal5puMRFQw1ZMkXk0XKqWwNCvNP4BlhbY9sjfZU5YpufXkrQb7YTJKtUp9mfeCxkGU4vtycfXeSIdVXRDUP8Tw4Y+l4TiVvuishTcmlGf/bL8u7BMyJF14cYp1KUI5skD35L4WuaaVWWlID2q5un1ytrRtChIiEMDHtW/HlKKOjH1AQN9WSITWgB0VvUbVgkmQlnL935QnLCnCa8SH9sxrWdFU85+2niixZaip3j61rlyekUKH6lRiKx+HrAgRIARA6JTG+bZ7RTFLLVF3p9u0t/zvB2RSMZ9h0PnRUhqBXF7iHTV3CI4N9NOeXXZEFCXCvukMcT+TTj9qsG1XoJkZ6Kt90Er/9phiRax7+TVwRMdJK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bd6d3b-a0b6-4b65-ce47-08de58c569bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:16:43.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4mU+q97s4SlR3VXtA/4Bjx9VN2+3IOzmFOEdkcmz2czEekBlXqd2eBm3WZhLMy9k+aD3u8yflTwLY/T3O5Kd+gMuqbocCcALoMeVz3uqtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8914

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
