Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F72BD5AF
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443744; cv=fail; b=nfagrhh0qXIDtXeM6oyeHT8aSOvMWfVMZbUias2lvTsB2ggyrgaQEIcOHg0IhpH0EPbj0t2b8NLuutJW/e3nriQqwHK808QuoNxWfaXlzdflbP/pUTg0wf1mrOxyUQRNK+mgR+AsauqOAKSk917AKhwRNNVhUKSLQelQ7o+H3pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443744; c=relaxed/simple;
	bh=7+VX2ljCKl/JjEQ5KgE+aXX4izja/4Q9JJJ4YkCORRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZ+1jGzPL5lc2kYLlD5P4OhGClES8GOfin7EAfj6rRH0CWFIgQnlGtDAJ2GlO6oyVzVlbbdGh1O0gpgsFtakfEjAgasNUfWtDUScrb5+MDoMDYUqtyXqOW7zYVPmcPIKUuskoaCvCD21AcY3WkSk4X0QXDN7xmGaJ0Qk3n6XkIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r7w62lWW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QJ4tInqC; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r7w62lWW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QJ4tInqC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762443740; x=1793979740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7+VX2ljCKl/JjEQ5KgE+aXX4izja/4Q9JJJ4YkCORRc=;
  b=r7w62lWWn2HAgMQRXVRcgUOCt7lOkOmhXJd5BQXlTcriN8qGbAfg/9GM
   gXG9R6Sy9836LacKqaWnYpb0X+qvmyTeBij/RAbXFm5OIjw/fUsJT3ory
   8VGymWAWDZNETZ/yH5MG/A1YfxwUHi3PZE8c/2XCRdR7j29e0LbExw6+Z
   j/vr7oA7jUHsPyIp/6Qvd3kLuDMJlpIHXEo3tvfazbFpNvpxt3SdgVkEk
   Pdl8WKwsVOw6mLV2NkyCUjdChY+s11Q6BPDMe2WxN7dsDvqRSoL7zqJ0b
   BnMlG/hAEqhL2fvQ/qD1+2RX/1HhP0TZnNxpVal90dy8Mg0Cb4LjsKwYe
   Q==;
X-CSE-ConnectionGUID: tDnWE68nQO6quWdSghFuBQ==
X-CSE-MsgGUID: dAdJm/DPTkyaAiMYX0SHwQ==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="134588671"
Received: from mail-eastusazon11011000.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.0])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 23:42:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlcAh8TG/rbISJ3EmUJXXAKkD5s+vFGUEqlpgvH67Sz/H8RIa/9Uly6rcUq59xw95NSS8z4HvYMNDL9Dj0nhFI0/zaCcE3FMJo/1RUglu8vbNSO25lza4e/BuCm1mJ/nhvTM8/ROOMSjGarKXT3bc4MrU6+FWrPG7VIXoZAxkl80GBaAUAZLtW8K5vTAjfRzshTZ0JK9tgocpUN3lE7zaS0tNrvoEiHba8aI4TxX0LTsBbnh5P/kmzhGE7iOdLJgjZxpHhiG6bT6w83cBy5maIF1OJMTNG1K8CgNur6qDCm2PLPkZoa1TtYaNCsFWL5LzvKdtrogbSsGX6TFKqHHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+VX2ljCKl/JjEQ5KgE+aXX4izja/4Q9JJJ4YkCORRc=;
 b=dqxORPhm7gnifs6f8NmzXOfwMPGyARsV9uzahcDLQZ7iaVMeBqi800w34SC2g8oquA41DqRAfHvYyGIznAGjN8Fj2TpYTv/W4b9tW0fNWLx1Za62u4kpcPnd47TKPZGqVA0dkl4vbWJa96u/1yRi9H5aVeAMVWGriQsdWyqsKW9suokRL67rBC0FuRp4XieLYKRV4yeB0qUYdfD7rlFhvenqHxnj7ymwqHh174dibu6QAHuzZvpA5Ww+Afn+nRExYabzYSxlYUuDmn3ODKkMf99aundmbrXpmGoXd4TbJv1jl5Wl+UgP8n/K7LGb2Ucvlj1Ch4CAMFKD5Nrm25KTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+VX2ljCKl/JjEQ5KgE+aXX4izja/4Q9JJJ4YkCORRc=;
 b=QJ4tInqCQQeX7wV19Z/nSTpa6tOQJWycU9LqudhI4XAc3Xhc/9ZUfry5F8rPeu4bBCuj0tawMcino2cnB5/vXQVetDIFHAV/vUAdRShvj7svPj8C4R+Rp3gYX6kfDrfNAPJjV3RBOSGfu/jxSTe6PkAQeA+wh6o+QwHBs8W9z3Y=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL3PR04MB8106.namprd04.prod.outlook.com (2603:10b6:208:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:42:14 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 15:42:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Thread-Topic: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Thread-Index: AQHcTsByGOVbfvXjL0WryNx7ZuqcnLTljKyAgAA4qACAAAUDAA==
Date: Thu, 6 Nov 2025 15:42:14 +0000
Message-ID: <5c39e22d-40e0-4803-90c2-64f82227ed7c@wdc.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-5-kbusch@meta.com> <20251106120131.GD2002@lst.de>
 <aQy9onvbbLaD_6Gx@kbusch-mbp>
In-Reply-To: <aQy9onvbbLaD_6Gx@kbusch-mbp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL3PR04MB8106:EE_
x-ms-office365-filtering-correlation-id: bb17fafe-4a0e-451b-2405-08de1d4b0f0c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXlPVmdjY2pqaHU2V2JOUWxOS0didmI2aUJDSGFvYUU2WmtlTkkxSGJseVBD?=
 =?utf-8?B?RXp6THRlZ0QyQnhqbWNpYThQWU9DUll2aGh3T3hmYkxVQVU3SDFtMHFiWVJB?=
 =?utf-8?B?eWF5ajQxZSthSU1OKzMyb1pMUlBnN3hDWURKM252d2FpaVNCY2UwbmZybzZG?=
 =?utf-8?B?akIwME1hR3ROcW5RZUpWcC9aMGI4aVg5S2U2WU9TNEIrcmFTS2JsVUkrZzF5?=
 =?utf-8?B?blZtR0Q5V2pvZ3VreUFhN0M2cXBobXVWSjhIR1YrdWJxcFY5VSswNk8vZnNi?=
 =?utf-8?B?Y0Fhd3N3ZzBnWFJabUlYNEpjQkpEeWdzSnpML2RKdUkwN1NIeXFpdGppQWx4?=
 =?utf-8?B?YjdnVUxDeSswT0phV2hHejdjYmsxS2J6dEx1WG9FS1hjcXVCcTdCeVNVTTNU?=
 =?utf-8?B?aFhtUjBmdmVhdmwyWGg3dVNWRjlxL2JHVXRWWmVFaWRrZ1NyNDY5ZjVMVm05?=
 =?utf-8?B?M2EwOHNGdnVUMmF5bm90ckw3eUdDZGxRSHUwN3M5bjNUM29GRjVvak5peWk4?=
 =?utf-8?B?MG9SZzlvbDNIMWplQTVEeXRtRlFIbFFyWm0wcEFTd1RzUG03REp1bkpCUjZt?=
 =?utf-8?B?MCtWTjRVbzdSMnJPOGJtRlZJUGk0OWtYNFJVQTR1VldVR3ZNQ2wzc0crRGRE?=
 =?utf-8?B?TU8rOC9yNDBKL09oK2FWRXZQMkNSRk1UYmdUM0dZRVk1NE9id05uS3pNeDNm?=
 =?utf-8?B?b3lyTjdaRTE3WHZKc3dVQ1N5OE9oYmNkVjdvMWluVFpQT3FKdHhORXI5OHVD?=
 =?utf-8?B?b0ZFdzVvTnNXd1M4OFFyN2RXMHVNNTVFODM1clNjdlFoc05IZXFqZEhtRmlC?=
 =?utf-8?B?T1c0VFdCeXlLaTdhRUJ3MStkVE45Y3AydHo4TURiV2dOOTJJMVo1ZXZjNHdW?=
 =?utf-8?B?dEZIL2x3QXcyU1hJU2VnOWNMUGpZZURVaFFYQkk5cHB2cUpzSWRCMU1XbktH?=
 =?utf-8?B?bFp4RGl6Z2t0ZVN3VzBNRHU5VHZtM1pYWVd4dXRGUDUzRGlteVpCS0VycWNK?=
 =?utf-8?B?ZzV0TGYxbVR1VFM1aktDV0h1N2M2ekFJQ2d6QUh4R1hSRlVBbDBZRW5GSWJH?=
 =?utf-8?B?RXQ2S0ltWW1KN3lLWHFSSUxKaVJhMUpWbm1MSU5scFZYYmJ1NVhKZ1pqZnJm?=
 =?utf-8?B?Qm0rdEhJc1J3YjdrOEVNVFMwZS96d2tJZTFic1hUUEYyTXJ4Q1dPT0hJRk91?=
 =?utf-8?B?dDFZNEQ0dnljM1dJbVBHeWxUTlBBTnJoVzlPUUQ4YlNSclZObzNNL1JoUTRM?=
 =?utf-8?B?cHQwbkxUcE1tVkl4dW9SeXFVNnpXR3doRy8yQmpPVnZnQXhBbng2U3BBaWNu?=
 =?utf-8?B?UnN0a3E3RnBDdEVqVGNYZTY3K1oxbUIySU1vbFBKRnhQTlFQR3JpYkxTUDNE?=
 =?utf-8?B?bVYycVhoZVhtWjA4Rm55L0NNRU93aEdFRVVyRUlBclV5eTYrYnRVVVhBZ0Fz?=
 =?utf-8?B?bmhVTTBNMDlWZXFidWZzU0ZaQ3N4RDNSSlZKMjNJYm03R3JMM0QxTlNtVzZU?=
 =?utf-8?B?VUZ2SHVQL3FaaU5aOVlMQWRzSDk4Z1ZiNDlOb3VkSXk0S0Flak82NCt5em5R?=
 =?utf-8?B?ZWl6M2wvSzQ2djlwQ2I5RmZZTVBmQzA5RWtHY0w2VnRXOWxaRGY4YUNjSXRC?=
 =?utf-8?B?eVBBVzBwN1BpWEtiSG9UZEVlRVVDSlBiNFd5UXo4RCtWZDRjNXJUL0g2WUpw?=
 =?utf-8?B?a2hFMWF4SG9DZHBiZEsxL1c1ZHVUaWljSG4wZzZqQnd2UTBQZ29NYWxpenQ1?=
 =?utf-8?B?TmtIUmJoOGMvRE94VWZXTXpLUVlTZXpWT2RvVmNKRklNY1RnbVpMdWF2RzR6?=
 =?utf-8?B?VUZwRDVUdWpjN0tMSTYzRXQ0KzVHaWpYZ3hORkw1bFFMN3o5c25VY1A2d2tE?=
 =?utf-8?B?MDA0d3ExKzcyWFRyY3VqMTBURG42WElHRXlYYnhWV0hjZGhITlMzTVZsdURp?=
 =?utf-8?B?WU1yaUpPb0RqTjZ3Qm9GUlFDZEVWczc3KzdwVlQ0LzQ4MHJpdVBLQ01YVWVv?=
 =?utf-8?B?cW1PbE45NzVLcFlmcEllRyt0d1NiZWIzcUc3N1NSZzdEbEFxcmlzSjhSSzNr?=
 =?utf-8?Q?/SFNn7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnkzQ3ZSYnREeVdSbllVK1ZxV2dNMktPcXZycDI4dDdVVVEzNHFibjNHTmlu?=
 =?utf-8?B?d3ZTMVMvbXQrL1hzMjlQZkVNc3dIa1F4OHZsTTE2RTByVzFKU2JTcmZ5N3Zt?=
 =?utf-8?B?MGs5VkdwblZndXFDbDkxMit5MFFuTkkxZDJoa3NDZGxrRnovcWhLOVFZMGxo?=
 =?utf-8?B?cmovcTNCQUhBLzZrKzdxK21aaldscXBSWXNWS2pweHd6SE9XYW13Z0t3LytI?=
 =?utf-8?B?M0lUNVRuN1JndzYwRVVNdTFYOUpoa2Z1SG9YNzBOeEZTTFMxYVZ2c01kTm1T?=
 =?utf-8?B?dzE4YWg4MFh2N3dKVTdiR3dyaXRaMGd2azdGYjB4SUFTcmFJeW1MQVNiY2dw?=
 =?utf-8?B?TE4wTnFVNGlzV3N0WSt5NUt3L21sTDdqS3FVTkdMQ0k3dVNaaWIzbVZ5MjJo?=
 =?utf-8?B?aFNBK2tzMC9INVdPK3FlaEZqQVNoeW1QR1lZbElabmhvM21uTG1GN3lrTXp6?=
 =?utf-8?B?ZXdWTEd6ZDdYYm5nKzVvdDU4TWRUU0hZdmNrMHJzS3o1RG1ISGREQVBLcHJX?=
 =?utf-8?B?STZ0Y1dnVWhIWGVwQUdBdEZiWDErZDNpTDZTWCsvS05FbkU4SUlJcmJPaWF1?=
 =?utf-8?B?ZitMNnFjUC9xT2pOcUI1c1FkZDJEdHYyclFCRmpwRGdYa0VNMkRLQXlubEFu?=
 =?utf-8?B?ODVhSzljOFJZVWNsakFGUDN2c0hsZ3dhYmc4enBoaXFxcHpNNmxKR1ZqMnlv?=
 =?utf-8?B?eCtSTkVSSFEzdFNnRGY2MmxzbWs1QmdzQlVJTnBpanZyWmxPalp6ck92enlq?=
 =?utf-8?B?VnpXcG1ZMmZERUl3enFpOEZ5eXlxeVNsVjNMazYzcmhVYm5yeWNZekZWam03?=
 =?utf-8?B?bWdvUmd2VUN1aTg0YXFPbkVyTkhmK3ZXa3l3a0x4VEh2UTdSdmNYMXBFWHht?=
 =?utf-8?B?L1BINEFBOHRSSzJKMWZXUTl2VVAxSnlqV1lzMFlyOWVvVjE2U2k5S2o4V0ZJ?=
 =?utf-8?B?N3diUnZsdUszVUxJbXlSVEM1WHdLcitMYzhMRFFHM0R1eTlVZ24wZDV2eW9w?=
 =?utf-8?B?OVhzYjJ4NE9URzdlL3NCVDI5YWNhSnVoT1htZ05EaGxyTWxZdHdhY0xWdEh6?=
 =?utf-8?B?Ylovd2c2VThnL2MwVzhjTXFmVG1qV01mZmhLbkd3UDk3T1N3c0FKRWxTNU92?=
 =?utf-8?B?Wmt4djJpSWwzN01tL3k3TDZycDlWTmNLVnBpcmZWVjRTeGNRL3lVODZFeSsr?=
 =?utf-8?B?ZzB0NmREdW53QWdBVW1tS1I2eXZobzVKSEVsellpc0NTdS95SGxWMEpKcDBW?=
 =?utf-8?B?VzFJVStjOHhNbnRtOGRhU3pTQUNPSGFha3lrWlZFU1BhdmsvNCtyWG82OUd4?=
 =?utf-8?B?R1VVY0w3T1FTbWtkYmhydGMyekxMa1VueVh0V3pmQ2I2cGxCRjBvTHFWZThH?=
 =?utf-8?B?dXppYWlFWUtlTno1M2NmS2ovNllJN2VnanhuQUordS9tSHlYeDRBL2h5K1FJ?=
 =?utf-8?B?NWcwcGNXbUhBOXhkc25xVmloVURKWUVOaDQrNWlGQXZqQjJpOXlJTHRPSU53?=
 =?utf-8?B?WVQ3eXdhNksxdk1CdEtoUm5pcEpjSDcrb0pxSS9HcGc5Mkw1b0d4ZnVxTU1E?=
 =?utf-8?B?L05TUzhqdzVvN2d1b1pFTjJTWHFYQ04xd1EvK3BTSE5rczFaMnZiZ3NlSnI1?=
 =?utf-8?B?SGl3NzZ1dnZka05NOEdiNmVlN0RLSllRVFZyQUFBTkMwMmhxemJwM1piWjVv?=
 =?utf-8?B?OEhpaDBpbnBFejR6Z21IWVQyNURQMmVObzZGbUtUd1NsOVpicGUwWnFZYVhz?=
 =?utf-8?B?LzdLUXpHeDJBVExWNmVOYzJWNVFEbVZMR2VQaTBOdXpYYnJsc1o5UzhJUGFL?=
 =?utf-8?B?Rm9IMitMSE1kSnRxQ1JyQkw4OVp5eGtjYmpZN0NrSHNIY2FUSUNUU2ZZY3pm?=
 =?utf-8?B?VzJJV2JYU2UzSzlZdlJScTFmWjl4OFhTR25Fb0tZNzFPTzdJbUtkWjJXTEs5?=
 =?utf-8?B?bnZGYm5ZQkRIc1VsT2pINUhGVkdzaWhZQm1xMG91RzlETGI0UUNvaVMxWTM0?=
 =?utf-8?B?NWlUUlhaTEY4M1dvVklCWXlGOWFZUVVEdzRTb0ZBMTJISUozelFlVWNhdFFL?=
 =?utf-8?B?NHlRTHRkQWFmY1FEWDlmTElBbkJRcHV6SWlmUDgwc3kxc2NrRzNValowV25o?=
 =?utf-8?B?eUJIQk4zQWNPNEx4MUpPWUZCMW1ldHNqZ3dkczcrSTNGRHZLUFhZYUY5dmtD?=
 =?utf-8?Q?2sbobdK2csa6y0Fmy9BfPM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EAE26A759CC7243BFB66D1F4A3DF9E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YICRFV/BtfQf4BmhEn5pP13cLgd2rezQaGAVmPjBYMlK9YI4MLI3I0wIg4sAkvKI87mbn051oB0ARlm81MTkEy0Qz+1h2jjrrQZPr0h0sIRmfah32nOulscuMc1EmYKVSaSbVAydE5vaU+rDUfhB1O+ckQNvZetVyIJKxTH4u6QjaOG5/nphJJdUOc7sPyuJWOjG2Sw06ksGLr4G1Bvz2Wn0DAlt2rMhuiOVQIJj3VKmoYcg1WJgUlKbS5Y1GiDr3SG3IWmJ9OnRUp4IbPhz0eZZww/elmskngn6JiaL8zOJGE/fGg8IVHbKUtG7yMjGEa0aJAgk3ad0dmi+z3ZRWao0cBQy7yR/wsfVxpouXC4J2HYPmV4WOVnkRDRRE/JCGAsbrICQuDvVMxFx7lw2WhC+WRJA1/0HtNLLzAUycXOFvk/yCmERT71Cmr7jKSOQ5zO4tPHhERA4uWCFdrB3Av2A611lNn2/O95htEVP6BYp7ZPn/Af6zrV9FNSs8VBZW64wgfto8TbUm7RiEamXi3TpcZGPeMmi/ElSh5+JwfetThJkp6QgLOrbVMjx5u1aH3AUN8xSWHXFoA6kdOzM9yXBmBHSSdiL2W2YpxgRM5hEGQsnuvAxzEUerJy6fFkN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb17fafe-4a0e-451b-2405-08de1d4b0f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 15:42:14.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7XuP+Ri53uYr/7CDfmIa+YPoMK99Io0r2zRbDaGer2cRU8AezDEuhmZWBzRDAWBLxJG9bx4pfqU1plqYGV7mYoyY65BFxs+tynNX29ubwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8106

T24gMTEvNi8yNSA0OjI1IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gQW55d2F5LCBpdCBzdGFy
dGVkIHRvIGxvb2sgbGlrZSBhbGwgdGhvc2UgbGl0dGxlIGNsZWFudXBzIHdlcmUNCj4gZGlzdHJh
Y3RpbmcgZnJvbSB0aGUgZmVhdHVyZSwgYnV0IEkgY2FuIHJlZG8gdGhlIHNlcmllcyB3aXRoIG1v
cmUgcHJlcA0KPiBwYXRjaGVzIHRvIHRpZHkgdGhpbmdzIHVwLg0KDQpPciBqdXN0IG1lcmdlIHRo
aXMgc2VyaWVzIGFzIG9mIG5vdyBhbmQgZG8gdGhlIGNsZWFudXAgb24gdG9wPyBJIG1lYW4sIA0K
aXQncyBhIHNtYWxsIGZlYXR1cmUgYW5kIGhhcyBubyBuZWdhdGl2ZSByZXZpZXcgY29tbWVudHMu
DQoNCg==
