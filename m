Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA9230BE9
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778836; cv=fail; b=q27WpzVEp/AfLNRniUivIj+no1jClNHh1owi8Kd3rLJ0z/VzGwUQ89gLh+gX4M7T38j8GT1ArjjvI6NRK0LXk74mlP+gRrAOFlnPyDdEHUnkWdRCAytHIAHET+2Nizl+HDbV2D7lJY6TbqX/MXaQAVPn+FjHhzpIZ9lk2dBCHI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778836; c=relaxed/simple;
	bh=ROT1TNjT2QgsDQ+3HNIk7xpC7ai/KHp9Gy2hCYfIY7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+R56o41JYqHyrFP/lGtwqiSkYUIw4XaDT5hLuqFuVENbqYE2skUblq10TN5CTzfNW0+VHLtSrvSspXk3nYGLJvFTBIv20nMQ9NFbX4Cp09JFqM1gtBMKC/qMvl+qVup8JFH1zCfRFiBl6uGtPBirqKrC/v/6gTYSwCXEY1/eO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HN+UauVL; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HN+UauVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARnPfS9MV+9tUueYOJkslARW+5eBXlg1PTLagp3NLfsMe/3cGPyhCGovieKDxeSJ7nRVA9mM2Vi9Hc0MhUABgBG34WPRpjhGKeQmA6O2CDF1StAmD1E9Y4axMyP+0Vyw/1QnDxV+gG0ujGcQMNKPvGJnt+24uPNGOPsyoGAcb0PoOtoysbgP63rfuFdOJuM/aRHsf8gxFCxl6y7LyELWgwIuEwKUJSMgLlQr+12C4kFsBTJr4HYH0qHI8oBscCWLtGTN6FDOh1yUKs5/pfTFyPv42N869ga/PntE0tHcyd9fcOaOxMc3uRXvbDQmsov+BO+zx8e+t/Hqy7vyra3Vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROT1TNjT2QgsDQ+3HNIk7xpC7ai/KHp9Gy2hCYfIY7U=;
 b=G2+7ci5I328sexZdchI8OfLHJtW2aQBFTssL6m+5A5BWesy7PEV729XQxqLIMqXpX1/LEHRdY1PdahM4TukbUT7p0lesyQL8lXUyEWJnp+VEhurMq+Znsg7HCbFOVuiyHJ0gJS6cOLGkcHzljtUseW/tXVdK3Hz83BpWiiv6tBudhOci83iIF7g27fQCXo1ew/S5vLiJFk6DDPmAu/EwCM4jB3xnIR0ZmO+uGEo8zYQwBK/gXcd9mI9+J1JOkEoqmNlxvvS13iB2tAHPNpiKdQsOF2OmfKKrCkMwRByfFE30o8prWugdb8H6ikI61NT8BvDR1sHa37E3a7wJ97LFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROT1TNjT2QgsDQ+3HNIk7xpC7ai/KHp9Gy2hCYfIY7U=;
 b=HN+UauVLa1LcFB2GptQ8ytrXQJP2Juo0SFVUivnPRg6t36cQJbpNHZWLoWDv7eN/0aarvb9PAWSxWuAO8fgzE/od2OrZieTMCmue/jiM7HqGjEEcR7XHkrQzHoS7ma04zktlL5+oYkd+CRzBzDVthXxuAmpvIxoUC/TJ68CyYKhTECMSlgU+3PGdwHAkcJwmWuIU3y8TnrvvLatX9wx9GHlb0GP6S4V91Da2ZnnLaNVa+gcu2rboc+FYcDXzUknrJcnteVZ9vq0cHCsjX/YTWplpWrfQhniEJhgIw/G6KxcpTF3bSy4FSJMkz+72sB0ANqjnJjWESpfX0r6M/J2TXg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 23:00:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 23:00:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Casey Chen <cachen@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "mkhalfella@purestorage.com" <mkhalfella@purestorage.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Topic: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Index: AQHcSRhauqXv7enrvU2FX6HoDAYwUrTZvXOA
Date: Wed, 29 Oct 2025 23:00:29 +0000
Message-ID: <65062542-e87c-4026-a58a-d5a29d03b8c9@nvidia.com>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
In-Reply-To: <20251029210853.20768-2-cachen@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7301:EE_
x-ms-office365-filtering-correlation-id: 95a7d3a5-7a92-44aa-a57c-08de173ef506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVhEeDI2YllqYmgvRGQ5bnQ5VUVPdnZCOVpQVHh2bTh3SThJcEZpbzVuMS94?=
 =?utf-8?B?Rjc4YVFmc3hvWThwOSthdXBuR0N0TGpRWXhXeU5xYXpvbXcvTGlibUNKYVht?=
 =?utf-8?B?Y1BuOEc5RGkyTHNERFhNOU04dVpRdFZJN1N6Tko5Q1dBWjcwK29YdWFOV0FH?=
 =?utf-8?B?VVEwa2xFemtwdWIxS0hwOXRKRXZFa2xxWitqdzFNRENERlJ0K2JpbmJ4eTBM?=
 =?utf-8?B?K0h0UmJpTW1Hb1ZsZVpaNVB5OGVtQnZtMFVvUWJCS0VRdXBRemQ3RXpSZG5E?=
 =?utf-8?B?bnRrN3FWelFyVFlrOE5Fa0xJWjRtck9PQnM0TFdPMHJNemdIbC9LdUNNMm85?=
 =?utf-8?B?VnN0dW9XSDlxcnp5QWozTHBJL3p4Q01rbE5ncVFVWWhwUTBuZkdjRVFKVDVn?=
 =?utf-8?B?TzFYb2R5dVBQVjAzVEpxUlZuTlQ2dy9FRWc4L1RISk1pejFsV1ZCL2RHaW80?=
 =?utf-8?B?WTNheGwwZTh3UWtjV0EzYmtpc2FncFVlM3cvTlZoOWhXUzl1M1VWZ0ZTQ1U5?=
 =?utf-8?B?Q0JHMlBhMnplcHAzMlN0Qk9FbzY4VEU5ODVzdG0wYnRQcFFzUUlBOXBBZFVo?=
 =?utf-8?B?REdRWE45QUVWWkRZOU44UWFVbzBaSU1qZFdUN2p1NTUybncrSEIvZ0IxK2g4?=
 =?utf-8?B?alk0aWZBVUhTUXdzaEFITlhQSUdDclBsdkRYR2RyM2ZOaWVhemJkTlRkR29D?=
 =?utf-8?B?bkU3SGdvTCtiYXNNK3IyRmNMNUc3NDBLUytsZWRsZGZZK3BWZmxGOGFBT0Fa?=
 =?utf-8?B?SVRyT2t2VVFHY1VYTHRJVEQzZ3FZRzVWSUxxS2hGeXRxczZKNGkwWlpJZzdT?=
 =?utf-8?B?U3VVK0xxdkxVM3FxYXc4YkhyMUVTcVNXdTVWa0t2LzlNMUlER2Z0VUxtYzNU?=
 =?utf-8?B?cEZ5akxYUmQ0SHBOajU3aVVhSDBMbi9KZ0hoVm9EcGc1dFEyY0RDMUMvRitB?=
 =?utf-8?B?dFpzUGtTbm1wT1YwNUUzVFlETEFFKzM4RElMMGE1eVRmbGpiTG9MMWkvUVVE?=
 =?utf-8?B?ZG1NTFZGYmpBZG1mNFdCNFFYbWt1b0ZINHdFcnNnZ1R3OEN4T0dxbXJIaE5Y?=
 =?utf-8?B?RHFsZG5rTkdqRnB1N3dzRXFDZkdoam54QXZ6R25IUjluQlMwd2lWcHk4OEpa?=
 =?utf-8?B?REZhZkZGSUdKemNLOVo4aVhsYU82MjVBY0lxcXpsZldkTm9Ja3RUREc4c2RU?=
 =?utf-8?B?K2FXbW1ObmFQdnVjQm5STE8zVEJYa2duczJ5QnBJN1M3TU4zVHdWb1JJRzBO?=
 =?utf-8?B?dDM2Q0lIb0wyUks0bi8wYlBWVTFyVjNhRHRQNjR6TXpUd01IT0xLQmlTd29Y?=
 =?utf-8?B?NUZpT1JUKzBPbzJBVWRiUUU5MS9ROXVoek5EVDk4djJieVlyYjlPRWplZjNx?=
 =?utf-8?B?Ym5zaUZsbDc0bHdtUlh3ekxiL1lqRlBNK0ppWm9NYjJRYjNVaW5qb241RlIv?=
 =?utf-8?B?ajIxQThOSFhCamFaT3JkbjVQaDZnOGVZSjBPbVhzeU11SFRPQ1RmdS9pcUl4?=
 =?utf-8?B?RlZjaW83czhteDNDMlNLK2xGZFhaZzg0czBtQThpVG1tS0VWU1dpTjhOY3I0?=
 =?utf-8?B?aWNGSnh6VFI4MTNZa3lMcDVLWEljSlpLWm1MaGNWY0ZLWmdKeUNwNGlpTzg1?=
 =?utf-8?B?eHM2WE1LMlk0YTZGYmlRV1VPeFRmeGF2VFZqQVlpRkhtRmU4NHV4RmZDbUNZ?=
 =?utf-8?B?MU9aWjVUcCt0d01sZnhTdi95cGREdkcrcmdiVnhUSmxUci9BMG91Nno3OXZs?=
 =?utf-8?B?R2Fxc3RZSEs5REduaVBvL0VEVElUcE5KZ3FsQSsySkwrOVJxUUNEVDhBbmpo?=
 =?utf-8?B?MDEyTzREa3dLU2Roa1hycXNjc2MzU09UNUlpSEhsWnNmaEVWVGladWlDSFQ1?=
 =?utf-8?B?RjdJMkhndGxrbklhMjkzU0FJcE1VQUlhaHl2VXl0bDRBa1UzemZDdWk5S1RR?=
 =?utf-8?B?WmdvTG41RERPeHBQQTZMWU5zWnc2cTVpd3IvdnZGaHFjdGgrblNuQUwyVmht?=
 =?utf-8?B?ZzZCSzdaYzNueXhabGpjL2V0OXVOMFBydjZxb1k2OFRvbmZhNXFOVFNHQnpS?=
 =?utf-8?Q?lRQhTt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEV6ZXNvMVZmVzJ3TUNEd3UyOG9Fc1NRV0djbWgxNk1sanlGbW92cVBmL0Yv?=
 =?utf-8?B?TTZqdTQzcGQ4NG0wYWs0Rk9RakNDd1ZxK2p2aUllYWljbWZVYmdPWGgzc2dj?=
 =?utf-8?B?dVhaaWpZZGVIa3JrNXAxTHFEcDlKLzlmSTF0YlBkMW90ZGRmOGthWmZVRWFp?=
 =?utf-8?B?VW04WG13QklpYzcwNDlEZ1BTUWhUZkk4YmN6SzRiUG9TV1ZWZ2dTZXdFVEZh?=
 =?utf-8?B?UFh2TDBNMkhiMDZDeVUyTk1iZEV4ZEVMYzBNRGZDR1ZwckpITG9QZkg3YWE4?=
 =?utf-8?B?eXJuemNyL2dIaDVFcEc5N3pERTN3ZDRuYTNXVnViSXZuRHZrc3F6Z2srYmY3?=
 =?utf-8?B?MUh6NzMyaW56dUc5V21OYmdrTU5aOHNLNjBEZDFFT0tmSXBEUTA5V29DWmpS?=
 =?utf-8?B?QnV4dEtOaEZ0V0YyNnRHa3JFcy8wRzlzMUQvREpreXJaVEhaYzlkNWcwRS9Z?=
 =?utf-8?B?eTl6Vkk4Q1A0T0w3YmJNYTNEOHBTV3MvV3JaZHJBK2dDNzRKTDNkRCtEaG9v?=
 =?utf-8?B?ell2Y2FxK3p4M3FHWTV3MFpYNUQ5NFoyaXBoK0NIU0x1UC9PU096aUZEMFJm?=
 =?utf-8?B?dElHRXJiYWp4Y1FZdnIyd1VjMlNHYzVHUXdBL2pZVE9EN1hDenl6USt4NEx1?=
 =?utf-8?B?OWhuYUIyMGdNeTJzTkxMamJCbXZ5YXo1ZkFWZDkzZHAxbldiOTJMbDRzV2FC?=
 =?utf-8?B?d3RCUmF6b1dkb0R5SEdqakNFYmxsNTZBdVk2eUxzNWU0TmQzd01jK0poc2g0?=
 =?utf-8?B?QTRTVUtZNjNpY2k2bTczUnkreGtSZXA1azZrRGtFdjQvWDc4NkgvTWhHV3kv?=
 =?utf-8?B?cFo2RzZDaHVWQVJTZ0lyUDRUeEFuWDQ5L0I2NXA4VFZOeXp6ZUp3UXYrck4v?=
 =?utf-8?B?MTh3SG5qcEgvYmc3bFRVd0U0elIwZ0NteDZGa3JCWS9KTXlpNHJPNnNIMHlP?=
 =?utf-8?B?b0RxbEJrbWgxUk9XbUVZcFV6eGRrWGk5L29jK2FVeVQrVUlRUVlua3gxNWxD?=
 =?utf-8?B?UzJXRWNtaGQySW5pVHBmN2xsUUVDOVFrNzhYbG9BK3VVYVNYMkdvUklzNkFI?=
 =?utf-8?B?MVdmVlJmRE9ta1VxeGRGQmVjMXQ2MllRek9IQ2dVcGx4bFAzT2R4MDFnLzJ0?=
 =?utf-8?B?OWI0aSs4NGFmQURNTnVCRDlIeGhoajJJQjBrN2c5M1JKUXhqaVRSdWx1cUIr?=
 =?utf-8?B?dk56Vm5EcGQ0Qk95S3BlU1NMKzgxbUZDdFRYUThiNm80eTAwRHM0cHd4SS9C?=
 =?utf-8?B?OGxqaktkTW1xT0tlanVBMERpYTdRbGI2NlRZY09nQ0NuVmp1RWo0M1dzUW14?=
 =?utf-8?B?U2d1Q2ZYaEJJdk5JR3Q0NW96K3lkWmlHK0ZvR011cDRFeVExOWhienRwNXdO?=
 =?utf-8?B?SDVOcVhoVDFxcGVRVXZicjlyM25IRmxCR29tdDdqbTVQT21TZ0VGNzJ1WHc0?=
 =?utf-8?B?alFQNUN0WkRNSGNKWVNuWUlKY1NrV1dZSHR0RmR6QnNtYjdybEFIMzlURzhL?=
 =?utf-8?B?NzZhd2xQRzV3SGhWZmM0YzVYSWFDNk16NTl5WXpOVUdvYTJWUFlNclA5cytj?=
 =?utf-8?B?NXFzZzJDVVRTSXgybGlRRkt4YU5DcmVPb3U1OWREUklqN29iV0FyeDdtUmlh?=
 =?utf-8?B?aTFzeVdhcmZ5WG5ac0o3RDVScnpiV2lkM0FsVHdOdzh4MlhGRk9pMDVDc00x?=
 =?utf-8?B?TFVud29rZEVnTkJqUmNZTkZBVEhXZnhnOUllcFV6QkMwTGtUZzRQejRYSGcx?=
 =?utf-8?B?bUc0NVd5SEJrbldReGg3WTgxbERiRWtwaHVPeEpIdWFaRWJTYUdSSnVBem9M?=
 =?utf-8?B?VFFvSzJEaWJpMHU3cnJhYnM0YWt4R3ErYVRaSjVVcjl1SnBQYTQ1MDF4LzB6?=
 =?utf-8?B?Wkc0ZTlUcnZwQ3F6NEUyWHlPZVlUSTBJSzdiQnpSWWxUSFUwZDFLWXBYK2hu?=
 =?utf-8?B?eUR5dnVIdmpvcjNoSC9XblJ0U3U0M3FCVzI2SGtpZTIzN2ZNRDZxV1NyZnVB?=
 =?utf-8?B?L3NFWGJ6VStPTmdWTmhWTlZjam1aWTFLUGU5dnA1cmR6algxeCtuZThrMGdD?=
 =?utf-8?B?T3JUdmlsUmJxYUg3eDZrTTVvaG5PSXVwMzBPdmlvWVNockF2U2pwbTBmblZB?=
 =?utf-8?B?Y0J3SFJoRXFacCtHTTN5RG9NWEkxd3JyWXVWcEJDSE84V2VMY0IvN1RUSTF5?=
 =?utf-8?Q?szIzELVQfotrJLzxaRgrAVHSKuaJjVeAFCcMVsQkY7sO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6304A9C020BA6D43957BF3C64ADF5CD0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a7d3a5-7a92-44aa-a57c-08de173ef506
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 23:00:29.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 246+GZtU5pPFSywjS8um4rwtWcBKMZmigz6ZDfQqikFo5lg9n+8QVrfwnATXJuatqmDQn965OJp/NyQS6IbsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

T24gMTAvMjkvMjUgMjowOCBQTSwgQ2FzZXkgQ2hlbiB3cm90ZToNCj4gRnJvbTogWXVhbnl1YW4g
WmhvbmcgPHl6aG9uZ0BwdXJlc3RvcmFnZS5jb20+DQo+DQo+IFdoZW4gYSBjb250cm9sbGVyIGlz
IGRlbGV0ZWQgKGUuZy4sIHZpYSBzeXNmcyBkZWxldGVfY29udHJvbGxlciksIHRoZQ0KPiBhZG1p
biBxdWV1ZSBpcyBmcmVlZCB3aGlsZSB1c2Vyc3BhY2UgbWF5IHN0aWxsIGhhdmUgb3BlbiBmZCB0
byB0aGUNCj4gbmFtZXNwYWNlIGJsb2NrIGRldmljZS4gVXNlcnNwYWNlIGNhbiBpc3N1ZSBJT0NU
THMgb24gdGhlIG9wZW4gZmQNCj4gdGhhdCBhY2Nlc3MgdGhlIGZyZWVkIGFkbWluIHF1ZXVlIHRo
cm91Z2ggdGhlIHN0YWxlIG5zLT5jdHJsLT5hZG1pbl9xDQo+IHBvaW50ZXIsIGNhdXNpbmcgYSB1
c2UtYWZ0ZXItZnJlZS4NCj4NCj4gRml4IHRoaXMgYnkgdGFraW5nIGFuIGFkZGl0aW9uYWwgcmVm
ZXJlbmNlIG9uIHRoZSBhZG1pbiBxdWV1ZSBkdXJpbmcNCj4gbmFtZXNwYWNlIGFsbG9jYXRpb24g
YW5kIHJlbGVhc2luZyBpdCBkdXJpbmcgbmFtZXNwYWNlIGNsZWFudXAuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IENhc2V5IENoZW4gPGNhY2hlbkBwdXJlc3RvcmFnZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFNlYW11cyBDb25ub3IgPHNjb25ub3JAcHVyZXN0b3JhZ2UuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxMCArKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+IGluZGV4
IDhkOGFmNThlNzlkMS4uMTg0YTYwOTZhMmJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+IEBAIC02ODcs
NiArNjg3LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9mcmVlX25zKHN0cnVjdCBrcmVmICprcmVmKQ0K
PiAgIHsNCj4gICAJc3RydWN0IG52bWVfbnMgKm5zID0gY29udGFpbmVyX29mKGtyZWYsIHN0cnVj
dCBudm1lX25zLCBrcmVmKTsNCj4gICANCj4gKwlibGtfcHV0X3F1ZXVlKG5zLT5jdHJsLT5hZG1p
bl9xKTsNCj4gICAJcHV0X2Rpc2sobnMtPmRpc2spOw0KPiAgIAludm1lX3B1dF9uc19oZWFkKG5z
LT5oZWFkKTsNCj4gICAJbnZtZV9wdXRfY3RybChucy0+Y3RybCk7DQo+IEBAIC0zOTAzLDkgKzM5
MDQsMTQgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
LCBzdHJ1Y3QgbnZtZV9uc19pbmZvICppbmZvKQ0KPiAgIAlzdHJ1Y3QgZ2VuZGlzayAqZGlzazsN
Cj4gICAJaW50IG5vZGUgPSBjdHJsLT5udW1hX25vZGU7DQo+ICAgDQoNCndvdWxkIGJlIGEgZ29v
ZCBpZGVhIHRvIGFkZCBhIGNvbW1lbnQgYXQgYm90aCBwbGFjZXMgdG8gZXhwbGFpbiB3aHkgd2Ug
DQphcmUgdGFraW5nIHRoaXMgYWRkaXRpb25hbCByZWZlcmVuY2UgP8Kgc2luY2UgdGhpcyBpcyBz
cGVjaWZpY2FsbHkgbmVlZGVkIA0KZm9yIHVzZXJzcGFjZS4NCg0KPiArCWlmICghYmxrX2dldF9x
dWV1ZShjdHJsLT5hZG1pbl9xKSkgew0KPiArCQlkZXZfZXJyKGN0cmwtPmRldmljZSwgImZhaWxl
ZCB0byBnZXQgYWRtaW5fcSAlcFxuIiwgY3RybC0+YWRtaW5fcSk7DQo+ICsJCXJldHVybjsNCj4g
Kwl9DQo+ICsNCj4gICAJbnMgPSBremFsbG9jX25vZGUoc2l6ZW9mKCpucyksIEdGUF9LRVJORUws
IG5vZGUpOw0KDQotY2sNCg0KDQo=
