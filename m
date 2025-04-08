Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200871EA65
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092331; cv=fail; b=FbaYhXPnrg7jC9HWN2nrpvzkET0ZsSJWDjDePMHNTZAmh3xMfXNXCh6nAw7Dzb/bf/Pqe32L0hhNvk/lhCUwFtPncJGF1K/EjiURj/Z0lHCAGPwxxaxLt83EhIkxhv23TE1FUKqnZf1S/gjQ72Dhe8fzW0eox4fwTItIzLmfdKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092331; c=relaxed/simple;
	bh=av1ff6bys6sESpFMrWtO1HlIG3cxvI/6CMZSL+v9d3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=inxJUogjo+FrSX4nLTWdyi5mBTZ4q5pR/nYMJIFgYj3cPSVx/NiDfbqXBZb7Qr10VqdIK73Ovxzr7/u21xVliSXK+7G7AqR0ndlXLOgRO/xSLhSJPMgWMjozSYnxBpteTW7fkhXwcJhcP9fm962brvuGLSzV46yYF4tAhpZH2Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qebRh6qY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HL7lP3Di; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qebRh6qY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HL7lP3Di"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744092330; x=1775628330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=av1ff6bys6sESpFMrWtO1HlIG3cxvI/6CMZSL+v9d3Y=;
  b=qebRh6qYbiQarApn3reTHxbFSrBYBoKqmP+MhOVhWWSZBUtX05shWYYx
   xlYnBpz6h2mCo+utv462/LAy2sSeJ6jV/huFjfQhgo53KV+txknUefwt5
   6KB+0ELt3XWoXcbGGvKMu6+b7zaOyEwDMnXBBU/iRnccIeE4xb3gjkoIr
   mnk+RYZp6dtKt2hvZztsybt7D1VJImFOSS1nq9YbbvUvEvTsRfNhQPxi4
   oK74H3DklkMGzlkkKOwg+7f9nWCqevZW60BU3iO3LI7GWP6N9AN+tzB23
   urJYk2Poxq6XfHDHoEBX8oELJ2osZc9kg6r7JVHaXaHSjL4sw04xf/6Rc
   w==;
X-CSE-ConnectionGUID: NXHaLShkQz6ygLNms9osng==
X-CSE-MsgGUID: mxVD9Eu3QkSUhzOoKaXLBQ==
X-IronPort-AV: E=Sophos;i="6.15,197,1739808000"; 
   d="scan'208";a="73504247"
Received: from mail-westcentralusazlp17011026.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.26])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2025 14:05:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6/kEL9aItev3o6oqDofr6eVt2f325hs7nWdPtAOkj5l8P8p6wQ1uxVWe/fhxkNXzFFQeHJry3HMmmAcX4Atwr7VdarHISn0OOIaHmhwBsTxQ+vAX9E6j73t6kLgFK8rWTxsnhMf3rDv3gconDipXVF4c87qSPgZTdV0kk2aJD5TZgyL6KBFly/dz/4WnBT8QmzI4xcuXSxa5RcBCsU7WSzOQTsYFm1nAPC0HfBajEPHRB5TZSt1/eqdBPobVbdF0qMK5cCGxcsMlurvVWWkZ7TWUNcVLvEbAtL8c0EL/v6DU520OIGgGl2R3+vwhi8D6eFELg/SXxQIu9+ArmYx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av1ff6bys6sESpFMrWtO1HlIG3cxvI/6CMZSL+v9d3Y=;
 b=JbVqE624XUlfn8Rt/1b0GBBqhP+JGqvYQRzoXKYWjYInCiiYK5Ve/kMLZmYGj8P6hmxq0cE1CCPLGn3IAL2kz4CtyeIEpsFHWQTjJJcyvU9fHThPrF0qzpP2fQkC83ZT6Z1zCWAxSrX3auaNMueMSf65C9pihWCgYI1pyH8OKXBwnvZfDDpzDhefsbybckKmk06IXIod8dFF5afu3QrtrmK4mYIzlD4Vwtaa4IbO5q4cbhVpj14fTYNl21VHdOIRYLMr/SxDlfojF1jQyQo3URJe4r1gdx1ZFAyOSC1BJZOGdn6NP0ZXPBh36OI4A4h2jbWhR449ZHAfox5aUqvzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av1ff6bys6sESpFMrWtO1HlIG3cxvI/6CMZSL+v9d3Y=;
 b=HL7lP3DiP96+5i+IF8h0mxrjicS5xW332LmC/8smU9mDr12twpuWCUiWJHKgb/5WH0jmMPVYx5b1kiMJHJxmeTWEYtB8BM2EIk/xFsV4XZvjQb0c6Mdga3RX62bIkb4FYcoqYLfYLX9GZCZh8yr/pwtAgVZx+eCmBaEp+5UTJFo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9153.namprd04.prod.outlook.com (2603:10b6:610:229::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 06:05:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:05:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Caleb Sander Mateos <csander@purestorage.com>, Uday Shankar
	<ushankar@purestorage.com>
Subject: Re: [PATCH 02/13] selftests: ublk: fix ublk_find_tgt()
Thread-Topic: [PATCH 02/13] selftests: ublk: fix ublk_find_tgt()
Thread-Index: AQHbp7+AAhv65HkW00uEWAydRi2IT7OZSPIA
Date: Tue, 8 Apr 2025 06:05:27 +0000
Message-ID: <37a69ba9-7928-4b4a-a887-1ec0b35a25e9@wdc.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
 <20250407131526.1927073-3-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-3-ming.lei@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9153:EE_
x-ms-office365-filtering-correlation-id: 048c549c-3854-49a9-ba5a-08dd76635bfb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHg0NEwxYUV4eFczUWcrRjJqTERMM3NBRzVzSjY1RDhBZzJaM010cHBTTjBa?=
 =?utf-8?B?RTE3KzFGb2dDS0JXaWpZU3QrU0JnaVJvRlg3NjN2M21qbUlXeTVQL1BRelhO?=
 =?utf-8?B?cTdSTENCZTB1MUl1VHNyMUxnZGMySjhFZFQwZXowc2RIUVhaSkgzaUcycmxy?=
 =?utf-8?B?NVVHVG9qMDdoeU5wOU96ZmdKcDZqV2ZCcUdLdjB4WjNZVkRjY3phTzNQQy9m?=
 =?utf-8?B?VjVoSEM0bWFpVDNKODh6YXlsU2Uvc2pMUkphUytJOUd6SzRIbHpFd2tiWjBQ?=
 =?utf-8?B?dFF2aTJtZjd2bmFFc0Z5alE4MDB0MEkwUVJBZ28xUEpJSjBWc1AxR0pQd0dl?=
 =?utf-8?B?RWloNUVrdXBYOTlzZXkxMDZlQis1bU04ZWV3dlRwZ2FOR2pQdmgzTDhkbnZv?=
 =?utf-8?B?ekpWdUlWc3NTYTFRK1FCTENEZmxMUkJmZnJCdjJqcTNhZURoVzgzTXJNMEJ5?=
 =?utf-8?B?TkkrMjdBUDR6Mzd0eGhwdGM4T0pDOGF3MEh5Qi85YVpPeUc1YXViQVZDMFY4?=
 =?utf-8?B?RTc4a3F1a09WczRzNUFzdUhqbkwxRXhSV1BVZzhOKzFGclBibHo2REJKMTBx?=
 =?utf-8?B?RGRrMDJXRGw4cWNqZWNZeXlLaU80aVhhdzdlZWI1bFdhd1YyWXBtSXBtQUxi?=
 =?utf-8?B?cE93Ulp5dmRFaWkvOW1KZ1JTNWticFppMnp3QWQ5ajJjenBzWFRES3RVMFZV?=
 =?utf-8?B?clFOb3lkblVOdzZVcXJpZjNjNlhYeFJSNjRFaFdlVEd2WHp1bWNnTWp2MDRy?=
 =?utf-8?B?U1Y4eFpLMi94OU9NUXptblV4dmNVSkhkVlhKRHFMS2hKL0UxdEFqNFFLMm1W?=
 =?utf-8?B?YmlIb0NjeXdpaW1IKzdOMXBtNnROUi81UnVpSGI5cEo0aG5BZEFBeVIvVXo5?=
 =?utf-8?B?enAxOUZnS2c3c3lERzdqTkhGTUx4SDlxangwcGR2dDh5alNVV1IvTzE5TE9M?=
 =?utf-8?B?WnBWNk9vUUtsdlFUWTJiejByMWgxN3VQT2llUHZ6NWlhbGFFZkx1c0l3THcz?=
 =?utf-8?B?MDFGZDR5b25nVUZ2bUtSMFNYYS9ubU1iKy9VbTNWVmErL20xYmx5bHd0Mlhh?=
 =?utf-8?B?c2ZkTUw0Qzl5aUs4KzFINWMxS2ZLdHZoVzdmaUwwZHJRbklRV3JwQTN3MTAz?=
 =?utf-8?B?V3M3VWx5VUt5bS9xNDE4TmIxcVg1OC9ZQkJJMFJPS3ZMaE9BYU4zd0VIM2ZX?=
 =?utf-8?B?eW53eEh2RHc2Z1FtU0xoUEdRL1RQQUJ4NHNQZ3BQRmpGN1VtS2JMSC8wTE1w?=
 =?utf-8?B?blZobDlnYnp1bjUyZnlYTTM0c2R0MUE2QkpTVXd1enZYcjB5T05md1V5bkp4?=
 =?utf-8?B?RExxSmxETzJ3MC95bDVJM2RNWXBNTkwveHJqQkVucUNkVk5DL05rVzh5TlBX?=
 =?utf-8?B?SEJseEpQTVh3YlN0bHdmYkFhNE9SVGkxR3pMR0FyMVJuV0tlQlJpcjdPODUx?=
 =?utf-8?B?MXhtMjZqcFU4Mk9ITjlpN2xzckJUYTdSVEc1ZFl2bzJWaWN6NjhieWc2ZkRj?=
 =?utf-8?B?eUNjV2VlVVFlUk5DZlV1VnIyNnhxRWN0b2lFelJpcDhiRndQVU5SMWk3TklW?=
 =?utf-8?B?NnplaVp4NThoTE44bldUZ05tOTE3ckdTbmJHZkt2YUxXSTRYZ2xtVEI0bjhx?=
 =?utf-8?B?cVZRemRleWIzMElJTzlRcmE4Q2Uzb3J2bXlIWldlQmNEbWNaMXVJZ2I1RHdQ?=
 =?utf-8?B?cWJoYWhnTHcwb0hvNHlLYy9QdXoyMmk5Z0t2V25rbXo2UWN4em9mK1Z0MTZj?=
 =?utf-8?B?ajVsRXhNN01VMGRSd2F0VE1FcHlKbVUrdXJGbHhyQ0VBUFVnNVFJUlhveFEz?=
 =?utf-8?B?NmxSeHBKZTJrcnVHTkFGejdpd2FsRnpUUFZyd3hua0JXZ2ZFYnJQdGdLZXdl?=
 =?utf-8?B?RmhvcFpYTVltMzdxQjJhSmFpQ2Qzd0NTT1Y2N1lvb0NrR080ODMvdU1IVGNU?=
 =?utf-8?Q?Lkm76DN/BxttkRfnIAaQtHRwKoB5VVlS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWZ4M1J1ZmtrbFVVUzdOQXFDblFneXNiL011TlhIQjQzeXNqYU82cGhxQmZv?=
 =?utf-8?B?d3g0T25VSExmQXlMeklLN2F2dUxwWlpXMlBoaExHeWtwelVsazJuaEpvNzJh?=
 =?utf-8?B?dUdxTThyWU5MLzhPNjF3N0N5Qno0NGJyRndyMmVzYXNOcmJmV0U5bXkvbUVo?=
 =?utf-8?B?OTNSVTNhaC9rbHEzaWNEZ2t2N3hlWGhQem5pWS9yNHZaQ1ZCRStyR3BJaEQ2?=
 =?utf-8?B?M1NlYjNxdGlDM2FMdHFic1FvVE8yeGQ5dHhNRXFlbjgycjM4Y3kxUzFvMjdN?=
 =?utf-8?B?b1VCbGtmN285WmFKYTQwb1BGbUxlbE1oN2E4S29OM1AwcDNiSFQ2dG5WS1FW?=
 =?utf-8?B?M2pEMDdMenpIYWEybHFQTlQzaGtLR0pGL1lReUE2eEJIR0o4K3g2clVlUk8z?=
 =?utf-8?B?ZFk2RzFjWVRmRGVQSWNqVFhuaTBSUTltOGczNWVXd3BWUGpiQkJ4UW1KM05E?=
 =?utf-8?B?N2dLdS9EMk1rVUd0N09HeXNJanhvYTZxOCswOWE0NmdHeUt1aTJuZ0dkVUNO?=
 =?utf-8?B?Y2poMjE2TTIveE1DT3FWOWVxL1hLdC9aMS9vNzNyMS9pNkNZM1IzNU5LRldP?=
 =?utf-8?B?SG1nODZ5aFMxMkR4NURxWDA5MElPcnBxelhkRjhQVzFWMFhoeDAxSkJyMlph?=
 =?utf-8?B?clJNakgyK01ETzV1M2RLclU3T2diUGYxamt4SHJEOVhqdmpBTTEvclptOHNr?=
 =?utf-8?B?MXZVeGVWUTFxQ1dnd3NKM3ZLL2lUN1VSUWlSNW94Z3NpNzA1SW9WRnR5alFx?=
 =?utf-8?B?Sys4U1ZHanMrbUo1bnc5c1RWQi80VjlQS3dzZEZmMnpYQTVFODJQSVo1SEl2?=
 =?utf-8?B?aVVROHhrMDhsdWZYdkdMUkZ6ZDlVeUxiV3J5UGtneEY1NC9EYWNtRDV6Tjl5?=
 =?utf-8?B?ZTBEblcrV2NQenVmeFI3dmJIakVMTnpHcXpITWp6NytaN3BzNDdHc3VjTHBS?=
 =?utf-8?B?Y2pTRko4N2hEa1hwVkhpU1FhMVFET29zbFdhQk9ybHZCRHBOSG1Tc0twWDdH?=
 =?utf-8?B?eGVmMjY5WFN5bDREdjQyVnRIenNrVUFkaHNtUmEzdXZDZ0pOZW96UlJkZmZT?=
 =?utf-8?B?TlVnS3RCMllyUWxIQkhPNlhuaGlDR3JlM0xaeDFWVHY3STFKMVpiSU4xOGR5?=
 =?utf-8?B?cGtiMlNRWkE3SCtJVWp3V0NHbDcwMW4vRE1VbEpTT0NldTVDYnR2Wk5QMUVF?=
 =?utf-8?B?R3liTWdVQzBrSnA4Y2kxY2ZlVGhYQVYwWlhXV1BGK1o5RTRFbUtLSTRDYkM2?=
 =?utf-8?B?UzhreUtnLzRjeE0rMGNxUnNTeWE4bHprN3EycUlRbGQ0N2ZjSlROc3ZScHBG?=
 =?utf-8?B?bWtWN1FWcUdET3hSTmg1Yk8vdW9QbVZSZE9TNGNtSHA3dmIxNC9NSm85TElL?=
 =?utf-8?B?bEtlR0N2WGw3ek1rNHVMTEw1L1JrUkZsb3BUZTBtYnVaOUczb3BZVjFhRXk4?=
 =?utf-8?B?bFJrZGQxYU9aRld0RkJHWDI0RE1Qd29jZnFnMEM4TmVyd2JxVzJPbFU2SXlM?=
 =?utf-8?B?Q29wZXp5eGtEeWNRSHdRenhLbUord25zYmk3c204cm43VDNad0QwczJsYlI5?=
 =?utf-8?B?dnUralBuVzZHbVBPTTRvc09RSmplTFVyYWdwSktkaktSekJGNmpwZmNsaHN4?=
 =?utf-8?B?OEUyZXZ5VjBUcG12bXI4RGg0U2cyOEhqQ3Vnd0xKdDFacFZpeEJmQmhlRWNo?=
 =?utf-8?B?L1BZdEcwV21iV2t4S25ndm1oWFRhL2d5K2FuMURzRkpxUnlHdHIyb3UvUVhR?=
 =?utf-8?B?Nk5BbnQ1a1ZUQldzd0doeVZnQUNxejZUdlBXVE1KTVJNdG0rMHFCWG9iekM0?=
 =?utf-8?B?ejluSUg1Y1lvVE5TdHVUMC9nVitMQ0FXdTF2S1NpeHo0Y0hEazZDS3A5TnBr?=
 =?utf-8?B?eWpHVy8yZ0htYjNRVkNWZ01QUEtzTUd2QnlEbFhJUitVeTVnbzFxd2lua1BZ?=
 =?utf-8?B?UGdYT2psTXBCYkhTRVJ2M0xJSHVGaDN1U254UzUya1J6ajN4M3BKWVZ2d0c0?=
 =?utf-8?B?RzJPNVhESDkrdW0xV0JXMTdlQ3NsNHlUOGNSbkIvRDQ0RWZpbDVPYStqcXI1?=
 =?utf-8?B?c1dGYWp2RWpEclJmcDE2SkhIYXFiUWVBazhmVzR2aTZQckRyYUpPbURaTUtx?=
 =?utf-8?B?bnM1TGJDd0N2OWgwRW9DekljRnBLSkplK1BhT3B2c0lSN3NJd3VsLzNMNTN1?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207D139B8B2A6B46B2FBAA161C39F388@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VdoUFJ8Ag5UXq+wC0Rj35nplMk/uCcdnq5IjxlqswJDjBxerGNK3pIs5dSal1aeiJBLUQYoXIhmOMXIv1gZyE+yjnzSS8W2pNuM+/ATgsdoZ+4F7iBaOG4e5fvBb5150P1LIl9DW+ExeBkTUPyv0+TCPzaR8O+XCbvYTbFurJz9fwB5XXHQ6X9tJKkw/Mr83CFFOoATbhEEAHHE3zAFykipGO7uh0mvMSE/5i19Dw1NIvq9h6Jjq4aJpMLcBbmRsvEKowpVo1N1mrAivTfR9E4/kB9hUJZkJFNdbT3OBB58jsJFKWdqnAulpdg6OxTR9fGcNRXuEf23mdK4KznAJq7KdyC/SHPsKZYQFEXR5cQHP/GtR4mVt8R0ciSoZDN1dH+Bbb0IX4WzdHX6Sxmt7TvJCP3xJvA5R3k6hUtNMPRlueRBXCB1XpIJdJTqM3jrADzSqg3yL0uUawdh3ZwRPRd5le/lID4rBktql+wYh2U+1cSNKrZLld8aQHwsnRDEzyLKMWgTUAOI/UfqHdzZr60RAzB38vpJhENQZXCTezwDqf3EtDvmdpqCrDb9xM5opt1CY1bYfv1nZ70BmqZ+gPSn8j1IW0VokjayfpOYlrVfTOjVeSDHRrE44nD4YWqwZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c549c-3854-49a9-ba5a-08dd76635bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 06:05:27.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoQYG/f4YuqFUkiNWMqiJLIefq/lVvH5Sm9uvdcMaYwJytdwotPM4vyXlhVTBz9Pz0vFPBbtlKIkqZ8/cCmzNFq8BUyUIeK5phJWq7R/YDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9153

T24gMDcuMDQuMjUgMTU6MTgsIE1pbmcgTGVpIHdyb3RlOg0KPiBCb3VuZHMgY2hlY2sgZm9yIGl0
ZXJhdG9yIHZhcmlhYmxlIGBpYCBpcyBtaXNzZWQsIHNvIGFkZCBpdCBhbmQgZml4DQo+IHVibGtf
ZmluZF90Z3QoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRo
YXQuY29tPg0KPiAtLS0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91YmxrL2t1YmxrLmMg
fCAzICstLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91YmxrL2t1Ymxr
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91YmxrL2t1YmxrLmMNCj4gaW5kZXggOTFjMjgy
YmM3Njc0Li41YzAzYzc3NjQyNmYgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3VibGsva3VibGsuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91YmxrL2t1
YmxrLmMNCj4gQEAgLTE0LDEzICsxNCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVibGtfdGd0
X29wcyAqdGd0X29wc19saXN0W10gPSB7DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB1
YmxrX3RndF9vcHMgKnVibGtfZmluZF90Z3QoY29uc3QgY2hhciAqbmFtZSkNCj4gICB7DQo+IC0J
Y29uc3Qgc3RydWN0IHVibGtfdGd0X29wcyAqb3BzOw0KPiAgIAlpbnQgaTsNCj4gICANCj4gICAJ
aWYgKG5hbWUgPT0gTlVMTCkNCj4gICAJCXJldHVybiBOVUxMOw0KPiAgIA0KPiAtCWZvciAoaSA9
IDA7IHNpemVvZih0Z3Rfb3BzX2xpc3QpIC8gc2l6ZW9mKG9wcyk7IGkrKykNCj4gKwlmb3IgKGkg
PSAwOyBpIDwgc2l6ZW9mKHRndF9vcHNfbGlzdCkgLyBzaXplb2YodGd0X29wc19saXN0WzBdKTsg
aSsrKQ0KDQpXaHkgbm90DQoNCglmb3IgKGk9MDsgaSA8IEFSUkFZX1NJWkUodGd0X29wc19saXN0
KTsgaSsrKQ0K
