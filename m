Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDB1CAA66
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585272; cv=fail; b=SuiEw10sqqw4029B0C373e3qbYuFQRQWPu+zzkbwiZKA+O4igSyqXHXLXtIfkkWedVOKxznId4fYzb284amAtPsquDye5gJnmIdXDbZQ4d1QIRGRiyqQ0vUr6K4+KxnHfavPNHlIWoc3ULkd+Tk0nBgEUNwlBtcC3UMAD8pd0GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585272; c=relaxed/simple;
	bh=WR3ofon16te+M2avDDIVxmNkMkZy40VWgr+wT8y1CEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbK60bwgycurywdpEGALAfK4WoA4I0C08m5JytI164zdQ6oyIoKWA3hrfMluAGjEqtWoWQkDYq1+PqF/azp1zPWEk6Asn1CtrjQZX42IuXHNdz9b7gSAEF8+94hSiFhst89zDeIflBUzrMD5xZGgppE+IZMsTWedjyEIDFP+0QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BIRonihn; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BIRonihn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCz12EQw63swSIQmpURLdXMjtcQBO3vump/CWARRm3/Lyzc/3CQfL9Lq7TLLUQkdBvlzhRy6EIMaJhyVoOsHBCmRgv90Fuhpu0iPNxBvCbgOaKlg/0/Iei+bx/3Fknu0lYnel68KAgGeMc5LqL9k9JegxRIo0C5RA0PoYtzmWeKWdjnk3eivZmPZ/LSl22xK46aT2YoWDzk5Vds8OQEl7ch9eFiu/MPl9+wPv6FJwgBJ4N4nacylvwLhCv3uvbxymSrmBsBo7OBPeU8zWAhztWo03FzI86I3i6Il6kQFt2juZCgGhFV6qXAmxDisuSShf5R/VIob7/n4SPYaqp+pkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR3ofon16te+M2avDDIVxmNkMkZy40VWgr+wT8y1CEM=;
 b=s86U8jV9wXvWVDZr8vwgOPrPqzo3hfI/I5hOmrwjzBoI49EtSJ86xk/yFtQBis3aXvvDHfVN+qPpqB3sDx2saShoRoTsOoikRREs+DSAQscbFfu+cDrOQLzjsZP4zFisMPKBiwjzAdOuZCrbI25qjwA+KUxDYvbsPpPkCOuUbyPHHtp1ipT9pb0+qAJdGI16Af8aviz2A6uVBL/D/DPznzXVa1o8oHRdTyqTEuEgvnThOb7pTDwSR9MFLoFZyJt65vAcAfL28aZqdU5qbyo8jT96tTX4/7MHI0PbmJri/dsmg74gkVU2bMoe1IxeRwyjkbaC5VqbHw7hR7f7BwXpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR3ofon16te+M2avDDIVxmNkMkZy40VWgr+wT8y1CEM=;
 b=BIRonihnZXNxXO+vc/E0ytWVAZNjoZxrEXk3oNflJZK4RVyMSetHZPqM0Mg3iqy5HpkaKk7cg1TW2uBHZPguC+NJiXpqqkt5/eGY4IXjlegUbcrVkvEXZqnas9SOo1Ssr9uYjGc2O2WfKJnxMX0taDvWW2M47DJ9Zd7BFXyUGqQ=
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 22:34:26 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a7f9:7418:ac9e:203]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a7f9:7418:ac9e:203%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 22:34:25 +0000
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
Thread-Index:
 AQHbYTG5PPtb1U4eCUarxpU24+zL4bMOWgAAgAAcSQCAFH+oAIAALw0AgABMsgCAAAH9gIAAAyAAgAACVgA=
Date: Wed, 22 Jan 2025 22:34:25 +0000
Message-ID: <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
 <20250122172108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250122172108-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8308:EE_|IA0PR12MB7675:EE_
x-ms-office365-filtering-correlation-id: 6f6acd8e-369e-496b-874d-08dd3b34ecdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlBsTDRWZUMzcmo3VXd5V211cm9nUnJ1OWFYSnc5eVhnTzAzYUZRdGtDbERz?=
 =?utf-8?B?cWRuT3JUYzZDRWcrZFpRRDJ5cEdSTFR0eWR1R1M0Ykx5QmJuL0ZFdEZkUGdH?=
 =?utf-8?B?ZjVIVTgwSjYwaXZJd281aG5Yc3BOdXhmS28vdG9VVXkrQ25kNjlIVzBSTm1C?=
 =?utf-8?B?QVoyUWg3RElRTWZsNmJVQXdWUFpIR3g2TS9IVFVGTlA4VlFmZXJYS29Ta24x?=
 =?utf-8?B?R2h5WG9FRTZCb2c4WDRJa3N6Ny9pRnVMYzRJbEliVUJycVJEVzArTTV3N3h1?=
 =?utf-8?B?eDR6QW1QaUV6UUFOWFNXUGtNcjZSOWhkQjkxalhSYUl6d1hHaHNVeTV1UnVm?=
 =?utf-8?B?Y2JoTTE5TFIwVTBJTWNJYnRoUkc0VXBGek1FN2ErTnFyVXMrQkg5R0I2TmtO?=
 =?utf-8?B?VWwwT05Bb3JGZVVrdmR5bFpITjFvUEtMTG5tWVp5eXAwMXJVOWg1NE12UWM4?=
 =?utf-8?B?MkNNZUVpbEd5cVpZYVVCcWJvb3h2OE82Mndta3FxQ01URGZpYXpVdmhUZDA0?=
 =?utf-8?B?NklNWkx2dHRnaGsyZlRscUh0Z2R1cDA2N2paL3pHM2pnNSs4K0JqbEVJQkpy?=
 =?utf-8?B?NW5Ca2RZWDV1Uks4UzRtUitIKy85NnNqU0s1S3VuSm9RL3FWOXc3c3FwRWlM?=
 =?utf-8?B?ei9OUzFpdFUxRUVHTGMvUDhPY2Z6VE1FK2Q3NnBSNENIK2dLcHZ0bjZtZnJ3?=
 =?utf-8?B?T25lVXpYYmQrTVR4ZjlkOFVIcGVJWlNlSjkyeDFJaEkyNWYzZmhoQnIvaGxR?=
 =?utf-8?B?bTMwMFI0ZkpCc3R6ejdYK0E2MjFMdkFxSHhleE9SdFNJRStRd0ZWQm5wZmY5?=
 =?utf-8?B?aFF3YnNFNDVtUkQrbWtMZDZuQURhQllVbmlIenJEV3JhbG5veXY3TEZNdDdu?=
 =?utf-8?B?RWdSU2V2R3NTU0Ixak5lWEMyUWR0YmlHcWdnb3RJVzl4bGFoaDVDS1Awb1dO?=
 =?utf-8?B?SXlBSEdCQWhKaVBjQzAzWUxDTHZWM0YzN1ZiVXRUZGpmakxzOWI1eGlMNjBB?=
 =?utf-8?B?d2cvUEZqY25HSlEwSTB2QkJRbUdtTDhTQVVRZE56dFVESGlMUlEyZndtZC9u?=
 =?utf-8?B?aUQ3T1BJc0dPMk1ieVhnVlNUaWdUbTgzd1F5YzNvMmxib2FMaHBoNlF3NGd0?=
 =?utf-8?B?YVhOdFI3MWdEMm9ZN0dJYWtobjV2RDVmZEtXMmMreGhkYXFFYkhWMG8rNmEr?=
 =?utf-8?B?a3dVK0VPN3I3bW1TOG13b3NmT29JTHNsWmEydmZHU1ZEQldsWUJ5VVNzbnRD?=
 =?utf-8?B?OWVkamE2RGNWWVM1TlE0YVNLOVBFRWwwMDVNbyt4MDBXWEpTU1p2cFNFQnpQ?=
 =?utf-8?B?QjJRNnlQNFpZYm92SzdzNGx2Zys4ZUN1V1M3SHhEYndHZytkcG0yVUc5QVdN?=
 =?utf-8?B?dDExQ3Z3WjkzZkRTZDhLNUNMQ0UyRmZXeEwwVm9OTUs0UXBjbWNsR2JmRUl2?=
 =?utf-8?B?MEJBcVhYdjJnYkxZSm5wZWs5NzQrRDRkUUEyYm9sSVF2dmNqdkk3blpDcFBZ?=
 =?utf-8?B?U0NZOWZEU05UcUZueUdoRWRMeDhDSU12azU1RlpLWnJKdFBaeHFlMURsZnhu?=
 =?utf-8?B?dk5OZGo1Mk9YK3I3SDc1ZzVOS0UyL21NOVdXS2R2RHJxUFI5VVVaZFNseUFG?=
 =?utf-8?B?WjBEOEhyMHc0UkVnam56d3QrV2VJSkU0VmN4dVVkK3BVbzNhUFJiQmpkcElV?=
 =?utf-8?B?Y3ZRWXdSckdMdzYyYVRqek4yTDdQbVcvdG4wZTVvY3Q2TXhoWmJIbHUvZXBN?=
 =?utf-8?B?K3MvbjluanlHRUV1Uy9LbU9zUlQyaVRjbklTd3ZmcVFwUXZ0Wm44dy8vWXB1?=
 =?utf-8?B?a29jZXVDUWNxWElzUkNDRU0yY21yUFRLNFEvVWtISFpDZ3lVQlBDM01zdm1j?=
 =?utf-8?B?ZU93NjZoRUs2NGFhUWZPQ3EyMEJzN25PM3VseTVEWmJwTFRwS3Z0dUlIME1u?=
 =?utf-8?Q?D52pqTBY5bFqn09C+64QAhoBcFUjMocb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUZqdU9EVFRUNkM1eEhYaThaNTJtanl5bkFOckNHbU95ZzFaN0l3bVJWUXdU?=
 =?utf-8?B?V3lHVVl5U2Jsb2xWYTJSWVJRWGdFNDBscFpnUVUzNWtzNjNHNzRTSklKRFNK?=
 =?utf-8?B?V09PWmprbmU2NTUrditsc3hOQm9LVEp6VmtLWGFXSDVGdGNFQ0Fka3praU1Z?=
 =?utf-8?B?N0JySmxnY2Zta0RKSm9tNlVQem13NmRMNkdDUFRob1l4UDV0S2xOOEozK1pX?=
 =?utf-8?B?SnB5Ukc0MnRQemoxSXRhd0JpZWdlYkNSNm1XOEJIMVQ1TWNMS3FXbnF3bFlK?=
 =?utf-8?B?WmJGaW1HRlFXZ3NEU1h4KzV3akdZSEJ4RkV3bWFtWlhpeHlUR1Q5c0pqYnhT?=
 =?utf-8?B?YnIxMjVrdVpoQTFhL1NwOFpvOEVxM1hvUk5Ia3JicHRqV3liVlNKVG8rdmxq?=
 =?utf-8?B?RGcvVlMrcDMzTkJZL0pncFI2dHV3MmZIWG4vdWNNZjNyN2VZMUFvUG9ZVWxs?=
 =?utf-8?B?MnpIMVhJSGNiNTZOUGNYbmlKTy80T0RrcmhzdnUyK2tRY0M3YTlzZlV3enhR?=
 =?utf-8?B?Q3E5d3NzYXQ1SkQzRlB1YmRJdzNPSUp0YUlmRjhoTWc0M1FXMkxtYmt1bEkz?=
 =?utf-8?B?czBGU21VUlNob0lMVG01aFFTM1R6NHpVQXdac1RoN21ZbTE1UGRBNkM3ditJ?=
 =?utf-8?B?dS9FRjA2VEFGUFhTdm4yV0tYK1hjcUJzQm5hUzNOMlFnS2IvRVlqZjdjalFo?=
 =?utf-8?B?WnUrR1EvSkxqWEpydC9oVzFoZ3NGaWUwYlc1UXN1NG9LbmpaSlZIYUV1cEtI?=
 =?utf-8?B?dTRoYXlacjZVY1YyVHFZNWQ2TWk0MWE1blpWZldsN0lmdjZpcUd4MG9saUxk?=
 =?utf-8?B?QlJxam5RazVsTFpqcnpBYlRpR1U1UEZnNnUva003Mk1GUzdoeVh6c2hJTWM4?=
 =?utf-8?B?Y0EyNkFGbHhWNjJqTThOTjRLVVdPNzJJZXFCUk5qMUdkN3J2NGE1MnlVVXdk?=
 =?utf-8?B?QmVnR0ZNUUUvZEpGU1JvMi9LeXZHOTFPdnFpR2R5ZUR0c010OWRUZ011YVFP?=
 =?utf-8?B?V1dyTXJ1VUVLSlYveGY1MTZ1UnducnNjbTUzemZtMWRYUUhJNFpZdC9MRGc5?=
 =?utf-8?B?K0hFK3hudXZvZnhwK3ZPenNuQ0ZYWEx1RWFlL1N0RnJFeFVNNFprQnZZb3Vw?=
 =?utf-8?B?RzRTQ0QwbE1QTjZleUJsZ2tkT215NjJIV3BaWHAxcXJSbEp5QU5na0R5aDZO?=
 =?utf-8?B?QTF2R2dCRVFMSjcvZThqZnlQZVVtNTg5L25tL2FTSVF3S0x1azF2SEtsOFo5?=
 =?utf-8?B?NnF2d2t3N1VTODRTb3lWTzh5M3RFSUVIb3RwenhxSXphU3lGN3M2cys0NjJx?=
 =?utf-8?B?NXVpL0dsM1ZDWm03UGZMK1lQQ1hyZ21xR2ZpZ01BdzYwOTBtdDczSDZ0VDRz?=
 =?utf-8?B?RU5GY3E0bVFrUDRnVmd6YVBrNGt0K1EyU0xvMVZFUGJJL1RTMCtaK29ONzVV?=
 =?utf-8?B?VlhNdVpOUDZqZDFOVDNwZHpFU2NMVTJFM2xaWGQwMzJsclVpNE9XUU4zWnEz?=
 =?utf-8?B?MXBHWXVMNCtzMkpVWHpsaU9qNlFnS1ZXWGY3QkJ4NUpkeXNhNjZwTnVHUjdi?=
 =?utf-8?B?am5YdHo3SkdGMnRPUXU1WDltVlovU3FqM2hGemtmbW84dUtOSUtEaDFsK2lC?=
 =?utf-8?B?SGJsVjRhYlFsNk1ZQnhnTmZZNHFaSEM1RkZNdzdjOEhMd3gzUE5hYjlaSmxF?=
 =?utf-8?B?a3paOGs4cSt1cFZIbHY3eCtsUUVwVmgxNXhoSEw0K3pXb0hvMGpkNzhDbk93?=
 =?utf-8?B?VjFTc3BhZnFDTGN0VklFeUhXY3lVaWF2a3hoMTE1V3d1T1Z4Y0hoTmEvZlhw?=
 =?utf-8?B?KzB3cHA2bXJqWjRvb1loY0gwd0NQeUJqQjlyeFArQ3JCZmhsUEltc0VQUDJ5?=
 =?utf-8?B?clZFWUd5MG4xZU5BMThDYzlnNnhtWjYzMktGczU3YVNFcXdIclNWNll5RWJo?=
 =?utf-8?B?UjB6bmg3VTFHaE8yZXFCM0RWTWw2VUNmTTZTcm1VZmMxc0R4Yjl4OGJvSVNK?=
 =?utf-8?B?WGFrQ1dQUHdHVEQ0b0k3ajcveStkNGNBczRZaVlZZWtQK1Q4MkdveGQ1MFUz?=
 =?utf-8?B?V01pQkpNUk5mbjJoRDNqdzdPVG0wK2hVNWlVNWcvLzNZYzdkbXdiUnFTOFJE?=
 =?utf-8?Q?k1KxdfzMXvyw5KnkxfklKAY1a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51CFD66D966230409E4D00D5C94A43E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6acd8e-369e-496b-874d-08dd3b34ecdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 22:34:25.4445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQugajtbFm5aw41yoikQP0U3wL+U+6nBbdLsU1ODKhaTBX4X7MWtshzSF6SQiPIa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

DQo+IE9uIEphbiAyMiwgMjAyNSwgYXQgNToyNeKAr1BNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+IA0K
PiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCAxMDoxNDo1MlBNICswMDAwLCBCb3llciwgQW5kcmV3
IHdyb3RlOg0KPj4gDQo+Pj4gT24gSmFuIDIyLCAyMDI1LCBhdCA1OjA34oCvUE0sIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IENhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVz
cG9uZGluZy4NCj4+PiANCj4+PiANCj4+PiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCAwNjozMzow
NFBNICswMTAwLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6DQo+Pj4+IEFtIDIyLjAxLjI1
IHVtIDE1OjQ0IHNjaHJpZWIgQm95ZXIsIEFuZHJldzoNCj4+Pj4gWy4uLl0NCj4+Pj4gDQo+Pj4+
Pj4+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYw0KPj4+Pj4+Pj4gKysrIGIvZHJp
dmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4+Pj4+Pj4+IEBAIC0zNzksMTQgKzM3OSwxMCBAQCBz
dGF0aWMgdm9pZCB2aXJ0aW9fY29tbWl0X3JxcyhzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCkN
Cj4+Pj4+Pj4+IHsNCj4+Pj4+Pj4+ICBzdHJ1Y3QgdmlydGlvX2JsayAqdmJsayA9IGhjdHgtPnF1
ZXVlLT5xdWV1ZWRhdGE7DQo+Pj4+Pj4+PiAgc3RydWN0IHZpcnRpb19ibGtfdnEgKnZxID0gJnZi
bGstPnZxc1toY3R4LT5xdWV1ZV9udW1dOw0KPj4+Pj4+Pj4gLSAgIGJvb2wga2ljazsNCj4+Pj4+
Pj4+ICBzcGluX2xvY2tfaXJxKCZ2cS0+bG9jayk7DQo+Pj4+Pj4+PiAtICAga2ljayA9IHZpcnRx
dWV1ZV9raWNrX3ByZXBhcmUodnEtPnZxKTsNCj4+Pj4+Pj4+ICsgICB2aXJ0cXVldWVfa2ljayh2
cS0+dnEpOw0KPj4+Pj4+Pj4gIHNwaW5fdW5sb2NrX2lycSgmdnEtPmxvY2spOw0KPj4+Pj4+Pj4g
LQ0KPj4+Pj4+Pj4gLSAgIGlmIChraWNrKQ0KPj4+Pj4+Pj4gLSAgICAgICAgICAgdmlydHF1ZXVl
X25vdGlmeSh2cS0+dnEpOw0KPj4+Pj4+Pj4gfQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gSSB3b3VsZCBh
c3N1bWUgdGhpcyB3aWxsIGJlIGEgcGVyZm9ybWFuY2UgbmlnaHRtYXJlIGZvciBub3JtYWwgSU8u
DQo+Pj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IEhlbGxvIE1pY2hhZWwgYW5kIENocmlzdGlhbiBhbmQg
SmFzb24sDQo+Pj4+PiBUaGFuayB5b3UgZm9yIHRha2luZyBhIGxvb2suDQo+Pj4+PiANCj4+Pj4+
IElzIHRoZSBwZXJmb3JtYW5jZSBjb25jZXJuIHRoYXQgdGhlIHZtZXhpdCBtaWdodCBsZWFkIHRv
IHRoZSB1bmRlcmx5aW5nIHZpcnR1YWwgc3RvcmFnZSBzdGFjayBkb2luZyB0aGUgd29yayBpbW1l
ZGlhdGVseT8gQW55IG90aGVyIGpvYiBwb3N0aW5nIHRvIHRoZSBzYW1lIHF1ZXVlIHdvdWxkIHBy
ZXN1bWFibHkgYmUgYmxvY2tlZCBvbiBhIHZtZXhpdCB3aGVuIGl0IGdvZXMgdG8gYXR0ZW1wdCBp
dHMgb3duIG5vdGlmaWNhdGlvbi4gVGhhdCB3b3VsZCBiZSBhbG1vc3QgdGhlIHNhbWUgYXMgaGF2
aW5nIHRoZSBvdGhlciBqb2IgYmxvY2sgb24gYSBsb2NrIGR1cmluZyB0aGUgb3BlcmF0aW9uLCBh
bHRob3VnaCBJIGd1ZXNzIGlmIHlvdSBhcmUgc2tpcHBpbmcgbm90aWZpY2F0aW9ucyBzb21laG93
IGl0IHdvdWxkIGxvb2sgZGlmZmVyZW50Lg0KPj4+PiANCj4+Pj4gVGhlIHBlcmZvcm1hbmNlIGNv
bmNlcm4gaXMgdGhhdCB5b3UgaG9sZCBhIGxvY2sgYW5kIHRoZW4gZXhpdC4gRXhpdHMgYXJlIGV4
cGVuc2l2ZSBhbmQgY2FuIHNjaGVkdWxlIHNvIHlvdSB3aWxsIGluY3JlYXNlIHRoZSBsb2NrIGhv
bGRpbmcgdGltZSBzaWduaWZpY2FudGx5LiBUaGlzIGlzIGJlZ2dpbmcgZm9yIGxvY2sgaG9sZGVy
IHByZWVtcHRpb24uDQo+Pj4+IFJlYWxseSwgZG9udCBkbyBpdC4NCj4+PiANCj4+PiANCj4+PiBU
aGUgaXNzdWUgaXMgd2l0aCBoYXJkd2FyZSB0aGF0IHdhbnRzIGEgY29weSBvZiBhbiBpbmRleCBz
ZW50IHRvDQo+Pj4gaXQgaW4gYSBub3RpZmljYXRpb24uIE5vdywgeW91IGhhdmUgYSByYWNlOg0K
Pj4+IA0KPj4+IHRocmVhZCAxOg0KPj4+IA0KPj4+ICAgICAgIGluZGV4ID0gMQ0KPj4+ICAgICAg
ICAgICAgICAgLT4gICAgICAgICAgICAgICAgICAgICAgLT4gc2VuZCAxIHRvIGhhcmR3YXJlDQo+
Pj4gDQo+Pj4gDQo+Pj4gdGhyZWFkIDI6DQo+Pj4gDQo+Pj4gICAgICAgaW5kZXggPSAyDQo+Pj4g
ICAgICAgICAgICAgICAtPiBzZW5kIDIgdG8gaGFyZHdhcmUNCj4+PiANCj4+PiB0aGUgc3BlYyB1
bmZvcnR1bmF0ZWx5IGRvZXMgbm90IHNheSB3aGV0aGVyIHRoYXQgaXMgbGVnYWwuDQo+Pj4gDQo+
Pj4gQXMgZmFyIGFzIEkgY291bGQgdGVsbCwgdGhlIGRldmljZSBjYW4gZWFzaWx5IHVzZSB0aGUN
Cj4+PiB3cmFwIGNvdW50ZXIgaW5zaWRlIHRoZSBub3RpZmljYXRpb24gdG8gZGV0ZWN0IHRoaXMN
Cj4+PiBhbmQgc2ltcGx5IGRpc2NhcmQgdGhlICIxIiBub3RpZmljYXRpb24uDQo+Pj4gDQo+Pj4g
DQo+Pj4gSWYgbm90LCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHdoeS4NCj4+IA0KPj4gIkVhc2ls
eSI/DQo+PiANCj4+IFRoaXMgaXMgYSBoYXJkd2FyZSBkb29yYmVsbCBibG9jayB1c2VkIGZvciBt
YW55IGRpZmZlcmVudCBpbnRlcmZhY2VzIGFuZCBkZXZpY2VzLiBXaGVuIHRoZSBub3RpZmljYXRp
b24gd3JpdGUgY29tZXMgdGhyb3VnaCwgdGhlIGRvb3JiZWxsIGJsb2NrIHVwZGF0ZXMgdGhlIHF1
ZXVlIHN0YXRlIGFuZCBzY2hlZHVsZXMgdGhlIHF1ZXVlIGZvciB3b3JrLiBJZiBhIHNlY29uZCBu
b3RpZmljYXRpb24gY29tZXMgaW4gYW5kIG92ZXJ3cml0ZXMgdGhhdCB1cGRhdGUgYmVmb3JlIHRo
ZSBxdWV1ZSBpcyBhYmxlIHRvIHJ1biAoZ29pbmcgYmFja3dhcmRzIGJ1dCBub3Qgd3JhcHBpbmcp
LCB3ZSdsbCBoYXZlIG5vIHdheSBvZiBkZXRlY3RpbmcgaXQuDQo+PiANCj4+IC1BbmRyZXcNCj4+
IA0KPiANCj4gRG9lcyBub3QgdGhpcyB3b3JrPw0KPiANCj4gbm90aWZpY2F0aW9uIGluY2x1ZGVz
IHR3byB2YWx1ZXM6DQo+IA0KPiAxLiBvZmZzZXQNCj4gMi4gd3JhcF9jb3VudGVyDQo+IA0KPiBp
ZiAoKG9mZnNldDIgPCBvZmZzZXQxICYmIHdyYXBfY291bnRlcjIgPT0gd3JhcF9jb3VudGVyMSkg
fHwNCj4gICAgIG9mZnNldDEgPiBvZmZzZXQxICYmIHdyYXBfY291bnRlcjIgIT0gd3JhcF9jb3Vu
dGVyMSkpIHsNCj4gICAgICAgIHByaW50ZigiZ29pbmcgYmFja3dhcmRzLCBkaXNjYXJkIG9mZnNl
dDIiKTsNCj4gfQ0KPiANCg0KTm8sIE1pY2hhZWwsIHRoaXMgZG9lcyBub3Qgd29yayBpbiBvdXIg
cHJvZ3JhbW1hYmxlIGhhcmR3YXJlIGRldmljZSwgYmVjYXVzZSBpdCBpcyBub3Qgc29mdHdhcmUu
DQoNCi1BbmRyZXcNCg0K
