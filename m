Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E2143C61;
	Mon, 26 May 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251424; cv=fail; b=USxScHwS8dwWokBuhGSG1K34zAtJ5nrqNZYtKSYKoxlEVqozblIa5MAAkH/rX2SN6SyTRl+I+R4UIhOsmAfget7q8u69bT0OJfFlJ55h6BOJLtdIRkho1Gymr72Tc0FJP2U6mzeP9XaMRdmeyI166ExjRfI+L26DX8GG7j5KPsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251424; c=relaxed/simple;
	bh=j5zmkAfjGBgsxqkctOhgGRazeESY9zm0ItNR4V6CgvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yt0/lzxQ2QuYiXcpnzCQ57TH4puHVBh9p8qLmr+dLLdddc2vqgi8Lqkv587ZZ6tKzR6JRZND9ZEaJOySq8xlnYt0KKwyBWjoNXknH6KYlUVh8hQExxZDi0PuwIEbg6nUY3s8NO849+Q03tlGPnvMmNtjXKCqpPlqwIAr9YIqopo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgQdrN0T; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgQdrN0T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVO3Dls/GUgBrT+H4mgTLzmv6cfg+r08f1N4sgxdHuTR2z/3kWvN2eZ8G1tSGZtUv79GcluerEXzqQtG6haTJIsIu22Gq2BpBTjpc3sQQ8uBXjzDck+TCAJrOMOAisA+hhjH0f5merpXy8WSOIEEsQPOPHfHKmRgAMTaiC0Y63hjuXN71emKJADSxvyPWb0CMxQVB6uj1eafm7jVgLysufVDizRNmPHkgUDYspXVnyk5mEIyG+dgWzp2eixYfcqhVrlSOmj2GonLCHcd0xLDpg9y/+zYZZhlOSa982VgtWWbozKat6Jb+Poac6t/Mpcmaq1D4V+CRtH+5vRNVr+gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5zmkAfjGBgsxqkctOhgGRazeESY9zm0ItNR4V6CgvQ=;
 b=Xk+gOpSUMY0hqlvGUYA1tPZ24slEcrJZw+86FEtVfcf35O/ldLEijliAZ0IX3soCtqfqUmGMCOzRldo4SCD7YquQQaxnj9sQf9/iOK5AaiZGg0UDPi+6iArKgiy8U+8aopGAX6u2fy8Athod5YKHFImfYm6LpDtKxuXrNHYzb+WGX8ZovMfcKG/aF1LPzZ3jly6BzK8Brj8LIJGOAo/qX4wwAJxFpOcjrsytzsri1K/hdZuAeCGiXBfbpyssGBl6Hw+jPcz4Jxk+BNeK0M3nMolcsD1aE9sOHsXINX4V2dFmqnIcpLTCtejxGsxiXHx2jySnpzolzeEAXjRHxLbXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5zmkAfjGBgsxqkctOhgGRazeESY9zm0ItNR4V6CgvQ=;
 b=CgQdrN0TxY640FtMb9tJsF5G5carjnJ2O3osSBAxGTqWoAK/HAT/O2jTkQNLzB1oXFLciB93epwMXJCjP9I4bIUzly7XGqBb+2NAeXcmvJaXmmSohdLZTD1XsQgfpIpqXpBteqtzvhx5nqEhbsfA7QVU/orprcsBo9p8sMBtDH6SHez6LGiDgy1ZjSkNQDb1rGVOklPDmgdMt1vq4FGKShgXQ2GjTymb3R1xfwrpuZkc7XcBb87C08QnTZrXTY5aQyMiH9oUCvxtX12Mcojd3g+K2wN6F+srLYW9Mbj320wFOEnr6a9c1Otu3itqE6Fuet6qeu36Yw4ztiW+Zu+giQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 09:23:38 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Mon, 26 May 2025
 09:23:38 +0000
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPdLOKAgADGdwCAAMY0gIAAAtjggAXuMXA=
Date: Mon, 26 May 2025 09:23:38 +0000
Message-ID:
 <CY8PR12MB719552B560C843F8CC334EDEDC65A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521145635.GA120766@fedora>
 <CY8PR12MB7195DE1F8F11675CD2584D22DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CAJSP0QXxspELYnToMuP1w86rayQgPDRccVo892C258y9UbH_Hg@mail.gmail.com>
 <CY8PR12MB71958DFA8D0043DA3842B93ADC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB71958DFA8D0043DA3842B93ADC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ1PR12MB6266:EE_
x-ms-office365-filtering-correlation-id: 1594384d-7485-4516-0163-08dd9c36ff5c
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUFIdVc4b1BBMDJHaVRtWEl6aE1weHpEU2Q1NTVnNUNhNzZvVkhWSU1nTGlN?=
 =?utf-8?B?dTY3Q1JKdUdYZWwwM01FQ0t3TU5BV2RsV3pWZjZ5dHFHV24zMjFSanJaR3V5?=
 =?utf-8?B?SFpzMDM2VUJ1UmVqcjFQUy9McVFuOVloM0Z6WDNHcmloNWUzN1RTSFFneS9u?=
 =?utf-8?B?RWhCeGdUeS81RGFDOUtPTnVrMjdUTUNWY3Y3QS9TYlIyK2QxNVN0dEZhQmNs?=
 =?utf-8?B?elJxeEtHZ0gvOXpsejJISVJXaitVOU5iVlp0cFU2UWNFdFk3WDBFandlandV?=
 =?utf-8?B?amNHWTU3NForcmtNbHQ1WHFpeVpjQWwvTDcyUjcweDMwM09sNmkzekZxc0k0?=
 =?utf-8?B?ZER6eDZXeUJqb0Y1VWVmdUptd2wyMGl0Y1Jnc21sdkpyVnlSbFI5Yk9NdmJv?=
 =?utf-8?B?RmdHOWJvUTBmNWg0VityZERYTWpLYzUwdnhpaWN6M09yNlQxVWpBeVpNZTJY?=
 =?utf-8?B?Q2NLQTVLc2NwZktETTkxeEtPNHN4MUpaSEpnRWpPYXl4MXRkMTFRUE1sdzVD?=
 =?utf-8?B?T3ZXWU0vanN3UVZFZTFhNC85a1huTTFKeVAydEJwWkdZWGM2MDQ5cFZNSFRS?=
 =?utf-8?B?YW1NcU0vcy90b3Y3TDdvTDQ5RXRuRmZFeWhZeFB0QXJtTnZOajdoTnZuQWx6?=
 =?utf-8?B?N20xd0FrcHV3TC80TDZPTjhwODhQK3ZGcEIwQnpvMVJTUVZtTnFDWEZOY2F3?=
 =?utf-8?B?RFFTVllnMGRETUQvckhRYjVFNEtFYVdFNHlPZWpadTZrRWVLTndJN1g0TG1x?=
 =?utf-8?B?bWF4Ulc1T1FIbU51UTkwb1VoN1cyTHJMUC9VRUoydzFGSmNJMGcyejlXRmhZ?=
 =?utf-8?B?dVRJZjNsY0tWVWJCZGszLzR0TWRiRG8zQTByTzF6QVlMS0ZDRHpXbjk2MmRH?=
 =?utf-8?B?a3VoK0JqcjNoNTVvK3pnTUVRYVArNjFDT2d6dGVVZ29zMmxJZ0ZTWDhHd09j?=
 =?utf-8?B?MkZUc29HVnEwbHNUdmx2VlY5K093eGpKdEpaa2VDeExqZlBxZzl4dGxZOGJi?=
 =?utf-8?B?MVNqVU5keHRQZzYyZUxIU25iSWJCWG8rak9KVGNsTXJmL3FwajllZFJrNGZl?=
 =?utf-8?B?aU8zYTFUMU9ubXM3bkdXdW5qY1BuY0NwQ3N4RDVzNWRzcXA5WkUraHB4bk5l?=
 =?utf-8?B?U0k5Qk9hQTZZTnp0ODRobHR2MmFlTS9vR0h4WXlVRjZwVEdZZWdXY3ZLUEc0?=
 =?utf-8?B?M3RGMUdLM2tsTHNING9kcjl1MDB5MHV2SWlEYW1SNThoc0Q0bnNRbWFRS1Z3?=
 =?utf-8?B?NVdkdG94R1RWVmdoVFlvUklKaXlUN0k5aEtEckRjaFpqdi9MMUxkWC93R0kx?=
 =?utf-8?B?NDZDT2hqdDViUzJaTjMydHpOYlN4Uzd2Qm51VWdDWjcrNWRIOHlpdXQ3NXBt?=
 =?utf-8?B?SEdOVjVDdWwwamoxLzBkMWgzS3ZiRVRldENXZnlZYkFPZUgydE9sYTIvN2My?=
 =?utf-8?B?Q2Y5NGRwTDBKMmVBdkNxUFJMcnZLaXRJb21mRUlFMGhpenl2SldzZkFsby9P?=
 =?utf-8?B?LzA1R1hudnNydXpLcFBzOTd3SDlBVFBKQmRzVVZnY2JYYi9iM3lKRWE4Umdw?=
 =?utf-8?B?ZnpDb1pmNWdQV3FYOUU3YVpFUy9LUi9jUmVsS2pPaUpLSkFRa1UrMUVWVzBG?=
 =?utf-8?B?dDI0U3pjMUZXTW1zZEhXVlhlZlplckZLTGROK2V0ZDFaRzc2d1Y0NzNranZI?=
 =?utf-8?B?MzcvbFdsb3ZnbzUzem40eWdhK3pDRVVQZ1MyMkoxa0N1YmkzTTQrNWEyZVds?=
 =?utf-8?B?SHZFckNKUzJQODJPVW80QXA4RWFKUTJFM01rTkxWdVBBWEVHblg3TVZrUjBx?=
 =?utf-8?B?eG53QUlESGRNTjZBcWZRellqR0s3L0pkSktPWFBpb3FvOC9PVHhONS84OWlL?=
 =?utf-8?B?MzlCcllxNDM4OW8rQU84WVZDUk0vUmVnbktSQnpuTDNEbm9lRmZEWHlGcDc1?=
 =?utf-8?B?SklPcWtkVlNjUFBjeXVQZ1dUMFBuRTFBWEFITjV2ZDN5WlhwS3VwTlk4bEk0?=
 =?utf-8?Q?Za9cpK/m6uJ5l78hIpsWuSq+1aIzGY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2hyMlhVeVVPZ0duVWJGdGM1L1BkK3pHM2JtZnJQOG03UUVXeGhWd1JVTXBY?=
 =?utf-8?B?WUFnNUYzUEhoUHpKZnNhT3RZbCtYRUttNUcwZ1F1RHQ4YjJsRFliTHVNelZO?=
 =?utf-8?B?SngwRDhSYmJZeklsWG5WdTZoNG5uT0RZTklkbnFQeVkvVjFZT0QvYURjQ0ZD?=
 =?utf-8?B?U2lyeTYwQ3F0Rkl6eGdQekZodENhcTQxTW1wLzhaVzFrNmVMOE9Ta1hsVFV4?=
 =?utf-8?B?UEF4VWpTR1AvMVZXZk1JR0lkSzdMVWZFNElsc01BZ05BeEEyRDlEM2tOQ0F5?=
 =?utf-8?B?NXMxV29ESStzSTA0bVdGdzRkSGpEdW9wQ1BEN1E5UDh1QXdNMEh4ZDlxODVY?=
 =?utf-8?B?dy9XUDNjYU1yTnlRVHlOVlM0ejJTbjNwVFJEMUhUV042V1dHUGVGa2NhWFJR?=
 =?utf-8?B?WTZjOHJXMFVydVRSek1YTzVzZ3FQOFM4NUlQcmNpVGt3OVQrQWxDSkFkdVFa?=
 =?utf-8?B?SmU0eUFBR0x1b2NUT3ZVU1NwL1NvakQzeGwwQi8xaC9RU1o5bGZaYXNSZVNM?=
 =?utf-8?B?eFBZeG1Icm9kdElES2hxMDV1U09tNThBUGtZc2puMURFV0FPV1E5N0RGZFlq?=
 =?utf-8?B?U01qVmQvczNETTB4a2RNUERhQk9RWWU5RDdzYlU0WVRNeUVQaHFkUGh2dkRD?=
 =?utf-8?B?bkVUU0Zud1d2UDN2UVNab2JwUUsrRklrUU9seUNwYU1HSHNBY2pLdFcxMU1N?=
 =?utf-8?B?a3NKalVzdm4ycjBxNmhoWksyc29sRFVPc0RleDN6VzB6cWxVZ0Z6ZGVzRmpN?=
 =?utf-8?B?QkpOdzRsZU5WaDc0aFp1VWhVRXRhME0zMEFxdHpyUlVSRnNwRlVVeUVCY1ZG?=
 =?utf-8?B?T0NVQ2RiajVHMHlZMUM0Q21UTC9KSVB2Vmhxam50YUYzcnVJb2MyQWg5SHIx?=
 =?utf-8?B?YnpSUHYrZWhYc3RJS2RsQ1oxcFlxVnJJcnMzRFRRY0JzNC9uWWpQVko2Zi9W?=
 =?utf-8?B?SURQa3JRUjZUS1JyNC9WOVRlUjRaVmw2OVpsSE9JR1dMRm9uNkZ1R0FOb2RS?=
 =?utf-8?B?NmpQeWV4UXh5QjdPU2FjZFpPVXZGY2VHSkZ1c3hPM3REcDNySUdYRVJpVzVi?=
 =?utf-8?B?Y2J2ZG8vcG9VQUtkS0FSNC9vSVMxenN6QkdTQTFFSFJZS2F2RS9KUmdSNnk2?=
 =?utf-8?B?VDFtYjVXSk5sdngycFllZTRNRTV5a0ljeE5JU0RoM2VFRlZhclBwYXNoTCsy?=
 =?utf-8?B?S0tqb1BYdWVuQkN0cXh1OXhPYnVUVjVVWS9sVTlVWTlWcEhwQzFYS2MxVDh6?=
 =?utf-8?B?Q05yS0xjb0hQM1k3Y2F2ampxQS9CN2dYd0hHclcrN0Zob0VTdXk1R2tSdmd6?=
 =?utf-8?B?RDZwTmoxSjluay9vWXdlUGlTenVDdWFIbFJ1MUlWWGtDZFJwSHI5c0M2R2pF?=
 =?utf-8?B?M0NoNWh0aitDMk44QkxJT0xFaVVKTmtOL21pSWt5TFFsWlY5eHRUSVdzdnZk?=
 =?utf-8?B?NmFmOEZLT3FwRDRvRVlZMDVQdlFIQ3J6Z0xlWlYvd2ZIV1BOOXRNSjVvTHdq?=
 =?utf-8?B?NkIzUHZ2RG00NUExSWxMNGJzdFlzbVZGSHBoOEsvT1R1cGpnem00OXFQaGcr?=
 =?utf-8?B?NGQ0NlNKRTVkRVlnTmo0UW1IWjNkdEMyc2p0ZTFEY0dzb2dHR3lKRC8zRi9w?=
 =?utf-8?B?QkhKZUZVUDVWbjlHdG91M2tyQWlRNmdzeHlESlhGU21uL0kxem9lRm00TVFH?=
 =?utf-8?B?ZjE5OE52anBaQndZOFgzenMvWGFUSXVJMEZTczVaS25RemY5WWh3UDlBQ3h1?=
 =?utf-8?B?ZFY0bDJMdnBDSDludVFNZXhJbWV5VFRGb0JWVGdBdWpYb21kVTZCV2NRclpt?=
 =?utf-8?B?UkF5QzJpZlFpemQ1ZldadVd3TkRyVGVQWVJpZGFuTDE3ajNnQXpaaFRtT1Fh?=
 =?utf-8?B?NWJOdG5HSEpsQ3U4UWlLTFE5S0xmSWlVd0Z2MlFtaEFYbjJDMTUwVTNyQUs1?=
 =?utf-8?B?TDVTb1dmMEh2SzJBZUtSakVRbE5xVWs5c2tJbkRWSjZkbXNMcUtBMlU3WFNG?=
 =?utf-8?B?cy84VEI1eEZiTzFvSHIwWVFYaEVVaHRWQ3NqNlQxczMwZEI0OGx4WjNaYlg4?=
 =?utf-8?B?L05leXVjK2ZYdDlDd1c2N3RBV3pUbmxwY3p6UVMrREZ2MFBMSFJhVlA1dzU0?=
 =?utf-8?Q?kdls=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1594384d-7485-4516-0163-08dd9c36ff5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 09:23:38.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAygNp9sSqX1wSjMelXCJ10YiSGuE5J03Svdl+9O6gUhLc0bKoFAiWQvxWamdjEHur+Z2r+w+DbHvpz6KWqmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

SGkgU3RlZmFuLA0KDQo+IEZyb206IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIE1heSAyMiwgMjAyNSA4OjI2IFBNDQo+IA0KPiANCj4gPiBGcm9tOiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQGdtYWlsLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwg
TWF5IDIyLCAyMDI1IDg6MDYgUE0NCj4gPg0KPiA+IE9uIFdlZCwgTWF5IDIxLCAyMDI1IGF0IDEw
OjU34oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiA+
ID4gRnJvbTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPiA+ID4gPiBT
ZW50OiBXZWRuZXNkYXksIE1heSAyMSwgMjAyNSA4OjI3IFBNDQo+ID4gPiA+DQo+ID4gPiA+IE9u
IFdlZCwgTWF5IDIxLCAyMDI1IGF0IDA2OjM3OjQxQU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90
ZToNCj4gPiA+ID4gPiBXaGVuIHRoZSBQQ0kgZGV2aWNlIGlzIHN1cnByaXNlIHJlbW92ZWQsIHJl
cXVlc3RzIG1heSBub3QNCj4gPiA+ID4gPiBjb21wbGV0ZSB0aGUgZGV2aWNlIGFzIHRoZSBWUSBp
cyBtYXJrZWQgYXMgYnJva2VuLiBEdWUgdG8gdGhpcywNCj4gPiA+ID4gPiB0aGUgZGlzayBkZWxl
dGlvbiBoYW5ncy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZpeCBpdCBieSBhYm9ydGluZyB0aGUg
cmVxdWVzdHMgd2hlbiB0aGUgVlEgaXMgYnJva2VuLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2l0
aCB0aGlzIGZpeCBub3cgZmlvIGNvbXBsZXRlcyBzd2lmdGx5Lg0KPiA+ID4gPiA+IEFuIGFsdGVy
bmF0aXZlIG9mIElPIHRpbWVvdXQgaGFzIGJlZW4gY29uc2lkZXJlZCwgaG93ZXZlciB3aGVuDQo+
ID4gPiA+ID4gdGhlIGRyaXZlciBrbm93cyBhYm91dCB1bnJlc3BvbnNpdmUgYmxvY2sgZGV2aWNl
LCBzd2lmdGx5DQo+ID4gPiA+ID4gY2xlYXJpbmcgdGhlbSBlbmFibGVzIHVzZXJzIGFuZCB1cHBl
ciBsYXllcnMgdG8gcmVhY3QgcXVpY2tseS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFZlcmlmaWVk
IHdpdGggbXVsdGlwbGUgZGV2aWNlIHVucGx1ZyBpdGVyYXRpb25zIHdpdGggcGVuZGluZw0KPiA+
ID4gPiA+IHJlcXVlc3RzIGluIHZpcnRpbyB1c2VkIHJpbmcgYW5kIHNvbWUgcGVuZGluZyB3aXRo
IHRoZSBkZXZpY2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGaXhlczogNDNiYjQwYzViOTI2ICgi
dmlydGlvX3BjaTogU3VwcG9ydCBzdXJwcmlzZSByZW1vdmFsIG9mDQo+ID4gPiA+ID4gdmlydGlv
IHBjaSBkZXZpY2UiKQ0KPiA+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4g
PiA+ID4gUmVwb3J0ZWQtYnk6IGxpcm9uZ3FpbmdAYmFpZHUuY29tDQo+ID4gPiA+ID4gQ2xvc2Vz
Og0KPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uL2M0NWRk
Njg2OThjZDQ3MjM4YzU1ZmI3M2MNCj4gPiA+ID4gPiBhOQ0KPiA+ID4gPiA+IGI0NzQNCj4gPiA+
ID4gPiAxQGJhaWR1LmNvbS8NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogTWF4IEd1cnRvdm95IDxt
Z3VydG92b3lAbnZpZGlhLmNvbT4NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogSXNyYWVsIFJ1a3No
aW4gPGlzcmFlbHJAbnZpZGlhLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQ
YW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gY2hhbmdl
bG9nOg0KPiA+ID4gPiA+IHYwLT52MToNCj4gPiA+ID4gPiAtIEZpeGVkIGNvbW1lbnRzIGZyb20g
U3RlZmFuIHRvIHJlbmFtZSBhIGNsZWFudXAgZnVuY3Rpb24NCj4gPiA+ID4gPiAtIEltcHJvdmVk
IGxvZ2ljIGZvciBoYW5kbGluZyBhbnkgb3V0c3RhbmRpbmcgcmVxdWVzdHMNCj4gPiA+ID4gPiAg
IGluIGJpbyBsYXllcg0KPiA+ID4gPiA+IC0gaW1wcm92ZWQgY2FuY2VsIGNhbGxiYWNrIHRvIHN5
bmMgd2l0aCBvbmdvaW5nIGRvbmUoKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gIGRyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIHwgOTUNCj4gPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
OTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19i
bGsuYyBpbmRleCA3Y2ZmZWEwMWQ4NjguLjUyMTJhZmRiZDNjNw0KPiA+ID4gPiA+IDEwMDY0NA0K
PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jDQo+ID4gPiA+ID4gKysr
IGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4gPiA+ID4gPiBAQCAtNDM1LDYgKzQzNSwx
MyBAQCBzdGF0aWMgYmxrX3N0YXR1c190IHZpcnRpb19xdWV1ZV9ycShzdHJ1Y3QNCj4gPiA+ID4g
YmxrX21xX2h3X2N0eCAqaGN0eCwNCj4gPiA+ID4gPiAgICAgYmxrX3N0YXR1c190IHN0YXR1czsN
Cj4gPiA+ID4gPiAgICAgaW50IGVycjsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICsgICAvKiBJbW1l
ZGlhdGVseSBmYWlsIGFsbCBpbmNvbWluZyByZXF1ZXN0cyBpZiB0aGUgdnEgaXMgYnJva2VuLg0K
PiA+ID4gPiA+ICsgICAgKiBPbmNlIHRoZSBxdWV1ZSBpcyB1bnF1aWVzY2VkLCB1cHBlciBibG9j
ayBsYXllciBmbHVzaGVzDQo+ID4gPiA+ID4gKyBhbnkNCj4gPiA+ID4gcGVuZGluZw0KPiA+ID4g
PiA+ICsgICAgKiBxdWV1ZWQgcmVxdWVzdHM7IGZhaWwgdGhlbSByaWdodCBhd2F5Lg0KPiA+ID4g
PiA+ICsgICAgKi8NCj4gPiA+ID4gPiArICAgaWYgKHVubGlrZWx5KHZpcnRxdWV1ZV9pc19icm9r
ZW4odmJsay0+dnFzW3FpZF0udnEpKSkNCj4gPiA+ID4gPiArICAgICAgICAgICByZXR1cm4gQkxL
X1NUU19JT0VSUjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gICAgIHN0YXR1cyA9IHZpcnRibGtf
cHJlcF9ycShoY3R4LCB2YmxrLCByZXEsIHZicik7DQo+ID4gPiA+ID4gICAgIGlmICh1bmxpa2Vs
eShzdGF0dXMpKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgIHJldHVybiBzdGF0dXM7DQo+ID4gPiA+
ID4gQEAgLTUwOCw2ICs1MTUsMTEgQEAgc3RhdGljIHZvaWQgdmlydGlvX3F1ZXVlX3JxcyhzdHJ1
Y3QgcnFfbGlzdA0KPiA+ICpycWxpc3QpDQo+ID4gPiA+ID4gICAgIHdoaWxlICgocmVxID0gcnFf
bGlzdF9wb3AocnFsaXN0KSkpIHsNCj4gPiA+ID4gPiAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlv
X2Jsa192cSAqdGhpc192cSA9DQo+ID4gPiA+ID5nZXRfdmlydGlvX2Jsa192cShyZXEtIG1xX2hj
dHgpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKyAgICAgICAgICAgaWYgKHVubGlrZWx5KHZpcnRx
dWV1ZV9pc19icm9rZW4odGhpc192cS0+dnEpKSkgew0KPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgcnFfbGlzdF9hZGRfdGFpbCgmcmVxdWV1ZV9saXN0LCByZXEpOw0KPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgfQ0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiAgICAgICAgICAgICBpZiAodnEgJiYgdnEgIT0gdGhpc192cSkN
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIHZpcnRibGtfYWRkX3JlcV9iYXRjaCh2cSwg
JnN1Ym1pdF9saXN0KTsNCj4gPiA+ID4gPiAgICAgICAgICAgICB2cSA9IHRoaXNfdnE7DQo+ID4g
PiA+ID4gQEAgLTE1NTQsNiArMTU2Niw4NyBAQCBzdGF0aWMgaW50IHZpcnRibGtfcHJvYmUoc3Ry
dWN0DQo+ID4gPiA+ID4gdmlydGlvX2RldmljZQ0KPiA+ID4gPiAqdmRldikNCj4gPiA+ID4gPiAg
ICAgcmV0dXJuIGVycjsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gK3N0YXRp
YyBib29sIHZpcnRibGtfcmVxdWVzdF9jYW5jZWwoc3RydWN0IHJlcXVlc3QgKnJxLCB2b2lkICpk
YXRhKSB7DQo+ID4gPiA+ID4gKyAgIHN0cnVjdCB2aXJ0YmxrX3JlcSAqdmJyID0gYmxrX21xX3Jx
X3RvX3BkdShycSk7DQo+ID4gPiA+ID4gKyAgIHN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gZGF0
YTsNCj4gPiA+ID4gPiArICAgc3RydWN0IHZpcnRpb19ibGtfdnEgKnZxOw0KPiA+ID4gPiA+ICsg
ICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgdnEgPSAm
dmJsay0+dnFzW3JxLT5tcV9oY3R4LT5xdWV1ZV9udW1dOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArICAgc3Bpbl9sb2NrX2lycXNhdmUoJnZxLT5sb2NrLCBmbGFncyk7DQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICsgICB2YnItPmluX2hkci5zdGF0dXMgPSBWSVJUSU9fQkxLX1NfSU9FUlI7DQo+
ID4gPiA+ID4gKyAgIGlmIChibGtfbXFfcmVxdWVzdF9zdGFydGVkKHJxKSAmJg0KPiAhYmxrX21x
X3JlcXVlc3RfY29tcGxldGVkKHJxKSkNCj4gPiA+ID4gPiArICAgICAgICAgICBibGtfbXFfY29t
cGxldGVfcmVxdWVzdChycSk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICBzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZ2cS0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gPiA+ICsgICByZXR1cm4gdHJ1
ZTsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgdmly
dGJsa19icm9rZW5fZGV2aWNlX2NsZWFudXAoc3RydWN0IHZpcnRpb19ibGsgKnZibGspIHsNCj4g
PiA+ID4gPiArICAgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSB2YmxrLT5kaXNrLT5xdWV1ZTsN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgIGlmICghdmlydHF1ZXVlX2lzX2Jyb2tlbih2Ymxr
LT52cXNbMF0udnEpKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4NCj4g
PiA+ID4gQ2FuIGEgc3Vic2V0IG9mIHZpcnRxdWV1ZXMgYmUgYnJva2VuPyBJZiBzbywgdGhlbiB0
aGlzIGNvZGUNCj4gPiA+ID4gZG9lc24ndCBoYW5kbGUNCj4gPiBpdC4NCj4gPiA+IE9uIGRldmlj
ZSByZW1vdmFsIGFsbCB0aGUgVlFzIGFyZSBicm9rZW4uIFRoaXMgY2hlY2sgb25seSB1c2VzIGEg
VlENCj4gPiA+IHRvIGRlY2lkZQ0KPiA+IG9uLg0KPiA+ID4gSW4gZnV0dXJlIG1heSBiZSBtb3Jl
IGVsYWJvcmF0ZSBBUEkgdG8gaGF2ZSB2aXJ0aW9fZGV2X2Jyb2tlbigpIGNhbg0KPiA+ID4gYmUN
Cj4gPiBhZGRlZC4NCj4gPiA+IFByZWZlciB0byBrZWVwIHRoaXMgcGF0Y2ggd2l0aG91dCBleHRl
bmRpbmcgbWFueSBBUElzIGdpdmVuIGl0IGhhcyBGaXhlcw0KPiB0YWcuDQo+ID4NCj4gPiB2aXJ0
YmxrX3JlbW92ZSgpIGlzIGNhbGxlZCBub3QganVzdCB3aGVuIGEgUENJIGRldmljZSBpcyBob3QN
Cj4gPiB1bnBsdWdnZWQuIEZvciBleGFtcGxlLCByZW1vdmluZyB0aGUgdmlydGlvX2JsayBrZXJu
ZWwgbW9kdWxlIG9yDQo+ID4gdW5iaW5kaW5nIGEgc3BlY2lmaWMgdmlydGlvIGRldmljZSBpbnN0
YW5jZSBhbHNvIGNhbGxzIGl0Lg0KPiA+DQo+IFRoaXMgaXMgb2suDQo+IA0KPiA+IE15IGNvbmNl
cm4gaXMgdGhhdCB2aXJ0YmxrX2Jyb2tlbl9kZXZpY2VfY2xlYW51cCgpIGlzIG9ubHkgaW50ZW5k
ZWQNCj4gPiBmb3IgdGhlIGNhc2VzIHdoZXJlIGFsbCB2aXJ0cXVldWVzIGFyZSBicm9rZW4gb3Ig
bm9uZSBhcmUgYnJva2VuLiBJZg0KPiA+IGp1c3QgdGhlIGZpcnN0IHZpcnRxdWV1ZSBpcyBicm9r
ZW4gdGhlbiBpdCBjb21wbGV0ZXMgcmVxdWVzdHMgb24NCj4gPiBvcGVyYXRpb25hbCB2aXJ0cXVl
dWVzIGFuZCB0aGV5IG1heSBzdGlsbCByYWlzZSBhbiBpbnRlcnJ1cHQuDQo+ID4NCj4gSSBzZWUg
dGhhdCB2cSBicm9rZW4gaXMgZXh0ZW5kZWQgZm9yIGVhY2ggcmVzZXQgc2NlbmFyaW8gdG9vIGxh
dGVseSBpbg0KPiB2cF9tb2Rlcm5fZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0KCkuDQo+IFNvIHllcywg
dGhpcyBwYXRjaCB3aGljaCB3YXMgaW50ZW5kZWQgZm9yIG9yaWdpbmFsIHN1cnByaXNlIHJlbW92
YWwgYnVnIHdoZXJlDQo+IHZxIGJyb2tlbiB3YXMgbm90IGRvbmUgZm9yIHJlc2V0IGNhc2VzLg0K
PiANCj4gSSBiZWxpZXZlIGZvciBmaXhpbmcgdGhlIGNpdGVkIHBhdGNoLCBkZXZpY2UtPmJyb2tl
biBmbGFnIHNob3VsZCBiZSB1c2VkLg0KPiBNYXggaW5kaWNhdGVkIHRoaXMgaW4gYW4gaW50ZXJu
YWwgcmV2aWV3LCBidXQgSSB3YXMgaW5jbGluZWQgdG8gYXZvaWQgYWRkaW5nDQo+IG1hbnkgY2hh
bmdlcy4NCj4gQW5kIGhlbmNlIHJldXNlIHZxIGJyb2tlbi4NCj4gDQo+IFNvIG9uZSBvcHRpb24g
aXMgdG8gZXh0ZW5kLA0KPiANCj4gdmlydGlvX2JyZWFrX2RldmljZSgpIHRvIGhhdmUgYSBmbGFn
IGxpa2UgYmVsb3cgYW5kIGNoZWNrIGR1cmluZyByZW1vdmUoKS4NCj4gICBkZXYtPmJyb2tlbiA9
IHRydWU7DQo+DQoNCkkgZGlnIGZ1cnRoZXIuDQpWUSByZXNpemUgaXMgdGhlIG9ubHkgdXNlciBv
ZiBkeW5hbWljYWxseSBicmVhay11bmJyZWFrIGEgVlE7IGFuZCBzcGVjaWZpYyBvbmx5IHRvIHZu
ZXQgZGV2aWNlLg0KU28gdnFbMF0uYnJva2VuIGNoZWNrIGluIHRoaXMgcGF0Y2ggaXMgc3VmZmlj
aWVudCBpbiB0aGlzIHByb3Bvc2VkIGZ1bmN0aW9uIHdpdGhvdXQgYWRkaW5nIGFib3ZlIGRldi0+
YnJva2VuIGNoZWNrLg0KDQpJZiBubyBmdXJ0aGVyIGNvbW1lbnRzLCBJIHdvdWxkIGxpa2UgdG8g
cG9zdCB2MiBhZGRyZXNzaW5nIHlvdXIgYW5kIE1pY2hhZWwncyBpbnB1dHMuDQpQbGVhc2UgbGV0
IG1lIGtub3cuDQogDQo+IG9yIHRvIHJldmVydCB0aGUgcGF0Y2gsIDQzYmI0MGM1YjkyNiwgd2hp
Y2ggTWljaGFlbCB3YXMgbm90IGxpbmtpbmcuDQo+DQo=
