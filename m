Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7E39C649
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938934; cv=fail; b=TKY1ql0faWAmgEsPDl2IvUWKGstVv+xUzLhl0DXJNEJOVzat0Q0xSo7l2+dKUTbPqlJwrWXPQCBaknj+syAkqBGNKpgu0lDkSGQTsoXMA4W+W9bcRtlVRL7oQGDP9eXdm6UuJZ9vcfHJDTjd/Pxv+5Zl0PuvfzNlnqLvUGBF6H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938934; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YfeYTCV6UrXefbTHP34kr2Dw+7cntKYJSzxIIW5VbYC8drzqhQdqLv3RUS7PGsW3PmS7OtHW9Mst9A2UnMCJVzuTlLCtVueuQzYhUUuyFBnjHyv1Hi4cx25J2bOSJMqyxHysCfX2V2x0JI7qJAh3L311fup1k9j4CGK9MtUS5KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OO0R+TJ+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=waZCYJqe; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OO0R+TJ+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="waZCYJqe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771938932; x=1803474932;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=OO0R+TJ+J0o4zsi5O1UOEU6sX5xfhIRzxwF+VsjURfXedtZclKuVr3TI
   KljPOzqLP9P8zV8pPAqSwmN5H0m/E9M4D9CdfUywqJkT3Og5uKfChh2ig
   dC/X/yctey1vv1ktwn4SfS4rCOkbQKDV0d2/DnKjspwGs68T0B7Ramvxg
   NAFKd1OD/mesDps03+qC0x92whPrVcO5nF2hUMf/nFz+t2pOdzqR/3Whw
   GmvMHTeRdRf272Cr0/PUHmch2HM+bekp3q/+Yx6v0drDZ9X0MdfmfUno3
   uYevZVkUneJ5VuQI2sluOlE+nkADXFin3lR9ofQUOIJQIB/3WsB+jbn1Z
   Q==;
X-CSE-ConnectionGUID: LV7mkUlSTzWZWvTxwav6TQ==
X-CSE-MsgGUID: 8bS5g9rJQy2d+IUnPMO+/Q==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="140393491"
Received: from mail-eastusazon11011056.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 21:15:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGz+mRozOx4cAWA6Dm7J0ZuNpIJQlGflTz27vI5YRENTa6wp3mOGj1XEA4eteyBOq5BCzj09KAOeQ4D+xdIyqxJFuFXc0M2BOSIICVaayO7Nsd8ibGOqjg3eOq4xF+qCpfDP8D/8Vm5AordiEm2dgUQafmmaFbtICQB5/6qmIeQ4bedADWV0Jw66r2CA/yysxKziRqESIA8oj/BlUzuBHoddyGahKIAm47JoveMI0gVe7k9vWdziLCe2hQW33z3jS55Mz2+Ms+wWg/8dRNUGlzEyS08+40bAIcyzqp67h3mn3D0lxxc3FH9v0c3jQV+nhxy24sk9VPJsBhjRzE5BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=PwqG00fT03VtPImNkQWj93tmmg0m6XwZogDnQIiPbC6V4EZc+Ls4w77UCkx/4LwsE5AcK93JxQP4pwkIKGNOnfc72BNrqCZ2033E8NOqZbsFU9lT8fdVlA6K8j5Ji7hZjqKg9/j43q0xGhiQK14IYF05uTFY5XmI1gze1RJYIseC08kLNBGKiVHTcD1Qolb+bA+pp87XCRVAQ8+hi2VT1sKqzDNwc92kvj8tbzTcBD35IuD+6QAwKFAQajjSYs5KX2J+AXE4rn2SPaKAjSBeycf+QA1yOkprlAQCXr+4DcNUhpP/WdZYmYJ7GrxOOJGBhT4aHnIx3c3SEutnKczxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=waZCYJqeYgKumSSYxiYeZ80g2G7vAMlp1r8P4lrAiP85ktO4VpvPOHyiNN+lWAnouVVzkVnyq9Xy8lxScl/oPZSinRZMkWVJd6zr7/b7bHN2/0i+EBwdaW84JS/ZK2eTlDDmpliRpw4LA66q1wxeomfQF40lTlfgdQzd7l0Yk/U=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7479.namprd04.prod.outlook.com (2603:10b6:510:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Tue, 24 Feb
 2026 13:15:25 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 13:15:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/8] block: remove disk_zone_is_full()
Thread-Topic: [PATCH 3/8] block: remove disk_zone_is_full()
Thread-Index: AQHcoswA1YJeGFWtBkCc04vu7efVqrWR2a0A
Date: Tue, 24 Feb 2026 13:15:25 +0000
Message-ID: <a9a76df7-e7d5-4d89-9264-2e6a979087b6@wdc.com>
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-4-dlemoal@kernel.org>
In-Reply-To: <20260221004411.548482-4-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7479:EE_
x-ms-office365-filtering-correlation-id: 12b6c888-ef23-4815-88cf-08de73a6c5bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDdjTVdtNzZ1NVlBOVRFYU9ndS9wVldVKzJJbWlyQ0E4K0x3UHQwN1IxMkdY?=
 =?utf-8?B?S3V4dTAwYzFXdk1oTjErcEp6VWM1MEZpL3ZGaVFLLzBhUzdiY3hsY2I1K0NG?=
 =?utf-8?B?SXZhQWxiSm5SM1FSU0F2bllGT0k5UTBrTnhzWjhGd1NqS1h5UWVrN240MlB0?=
 =?utf-8?B?dmhCb1lDczFValpPZXNkYm83T1dRUFlJVEZmL2RwNDc3NjgrNzVNWTVXZ1pa?=
 =?utf-8?B?Qmx1V0pCTXMrRGY0OE5sdHlGcnN6QTYybS84eFAwV1FCSnVCSVhvaWNiRTBy?=
 =?utf-8?B?YjkzcFVmM0tpRFNQMzJIZlRqRXlMSjRnVWIrbmE5dVluZk1qcHZMODBianhs?=
 =?utf-8?B?QTRRNkg1NTJpaG5PRE9KMy9OWDdKQ3pxK1R5TFFNcFp3Y0dLVUZGMGhzcXAx?=
 =?utf-8?B?K2VnTFIzVWYwTitPbWErd2VTdHZEVHZIRHkzb2ZKN0M4SVFUSHFMdjFMNXkx?=
 =?utf-8?B?eis5MDB3QnFROG9mZHFqZjhxcS9peFRZVFZoeHI5NFhHRU9MUytITzlFdEJX?=
 =?utf-8?B?WnZleE1lNkJ2N1o0V3RNV1czZTBwQU8vdUFzVDBHN3BjQm14a2lKaWpzWFc1?=
 =?utf-8?B?Y0YvdFFlMjBHSzBZakJObEpvNnk0akU3MlhrSWhmb0FZQkh2OGdmczdBT0R2?=
 =?utf-8?B?MjdtT0FlTjN4SWhXdWhIMjRGdzFVNnlTR053akFCM3AxWnZaNDJhdXJxbEpS?=
 =?utf-8?B?eUFTZHZYZGxhVGR5UThRRlJYS2w1ak5UWjRXVzlPc1lpMVRHNjIvS3MxeFdj?=
 =?utf-8?B?SDd5ZzdaaUhqZHhLWks4UXFkRzVwSFhBQnlkODNjYTNjOWQ5QWVEQWVXblQw?=
 =?utf-8?B?SzJ0U1dmSW9mZnpQb0s4bUQrWHMrZzNNL0J1WkZsQW55STdnOGJnWVYrUGRH?=
 =?utf-8?B?aUJodVlFMVdIaVZsVnM0dHA3TmZ1R2lZeVJLOE1rSUZySERteTFNN1JvR0pK?=
 =?utf-8?B?VHZEU1lKZzFSUmE0OHdTWVhhdEtFcHp3NVVNYU9CdnZuV0drUlF1aXBvRktk?=
 =?utf-8?B?a0xrSUR1T0RYMHZnT3djcjg3L3hFanBwSDNleWltQ21UTE9KQjZ4eTFma1lR?=
 =?utf-8?B?enBsVyt2bUNTNEFFNGMzV1hRRWpiRzhlQ1lBSDd6MEx1a05DT2tBN2tCVTdU?=
 =?utf-8?B?T1A3ZHpEcWlCZDJvK0orSE9LVmlLb2hEWVBIL0Q4dHhkY2NtZmlEQkZTWmUw?=
 =?utf-8?B?Z0JLT1k2MUpJbnJZenJITkZReCtFZG1WcEFtdUFFa2gzeGE5SHRwczRJQkMx?=
 =?utf-8?B?NVdLbDdVenhEeElhdnFOK0xvb0xEdlhhQk04MmlEYTh1MW9LWWU0bGFDWDZx?=
 =?utf-8?B?SWMwS3RwN2pTWCszZGpIa0tNeWxneDUzVklmMzJURWpOWGxUeVhQQ2ZaRVYy?=
 =?utf-8?B?cVFBM0tiVU1QdlE4MkpNdGQwcEZOR0tJdkRzYmN2Ymsrc1VacG84UVF4elo5?=
 =?utf-8?B?TlpmcGRrcDVBZFpDV1RPZjNnLys2b3dvcXhHSy96bkplZ3ZFR0UwR3pjaStW?=
 =?utf-8?B?MDRKWm1SQTRYdlZma1JvcFY2cTk3M2lzRFUzTkNOWGJKOVp4Yi8zeldYOElo?=
 =?utf-8?B?NWNEeEtsNnRUczBYRVkvbno2cGE4emp3ckFESytCVUttZ0pqSjc4REZUeXVM?=
 =?utf-8?B?YmE1NUFyMjdLbUcvV3ZRSit1MFQ0aTJlbDNHRWVYbmRnSk9PWVNPbW1sb3lm?=
 =?utf-8?B?UkNpZml1Q2tUUm5acGRLK2d4b3ZSSHk1L1cxanQybWh5V0YwNHFFdGt0dkRq?=
 =?utf-8?B?YmFQMU43RUVDVUNhTkFha0xhaHFYOGlDMmZ5TlhxNkRUaXpYNkVSSFV4T2Vz?=
 =?utf-8?B?SmNKd2dCUythVnU2VHpBUWY3R0c1NEIyT3ZySmhKSWdUcVlNVElDTXZETWJw?=
 =?utf-8?B?YnhxNlBkY1gvVk5BZjBwa2E2Wk45WXp4NzBhN21lRVFONGF2MGNlYXFQdzNj?=
 =?utf-8?B?aGNKYmNKNUc1VXUxeklUR04zcVNaWFpXcUJGYWJsK3lrWnUrSTR1SEhtNlBW?=
 =?utf-8?B?V0I4YVlYQitVOExERDk3ajhobkRQYTFxcStVc3FxWmc0b25DV3UwckpwRmsx?=
 =?utf-8?B?bmVoekNhcDlaTjIyOC9UbHg0dHJjVGZwNU5yc0o2bllURFdHQUNOSlArYWFR?=
 =?utf-8?B?SFNsWi9lUmhIZDEwdHg4dS9SdWpkMmtlYXFMb2t1bmZPRXFyMW5FVXZTbjJz?=
 =?utf-8?Q?/VVi/Zoi7v6lacbmjEya+co=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGFSNTFYNGo4VERKT1YyZ0xndHNiVk1KUkNSNXFmZndTdllBR3Boa2pGRTNu?=
 =?utf-8?B?RUlqblN1YmorOE1tWERWaHp3NGFITTRtaFYrbWViTFhZQmxFb0p3U2NwTjNZ?=
 =?utf-8?B?RlcydDgyOHpYUXcvQnUwVGp1SjhEZ2FIbUt1cjI1UWFKM2tOZFVxTkZtNFlr?=
 =?utf-8?B?REZ6WFBLYzJTOE9Pc3hzWVFrOWNXc05wT1VGS1RqKzNtU0xJbVdVK0lhdm9v?=
 =?utf-8?B?dUx1clNYSWl3amhqTVFPN1VMQzJra09pMmJadUpUS0w1a2tpaVNLVG1YRFkx?=
 =?utf-8?B?bHFQMHE1WmcvUkYrOU1jLzM3K2Z5RDFUK3BJSVNLN3EwZHUyTi9YKysvemlO?=
 =?utf-8?B?ZjJ0UnRCY2dYdXdQWEpJc2M2YVlpM2hSVHZKVVo0TUJJYyt0cDFGOUhHQUds?=
 =?utf-8?B?a1dybU10UWYxeDdieDFpd2FlLzBWbStZM1Zhd09QZnNieC9vTzVtSGsrMENx?=
 =?utf-8?B?MDJyalRNMGw5ODRXUThsczNxRXl0Sng4STBZV0tpa21qR0RhREtBNnIvbEZu?=
 =?utf-8?B?QS9RQnlFbm45a1Ivb0ZQVDFYR3VXWm8rOTlFZU5TOTB2N0JRZ2txeUFCdkhv?=
 =?utf-8?B?TFFSU3lRakl0SktVTVpKZFhLOTN3NGVRYjB4L1ltZUZRRVE4WWlhS2ZzcFFs?=
 =?utf-8?B?RWlZZDk1cFRMbXJKZHpSY3dFR0tXb1JYcG1SaFF6Nm4ydThxZVNNS0hLdUt1?=
 =?utf-8?B?aFFYZ1Jab2lZM2FRMlpKQURtMUVKbGZaQVNqMzdiQUNCRXpQY2hOYjUvMnhs?=
 =?utf-8?B?YTE1dDE5QmlmVjlhQjE5aTNNQTJwYjZ5d2VoeklDWEljcWxGbmc1cXVOYjRp?=
 =?utf-8?B?Y2VoS0dSQmgrbFo3UHlLSkNIeVhhbVRtVCtLWXFOUUlZazBIZXVUU05GZlRD?=
 =?utf-8?B?VWMyYmV6bVdHMzhqSnpqaEkrdTJjVm85Q1pVSnNSYW4reCtIbFNlbTlJeGxm?=
 =?utf-8?B?MktuaWMvQUdIejA5Lzh1dmw3SVJJeDg2bmhqRUNWTHlFSnFxRjB0ejU1QzBj?=
 =?utf-8?B?VWRqbHkwTC83SlNyVlBtY1lHR1FyUTl6TFJlQ3lsM3d2dXZPbXF3bENhQnRx?=
 =?utf-8?B?VG0rYzhBNkViaGlOdjRwK2s3TDBVYkhnelFBdURFQkU5V2VucVlUdVlBVGZH?=
 =?utf-8?B?S1djOXo2czN4MzBGK1ZYR1VLNTk2dmRmcDAyWStVYjlRZWI1Y2FESWd0RzR1?=
 =?utf-8?B?NE80ZDlGaS9vYURiWlNRWURocDdyUkUwSGZHdUUwWUNGTjNKYW9OTGN5WVN1?=
 =?utf-8?B?c1ZaaXBYSmNUcUs1VUwvQmEwdXI3UVQyaTVqVEQ5QUR3cTBrWWYzUGtaTWpj?=
 =?utf-8?B?RkJ0cG9EdFVkMGV2TndtaGl0MTBPcVNxVnpPUUtaQkhnejlaMXZiYW9PL2Nq?=
 =?utf-8?B?K00zdzU2eXVyczIrcS9qNmdYeVhQYlNYdFpweEJkRE9rWmQxYnJWYy9CRVQv?=
 =?utf-8?B?ejNKNUJNeU9SeUhDUTFiS3UrWW85K1BDL25ZcGppOFRQb0hVYXRXNGdPL1lk?=
 =?utf-8?B?R3N6VmIzYlBaQTZvbVhrYkswY2xIQmQ2UStKeGxuaUpoRndWaHlnajdPbWo1?=
 =?utf-8?B?VW1UV1hLVkY0TVY5SFNIRGcxUUpwa2l6OVMvcVRnODR1aTBoekc1V012eVVE?=
 =?utf-8?B?NHI4LzFDbGFRNDdJQjRveEdIN1ZNRVZ2MkNjMzQ4Q0dZcFo1LzBjaEJodnZP?=
 =?utf-8?B?NytqSGpDU2J3Vk1GajlyaFpwTXB2QXdLcUU2dHhmWVlyODR4Y3h1dnJkZzdD?=
 =?utf-8?B?NjFnTFFONHgweFJKMVl0NFlXdWlZSFhQdEFrNkRCaFBEby9jdVgraVJUVWo4?=
 =?utf-8?B?UHZVaWdDK1hkKzIrTmF3b21EbGswUVdNSHhjTzNuNnBBYmN3MjlMZVoxTlJr?=
 =?utf-8?B?ZTJ6Qk1kcXQzcTBISTRpUkZ1c05ZbURkV2pCZHZINUV1MFYyVEdsR1hoSW9z?=
 =?utf-8?B?dW5ZMG5wN1VERWxBNDNqU0xnSWpnZzhBSUczTitNQVRuQmFjcysvblhLTUdm?=
 =?utf-8?B?TkZGekc0T1hPcDhiVEltZHhVRWQ2OC9BaEl2dHkrWlVVK1NYSnFKdjhQaDdY?=
 =?utf-8?B?MjNMN1Zra3RjSmphUHVYUFdzeXJhSDM1eVNiTldqOTdPeUVCTHFBbGp1QU93?=
 =?utf-8?B?MXZVRE41UEMxZzRmVlVJWWxJUktReVRqMXlEWm9GcW9qc0JsUC9QemdEdlIr?=
 =?utf-8?B?czIvT2dTYXg1ckdTM1VSVHA5Y2VVV2FHeHY3U3k0dU1nRk9TbDVwbGZVR1hi?=
 =?utf-8?B?ekdyVEJ4MlB0WG4wQnUycUNWMGxyMWhSUmY4V1lQMUVDaDJURzR6YTZPaDlr?=
 =?utf-8?B?bm9Bb3RuRWt6QjRoU3R3TTBydTNxL2szUjJKQkdMTnZ1c3cvSDlOWVQvOWNt?=
 =?utf-8?Q?msn18Vj7smjJ1rME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C18D42E7B78BA64FA9673CFA3F233AA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kEtEvszuynSUVR0TYH6u9RhOEAqWB2dky8xdJNabvaXRM9E3G/utRJMYe0UMB3yd49CKOx1cyHcBfO59npY15syTaQWKHEfzc7Ii8w0EvQJ07H+7YW3KHEmtgig5TfDXFd0ybxFihsp97JtNFVAcPDZae8Jj3zRvoO5DnLBG4xb0z7Is0SbnB97fpB8rV2SDWSR7nvkmCLVLBbpN8gt9VtDkesrEZ8WXPLJFxaDxg/LbFfA0n8LPvDsK2WA2NhJCuzWip70X+X6E5KU2K431c/tjJKtC5/FAhqnf+RAgjyNMM0Kqpr1nWiv2Z3Z9sbw4jirCAZEv4VWOIqmrZW0sZWEnER5ETVtGBlxYgMQxmsf/9neknR64oHf+szALPBw+QY5Ae70EMUD2OWHtSBKjQMY/AcHJZWhL83ZI46GiArteCVMqeFIj206fcgIVcYsWjhBq8N0DU/11PlUT1wUXRiokCiiH59fFBdBirBWz1aCEhl2Ph6V3qoViDT/AKtvnDncpZwG+6GXIY7CVzsr4g1ZgxSOrsSewlcVBVylloXQUsV4r34p0O71T49Nk48CP8yknLiqKg7psRCNzIqaWAPpeEPwNgkk1WrfB9VjCUhs8R0XhFM0nCxAvasuwWN6Y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b6c888-ef23-4815-88cf-08de73a6c5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 13:15:25.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGaBQPmeR+h3h2feaWRZS0CoLzm4N2RQnmqtLDGHWJeCoJj91xwfVloXL4I5FO4sEKYLdjcLOn3uSkDgld78/3e4Hy9dUHYhLQYMaXTbdtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7479

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
