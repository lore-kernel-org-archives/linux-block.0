Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769591534EC
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524190; cv=fail; b=njNxJr7+Zdlx3I8fGHea589WeinfHkTnS7qGsL8jfPCte9alPRRCQpzOwWKKqy+T6JxAkoFXRLB2CkVjAHWIaLG8KY5TNPJqkVJJXFaVW3tr0Rg3W85N0mjW9+Nzy8Qwy1hyUy8Pf70SJmZBOwNIECbL2so/N/G7VAm+XbiyFQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524190; c=relaxed/simple;
	bh=EKcarEDQTXDpgBW3Xsjf7nHTdJeul9FXH8JEd8MKsw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mo+jXnSzxeY3qkST5bx4MIfn7KX1EvYZE9RJbx9bozlbwo2DAzcaUXHuCxe6dhesIkpN1YLxIvLYAAQjYL2uF7wnGaCJUQJ0L3ODpMM+bSp0yU2ynQwS+ZtY6aQBSygJ7JxC4TdrFW/zz28LT/jnXBvBHKBQsqGPKGIfSwi5qAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K3xaqY4w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nXlEob6S; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K3xaqY4w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nXlEob6S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734524188; x=1766060188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EKcarEDQTXDpgBW3Xsjf7nHTdJeul9FXH8JEd8MKsw0=;
  b=K3xaqY4wXJ9KQaz8pFsM5CT6gcrIwon3jdop4fGxnS2yfTGR2C/Am2c+
   8g++xQWgid+49CrWfLEL+ZDRTt9aEHjAYG5LiKEB8k/ZrCTOoe6lnKU57
   1Mjsy/t5L0Su7hXZNWsIwFFDpjovg3tgC5cZtuR58LDLhd2KwXK5dhmxe
   nu4n/xJKajMgf1lgiQg2vLxp1CBRvt+EBYfrcACzaQ3WRibOQ8uarhQOS
   aW9xfOtdaaO0I8Ap5ZcL+oH3ptte1xGWFnxjJIRnmkxD79bbrS6b/Of2Z
   7UXtmvqaO26u+jtHLvCuL6em7CZ1UvoMdKkG2F+UXpprOwQ4vYHh+ClcJ
   Q==;
X-CSE-ConnectionGUID: 8hcGDTZnQBusFF3HldfwCg==
X-CSE-MsgGUID: Ml4xnNeXSYevVdCLfIqpNw==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="35288787"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 20:16:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO7jtWUFToHNKjo0/1VxWPlldllItpDKs25X7jSbf9QA00VRlLJ3PIS7UVaFjoZUu6kugOdcn7zXAva24yBwkKyIJY3C/9ScqVUTi+3pRaUJAx+mqlti+LLs6s/fzntSVPuW4Q0RiOR1hrrmaZPb6mL4L46HtYHBf96VJ7jFtLhT1yzMcmxhTQZpj9eGES8o79XOz4GJ8l6cyQ09bDyYrlvh4IymMjOl5BgI5Skbp1wsFMKo56BKdcwdDcBfT3iZjLloZ1SqfZsdBrVPjsKYY+hDwj+Y+TeBzkL5KnzbUhtZIxmvqJ04+tVZR9mL/jYcfhpURCi5JrkvRF85l5ZO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKcarEDQTXDpgBW3Xsjf7nHTdJeul9FXH8JEd8MKsw0=;
 b=ALYdHGUJSekM4HFRxmgUx8gxszyYoKw6QEikbni2JVIEvldw5PPy5NAUmhfGv0BVeDSzJVeeuq+KuqAdXEAHcNAWcB6C4a5SnzcuSDbBpZ+zkFqPZPu1x27c21Fniyt1Q3bcGVm4uGKDO1GCz1HamDBvDe5FnXqNp7CRj3VOtURmR9yZFCstMmf4QryN3oa2ugY5fC1nmYIhXiW3JJvPiYrQ8DE1veNz62t5j6k/46c1PpUU/tpkK3NtUNq4soxvNCOWhDBpZqzqKRtPgZD76EjyMevJX6KkHVVxbLl/eoO+LFTpaq9Ss9DSVUNqtj1lQJcyv1tX+92CtIXttxgv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKcarEDQTXDpgBW3Xsjf7nHTdJeul9FXH8JEd8MKsw0=;
 b=nXlEob6StG7TQdrq5JW8WCdrBHu5tjgg3IzOb8sX5Q7NYE6a2jeBx4tVZPQcJqO9G6Eloqg0YgP/yqqiSvGTVW3BpuRar36/dMTJ656Ta/ueTQOVtc75UDuBOt/c67qiGcr11dQn4Uq8+VYX+R6mEcS4aS0Vwk9u/VWCTmd4mhk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6399.namprd04.prod.outlook.com (2603:10b6:208:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 12:16:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 12:16:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Zhang Yi
	<yi.zhang@redhat.com>
Subject: Re: [PATCH] blktests: src/miniublk.c: fix segment fault when io_uring
 is disabled
Thread-Topic: [PATCH] blktests: src/miniublk.c: fix segment fault when
 io_uring is disabled
Thread-Index: AQHbTTHNvRo4M4q1AkS+FYuAUGaM1rLr0aqAgAAF8ACAABtQgA==
Date: Wed, 18 Dec 2024 12:16:24 +0000
Message-ID: <s45w6k6lq4unukr2wgst4xfijsjo7ndz2vt5oxnmg5utrt47pn@mlojc72skvor>
References: <20241213073645.2347787-1-ming.lei@redhat.com>
 <57fglxl5mwxugcgj3aa3hkwdvmcfsfwdamlhd3r7r4fcfx75bf@opaflvrpqa7i>
 <CAFj5m9K6Qn3XFN4WpCUpOgBQVy93KUJT0Pbem5KhKG1jNB9M1A@mail.gmail.com>
In-Reply-To:
 <CAFj5m9K6Qn3XFN4WpCUpOgBQVy93KUJT0Pbem5KhKG1jNB9M1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6399:EE_
x-ms-office365-filtering-correlation-id: cb088024-7c7b-44a8-8cf1-08dd1f5dca5c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHZ1UDI2S0hIeUNRenlGYUhKZFJ1dHFJbFFYQzh3T3NVTjJZM2duejJOZWJR?=
 =?utf-8?B?QzR5ZGNaSzl1MG9Mak01ZnlDQXg3V1hySkIrNnF1WGFVNG9PYUF1TnBWbDRG?=
 =?utf-8?B?YlhPcGIyM0cxY1E2cmg4N2NIcUhJTTZOcGxJM3FramM0MkRlcEVNRE8rQ2Za?=
 =?utf-8?B?NjRVbDNJeUFXcklkVWVSd3NQUko2SFFHTlNCTmFWc3ByUEZVTmR1b3YzcGVV?=
 =?utf-8?B?YW9qOXVkNzc3aTVWWXRmV0dhVlJFdDZxSlpoRFE2MnB5WnhNS1N1T3ZKZTN1?=
 =?utf-8?B?ODQxSFZxd3BDNGg0WU1hdS8xYmZkajVrcFdFZGUwZkY3SWRiVUhHWlp1d2F2?=
 =?utf-8?B?aHFLalhSREd4bG1ZaWlxZjNFV0RxVEJidDlhNDJ3K2ZLZFR5VDZtTExlNU9m?=
 =?utf-8?B?N0NrdzB0eFdHZmg2NWpiL1h2VHhXejhKV0lkMjVxcEprajFLcmJRNCtqTWZo?=
 =?utf-8?B?Wi9YYjc5d3JyNkY2aWU5bnZ4eDgweG5nWFN1QmJFZ1NSRkVOU2E3TlhDeHlh?=
 =?utf-8?B?RitteXU2Y01xYytSWWE4UEJyYlJSNDVhWEU3bDI1Tzk2TUY4VGpyenovVld5?=
 =?utf-8?B?MEMxSk40SW8rUnJMcGR4U3FSTFlwMk1zUXhQRS84NVhMWHRHckV6TEh5MGFP?=
 =?utf-8?B?RzBYQXdrMXNMSFBEK1JkVXFBWEV0ZkFkUll0WXU2YXBDcGM2S3NFRkdwYkgr?=
 =?utf-8?B?RFBSZklJVjV3U0g1dE8yQjg2V2hZQWhwTjZqNENDRk9oa0VxRU84Ly9MSWsv?=
 =?utf-8?B?WmxPQUczUFREb2JHcUFhR1FPNWovUnlLY0t6cVFINWJuZHJRS0ZWK0tWQVll?=
 =?utf-8?B?TnNiNlNLRlA3K2FmNzJ3NzRjWndzRjd0bk4zLy9JdXU5Z3ZBeXB3Qi84Ym9K?=
 =?utf-8?B?dy9rTUkwQnV3eXA5TDVOY3lkUk85c3JPcEtBd1oyWXYvanlGTDN5Nm5oYTV4?=
 =?utf-8?B?KzZSdUo0VksrTE4yekc5TFoyVm9BeHBxR2dCNGNEdSsvak1jSU5NNElVYmk2?=
 =?utf-8?B?V1h4cDd4djNMei9jK0xnQ01SeDNrNXZDM0pyc20wVDE3S0pYa2Q5YmlOYmFv?=
 =?utf-8?B?Z3NnVnV6c1E5dTdVa0JLWmp2K2xKc0h4aFFJT0ZZNGZyTmdvT0lJWGZnR1Vs?=
 =?utf-8?B?YUFYUEx5RWE2c1ZqQXMxb252d1ZqVEU2OHVaSEkyMkVlZUMzU0ZJeFdyOVlX?=
 =?utf-8?B?QWVsS1NjREN5cWc4cUpDazRGQ1RydXdwMElkUHY5U0tDek1FN2x1VXEzRE9Y?=
 =?utf-8?B?eTVWek9OQXZnZnlhV2Rnekx0V1BtaFFCVHRIQm9yNTA0d3YyRjVFblFDQ2oz?=
 =?utf-8?B?YUNiNEF5TmhTTFZIMHZsaVQrL1FvRmx5MFlsT1RmaG0rTkZQd08zQkxuL25P?=
 =?utf-8?B?SXA1TE9hRTlVZ1ZxMjBtZm05dnRXYUJXTHA4S1M0NkhhTEtFTGluOHM0YTNJ?=
 =?utf-8?B?MFAxYi91WEd5OXh5NmJydGtQT0U5d2E4YTZjb1FWWTJ4Tjlyd0xwL1ZrTE5t?=
 =?utf-8?B?VFpVUXhHRnFPek9mUDVnNFFUc25JQWRDcVVCNlNma2QxS002WVR3OFhjU1hK?=
 =?utf-8?B?OVNkRGhVdUlOdmtxQS9XeXFnVFFPYkpobjhMQkZXeERnUHBvZVAvU3BiZGNM?=
 =?utf-8?B?aXRRQUM0b0pBaHdqRHhRSlBIV3RKWlIwcTA3UHdXcjlHWExzYmZUUlZ4QzF3?=
 =?utf-8?B?by92NUxBN1lnenBUYVVrdmVGZ3dvdXBTZ2VMaTV5Nk04dVFrdEZzWEdTNmxW?=
 =?utf-8?B?SS9OTHI2ak1Vd21ON1F1Q1VCRlhnUFBBZVEvSVFFeWU2TlpWa3E4aHRBL09P?=
 =?utf-8?B?RUpiRUhnZnlibWphMWJTZm15U0dteFRKZUpiNmlod1BSNUxvR0ZIdXNWRU03?=
 =?utf-8?B?eVRraTNySUlNempGOEJidlNXTTBrbWpPczBjWm5wUG5yTjNqWEYvMmFKNnhS?=
 =?utf-8?Q?mnYyFDq+ZEzEj5GUh4746UexzTR78gYr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2Q2K2g3QlRIU2Q4TTNDZDNZMjlPUVJwT1lnM2NTTUdnWFovcHdGSGdmTGd4?=
 =?utf-8?B?eUFjUkw5Mm5xb3luM0JZSXc0NFlCejRNb0RldldFcWhaYlo4dEh2UXViaytK?=
 =?utf-8?B?Nm1sL2lIS3R6UFBhMlMyZlpva0IwQzZ6SDRoQTBhNkYrLzhNdzJ4ZVZOMXFU?=
 =?utf-8?B?UGxxMlBiTG1KRlBMWjI2ZkxzVWZiZlRvYnJyWXJrejlEM1NCOEd3QkFlVC80?=
 =?utf-8?B?RTVhZitWaEV2MHhxTnhZeVM1M0F0NCt4SEdqT0dUUzZPSUxpVVhYcjBOOVhy?=
 =?utf-8?B?enRMVnZtM3BFTjdaT0pQZ3NEUThwcGc3eGNDbmdja0VhWDl4SGRMSWVaS3l5?=
 =?utf-8?B?TG1hYm5EZHVITWgvREpHT3hWd0JtNTRhZFNCU1dvKzMvaS9nczBsNEdjL2cy?=
 =?utf-8?B?ZDRpUlQ5dHprSHhwTTIvQ2haK0oyVFdxblVobU4zN09kbWV1aXhRSUVINEVh?=
 =?utf-8?B?NFJHZEkzOWttK1dvbFpGNTlkcEVzSmdyZmdZWGw1SWltQzloVDZIaDNESGVh?=
 =?utf-8?B?SXhUeDVJRUVXbll0YTNLUHQ1SG5Bb1FVMWhQYUt0K2E5WlQ2TUxLRTFvQ1dM?=
 =?utf-8?B?dlhOZWxDQkRNSUlqV1NNbWFTNjNaTFV0UE1FVGFuSG0zVVRXbWpYa2hOY1p6?=
 =?utf-8?B?RnZrN05HODBBZlRlL0RHandMejNDMUpyZU4xdzRyOXc5NlVscFd6dS9QVXpU?=
 =?utf-8?B?T0U2SmF5YW5nRy93WTloUW9MaHVWb0t1SkQ2dFNsNHRSYkJPOGtZV1ZpZkJy?=
 =?utf-8?B?bldQWkxyeTlOWDVsb3RRaWdNRTZOZnlRZjZMcGV0QnVTNEJ1Z0dpMlZMR0Zu?=
 =?utf-8?B?Uy9pMVpWcWE5N255aHJVY1BVOGgrMk9oVHVVWWNabU8zWEJsZ0tvbWQ2UFhO?=
 =?utf-8?B?TzRhZXFJVlh2aEJFVm1GQkZJRVFUSDJWdFZFUHBIb0RUTmRHV1BsQ3lpQW1O?=
 =?utf-8?B?eHBVSnNvOVJRQngzS2Y5SHFkOGdnTG5NZFhiQ1l6TWxiTEhyM2RqSUZrcity?=
 =?utf-8?B?aHEycUE1U0hCVHNMQk5ZeVhFejY2R0k1QTlWeHVwdlpXbkdsM21FM3gweFAv?=
 =?utf-8?B?SmFjSUpNVXdEalc1S2htSjJwdjBrV0FnTHNZZk5aalZmYnNDYzZHUit3UmEy?=
 =?utf-8?B?UU9ic0xlelByTWZjTUhQUEw5c3JhVnRLYytpM1UvNmk0eG1GKzNObnZPU010?=
 =?utf-8?B?Slp0L08yREc0b3g2YklyN091ZVRseUsxL0pOa1JvYkpOdzFiSmViNkNjTE5O?=
 =?utf-8?B?NjFvUFViYnZLSFhmVTNYRWJBRDl3eWo1UzBUNUU0WER1dlJiWEtWRENRQnpH?=
 =?utf-8?B?MzdEU2xVdGZCcFQ0L1RxK3QwdnNZOXI3Qkk0MjhuZDhZMXBJUkhQRVFMVzdn?=
 =?utf-8?B?R2tudjBJMDRvUlJBSDVyT25MdFQxbExQbUUzYXZ1czg1cEJWbmFFbGptbDJ3?=
 =?utf-8?B?bEdDT0grbmZPdVluWXFVTzZSeSthclgxUTd4RDBIeTBlc1BSQ0FNczkyKzJx?=
 =?utf-8?B?ZEZVK2VYOGdzUkRMTkRaSitDYStEOUhSOG96d0NqNmpMc1FIbXEzTUdMb1FP?=
 =?utf-8?B?ck9NMG54OEIxZjluMDQxZWNpZEpsbkQvUWc2MlVkbldxZzAweHJ6Rk1SUUVk?=
 =?utf-8?B?aFVKL2dxUWtjZklwUzFmdzRxSFkwRldLdUNGMjdOMUk3TXVoZWhyNkRjS2hR?=
 =?utf-8?B?U2l6UWdzZk9la29MaTF3QUwzQWlVV2x6Nk95UEhqSzdMdGt4TGhHVGhxbllz?=
 =?utf-8?B?Yk5qanJ6aFlCcUE1Nm44L3VWWkZXTE1wMEhPT1liNExzRS9EbmxPbHd2R1Iz?=
 =?utf-8?B?ckFMK2VkeWdwV0tUOEwxT2FVd2RXR1p6SWdDMGZ2c2V6NndvVHVnbmlVYnFK?=
 =?utf-8?B?QmhkaEx5WFVPVlZaeUgzUmFqMUpaYzY4NHcrTVp0SmovOFNGeW03ZDJlM2tu?=
 =?utf-8?B?RDF2d3VGOGtSTE1VUmZFMHovWE5XYXlUdmowbTd1ZmdrUjRyRlVuSFNsZnkx?=
 =?utf-8?B?NDN3SWxsdHNucW45MXJLVWYvNVUzTUtIeUFvbWlOZnhRSU1WZ0NDeC84djZH?=
 =?utf-8?B?NUtPKytJbTFjSi9za2NoeWtwWkZkeU1MUTQvNENkQi9TR0tXWWxVTEFwUFIw?=
 =?utf-8?B?RmttODdOQVlVQmV5M1N5d05EdVFFMGdYdVU4UkhWNzYrdHZLWUZXRFhFQjNW?=
 =?utf-8?Q?nGC1+qSva3XffCi541OVCZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB8E49C781673C438042F1C290671EA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6sZMeN/dgE33oo+iIcencyPy4kiCHtl4nO44LxEZXCR19T1AcwiIseXJffsysJ66x7PziVWXBbcZvhslhukYZlvzM1FEGB5nQyr/y1IwZFkZC8pTEivt1+efkQZwSouuXlT5TW3Y2k2lcRhCJ8UGrgdSZ2PdUOJcNjETNMm+3BECU5Fsx5PPIuqEKwy3G7o9axVg3FLRJjN0QKZzevUUk2Z4wTM54UR3xUpw6Yo3ENjLmR8m5HBogUUhzivKmYrsGO6hnX/Qizwb1vQprS/sidw4veSvfj2jwofz65noM48Qc/HdSkFMHqzEz79hX+z6T+MKjmyUezRVrs4sn6rpstpev3fI+Ies1W7q5Aev+171D/lFZ4QmMCheSNKWT5qRal9GFJCqVqMZariAY+rn4txxKsObMBtUXc2FOwt5u6cxvGvLsUQ158TWJ2S0hAne72KNbkY7STCwefnyohPGHz6z5TyErUCuKuhNgVNuwbtpRSvi+1Nl3IC/p1vdi3WuW5dxtDo/V4XuMzdKwPpe//Y6Ez/NlMUFqbbUmghbjnfqC4bYkYd8Ep6lio/bPMm6z79KzY69u3gTQmgJ9T4X9AG32/8TejtIO0iZFhlCnVWmSE7jEcSJsyxgzdzytHGL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb088024-7c7b-44a8-8cf1-08dd1f5dca5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 12:16:24.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hE0k4UwBVDpB47nPhCM2BOKrgnUKj8Mc4GmP3dWh1OJKRN+swd17feSqNfuDlltBF1JQWvK9S/7vEK+Bb2mcA14f18BxIzjfOr/oJFXmjZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6399

T24gRGVjIDE4LCAyMDI0IC8gMTg6MzgsIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBXZWQsIERlYyAx
OCwgMjAyNCBhdCA2OjE34oCvUE0gU2hpbmljaGlybyBLYXdhc2FraQ0KPiA8c2hpbmljaGlyby5r
YXdhc2FraUB3ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIERlYyAxMywgMjAyNCAvIDE1OjM2
LCBNaW5nIExlaSB3cm90ZToNCj4gPiA+IFdoZW4gaW9fdXJpbmcgaXMgZGlzYWJsZWQsIHVibGtf
Y3RybF9pbml0KCkgd2lsbCByZXR1cm4gTlVMTCwgc28gd2UNCj4gPiA+IGhhdmUgdG8gY2hlY2sg
dGhlIHJlc3VsdC4NCj4gPiA+DQo+ID4gPiBGaXhlcyBzZWdtZW50IGZhdWx0IHJlcG9ydGVkIGZy
b20gWWkuDQo+ID4NCj4gPiBNaW5nLCBsZXQgbWUgY29uZmlybSwgdGhlIHNlZ21lbnRhdGlvbiBm
YXVsdCB3YXMgcmVwb3J0ZWQgaW4gdGhlIGJsa3Rlc3RzIEdpdEh1Yg0KPiA+IFBSIDE1MyBbMV0u
IEFGQUlVLCB0aGUgc2VnbWVudGF0aW9uIGZhdWx0IGNhdXNlIGlzIGluIGxpYnVyaW5nLCBub3Qg
aW4gYmxrdGVzdHMNCj4gPiBzcmMvbWluaXVibGsuYy4gU28gSSBndWVzcyB0aGF0IHRoaXMgcGF0
Y2ggaXMgbm90IG5lZWRlZC4gRG8geW91IGhhdmUgc2FtZSB2aWV3Pw0KPiANCj4gSGkgU2hpbmlj
aGlybywNCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMgYW5vdGhlciBzZWdtZW50IGZhdWx0IHdoaWNo
IGlzIG1pbml1YmxrIHNwZWNpZmljLg0KDQpHb3QgaXQsIEkgaGF2ZSBhcHBsaWVkIHRoaXMgcGF0
Y2guIFRoYW5rcyE=
