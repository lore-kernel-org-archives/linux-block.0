Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EF172764
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966505; cv=fail; b=fSHmZ0bDUVZq9l2lTcUVKdmYkzfZFG4oDCeBVNt6tE6CQRJSoOnnGY67uN03J9M0/JGh7q+gmZ8KPgsGE1PnrLHoJbt3DzuBl4SuhEG5idSP93wF+aASWIQwx9rig+F42eg50w0tirvHNjepzeMQpsey73XAMwiv+m/PBJ0Gofk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966505; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozVvye1tuwdhfAMwITmETIDGAgVnaAUza+DFRsJIildNy56BOJ3sk5CGhrUwzC/qGvksRTm51Xks5K5gylh2WBYJ3PWGTW8v0AYAHAZFCjj30R29EpkGvV96R+HFeU45cHwcY/xcctIEAp5Vw3iToPPJBDd5QgSsUcEPxbzW6bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pS0HlNul; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0L9WokLv; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pS0HlNul";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0L9WokLv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718966502; x=1750502502;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pS0HlNul6y4YwvAf89QEFWm/LG+hXGvwl7UiQyuL/iUMnk9Dp3M/sg5Y
   JJ4SO35eN+72doqPFH8VI3TJr9TyG3VoVqS8H/piAlO1t8THF6beqfzxt
   JDlP5eoYag4T+dSzLcu4kbG1udiBK3gEsW0U7R15elUWs5nmJUfmcuMLC
   lrhlqRLVC7CocoRo7rYV3D5E8TtCw0KNxecOK3BHghn29Mp0AwviPQMEb
   BekiufnuLTv09/pEKnlm8a/KrEbK9OYDLWGtdb3Q/zL85BtZ3xs5TxyWb
   13IuMbG8EUAYUXQSBcH/pLDwEhhZRsfg4T9S49CjQAGL1ch+6JueFsbLc
   w==;
X-CSE-ConnectionGUID: 5uX/CEimTEOSLrjILmij4Q==
X-CSE-MsgGUID: WoXsjmj7RKql/+0tFWJE6g==
X-IronPort-AV: E=Sophos;i="6.08,254,1712592000"; 
   d="scan'208";a="20479808"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2024 18:41:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiAcqE4GhMQzuvvbaiDo3t9hGKJHApN5nVC86Mogrg5rOvWeCQxqVLI5CFbCJ10aepi2mm03mjdttWw7Bgvbg7PoL0HneSuWeFQmz7PN13BK52bV9vHxVhGBoS1Zoaym4JgPJbGIL1rsxXHPanhkZYglFKVUC5hilO2T09vdhu67Ad7FpXtBFfWDfiKTa3rFi91MK3pRYSSE2waIDC/lZqBt/ZE7pnbNK2Uevn8qjuBmIW9A4ovZeXZcch3FAUuKWTo7Dy8crZMZNBPM5QXsntP4jeP3ntHWEf7oUV1dL0prX6Y4KtjR1IyFyCD4gOxUFM1Y7xw2UpWw5p9/DQuYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FuU6UbnuMXKdB32eYzataGPEFuKlAOlm66/F1sREzzB1ci/VAUu0nemm8G4/li7fXIdcUCtMwH1GEk6HqRuzzJJJj87G/TEExaz5GsD/KSL/GYtqZCA1pMFF+HxHxmH4SbQS3KqQCX5MDqtjllmcKMYUjjQVtagGpC0JVBgSBtr40KRAcG2Z4NJTyHyvXGkB75wjzLWGOduTcu/9Z52VH2+4Mgnkf/ly+7iHCg/fPScoty6uMA+qfd2H+npkIXi75VZG10IKrbXzdsfl5WzQpSHnGQ4EQoZver9a7JznA661cWQBtjjVDHUzh4M25grtvVFD8TWUVNPfe7DsNaBk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=0L9WokLvKW30Kb+45UkN3FQf6VizB5tJKIaoOIQcvUzToInYd3466IzCv3zWIi2g3Fi+a6XEeVPruYms1Swh3mdL6OGELEB8m/HV3MPtANd/SzYZ97gw5H1s8zFyHP0wSOwlAabUrtKpFHJkVargmcEGznAsa6E7/RgY3qUGDXE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7689.namprd04.prod.outlook.com (2603:10b6:806:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:41:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 10:41:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] null_blk: Do not set disk->nr_zones
Thread-Topic: [PATCH 1/3] null_blk: Do not set disk->nr_zones
Thread-Index: AQHaw4lFc3Hv81fLBk2g0u4W6CX8SbHSCBeA
Date: Fri, 21 Jun 2024 10:41:34 +0000
Message-ID: <6e196ae0-07d1-4a05-a2ae-cef8e5d07cec@wdc.com>
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-2-dlemoal@kernel.org>
In-Reply-To: <20240621031506.759397-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7689:EE_
x-ms-office365-filtering-correlation-id: f8d469b0-dcd6-4f3a-746f-08dc91deb858
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVVIdWFLaEpONU9ubDNWSENiQTNVMCtQeENra282TVpHc1E2bVViSlhYQ3B0?=
 =?utf-8?B?ekNiV2NZWXFzQkFzMDkxaXdOZjlvUjU0MEo3eXhvRG5ycTBRaTUrU2NRbEt0?=
 =?utf-8?B?bElwRlJGN25mRFQ3S2lnaWlCdW9QNnAyNUxjRGdwT01SckpvN0dBZnZBcml4?=
 =?utf-8?B?c2srR0MxWUVVN2w3Z2IySk1KN28zTlpBVy9Xd25qTUZsMFcvTXNZOGVIRUNW?=
 =?utf-8?B?OHB1SmNYQnd5WGZ5S1cwTE9ucW1qNTl3WC9MWUMrQ2pTS0sxbW1NbnFBMld5?=
 =?utf-8?B?UzJ4ekdhdUlkMzd2REphLzRIQjU0TFM1dzB4dFRpQ2loUGhjZTd3ZXhOVE5r?=
 =?utf-8?B?OFhtZzFHYjdMRm16eFZRU2l3VHZLallEMytnZCt6ZFNGZUFjeDJOVXA5WlM4?=
 =?utf-8?B?eUVCaENzaFhTU0hiL0l4Y1JNNXpldXczK0xkK2tVS29iaUJPZTRFUk9tbkFC?=
 =?utf-8?B?VzBqYW9FWXBQR0FPWGpVbFpJRnFOb09PRXlyYnZKdzJzVUxtVTE2dTM5RGdy?=
 =?utf-8?B?L2g0WnNFY3gzZjd4eFphVDF6cHFPVVRDNGFTYWVqcEFXODVlRGFUdzR0c05n?=
 =?utf-8?B?ZzRWQW80WjNqNkxIdkhZMmZ0ZnVKYll2ZzhIaDFoVEpKWGVybWFDNVdhOWFi?=
 =?utf-8?B?WFdFSktJRy93L1pBMmpWUCswcTBaN3NRMXB0M3dGRnlzQlJuSTI0YmtPbnh2?=
 =?utf-8?B?L0Q5aEhCaTFiVm5sSmxPL2UvWHo5QVlOMWJheFdJdCtRTzMrSlNSbnB2Y2pv?=
 =?utf-8?B?TEs3UmZOZGgwMmkrbGhvcFVPZWdEWXc4eDZidk9nY2ZCV1lxRDNWU3B0WlFs?=
 =?utf-8?B?c0ExamVzc2o5TFV5cU1OeDRRUTZXU0pXOHFPN2ZNOVBqYmp6RzhpU080aVZa?=
 =?utf-8?B?WmJZUmRESmtINkVrL3phMkdWN3N1RTFVVnBvRlpHTG1iWjZkL0hEaWlFdmZX?=
 =?utf-8?B?QUtmZFF1djc1TGN2aEt4NFA2YzBsVTR1dGJ3WTBhR0FrdVlDc1M5OEVLSHBm?=
 =?utf-8?B?MzZJdGdTcVN2SEROcFgvaWh3V1ZoMFA2TVpQUDB4VnpTbEU3R1FhaWNELzVl?=
 =?utf-8?B?VTNuR284SVlhem9NUEtmUmRlSXR6TjZUelNaWVdOSWdZaEZlNzYzWjhoVnlo?=
 =?utf-8?B?YnhHWlR6Nm9CMGVPQU8vM0FET2Z5M1ZtUHd4cjRZMUlHdnJLb1N5bUpCWXls?=
 =?utf-8?B?RFA3ZlEwOUFnRTlQR1d1ZVdhUTNMZDNNZHdxbDZlVWFlNFJMWno3NTJiZHow?=
 =?utf-8?B?Q09tWEpmbjk0N3pLZGdEaVZnRGgvU1BmN2VrOWJ5V3lpRkZ4OWZVdEZOS20x?=
 =?utf-8?B?U1RyTEsrY1d4YkdGRFVLTFNxQjlXRVRXbzlSZW1mMUtwOUpIdEcyNEFiRW5S?=
 =?utf-8?B?NHA5TFFmT3lEeDhvYWs1RlNuLzRlNzgzenRJQS91U0xmRHRibjBkMW1oaTRw?=
 =?utf-8?B?a0EwcWVJMEFGK3dQbW9aZVZxQWNpNjZLeGt2TTRjTld3VUgwYXlKaFpsVGs5?=
 =?utf-8?B?ZVZmRno4NHpZSjJvYW1UdXJUVEtncDd4YlkzOU51UDFWQ21YZnRWNlE1MEZO?=
 =?utf-8?B?WkNxWjVEY1lUaDVWZ1ZZU3VKbmhnWHBFL1lubFBQU2lLZlRJajJCYUhFc3li?=
 =?utf-8?B?TExjWHcweVJqMEx0cENVOFFhOVdBNXdyQVhaNU11ZnhxWExYM1JNcGtJVlJ2?=
 =?utf-8?B?dHVITVFsYW56dlZ6NlZBT21Ld2dUTHlKTHVsTDRmN0gxck14d0FlLy9ydjE5?=
 =?utf-8?B?SDBYVE54bGNzYzBuL0lDV0dmaFZHQVY4Y2gwY2RDTDFIcUpXa20xUDdvcjl1?=
 =?utf-8?Q?HkA+Vlu80GYTMgtaPphmax0/iMSz5lY2/pxfg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXdIMWFHWW9QUVFLY2RFQnFncEkwemtYdFRVSFlXZWFJRFc4ZVAyUENkS2FH?=
 =?utf-8?B?RTVIekg1UGs3c25aTHpqZWQ4LzI1OW1jSDN3SHdCbjJZU3ppOUtGV2VscmFw?=
 =?utf-8?B?M1dXaXZ3ZXdja0VIUlBDakNMVGQydnRlUURKVmlYSGFSMTg3R2laUzNWWlNo?=
 =?utf-8?B?UjlZN0I3cHh5UnVBQ1BHUDRUK2ZFWVptaC9pemJQbmI0T2xwMVFNdmJpcnNz?=
 =?utf-8?B?allYd3NsNkhZT3lqdUlhWWR1bzVnNVdySDlLQlpSKzNwZlp5ekJVUzVHTlAv?=
 =?utf-8?B?dnlrOGZqOW1iMnVFT0w5V2sxTG5SS2xJUkRVM09uRjN0b055cGZjSWRGRElM?=
 =?utf-8?B?M21kTk91VHNXRGsvb0lhVHpUOXZHSEkzeXovL2d0a3VBMC9QNktSb3l1RVZ6?=
 =?utf-8?B?R2hJWVgyT21iYVdWZ05VU2luWGlwVVJrWHh2dGh6S0cxSVcxU3lvNHB2Ny8y?=
 =?utf-8?B?S3A3UWhqd3dpRGNoa0s3allSbThDTjAwNVY1cGVZWGx6eVFxMzNKMjVwcVR4?=
 =?utf-8?B?cmlmVTl6SEhiMloxZm92cUJPZFZNa0tnWnY3YXYrNDZYMlhwOS9ocG81Qksz?=
 =?utf-8?B?L29oRk5LUkk3TVZmVU9YYkNkdVUwZGlLbmNZWERLd1czbEhQNVE2MUZxWTgr?=
 =?utf-8?B?dDZ3clIrWkFibWQzWUVlM3RqaW5PcVRXYUlQdHp0N2VYbExHVy8rTjBqWlpm?=
 =?utf-8?B?c2N2dU9tUkVkVmN5TjZsbXFXamhSOU02eE9kMVN5T1FtaUpMU2NtQU51c0lB?=
 =?utf-8?B?S3BtYmM3V3BYalUzTGl5ck90MXQ5TC9hdVVUeGJBanVsazcvWkRxMzJWQzBa?=
 =?utf-8?B?RC83ZXNzZk44NzEzaXlMT2h1dTJzQU9RODk0VmovSm1xZTJzMlI3WFpObmF6?=
 =?utf-8?B?alhyY0E3eU1zNkdGVy9TTVRqdWNLR2Urc0FkRHFkZE5CY3lON1hmUVFybWJM?=
 =?utf-8?B?cUF6OGJnTlJpa0c5N0xRallYajFlUURxMS9KYkI4OGExQlVvTzhseVVpZHFH?=
 =?utf-8?B?Nm1vakswYmFPakxkVVFYbFd2K21tQlZ5ZUViV1dHT0lJaHpMZHQ2RHREYmt3?=
 =?utf-8?B?U3RJa3Q3K29pUlhqaXc0Nkp0bTNHOXBCMUpPYmIyTzlnUzAyM24yTnZ6RnRR?=
 =?utf-8?B?OFc5VlFocjRwVVJscVlZRjMrMmdLWHRaTEN2K2JJM0NLZzU5anJUN1BQakxX?=
 =?utf-8?B?YU9GR0ZvYnE4MmoyMWJnMHMvSERDSytNVDVHV1FGODVPT253TzZ3Mk5tbk5F?=
 =?utf-8?B?M3hDWFlIZ1hBUXgzTkJ3clZTa0VlK1FDQitXVTFXS3hyU3JHNC9NNTZSdEU4?=
 =?utf-8?B?V1JYajJoOTlHWHlSdjZVOUF0VG53RHIzem54eVROSEs2Q0dTZXVEa0szK0ZE?=
 =?utf-8?B?bjJtU0dKUXZ5S1NLZ3gzRENkVmFlTDdYUm9rYVdFRDBvenJaS0FxcDRvNzBa?=
 =?utf-8?B?cGx0WmxzekFKTDByQUxuNjZKa0llOUlZSEh4bjhTdEg2YStpbFVtT3VUK3cz?=
 =?utf-8?B?eVllNEpzRmp1SGNxZGMzMis1NUZTU050dVYxbyt6STlPSTdsRXNIMElFRzdk?=
 =?utf-8?B?Rk15L3NhbDNScHRjeHd6dWNrN2pHNWdpYmVFRklBQWJqcy9IbEpQdWJwbnFp?=
 =?utf-8?B?NnBoV3Nhak9sL01PYzNuUXFaSERjVUpiRnJsWjl0N2VaRStWb2VjVVNxLzJT?=
 =?utf-8?B?ZXUrbnFmTlZ4QXZZTERaVUxhZHQwOXMzRFNRR2ljdTdqeDZVM1FVSjAyTlFE?=
 =?utf-8?B?cFdDaHFBRnBJKys1N05ZQlAyN2VqUHVOWUdKdmV1MkthZlZFdFEweFU4bEJ0?=
 =?utf-8?B?VEFNQlRQaGFnTFV6MjJlOEI4Zk9CTUVyTVVDMlhUOWVwdjAweWRyZW5sLzRJ?=
 =?utf-8?B?b1M3RStRb1Zzc0g1QTExckoxQU5sVVRxdjUzK1U2NUxwVHZwSW94U210LzJ3?=
 =?utf-8?B?U09LWVp0NERocTV3OHF5ZkZzZ1M5R1dKTVBsT0NGcmZUOEhjK2lyaG1raURD?=
 =?utf-8?B?MGNHVmNFdjFRcDYwc0lhRGR4cThLZFpnTDQ1d3dkcThYa0NPREhpTHNrdkc4?=
 =?utf-8?B?ZzlhZlJ2UzNLM3I3QWhuVTZrcHVSNUFVMENoVDZYZlphTENHZlhDUk1FV3k5?=
 =?utf-8?B?V2pXVGV6dklpOGl1Q1k5YXl1b1lrK3V1bTVoQ01RaWFDKy84d1VYdno4UU1O?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ED009CE2F37054CAF328E28BF3692EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6lzAjPQ6oXOeqDmP0VTIyZrahZhC+Jf591wycFId4qaKMZsJqOeGlWzJOF/0HNpN2syES480Q0BJY5JnB/tms6gJ4MF41ajlYxObu0xreazJstFLoIcHpJwuYNMgG7AT6bX5azs/JsKMfMgfeDioINAPksiaxz8JW5+Mxk/Wl/9e4SZoCFe06i9mEU0pmTg8uRFQfzQ+T8N6gquq0o8cKX8t79O0x/J41MeKeVqgTYvP6sq8BrLyDXMIwoS51P6owiNp7a8HpTPZ+9ngrMwaOChze/78W7eJbdZQesZ00dA76FTDvo5onoQqJes0hW1jQdXa/nC1MPNmsOM66tpuDmfAXvDzoHkpBQM0nYxAi1D3CZqUDuqzfTQRNALQ1ViJVeEmUry5OAFFnQbQYb+haUpM2+yPtUXAa/AGVtky8GzQeZI8EPcMpLJXvsaV+bWFMsa5G8aiF9Qri5V07vlV3cR7UTGQlYbhYzYis0Rmrjdb4AyckAnJpsShJJctP1UL6Z6SminZD+DUSqYlrj/kP9+REoXA1LIBCPdtW8lK3d+1YXP0Z/Q06DISwD319veb9Wds+ET0trbohlAuk5YcLBY5/C6Y/2UEPwFuAW4Vk8gly2NTqZDc3GeIcH7XPxAk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d469b0-dcd6-4f3a-746f-08dc91deb858
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 10:41:34.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mC/AvIal+PIq/QkWMLADsV0Fbxscw5L56M27Z0kaN/U4JO2bzhVnxLWF8LNTrn08VowW+5aPY1JYvJBAVtNCbsMFUOIhY/2dtXUS1FCQNAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7689

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
