Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F218EAB;
	Sat, 15 Nov 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245506; cv=fail; b=WHfw6rdALd1Vpt6tPUU2YSfo7r8XzWAjbDoTdVVFCGVpMZHJNIQOI3Yuq62EyyPXpGkjq7EX4j4QYwlI1GQIe3LlJWdiy2skTaomaXNkTiMK6Lq+sf1i/Wyz8REIl867J2sOjOjii2rs2H2wI9PsndIuHUoHdPFgZyWrp5IFzmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245506; c=relaxed/simple;
	bh=9o/ZQbUlTrb6i8Hx5TNBwdWBQcd0h2kVGGlfHjNqf6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SoD9qtTnXWKnxuX2hKVckvDa7b5xYC8c4OKDeidRpnvARipdI2er3u2r7MZt4fTdS+qJIzV75a2BXHDTeKn5koxe6EnVib8lhP0aQIqQbURUn2MlJ/Jsjc76d9r4yIeF4MLeobkf+PuuBqgCKSE1vC3oLzXNY3fW5+r0jKi4e1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fqaRfSeL; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fqaRfSeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQcvqbBUT8MJn8PO6IESqBodf1XT95itfWj6hraVX97bwkDBIfjAzLyqEaadzyT5y5Sh0L1mpBBjTqdsiIhVjQcj+hcd8WjRztY5HuUxtKKkpygM+FTXQdfXfgj51xikZc9l3Imx6rxDFwtTllB+Gze3/oC/1ynAkNdEncf7hgKa0/OuYSFLW2ZxT/Kr+tUxiL35pjir0FShVocSAyqq2RCrHVE+SDhNmBmqUliJYWmy0YWpFOrp01LMe6l+XOK004LaBIiv3LvI6AXW7YTXlgPShvBRPqTuLe+ygIjDRPxVw6BhUSvza2FhxyuTrdDP9/7AEnm/GiC8XD+qd39piA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o/ZQbUlTrb6i8Hx5TNBwdWBQcd0h2kVGGlfHjNqf6U=;
 b=e/9teYaV+kt0GkXO1YEGSzTZCaPQjf+QC7cFdwWkWkQUVZI/n6lpl7cdCRSfOlT/rLKtsQB7JspMTneBdVTmLJlBKDoJNVf6qmrqFsCongz53I7kKN3/NKmhfC6TemDyTllFxawarg1Sq14vR1Xco9w/kZnS631Bkx/bEnF5n1q6wO1Y+Ww6raU+ZWYmzq/tLTys2qKi5JiMkEe5K2rRzFEPGyGT3b52oN7ycZTE0Jx/LXDCAWq9qdKrUAlmVN/o/Owx8bPeOJstDHhtqq6xBlOfEBNB3r0uZZbCz8o+QbnEwxtVEmZczKjRQGACdcAzwg8yPoi38xS9nHLMJqThbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o/ZQbUlTrb6i8Hx5TNBwdWBQcd0h2kVGGlfHjNqf6U=;
 b=fqaRfSeLGBXIHHTAnXglRuZYWcylHZWnsZV5wdn/2TZmkQVazAC/MjEtGsyd7IgjjCDcXbWchXsaC9T65AfAOWxLKRziABAvC9ACPBeeF10yisAzJbHt2HJWc4EItVOpruVeGy1e1d7PbBtgoannwKVKQ6FGMOGqlGAWa0iQ/P5ErvHaIyoIMqy6QYYshvJVnMrp9kMhndHFvV+OGUQqnLEhNo48bs03ngemB6OzppDWm6pDxvkloIREY5r0ujbPAUYqfxWUEGnfcb5UZqSEoWjqmed37RoMH/21Cek9j7IGqPcBgR8P4ifsdnPhxqUDNQ9/a9cK7Hqnqc7VJrcldQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sat, 15 Nov
 2025 22:25:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 22:25:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Thread-Topic: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Thread-Index: AQHcVkwvi1b7T8taxUSxvEfB+ZTo2rT0UMKA
Date: Sat, 15 Nov 2025 22:25:00 +0000
Message-ID: <b389f836-d88a-4b50-a2d5-dbe0ca025cb7@nvidia.com>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
 <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
In-Reply-To: <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6242:EE_
x-ms-office365-filtering-correlation-id: 3aabd60a-7ba1-4cdf-0d04-08de2495d091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnhRMUhQblpwbjNZVTdZNmkwbzhpK2hBUDJ3Ty9kTWZvRXFTeFdZZENORHNv?=
 =?utf-8?B?UmZ1U0dudmhWaEtrREpYbDJsejV1VjRtZXBZemZhUkh5Vzh6RG5kRzRNTVhO?=
 =?utf-8?B?alljY3ZPNHZUQ1RYNDQ1d3BtNHZlcTZIQm5qeGFoL1MyUkNVaFFFMHpiYTJq?=
 =?utf-8?B?dHFlTmc3THNVWFVXdWhtT2wzaEdaRFRXQnduVDdvTzB4c05VL0dBc0hYd1Zs?=
 =?utf-8?B?ZjgvVE50dE16UlNtblNjOFEwWWlhdkFpYmFPVGdGZy9rT0UxQWtSeFJaZEV0?=
 =?utf-8?B?cTF5cHNnWjE3ZHRrU2M3Y0pPVlQ3bVNJUGxrR3VJeHBLMjZnVVVaNlRDR3Rp?=
 =?utf-8?B?K3liUStJWEdHcVcrK1FRUE5vOGg0MDFXb1dJSWcvYWMya3Z2S3k0dCtPYWhz?=
 =?utf-8?B?b2hYL1VEWnE5Y3Q2VGoyV3ZiaXVwcG9FM09nV2RHNkkveURvL2syTXlCSTFZ?=
 =?utf-8?B?aWk3S0FYMGdPcW9Hc01OdWE3TzR6WFh0SXhXTUliN3NTREJBclpIcWhZTi9v?=
 =?utf-8?B?Sjkxb3NEMy9iVXovQ0ZYNWs1elRaTkFEZFV6U0doWllMdUtGdVdpRVJEdzQz?=
 =?utf-8?B?U3hlZUdUbHJ6S1ZBZmdPN3k1MXhqV1pSUHJvaDlsNkJiZGxqMXdTWjRNRnZ6?=
 =?utf-8?B?MTdqcmMyaUljbGRndjd2TDlmNnh4U1o5N3NNbjlCTkZyWHdieTNELzF2YWdQ?=
 =?utf-8?B?emMvaHNubkFUTC8vYkRkSk5pVEk5L1g3TDJsdmV1b3Y0aXVUWHhTd1Zhc0Zv?=
 =?utf-8?B?dVQraXJGYTVKV1ROL3pZQ29HeHhzU2J4UkVUR0cxd2ZjZ21mdEIremNCa2JJ?=
 =?utf-8?B?TWdsL1lIK21mdytmWEl1QmZFN2JyODFVT0JCbjc5dFhPanFKQkdITmhwMmkr?=
 =?utf-8?B?VGcvTmFOZ3ljWEJuTWNCY2R5S1QxMFplcDJDZElUSmFIWVFIRHlmVTJGb05Y?=
 =?utf-8?B?U1VnRzgyRTk3TWJkem8zS0N5NXh1T1pPakQ4STMxdnJScDBLUSthOUhGYkg2?=
 =?utf-8?B?TStCM1Vtai9qNlh0M1YzSzkySStqc1doSTFTanVNcG5Gb2JvWUoycmRvVHpM?=
 =?utf-8?B?NjZyUElrU2ZGcGd4THlnUGxVcVNkUnorRUxFSzNuczhXR1lIakFtTE1EcFhq?=
 =?utf-8?B?SWdRS0EzSGlzNXdWOVMrM3RwbTNHYlhuRSs1Z05mRlFVZHV3K0E5MGxjSjl4?=
 =?utf-8?B?UmlJMVpkQjd5VVRDRk15Rk1CTSt6NmFadkdkdHZoZ1lNQjUrbk16TlNCdk1U?=
 =?utf-8?B?RUFMamxYOURNaHp6bDNvWkdYVkZNc3Y1NktUWE5MblYvWVlHRUJQclJ0R2JL?=
 =?utf-8?B?ZjJWMTVudk5SSDRsR2w5UE1GWDQ3dkJXcENOSG51TzArcy9FUHNOV2U2R3c2?=
 =?utf-8?B?M1hSY2ZaYXZqYlU5cFZKbFhxd2VnY3YvYzhUTUR2K3R2cGFWRU5JRXhxM1Z2?=
 =?utf-8?B?bExzbE5LcmZaWld4MGtiUnFsM3RnUkxzV1dHUTRjOFNNelc1UUllREE5dXc0?=
 =?utf-8?B?LzlDd2xHcmxqMzROS2R0V2dQT3NpanJjRzBGUTROWWNJRVhzaHNIRGUrdHJx?=
 =?utf-8?B?dEVaRkRXQzY3UGRBeTRPa3BDNHN5VVpsL0MxWVVjc1l3blA2SFdsNWlpTFUz?=
 =?utf-8?B?WVh3OGZIUkljeklvR0hUbytqeU5sVm5BUzFKMXl0MERVR214RnBUSTVZK2t0?=
 =?utf-8?B?aktEZ2ZHSGhFSWk4Z2djbG10VDFHbXFTMml5akt4WGRTSXdRS2V1Vy93SUV2?=
 =?utf-8?B?TWlCTm4wN2dob3JqdjN6ODJlOU5Bd09HQlhJYnRpa2NWN3UxVk45T3kybnJL?=
 =?utf-8?B?S1VMSVY0dDRLQmd4anEvSERFRWdXMWtLQ1pHNGRmckhZR1JmcGg2UmhZTEl2?=
 =?utf-8?B?MXFNakIzZUhUMy80djZZWDBLUm1mdHozTWpZdWJGSlJyUDU4K29EMEtXb1JL?=
 =?utf-8?B?TGhhZ1hZUTRZZUZEL0JxanJtYWhRdnlFT3BxYnRkdnIwTGhSaERzKzR3bUdm?=
 =?utf-8?B?b2g0eUQ1dDlXUmp4NVBuSUt3NkJibk5SRFp5ckFyMVpPK0FvaVhaZnQ4cWlx?=
 =?utf-8?Q?1+dkRz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDlHOEQvczA0eFRub21RV21NczJkNGMwbURtWndKSTlaWmg5Vmxnd1piRkFB?=
 =?utf-8?B?K0tnVUNqblVwcnl4UXkzNU9LWjZpSU0xb1Q5OWVMS05tZUloSVVqVUx3dkZr?=
 =?utf-8?B?Tnd4bUJKdEh4RUdhaVo2NU5VRzMwL1huRUxSQk96Y0NtOC9DV3YzQ0gxSi9F?=
 =?utf-8?B?MUF1YTJGRkRYMHR6clVlTi9CWjVqZHFTSnVzLzRhL28yN3I4YWVkb25VYmsr?=
 =?utf-8?B?ckd4YjRSeW5BczdKaE1IUjdPSWltampBVlR3UkJIUTVUSEVhdTRMbUNibFJw?=
 =?utf-8?B?T0xTOUkxTlNyV201RFE0Uy9WM3Y1OWVkb2tudGpYY1ZwVXo5QjIrN1VxZ1h1?=
 =?utf-8?B?U3dsL3dFbmNZKzZnR3hZMU9zbXhNZHlwNkZlU3luNmF1NWNXMms4cXFDekVh?=
 =?utf-8?B?ekxZUE9namR5WWhpUXFTcVc0RGJiTGcwMEhEcGFIai9acytqU0RRS3ZsaDJ6?=
 =?utf-8?B?VXEvNko1b1I2ZTNUSlRTTkR4eU1HY2xKbFdoY3grOCtjV1U1QW5kTW1SK0E3?=
 =?utf-8?B?SEVtQ0l5eW12cjBCNTg1VWZyQTNzSnlRdU9lT21RRXZLcmJ5TWdtaFhpZC9w?=
 =?utf-8?B?cWNNM1pSNm9KN2V4SG41a3M3Y2Rpa0Ziak55cUtrQ1ErckVtOEwwaWhtdjZu?=
 =?utf-8?B?U2txOWhuZlpJL1p5bW9GT0drRDJYSlZTVEw4T042VEhYc09zTWxLcWc3YjE2?=
 =?utf-8?B?ZjVkSkU1MjFvQlJTWTRsalkydVQ4aVNiRjBkVHdFc3ExTFgrQlB6VFdBZGxR?=
 =?utf-8?B?bG9vWmlIbFNTZlZMemZ5UU5YWmJJc1JKOGU3KzZZd2dZZ21xaldkWW9YUTVD?=
 =?utf-8?B?ckorOFQxSFJabjB2S0JSQk9RODdIbm9CU0FWcmRaYXZ5QzFwb3BLM21SMzM3?=
 =?utf-8?B?R2FVdThPMDh5SkQ5TXQ2dkhUUVdFMnZpZW1TZ0VJSHU0M05ZYXJLa3djOXJ6?=
 =?utf-8?B?U2dnL3RXcE13dzBha2c1VnVoRnJ5RjZpS205WVYveW9Za0k0ZWxaOVp1ME01?=
 =?utf-8?B?elRVcTI3MXl1d3Rvak1YellqVWlkVmM5TlpTemlra0tpQlkySmpWcDgraHA0?=
 =?utf-8?B?Z3RFZHBxMFRnQktIU3VuSHNqNnZEQzR5THQ5VHRnOStBR2Mwd1VuRlovTXJ1?=
 =?utf-8?B?UURTU3NDMDhwTUlVK3RpMVkyZk1oSG91anRGdFBQV1ZIR0ppclc4LzNsVGsv?=
 =?utf-8?B?S21wY0FJZ1BpYzhDYlFkL1V3eXJxNHZlK0xGOWE5Z1BBd3o5OVQ0SnNnWmpW?=
 =?utf-8?B?eURucVBxcW5JSFF0Rk5vbE5wenpvL2R0VGpiYUFKa21HUEdRNktHb3ltVElT?=
 =?utf-8?B?QVpXZ3d6MkU1OXZCZXVuSjJzL3BvejdJaVFEYnVPdGszZFE5Q1RXNEVvT3FQ?=
 =?utf-8?B?aXN3anAzNHRQN1JIU2dCQkFJb0o0SFhFRjJCc0hIV3FONE9wV2dKcXhnVVAv?=
 =?utf-8?B?Z01nTTZXNFlyYk5SL3BjeVdYeGlPaUN1STJ5dURmcW1yK3YzUXJSa0E0UWdH?=
 =?utf-8?B?Z2lvajZ3ZWE5QmVhZGVPVFZRd1ZLS2hTWTRSQU9LVENJaEg1b2xhUzNWeG9x?=
 =?utf-8?B?ZkFFRkE5dmNmRmtxdGdZTkZlR2VNc0YvczM5ZS93cHF1RWNzMzVzaDcvNkZp?=
 =?utf-8?B?enNoRUwvSnY1a09EN0dnVm5scFBYZ1RscktxQUJ1aHRxRWVab0t6eGJ3MEJQ?=
 =?utf-8?B?Mnk5Wm1Id1dEMG5KSTJCOVBiSWtMc0d4SHFaUmRrYXZOUXBIU1dPZXlRREJj?=
 =?utf-8?B?S2R0dWNTdzFUU0tIaWd6R2MyQUVya2JrWDFiRGhqT01oSmttdnVTVXNQQ081?=
 =?utf-8?B?QWFsZDVtdjdXbHRLckllQ1Bvc1hyZjFkU2dacExUbXAyaHc4ZS9xMlJCQWlH?=
 =?utf-8?B?NEw1eDNwOSt2UFBKbEd0WmhDQ05tK2sxaFJ1bW8vOG5TY0pSNEt0bWI0Y0Ji?=
 =?utf-8?B?bGJRR3BhNEt4bGZ0cWF0T3laR293a0g2R0laUFhCRkJRRStWZjJqN2FBcUVP?=
 =?utf-8?B?bjN4NUZJOCtPQjZ6eVBKTFQ5c0czdWZJR05kbjFFVSsydmNLWUhkY1NvdHlY?=
 =?utf-8?B?dGZUYzhkcjJHblJRdmFQU0dQK1Bxem5PaXorSUJCU1M4dzE2clhuNVh4aWYv?=
 =?utf-8?B?Q2lEWEVvblpBUVpCeFg2ZklWZU8wMHVZQlp6aHV3QXFsNGRRcU1wNFlVblpD?=
 =?utf-8?Q?Saz+Vo8tqKNJBKpxhIpgA2YGi14t4qv9RNwd/dALbJbU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B508A4661F51B442AF77B911970ED694@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aabd60a-7ba1-4cdf-0d04-08de2495d091
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2025 22:25:00.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eKGEmS2OQrqAzjWw51t70exrQxRndxJxw+SZo8Type/j1vlEOLr8M1x0daXCFGBQJfwSkSWXn782J1ttBM8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

T24gMTEvMTUvMjUgMDg6MjIsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVvbiBS
b21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KPg0KPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhl
IGxlbmd0aCB2YXJpYWJsZXMgZnJvbSB1bnNpZ25lZCBpbnQgdG8gc2l6ZV90Lg0KPiBVc2luZyBz
aXplX3QgZW5zdXJlcyB0aGF0IHdlIGNhbiBoYW5kbGUgbGFyZ2VyIHNpemVzLCBhcyBzaXplX3Qg
aXMNCj4gYWx3YXlzIGVxdWFsIHRvIG9yIGxhcmdlciB0aGFuIHRoZSBwcmV2aW91c2x5IHVzZWQg
dTMyIHR5cGUuDQo+DQo+IE9yaWdpbmFsbHksIHUzMiB3YXMgdXNlZCBiZWNhdXNlIGJsay1tcS1k
bWEgY29kZSBldm9sdmVkIGZyb20NCj4gc2NhdHRlci1nYXRoZXIgaW1wbGVtZW50YXRpb24sIHdo
aWNoIHVzZXMgdW5zaWduZWQgaW50IHRvIGRlc2NyaWJlIGxlbmd0aC4NCj4gVGhpcyBjaGFuZ2Ug
d2lsbCBhbHNvIGFsbG93IHVzIHRvIHJldXNlIHRoZSBleGlzdGluZyBzdHJ1Y3QgcGh5c192ZWMg
aW4gcGxhY2VzDQo+IHRoYXQgZG9uJ3QgbmVlZCBzY2F0dGVyLWdhdGhlci4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogTGVvbiBSb21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg==
