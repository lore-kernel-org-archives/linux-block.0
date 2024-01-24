Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E017C91
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088680; cv=fail; b=VebSrzWNwyWact2Cp01kbzrSTKgIzj7KK5w7wtC6+x8HRRYfhc6sZitMbj/MSP92inRPMDDKABwjyjJQjBzR+LCTLKZnRma/+dh5aLfrAyqYnyEi8a5PGZl7qvRicOWNIjN/s09rdMKCU8JvTgp3YGND71vzdsPjzX4YI0u6KXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088680; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANqV0Ei9sQ2RJ+uDSCM6lG5DY7JYaS4Dw/94/hoJj65VNGqzLHTeMWZces/WgiXoItrg73XKAD8kWsFnmEBtmWWexrTJWt4AR+QxXOK9YLTDawknRGuxYyf6x4wxJluKnHW0H49qqr0wv8VUYLKGXBiJiCGa133PnRpmimu1DW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZMr2ycU0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bPgG0BPp; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZMr2ycU0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bPgG0BPp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706088678; x=1737624678;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZMr2ycU0m0OYzI87FvKKU1DgzefKXLcc1+5ErDLFqCldeWiKF13vB+zm
   sdDmW74Y13sqsRWWVkKArnXyRBCcv7r0iUOJBj3GkMWtDIdJsFU5u8tXC
   P5j7N0xk/u4tx1XIUvJWq8LSUHcTP5QMjKsY44IAxRZOess1qx9zo+wFC
   0dxFyOyUps03GCiBx/H/7lUprtlmjDcTMgzd678GxvZA+0gAPazurPW//
   7+fd3OCMYlbQp1VdlBfQyQosJ0mE9cZ14ZnjW/b6AghT7dzXpDZ7Pt3xT
   sVrN+lBV27msZSv3h3U19SyB2q47wo26yfWB2bHKd0Atjmnr8VbWFEvHX
   w==;
X-CSE-ConnectionGUID: FfH8QHb1RcGf1+bu8QbLDQ==
X-CSE-MsgGUID: Jb6M6R7SRQeSOWSQropAvw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7611982"
Received: from mail-westus2azlp17013030.outbound.protection.outlook.com (HELO MW2PR02CU002.outbound.protection.outlook.com) ([40.93.10.30])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2024 17:31:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1NiqGoxc3W40sv05tU8OdMDnoZhlvSJccZCRTDMLPgYnpHnd8+b3K+8vzcYsr/zTnTACehFg0FtGmTBe2M5KhX0eMaF64XpbfWqqzV2PEsQlT6+D/sVxMHoq3Ox+0rwZD3hDhzDhH9z4IfgNX10q8C7lMwUngx7Ltbh7yY7MPeiR6LIaUpzZL0w6nEwZAm62dyay0qs2yydQftOOlbn1qof/JY3JaqQuLsTGaTnt9lqrRuxSk9Q1Che7i73znjdV+JLfVgPQGiEgp5hzLfJ45Z9Mt3mQ/X/Qgl6G2g2JmWR/pKwtQibUDAeLm5hUg7RRsHd0LYJFwGT7wp5XqozJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZVDwi3bTACigIB/Wg8phiH7ZUgD8WXSUlx6MM07Bf9NHROAy3Q2DDtDCscu3gAPSkgNSEyJNVHtMNlng4zS8RynSvK5PcPlchDBiGJRkLdVmtoHKHVhDFHe72ZIuHWrx1dss7AmHm4ZOVC7tRO0+QRnPX+DCdmjYEBL/mwt+v/IEZFmVVo3+0vCgLpUtcjoIS7aR6V8x6W2stMgH9vbLQK60iV03+jW4zynqlOV/MQFONIiHdscgk+lUUxTbvOWkzWHmHgsIr+l3hXzyWGBlpjbYZuPhS2CHFwW/tDZEColSFWq5jIs01BV/eqR4sbzdHFjCAfcow4i4bMgDmLYZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bPgG0BPpYj2cxKJojQ9IL/5XePVlI587zd1T1ZBVWaDTvYJ0AKsiVwcCV7+4IHYiwitml64MtLdSJvwt+nQnNWD8HVp+34Ukb6KvOk2MrA/QdDnXE3nFT0HPggEO/ZyX39/0bJkNbOSFcHn9kln6l1Wpmx0DKxCK3+ccNBOtnUk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8493.namprd04.prod.outlook.com (2603:10b6:806:326::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:31:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:31:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/8] block/mq-deadline: skip expensive merge lookups if
 contended
Thread-Topic: [PATCH 3/8] block/mq-deadline: skip expensive merge lookups if
 contended
Thread-Index: AQHaTiNOmtNFo9WXa0WaJvT5OaLeYLDos+CA
Date: Wed, 24 Jan 2024 09:31:15 +0000
Message-ID: <8cec4aa1-6e3d-4adc-9495-53755448a708@wdc.com>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-4-axboe@kernel.dk>
In-Reply-To: <20240123174021.1967461-4-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8493:EE_
x-ms-office365-filtering-correlation-id: 1718eefa-d3f5-4d5a-b45f-08dc1cbf3671
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5H4LcYt2LfeOlX3aNLTL3qzqBEeFViVXN9/Fw9exluqTReK3Fr/HCyg8MgkD9YDemw8rNoGehLjLZmUc934uviAjSy2JXE+lE6ZUOEFLsyLT53Pmxgh7blsQKAYXBrX+Jr/PFjVYPLgQvGJfTb6AAmBmtEl2ABDu6qh4HvWIfV/DlVZZhF7lsRgwPmxPGjOvKLSgo9U/SSHQAxUdRfccYngQSKESCfgBwvUR3vGZLDz56srGFUjrkQmTUa3HW1EvIN7Jp3T1sS/tvvkQQWcDGtwIch0C/CjHtZa2GL0ig2HouLVBO0WagIiOFwTbIFQQDtlfsrsQs2rEOjGhejTttzWwxyoKe7H67m864duj3NdPag6qIMB5+UaXnF16u80S1pOJWGimD/ZGfDsCUxtf74MACYlPziQcvL+khYgr4bujBk5kUr4ppNvIJiAOJ49ZcZVk7RFSkqfD+mfqo6ikSFv9jd9rEtFpB3/Ho2MKaLFu6a6uVVut2H3e/mUPhjZ0/M4KO6szi7Rc/S6Zfy5cnhksyLN4yfxe83DmZXNUNyaq6W9qYnYmL4QYk9LpALuS4ufhx2mzoq1SMET0ftOD/JJUOfqAjWgDN/sXhKmL0LqGaRiFnJYtZ5rsEw1HelcxbdJmHqaQA3MmCVgNQ813KPCwqg9ZbOfcvpvqwQL7tixpGl0jzjYvKKiv28KX+Euo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(110136005)(82960400001)(91956017)(66556008)(66446008)(66476007)(316002)(66946007)(64756008)(4270600006)(6512007)(2616005)(122000001)(6486002)(478600001)(38100700002)(6506007)(71200400001)(8936002)(76116006)(8676002)(5660300002)(31686004)(41300700001)(31696002)(86362001)(2906002)(558084003)(36756003)(19618925003)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm0vVzdieStmcDJaY2FTNHVNek1BaGVmeG5QUExCOFV6dG1kSjZNVXZZdXRl?=
 =?utf-8?B?NE9aN2lmSFdDWTlPdFhUR0RkWndDMGxURUwxOEoyV0NjcmFsekJCVzU2Z1Rl?=
 =?utf-8?B?Y2NPSkdoNUtXK0llRHljWjBsZ3BpbHJPc1MyTzRWRzNxWStmSXNOYm8zV1Ji?=
 =?utf-8?B?RHJ5aGRkdXJSbTVXdlJTcExnTzhRRVJsTVNmemwrVmxBVWhQM0dXT3o1UW5L?=
 =?utf-8?B?QllLT282MVZSbXNNaWwwMHhpckpneXRPTkEvbmRTdkNZMUNRZ1puZUY2aXhq?=
 =?utf-8?B?WnRacG1iYmNzVDllR3p5c29Ua1V4bDlXL0dvSVRaZDBhM254RlJxSTk0WWo0?=
 =?utf-8?B?bUloNjU2NGRnVTF6STdtczVCNXVqNENyaEVCTVpzV0NqeldVRDhESUhKdUx4?=
 =?utf-8?B?OHlIeE8zRGowTE5Hd2NxclpTdXV5WGVLT20zQ2lkd25KQUNlNDdIMmpYZUdH?=
 =?utf-8?B?VTJLQXI2eGR6cHU2Vm1xQjJYOS80MGdqbytKMkNGeWFsNStGbHB5UDBaUVFK?=
 =?utf-8?B?ZnRMcTA2MjZwMXFkZXhURktwVEFXMzY5dFNEQ29TanI0YjV5M0ZsWjlOT2JJ?=
 =?utf-8?B?ODRVY1Q1R0I3MnByWE02RlloOUpCcEI2OU5iK0hPcjdBOFhBVW5jZzNTbVRB?=
 =?utf-8?B?RWVtTDc1QXllS3RxWHZ5aUZsQjNoU3JvcHBWQm5DSEJ3MTNlamNSYy9JUGRP?=
 =?utf-8?B?SzNkUFgxQnlabVpnOFJ2ZjNmZm8yZmVRL0dFUnhsZEY1QU9GWnRxK0x1blBu?=
 =?utf-8?B?YXVhd2xYZDIxSWVjNXloK0Z1UEUrbjE1TmRqL3NaV1RHbTVMQWxHMU1QaldO?=
 =?utf-8?B?SmVDazdqYUhmbis0alRXUzQxeTdDUUdqeVNoaHk4anJneExTL2NjUkJIaXdu?=
 =?utf-8?B?UVVsQk1NenhnWmgrZHExRjUrK1pFejU2QlRlaWZhTk9ab0x5RlBqNFdUdnUx?=
 =?utf-8?B?cm1NMjZ4T2RLak1QWGJ4bGJraHc5U1VZUVpSQ2Y4NlMyTEVVLzg5WXR1U1lR?=
 =?utf-8?B?alZtcFZ3YWl2REJiU0E3SXVUVmMwM0lNZGNKNGFoMWxseURzZ1VEU0U0dUNF?=
 =?utf-8?B?OGZKUUJibEdtNDBuM1NQVTVsZ0tPYzlhOHoyYU5sUjI1bzVpWFVpc2hQMDdR?=
 =?utf-8?B?N2RuSzBoZ2F0RzJGV0pSQ0VEaEt0TnIrTjhiRlpGQ2hwaXZCd0JuUC9BbkU1?=
 =?utf-8?B?U1dFcVFMQkxrVVJQMEJ0Ny93Ty9pRnZBWnVGeUgxbHU2bExTclpZd1RvSWhL?=
 =?utf-8?B?a24wTHdkTmREZzNTOGwyOFhaL2FtUmY5ZDU1TCtEb01yVk1NeEcwdTVVempN?=
 =?utf-8?B?eDZvenVpVVR1cC9sb1Rna3FpZmIyR2lkbEV1azc4WWFBeEVxVGw5UUczMWxt?=
 =?utf-8?B?bjNhR2lUMmFnN0Jabi90dW1tUS9YeXdBVkRMQm5UL0lNSW9iNE9nOWlaS0pL?=
 =?utf-8?B?YkVsQysrYlBkVzkxZTZuYkZhbDZJOVdlemtpS3FDemhpNFhIVFUrbkdja0E3?=
 =?utf-8?B?d0Z2eEhodThlTG9CVGRJZ3I5WDFURGJKbTNvaWVFVk5QQU5KYXN6NFVDUTM2?=
 =?utf-8?B?YjEvY1FqS2FrVGRnOGtkQTNhbUI3VmpvQ0tRUlV2NEZNd2I3QXVSYUhPZWtU?=
 =?utf-8?B?M3llQ2lFZ1VjWUVJTHB1MWY5cCswSUdwYUF3Z0hXWlozbU82Z0w2YlJpZ0hW?=
 =?utf-8?B?bldvcXFiUFByNENWZFdoQ1AwOEJOeWtDaUNpSnE5dm15Ti90elNjNE1qdlF5?=
 =?utf-8?B?ZW9GRGhTZ1RKRnExQ3VlQ0QwSFg4aHo3UFVYYm5NMXVCOHdqTEsvMkxpenJo?=
 =?utf-8?B?MWlwOFZDZHhEdkZhajlGT0dJUzNlUVFkMWUyRjhST1BuUzB6aTBtUXh6NFlj?=
 =?utf-8?B?a3c3OCt2TGM0QUxZa0xYMFBNU1VlT1dIbGRtV0llaGQ0aldoby9hNHBDcVg0?=
 =?utf-8?B?ZzdCQWg5OFJKWnUwSFZuQzhMU1NpOE5odldUZGtiNGVOaXFISkszYWFSZ0pk?=
 =?utf-8?B?OERMZGZXVEdUcnpRWDRXQzhOZVpPd0ZaaVlNdXY2RXdvUUV3Y05lUWVRTEpY?=
 =?utf-8?B?bUxGQ0xNRzd0RVY0SkYrMEtwR2RlUlEzOHc3VDJ0N3RPQXJ5S2V5MVduRElM?=
 =?utf-8?B?ejRlZDUrMnNoVzY1Q3BpY1Z3eUJqeGZSd0VaSXJSYkdKY0Y3SlVSSEtkcmJo?=
 =?utf-8?B?dHNNdFhvU3N2YkZHU3RtV2Y3SUtDWXpxd3R5YXVyZWFKdTY5SXF5QlhSeEZM?=
 =?utf-8?B?Y3BnWnI4R2NlTlFURkZtQ0d3RnJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2BF6929E10F248BE3FBF798D373F7D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+rtyXIw8PhhxatON2vRv7+2S3arYGSjynADIqZxvws8Gm89UFQVjBED9AiwBzJMYKgvcJqJxWUuNpdgvY++cPXA20LsILFmNLPkR632B3Lb7zsh83p0Ai1S1tpw8NrtIPL9SdFUPxg5yDP0xvGHvsdMfD4w1wj1glSDFEcO5+6G4l24n5CoN+NPg3Fye5sKdO8dPRTnYM/wncYT9PXvHD73jBJkAA3GnjNfzlQQjMLl4qkMBKVvXZBCWX0V7Pn1pq0+NCAutg9JXJs54aQpK0YREWqj5V5LGeFmee9xThTr92Ic8Z0wOwsFZK2EtirOZMmIo658qYf7QMcjh6C2Elf5UTpk9nmruFbYxi/NEPHPzYL0oRcBmeoFBFL2G2oQVIx7YpAbafuCvkHEt0WkTSUY4j30Y8mgGc4UjixDxLTrNCX/Rm/7FR7JqcKPHOwqrck4tFLI2ZokIxEC3fWG38t0+ByySF0wlf2JmX73VMiJylqIBzohDOIVN1mgprbKQuBlyvQ71PumxRh25PVmc6QJl0T2HWPc7kbvii8VZ7u2JFIJ0uuLg+IUTMv7tIsFz7oJLtJDq0LcqFqb4lufJyb4uJnfWRRpQhiWRIgOvnRakV658BocqVRwJ9DT1D0R5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1718eefa-d3f5-4d5a-b45f-08dc1cbf3671
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:31:15.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKQNyfF08HV61rNeBUe5mPGuXRN5FPLwZZBGmvkerrlCyOBtH264Te6Asu6MxkGDcof8D3Sbh7CPWrZZxlE4ky5S4GkjhDn9t0yjJPCZ+v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8493

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
