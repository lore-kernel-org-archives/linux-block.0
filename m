Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F47383A2
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507713; cv=fail; b=LYuXdXZy0tSytMWqaJomUUm2V/xsHFZ1e58MY3AM99jFgWl4D5S4u+uaHc75bipb0iX7P6yQ5iO3/8V8Puhfzedv+fTVN+TqVQNFRdwOgCjJw5YuL8ibxrAyMElMlGHz/fRcbkX5LHFvGyR73NnU+qZaVAF44n2sEmmJm5dF3z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507713; c=relaxed/simple;
	bh=YVI1RNr9m3k+hiyndN+qEZUBNIP4zqpMQSrLdF2gABM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nz7WjZPzX9fAB333Z/Ja7MJYphqhx4SPXMaEG3l+cY4Lco5sQ5wAHF6GJkU0QxGw4TE8ePAj+O1X2E4Lk/Ck65kT/A+Z3JUGVqDsIb6u3BqvjxmDkqythr3JqcYLaJPVp55MPh7s1Zy428w+HBzuHwDbSYc800Uk+Lr1L0hk2zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pOXGlDPA; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pOXGlDPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXJ9Cbyznyt9MxtEmEbgK+JVk13rCCB6kuLAdsf48JtoXcHOtQc/+wvHqWjrB4F5f6UZ2Y1zA+f5TDzJ/I2J5adgE/pLBH8Gti4wwIEjUrZbET8Isq6nDGj7DsXp250fU9O1tVVKJwN8IgJpwTwlOCiSdQLNCEzrO07FUrlQUHeYMLgYgzQYGZ2MMko7151951CL8GfgEnDly3IEl8p+6cq+u3E4ygAgIe0u9IuiRAiUw3DX1SZm3BX3jU255onpSEZE9PVX8oVodZ2dw3RrgFHA0gyeARZnUgwBzufnFK/s9nc/mwdqBaoMOQ2R7hfj8s1RK7gE0vObzI+0MWrB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVI1RNr9m3k+hiyndN+qEZUBNIP4zqpMQSrLdF2gABM=;
 b=eO1XAWj7ZLws/9Dx2ewSQ+Aj7dUICZLo/cBz+w/s2g3UQ+Caq1C/piAiDGfvZdhW7qPPspX02wkhGpLUD09yKVY+PiD55c7CQoibr2QpQizNmQkTp1rtmAakwXoXXC4jSJWpf+rdRSwLk9HBbW2ANV2qCEXa+IfkpGE5+2GMIXrSGQjnyMMm2HaCMZdXzUcHWoRXFS+DyBazE5dNX1bqpUvAhKI42Dqyh/sgSM24e4vXmniN27DH/JqRU82s9JypWG2+TXLP7KZ0m5nPufS19IhR6GxJaArZ4AlnnvLBUX9FE+BIzthB9Cp8T99N0kWrvIvjCOjTjwzAGkN66X5GvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVI1RNr9m3k+hiyndN+qEZUBNIP4zqpMQSrLdF2gABM=;
 b=pOXGlDPAjmuDmMLlY5qYDMlkGD0kUJhoIscxWiKCCchZRhAvCxuUHLQPDd7JY5di3J0jXgKsm8XMKqKffXQUxnIYj1Gb6/Ev3zovHMbAKUhBT1KpMADklMooFgNKu4XmSTM6MUhY9n3StDoyjkiRC1Sj8L8xSfpGSRPdK0duUQmFjhXrHBucC4GnBj3u7O0yZ6A0yjfV9BqDXFFLmwnuj1CdDRhgCnDDAhxUszx/l5MjYU+9vj+KWI//e72Y6Bd/13ga4WtErrbZbdwtJtyI6zsXwvduKuBgqB9Pt4S49VT1/ueBH4uR+a1rZPrq64gqKjdNi8l7Ts78OQ3nXz9ZEw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Wed, 22 Jan
 2025 01:01:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 01:01:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>
CC: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v4 0/5] null_blk: improve write failure
 simulation
Thread-Topic: [PATCH for-next v4 0/5] null_blk: improve write failure
 simulation
Thread-Index: AQHba9ytq/EsO+z4yU+GQuSe1QZCvbMh+rSA
Date: Wed, 22 Jan 2025 01:01:49 +0000
Message-ID: <3927c72c-7cb9-4d91-9296-fb0e70b64354@nvidia.com>
References: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6282:EE_
x-ms-office365-filtering-correlation-id: ceb9333e-1e60-499e-8e3b-08dd3a805a31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFRsWlE2NHdNeG1SQWl1QUVWUnh1dHl1TVB1dGhsL2RGQUg3WVFJOHkyTXRD?=
 =?utf-8?B?bnRLOGI2ZUV4UWdxZVpjK2IrcVBGZ0VGOUdFS25vMTI3bUxkeTRQeWlGVTJ6?=
 =?utf-8?B?N3dmN05kRWRWa0NNWkk4MGpGaEVaRHJhQUtNcDBoYVFFUWNQL3FSaDZBWDZH?=
 =?utf-8?B?d3hIam51QTVTbzhGWnNxT2Zqck5VUkpKaUpCOE9VcGtXWGk5TnBYMHovZDBN?=
 =?utf-8?B?WnByaTZNb2NmdmhZMm9qWml3czAvbWlBeWs0UStlL3Rwa3JwOWdyNGJhSkFk?=
 =?utf-8?B?TGY4VGwva1N0RDhvOEZiUDFreitsT1RKVlIzOFNFUzZEeTQxS0J3WnZ4eW8v?=
 =?utf-8?B?Yk9hNjZpNGFqNjZ6ZlRSOCt5R1o2RmhCd3F4VFVoeUtMY2dVcVhMMGI3ejRM?=
 =?utf-8?B?UjMvL3RsZ3Fqa28wRVVrN0s3clczRm9HbGFNT3VWNENKZVJjQU5wQ1pob09j?=
 =?utf-8?B?UWMralZ4Qy9waFh0TmVNQVZCZmh3eEhPUk5WbSs5WC9NSWgyY2xXTUF5UHBW?=
 =?utf-8?B?YTBEZTlEU1hFUGlqK2s1NitBVXZvaGVlYXNsWnV4ZDZlQkh2SFBmQW40SkUy?=
 =?utf-8?B?V0VMbHM3S2RIUWphcEw5N2l3MDVyc1liNkhGV3RTelJYcVVJY0ZpQUFqMDlM?=
 =?utf-8?B?MWVPcGNKQ1hCaHZkVnIzTU01MGNEemZsbFdwaVMyT1BRMkVic0hmOUF6Rldk?=
 =?utf-8?B?RTNpWVh5eDVrZDF5R0NHdkZuWElJMUVSZXlRUmNQNTFtcWluQm1jbVVtMmRh?=
 =?utf-8?B?V3czbnJEQ3VHWVJETTk4dzcwaW5PR29mU2o0dUt4MFpYblRGb2h6ZGlDV0VX?=
 =?utf-8?B?V2g1UzgvV21xSDhGM1MvWG9UT1FKbUQ5RlJLY3owMlBtY21KeGF1OHMvaHdN?=
 =?utf-8?B?TU9ZdzRvVU1wNHBrUGJTUGI5bnZKWEhERVU1eUdWQ3FSY3pEb1lWQndudnp0?=
 =?utf-8?B?YXVUUzhaZGlhcExWMURacG1UZHE0dmRvNGh6MEtFLzhzTDRYY21mRkhKM0ZQ?=
 =?utf-8?B?d0hsbkNMSkkyU2VKSUlEV0lQNDlyTG10NCtmdVVZdUpUQk9ZWDRqUXRMMUpU?=
 =?utf-8?B?VHdMUVBJLzE4SmI1S294OUQvQ2FTOXJTMDdHd1dpYU9YVVYwOHI3VGhOOE9w?=
 =?utf-8?B?c1d4dE15Y2lXYTlrYXpOMzVNMUlaRllRMkw0UFdIR0xNQkFGUVBFenVtWHJT?=
 =?utf-8?B?VEhWdmxrdGxIazVhbkwwUEplY2xDcHJ4KzBzMTBtWDdvNzU3SExBekdsUGZk?=
 =?utf-8?B?cjhPSVdRSU5vK0Y2UDdINWcyK1l1U2pBVXQvTSt3V0hkbU5BMEZrdWlKUFg0?=
 =?utf-8?B?NUNxaGxxMFNITThvRnJkNEliQm0vVEc1dHBxY0xQTCtCZ0wzOVp6WFNoYkM2?=
 =?utf-8?B?VHBGKzZEOUxXSHQxVUowTHhrZGxsNWJGQjBIWTNOc2h0UmRrMU9xNkwrN1dx?=
 =?utf-8?B?UXc3YkZZVmZ0dStTamtHWFZzL3pkSlpiTUVTajNkUlJXTElMalk4N0UzUmR4?=
 =?utf-8?B?bElmYVk3R0ZaY0xBSk05V0pkMENnVjBJWTdGbHdaMXljMytHYnlrVisvTDIw?=
 =?utf-8?B?R1RmSFZIcWJreE5CMVRJNk53VmRJMGRjVnVTTUlLb3IwTHNDSzRQZTdFU05N?=
 =?utf-8?B?cCt1c1BvcTVLV3FJOE00VWVIMFd0YjI1T0l3ejN2cTR3d2pXeWVVV0FHN014?=
 =?utf-8?B?SDdaMVhmNVhLbUFkTVNqUVV4OTl3bm1KUGZBNnJrMmNwZmRxYWh0a3JFc3RT?=
 =?utf-8?B?L0dFTDBDa1FxRktWNnVuVS9LUk1rTVV1b0lFOU5xbWpqb2piMVFJdjJ4RkJ2?=
 =?utf-8?B?VUprZmd3TmgyZ1Q5TnpNbVNEd1hBTUNnU09MbWRDRVhLZlBUNmpuUVl3cElU?=
 =?utf-8?B?Wm94M0d1bFVHN05yZUduQXdRR0NUQWZ6WW43NUY5Y29OZmZyK1RrOUNrSm93?=
 =?utf-8?Q?aydGWb4w5aun9yOQ9hNycaH+txaM4I/s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVN1eE9lWW1KZjJVZG9Kb3dNM2w5dnVhNFpDQmtzd0NURlB3UWlmbHpVS1Qv?=
 =?utf-8?B?emZUeUZLeGpWTk02WXlLQUx5dHVhR1Z1TE5BVUVZcWpmUUYzNCsrUnFpc1lC?=
 =?utf-8?B?d0VQVWpGS3NrdWxuOGZOcy9CcnZhQUppdEdLaDFZY3hBWVgvWXFQSzh6MlpQ?=
 =?utf-8?B?cmVtOFRSNE53L1dXcEd4eEc4TWNOVEVpc3dJQVRFQWdVR21LYVFtdDdwbTdq?=
 =?utf-8?B?NEpERFlZOTZacDFiaEpheml5TEhPTmRrb3JRYXY0bW44Ti96SGMrbTFxaVlH?=
 =?utf-8?B?U2NXa1FtQkI5b2tzdlFMSTQ1cUFvb3g0SFdhRHBMYVdLbU5vVTNkSGo3V1dL?=
 =?utf-8?B?UFNKa2pLWnlqcXJnenJxTkppSGdlcEFBSlBPbEhiMUlmeHNDelNRUVpEN1N1?=
 =?utf-8?B?K2JoMGU3YUhEVmVLRXFSb1dsVmVYQjFNSVhIVDM4eEpQVXNWZ0NkREFJNm5v?=
 =?utf-8?B?UHgvbnBFd242MVZSYWYrd1YxR0VZWnZFK3BTZWZEUStOWG1KNmpyR2F1aVFQ?=
 =?utf-8?B?MEhST1Rod21hZnJ6SW5hQ2FvYm43NmRXNmRsRzFJN0dSRVo1TW5BQmlrZGNX?=
 =?utf-8?B?anMycXRuTE9HdzlVd2lvL01taWw5ekxKQ1QrQVlHdmNBemU0SjV6ZzhKYzE5?=
 =?utf-8?B?OG1sSTlLN2Y1TENSMzhTNVBaeFFYeE5ucThac25TaFBRTkYvaEV1VitJbk40?=
 =?utf-8?B?ZFVhc0ZEc2xBTHUzU0RnSkpHQkZnY3RubTU2Q0diR3RYcy9IOWRlckxnNlo5?=
 =?utf-8?B?U2F0REdWVlBOVGs1TGdUbjRydEdZYm1JNHNZaTVZY1pRUkxNNkk0YkI3V0Zj?=
 =?utf-8?B?cEFaK052aGt1ZjRsV0RTa3JnZm5NOWpraWlkLzBuZG1WS2VhTzJYNXdDYTBx?=
 =?utf-8?B?a3NjTXdtSW40SGtYUGpaV2hIVmlKZjI2VHhuN3ArcHZJdlE3WE96YnZYT2ov?=
 =?utf-8?B?RkdPdC81dDZzNnZVWmxNZitGOHdPREZ1T0lQMGtudTdmM1NmUy9VRjBoQmdF?=
 =?utf-8?B?VnhOOU5DS0pQR0RBRnVnQ2RaeUF5QVdBSzRiVEhYeVQwMkdDT1J4N1hmWEN2?=
 =?utf-8?B?UC9EZnd4MnRKVzNZZWpUaGdlQW1rN2ZOZjBjMW9EN2J2Z283TUxNaDRzL0Yx?=
 =?utf-8?B?MUxvWmdoT2JjRmtCQzJ5eDNLQW1jZDNXam50M083VzEzSFV4RnB2bE85VTdu?=
 =?utf-8?B?VThLVUdlNnJla1FjL3p3bjhrUmFBa3l2bzJmRlRPMFNXbXc1QnFSRDhlMkx6?=
 =?utf-8?B?bnlWejRQQlAwRE1JbS9RNzc5WHlqVHRSenA4T1duMFV2M2NIM2V3aXgzK3VK?=
 =?utf-8?B?eG5iT3c1d1lDQkdiUnNib25RcnFXTWg3QXYxYTNwcHpHWDNjNzZNRGRHU01U?=
 =?utf-8?B?SWVBZnBXWW5rQk5WdTl3Tit6Yk9pdlhBTmltdjV2QUZKQjNDRzJmclUvZ1Fi?=
 =?utf-8?B?MUN2TUNzWjI0cmd1SmRXRk1yeTRWR0dhN2VYNXhHdjRSVXl4S3dnR0c4RG1M?=
 =?utf-8?B?TGhjR09nNkQ3eEpMbWhnZTlVNVE0OUFBMTMwNmZwY0ZqT2Y2aFBIYVM1VjNz?=
 =?utf-8?B?Lzk3MFdnRWUwbEJSRkV1QTJvdXAxZXIxSmdITU5GRzBEOFI5TXBsdUJOdk14?=
 =?utf-8?B?VHNPRlJqRU0wZGcwbFFCU3lzVUl3c2lTdUFKOFZSRWI1RlFNamxQOE5aYnJT?=
 =?utf-8?B?VlYvS2pHRlNsM1VzY0F1b1I1VTdWdGpxRWlxdFYreG90MCs0THdHN1U5SFBq?=
 =?utf-8?B?RU9ROTFwbEpFdEM4TzRpNWt4L1JiMHlLZGJERXBsdk56WlBKbnhkMTE5bEFG?=
 =?utf-8?B?aVgvMTJ2Yk41L3lueXZkM0ZiNWVsZUFydVhtUEhLcStaY2xNbVFINFBJMHFo?=
 =?utf-8?B?TkRHK2Rzb2EwNGxRelRybHNoTUd5ZS9PZ1hxcVRDM0RYbGF2MFFCS3M0OS8x?=
 =?utf-8?B?NTdQR2RzaGdjTEJzS2pGNTNId0YzZ3kwL2w0Z0JETGJWdjIvOHpTKytESzd6?=
 =?utf-8?B?OWNEcG5QZEJqdERRTHY4aVlmTEJLMTlTWXhvWTJwZGQrcFp1aSsxU3Y4bUcx?=
 =?utf-8?B?M0Mzd0Fqb2R1cERlNVV1ckVnM2RveExKMTRYRm5jemR0Nmh0b1FQYzlaa3ZQ?=
 =?utf-8?B?UzVHVGhRWHJraWUwdnVIZHlIVWZzWlJGOTNCL1RPRnY2RktRV3dqVzZ4UnVS?=
 =?utf-8?Q?DBODfw/I3iDeb6XGDZjYVVqD0ARowVX/Y+kVNiP6XeL3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DA96F7C657E744798D99BFAC7EBD542@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb9333e-1e60-499e-8e3b-08dd3a805a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 01:01:49.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Isyw/0xYxJ/gxlKHQdWIaQlSzkZVb+lU7qenzMyiHWGQ8IO0EYWBAqzx4H0Rvnw9xn5K1mUBdTmhZQSempN8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

T24gMS8yMS8yNSAwMDoxNSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEN1cnJlbnRs
eSwgbnVsbF9ibGsgaGFzICdiYWRibG9ja3MnIHBhcmFtZXRlciB0byBzaW11bGF0ZSBJTyBmYWls
dXJlcw0KPiBmb3IgYnJva2VuIGJsb2Nrcy4gVGhpcyBoZWxwcyBjaGVja2luZyBpZiB1c2VybGFu
ZCB0b29scyBjYW4gaGFuZGxlIElPDQo+IGZhaWx1cmVzLiBIb3dldmVyLCB0aGlzIGJhZGJsb2Nr
cyBmZWF0dXJlIGhhcyB0d28gZGlmZmVyZW5jZXMgZnJvbSB0aGUNCj4gSU8gZmFpbHVyZXMgb24g
cmVhbCBzdG9yYWdlIGRldmljZXMuIEZpcnN0bHksIHdoZW4gd3JpdGUgb3BlcmF0aW9ucyBmYWls
DQo+IGZvciB0aGUgYmFkYmxvY2tzLCBudWxsX2JsayBkb2VzIG5vdCB3cml0ZSBhbnkgZGF0YSwg
d2hpbGUgcmVhbCBzdG9yYWdlDQo+IGRldmljZXMgc29tZXRpbWVzIGRvIHBhcnRpYWwgZGF0YSB3
cml0ZS4gU2Vjb25kbHksIG51bGxfYmxrIGFsd2F5cyBtYWtlDQo+IHdyaXRlIG9wZXJhdGlvbnMg
ZmFpbCBmb3IgdGhlIHNwZWNpZmllZCBiYWRibG9ja3MsIHdoaWxlIHJlYWwgc3RvcmFnZQ0KPiBk
ZXZpY2VzIGNhbiByZWNvdmVyIHRoZSBiYWQgYmxvY2tzIHNvIHRoYXQgbmV4dCB3cml0ZSBvcGVy
YXRpb25zIGNhbg0KPiBzdWNjZWVkIGFmdGVyIGZhaWx1cmUuIEhlbmNlLCByZWFsIHN0b3JhZ2Ug
ZGV2aWNlcyBhcmUgcmVxdWlyZWQgdG8gY2hlY2sNCj4gaWYgdXNlcmxhbmQgdG9vbHMgc3VwcG9y
dCBzdWNoIHBhcnRpYWwgd3JpdGVzIG9yIGJhZCBibG9ja3MgcmVjb3ZlcnkuDQo+DQo+IFRoaXMg
c2VyaWVzIGltcHJvdmVzIHdyaXRlIGZhaWx1cmUgc2ltdWxhdGlvbiBieSBudWxsX2JsayB0byBh
bGxvdw0KPiBjaGVja2luZyB1c2VybGFuZCB0b29scyB3aXRob3V0IHJlYWwgc3RvcmFnZSBkZXZp
Y2VzLiBUaGUgZmlyc3QgcGF0Y2gNCj4gaXMgYSBwcmVwYXJhdGlvbiB0byBtYWtlIG5ldyBmZWF0
dXJlIGFkZGl0aW9uIHNpbXBsZXIuIFRoZSBzZWNvbmQgcGF0Y2gNCj4gaW50cm9kdWNlcyB0aGUg
J2JhZGJsb2Nrc19vbmNlJyBwYXJhbWV0ZXIgdG8gc2ltdWxhdGUgYmFkIGJsb2Nrcw0KPiByZWNv
dmVyeS4gVGhlIHRoaXJkIHBhdGNoIGZpeGVzIGEgYnVnLCBhbmQgdGhlIGZvdXJ0aCBwYXRjaCBh
ZGRzIGENCj4gZnVuY3Rpb24gYXJndW1lbnQgdG8gcHJlcGFyZSBmb3IgdGhlIGZpZnRoIHBhdGNo
LiBUaGUgZmlmdGggcGF0Y2ggYWRkcw0KPiB0aGUgcGFydGlhbCBJTyBzdXBwb3J0IGFuZCBpbnRy
b2R1Y2VzIHRoZSAnYmFkYmxvY2tzX3BhcnRpYWxfaW8nDQo+IHBhcmFtZXRlci4NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
