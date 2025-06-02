Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8315A8;
	Mon,  2 Jun 2025 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748831122; cv=fail; b=QmB9ciPilf4l6XdB1UwvIrumLblqJiUc5mgEpvX2NLyLIi5/974Mo7KR/N2igCKzgnHM8SET4X2tKUGWFJ7EyfVVLOmcSL+ILsN8MzElcKVZTN+Yy6iVdJzvvImklFo5Tc2o0nt8JJwE4cErqU3S2kPF2kgsmw0wYPDyUkzGFYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748831122; c=relaxed/simple;
	bh=BP60G7nUXWAEXtk4weTBWsOhiJrsCm7A3UtguCujHdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rlm7+QMvCZx5zzfQMTKaYIii2CHBf2Bnl2ePVBMTpdXQ0ffZYwWou0lv3K0KMwS90OFcU4EuDWi2cn1KbUpjrFAgeQ/8CcJV8j2SGDjup5PK7nBX5u21FmGoqa1y6ackEmeZbOL/TjEcaIycbWYQVediJslvmMa9zPnmOAeAgeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ieDulRsY; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ieDulRsY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8IgmGM1lRx98p6CLsCqIaBxHYC8XQ2qgl0xIw1uSars7LynL7FCqys19k0C5lhTfsr4liUB7mxcxIFO0PVoncd33D461AEX2J+0Ln2edeNztnasQ6z6+Eg6yKS0XtvLdcK2XK8BA7YdVMua0kT90++c564NmIh62GvmOpdVvtgK1Rwem/S+k0gU9NzTZaacZP1SnStgY+7XxbRG7uzJ9FQ/idFXcAPirKSqhZIV5PfL/T3O8USkmzwW0IglbjXogPvFtjlSUcbtyhARJqtlpzRsoOWk91HqLu6hOp0c2RhP+VSJZb+KDd3hT9wh6RFP3JDg6gmC0zO22yShxkfe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP60G7nUXWAEXtk4weTBWsOhiJrsCm7A3UtguCujHdQ=;
 b=Oo604p0qtYoO/pHXB2C0qfHv4ybnPJrwarGHVbYecbWCuGgzzsVmxyyBjvg2dqfU6+AoQ8IMWKxwHODVOAGlisxFNayhZxkES8mQT9uVf43cXNVudbxYkpMJV77DgxnxGPlcLrW/vgLIZTfxkYdhNfz6iOGCQ7pj2DfnWNdSnUh0C+1lgKNuaIIareMtxKwhdKVuaIFiWvEwZ86dOn6ZYOMwhbvt4krhq2ei+7F9RFCiS6u2GQXPSZ11vh441RX1Y5HE4tzTXCM0xQo4BbnRFU5Fr+2vnufL78xdSU/8ezSycS1UlBHXQycBNwicNMCM52xzFgl67Ah0OKy2xbJ2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP60G7nUXWAEXtk4weTBWsOhiJrsCm7A3UtguCujHdQ=;
 b=ieDulRsYDWbXi49glEt8YH3I1q4Nxc2FIKQI+5Q1wHf+IRtXiih0NHa1FliErgUq5NSxp1uSvfjsMS6D136eDE3BfQGy43PUj8+DaVfXdN3Rlln2H2q81/V9qSVNikuVku8TL1+GtUTSiV7ngTVlUC2ciOk+cidwFkU47mxhsjBZTQubo3oh5y7u9vSILKZ+i99qdN19rEFWtfo8gcYYmIkPzZEcsnydm7Q5w2HKEMcWeTsJcqw58NGe9jttl9HpaO9UYuokaTEEWJTjGGRU3hiykjZIlh4+yccxD9DRUCbw7Do6I1plxPOr7kNuXd0MmQHRaRXjsxNcaOY9A172og==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 02:25:18 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Mon, 2 Jun 2025
 02:25:17 +0000
From: Parav Pandit <parav@nvidia.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, "mst@redhat.com" <mst@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li
 Rongqing (EXTERNAL)" <lirongqing@baidu.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v4] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v4] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHb0e2b0CsIhUFrckS30P6BD06HyrPtKLAAgAH+ayA=
Date: Mon, 2 Jun 2025 02:25:17 +0000
Message-ID:
 <CY8PR12MB7195A42DF9D8E61681B5BBDCDC62A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250531053324.39513-1-parav@nvidia.com>
 <eec84588-a9dc-4ac3-a3a3-6085cae86bae@oracle.com>
In-Reply-To: <eec84588-a9dc-4ac3-a3a3-6085cae86bae@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ0PR12MB6733:EE_
x-ms-office365-filtering-correlation-id: 06d0ef81-68f3-4cbb-4d80-08dda17cb722
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkltM1EwRDhuMkJ1d05iMGUzdXBOeFVraCt1ZFFhTW1CTTBTTTEzam9aZ1Ez?=
 =?utf-8?B?R3FFY2dFdXZsbnlSdHVjOXZ3bktJSEtHL1JrczQ1MXVOcXB4Nm9LZjVrMkxI?=
 =?utf-8?B?ak5aSkN0SUpWSG0zdlBkdmdkQzFHVEdjNmdYUW5GVHUwcnRwZFBIUE5zTDd3?=
 =?utf-8?B?a3A4VkpmTVR3cWRXRFVBMEpsZ0VRVWJoUXNBdkZOZjIyRk5zRzg5bGszM3N3?=
 =?utf-8?B?M1dUZzBqV1c0MEU0UGEzejUwUFhaa3BTTjVybnhlQ21SVnlkWHFHNU9kWW9k?=
 =?utf-8?B?VWNDRDEzQVJoblY3UUp0OFMxMVNzS2JmNS80NUNHMVVsMWh3WXFQTlphZXRx?=
 =?utf-8?B?dlhhRU5BaHlKb3JrdUYraFlUUzMyNTJKQlNMRHNPcm0yU2VacVF0MVhJM3pI?=
 =?utf-8?B?MnpJdHF5VE1leVNtU1JNNlMrK3JQTjZtaUhoSWJrYStnVHE4MUtXdFhOUE9C?=
 =?utf-8?B?UDZDRUcrQ2tLd1BobkZZNTdTay9EOS9NMUtTYnVKLzlKQnhRRHliZ2hJaFZW?=
 =?utf-8?B?WjF2K2oxdnNiUWNja1pwZFR5REpSaDJTbDMxSWpSZlo1NXpxREVhZzZyeWpC?=
 =?utf-8?B?TDg3RzdkeWZ2bnhZZkZ3ckFyNWp2aGZlN1NQWmNlaElTV1N2NmhIeWV6TzJw?=
 =?utf-8?B?SGlPQlBHV1YxbWpFSzJDR2xkY3JBTUd2OGdhWjBqcm9iVTlFby9rMElhdGIw?=
 =?utf-8?B?NmlOM1RKWldOWkxMeWZtWjBoaGRKV0d1MUVGVmpWWXd6QXc5OVBjWmQ1cit5?=
 =?utf-8?B?MzNhSU9FS016T1ZmWkdIRU9YRFp1MU9UVExQV3laNmV5WitSVzNyS0VsUTRo?=
 =?utf-8?B?bW1aL0wxOGV4OEE1T2xBWFVnTWZaWENWY2RKS1hBYTRNVmNNN2E3RTRyL0Nz?=
 =?utf-8?B?akhHRUlSR0hDTXJnNTdGNXNCUDlXdkN6YWwvV05oYkFaTTkwY0lkZ3FCOFZ1?=
 =?utf-8?B?b1FRNUJhU203cEg2bGx6bnRRQzJKWjZhelYrdTQyamFEM3hRL3RabXg4Sm5s?=
 =?utf-8?B?NHFsazZha1VrcUFGQi93OG9MdjJDZ0YzUzcxV0p6dUM4VExrMnZmMjdzeTJW?=
 =?utf-8?B?aUxsZ3NqNGNRaXl6TFpocE1OVlZoVmJDVjV1MnBOdVRhd1lwWHNiMis4VDY2?=
 =?utf-8?B?cTM3a0YxczA2Wlk4cFh2WWdUSkhzYTNVcFl4MTdqRk96WDNDN3NRVVYyY2F6?=
 =?utf-8?B?ZDFRbFNkdUczQ3JXeXEwMmRVdTZ1a0dnbE1Rd2owMTJhYTJyTkF1REVwclRz?=
 =?utf-8?B?eE1BMGNzdkxiam5QcllQb2ZxSFFZMEdqbFFpRTlDRzF5WHV1YzlkS1RGVTlh?=
 =?utf-8?B?K0JhMVluaE5zOFZMcngyNTRaTU1XRGd2ZVM3WE1qZ2ZvcXhtV3ljUkVSS0Rm?=
 =?utf-8?B?WHFOU1JNcklpZFpLN29TczBjc0JIQWFxRFNJb1BWeDZFS3B2T2Q0ZjJvNXJq?=
 =?utf-8?B?c1h0WlRiU2svYkVkUFR6WUFXMDFpRkt5c2F4aVNiaUY4QmdWNE42T3RFZ1BU?=
 =?utf-8?B?bWJwc2xIUi9MQTFjOHFjUEh2bDVKZEFYcUlwYlQrQndHNjl5L2tmNFg0cXdJ?=
 =?utf-8?B?Rmdwcm01cWNva3VXZEdndTJHQmY5TTFkdmZ1SkRDSUpXNEtBTml3OHdXSWVI?=
 =?utf-8?B?MUF6SEVET0JpdjVGNFJpejJhdUgzTlBQY2tvc1Y1ZVA5L1FoZ3g4cTBwbkE1?=
 =?utf-8?B?Ri96cU95Nm9HQVNzUFByUFlrT1gvc3hmR09RUkRoNGJTRE45MG1HZnBnbCtZ?=
 =?utf-8?B?QjBWbVpTbWtxNTZ6TWt1enp0ek5hdzNweFcxVmNyV21CK3dwZHo1NmNIVWRp?=
 =?utf-8?B?N1FibFZXR0NoSWZXU2J4ZG5lRVU0QldTYWl4cWhhSDg1V0Q4MU9VdWdObnBa?=
 =?utf-8?B?ek9hb2NRWm0vb1RDRXJCQ0dETWlkQUJyUjdkdHorMjN3d0E1bEdBS0JkYzQ3?=
 =?utf-8?B?YzIweG9ESUJpV09CektiWElZSlUzVEJ6SXZkNGl4Z2orQU1tOW1yWGxjdHdz?=
 =?utf-8?B?S204QkVPRDV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUpJalRHcVV3NWx5b2VqSmh3MjhsbHMvUmNmZ2VUNnZaN2VIWFc0QjJaVU9R?=
 =?utf-8?B?ZHdtSkVoWGJtVnhoTHBCbU1VRTl1TWU4Vmw3cHVrU0NFVk1wRnFvOFFlRldl?=
 =?utf-8?B?K0dCWUc0ZFRaZG5GOTVidVAweWFiVkdBQ2Iwb3VJbFVmcmNEcFpRR0lFSXBZ?=
 =?utf-8?B?NlpZNG9mSCttTGtYWi92ZkxXVmNvN0ZkbUZRdVBxaktDd0Z2Rnd3MDZrVFBY?=
 =?utf-8?B?M2lsTGNzWndVN2hWMW1xZ0srUVhlZ0ltakh2ZVpFZGt1aTR5MW55QzVSTnlt?=
 =?utf-8?B?M1BvYVh2TlErT012YkZaQUFUUE1pWjJFVmhHbXBJaFlWUzRmYVlvNVpCUWZw?=
 =?utf-8?B?RzFVWWlmUU1pcEU2TnRNcm9HOE1nTjhWN0JDdjVZRjdWRHgzNHg1UlZMd1Fo?=
 =?utf-8?B?Rm1tRnBqekxEUXdkWHcxR1hiZ3JuYStyYmtCTFkwL1dxNUZXZnNTcXpmNGto?=
 =?utf-8?B?L21pUml2eWwrNnZCTHg4bzJrZ1BZbzRNOTI3T0dNRlJWUGxwSVVHN0xlRzBE?=
 =?utf-8?B?TjVkUnlwdVl4Zzc5NVcyeFAzMVdHcVlZWGlYejZ5SGxmc3Y4MkNmQXZGWFM3?=
 =?utf-8?B?RWdRNkJGMzVPQWYzRS9xQk5yUlgrVUN6Z2p1VDUzZERWZkdTYVF0eWNmMlJQ?=
 =?utf-8?B?cEtBV2lVRWt0a0o4akRFTFl0NUluWmo4K0dQamI3czFJZ3lXMDBLdFlsc3pQ?=
 =?utf-8?B?ME9SSDQ0cTc4Szg2d1ZDTmxuTThJRFN6Z2UrczJOM1FYNGUwTkRsRHluRXZi?=
 =?utf-8?B?anRxdXcvL0ZoUmovMGtMNFlxZFhHTVlKd200VFpRVTljNmRMcVRGeFRYYkFr?=
 =?utf-8?B?bGZkSjQ0L0EvaUxDaFBlc01VYlcxcWNna3htYnZmQjI2YXk3NXBCQ1N1V1ZU?=
 =?utf-8?B?TEhTbHcrejRGQ0FDME1PTHJoQjJPUTdZZUc2em9ja1FXdVlXekpJMzNMTDI1?=
 =?utf-8?B?ZnI3aFpGaWxsbTlMZ3VRR3R5Tm9qTVM4UjNEaXdKQm5HVWN3d05RcUJIYTlw?=
 =?utf-8?B?cFRod2RkTzQxRTB5RzlkLzA4aUx6WWtVWkVyOHZWM3dzWnZ4QStwZ2dQSWZa?=
 =?utf-8?B?V0ZacmFoYnFIdXFGYXFqd01jU2RIK2tOUHppb0o1VkNOd1dYUW5ORllMRU9Q?=
 =?utf-8?B?Si9pMDVrWDFkZ0xhSmtuYkoyc3p4MFNxKy9KVnMvdVBNZkJFSnE3Lzg3bE1h?=
 =?utf-8?B?aVNramN3UXJWbmdMMEh5YTliMUZMaGhGMUJ5VlhlQjZBVlR4VklkWnFSRkJB?=
 =?utf-8?B?NXgremZ6WjVUaTJLUSs0TDhNamN5ZTJ4clBZendWYzlCUmN1SVVydHNFSGQ0?=
 =?utf-8?B?aG1HbFVuZzQxLysxTEdaRzFDa1p6Y0M2OGZXZkFiQ0JaMzN6WnFkVFREVGxR?=
 =?utf-8?B?aXdZcW4zbmFZWGJiWEJQcHpFT1M0Q2RVYnd4OXVLNFlLZ1lEVjNIc3BnS3Bt?=
 =?utf-8?B?SnJWd3dpZ2x1UUNLQ3g5WjBOMmN1eWEzTFFzNXlRbFZycTQvZ0FxMzhPazVP?=
 =?utf-8?B?V284d3VwdzVadVNGVnQydVFldlJ4dkZtS2hRL01xTGVkTzIya2o1T1pmYlNX?=
 =?utf-8?B?bDVaclgvTmhTTjBTWUdiYTR0MHU4bjJpeVAwN09VUEhockpSQ1Nvak1FanJz?=
 =?utf-8?B?Nlg0dEY3cXFIVTZnd2tUT081NExPbWc4N3dHQVYvRlI0ckd1c20wL0JCM05L?=
 =?utf-8?B?TFhCc2pLV1RyWUlXa0xmRGZNMUdMUzVtNWU1eXFSL2ZXamxhVzljTFJ2RHE4?=
 =?utf-8?B?ektkR0VpYk1RdktlL1lSUkpiOEFhOVVzYzhiQTNoSmxCdnVkaWllVkZaeHFD?=
 =?utf-8?B?MEJhMUtVUlhtNExpa3dTNkVyYUxuR255bjI4SDhzeElGQ0dSczk3Q2lmZnZt?=
 =?utf-8?B?bWdxOThkQVZYNXVySUl1Wmx1MnVnUnNNWTJEYmtIM3lhdXBnelJFODdSRlIw?=
 =?utf-8?B?NngvcFR4YzZsd3hGM3ljcnNYYWlJb2lWMU4rWHlNekhIQkJoOXlYaGJ3UEw0?=
 =?utf-8?B?Z0I5VU1XYzM3YXRCd0ErUFd0WGVjT21OZm1TVG1pN2lhL29OWTdMck9yZDNT?=
 =?utf-8?B?WE5aZmtEb3d6L2dTdjFzMGEyUjI4SUlZbU13ZWoyQVFMZDhDZENTalN2S2Y5?=
 =?utf-8?Q?8htI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d0ef81-68f3-4cbb-4d80-08dda17cb722
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 02:25:17.6785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyJbeqAR9ksD0JYvL3BAB3dWl+cZ+1wY9NvpflwMh/qvccSnVOPqJPY0346XjwPBf3df+BVO+fbPgoa6A0eI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

DQoNCj4gRnJvbTogQUxPSyBUSVdBUkkgPGFsb2suYS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gU2Vu
dDogU3VuZGF5LCBKdW5lIDEsIDIwMjUgMToyOCBBTQ0KPiANCj4gDQo+IA0KPiBPbiAzMS0wNS0y
MDI1IDExOjAzLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gKwlpZiAoIXZpcnRxdWV1ZV9pc19i
cm9rZW4odmJsay0+dnFzWzBdLnZxKSkNCj4gDQo+IGlzIGl0IGNhbGwsIGlmIHRoZSB2aXJ0cXVl
dWUgaXMgbm90IGJyb2tlbiA/DQo+DQpPb3BzLiBUeXBvIGVycm9yLg0KU2VuZGluZyB2NSB3aXRo
IHRoZSBmaXguDQogDQo+ID4gKwkJdmlydGJsa19jbGVhbnVwX2Jyb2tlbl9kZXZpY2UodmJsayk7
DQo+ID4gKw0KPiA+ICAgCWRlbF9nZW5kaXNrKHZibGstPmRpc2spOw0KPiA+ICAgCWJsa19tcV9m
cmVlX3RhZ19zZXQoJnZibGstPnRhZ19zZXQpOw0KPiANCj4gDQo+IFRoYW5rcywNCj4gQWxvaw0K
