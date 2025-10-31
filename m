Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB48246BD7
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904997; cv=fail; b=MvfEvkUg57XuiDs/3ieqdPX2N/OVz9c7R5LLatNoKZeB48lgmwSxWDyVlRgA7Wp4ZfLEE0Twd0BeYxtd2q0gRiGzTNIWqe7MAyVm602o8zI2eVRq5jcQ0AhZwgsqlvoWXZIZ8yLo0KqZahgFw3p17Y7rJPogC5WNgOSdKdGmrME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904997; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OH9/n5pP6yswn/8iXKimE112b5n6h+iQ+LSbbgR8A+rDkuU5UWpg/EHsnm6X0c7ckyXvEZVQwjs+I09rwEa7P40xKnaDK6Xc83HN6MnzK2ZxJCJ2wM0eIpaRo38bW1WEAW9GgN5q8qhPQhp65rm8XTkqE7MNt6F/sqny7+Wjixk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YjQRe6vX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xL2rsR3w; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YjQRe6vX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xL2rsR3w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761904995; x=1793440995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=YjQRe6vX2UDgRikAclD1qs5GskirVZb9XeWjnhSo9yaY07Dzb876R6VG
   7uR3B2JcF0qt11IVIauCLBVzlcgVTRiWw+hnPuuAhpJRXTVfRTqW87Ivk
   nymia9mGRY8N64Hu3q2LZLYynFuqOHN5zLahNnYKbFv6A09e+vSYb642Q
   AeQgutvZ6/3fDjxhPrCRW0NL5Ukt5XRPxpQknmlwcChROH63B6cJiVlJC
   qsT568Jfo7t/4l7NCpx3ixbuGsJ/2Hww2HEd0lGb4y2yH/lWIbRF/FjSL
   oVrCkxI3WO5r0zhdfKal9Axvf7iFRWVT3xofAwuTibHHqciEiH6ForH/D
   Q==;
X-CSE-ConnectionGUID: 7+YtcOaYSyaNtb1PyRdNNA==
X-CSE-MsgGUID: TU2pmr+fTXa3Q+XB7aPGSA==
X-IronPort-AV: E=Sophos;i="6.19,269,1754928000"; 
   d="scan'208";a="131252266"
Received: from mail-eastusazon11011043.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.43])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 18:03:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdekTXTQi/zDiud42R9BxWevpT9567agtsPHiJJOThRhaZDUDP2kkGpCnZ53WbiDSJbJMKh04fVE209W+XqFsSi4HT/rZCxiD0Al7hAfAU9NsErWv2FMGOZHdgNeoNn8O9kgfXMQNDst7CWr3uh0nhr+2QskQOx59VQn93Swnma3Hia+fUNQQgzO+w68KfVOzE/RCfk8/nqr/k+i/hxavDiRviPK0NNNqZnh8LU632rWJ7fwatf4KJ4x5DzXkweE8u4wzO403pMSrRdIUJUml+xNgZqRRv3Go2qe1SJLYKRFget24z0bv0topnoIDavZ4OKGM2pOr/2gPAv9h9ApxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=ATEXX85UpNHABIf6dKbSuBnqB9g3PgpYfoNCIJ0B1yCiiNFnv6xHoMh66AX14rG3ixsBOVIeDuu42YjNybLDvZWtml+Nu+3PiFcp2VRgUY6h1Tsb0/+B8Vl9EFJKhaIwiCQdPILZnR0gD9bYAh0j36MX4LewL2KrsI/t5/cNKBxCyZZyVl+QCCBbF6aONcl86ufZx3uUJbbMGhMRH59QAG1Mlbc/vabL88iLD7UInn0mlvTRNaNhfvM5CSc3jNXBpAT5/5/dco+a1ODsuQQc265mb588QfdUC/I4pTmO/9kFdU0IXzuvRURrd2v78JiKVWYhHW+JoSU0fBrVWXxEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=xL2rsR3wsXuNVl+Qp9VqWFu/G4afLu4UfEUpEyOYTA5yV9BGUtfJLTJlqJwG6j3b8xUDnCkjJ4gR5PbJZdj4YWrm0O7hDuV+5ss52oTv3Tw4cykfmxTL1CVcT2cOGsrDSVdpiTgES1llHHIu3zxdUtDIFOkI1HV7mK26MzD2O8M=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA6PR04MB9639.namprd04.prod.outlook.com (2603:10b6:806:430::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Fri, 31 Oct
 2025 10:03:10 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 10:03:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Hans Holmberg <Hans.Holmberg@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, hch
	<hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andreas
 Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] null_blk: set dma alignment to logical block size
Thread-Topic: [PATCH v4] null_blk: set dma alignment to logical block size
Thread-Index: AQHcSkuHULVTWk/D/0i3m+EC1cmFGbTcBoeA
Date: Fri, 31 Oct 2025 10:03:09 +0000
Message-ID: <ee7c8368-12f9-4869-87ff-78fb4f1bd02e@wdc.com>
References: <20251031094826.135296-1-hans.holmberg@wdc.com>
In-Reply-To: <20251031094826.135296-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA6PR04MB9639:EE_
x-ms-office365-filtering-correlation-id: 9da3dfb9-7d98-4a23-6360-08de1864b240
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVJZSHgzOEhXK1BzS0l5TzBXZnQzZkdTanVrVklSL2llb0twaWxtU3hRbTZF?=
 =?utf-8?B?N3ZlNEwzRlU2NUZhdXhQd0QrVXZ6NFBJMGZydVBNRGZWRjc5Q2JHZkRSUE4x?=
 =?utf-8?B?S1ZCV3YyeGkvaXV5aFluSnhZbEpSSkZiT2ZmMU92NDVFdVhsN2g0UVowUFpH?=
 =?utf-8?B?MDE5WkxCSWtVNzgwaHZRQUdLVGlPMWRaYWhBdFU5cHlSRElGV3NLZ2FiM3ZL?=
 =?utf-8?B?ZmxJT25wN2hkMTVEL0c2U3Zid2g0a1RadHhhTE1WYlNVUmUwZk1SN2dWdDMx?=
 =?utf-8?B?NEdlZjZIZXQ1VnA5OWF6YTZHUVdYUHg1MjRndGduSXViZHhOVHhrOTErSVE5?=
 =?utf-8?B?SVFCQVRnaGF5N2E0RkhrOWw5N29rd0hGK0djQUtoZjRJTHhBWVQ1QzVTNGsr?=
 =?utf-8?B?Q1hXZ25mYWdxanVEMEU3eFY2d0l5VjI1d3ZYNHc0eXFoUDZ4dHJQZE1ma29y?=
 =?utf-8?B?QW5ocDlvanhwZCtFWmpHSkR3emFKSXU4NE5PbWlTcmRZQ2dHd1V0RzQ4RmJk?=
 =?utf-8?B?ZXNYQ2htZ0hpNlhMZHdSM05WQWVva3lFcVNPL2I0K3ltVDFhYnBwL2lxZjBz?=
 =?utf-8?B?ejJuZ1FhazQ1bDdxQ2IvZWFpT3NTTkV4eUVubm5yNU9RaHZSQ2d6TTBTRWVt?=
 =?utf-8?B?dEoxUGg2dzFWYTAxQnMzRG9ZbFkzWStsekdMY2VVdXBrSGg3ZFRjZ0lrRity?=
 =?utf-8?B?ZWV2ZHUycGloWFZWWFZsd2ZTbk5qMERNV0pJUXVBemNMVzJ5alQrRkdRdnhS?=
 =?utf-8?B?TEFsc2k2RVFGUzdYNFFFdTBJZ0RlOWpnV0dTa0dVd0JnV3huQUkxRGQwRFpj?=
 =?utf-8?B?OTZMU0RhbStzeURka0NYTVJCeFlpSDdjZW15K3pnRjlIOWVsN1NRSXFNSEVG?=
 =?utf-8?B?T3Y5ZzZzOTEzalVEV0taQmI5S3RhMUVERjIxU2RCRUZnSVRmVG1qNnJqUEJk?=
 =?utf-8?B?ZFUzUGRjeTFNR05uRkUvVzBJVkxqU1J1MUQ5VitabEx1S3dxM0RGcmp4YlRF?=
 =?utf-8?B?dktWdnUwL0NTYzVRMFByYUw5U0EwaVFNQ2xxL1M3eUYxSHF0REJiRkFjeUsr?=
 =?utf-8?B?K1orS2ZWTVdmeUdEV2wvQXE3NlkxcmFNbkhTNnVlOUNMMjNnQ0VnZjdmeEFX?=
 =?utf-8?B?cnk2WTlzU1ppZzlDSW1QaGxvU2tvZ2N4d3V5U3NDWHFleVdHMU0xZndyMGpT?=
 =?utf-8?B?dk1NdUtVVjdkV2xrSXdIVnlPdml1Ym5aM094OXVwWlgzcjh6elRDKzNIcUUx?=
 =?utf-8?B?UU9va0ErSS9hZlRkS25ZdjZLNU04TlMyZ3QwSmtpc1pxWmpZMW5ldkRpR21D?=
 =?utf-8?B?RHgvVk4wZk4xakhNZmc1OWlYVlFhWS9EUUtDdFlqUjNFMFRGT21kTkZxdTFp?=
 =?utf-8?B?WkVoSjRncTVZL3lnVTh4RjVKVHBCVWJWZVExbU1DbnpvMnViQXhxR1JjTUxz?=
 =?utf-8?B?L1lxU2RpZTJITVljWEFvTVZ6MzIzbDM3WWN4dzdnUnVibnAraU9WR0RkaWVK?=
 =?utf-8?B?cmRGWXJVRmdPSW5OZFg1ZExOZ3NIUlFKNkxJOVNFNjlwaTExaGpFVGF4bndp?=
 =?utf-8?B?aHhGR2xOSkNLWkJxRlFtMldPVWxjMHovQVhnMWNxUUtSVWpwOGFqZUJZQWM4?=
 =?utf-8?B?NWozZ244ZHJ0Y05VTnNLNU45ak5qRHV2TStSeFk4SlkraTEwRlpWNXNiNmFF?=
 =?utf-8?B?cGdsek5CdGwrY0tqSjVxcWhLS1VQVHZmbW4xU3pQVk9zcUVaRE13Y3l4MXlJ?=
 =?utf-8?B?cmFXWXA4dTM0QzYvZ09PRmFQOENhR3Nwbkg5N0RVc2JZNXpEbXlmNnRuVzVk?=
 =?utf-8?B?MXJXSTVpemluUWk0T1V5UUJjamdJQWN2b1N5VTAzVnpadHV1TzBLM2I2WUU0?=
 =?utf-8?B?MW9uWmJnWC9RUXhRUCttTWNyTURwVkx6OElBT0l2YkxrNDh2S1NGUHlDT2VL?=
 =?utf-8?B?YUR2QjhCcGxLOXlGNlUxZnhONlhucFJnWW00UnA0ODJvYVoxQjZSR0s3WlZG?=
 =?utf-8?B?MXBnQlRLYVlId2VNRytkaEp2NGtjVTBQbTExRmxpd3dNaUJpMjZ1SDVyalhH?=
 =?utf-8?Q?VTtyW2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXZJMk9SY0RKcHVpL3EzMkZXZHdSdmRJSEFlNHZBNWZVVzk4Mlk3ZWlkY0Ux?=
 =?utf-8?B?QThaMEFVVmV4MEFjSkNIeFJSeG12NXBYcFhtbzZMVjI5dll1RkdJUFVOTnRh?=
 =?utf-8?B?UjZqWkQzUzFWcTVMZXp2SFAxejNURnJUSUo5d3B5d3QyR2RnL2IvVzhEelF1?=
 =?utf-8?B?cU5XTk5rVnFISFIwVXcvNVVRbmJLWWpSa2JJR3NzbGk4ellLdDdvcTVLM1RH?=
 =?utf-8?B?K1pVemIvNzVJbDJDZmp5STQwQXdwZ3pzWDFSWkpLaGpaMHNzSlR1bU93VnA4?=
 =?utf-8?B?azNHMTN0TEk1M2oyT0pIdUVhZjhFdjZlSWdRUFNZY3hNWmNkSFBSdFVsWjhu?=
 =?utf-8?B?cFMzcUc3d01BbjEyYWFrQnEwYUlJY2NSSU1VR2lBQjY3ejJJeFNPQkREaVE1?=
 =?utf-8?B?L1dRaHlZczZ6bTBVZEk0RHJTQlBXd21QTDJ3T05oWTlvRmM0V2p0WTZGV0E5?=
 =?utf-8?B?YmpCcHBqTUR0R2dWNmZFeGVadjZiYnIvMi8zQkE5eVB0V2E5WGJlRW1yM3pr?=
 =?utf-8?B?clh1V000dEljWEkyOVdTLys0VFczYXRldVNLM0dHUEhjSVNNZTdpQTJlOXVo?=
 =?utf-8?B?Y2NsRGRsMk1KcGRxQXR1REJBN1BjZkpDVmhDd0tUcUZPSlUyUXhvWUo3bjRl?=
 =?utf-8?B?ejdOV3BxL0tOMkhva3kyWCtZU2hxbUMydlRQZWRrbjFycEltcTZtd2JtYWxL?=
 =?utf-8?B?Q25zZENpMEIxcGlZb3pOUEdsSy84QS92WWlDTXpNMDdQUWZSK2pYYXFkVEp6?=
 =?utf-8?B?MnFGcmI5aGQ3U2xJbDVCcHMvdEY2ZE1XRjhIQjQxUzZLK3AvSnR4WTJNMWlN?=
 =?utf-8?B?MnlJTTI4VE1uY0NxYURtanRZNkdFc2hqcCtkZ1BYWURFUHZGSVYxNGJIaDRz?=
 =?utf-8?B?eE9hRVZIdEVRQWt0VU9zQ0p2aFNrQ2NoRDYyR2dPZlg3MUtrUFZJeHFieTE1?=
 =?utf-8?B?eHNGcE9yVWZNMDhsQUtQVjhsdnVDaEVxWmFwUFFNZ1VPMkh3c3JmT0IwQ2hL?=
 =?utf-8?B?TXJyYncxVTJncE5QN3dGbWdHODBaYzRNUFIxWnRJa2Z4a3NqWjd4QzVHMFFp?=
 =?utf-8?B?N09NOUpJSEZ4Slo4Z2t1ZS9WcnFtTWVHS1M5RitMTUkwM3dPc1Y2T1hyMHZS?=
 =?utf-8?B?Qlo5M0Q4aGxXRENKZyt4L0RwMzEvQVpNZnN1N3dBc0UvdmlCbldOUVVGWFBS?=
 =?utf-8?B?blpaWC9kWEZYRlAvcU84cmM4UFdyb0paYmZ1U2R1Lzhqa3VuYk90bmVVWUYw?=
 =?utf-8?B?VFVjQ2pvazl2N3N2QlQxV091ZFpudzUrVEhncU92VUFBc2VPSHB5NFArcGtM?=
 =?utf-8?B?d29OQXJheWlYR2VScytGRzR0K05zQnliYjR6b2sxKzRGdHdVbjZ2Rmk4cHg3?=
 =?utf-8?B?VVh0dVY0bUFSNDdyTEozeGJHZ1J0cW0wQkhpQ3k3cTZhSngzbjhKaTFkRVpX?=
 =?utf-8?B?dEdZcWFpZnBMeXVzUlVIMThhdlFwTDU0TjdTZVVWTUNCTlZLODRxNmM5c3Bu?=
 =?utf-8?B?a1E2T0NwSHZtVlAxUGFyR3ZaQnpBQy9ybTIvYURyTkRoSmNGOHptdEEyS3BN?=
 =?utf-8?B?TjNWNXZwNWJnNi9DVVJWQVUrSHpZNkdIMWYxL2wxSWI2MGNaOVRCMHJqV3U3?=
 =?utf-8?B?SGFES3kzakVkQ0J4M3N4aHRIYlVBbVZHSHUyR2UrQVBZY09POE9xQlFmcDhk?=
 =?utf-8?B?UzJGUjloSXJmWlYvME1xZWVjYmo4NlBXa0ZDZytYcHQ0TXFtZWdUcit2QVVE?=
 =?utf-8?B?NGFYV1BYNUlsRFVMMDVibGJHdXZmdHNhdE42NTJ3REJWL0Eyb0tUOURpRnFh?=
 =?utf-8?B?eFJDSHBmZVVMTjRTdUN1eFd2TFkxSG8vZ0NITHJZdWluWHR0aER0UWlzMlpY?=
 =?utf-8?B?dEd6S0hvaUhEZU1HejhtWGJSV2NGMkIxWjJXWmY3a1kvT1cyekxoekRLRFVn?=
 =?utf-8?B?UmY5WW8zRDBiZFhuTVlnQ3VCUTE3QUh0cDYrczZlejY3SVc5NU8yeXpNTCtj?=
 =?utf-8?B?c2dCWmJzQlNZL2tmbjkwcnArUEZVSXdyVEdsZGRybU8rZ0dkVlFpb2VLTlcy?=
 =?utf-8?B?UlE4aUlQamw1N0pCb1BQUzZDSE50cXJScXcrZmRINklCR2R0QjdLNWhtSUJJ?=
 =?utf-8?B?UUlIcTZRQ1h0VFg0eSt1ZjVIMnZldnNlMk5LOGlpbVcxWjRPM0ZsL1VOT1Ur?=
 =?utf-8?B?VmpYSDVRTjNCeXpVRGZYNFdZVUpsWXpwSlJiQjlQSEVPd2J4MDJWbnpteHZP?=
 =?utf-8?B?TE1BOUJZbHRxbVluLzRsUzJCYUd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88FB884370ADBD45A0787243FD4A9321@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FAZ635ZktZyhJ1ZzfZ0J14cUWqnhVb5ezsVmoymkZKxISlQJHOmoZ3kLnZvTecIjLVGVX3ELula5jYp1atDZ4kaMPx0a1OktCyv/yfZNnz4zpPrOOFYFlXg/7v783wqnu7hSemamN2Jnzv7/RDleKeb54a9bBBAweX2CXDQPFAmm49BAb+XM+LCnNRU2Ag8/7hsNOEyAJhHLTI/3jBXTW6g9rMyH/NctMtFFkHxrBL9fWHKI7Vu5JqjAf+XmIpSvlj83lC62uLA8SoeE2Zblv8Ckbajomq4gDVFkY5aCF/9aox9qanrUcnZVlluBbNoVD7qrjhxxr+qhbYsO/On3rYTA27W74y0vsTCUeSBlv0Y7CVv2AmZh9JWkye8HYOC7L7bjJxoudkpZbb16x+UlG9NGaabPKSVmGOLVr+i1ImkXAuEcr/NSmZ6W3fVv3nOptST0J3vvfom3WJjFcJn4C6wKZn3KxeqTIbW2tmb5NCgRUy9nhZKNANJ1++3AOSLbE5ujF/L7Wc69MUEJRkg45Jhcj7GXKjQzp9v7jDZv0Qv8F7JE8ZdS55mkM6IITK6kLOGbpRsM+HyraOycsGXeG0SXR51F450EbeI07FInsEjXpKipBeKDSi7mJy5QF94d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da3dfb9-7d98-4a23-6360-08de1864b240
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 10:03:09.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnRXdUd3+X3eGyxn8KJi+jWmTnVgOhELUczGLH+LnPAdVav+P7x0AbdVsjpV+T5TdWPd6zR+9ET2ZLQxCiIHdsNZ8wBItavef34HI86fii4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9639

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
