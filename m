Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2F1304B0
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999159; cv=fail; b=cQlj3P6blhWqUst71N99cHufs1621kkB+lZQ5+41tS7Zl9SVS8zUGs2W5zxRXyhuCr1n6kD11sUPjpWZ1ORwISFBsvsSi0dUhoCBc62W7UuZZYttXygDbRTspTEc/45kYLk/XcXKWBq3MSh0WWJgSnSARd8174BRVmAz0zIQ9dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999159; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lrHTSNGmqMMteliLmQ7irYO+0R+NNT/eb+sWFeNy/k9oMUt3YU/hVZtGC5JGraE5tY/yTbYH61iitNOt4AfVCjO8VLJgXAzSGD+7VUJTR9UuUFCknysme7+1yjXZRq9in8XO8+nruRiCSJLnTzI6gN5K/OnTsfkYJW5jfcTGwYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gBADCaMO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=As714Viy; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gBADCaMO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="As714Viy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719999157; x=1751535157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gBADCaMO8xtqBP/I6Xp7oYmlviQ4We1YPisMLQDi7O9Itgjv7tVKP5mI
   7vbhMWVzX0h+2aDK9s9vJJoGxCzPkXbDorTahh0+iA0NMkgz97nrJ3IY/
   v7XgMpZbSB4MVEwYGLx0h/7WRkUtDAicgPzhuhk2siFx4V7EcwaDKesCA
   Ya4KP3HULdNa5esjEFSONFevUTui4ieSFAkeN+kfJ9rWv2h/jIyOM2hwQ
   buG4BKIrnsAjQbNdvo8fxd95zIyqU6vdaURN8G8UYyoEZbrJOum53Qnkq
   ftStBdF/sN9bFvYDYPqYk9oLRLIQhpx2JNfWKj8UgeTONF4OyKiUYXYO7
   g==;
X-CSE-ConnectionGUID: zGCIXFhrQBuwlY6Zi47Ylg==
X-CSE-MsgGUID: CzC/gyEyRLGB2Zhq1Z1NCw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="21088409"
Received: from mail-southcentralusazlp17011027.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.27])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:32:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccq6bqay5O1/Zj+S0T42f/zjvCND/gueWGE70RPHWOurcYMdaWPVcO8GXRcaS2bhUWjc8yNMvDyksii5wS3IFwZDq9Aj/EUmPB2l7U7kobfIwRCOtAYbn1dj4ptoHYUYSy5C6K33mTTWgXNCVJ1te9YFfizXAL/UVvZJU0/wqwAX1md2TjWegL/7cWoKN4nWLTKuzB5mUJcc+SGLik7EgjzoZ7FS0j/yKRXEkwdkSr/Pd3Fh4qqwtwclpoisABriS5zksOGfBKFkmkF2Td5IFUwpjQvgxwK3apJULgayzvrykwoAJF/lAHehcs0frjvHB81EDTc6R0R0oFjtM0yu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dugRr1iS1yBys+mT16gKa5qdgRHGq6dhXkBtImX16d41I9fGvu9CFgcpfEQkNiYEZOvg+wbOYEyACdR3zTB56493TAzbUBBLb+Rs6OJ4MG4NHAsZ0hWHRTv+OOiXr9AHA/khyLVrT7dOmDwLEY3QoXuFViJHGk4joKewhy3ymv+7+H1AUW9W8uu/xMLdPKt2B3rVGVGZONm72Wwm8YhbLlnR4372KNJi9CsumUwr9YB5Gy28Pt3QQZIz24iW7bXNmEyAvP6AbjYG9j8Rf7cQbgHuG9U+mQSSYVLpTbYpuTDeC28IfwrZ6LV6o3I/cNQTXG237IzhRIRpvfXyPvwAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=As714ViyELhbK+eyyXnVQPOot8J/7OvtHRA91Kdjl+Kvgy8jgWV3Z2W9pm0rtQaHDQJBPhABG4QFroBHXfzwM01uEdq5rI7XxMKSrOyx2iwfsGZSrhBTRH0eQoaj6sxVp6vqs94onmp467GZzgA6VeaXfWbbk3SwPt4p8LHE0Mg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 09:32:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:32:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/6] block: call bio_integrity_unmap_free_user from
 blk_rq_unmap_user
Thread-Topic: [PATCH 4/6] block: call bio_integrity_unmap_free_user from
 blk_rq_unmap_user
Thread-Index: AQHazJIy1QW/EK7fGEadn0/2QZY9TLHkvrAA
Date: Wed, 3 Jul 2024 09:32:27 +0000
Message-ID: <ac9b5d52-3f57-4d24-be95-6ded134a8300@wdc.com>
References: <20240702151047.1746127-1-hch@lst.de>
 <20240702151047.1746127-5-hch@lst.de>
In-Reply-To: <20240702151047.1746127-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: b1819f6c-2e44-4220-eb51-08dc9b430d89
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTlGSWg2cHN1dFAycWVKczJldWsrSEY5OXB6T3pPQlFLTTdwZFhxOU56QjQr?=
 =?utf-8?B?WWpUN3NXOVNQSHViU3htWTdybHBsY1M0V04zdXZ5VWNzZFc4dEYvbjFSYUh3?=
 =?utf-8?B?V214RmpZcGFEc3lYWnB3cTI0YW1RR3pKQTg5OHpyTEFSNmFkeForY1cyc1M2?=
 =?utf-8?B?UGE5dHg4TTA1b1BWSURiN3ZjMVdGVkJPWEw3T1JwTjdVY0FkZ0h3NEMwR3VZ?=
 =?utf-8?B?TldzNjhnL2gzUVRhTFFxcHVBdmdVQzNST2dFbW44VVNVa1Z3bm5jZy9kaW5F?=
 =?utf-8?B?U2RUS0YrNy9HVC9rMU9lSDJsL0VjV2pjaGJreEFHV2RTL3pIUGNQdlYraEs4?=
 =?utf-8?B?RThOU2ZkR0VrTEJrQXV4VVlnaGJaMTVneVVySHYxWExHbzVFWXlCckhMUktQ?=
 =?utf-8?B?OW00VnpzYlZiQzdSVXZjQTIwOXZLSjFWLzlRdzRBcUFEMlJBL0NoVVIxOVNT?=
 =?utf-8?B?ZHZ1TEpEdEpMajRkTy83VzZGREdyNG56VVpuc1ZJbG1VVEpNTS9uUEhuUG0r?=
 =?utf-8?B?WDlQbW1OUmV4YmlqRWJWSGVjc0RyN2JKcjV5cGV5OEpKN3ZiVlVSSUNmNDNm?=
 =?utf-8?B?a3dNUkNla3NTMkxkei9LczNQb0F2Qlp3SjUzNkh6SGxteFVhUTUwemVSMnNS?=
 =?utf-8?B?bVRrRDdkNkFVeWZHQ1JKcE9Yc1p0RjBpWk11bWxUcDJCak1NVDJ0U1Zpa0ZW?=
 =?utf-8?B?UXF3MjNucFdkWWhDNy8wYVczRzMxNE9LZ1VlYlN6L1BWSmFHMmxtc0ZJQVpm?=
 =?utf-8?B?YkdZbkFTMENzNHBETmt3RmhjbUo2WnhxNWNNNzdDMlZTRXlFSHk5MlZpeVZu?=
 =?utf-8?B?ZjVIdnJOcGI1RXI2a1F5N3hHTEpLcW5sblR0b2ZQTld4UUc0aDJRd2k2QjBF?=
 =?utf-8?B?UGlGTmxsNVJOdGVxc3g4dkgvNS9kSElRdW1VUWVMMnFGeWFHY1QzRG1EWms3?=
 =?utf-8?B?YTdSUmJpVlhNdVIrd3J3MXlNQlRNdHoyWXlERVVBeVBqMUs4SzhYOGovUHUv?=
 =?utf-8?B?aGJTdjE2U1FaOUN5ejRjempuTjZDSG5sYXBubzNiRHdhSFBJTnRiUEF0QUVY?=
 =?utf-8?B?VFZJSnFEQjdDYS81VEM1a1N2dy9DNlRERmx0N2V1ZnF3VHhtMk11a09YRlZk?=
 =?utf-8?B?OTdVZjBmRG9aN09vOUFlRURtV3BhY0ZGb0FkVHBhalFiOTJrbUFoclM2Tkgx?=
 =?utf-8?B?eTRFMG5EWjRsV1hOK0UyUTFjNVBRejRWZG41eVVySHpObis2RGpHbjBraFFs?=
 =?utf-8?B?MDFXZWR0NDMzamdsMUlFOGpNUjdzL1NBVDJLN1prN3Z1UzB0ZG1oaUcwN2k4?=
 =?utf-8?B?OXZRKzI3dy9lclRsZFFpMTByWjB6TXg4RVRralNJOGRRUEp0OTFZSGxIRUVD?=
 =?utf-8?B?VklYMWhUa3ZtUTFoU0hRVFduYkM2YXpZaEFEc3pmdTBmM3Y5UnVQc0JiOGVn?=
 =?utf-8?B?K2JPVXhiU2R4NEhkcnVHV28wcTl5eE5ud3QrRHJUbFQ4NldwZHhpbkhwYWc4?=
 =?utf-8?B?MjhHbDhScGhxb2JmTEVFNEdCMzB1aTBicVBvcGF4TUpWQVRJSytrTG1uYSs5?=
 =?utf-8?B?enBCOERHZ3R0U0lGeVJVZGNuazJOcU9qbW1tenlNRWhDZ1VNOXQrZUZJMUJl?=
 =?utf-8?B?UmVKOE9GVmNURUNHaXVCUzVmZ1BVdHZMK3Y0d3ZFSTYrYXdDRzhqUWFkWjkx?=
 =?utf-8?B?M05mblp2WVFnWUd0c0hoZUNvZU9hUVB5dXhlVkR6TWhSbnFZLzkwemx6ckhv?=
 =?utf-8?B?UmpaYzhQZ2FPMHl6T1VSM05HWW5ta2J2NU8xTXlFYzVsdHhRdTdaa1pITzlS?=
 =?utf-8?B?WFZVVldzTmJMbFF5Ryt3N2FoYkZadDVlY3EzbnZYcjM2bDlka2FwNHFUTkNa?=
 =?utf-8?B?b2Y3N2dsc0U2NjhWUGhleTQxNXhRYXBMbXgrNllBTHlTTGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3VvbVNwRnB1V1pFa1pCOEY3RVlZa2ZSUnc1d3N5aURHbklFS3dxYVBMRkJx?=
 =?utf-8?B?V0gzMllSZStIbkdWNjUvTzJHekcvTmxCcmh0QzgxZlMvc0JrbXZha0gzb2g0?=
 =?utf-8?B?SElwUDZQazUyS25oWTE0STR4UHFBYkZMNHVDNVZJMVM0OC9vVDhpUVllSE9Z?=
 =?utf-8?B?L1h6Uy9kMEZrM05kN2NabFd1ZDhiKzFvQlB5b0xVOGZ4SGFJZG9DWUpaWlJW?=
 =?utf-8?B?UXpnZXIzR09jOVpqTldpQzJmSjdyTG1NNGcvN1RvdzhtUDZiN2oxZE83aXFm?=
 =?utf-8?B?REhzeGVweERhTHlPQkZlU3dSdjAvL1B4azVMUmljeWZxakZsOVl5RUt4a2p2?=
 =?utf-8?B?enRxU09kMmd2N1BONWhjSFpNZEh4ZGpWbkM0c3BKZ0phdUJ3UlpUdWVLaC82?=
 =?utf-8?B?VTBmSlVZWCtNZm8weDVlL1NPQk9ycjJ1TC93SlkwWmxmcXhhSWNmV0t5R01R?=
 =?utf-8?B?YWtqK1BlTVVUaW9vb0wrSVloRGZzTHd5UDU0MjNYWEhBWE85Q09ZUzdNN2Y0?=
 =?utf-8?B?Sy90eFF3V3RmSjRNRHBNNkp2b2dxUVZrWXIvUDBHVDljL3M0UVZFQmF3OG5i?=
 =?utf-8?B?WThQcWplS1FkWlh5U3Y3U2RqTEdOaWZpZjhoT1c3ZVg4Rmd5Q2tDdkRJWXNN?=
 =?utf-8?B?MFRKbE5rR2RtSmduc2lIRURXVkh0VysxdDJ0Z3I1K0ZpWmJjV3lXM2J1cUh1?=
 =?utf-8?B?azN0SzMyMEhCQ2NGZFI1VEJVNllVTlZ3TlNBUEp3R2RHZ2FVcEdXYWU3Wk9x?=
 =?utf-8?B?VGJ1NkNJQS9uTUwrTEpUQmVnQVBqdzVCdjZtUXYxUEFVYndkKzY4WUhMWXlB?=
 =?utf-8?B?bEt2ZWQvN1NYTmxnNkw3QkQzRlkwRTZ6SFgzcmEwS3d0YXJYRHgrR0ZBMERT?=
 =?utf-8?B?NjZYVUs1UGczK0lFRm9GZU9SdkpNSnFocjZienltSVgrekZpaWl6VTdKOVVK?=
 =?utf-8?B?M0FBTFdzTWxVWTE2MnZ3NXVwTWJTNzN0cCtMTHBmaWtSZ0hFMkQ0ZUxkY1U2?=
 =?utf-8?B?cXAxY3lwdnR0L3U3ZmIxUS9tSmpINHp0YmhrU0YrN1E2R3d5cWlPbUsza1FY?=
 =?utf-8?B?VkRYaDRzK0JLd3JtZVBVNHlMUzkzelZqQ3ZCQm5DendaYmZ0bGdUS3BzUXpJ?=
 =?utf-8?B?dWU3T1M5SXZWMEkvTExVZkprV1JKOW51dGRSZmYvOHVNS1FDTjBUNWNPVjVo?=
 =?utf-8?B?MXdJZXhWWXdGRzI0V0pMeUhoWUZiMkJoY0VuSURNU1NFUUN5bkJyNXhqdzY3?=
 =?utf-8?B?aDNWR0l2WVpleEtsUG52VSs5OERMczMvakpvZWZjaDZ2L2k2bVZxbkdtQklm?=
 =?utf-8?B?VVZYWE1wQVFYNFFWRnBhTU1iQThDeGtXbWlEZnZzTXRMRFJpeks4ZmczdnZ3?=
 =?utf-8?B?OWpGdUNwczFGcUw0UGxsRmRIZFVOM25MMEFBM21CaXBQS3NmVmdNbjdMeStn?=
 =?utf-8?B?Q2ZVNWFKbjIra2tSZ1p5YmFyOXJDQ1dLRWk4a3VsZGh2azBuZTloWnhFd3kz?=
 =?utf-8?B?bHNCSE43NGdLS0lkclhuVjNoaFpBYlo1U3Fkc21PQmRqT0Rvc0NsbWF5eU9P?=
 =?utf-8?B?b3ZMVGlEbVdvK0w5ZU51aElaU0xjZmdEOEphak9Ob2IrTFlObkhSUWJ5YmFC?=
 =?utf-8?B?UmQ0MGJnT3VwbTRLVWsyU04vb1hLdDFjL3N1MkRmRW1BMTV6dlptTHNFaDgw?=
 =?utf-8?B?UnhFdFNucjlZV1pUditEakoxK0JscUR2WWJkVjZ2V2tqTjFtTDY3VS9IbGFD?=
 =?utf-8?B?Uk16anJlY0s4WVpiQjJmV2RpTjM1bkZRRkFYZGZ2cUliS1NiYlBhODdIYVg3?=
 =?utf-8?B?TFc2dWVUU1RyKyt4eWNKRTUvcTYrTFRzcURZdHh3TlRucEVLZjE5SERJQ3Y5?=
 =?utf-8?B?WUFONi9NMm5JbG8xdGJoT1k1Q1V6Z0JSYUNYYkp5Z1hhSExkT1R3eDlhZ0p4?=
 =?utf-8?B?S0FsQ1BjKzYxS0ZNTTF4bGhsM1pQOTQwblVFRVhmeld1L3FZZmpxWjdJdFo0?=
 =?utf-8?B?UEw2clBUUHRTZWxEQ2dlanREWmhKTTFpNnJlalRHZlorckNwRnNubXV2eTh2?=
 =?utf-8?B?Zm05U3ZHc05YYlVSK1ptd1psMHRUOUlscUxOb1VFS0J0YkJ0d0Y4YTJMdTZ1?=
 =?utf-8?B?Z21QRE05RVFTTDNydkR2dXRvV2dxMS9UK09uU3VaMXQ3MGJhUXZXQlB0U1po?=
 =?utf-8?B?MEtONnRBemVvdGptamo4d0piRE5SYSsvaG1zT0hPSDNIYkRUVSszTTIrWXdH?=
 =?utf-8?B?RGpySVpKdGFXamVHSDFKTzJ6Z0xBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91AB84A2BF24B346ADAEC8357134A9F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f1/CYaCAV9fvLRN98OR6NhBUbmiGBC17VCY6YOFnugvKcaoEGGRTfDTnU3e5jY8IgAr/unt7ZdbGvyssXkWt/ZsvIftax++A3xnfPpuENs9kyQSDVfzrv35yIjZl/LMcSuf3UlHhxsPzRaz6tuhDyG/+mRWNbbDuw8rD1ITX1R58v+is+AHcSNxT2sLpDUh7mHwGBLiK0DDrNCfKwK7RiaDEM2o3Htk1UDyyqz/uQBmYaz0RtyRhiaKzX15w+fyc0EbYCrql/FzyMqaEQJpeGxQ9crYBrpa9HxjJWK8yaZ3QYvCT4rtPgNBMhqIJoUYErfqinal2z6cmAw+SmRegYEFlF1Q+iU/WMtoz0oiGDvJC9mxTTyZbGwsynq2lhfHcUQZWgXIevSuN1ZIE0U6SEKveRi8cv6BOTMg9h8m5blTYlL++VSL6vsvGqjwBi5aQuGcaI1z9skK9rPLdoSUC4DlhUtQRsaC+CI7wlSh/USUMea0MYpqXh9vVaQ4IPCdVTAETdTO9MukwRskQ2I4JOxtiqCvBq4pDSa/Gfu1b/v8sDmJfaL1IvwMqil9mtLNvHb5QRx5IrBvPXrwkEoKo0KF1M0cyuTkZ+hkxQ69teayL/7II9QBZNyXY6TbRCTdg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1819f6c-2e44-4220-eb51-08dc9b430d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:32:27.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOOG9xUOwr6aX3CXESfGUQ9MiVWz7prcrX2PQmhbVRPSP44+zEZrb97B29V9DFH0V/Btt2NwIFxLb7gZk7Q/5TBFK8e4CVWld1RNin+aGLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
