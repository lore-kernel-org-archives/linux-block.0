Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABF284B32
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548851; cv=fail; b=VuGsD9EMlAuPcCyT+tq/CJQh2QlsB3Yu1fCn5lX5OpGNrl6Tn4ufqtJ2ay0n9EiiSBW7TaS0QTkbo4brNq1J2duVI5XJ7Z5ulSvWiZteTmEuR8h88aBcc2kSm0c0FtTKGmrsc7cl3OrGCEa0XtCSCT0HjiyGSqFlotGbO0/nxUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548851; c=relaxed/simple;
	bh=DdFlBsvfpb89Pqdx587e+yMZTP9ciWAdOWbOMdzIfbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krUAXLtcK/KQNo5O/ghmkDILQ+N//JqzY1/akHr8o7t8F2ezBbqt7861x7L1lU0N3r//+3Uxu1tpsyieGnXGes1ggpC4891jR0gkKvmS6+V8oCmC/obRzX4DUvr6kw0mzP3Qf6/9v8VEfc6VMuvlAwVrGnXNluXKFuRLbVWUW8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RSbsa7R5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=A2Druztt; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RSbsa7R5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A2Druztt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746548849; x=1778084849;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DdFlBsvfpb89Pqdx587e+yMZTP9ciWAdOWbOMdzIfbo=;
  b=RSbsa7R5omA1HL5WqLdurYvvrWc6jULSDrUQ4517I/XfBaE32YWruhZp
   un+m+GNC2dOqiEUNxhT9S0U3pAuHb5n/se7i6lN4b2AupqmV3XTAKJxov
   NWCaQrRx6RgwjmIJaxjLnaWVrwrkOqKhisF8iyUd2wDwVXBrM4LcV0Q6i
   N7j0+M/BtDm9TzMJaKDK4Lq0cxVh/TWrBa4odbE5/W7L6FqTqAOkDJ131
   93NVhr7a67+XXFn0Klx3/fTaWe4bbfMg4LkrWe9oANG52yeLNILswmUiO
   rGCZH6e1zV8BtXtQ2pcwEcjknAoWJ5gV8jS9GOgnV3+x4/T8obGjIH76J
   g==;
X-CSE-ConnectionGUID: xlZVxT8YRYWLFT7ehFCWKQ==
X-CSE-MsgGUID: p2RywF99QOObYKVDSw3ZOw==
X-IronPort-AV: E=Sophos;i="6.15,266,1739808000"; 
   d="scan'208";a="85350438"
Received: from mail-centralusazlp17010003.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.3])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 00:27:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMyP3kvIjh7LeJv0mrL4dU4VLN4ZzFLAk9E8nVg+AD/Tkq4LmwvX+a1V4PUrd0bX/flOlzKerQAc3QYIws+RUupdm9IYdsa1glpn3+9cVA7URVrC2O/Zx6BBc2yvPK2u+NP3jWGNYikbFgx0ApXI5zL2FVFI6Y2hjJYRqADGk8rbkk99ETVviCmmvaDxrZnRahulG5h7GchDoPGNCWoZ9K86n6+W2we5m2QMLTaB8HQs20P7vTJF9yX3Hl1T5aRV26Vzy5rSyHPPcLmI7dVGfShdS8S1Qzeul4hld/JUbNlz4aj/OP0oWMMzaUzAtL6OnX9RFR+1EcDzqnyNvVkmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdFlBsvfpb89Pqdx587e+yMZTP9ciWAdOWbOMdzIfbo=;
 b=sNLj1Past0slT8kjBJl6DBCCKDKplpgczNNYbqKsdTqqyfG0jqCopjiZ4b4gqebBnenc4WOck2WjhhrUQx8GXdnoBy5AhRJl31NqfhBJy1pvNkEj76FHqWkZvAg/nc5/mukHi7PO/1mPjflbVvEY4g46gsKnRKt54FMrXYljybi6VAPpTqmPry9PTinyr3lSqg6xUDQX1RO67aDY0V3qbCd+dS1sHddUwXuQbU8fXNKOij0oeBnutoxX1uRNu9BCJKDv+TX70defD/qySHVc7HP2EfbcyvsDlQwppPrWXVdPqzrhlMi3q/6GrxoNGtWTOK2tfx7rZ33TBQ5yEDT2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdFlBsvfpb89Pqdx587e+yMZTP9ciWAdOWbOMdzIfbo=;
 b=A2DruzttVSeBZjK8xjGjgMvXbEKhDlqzG6/FlrQiiUHc+WKBP6zqTpWw9uW93vdEb/WSfAuuBrlbBPyOpV5hWnCX0jChq/cHU2wwjNG1XKhSuZLOlupLhA02gI319kI2tjY2v9g9HqsROelxI//jucbM1BmoPsiADl+DJdMIhY0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6333.namprd04.prod.outlook.com (2603:10b6:208:1a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 16:27:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 16:27:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Johannes Thumshirn <jth@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
CC: hch <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: only update request sector if needed
Thread-Topic: [PATCH] block: only update request sector if needed
Thread-Index: AQHbvnnmwXaDW1Tvd0eHedaFi6EPMbPFw64AgAAG0oA=
Date: Tue, 6 May 2025 16:27:15 +0000
Message-ID: <8dd9c536-b7e2-4356-ad33-5c37521d0872@wdc.com>
References:
 <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
 <5ccb451e-f13b-40d8-9494-e5a2cedc84a3@acm.org>
In-Reply-To: <5ccb451e-f13b-40d8-9494-e5a2cedc84a3@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6333:EE_
x-ms-office365-filtering-correlation-id: ba263043-0ec2-452c-6fbf-08dd8cbadd23
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGJhdDY2bitUL3dyVWJqbVBYNkdLM2FXc2xKU3hxcmJrZFN0U1I1a0dMcjJV?=
 =?utf-8?B?b0t0VXFYM3BFQVdHeHlza0xDd0NPWGwxSVA5VXNPY2ZLczduWXhheEQxY2c5?=
 =?utf-8?B?Z1pYTWVta0ZLWnhDR2ZSaDFNM1loU2tQZno3amJMVlBPdUVHNWhLSHpHSDEx?=
 =?utf-8?B?Vy9ER3M2YXFVb1c2UHFFWlJKclF4WHZVVUwyeGZSTVZXSy9LbVZZcjBNbDgw?=
 =?utf-8?B?cWFHTmlmajZQTDQ4M3M3c0lORXc0TTJUdys1NkNZbDIxTVNTUFRwSnpQN0lG?=
 =?utf-8?B?eVpIZWhtcFJxTzZSRS9sODBDMTZkNVo1anhvaFdPQmZ5Yk0wd04rbGpNMWJa?=
 =?utf-8?B?UWVXMXB4RE43bXFneHgrK3hGL1Nhd29oRUpBWmJuQVp3VWtpM0FBdTJ6VlBX?=
 =?utf-8?B?aWMxd2w5aW8yVE1OS0R5RkdlZTMvdktzWWNwZGhrbEM5UWs2RzBTL3FQODBa?=
 =?utf-8?B?VmpiN21tbFpPVUYrYzVRTEt3NVhHNU9US2VPRFEyUGJqeUFqa2xkV3lXd2tu?=
 =?utf-8?B?dEx0bHYxQ1g0aWtjQitQUXZ4UG1SdFQwNGdLTlpVbTY1VWNPVkF3NzErc1Iv?=
 =?utf-8?B?U01IeFJJaEpFYkdDNllhVXVXbVpQL3ZHU2g5c3dFblkyQjNpTldlbFd6RVRN?=
 =?utf-8?B?Z1kxa0xZdHI0QkxLd0EyOUFJWFExbG52R1hkdy9EZTUyNnhtWlh2MUFBdk4x?=
 =?utf-8?B?cVliTmVmMjVuYmp6UWNPdm5DcnpibWo1WTRTQnFCTWI5d2RlQnR2UTJQQkVL?=
 =?utf-8?B?SU0vcGdzSWxSazdHcWhyYWZQM1dIb0hGSEpML2xlT3VWODhSVElNTVVjcVNW?=
 =?utf-8?B?Qm5wZXdRUEFLWnlrRWx2QW9Tb2RQRnE0NVd0UERXWXJJUnBEQnllOEhEK3N6?=
 =?utf-8?B?azZWZ3p3dFdwMGJ5RlZhMUNwTE9LRUFVZkxCV2NEaTlOcXdHQnM5aWRoL1lr?=
 =?utf-8?B?T3pWSEp1T3dKSlk0QWF3aTV4eUJyd01PanN1WU1hVm9BdVJkV3VEWWx6dldN?=
 =?utf-8?B?dko5ck43VVVPOGw4dGNRY0RqSklEMWlqcmRTRWZ0aTdGbStUdWdtTmdFRER2?=
 =?utf-8?B?VjQ4bWxWL1Fiblh5WFpxWEZldmdCeFJjR0J4MmpKMVlCcDFYK0hLT1A5WDFr?=
 =?utf-8?B?c1hWejc2emN6dFpENXpwQ09tTWY0L1V1T2RsRWpmQXdnL090azdTVFBQYkFE?=
 =?utf-8?B?czJDRE1LQkVRT3d4WC9iU0FzNXk5KzVOYnZLZFhiUGlrZktheVlEVzNPNjli?=
 =?utf-8?B?cGx0a3JCSzUzbVdCYlYwbXo1TnFxSDlBUldhblVJWDN0TC9rV0U1UHptY3Vx?=
 =?utf-8?B?VnF5L1orQ0NIeXIzaU1VTVpsano0VmhiV2pHaHpVcnpaZStPS2JUTWdHaUtv?=
 =?utf-8?B?VGNPbnIydHYrbE8wL1hlZ0pzTVhVeTdlSlJyUkduYjlBL2g5WjJzb2JRZFRu?=
 =?utf-8?B?dzlKT3lwUU5FSDJveGg5dDVRa3JhUWlGVUh1bGUrc043dGxXZCtvZXk0UmZm?=
 =?utf-8?B?VjR3dkNVTWxZVDlZY3NOdlhQRWFremN6ZjRJaVJSaHZiNlpmSHhaeWh0T01D?=
 =?utf-8?B?bnFhRnlEZm44dlYzYUJ3Z3MvTVFRSkhRenVUcXJXTkJWMk9pTEE4bENXM042?=
 =?utf-8?B?TXY3aXdpaVFuUFNta24yVlJNNFRTT3ZVZDRSVjk1Q0tnTFdVMDB0MXZneVVW?=
 =?utf-8?B?cU14KzlzSTFVSmgxNmx5bGNnNVhGbWNTaGUvdHBFL2JCdjdFL2JMeFdZZWlM?=
 =?utf-8?B?dTdaQzdHcWo2bjdoNExlSlFXUnNXczdiYkFjSStQcmR4Rmk1bWVaZ2x1Szl3?=
 =?utf-8?B?V3lhTWdsVXRCVXFTMVZ1ZEJCcG1RUGtncTZrZXhsUDNnK2Z5Wml1eU0zbis1?=
 =?utf-8?B?MXluL0drZHZiTzlXbUJnQkpaUC9mNlNIc3FpanZTVHpGNzIwVVBaYzRCSDls?=
 =?utf-8?B?QnZJVEVGbnEyNkU4NC9JaFFjVWJTQWpJdHdWUDZBbmNodi9LM00rcnovbVk0?=
 =?utf-8?Q?VwezA+CbwSE04UJQzGwx0xBnizpljc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0Q0Y1A5ZEtBektuZUo1aFpNZExMWVBJaFhnekgzSXdsK2NrK1lRQ0xBSUhG?=
 =?utf-8?B?M2xXWjZQUG1makw2V0pGRnpyNFp1a0dQWmFSQWJwdXBQMjYxM21yZlUwODlm?=
 =?utf-8?B?RDZWazV2K2J0TjF5RXFDRjNqYXg4UXZWSTFZZUJtelovTGN4VTByL0FrL0VU?=
 =?utf-8?B?N3pYRkR4WmQ1RW9URzd5WnUybmp2Qko0dWkreURZR2RtY254VWhGSXk2VWN4?=
 =?utf-8?B?aExKdCtpUmRuT0lwSm4xak9ub3ZKVU9LYnp2S1MrUjBiNHpWb0VtRHhNR095?=
 =?utf-8?B?K2xtT0NXQUljekNFRjd0dDJEL0tWY0NKYkt2L295MkRxME1zSGJKbUtsVXU2?=
 =?utf-8?B?RkFZVGpmb0Nzai81VW56Y2tDR3hmYUlqR1h5M21jRXdobmpDODAzcjBqYkIy?=
 =?utf-8?B?NTUvQ3RscjVQb0Q3Vm4wdEtXN3NSQzNpbnZwb1ZuTWxjZHdRanp2azlqOGxB?=
 =?utf-8?B?czJYYk51RG10N0gycFhjK1JGZEZnN0FYblNGWVp1UHBib2lJY0NJVkN6Y3Vx?=
 =?utf-8?B?YnNEdXpJbU90eThWOUMvV2FGTVpWVVU3R21nWHptbEdVMXFXc3pxVjNEb2tk?=
 =?utf-8?B?MkVoZVdmZVNpeDd5S3U0bXNnSVdnbUZ4YXBNRXhRM25DSmNvWnVNYk1tVXg5?=
 =?utf-8?B?UkQ0c1NtbXhkeUtXNUpFbDB0anZQNUtDM2JVcmM4UCtWT3dJaFp5STQ4ZW4y?=
 =?utf-8?B?eUp3eWNnUkZUbkcvM09Va0ZUaTNGclVJekEyQThhMWRSWTEvT0VvQ0pFSHdQ?=
 =?utf-8?B?ZEhOSkVXckdTdUY3SC9iQldLWC91ZWZHSHJUbnQ1WHg2VitsN1Bpay8rN3I2?=
 =?utf-8?B?OHhZeFdNZGZNOGZkd2pXMHhVbitRUEw4dlhEaGJrU1BHMENIY3hidFppd3VS?=
 =?utf-8?B?WWdkc1N6c240TWJITFFpQ0VIMkpwUU1aZ0paQktVTHFydk1qQUdDTkZzZU5y?=
 =?utf-8?B?ZmxlZDhBcWhvMFMyWXI5d0F4dENBR1MrYmFCM0FMZGpDZ3l1b1hWMTlFbWpz?=
 =?utf-8?B?SFpPYVNFUEZDWWhhV0Q0UmEvSXZKNHMrYzFtaDZ6aXJZSVAvZXNnUXRqR0Y5?=
 =?utf-8?B?VVY1UEFsekovdmR6MDNlbWMyWE9HUUhZaTlXV3Uzbm02aFBYMndoQTB4S0VQ?=
 =?utf-8?B?Z3RJc1dHRDVuSWQ1Y3JZM1h6NTBmeGpLbDYrL2JzVmhPdEFUZGlXSzZXMWNH?=
 =?utf-8?B?eWJhRHV4MENSWHVINGRadTVHaEk5ckZKeVJEdmVBTEhZZ2ZweG43aGZFMkRz?=
 =?utf-8?B?YWtHVkJDNnNLZnRiZ2xnRjA3cVQ3b3pNU0JEQ1NYdE5BZFZMd09wSmN2VWhO?=
 =?utf-8?B?Szk3b09mWjZab3BwalZsS1NvMnJuaWR1elVUQXRFbE10NjhOb080Q2RLZTVV?=
 =?utf-8?B?V0hEaUJ2Z3hKYTRRcG1aZzNPeithcG52UDhROWNtQUNhRmpiL0paRVUxRllz?=
 =?utf-8?B?Q3dyK29HM3BBWHB6MUxBZlYwRTZnY0FwT1JLcnpIN0ViVUllb2k1ekhIdE4y?=
 =?utf-8?B?RFc0OE82RWpNenk4c004d01JSzVpY1VUenYzeGo2NHB1dHR4WitjRExFckVW?=
 =?utf-8?B?d3VSQU82cENRSkQ4QnhoekxzYnZxZXpvbWxacTY2aVNRVVhTQkExU2tkSE9Y?=
 =?utf-8?B?bFRsZkpPbXFaTmJsOENWMGxxQTl6RktGa0g2MWJUcFcrOXhtZmZadzVlQWl2?=
 =?utf-8?B?WGZ0UXBYeVNGV094QnZHTEFRRE13S0IwSy9rMnhpY2x5N0dtUmtZTXNvMjdT?=
 =?utf-8?B?NHBwWGcrdDU0eUNQaVlIMHRiWkFNUnpoL1dTOHU0YjVmcjhiTkp4dFBabFR1?=
 =?utf-8?B?ZURiVkVBTWphTzJBVmNENDMxNDhib20zbmFEaWdCczY1dVk2SURYTjF5TzJS?=
 =?utf-8?B?bTdWdkZ0eGpaQzJTV3BJRDlxWkZ1Q29ldmxkTHVId1ZzcVk2UGM5MjYwVGpE?=
 =?utf-8?B?WG1DQkErNXB3cXZMQXZaZ1V6QlJpWHp5TWI3ekZ3OFM1MlN4dmZuWnlQSEda?=
 =?utf-8?B?bzRzTHRCSkJscUpkNWpkeWlCVEd5SnBtd1g4Z2d0V3dCb1h5Uk5ZUGIxd2xZ?=
 =?utf-8?B?eGRUbmZsdXZiS0NvRkJoVjFLWnVSdHVYSlI0emM4MlZGWXZnZlArUmQ2UXMv?=
 =?utf-8?B?NlhXVTNMbTlhRTNEUG8wN3BMK2RCaDQxOWNNSW9tMmFPNFJiTW96RWdqb0Yx?=
 =?utf-8?B?ZVFhTSsyOTQ5M0k3MGhXTjhqb3ZsRDFEQWFlM1JyRCtlcWozQUVGNFZEdFRM?=
 =?utf-8?B?ZnlzZVdHeGRyeDZUWGRZdEpiL3d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3460E9EAFEA9341AC205BFB535F3A3B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jwyqWwWKOH20UXvuNKjZTbmXy2XJySXXeuWlg/wHlHv2aPfLJTX1NQMwEp4f9sNqiKuT8PGE6yM4zfvTk0tPEA2sK/BJ2SSsJq+I328YKHwHnKNlflxfcsYOgXXW4/Ndy9YEfzlRf4ulbd4SSRuWMlu9ZjS7DWe3rIjPYQQu+qa4zhhIIMgwzlzCq2ol3we0ExVWql9ycD7cs17NIH2r0B/Ld/N2FX//AppeLwwV1EHWucU9DFOtS/BAE2J+d6EhTmUnxwSFRe5Y5k6stLA26Q01AnDXbYU2vs10tp9KUA7rv6yYI5d/GtXQp1IliEb4hVLPpviSC0mbb7Cn8RyARFAmoKiwdhFk3ye85SAP8LyVh0yHc43DfF5nze7LAqT4+s7QIulhStiVoGoYEcy0bJaL23Hqif6uEzh8mYV/NcSd4Ol51RaOUZkJRQU7KLfuoA7NB3JLCFR0YmgT6aeRfJsbn6hpf0J2I4H4cEygvP+6jEy6QCd2IIu8ocEGTd5vK42T1F/rRlGhGKrRQyTEGsQhKZypMFPqYKddnQPgWs/oey+tEUlW3Dwx6jK5qDMFXCuftoO8hBNFIStwq/bDu7F86WCfonNXlGrdizSsuIfLONpFWBDrIco/9kPN1LeS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba263043-0ec2-452c-6fbf-08dd8cbadd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 16:27:15.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dp3wQJvIEMj7LC/0XTm9TcHw4WyPt3xlZyijG54Vickd7iJTKj/gp+EoGIVprluREeVvR/quCiayZ84m0NWjJdCwqQWgTtRBhVIIomkn/NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6333

T24gMDYuMDUuMjUgMTg6MDMsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gDQo+IERvZXMgdGhp
cyBwYXRjaCBuZWVkIGEgIkZpeGVzOiIgdGFnPyBJcyB0aGUgYmVsb3cgY29ycmVjdD8NCj4gDQo+
IEZpeGVzOiBkZDI5MWQ3N2NjOTAgKCJibG9jazogSW50cm9kdWNlIHpvbmUgd3JpdGUgcGx1Z2dp
bmciKQ0KDQpXaHk/IEl0J3MganVzdCBhIHN1cGVyZmx1b3VzIGFzc2lnbm1lbnQuIEkgb25seSBu
b3RpY2VkIG15c2VsZiBiZWNhdXNlIEkgDQp3YXMgYWRkaW5nIGEgdHJhY2Vwb2ludCBpbiBibGtf
em9uZV91cGRhdGVfcmVxdWVzdF9iaW8oKSBhbmQgZ290IA0KdW5leHBlY3RlZCByZXN1bHRzLg0K
