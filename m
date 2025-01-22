Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAA214237
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567935; cv=fail; b=Wr+il/EEgTNbMjQCKn+L34sTFiQX5KT8wqneEKByPRW8NYQeTSZw4wSpRd0gPlSTsnPoHVe+TKJH5zu4nHpLZKczY3ArddSoFbuHxigxFBap0fpB4MWQTrodlt3L39LBl0jbTKL7fGFss7hq6in+YIWiniFoRbsRYXecXx/NWcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567935; c=relaxed/simple;
	bh=r2LkUg/elgFzvo0FOBr3H/bJlut0PiHE8i+TYrHwu4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlGIH9cgnmc0NvCcWrFNj8ygrVASPt0W7U1HtlkuCEr09QG+7bGjluztd+i/O6gUJljB61435RSECDKOTIHJM96WXpeBscwMvqC8gVjL3zZ4UxTD3RcI/CDYOiYwvm76OVb7ciYxdMFv+TqamOqJ+ePWbnLxAJDTaBRIEt2yv28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lFa4d0Pg; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lFa4d0Pg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpcE+SC2565G1A4g+fcRH2k40jddPD9VNzAOA5S2I1JuDqJwiknQ8PDj9AHJAtNa+l6Qs0Yo7UgzClLFpYrwfvS9WWSzucCfE0IwOgtf9rkeWm4G+z08VOMYjpKXbJI5T6JKmYvp2ZWHu/wZD8OYsb29BV3kGT+GY7aicp0VudZoLnoSU/ImLCimI4aZQO0TqflFKJxpLTthMK66g2Hhgd3bi5WSWAuJlnnr0Zz6F9KWjc6a116EIzCKiYvmV8o4S6GQwCxmr8PZN91rzoTuLNURfHt9WWX8ZNpBmxQFA4r58gkrrvg4u0OiRfFFr67l4p/cz8tJySokVlVvIqmYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2LkUg/elgFzvo0FOBr3H/bJlut0PiHE8i+TYrHwu4w=;
 b=dFMLA6mQuIqlK4wJK9D70auGXHyDF8jCB4dSSjzLhpV2E/8hpeY1sU2Fhh22wZfxhkVHy1G+iPcILeUEdKmFYBjsC6cWk9adP4/bOl9gpGMkk4eNNemtvjv2Le793Rsx3ONAt2vARNCah90IzDtJNfTdjMRAea8JuDCmRS79NtBL5Q99hKeATuz55gZsdlpxrE/K5+73P2utBcBnKMAVH99lKJUfo1kPtRWT8pGbSsrLX9dpHy/DOD0UQalj9fPIBpMLbvAuJqBVcesBoLzoBRDN/P9Z5UuGoH04vO0GjDul+FKlZHJUbKEVY0J1uQfM2y1UefwxT06SF8DLM4E+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2LkUg/elgFzvo0FOBr3H/bJlut0PiHE8i+TYrHwu4w=;
 b=lFa4d0Pgtjt0zwrIGiApgYSNmFdMNzEJZPLlpirsBe0e/QprCPehiIcZM73187heWLfulGbsQTx/FcFujsOFClsGRewP3sY+Dd5pR2k6q73QI4s5sMAX6ViGFwYTls8xV8/8zNU+0uthV+JTEM/3iqkws4K7gZY+46OcCMbBAUU=
Received: from IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 17:45:29 +0000
Received: from IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f]) by IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 17:45:29 +0000
From: "Boyer, Andrew" <Andrew.Boyer@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Boyer, Andrew" <Andrew.Boyer@amd.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez
	<eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>, "Hubbe, Allen"
	<Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Thread-Topic: [PATCH] virtio_blk: always post notifications under the lock
Thread-Index: AQHbYTG5PPtb1U4eCUarxpU24+zL4bMOWgAAgAAcSQCAFH+oAIAACC0AgAAqSwA=
Date: Wed, 22 Jan 2025 17:45:28 +0000
Message-ID: <60290C9C-8975-4D7C-B1A2-8781EA5633AB@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <20250122100622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250122100622-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8311:EE_|CY8PR12MB7146:EE_
x-ms-office365-filtering-correlation-id: 637208cd-de2d-44b2-e7fb-08dd3b0c8f7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXI5UGRnQndYbU1tdDdab0Ixakk2STlCVTkvYXRWRE9BS2xxRVNOZjhFLzRi?=
 =?utf-8?B?RFVvd3lIUngvakNxdUxGTVFDSis4aEdxclY0RmVtNEVyM3JRSDRLSG9KQ1ly?=
 =?utf-8?B?QmgwMklCNS8rMEdjOHBITTFRdTVWdVBnb2tYc1ZBcUkyVGxUeWN1N3Fldi9q?=
 =?utf-8?B?N1NybHMyNlpPTlpOZ2ZZQmZqR0UzQWQwTklub1ZwdGh5NXVIZFF0Wmtpekdz?=
 =?utf-8?B?ZmdodXJDTEZqNHc2NkVwNW5qd1lJMlQvR01DTUw3Lzg5czdvOVZaRXJscUtD?=
 =?utf-8?B?RHREK3JrbzgwMGNtY3NWUjJuU3F1MlNuN3RxakhCNEZuMUlKZWc1ZzFGWk1r?=
 =?utf-8?B?cDhpVXp4alVGSDRkemt0V3JBUnpaMFcvUklBZW5pbnVGSFJBMG82TWdvVnho?=
 =?utf-8?B?Wnk2M0FLdlV0U3RHRDFRNXErQlBFRnIzRUdPRUxWaWExMDQ1eEFsOC96M0R4?=
 =?utf-8?B?bkQycXFxRmZ2QnRBQ0ZrQ2V2aW1kWmpBT0t0L3hyVks5S2NFRW80aktVNWta?=
 =?utf-8?B?cU1pTjhDVTNFcmtzNEk3TCtBZ2t5RGpUTFR0TWdBVUpQOU5xS3JBVm5YWE93?=
 =?utf-8?B?ZjNYcnQwSThMYWVzd3c1cURseE5FR3JRV2J3NG5rQVpIL0p6WDZ2dS9ieklJ?=
 =?utf-8?B?dTEzWjJ5R2V1emx4NVBSY0dZWjUzS2tuMGhDVjl1Tng4M3dPeUc0ZHZmQUMw?=
 =?utf-8?B?MTVLZ0cvUEcvTDJaM3FVNDJjZDgydjk1cTVqb0l0MHIzR1RPejVCRjRBbEhP?=
 =?utf-8?B?N1lUaGFtaWQ5alduNFNqM1YvV1lXMERiYUtIWWd1bTNqMWV2MzdIRWxjcTBS?=
 =?utf-8?B?UXhpa3ZvVXNDZmcxaUlEWFJGeGp5RWdkVTg5ZDZ3OWVXRnlsd1I5SmViSFRr?=
 =?utf-8?B?dkJoY2tsTjVLNlNScmpvSDNEQWt5VGhjVEJWM0ErcGg1VHBDWlhqVUx4NkU3?=
 =?utf-8?B?VU9HVHIzWUdpRm1hZHJFa1h5c1JmNTBtdm0rQWk0eDlvL0E0ZzJ5UkozQVZG?=
 =?utf-8?B?a1pPOTltK2lVVGx0Z2tEbWNaOTZpRThSSytMY3lFc043VUdWS2VCTENqa1lN?=
 =?utf-8?B?NUVQS0IvWXdWS2JObm0xZUg1UjJUL0tkRHVXOUI0UW9mR0xWRngvdkMzcGxR?=
 =?utf-8?B?ZkNtSzZMcG0xVmZMSFd1NlpHeHQ1OEQxZkN2TGJzaGp1U2ZVdmFaQzRtdyty?=
 =?utf-8?B?bDVOdFJuL3JOZlh4UnluRVUxcktSMDZYT0tWRFliYXkvVTZhWnBRRjhPUlg0?=
 =?utf-8?B?VFBYK1JmTXUyZmZub0R4UkJ5Q2JYWU9xRmNjOG9lSDhLOXBuQktYNXlWaTFW?=
 =?utf-8?B?dWJGaVE1bTJFZTlLYmUvQjdQMEsybnZLdTBYT3JhNkorVERqN1hjZ2Iza2xI?=
 =?utf-8?B?VS8zclV6YUdwTUpzcFdCcVgrZ25MQitXelN6ek5yQmtjS3BQcEhKbmNsWXNu?=
 =?utf-8?B?d2tKVjFiazdYaDcrSCs4K3dTN1Zxb1pic3IwQ0pwNG80TEM4RkhyRVllY2gv?=
 =?utf-8?B?RGRUcUllK2RENmxHM09BT0lUOTBGaitaaENaa1M2R3hpUHZzNVhGUElNYkht?=
 =?utf-8?B?NDBCaXNQSkFlOEVBaEVNZjNvbWNEMExVN3RDVHlSMjNLeFc4N1RybHROWTZM?=
 =?utf-8?B?K2JPWktOZ0Y2VWw3ODZrdE4wSDMvMGVpTTRvaFcwRTlGc0twaG02ZTNnRjkx?=
 =?utf-8?B?Ly90L21aZnJMZDhtK0ZRMlFrTDRLa2Q4LzhycUprZEQ2Y2ZscTdsb1RKa1lO?=
 =?utf-8?B?a1Q5R0tGeXlNUXpQTFhUMGowTEFlNm9JZFVrNXdxL1Z3U1BBa0hSQ1JkQUhN?=
 =?utf-8?B?RjN2TDJjbWVXUGFKQ3p2dEhaaG9qdDhQMDhiRVFjd0w1bXNCY1NZMXNFWWt3?=
 =?utf-8?B?cFpxZE1Oem1zVmlSYnVmZmp4cEVrS0VuYXRlQkNUYnpnODJsUkl5aWlUUkNC?=
 =?utf-8?Q?i4Ke0KKV1ph0FbqQs33iwNctAtqtamx3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDJyczVDbng5ZCsrcXpOeU5jZHg4cFUrZEo3dThhbnlzcTkwNDRyKytIY2FB?=
 =?utf-8?B?NDE5WUFFdWRoT0tDZlZHS0RmdzNmRGNEckd1NUpOa2VrMmJrbjBrYW9ueFJs?=
 =?utf-8?B?TkwxanVLR0pUcnhlWk56dU1KU3lFQW1pTU9RQVA4a0R3bUpCZENaeUZnZVNI?=
 =?utf-8?B?NTFkSFZpR0dZOUpUU20xTEc3RGNqbkFGUDdRNXhtNEF3ZUsxcStxdHBBK2Jz?=
 =?utf-8?B?RW1hdVNEU0J3bjJwejFjTkw0SGdFZmh0U09wTG1ObWhoS2Y3SmJaWlU2eGpa?=
 =?utf-8?B?K21yWFZxNTB1My9hQkhHVndYMVZXdmYxN1g5ZWZ5TUZGcDlpeUZ1TFpuRVZO?=
 =?utf-8?B?L2RmT3M0U3BKcjczM0c3RHM0Njl5ckwvMGEzUFFVb2hMR0VMMXFocWFQTUhQ?=
 =?utf-8?B?eFFJVk1DeDFQWFhRQlhkZUNDZ0hRajllNFI1QTl0Rk1ZaGNSQTNJa21FZVdk?=
 =?utf-8?B?UG9XcDJDRXY4cjF5TEgwbTBqQkEyeFZKV2FMNVJ3bm5CZk9qOGFPdnBXdmlL?=
 =?utf-8?B?dmZSUVdlalo3em9xUVRFOWhUUDRSODFLT1dSMUQwNjFFUGJ6dGg1QTl5TGZ0?=
 =?utf-8?B?c3ZoSHRQT2IrNlVQYmpDV0JSMmlSWHdjUzExMTJjNmZJckZpbE9JWXVTRzUx?=
 =?utf-8?B?M25XbHZoVUh6Mm9uWUpsU0FyN3A2N09oL0dlM3Y3Szk0ZEcrYlpRT2ZsQXZN?=
 =?utf-8?B?Qlh2Vk1nbXpGdmlLZnFhWlRQYTVpd1h6eXl1SnBXYzgxZGg5dnpHVjBablVl?=
 =?utf-8?B?MENkV1BCdWtUSE1lTDFEanFEcVlxVDYrNG1wWFdHaG5jckY5QzlkY255YWhp?=
 =?utf-8?B?bWhLSFR3VzR4dXdkUGhKQkdhd1lSby9USE9NNC9iYXYyaklhUTB4ejY1OXhH?=
 =?utf-8?B?MUlQbHRENkIxdFR6em50Tk9DMFBPYmVxM2JLd1pCcEVXTENPT3NXbEJkTndO?=
 =?utf-8?B?SUVKZEt2Mk1jUlBvcHVLVVNxVldtWFM0SzgyejFRaXBHa0NEamIxTGFCajhw?=
 =?utf-8?B?bzVBbWZVVkpWblRUNzh2QnEwRk5scEljbVo1ZUVCak82djNxTmlsNGw2VDhB?=
 =?utf-8?B?N0NxSDgyYWloeHlPZGdHSmZBQWpQQW8vQjNwSTU0R3VSSjExWGRXNGV1YVh0?=
 =?utf-8?B?VlkzekxKZVpiVEQ3TFdaa1ZmOGpPcCtaNndNazc0MjZMVGtJM1B1RW9VTWg1?=
 =?utf-8?B?eWlBSHZpYUU2aUovVks4T3R3enJNVXFjaStVSjdhNlNPWmU2M2JoczVkc0hx?=
 =?utf-8?B?ekNsQk1SaTBVZm1meUl6b2dqS0o0V3o5OUdVOW1yQWp4cXVWdGZWNWd1YjhU?=
 =?utf-8?B?WTRITUFFUXhkZml1SmZWSUpaeGdZRVhCWDlQSGg5eFZrTis1aWljb21mSTM0?=
 =?utf-8?B?QXcwcHRldWNsMzlpeXl0WlZjZEhJb2lYZUlnZ1hrc25jWlBYSnNINnRDcE15?=
 =?utf-8?B?WTlrdG9jUUg0N0FIZjRFbTE0MkJIZ0JVSWFXaG1DT29hZkQ4blFmTnpzdmhz?=
 =?utf-8?B?ck1abTlGSjZocWFhR3l0VWprSllQUE5Pc2JCRjFTa0pZNXY2eDV6V0dhYitT?=
 =?utf-8?B?eFZBVm1kQXhqUFVEUlI2NUVTL3IyODVROUhpMDVUVXRMMlZaMDhFbks3WmpP?=
 =?utf-8?B?ZzJNTUJNWGpjb1h3TjJlWHMraFBWRkV0VlJNaTZoWlpoZENXb2xERUFCcnhi?=
 =?utf-8?B?MW5IKzdTaGlYVnc2V2dRRGhxRUdMM2tPa2V5bTFOSWZUakEwVUpiN2JONW54?=
 =?utf-8?B?Q0hOMnVLdlhTT0V5S0hKK1ZUczFDL0grS0w0VU9vUG0wRzBoZTljYWVHbm1J?=
 =?utf-8?B?YVhkTTVVaWxvUWFjNUcrNzJsTWZ3WlZnQi9neGVFeUR6THNsSXp6VjVZRXFv?=
 =?utf-8?B?VE9lM0huS0lBQUhSTlYxVXBGN2JpSVZvTkNKeGZIVmVzZGRHeFRBT3dXZkVC?=
 =?utf-8?B?cldSMnBFWFU4dk15Q0dyMENRKzNDcTJJKzdLZDAzSmZuWFFOY0VYVVVVUGNN?=
 =?utf-8?B?Nk1SdnVqZ0lBekR4RVpucW8yYkZ4V3pVc0VsVGREM0hNbUNjMlRraHVQVmd4?=
 =?utf-8?B?MFQ1SUVYajZwcFNQKzhZYUZodHlkWEo0TThCWG94S3ladkErV0FVT0RUTzFN?=
 =?utf-8?Q?F9c5qDn9CMtMZRRh13oac0+Hs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F661EDC8616E1341A31118A88E3CBB7B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637208cd-de2d-44b2-e7fb-08dd3b0c8f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 17:45:28.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOqCWCrfKRsz4Qq48RVnBLAGMfd5kMYYIUIpXrA7aJdltpiDMsGIrkpUCe4FAU1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

DQoNCj4gT24gSmFuIDIyLCAyMDI1LCBhdCAxMDoxM+KAr0FNLCBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+
IA0KPiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCAwMjo0NDo1MFBNICswMDAwLCBCb3llciwgQW5k
cmV3IHdyb3RlOg0KPj4gDQo+PiANCj4+ICAgIE9uIEphbiA5LCAyMDI1LCBhdCA4OjQy4oCvQU0s
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gDQo+PiAgICBP
biBUaHUsIEphbiAwOSwgMjAyNSBhdCAwMTowMToyMFBNICswMTAwLCBDaHJpc3RpYW4gQm9ybnRy
YWVnZXIgd3JvdGU6DQo+PiANCj4+IA0KPj4gICAgICAgIEFtIDA3LjAxLjI1IHVtIDE5OjI1IHNj
aHJpZWIgQW5kcmV3IEJveWVyOg0KPj4gDQo+PiAgICAgICAgICAgIENvbW1pdCBhZjhlY2VjZGEx
ODUgKCJ2aXJ0aW86IGFkZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQQ0KPj4gICAgICAgICAg
ICBmZWF0dXJlDQo+PiAgICAgICAgICAgIHN1cHBvcnQiKSBhZGRlZCBub3RpZmljYXRpb24gZGF0
YSBzdXBwb3J0IHRvIHRoZSBjb3JlIHZpcnRpbyBkcml2ZXINCj4+ICAgICAgICAgICAgY29kZS4g
V2hlbiB0aGlzIGZlYXR1cmUgaXMgZW5hYmxlZCwgdGhlIG5vdGlmaWNhdGlvbiBpbmNsdWRlcyB0
aGUNCj4+ICAgICAgICAgICAgdXBkYXRlZCBwcm9kdWNlciBpbmRleCBmb3IgdGhlIHF1ZXVlLiBU
aHVzIGl0IGlzIG5vdyBjcml0aWNhbCB0aGF0DQo+PiAgICAgICAgICAgIG5vdGlmaWNhdGlvbnMg
YXJyaXZlIGluIG9yZGVyLg0KPj4gDQo+PiAgICAgICAgICAgIFRoZSB2aXJ0aW9fYmxrIGRyaXZl
ciBoYXMgaGlzdG9yaWNhbGx5IG5vdCB3b3JyaWVkIGFib3V0DQo+PiAgICAgICAgICAgIG5vdGlm
aWNhdGlvbg0KPj4gICAgICAgICAgICBvcmRlcmluZy4gTW9kaWZ5IGl0IHNvIHRoYXQgdGhlIHBy
ZXBhcmUgYW5kIGtpY2sgc3RlcHMgYXJlIGJvdGgNCj4+ICAgICAgICAgICAgZG9uZQ0KPj4gICAg
ICAgICAgICB1bmRlciB0aGUgdnEgbG9jay4NCj4+IA0KPj4gICAgICAgICAgICBTaWduZWQtb2Zm
LWJ5OiBBbmRyZXcgQm95ZXIgPGFuZHJldy5ib3llckBhbWQuY29tPg0KPj4gICAgICAgICAgICBS
ZXZpZXdlZC1ieTogQnJldHQgQ3JlZWxleSA8YnJldHQuY3JlZWxleUBhbWQuY29tPg0KPj4gICAg
ICAgICAgICBGaXhlczogYWY4ZWNlY2RhMTg1ICgidmlydGlvOiBhZGQgVklSVElPX0ZfTk9USUZJ
Q0FUSU9OX0RBVEENCj4+ICAgICAgICAgICAgZmVhdHVyZSBzdXBwb3J0IikNCj4+ICAgICAgICAg
ICAgQ2M6IFZpa3RvciBQcnV0eWFub3YgPHZpa3RvckBkYXluaXguY29tPg0KPj4gICAgICAgICAg
ICBDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2DQo+PiAgICAgICAgICAgIENjOiBs
aW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcNCj4+ICAgICAgICAgICAgLS0tDQo+PiAgICAgICAg
ICAgICBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDE5ICsrKystLS0tLS0tLS0tLS0tLS0N
Cj4+ICAgICAgICAgICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQ0KPj4gDQo+PiAgICAgICAgICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3Zp
cnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2svDQo+PiAgICAgICAgICAgIHZpcnRpb19ibGsuYw0K
Pj4gICAgICAgICAgICBpbmRleCAzZWZlMzc4ZjEzODYuLjE0ZDllNjZiYjg0NCAxMDA2NDQNCj4+
ICAgICAgICAgICAgLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4+ICAgICAgICAg
ICAgKysrIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4+ICAgICAgICAgICAgQEAgLTM3
OSwxNCArMzc5LDEwIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19jb21taXRfcnFzKHN0cnVjdA0KPj4g
ICAgICAgICAgICBibGtfbXFfaHdfY3R4ICpoY3R4KQ0KPj4gICAgICAgICAgICAgew0KPj4gICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2JsayAqdmJsayA9IGhjdHgtPnF1ZXVlLT5xdWV1ZWRh
dGE7DQo+PiAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fYmxrX3ZxICp2cSA9ICZ2YmxrLT52
cXNbaGN0eC0+cXVldWVfbnVtXTsNCj4+ICAgICAgICAgICAgLSAgIGJvb2wga2ljazsNCj4+ICAg
ICAgICAgICAgICAgc3Bpbl9sb2NrX2lycSgmdnEtPmxvY2spOw0KPj4gICAgICAgICAgICAtICAg
a2ljayA9IHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUodnEtPnZxKTsNCj4+ICAgICAgICAgICAgKyAg
IHZpcnRxdWV1ZV9raWNrKHZxLT52cSk7DQo+PiAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2ly
cSgmdnEtPmxvY2spOw0KPj4gICAgICAgICAgICAtDQo+PiAgICAgICAgICAgIC0gICBpZiAoa2lj
aykNCj4+ICAgICAgICAgICAgLSAgICAgICAgICAgdmlydHF1ZXVlX25vdGlmeSh2cS0+dnEpOw0K
Pj4gICAgICAgICAgICAgfQ0KPj4gDQo+PiANCj4+ICAgICAgICBJIHdvdWxkIGFzc3VtZSB0aGlz
IHdpbGwgYmUgYSBwZXJmb3JtYW5jZSBuaWdodG1hcmUgZm9yIG5vcm1hbCBJTy4NCj4+IA0KPj4g
DQo+PiANCj4+IA0KPj4gSGVsbG8gTWljaGFlbCBhbmQgQ2hyaXN0aWFuIGFuZCBKYXNvbiwNCj4+
IFRoYW5rIHlvdSBmb3IgdGFraW5nIGEgbG9vay4NCj4+IA0KPj4gSXMgdGhlIHBlcmZvcm1hbmNl
IGNvbmNlcm4gdGhhdCB0aGUgdm1leGl0IG1pZ2h0IGxlYWQgdG8gdGhlIHVuZGVybHlpbmcgdmly
dHVhbA0KPj4gc3RvcmFnZSBzdGFjayBkb2luZyB0aGUgd29yayBpbW1lZGlhdGVseT8gQW55IG90
aGVyIGpvYiBwb3N0aW5nIHRvIHRoZSBzYW1lDQo+PiBxdWV1ZSB3b3VsZCBwcmVzdW1hYmx5IGJl
IGJsb2NrZWQgb24gYSB2bWV4aXQgd2hlbiBpdCBnb2VzIHRvIGF0dGVtcHQgaXRzIG93bg0KPj4g
bm90aWZpY2F0aW9uLiBUaGF0IHdvdWxkIGJlIGFsbW9zdCB0aGUgc2FtZSBhcyBoYXZpbmcgdGhl
IG90aGVyIGpvYiBibG9jayBvbiBhDQo+PiBsb2NrIGR1cmluZyB0aGUgb3BlcmF0aW9uLCBhbHRo
b3VnaCBJIGd1ZXNzIGlmIHlvdSBhcmUgc2tpcHBpbmcgbm90aWZpY2F0aW9ucw0KPj4gc29tZWhv
dyBpdCB3b3VsZCBsb29rIGRpZmZlcmVudC4NCj4+IA0KPj4gSSBkb24ndCBoYXZlIGFueSBzb3J0
IG9mIHNldHVwIHdoZXJlIEkgY2FuIHRyeSBpdCBidXQgSSB3b3VsZCBhcHByZWNpYXRlIGl0IGlm
DQo+PiBzb21lb25lIGVsc2UgY291bGQuDQo+PiANCj4+IA0KPj4gICAgSG1tLiBOb3QgZ29vZCwg
bm90aWZ5IGNhbiBiZSB2ZXJ5IHNsb3csIGhvbGRpbmcgYSBsb2NrIGlzIGEgYmFkIGlkZWEuDQo+
PiAgICBCYXNpY2FsbHksIHZpcnRxdWV1ZV9ub3RpZnkgbXVzdCB3b3JrIG91c2lkZSBvZiBsb2Nr
cywgdGhpcw0KPj4gICAgbWVhbnMgYWY4ZWNlY2RhMTg1IGlzIGJyb2tlbiBhbmQgd2UgZGlkIG5v
dCBub3RpY2UuDQo+PiANCj4+ICAgIExldCdzIGZpeCBpdCBwbGVhc2UuDQo+PiANCj4+IA0KPj4g
V2l0aCBzbyBtYW55IGJyb2tlbiBrZXJuZWxzIGFscmVhZHkgaW4gdGhlIHdpbGQsIEkgdGhpbmsg
ZGlzYWJsaW5nDQo+PiBGX05PVElGSUNBVElPTl9EQVRBIGZvciB2aXJ0aW8tYmxrIHdvdWxkIGJl
IGEgcmVhc29uYWJsZSBzb2x1dGlvbi4NCj4gDQo+IFNvbWUgZGV2aWNlcyBtaWdodCBmYWlsIGZl
YXR1cmUgbmVnb3RpYXRpb24gdGhlbi4NCj4gSSBhbSBub3Qgc3VyZSB0aGV5IGFyZSBicm9rZW4s
IGRldmljZXMgbWlnaHQgc2ltcGx5IGJlIGFibGUgdG8NCj4gaGFuZGxlIG91dCBvZiBvcmRlciB2
YWx1ZXMuDQo+IA0KDQpBIGRyaXZlciB3aGljaCBkb2VzIG5vdCBzdXBwb3J0IEZfTk9USUZJQ0FU
SU9OX0RBVEEgc2hvdWxkIGp1c3QgY2xlYXIgdGhhdCBiaXQuIFN1cmVseSBkZXZpY2VzIHdoaWNo
IHN1cHBvcnQgaXQgd291bGQgYWxzbyBzdXBwb3J0IG5vdCBlbmFibGluZyBpdD8gT3RoZXJ3aXNl
IHByZS02LjQga2VybmVscyB3b3VsZG4ndCB3b3JrIGF0IGFsbC4NCg0KPiANCj4+IA0KPj4gICAg
VHJ5IHNvbWUga2luZCBvZiBjb21wYXJlIGFuZCBzd2FwIHNjaGVtZSB3aGVyZSB3ZSBkZXRlY3Qg
dGhhdCBpbmRleA0KPj4gICAgd2FzIHVwZGF0ZWQgc2luY2U/IFdpbGwgYWxsb3cgc2tpcHBpbmcg
YSBub3RpZmljYXRpb24sIHRvby4NCj4+IA0KPj4gDQo+PiBEbyB5b3UgaGF2ZSBhbiBpZGVhIG9m
IGhvdyB0aGlzIG1pZ2h0IGJlIGRvbmU/IEFueXRoaW5nIEkndmUgY29tZSB1cCB3aXRoDQo+PiBp
bnZvbHZlcyBhIGxvY2suDQo+PiANCj4+IFdvdWxkIGl0IGJlIGRvYWJsZSB0byBoYXZlIGEgbG9j
ayBmb3IgdGhlIHZxIG1hbmFnZW1lbnQgc3R1ZmYNCj4+IGFuZCBhIHNlY29uZCBvbmUgdG8gcG9z
dCBub3RpZmljYXRpb25zPw0KPiANCj4gDQo+IGFuZCBvbmx5IGZvciB3aGVuIEZfTk9USUZJQ0FU
SU9OX0RBVEEgaXMgc2V0LiBub3QgdGVycmlibGUgb2sgSSB0aGluay4NCj4gDQo+PiANCj4+ICAg
IEFNRCBndXlzLCBjYW4ndCBkZXZpY2Ugc3Vydml2ZSB3aXRoIHJlb3JkZXJlZCBub3RpZmljYXRp
b25zPw0KPj4gICAgQmFzaWNhbGx5IGp1c3QgZHJvcCBhIG5vdGlmaWNhdGlvbiBpZiB5b3Ugc2Vl
IGluZGV4DQo+PiAgICBnb2luZyBiYWNrPw0KPj4gDQo+PiANCj4+IFRoaXMgaXMgdGhlIGRyaXZl
ciBseWluZyB0byB1cyBhYm91dCB0aGUgc3RhdGUgb2YgdGhlIHF1ZXVlOyBpdCdzIG5vdCBnb2lu
ZyB0bw0KPj4gYmUgcG9zc2libGUgZm9yIHVzIHRvIHdvcmsgYXJvdW5kIGl0IGluIGhhcmR3YXJl
LiBGb3Igc3RhcnRlcnMsIGhvdyB3b3VsZCB3ZQ0KPj4gZGV0ZWN0IHF1ZXVlIHdyYXAgYXJvdW5k
Pw0KPj4gDQo+PiBUaGFuayB5b3UsDQo+PiBBbmRyZXcNCj4gDQo+IFRoZSBpbmRleCBpcyBhIHJ1
bm5pbmcgdmFsdWUgZm9yIHNwbGl0LCBmb3Igd3JhcCBhcm91bmRzLCB0aGVyZSBpcw0KPiBhIHNw
ZWNpYWwgYml0IGZvciB0aGF0LiBObz8NCj4gDQoNClRoaXMgaXMgYSBoYXJkd2FyZSBibG9jayB1
c2VkIGZvciBtYW55IGRpZmZlcmVudCBpbnRlcmZhY2VzIGFuZCBkZXZpY2VzLiBXaGVuIHRoZSBu
b3RpZmljYXRpb24gd3JpdGUgY29tZXMgdGhyb3VnaCwgdGhlIGRvb3JiZWxsIGJsb2NrIHVwZGF0
ZXMgdGhlIHF1ZXVlIHN0YXRlIGFuZCBzY2hlZHVsZXMgdGhlIHF1ZXVlIGZvciB3b3JrLiBJZiBh
IHNlY29uZCBub3RpZmljYXRpb24gY29tZXMgaW4gYW5kIG92ZXJ3cml0ZXMgdGhhdCB1cGRhdGUg
YmVmb3JlIHRoZSBxdWV1ZSBpcyBhYmxlIHRvIHJ1biAoZ29pbmcgYmFja3dhcmRzIGJ1dCBub3Qg
d3JhcHBpbmcpLCB3ZSdsbCBoYXZlIG5vIHdheSBvZiBkZXRlY3RpbmcgaXQuDQoNCi1BbmRyZXcN
Cg0K
