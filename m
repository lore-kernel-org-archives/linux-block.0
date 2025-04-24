Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E2291155
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521651; cv=fail; b=S8O9qGlhiRK1kPj2FwWrYno1FItBlDBnx5CKj4AQ0XzVI5Y6qNZLNL24Oa7qt65kbtst97aY4rIULkbRBlObBAPYLL6KiQszUIrgd7q0apatuU693T1Ry2u18we58ZICrLeVhSORLCnLnOEhpOvgvpvaIrNSp5nd+0m3gxv1yko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521651; c=relaxed/simple;
	bh=jzWcbnUgVYc7kLZUHXHqDMwDwsIFodQR8lYIAKFpxzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VcraBkTYJ1GzMpAAVk4lKnQEfAZGOLjn6FUiKjyNCuMXmdQcCWU/Kk5P1XHSw3FpyKSYlrEPRfhvbkpLwC0X/3WAwLISeCtvj6m8Mwqshm15LYXOFyS6hS6em1MF0Txe7HNW+GvM9xvo8PfIqRcWwBEZvTWKxM93DFOi3KwP6x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MmQbMaQH; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MmQbMaQH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBumRiRy8bNK2QEUXjuhlJDuD7nAXufpF/9HdxJMpNejy/oA61gKhfXmi7BFaMTeFqR79+rnrcVTKabrDLxIB+fNFQqRCI/CoSkelDW+BgaJHEqspHC5cP3L1iYV1S7/8hLGw1WpPM3Opa4hvFAwKjfjrzezO3LzvRyE59PT+rcyLkKI+qDWcW+X6KAy2sTefGDDpqK5bZnRPekYRGv34eumhsiJPp65mCfOhT2bxeLKBXoGxozapdCbEyJkzuq/I0PccGR7iQrzjikX00wQ8XcxBQGIKiQ02QsSOs+wwC4gyFdzhuMcU65nb3I8pxyVDVKmZsa3lvUxD9IzVs248g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzWcbnUgVYc7kLZUHXHqDMwDwsIFodQR8lYIAKFpxzc=;
 b=lkWxQVpgmsZFtqMZFled0Zt9ZddkY58MsuVnR+kNUMweBVFvC/ZxV83HrkoFpJMFWP9ta9/QsJQt1wzy+AqjwI79P5RH8EZA8L1YdQ3tIjQlF24XjMEbQodPU3dHoGk8lPZeaZ17m2vz6xKO30gy+J6bRn1OrFZ2GKalomk3cstQDBjWg3fEN31Yq4uw9K9HeAoUc54IHkJBOpihunhmy71CsQvpqCf2AglyrU800NzpBbw2Ppoh/8f3NsydR6u6nVVeW5NFIFU+QwKb5PDHCVi52THWa+p0lgySHrbHTaZH42+EQXrsTmKK+aa5Govp8sUS8ZbFsRq8l+hBbTcavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzWcbnUgVYc7kLZUHXHqDMwDwsIFodQR8lYIAKFpxzc=;
 b=MmQbMaQHD/NZhjs+nRLeI8uN4S3dWyB55Yp/dBTlowP/WrdZf6Wn5an39mmGnxZwM1JN8uf7Z8p4FMeUJqfE0hooqOFL4dMl7cSQYYiN708wiSALOE9/5YvRQWfGvNiDJXVECOfAWFRV43Mapz6LdduvRggQjnJWW6ZVeq5UnFLh97oeIBkXWkoOFHXHubALo1j+ixIyCyssCEcoXozTUDLBpF7LN7MAbC+xOBvlwcrAehQg7KZtr4aiaAG8iNZ/LlF2GY020sPFUk4U7Au5Hf+dW9SeWJNIeZPPdBS1e340LUYsaOWVGG5GjYliXdRxrwOBeS7QszwD0O3h3ywSRA==
Received: from IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 19:07:26 +0000
Received: from IA1PR12MB6067.namprd12.prod.outlook.com
 ([fe80::ec5:d70e:98de:e13d]) by IA1PR12MB6067.namprd12.prod.outlook.com
 ([fe80::ec5:d70e:98de:e13d%3]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 19:07:26 +0000
From: Ofer Oshri <ofer@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, Jared Holzman <jholzman@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>, Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi
	<omril@nvidia.com>
Subject: Re: ublk: RFC fetch_req_multishot
Thread-Topic: ublk: RFC fetch_req_multishot
Thread-Index: AQHbtUTtH3Tf0nZGzUqlIHCxf+6T5rOzIteAgAAKjAk=
Date: Thu, 24 Apr 2025 19:07:26 +0000
Message-ID:
 <IA1PR12MB60674CB0DC7A259099B0F400B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
References:
 <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
In-Reply-To:
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6067:EE_|MN2PR12MB4223:EE_
x-ms-office365-filtering-correlation-id: 5cda5f39-782f-4705-4113-08dd836340a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUdOZkpaWjIyZUV6Y0Yvd2RiWmdGdTRpZHIrYzZINkU3MlZ0OFRpVDYwazZN?=
 =?utf-8?B?TGRITGlyTDgxOXRJVmJ2YkJtOXBmVlRMNm5qSkIvaE9VUm8rMlg1WmQ2dHp4?=
 =?utf-8?B?eDlKMHZCWTROVEQ0U04yUEZLdlBSZzJsSDZhbFY1Si9VMmx3U3l0Qk52bFNZ?=
 =?utf-8?B?V3pMaW94WndZemJWbzhOZXl3MnZ4T1N3dG92MjJMczBzdUx5azVyVk9tY2RC?=
 =?utf-8?B?T1lWUHhCdjdCOGtoOUt4UFQ0MVNkSTFWY2R5bC9GNzFVVWxMTHdHUHNsYm02?=
 =?utf-8?B?ZWxac1pJcGRUdXpFUjl0M1NTaHM2QmRGN1FkMFhoL09MdlRPZmdHa2ovWmkw?=
 =?utf-8?B?WXNiVGZLZVo0VmxCRUFielEwRzdPZFNUZTdFcE15RVE5WFNsNnVsbUpIS1pX?=
 =?utf-8?B?Y1RLZC9sa0xjZUwrakxGdFQwYTEwRDNQSTdWNlhFQSt3eFNqdkZnb3plYlVV?=
 =?utf-8?B?NEpaRkRxLys0N29mbEwrTjZtbm4vbGF1bkRuc2JUTDkxSG1oZmhrTFZPMXBI?=
 =?utf-8?B?RXQ2bUNrV2NlZmFDQTJyQW1odVZaaWV1Rm9lK1NGdHp2L0Fad000WlpsS2Rk?=
 =?utf-8?B?MEJsWjRNbk1zSkxSSmFaR3kwUDJsWVkwRWtkU2EvUDFGSEhjV1YvbllwMGtD?=
 =?utf-8?B?Ry90alN5Mjk1aTE2ZU4xN1VjTjZUMUdrc1dRUzRpM3k1eVRCdVdWb3YyaHpD?=
 =?utf-8?B?ZTVoTTkrWllVTGVpRVl1N3dNcnFtcFJYWUM4MEh0YnVZckFseXFPaFFJNUJB?=
 =?utf-8?B?dEIvS0lQY0Y1eHloYlhYbUlhck9BMTUraHZCelpIUVIxTjhROXI4UnI0RFpH?=
 =?utf-8?B?d2hSZU5xdnMweVJvcy9QUXRKZWhFVTJFb00wblhwSzVZWWpmL0wyOWRKOGZ4?=
 =?utf-8?B?U2pXYmhwZzNveUFVc2hqZGMvTFJUdFNkZGw1MklJQ0xIVWd6c2ZlQTJwT0Nn?=
 =?utf-8?B?bHA2SU95NTJNaDlHOTlVVk1zeWo2dDFhTklGMWNQbmtKTW9KWjNHQ05Na0lG?=
 =?utf-8?B?L2xXTG9KZ0VsRzl1UTZSZnFUWDlUQmlJWWF6NzM1YnlMbjBlbFBqQ3ZmZkxi?=
 =?utf-8?B?dmFZMHVZeXNBckhzb1FWV1VTWXU2c2Q5NHFSdHFpQXVxaXFaMmRvWWZKc2Zl?=
 =?utf-8?B?RWlFRDcwTjNiNmNvV1JIc1ljNURsOHNTZ1A2akwyMVlBc25yeGRCbnYwaDU5?=
 =?utf-8?B?MFE3eHBONTM0Tk5MdjNEcHVUMGRiV3p1ZzNHQXZpMW5XZlM5SGZzTDJ5YWV6?=
 =?utf-8?B?QVpudks4VVF3VDNBcVhYU2dBUzdzV1JxRFpBSnVoZ2sxbGdMSmR1ZVdmS1VK?=
 =?utf-8?B?dm80eEkweVdHU0I1YXJQYWhwd0oyc0Rrc0JpTTdzQnlKNVUrR3R1UDRlUTBu?=
 =?utf-8?B?d0xBL0RGRCtMU2YxdFFaUnFPQnpUaWtqbmxoMm5rejJoY1FuWEw0TzN4UjhF?=
 =?utf-8?B?dUlGYzRnRS9yVGxHcTQ4c0VCZEhXSXJOM1ppdGVoNXVyN092SFBaS3ZPQ1FI?=
 =?utf-8?B?dGN5OHZhbEZGcGVib1g5WGNLSHNLWTFLc3lobHhhUUFMdjNwQlg1eTZ0Vm5E?=
 =?utf-8?B?TEFYTy9laVdISkwvbnZUVC85UTNtTVZKWld0bWVwNSttbU5yR2tYcEQzazA5?=
 =?utf-8?B?RlM3ckVGSi9nMUExeWZlSTVkWTN6U08vbGl2VVJYbnMyVWVTbCs2ZGsyV1Jv?=
 =?utf-8?B?QUhDOXJ1RnZFeG9SdkZVVSsvdUYray9FdGZiMThUOFphRkZYR3NNcDQ4Mnhz?=
 =?utf-8?B?Yjh5QmtoUHo4WEJtM3RXbnBXeG4wZ3VqSVVYYVVNeUJEODF1OEVaZENTaFho?=
 =?utf-8?B?QjhrZGJlT2c4R3luMlJTUXpCSm1zRWhEL3NyMHRqTGxiTnZ1T0NuY3pkN1d5?=
 =?utf-8?B?SkJTc2drVm5SQW1kbU8wNzdLUVZUay9JVy81aUM1TXlRQU1GaVRibGc2OFBR?=
 =?utf-8?B?VEdIc0cxc000UlRNc2JNa1c3SldyL1J5ck5zRXVWQXhDOTVtMHp3Uy9BR25a?=
 =?utf-8?Q?vJPYPq1DWmu6clRIgchPVV4kSjmIAc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6067.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z01MYU54UEVCV2VVcHk1aEhyUGZmMU1teTZvUWZMZUxhUFZDbUNpeDJnUjcr?=
 =?utf-8?B?VlJyckFoTFU3NlY1aURxUjFHUlZ4Mms2OGVIOVc3NFlyOHdKTlh2S0kwTGV3?=
 =?utf-8?B?b0ozN3V0ZFhyUzUyZ29BQmFZaTJXNHYwZzdIMlJBbXc2NjJVc3k1dDFVVlBU?=
 =?utf-8?B?VFJIT0tjaEoxaWlMMnAxZVFlK0pKNGtVN2lYL3ZxazZBbGVXMGtFalNUbVJB?=
 =?utf-8?B?SmVacWExemREQlY5NkdVSGtPZVkzYkRVeWRsQTh4YzNoenNVeE5lVHNPRmxj?=
 =?utf-8?B?WDZlSEhRazkramlnU3c5R0dKb0lZcTF5aCttSE5RQk5NWlJ3cHh5Q0l1UjFS?=
 =?utf-8?B?TFlVS2F1dzcxZ2x6Qnp6TDZPcCtQOGFMQ3RXaGFDekZBSG02aE45eUFOWDBV?=
 =?utf-8?B?YXNzcTQyZjZibEg0QTdndGFwNy9xUEI0MW0wNEg3Myt1RFVEN0x1RGpDU3Bl?=
 =?utf-8?B?UHZ2SWtWbWp3R3d6ZVJaWlhUcFNrZTR5Q3J4azlnNDJQUkpzV3ZwWkEydkIx?=
 =?utf-8?B?b0JtaEpkMlBjYm9SaUNUMEZQeDFFQWQraVE1a2pxUFg2UEhWSElvYlpOWFNs?=
 =?utf-8?B?OVpQbDc3amlwS1o3Q09qVGRRdEgwczBmZEUxRFNaNU1Rb3VNUldiQmxZRGtC?=
 =?utf-8?B?M1dZZ25WR1JJWWpQUDJHQkF4aUUrdXJiaWZEU2s4K0w4OFBVeC9pUUFBaWxY?=
 =?utf-8?B?UFliQTlBQWY5Z1FGQ3BIZTBRU3h2N0Q0NE1KdTBGYzZ2MS9VMllWaXl4eGkz?=
 =?utf-8?B?TFRzT1dzM2V0cTlIQ1dXeE11OXgzbnY0Nm5tdVpKTzRlSjI3VERpSndJTUJE?=
 =?utf-8?B?eDkwRUhpSWxDRXQrbmQrb09DMnlsTnpuWUh3SjVzd0hLREVxZWhxRzJrZnRl?=
 =?utf-8?B?Vy9hdTRSNnlVVXMwSWFWZys4WkJZWXdDZEZlb3k1Q1N3RzdvcCtIUUFReTN1?=
 =?utf-8?B?cTJUSEpJSkVHMUh5ZDB6cksyZUJ5c0RtVkFyQTNLSW1LS0JSdy9OSmRwZ0Nl?=
 =?utf-8?B?eGhHNm1ZRFNHNkFXQUZaZWhFQTFScEV1K1ExdEpqUUVCdkJDek1NaGlyQmlq?=
 =?utf-8?B?NW4wbTYxd25LOVJNVGUxbVJZOWQrN1JETjduSnhneU5vbCtyNFBWS0ZYUGFM?=
 =?utf-8?B?a01tUWd6bjlUUzE0RHQ0Y3g4ZFdpUXhxR0lMczNha0tpWGVHZms0YVBBNDFa?=
 =?utf-8?B?U0hhUk9ncnBTN2JZSW1tNjRHWnVvNVdJRWQxei9ZUG5nMlBzaENvNm5OeUFt?=
 =?utf-8?B?T3E3dUN6MHBwYmtCeG5GbGp0UUlpbkpyMHM4dWhSaS9lRHJUUkFlSGxYWktJ?=
 =?utf-8?B?eFRsMExBanh6c2Zwb1pJUms3SFhOWVFMQllhOGFSNTlnUFR0TlUrZVgyU3BF?=
 =?utf-8?B?MW9NT0sxck1sQUNkTnhaT05DY1pWQnl2aDJ6TlljbDdURitpcEJlNzV4MlhW?=
 =?utf-8?B?c3dlUmE3WGEyaWFOcHpmM0NQUXlNdHFzTDlVV2hqaytiTjZZWktQWnh1SDR3?=
 =?utf-8?B?WjAyTk1MV3BrV0w1VFdHZm9UUmFZQUhMa1VYdlBTUE96SFVmeldhcXdxVUVm?=
 =?utf-8?B?RDYvK3U2c002djZ5ZGNpeXUyTXYrUE1Ob1V0VXhNa0RPM01QYThGNGIwSzQ5?=
 =?utf-8?B?TU1acEF0YXMxV09nNXlteUhjcnJreW5sRGFIcllvTVFjQ1BzM0k3clpzbks1?=
 =?utf-8?B?WU92LzRJREVpTUFXNzZFYlJNUmtMWWdjWnpqR2N4VG9PYjRnSkZzK1owNWlv?=
 =?utf-8?B?a2NTY1RwUFNrL05IYWxJY1lQM0l3ZVNFWXhrOVpWbkFsTkNwSFNHNFdvblRq?=
 =?utf-8?B?cHhvNlQ2RkVWZWR1UEVzV25QV210LzdveHBqblpVS0t4cGhNU29RNjBtY0hy?=
 =?utf-8?B?eVMwZ294RG5XczUrbW81T2JCQ1dKZmNhT0REbEdQSjRRcGNmNU9UQUQwSVVK?=
 =?utf-8?B?RVByWGJFNTcxL2xWRzkrS2RGOHVaanpvZWsyTFRYakxrRzJYYzcybUZoazFU?=
 =?utf-8?B?KzFDM0RvSmp5Vkx2UE9xS1FPYkJqaFkzaHpoTjl1UzVhOVlNSm8wRTVORFU2?=
 =?utf-8?B?dHJma0cyMENSU21ZbDNnczdGcGUzMllhVFV2MW1hSUVGTldjNDYwVXZFR283?=
 =?utf-8?Q?0Mok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda5f39-782f-4705-4113-08dd836340a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 19:07:26.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zZ2etvIBGaTDzAugwIg6uMDWs1OI4dL22qDTFJXkxN0wonC8GpJjwo/OO6qtVmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206wqBDYWxlYiBT
YW5kZXIgTWF0ZW9zIDxjc2FuZGVyQHB1cmVzdG9yYWdlLmNvbT4KU2VudDrCoFRodXJzZGF5LCBB
cHJpbCAyNCwgMjAyNSA5OjI4IFBNClRvOsKgT2ZlciBPc2hyaSA8b2ZlckBudmlkaWEuY29tPgpD
YzrCoGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZyA8bGludXgtYmxvY2tAdmdlci5rZXJuZWwu
b3JnPjsgbWluZy5sZWlAcmVkaGF0LmNvbSA8bWluZy5sZWlAcmVkaGF0LmNvbT47IGF4Ym9lQGtl
cm5lbC5kayA8YXhib2VAa2VybmVsLmRrPjsgSmFyZWQgSG9sem1hbiA8amhvbHptYW5AbnZpZGlh
LmNvbT47IFlvYXYgQ29oZW4gPHlvYXZAbnZpZGlhLmNvbT47IEd1eSBFaXNlbmJlcmcgPGdlaXNl
bmJlcmdAbnZpZGlhLmNvbT47IE9tcmkgTGV2aSA8b21yaWxAbnZpZGlhLmNvbT4KU3ViamVjdDrC
oFJlOiB1YmxrOiBSRkMgZmV0Y2hfcmVxX211bHRpc2hvdArCoApFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwoKCk9uIFRodSwgQXByIDI0LCAy
MDI1IGF0IDExOjE54oCvQU0gT2ZlciBPc2hyaSA8b2ZlckBudmlkaWEuY29tPiB3cm90ZToKPgo+
IEhpLAo+Cj4gT3VyIGNvZGUgdXNlcyBhIHNpbmdsZSBpb191cmluZyBwZXIgY29yZSwgd2hpY2gg
aXMgc2hhcmVkIGFtb25nIGFsbCBibG9jayBkZXZpY2VzIC0gbWVhbmluZyBlYWNoIGJsb2NrIGRl
dmljZSBvbiBhIGNvcmUgdXNlcyB0aGUgc2FtZSBpb191cmluZy4KPgo+IExldOKAmXMgc2F5IHRo
ZSBzaXplIG9mIHRoZSBpb191cmluZyBpcyBOLiBFYWNoIGJsb2NrIGRldmljZSBzdWJtaXRzIE0g
VUJMS19VX0lPX0ZFVENIX1JFUSByZXF1ZXN0cy4gQXMgYSByZXN1bHQsIHdpdGggdGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24sIHdlIGNhbiBvbmx5IHN1cHBvcnQgdXAgdG8gUCBibG9jayBkZXZp
Y2VzLCB3aGVyZSBQID0gTiAvIE0uIFRoaXMgbWVhbnMgdGhhdCB3aGVuIHdlIGF0dGVtcHQgdG8g
c3VwcG9ydCBibG9jayBkZXZpY2UgUCsxLCBpdCB3aWxsIGZhaWwgZHVlIHRvIGlvX3VyaW5nIGV4
aGF1c3Rpb24uCgpXaGF0IGRvIHlvdSBtZWFuIGJ5ICJzaXplIG9mIHRoZSBpb191cmluZyIsIHRo
ZSBzdWJtaXNzaW9uIHF1ZXVlIHNpemU/CldoeSBjYW4ndCB5b3Ugc3VibWl0IGFsbCBQICogTSBV
QkxLX1VfSU9fRkVUQ0hfUkVRIG9wZXJhdGlvbnMgaW4KYmF0Y2hlcyBvZiBOPwoKQmVzdCwKQ2Fs
ZWIKCk4gaXMgdGhlIHNpemUgb2YgdGhlIHN1Ym1pc3Npb24gcXVldWUsIGFuZCBQIGlzIG5vdCBm
aXhlZCBhbmQgdW5rbm93biBhdCB0aGUgdGltZSBvZiByaW5nIGluaXRpYWxpemF0aW9uLi4uLgo=
