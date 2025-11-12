Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34A345CC9
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963808; cv=fail; b=fXu8eVFQtBl1NIWmQXja1tzhYedHFStbNpJee0CuH95/OELV4CyR4x0zob0W/zfF96XXjqFAg9PLhFJUc7n2i3FnNzgR0mpUrm6BIfVeWKq8teVECDYc/vm0ncGxaxX2YjOjePCkOqQVxFapkhzBaW7681cage6MkMYw3Ow7ZnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963808; c=relaxed/simple;
	bh=JSzIK5tgjiWr+jGgVzkIZ1b3WaYVnVggzmbvJsR208E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jaTfwN03mtZvjrPX6vj0BMqgIaby0VPJEQV9gbnDaQ2SXdNfFnq5kse0+7Am1JJXxCDtP3Y0PbqXM+JJOA6OtRyoYuQufXBwK2eO3wavBDjDzHeWumuBFvZpD3NBgJ7q4ttBEC8l0Ophh1hTvTmhxJ4NzISV5VonQZ/eroDrJfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/JVBurm; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/JVBurm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OigF1NkJ7i2H3yHXSxMfndX80wbldmhqgeMcioOsXJ3Nll9XeV+ODIwh1fW+5HNsAbmD+LOMxkTknxD5s/K5rW6p11BkN+o6/IalJfoxITA+SMWCCG8hfre4iZNKxnSH1NcUC3QV0NWfGZRD25jh1zDzhgHoiBcSMmL15v/ImIkjMfT7+cah1YrlbAkjn3EQ76m+S/rFyZTw1MYdFENJImJq4iJpsTu7gPrv+L5QK5JEIgeWkyZeVDp6eIcXZqhccODZn1FGtjVckNGHpwzW2I/FqMwp1znbOViJjmgjmdiWyfv2iL4khzui99LjanCppPr+JdwqnuhDmIh79/B+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSzIK5tgjiWr+jGgVzkIZ1b3WaYVnVggzmbvJsR208E=;
 b=LEuCJvQ3JvNmktyxymAIYF3NSfYDPPubDkmmmzcarqhZdyWR6rNXQ13mzRxqVd6GptnN2pNIHORArcxcFHVAUOedX832LiB3YImCneHLos3j4llTEnlBwf+2iJ2tKSvA8bBJs4lvTMuukDqHGQEU6barIDRxe/zgtz9UTjnh97xt55gm+oAa4Ugc+Cy8hcwTMZYdHM7M47GdKt5uLiqVaqytC0dZkWSPwFFOwCFKB/7MxwR3BqYIR8ySkJCzzyhtXS0NH9d4j32ulAODPZN/6Fby10tGSB8xUYVef/+EQ9J5u7flFd0NqZuU22Iuzt14NIaQc5zb1XI8t3fEuFEiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSzIK5tgjiWr+jGgVzkIZ1b3WaYVnVggzmbvJsR208E=;
 b=J/JVBurmuLxS4ag1CAcqs10BmCeCUpEDxlanZgY0nEAnvsqx9hAhnEXalJptRSoZkfuT2hbapGxSwG1shpkSPX2DxoveaoZ/1qsDNJnblQl2kE+HXS1dMT7Uxi7DlWfiTOVz/LZVpTmMd9Sie/Ey9zMLix6W30Vf6g/C2IRR+0/yBjsIxkLu9J+biSZ7e4cpBIgzlBEoIyKYtChY8FboP+TJ0cRUqU5dlhNUVN71JSa8S0CYYFrw6HrWZw71uqf8hyJ8scao2vd1AfAQVNuNN02ME21XEYasoVwJ3EJClKYhhZIZZXBPJMQIDAz/33e7Sd2NR0QGpwfLrp0Sr51p6Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 16:10:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 16:10:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <ckulkarnilinux@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Topic: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Index: AQHcU2IiEOCHpn1A8EelxJPvuVBn2rTuXHSAgAC2MYCAACQuAA==
Date: Wed, 12 Nov 2025 16:10:01 +0000
Message-ID: <27a1c07a-7801-4fc8-9ae5-2ab8c4d656ab@nvidia.com>
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
 <aRP6KdADdbnhwwrj@kbusch-mbp>
 <499e05be-69c6-472c-a9e1-3061a583d71e@kernel.dk>
In-Reply-To: <499e05be-69c6-472c-a9e1-3061a583d71e@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9642:EE_
x-ms-office365-filtering-correlation-id: ef4b3601-d01e-4f91-6c72-08de2205eeeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTJSWkFtc0FrVnZ6L2szTGY5STlLU1hqalZHZHJBU0paa2FOOVV1Z1R2K3Jv?=
 =?utf-8?B?UzU1NGQ3K3p0Y0QySTg5VTg0SDUvUkNmTEY5OTZ4Umd5RjJ5YmlVNVh6MU9I?=
 =?utf-8?B?MkxGcUIrSlNxYWx2RU1RSTNJaEhHMStrL3YzVk5ocFV3WHFjVXl6OVpIckZB?=
 =?utf-8?B?YXdKdC9BUFNFcXEvU25aQW5TNldNWW8vVjRML3JHTUJibHE4Z09lN292RGdO?=
 =?utf-8?B?ZEp2SHMveUxsQ1krRWZqeGltNzMyangwSmVxVUdiYnZrbTRPekJOdHRwcUs5?=
 =?utf-8?B?ckdqSSszT2xESC9XOFEwR2c3a25nNWpPWFV2QkF3bVFPUDFKS0JQNGQ3Q2Ev?=
 =?utf-8?B?RjJIZ1pYNDFDNEc0amN3aU4rMmV4bEhOTzRLOTdVZnFMeFJHOEVEQ2NYczMr?=
 =?utf-8?B?UnA2OCtZK253SWIreVhocjZZT0VaR0ErTUZ5c0o2Y2hNMEJsRjk2UWxVNjgv?=
 =?utf-8?B?aWdibDhVTzVCbTNLdDBxT2pOQ0R6akVqRHpYOUtVNjNmTXB6bFRQV0dpUVdP?=
 =?utf-8?B?cURNdnJhZHFQdTdkS05yUTd2K2pURFNSYVRLVksycnRzeXMydTV4UWgyU1hQ?=
 =?utf-8?B?VCt0dHVZUGNwR2NnNXBYZlRvbkxxUUlaMWl4UXpnNTl3WUR0NmZkYUNZRWFt?=
 =?utf-8?B?NGJXZmRCVlNnb2JBRjFLOWkwb1BRQkRBTmxxY0lEUGczaWhtUTg4M0xoNlFj?=
 =?utf-8?B?TEVZdS9ZMWtDZkJCNW9Tdzlsc3czLzJBdFFpVlZjOXc3UGxzTXZPOWNtUENQ?=
 =?utf-8?B?MkkrMEZ0UlgxZ1FQVmw4bWprdmNjUUIwcTlBZGFjamNuU0diYzdObHQ0bVZq?=
 =?utf-8?B?UVhvbVVtczJueGhhU2UyVUhCb0Z2Z3pYYUUxcS9oaG1qRkUwUW9oYlF6aFRh?=
 =?utf-8?B?cTNyUEY2bi9UcHI5UURtZ2UzVWVRK3VDU3Zka3BmbHdmVDdJZXdadStkQXhW?=
 =?utf-8?B?WU93OVkxSit2Y2pOQzUxcnBWbGRlYnRjaVlIRzJ3eFJYVDVZNEh2TWhKWHQ1?=
 =?utf-8?B?NWY5QUZsbjB2cHdTQlNicnhOMm1LdWZkZW0yN3d4eVRGU1hOc3dzZlh3bGdN?=
 =?utf-8?B?cHlxNGk3LzJ1WE1WVFVLRmRwem1kSHZBa0xhVmVOanRpY1lzY1NtYTBuN05s?=
 =?utf-8?B?TDQ2VjAzL2grbjV3WUV5K2k3d1VLb2NKQ2xlRUc4SmdlNG01YlFuREZWdDVu?=
 =?utf-8?B?Q1FlcVRpVFo4eHViRHRDWGpQZUNrU2JpTW5oSHY4eWZQb1VjVkRoakt4N0ZY?=
 =?utf-8?B?QWpNV2FOaG5TUXpHOHdBSU4rSVYxTUNndk03SEVQRjRjYUVwSTBSQU45T0dO?=
 =?utf-8?B?NlRvNkxyaTNQSUFFS3ZtY0VaU0duVTNxY2JxMGF2K3NaNytmZms0Sk4wS0Zx?=
 =?utf-8?B?UXNGWWRmVUt5SDhZMFR5RzE1M3E3WnRtSmc3VU9Panh6L1IxVXg2SndEbVJ2?=
 =?utf-8?B?Y1UvWmxzbHBnakhFN3hic3R1citKbFlWVUVFWXNqamhCdTdvdERvWU1Pc3pW?=
 =?utf-8?B?WlFlQ284MUJJZ2l1NmVyWlF3enpVUVZ2SUNGYXVZc0pLWVIwQzJSN1hIczhp?=
 =?utf-8?B?SUd0by8zMXk5a1hISXhlUVg4QWp1MkFxK0FvK1hGaWpLS1FBWlp5MDBYMXVQ?=
 =?utf-8?B?aXA3b1RyY25JT0pnWnczMlF3UE85UDFLVnNaWWdNVFF3ZTBWTHZCNSt5OWho?=
 =?utf-8?B?dS9BVnU3ZEJCdExYUHJQMU13bEZMZTRYQ3JHZHBwOFNmcHNBTnllQXlsZzFn?=
 =?utf-8?B?UU5JVmlLejlpSE1aRXZCVVp4MUFqL01ReHQxejF5T25tSkVUbGVpQ0o3TlVI?=
 =?utf-8?B?UEZZcFViNWdpYUNxMDZrNkZ0R0x1OGU0V2VMNkpiM3phWDVqbzdSZU5LTHNZ?=
 =?utf-8?B?U2VJVk8vUGtZcFFQcVBkc01GdzRYQTRQYVFBbHljZHNxRU1yRDI2UzF6TGFZ?=
 =?utf-8?B?aWIxcmw1SUxWY0Y4eXFqYXZZSm4zbVJvWDRvTUxLREgzakUxQzF3U2J1TjJz?=
 =?utf-8?B?SHZ6cjV4eXlqQXNxaXVKVUdDblJvYjRTaldaa2x4OENpbGhIZWNBcGllVXpp?=
 =?utf-8?Q?BkzXF4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?endsUkVneU5nVitqa1FGWnYxOEU3UmtoY083RGVGV3Qwa3VpaEE3U0RhKzRt?=
 =?utf-8?B?K1luT3hFangxZXFNYjBnN0RMd1dQWnpvRWYweS9uVnYvT2dmd1pmL3hiN01T?=
 =?utf-8?B?VnNnNnFvL0NaT1l5SGprVGlsaXAzZmpuRGE5L2F0b2ZIRUo2anExUWoraC9H?=
 =?utf-8?B?MFBXeVdGTktNUmdvejhXTVlEem9NNU55ampVUkZkcHRveCt6SWpJTUxQTjI1?=
 =?utf-8?B?MnNzT25EMVBpeEpSamxJYnNPemhuSVZVSGdSMFJ2anRVTDRaMyt1My9wTUox?=
 =?utf-8?B?THdFWDVseUdmc0V3RkRXNWdMTkxDWTJYakN3VldSWFVySCsvNklkN3dodk1R?=
 =?utf-8?B?dHh2Q3VmWHpyT0NRTWFXVTRWbXQxdFdMZ2NMOGVrQkxMQ1RIZTZod0pKbjNY?=
 =?utf-8?B?N2pVanlFdGNaUE9welg5ZW9pTm02dEt1NERWTTh3ckNZajBGM0MrNnZNVXBt?=
 =?utf-8?B?NkRPTm1yNlZpbGxrbUdZcXo3cU05Tk5Ld0JUdExFSmJvcWk2VTBmcEhXOHA4?=
 =?utf-8?B?aWdTbDkrWWVzTXRPRGNBdlA1Rm1MWjhLZFBYcUtzWEZONTkxQWV2SHZZUUpq?=
 =?utf-8?B?cXpPMjlKSVVyNGRYV1gwNGEvZDFyL1pUMng2dnNPT2dEdHh2b0JlSjZpMWxq?=
 =?utf-8?B?cjI3L2p1cWdSVU9SMTVwTm9iM045UkxLWnZPYVVMdkFMamdYcUJDR2ZTejV6?=
 =?utf-8?B?T0hmcmU1VUViODNEanBFNGN4TFJEK1NGbGQ0YzQyblh3M0s4MkFkRG1lRW1v?=
 =?utf-8?B?WkovdnRKdk1MbXhiNUxRbGk5ZnVoZzdGU2VXb0JzSzZ3MlNud2E5U0dDdkFS?=
 =?utf-8?B?L1EvQ1VSNC8zZmd0bUV4b1hUdHIrbGhMbVFmYzdYQ29oRjNiWHlYUm9FVVpP?=
 =?utf-8?B?VDhPVkxwQVBMWUpNcHNsem9UUml4NW1uSDkvZ3lHWGs0dTQybTM3WXdzM2Zh?=
 =?utf-8?B?akMzSVFUNCtVOC82QWtWU3hTNzZNUXZTb04zVWFJUEs3YTFmYXJVbVdZOTFS?=
 =?utf-8?B?RmQrT3Zya1lESzY2cWprczhjVi9YdjNhRGZ1d01tUjlxTDIzT1IxalV5Wm4w?=
 =?utf-8?B?YnA1UFMrY00zaTJGYWtPRTE3c0hENWdCMVZXWGJ5NWY1NmtGV3JEZkk5Q0pQ?=
 =?utf-8?B?anlGTkpEMkpySDlRSVEzcUlBQ3dtV1B4RkdySzJuS1FJdVpUTkJpbk94ZnBT?=
 =?utf-8?B?aDkzd052VzJ1WlhCbW80dklmTzVFS0UveThEVXhEemNrcUxFNmNTZ1ltMVJx?=
 =?utf-8?B?cDVRNC9yNjNTUjI4NWhxTmJqYTVGSEJHUmdVL056cHk0V1JwZHZZb2lrdG0y?=
 =?utf-8?B?M0hFMVhuM1V2bmRFZkE3cmtoNEZRQlFFcXl2NDNiWEFsUGY1MDBaQy9Ma0sv?=
 =?utf-8?B?YXZmS1JtUTBscW5ib2VwZE5VNUkzNFJtdDZRb3NpY09oaHM3c1BPWkgwRjJU?=
 =?utf-8?B?ZlMyeGJvMnpIeDRkbkJVVUVwYTJNZmorNnJTVlBjYnJMRytIZmdFeVdkcTFY?=
 =?utf-8?B?MFJpdFBZYVJiWXNTVFJoZ2RTS0svVlhtQU9TcENPYURLMzZGQVlTQWoxS3NZ?=
 =?utf-8?B?eCtuY2h6YjJWVnMydXhBWHltYS95TG9OdVJ5Z1RIT3VTQVoyYmZsTHIvSlAz?=
 =?utf-8?B?TmprT0pmbXRYMEVaa1VsOU9oMjBYc2lXSW9VL0UrZDBZbzZJNjAwS1diOFVE?=
 =?utf-8?B?OGt0MmxmSldzeWtyWGIra01Fc2J3RVFkZ0lNZStwa3ZjcXBzcktmSmFPeElr?=
 =?utf-8?B?bkVCbGMzdlQxSGZpTXdRclppUGhkdFBmQTlYQ0FvTmNEc0wvQk5HYUVpdFlI?=
 =?utf-8?B?eTg1a3NSa2VNaHJuRUZWWEJRZXA0d3FqVVRGSHVlQ1ZJSGVvbTNqN3BZeGg0?=
 =?utf-8?B?ZVN5ckFRcmt4YmM0K1BIUVcwaXY4WnJVeGxlVGM1dHJpbnR6d0hEZSswdXdN?=
 =?utf-8?B?cGkrZEVmRGdKaDNoMHljUEw0blFaQ1k5ZTFHU1FsNlhOSFNRVmVVd1B3d082?=
 =?utf-8?B?Vll5OENPK3lMdmcxTjhaTnhYL1JmY01sdkFGYkpqbldTdU9hZkdpRkE3dUpD?=
 =?utf-8?B?aTlKbnMrdEhxTk9XV20wRUlQQmo3K1AvVWE1TGxvYUFBd3k4N0hLaUp4VExu?=
 =?utf-8?B?THpPNU5qd1BBakw4USt0Q0NrUExrSUZiNk83V25EcS9yOXdQcHloM1Q0RDdz?=
 =?utf-8?Q?bhlFVS7NFJcjS1VYg2i/7qTaMaY9mpRw0jecwWHN6Z8j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4CCC73CB866424393C2E469C561AB03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4b3601-d01e-4f91-6c72-08de2205eeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 16:10:01.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvjLY8coIvL1wJSO/PqlM6xzrf1yqrZQ7YDEqPFB6RQvCASlKqBc0CuI+EtdGUp2L08DCGI0r6sOkindWMTJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642

T24gMTEvMTIvMjUgMDY6MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDExLzExLzI1IDg6MDgg
UE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4gT24gVHVlLCBOb3YgMTEsIDIwMjUgYXQgMDM6MjI6
NTJQTSAtMDgwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+IFRoaXMgcGF0Y2ggYWxz
byBwcm92aWRlcyBhIGNsZWFyIEFQSSB0byBhdm9pZCBhbnkgcG90ZW50aWFsIG1pc3VzZSBvZg0K
Pj4+IGJsa19ucl9waHlzX3NlZ21lbnRzKCkgZm9yIGNhbGN1bGF0aW5nIHRoZSBidmVjcyBzaW5j
ZSwgb25lIGJ2ZWMgY2FuDQo+Pj4gaGF2ZSBtb3JlIHRoYW4gb25lIHNlZ21lbnRzIGFuZCB1c2Ug
b2YgYmxrX25yX3BoeXNfc2VnbWVudHMoKSBjYW4NCj4+PiBsZWFkIHRvIGV4dHJhIG1lbW9yeSBh
bGxvY2F0aW9uIDotDQo+PiBQZXJoYXBzIGJsa19ucl9waHlzX3NlZ21lbnRzIGlzIG1pc25hbWVk
IGFzIGl0IHJlcHJlc2VudHMgZGV2aWNlDQo+PiBzZWdtZW50cywgbm90IHBoeXNpY2FsIGhvc3Qg
bWVtb3J5IHNlZ21lbnRzLiBJbnN0ZWFkIG9mIHJld2Fsa2luZyB0bw0KPj4gY2FsY3VsYXRlIHBo
eXNpY2FsIHNlZ21lbnRzLCBtYXliZSBqdXN0IGludHJvZHVjZSBhIG5ldyBmaWVsZCBpbnRvIHRo
ZQ0KPj4gcmVxdWVzdCBzbyB0aGF0IHdlIGNhbiBzYXZlIGJvdGggdGhlIHBoeXNpY2FsIGFuZCBk
ZXZpY2Ugc2VnbWVudHMgdG8NCj4+IGF2b2lkIGhhdmluZyB0byByZXBlYXRlZGx5IHJld2FsayB0
aGUgc2FtZSBsaXN0LiBUaGVyZSBpcyBhbiBvbmdvaW5nDQo+PiBlZmZvcnQgdG8gYXZvaWQgc3Vj
aCByZXBlYXRlZCB3b3JrLg0KPiBJcyBpdCB1c2VkIGluIHRoZSBmYXN0IHBhdGg/IEZyb20gdGhl
IGluaXRpYWwgcGF0Y2gsIEkgb25seSBzZWUNCj4gbG9vcC96bG9vcCB1c2luZyBpdCwgYW5kIHRo
YXQncyBjZXJ0YWlubHkgbm90IGVub3VnaCB0byB3YXJyYW50DQo+IGZ1cnRoZXIgYmxvYXRpbmcg
c3RydWN0IHJlcXVlc3QuIEp1c3QgaGF2ZSB0aGVtIGl0ZXJhdGUgdGhlDQo+IGRhcm4gdGhpbmcs
IGl0J3Mgbm90IGEgaHVnZSBkZWFsLg0KPg0Kb2theSwgd2lsbCBrZWVwIHRoZSBWMiBhcyBpcyB0
byBnZXQgcmV2aWV3cy4NCg0KLWNrDQoNCg0K
