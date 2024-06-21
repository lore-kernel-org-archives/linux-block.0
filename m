Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E316DEC9
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966770; cv=fail; b=P/wpnjc7J4RI0rR5b/M/hGHZKerhRKna82GOJq1PfvbZ7/eXU0ph0qSM1h7rCJXMO8oNNPCEPwlGUu1UWIMh62JGorUoMMWYasTxvClxKRz5Oa35sv1kisxsrN5MsvJiOAPtAKNaWp2EOE+/Y1/FSSkEzWLb2B5tIFIVHFdxHyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966770; c=relaxed/simple;
	bh=aDNvLIN5+TglSF0G2F5P+h5bTUi8faBN897C4n9wd8g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bod1mcI7sdxv+i4+H7auuaaRBmb2sGdNol5m42VjW1UHE+8xnZOyrbRswu3Qc1f05HBLmJnWiErIYfOVveOMuEskKomA+rjd82k9EuHyu1QatEFJhAblHWMh5B4D+6Vj79I3qmpy3lss61IeckrsHcM72thKuDCWBp8lTBID9+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QCT32/TD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uNy1GVDx; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QCT32/TD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uNy1GVDx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718966766; x=1750502766;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=aDNvLIN5+TglSF0G2F5P+h5bTUi8faBN897C4n9wd8g=;
  b=QCT32/TDEp1JVJ8s5YFrR+yMW4qdVA/L5oxXrZBmDVzWwTXydDitOejX
   vtd0A31VFefqoBDdBiPgW/KEWVbVrTbY5Q0ZfghCmEe/bHvN9IwkwqG1+
   NJCxK5A/UMPRMh8MHpRQ2GpUgmfGttoldC2YvdOb5t1TJLUpF8YuCM2DB
   cXvseV3q0NJh5JXjbD3lFClWBfsT+8bgkukJgQHnNAFVw2VZLojlhcKwU
   5Dqs9Men9uAVhEXv663iRoEz6cs257eZo3HE3zD8pgJ+YPGNkQOjvdGvE
   PNLMIFVsSXY8EJ7RUKin3M3OuLSV8XMB3rVr2NFVcBGqaXtwJtdFYisdQ
   g==;
X-CSE-ConnectionGUID: AsqGNzcGRBiL8Q4F1bYL9g==
X-CSE-MsgGUID: r68K15HdSEiCDk/jY7cHdA==
X-IronPort-AV: E=Sophos;i="6.08,254,1712592000"; 
   d="scan'208";a="19740290"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2024 18:44:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8xrcbC5vkfDv9UZHoP7usU8lP5fGigHhg4Qmj4TC95XNs+qusLzhpE78N8FvBywTBHA9+nWLWO69R87qdZLyuFTr2WwkL/oqERQYk53oBajoyvYrLBEEIORCl2tF8KLljNdQANDIlTlAe7GMsq8BdRlhXT7hTob0NVDNm7BSkMpEvdxYDFlXTAdI/kZ2ujz204cJAXnpiclRbVDtAuvvByGn5ZsLcAZ5RQYaUpoPJ6UG4E0HskwYqgYz3t5TObkqnVeHZeiVaRHo0SA5wI4cyCJeJE0HvxZrskHZ00r7pjRR0CEFNKLHN6rXGQb+8DF05a6DK4g2TsIaKqjLGG+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDNvLIN5+TglSF0G2F5P+h5bTUi8faBN897C4n9wd8g=;
 b=OIVjeVg3F8H70HLT+XB7QamGcuJlll0hSyvBs6CGdax81s6Py/Gm+OVpNcMSE5IxG2QDvgSMvLiWa7U3gqF5vBTlVaLLAKTkUZ8xyogjgRwYmdn+O4whflNXCdRO6D04uKuB1/bkV7HBLaLqr5Y1RfbRPQy/1K4On9A9Y3C18BRSEcIqC5dSrrHC0j93W1Wi9gT0iKbe9+kyTYwXPWc0tPoJqpl13CHsqGAgQpB2DnTA5uA17g0nDsIkPsgQS/ku5gNQGKgndJXkkVgclR6MuMlT5r8kxArLlAMIYdDSlBqVrAuWhQtYL+KI+tKc03EWpCMfJiG29XxekRK3KLYQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDNvLIN5+TglSF0G2F5P+h5bTUi8faBN897C4n9wd8g=;
 b=uNy1GVDx48Kh0pNOF92BD4PkiNDzScNkyDrcVc8P0m+yY2YayAJs0tAkpBtD8Z+Kjs16cjk5Wjqtp6x+L6rJmz6u1ZglGl6rvMk87Mo1/Ct1zaCClePWQ46bTf8PBzdC6nhuNOBbjwpigBZlus24ImVB4vCP1myssU8w5uuxYCI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7084.namprd04.prod.outlook.com (2603:10b6:5:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:44:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 10:44:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block: Cleanup block device zone helpers
Thread-Topic: [PATCH 3/3] block: Cleanup block device zone helpers
Thread-Index: AQHaw4lGgrltusXhB0OlPjL7jQ6yW7HSCQkA
Date: Fri, 21 Jun 2024 10:44:56 +0000
Message-ID: <04fb7102-7f88-48fb-9f93-2db55ad4c739@wdc.com>
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-4-dlemoal@kernel.org>
In-Reply-To: <20240621031506.759397-4-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB7084:EE_
x-ms-office365-filtering-correlation-id: 2a7c97ad-c023-4e92-e9a9-08dc91df30ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm5teUpYRG5XUnFQNVNaenRhUlBwc2l0aUFWNDJGcmFKR2VEOGZyOVVFTEh5?=
 =?utf-8?B?Y3RxUU1mckJIQzFoakRSc3BRS25nL0VaT1lVMEhnSG16UFRlZDRFVXk3RU1T?=
 =?utf-8?B?NHNDcStJWXpqK3RobUNDZ1U5QkttN1NlWE93a0k3RkoxRWtFbHNzelpNcCtZ?=
 =?utf-8?B?WFc3VStIRnlSbG5qM01RSUF1YkFBb1pSRmE0SUxLVzFvSWkwWWNGYU93TXN3?=
 =?utf-8?B?UHZ4SUdpOXpoWkQzUGRzbkViMjI0T3FEdDg0czNqbjQ4K2pDOVZpNmkycEZx?=
 =?utf-8?B?K2dXZDEzOUVZQ0srOEhGTnUwVXEwQVg1dmJzbnBHcGpCUHFzQk9yTjhJNlJX?=
 =?utf-8?B?TGhaeHNCaUN2bmpFWEltUlpRZ0V5eTE3SGN1RGZhTnREVUJhS1dpMXk1ZTg0?=
 =?utf-8?B?dWNUVzFlaG43aFhVc1FZbmpMUEh2VEpTckNJRnRBbDBHd0Y1WnB6VXk0dStE?=
 =?utf-8?B?dEtvNlRJc2lxcmRGWitjZjRpeGVnRHprT1lZcGphQ3lYY2JsSzd0QkhWQWpQ?=
 =?utf-8?B?b1VjeEt0YUI1eFE0ZzkzcElDM3l1N0ZiaHpTY0g4Yk9Fc3ByRnZwZlV4VTJs?=
 =?utf-8?B?c0Q2Zy96andURitmakRkdzlwNHFPdHZVYVI3aXkvZlVyMTRjS2ZmV0wrZkZS?=
 =?utf-8?B?NDVzbisvczlVdmFTc2ZxODUwNTZVSmFrQnZyYjVBcStaSUFZd3ZhK0F4UVBK?=
 =?utf-8?B?eDdpTUFnWlBnNjlRM2tzL01Nbk5UeEhUZUtocFdkaWdmZElPNkhZV3Zjb3ZY?=
 =?utf-8?B?MEdVUDhDQnhvUDZqUWxYdjNjVThtVlBzMGdmUnF3WFMxTXROL3BnZGxiUEll?=
 =?utf-8?B?SHdOVHJ5ZEF4MXZGV2pWbVFWUGdIcHZmMktWYkJnY01WYU83N0ZKMHZJVVZJ?=
 =?utf-8?B?dzZVWmt5UStZT1Q5S0JWcDNqSVBRLzh3ejVNS1hIMU1UVmVPN1lWclBuaWZL?=
 =?utf-8?B?aEtCSFQ2OGJWSmdiSU91dHFWay9yTTRJSzlESHpEMFNOUEVHa2NuR3BVWWkv?=
 =?utf-8?B?bTVjejFUUFpQczhKYysxTUVGc1Ridk9ZZnl5OFQ5aDhpeGdGVDdUMkVTbldv?=
 =?utf-8?B?VWFDTjd5azEzQlF5bXZpcmF3c29UN2FOcXA4ZFhWS3gyMHZPMTR1Z2lEdkZq?=
 =?utf-8?B?N1lrQ2lxU3lWWlh6SGwyaXovTGh3VUtLaTREdEVjM1p4UWlpU1JQRm9nc0l2?=
 =?utf-8?B?b1RVazBiMVh1RUNuYU9yb0VtcDAyemRIUjlkVXc4M3R5YWpidmFLSS9aQ09V?=
 =?utf-8?B?cFlKQnN4YUZHZ0h6Q1czNUl0dmVCSUVQa0tuWFJqT2FXMkRlbmF5c3lLS29t?=
 =?utf-8?B?bjl1VjdQaHkwbHFTZ2hwbUk2Tks1TUZmeDY1SzB1WjI0ZGQ4Unh5c2YvQ3p5?=
 =?utf-8?B?NWlzU3c4d3dkSk5icWRCSVd3aDh1NUhaVG1UNWhMaUR5WWFFaUUwNFREZmJE?=
 =?utf-8?B?U29rTUFFMFFOZjJ5eHc2TU9ZZGRJTVpZN0F6bGlwaHlrT29xc2tTTVVrK21P?=
 =?utf-8?B?c0R0aE9TUG5LamZYSjhRQW9LKzVqVUpuMG9uSGhCMXEreDI2QVJxa0F4TkRR?=
 =?utf-8?B?ZmZ2QzBKTGZZUHdhbWVPdkt2bEZ5MlR0TGxVWEFTV3g0MENUamJVc0ZZa243?=
 =?utf-8?B?WjRQaGxDRlIvWVVNRTF4MjRCRGJMY3ltL2JUa2RrOVhlK3lvL3FIeStDbzVI?=
 =?utf-8?B?UDNWaGViNEhabTBiV2E5QnJHOXNRckd3bng3NnhkSEJFekVMVXNLWmpwNGR4?=
 =?utf-8?B?WGh6alBCRnNhckdZVENYUUhwTWVubWIrL2lpQk42aXlNaENIVUlwT3IzYXBF?=
 =?utf-8?Q?tw5tqw9eIt4YItSLsVQQO98RphAoU8eWpDI3k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RklLSVlqWEl4Z2RQOHhJUS9KNjA5V1o1VXNKaDNDVWtQT3I3Nlc3aGJsUUVY?=
 =?utf-8?B?NTY3OFozM3NEb0x4Sk9yZ1A2SmpMMGFOQWZnNXRsWkFOWUsrbkNqVnBRdURq?=
 =?utf-8?B?em9aTE40c2FnZW5QUHl4TFdxYjN1L1FFZWdXcDBwY0JFYS9mb2RxWC9pOGFO?=
 =?utf-8?B?YnM3d0FCejVxZWxTeU1iMmhBakxVSndzaE5FYU1EZGNtcm1saHh2UDA1VWIz?=
 =?utf-8?B?SVpLRFAzMkJIRG1KYllWSHA1RlBMOS9zeGNoOFRWamdXT3pqb2ZXeTY1VUdn?=
 =?utf-8?B?M3BMSUpGdldCUWdWNURndnYxdlZ0R1BYeC9Tbi8vdEpmRzlXeVBqTUM5K2Y1?=
 =?utf-8?B?Wml4eFhtMDhtaENhbVAyNGJKV2tIWGM3Rk5LS3Nid0drUjd3TkhWM2NMQ0Fz?=
 =?utf-8?B?cm5yaUk3aThKMHZVWlI2R1pRcEJRUXlyalg3Z2hyOTRuQ1JBeGFQN1ZOai9J?=
 =?utf-8?B?SDBVbm01bktYc0doTENWTFJKZzBXcjJNMjNHZFdqR2MyUVFCRTg4OUJpSWhY?=
 =?utf-8?B?QmwrNkdpdUZLNGtvTGFGcFVkR3RiT2t0TzRRanVqeFZBUytLbzU5QllWOGlQ?=
 =?utf-8?B?NXpkV1BrQUFPRFhnOFRWb3U0NmFlUGRSQVpXY082czFHRGRPSlRxT00zcWhW?=
 =?utf-8?B?RTZRbnRLWFMyd2RqQ3hkeFdtVGdHTjlJRUFDVHJFbGc1K0xNb3lIUVFMeGZT?=
 =?utf-8?B?TEhKb1h4eFBSY1piaGJ0U0ErM2ltWE9wWDBDZ3d4dzF4b0VZYXNudWtITHBo?=
 =?utf-8?B?a1IvVld2YlEwZm4vSUtudTJwa21NQkp2dzcwNkc1RnpaVy9LaUVGOHVBUUl1?=
 =?utf-8?B?MVFNRGRUK3FFbFlrdzdScWJiaWhLUW52K0w4UXo2UEJRVlhjKzUrbzgxYlg5?=
 =?utf-8?B?QlJlVXJYZHhtRUN2NFZKNmtXT24rV0RoU0NRMEV4VVVTNlFEMEFWYlI2QmFq?=
 =?utf-8?B?Y3RIZnZ5cCtzajdjYmdmbzNRRFRRYXpwQVJFcWQwNDN5MlRFenIyeFBuRWVv?=
 =?utf-8?B?aVB2UWZkVFJYMUE0TFY3eHpUQjFEWnEwbzViNnRSeXlLdCswbE82MGFXTnJs?=
 =?utf-8?B?R3BRVHhxRURmRHYvSVZZRmRIK3l5L2Ivc2xabGVaUVo4N2Q2SXJMM0lHbVNQ?=
 =?utf-8?B?bGxOUS9Vc3FLcUk0NFVJOGQrZ1pwTm1ENm5pcnJaQzVHYk9XS2I5M0J2Ym0w?=
 =?utf-8?B?ZnRtQ29BamdqUjUvNTNYczBoTkRDSjl5RFMwUzFILzVDTG9PRHA5YXVvUnZK?=
 =?utf-8?B?dkdIeUFIYW9IZ3A5ZGZKWmpGa2UyRzBHRmlpZE5zVkhYd0ZtY0dVRUVjeDU5?=
 =?utf-8?B?dVNXS1VwdDlCdWZWWE1jUTd3Yld1ZVVQcVEvUGk4OW5uUTVQZENxQW1hNkt5?=
 =?utf-8?B?cDgzRUY0aXNhcTRFbGZBTU1JdGdzbTRYbXBJK21DVmN5YXlEOXhSdVFaVklG?=
 =?utf-8?B?amZTUDUxZjdBZ25QYXZPbjFxMzhmMHNmd2hQVHlhOHpUOWs2MXZoVFVRUkdO?=
 =?utf-8?B?R21TaUZ6UGJQaXRnYWR4VU1ZYy9ybk1tNHF5cStUaHJlSkE1Q3E5SUFPdFkr?=
 =?utf-8?B?UmhiWTRWKzBLWXNSYi9JNkhtLzJreVh4aDBJak9wYW4wdmZ5OVlxV2hqcVlK?=
 =?utf-8?B?a0JJak1tTDZ1eTJtbWdtU3IzRnAwZldSTFBOM0E2Y3IwV1NtaVJVVkZ1dnlp?=
 =?utf-8?B?c3Z2enM4WVlhREJ0bVVpckZmMGU3a2hxWWFpV091a1ZHbEFaeUMvUTE4dHFM?=
 =?utf-8?B?YXVLQ2d0dlFCbUN0K3I0aCtQTEZ0Q1dGVGtoWFpNVDhHcFVnNjJmdlpraFFn?=
 =?utf-8?B?RXNBWks5ZFEvNUhtazZ1anFsZUhoNHBKci80ZDE3RW1SakI4K3l0R21jQm0z?=
 =?utf-8?B?aVkrdHhza3haeVBJeUdrcFpqc3RNTytPZTg0UTBHSVgyWUh4amMzUXhvdFR5?=
 =?utf-8?B?NjlNNmRmRzNkRzFoZ0lMTnFDM0hhRmp5UmlEQXVHWXphWHFPWW9QWXUzenhT?=
 =?utf-8?B?OVdLS2hwZlludGZaTXBBUVpYRDVPRVcydlk5enc1Qm5HKzRYeUdhSEtaTEZq?=
 =?utf-8?B?L3I4am82dkZBUWlkblZsaVg2cDRGVzRmM2JhY3JDNGgwVDZlM2h4OEl1ejl6?=
 =?utf-8?B?OXBRVGI1RlJiNk1WOHhXVlFBOGhCeUI3V0gxQnRlRk5hbkRvQSs0b2I1Vy9L?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B782303E73CD429B4C2413A37778E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0XpFXe/Dc/JBKumXwMeE1NEmT73MRhl5DPjIQ6z3/2CS72zWc2g25vQJkNsZCYYvKhmr2SWuTmKEr2l7Ft8qW3Q7mriQRM98zI3sCK8ClOQS2d2NErYgeMrWWJr4SoNFiPz9H1Z8ZndHsJFssnttWuyBKnzNTQBGt5U5LCjbJUnabS208bsu3Dwt1apHqY/mX9GtvKzNjN539TbsZMX3V0DSaBl5NucccqBTWqHQwHsymV8W0n1Z34ECKuBQJo23WEXSvVKKWoCXY/au7BzgOLzZQlQSTbyaPuD9xwkcYPPvrYFjSymnqci7y3YaW82lrz9aknIyfTKeIX0/NUMy+KtpG6BSlzuBY36exMIzqNEv24uPF/ZM/gjn67IdBRm+3lvwBw981XfzLUSsLE3nycGz8kgneArRPMqUhBpWun14pKsouo/+NGlQVDFOdocvOCXUJ0A9PTlJ/cwZqEg8k2mAGwGi6OZDXXfXfHPPSyYH5HlPnBq6ee5Q8BNM62o7knXnPSyFNrafJtEhRrZKwpPfZ6MdvWsrn2CnVMk+RkW1CF2oOERK1B5jGQCmCX5M5PSc9WXSe5e7VPl9f/qFuBM3xIpgOoMTBHsMmU6yKeC/4cZu9kRHaSmy+91Tcy42
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7c97ad-c023-4e92-e9a9-08dc91df30ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 10:44:56.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNKkZO8BgS3PkEw+BXhCHCrBx6AceDGZ8p6/kLlULPeGokaWbyq9s2q6pkD6nuy1EZ6QTQE5zITy/Jc8eyW7k1ZsuZG5izp6+bkiRpPOJzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7084

T24gMjEuMDYuMjQgMDU6MTUsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBUaGVyZSBpcyBubyBu
ZWVkIHRvIGNvbmRpdGlvbmFsbHkgZGVmaW5lIG9uIENPTkZJR19CTEtfREVWX1pPTkVEIHRoZQ0K
PiBpbmxpbmUgaGVscGVyIGZ1bmN0aW9ucyBiZGV2X25yX3pvbmVzKCksIGJkZXZfbWF4X29wZW5f
em9uZXMoKSwNCj4gYmRldl9tYXhfYWN0aXZlX3pvbmVzKCkgYW5kIGRpc2tfem9uZV9ubygpIGFz
IHRoZXNlIGZ1bmN0aW9uIHdpbGwgcmV0dXJuDQo+IHRoZSBjb3JyZWN0IHZhbHUgaW4gYWxsIGNh
c2VzICh6b25lZCBkZXZpY2Ugb3Igbm90LCBpbmNsdWRpbmcgd2hlbiAgDQoJdmFsdWUgfl4NCg0K
T3RoZXJ3aXNlLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo=
