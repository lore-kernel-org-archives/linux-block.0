Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C635966
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815445; cv=fail; b=OVc/uLo+cqId1mgdVPY88Cplj11MX9/F+Q+RIqPi3tW28GHy71IlzSImS45gXff/OJcBLrDSbStaFavBJcRy73/71FkPdIhXqNOlpZwf0YY38+cCMYFDDE9iLK3wA06tKvwoNl785R1CK10dh4syONFCJdFkeRQg1R7vAC3d6mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815445; c=relaxed/simple;
	bh=yRswz2Nolq2JGaW9qzAEunx83g+xd6EJVKUR0nVtQIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Id9gOAEzvDderFapTawlE6BwONmMoMMbweS9pQr0Cp6q2GMOIi24CXGWff13Seg8xa5xlr2jhDU58aaEUoBXqNHQNvOPYS7+RUqQdcHYfprWxGHeAP2eUePFu1pbSWfPV0dT5zB1J+MUaLSMYdv+Iti0KrTJRMTISF+GYk52qkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cGIbUiTD; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cGIbUiTD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtSVu+QTGs2p29sB+M3BOaPQtJFChT+tNzq3ihk8+bgWZ9a1QlIvMb0td4rj/EaXCKXn6KVsTra8RIDnp/yEB5Xedl3G29ESlkk1poZSGjkoK45MGcrJULCjk1/d0ZiTMLYbtnmZaKJXuqBJUpaNAFlBLEq1ynWz1IIR2b0pcZGDMyR1pJBBGdvuyfcJWJQKpss6hNqvl/tyhx4anNUrWxmigBlWN+OigC41rJAzYoTxSSQQajaW/ag2WnZH3sHxPxaks7Wg/cZPMI2BPDqa4lYRoDyO83kpab+4OnqKaJh8Qo8eNFRHwsHNUU9rObwLHFElfq9h25IYzhRSb48CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRswz2Nolq2JGaW9qzAEunx83g+xd6EJVKUR0nVtQIA=;
 b=awcfkTT3UlbyyLfBYU7DGPPKksGppCB86QNw3tfAPIpS7imRubUabOVpuB6wc5rqyMepisKXKreR4SUbhaCMhSBV0C8RiKAPk/gM2OLTZtX9DJA+HHH2udD+dVJrN3p/wPRM1Av93Ys5ok6HoO8pF3qHpeFvITyuDBWaL4X7ncKaeAAB8iB3+Ut9lE+Pytz2fObGWWKSRw2xk9j4l8sh6Zs6lZyQWuajrx7wbhsyXS73CEu5uWj7Ffc9tSWocOaI9YSt8KiJ/HfAl0h5QTa5+ILqPyxawVumDTgC4mZGP6S2fCmw1TFoqLnAH3Nx/bHlhkB4mLxrJYvcHjLk9BfrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRswz2Nolq2JGaW9qzAEunx83g+xd6EJVKUR0nVtQIA=;
 b=cGIbUiTDUwqJ7tN5ickLwyvGrHMGBCvTf2TekjRartX2h4jzHsmw/eA3K3TMB6vXnVUjZnvoVHy1S+Veal8otsy76OnHFRCYK1FSvXz+WCZsej3DU8wt+L6QqOvBRQbpiwMFw2/JT8YnvfjW/HxMi8hZ0D5DLfNW3+ep29K38G42dY6zKP93FnhQGQoVJVVEnPliyM3j+3gtpHo76QNTu7nShiHUuStdThLcQ6Wm7f+GTlZ/obrLTsAQ5wE/WHAlOB4l+a1s4/USdDaX28WJakF0PhzaU2cBr/FPWZ8Ze/pSK06od6U/4AIpY0eR00Ct2ZQcX2GBzCA0uLJfOuwelw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 00:43:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 00:43:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 1/2] block: Reorder the request allocation code in
 blk_mq_submit_bio()
Thread-Topic: [PATCH v3 1/2] block: Reorder the request allocation code in
 blk_mq_submit_bio()
Thread-Index: AQHbUZMcZNaoOddRWkKiI6uJMo9ZJLMVl6WA
Date: Tue, 14 Jan 2025 00:43:59 +0000
Message-ID: <ec56727d-d78c-4b87-9dfb-f70365ce29cf@nvidia.com>
References: <20241218212246.1073149-1-bvanassche@acm.org>
 <20241218212246.1073149-2-bvanassche@acm.org>
In-Reply-To: <20241218212246.1073149-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6095:EE_
x-ms-office365-filtering-correlation-id: 5c8d5455-fbf3-49ca-0e75-08dd343488f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTFYTHBMRmZxTWdRYldDUmhUNXJCNktMbDBQS09Jd0FnaFVEaHF1dHd3Ylpv?=
 =?utf-8?B?dmdURThIWFNJbnhZWjErYVIxelJTaXRGcEs0RFBtb0V3aHNzc3ZhN0dJaTdx?=
 =?utf-8?B?bFNCbGRzU3RMZUIrY1AySWlHampHdkxLdmNIYzZ6dUMxSWJtSmJxVWFLYklE?=
 =?utf-8?B?U0RIaUw1VzVNNEovV0lYZ1hZSTIxMGxMR1U2REpxNWdPUTRCZ3VsZW83TkNk?=
 =?utf-8?B?ajF5T3dybFF1RWt6dzBwcmdjWVYvWWNZWFFqaC9ZZWhUVkJkQTVwaFo1Rkp4?=
 =?utf-8?B?cXRxY01KU2ZNQWh3UWU3NDI0K0xkeHVmSXV3enpEOFd6U1BHYjRPTGEwbEtj?=
 =?utf-8?B?TEZsc3lnTzB1WVl5MFVCcEhuS0xONTI5dHNZMVJ3dzhweUpWRjluT3IwaDRs?=
 =?utf-8?B?U3dXc3Ruc2ZNV2pkTC9Ya3hTN0JOeVUvUWpFajdvcHhXKzMvUjl5Yk5INkhE?=
 =?utf-8?B?VXF6SUgxZXM1L3JqUGptb2llelorLzFnV2JEOVRqYktZY1RjUXBWVXFhRTls?=
 =?utf-8?B?ZFFNRDV1amk0OHc5dFhsdFZocjlJY0dXdmhpdkZLNTY1bEorUUxxaWk0eUtW?=
 =?utf-8?B?ajM1VWYrLzVYRUFoTWV4RzdLQlVUMlAyQVQ3TTlSNHhSSWJRWnBPTkxkNFcx?=
 =?utf-8?B?QkRLQ3kwU2dJSEJjaGx3VTRublJEcjdmV1VianpiOE1CUWVVUXdlanI4ZGcv?=
 =?utf-8?B?MzBMWCtvdjU0V0hrOUo1MmE5U0FpekZyTWxhdEF1VWFDL1NvSndGS1N1SW1F?=
 =?utf-8?B?Y1YvUnRMY00vYjM1MTV4UkFCaThocHRNSGpEMFMvMmJ5NGlLOURnT243ZDdS?=
 =?utf-8?B?TkFldFRCS0NOMVc0MmVydm9pTkVYZnhWc3FZQ1RCajROTEI2c1U0WEdVRzhN?=
 =?utf-8?B?ckZ6bVp6RUFJYmgxcTZtVGpEMjBKaDBjdzU0clBpSDUwcE5nY0IxZ01JV1hS?=
 =?utf-8?B?T3ZGaCtsaHk4cTh4RGlidkRudkxhUk8xcDl3TURTV3g4UTFuVTBobFgrMlpK?=
 =?utf-8?B?K3hjbWwrTDdZWk9HUW9YY0JXUWM0RnlycHA5ZUVxYmo0UTVBODFhVlVxV3Bx?=
 =?utf-8?B?VWtEbC9FTkxDalRUVmFOU2t4NU9WbW5EaDhTKzdYZUtJUi9DVnBSb1hHYWpJ?=
 =?utf-8?B?Qk1YQzdRRDRuSzFBck5Bc1lncnhuTXZ3M0NMWE5kMWVOZTZNOFkzMlNzeEEz?=
 =?utf-8?B?RENVQ2M4R0ZPMkMrdTg1enBYU1dZWURYTi9GRDlDQWlWMzk5cCttQWlyUFJl?=
 =?utf-8?B?RGU3SkFzVEU1Z2xXNTJqVGI5RVlyR2RlZXVzNWZMSlFhTENjdTdEMW5HMTFK?=
 =?utf-8?B?eVI4M0RiVzlrTUY0MFBmcExYY3gzY0tPL1B3MFE2bTZvdG03VEJoT3REcjdn?=
 =?utf-8?B?MnRXaUJSQTh5MUprZFM1VnJxSUErV0grV3hWUzFxbzZkMFltTjlVS05uREx5?=
 =?utf-8?B?Nks5MDd3Tk1ySGpPUTljVWJPdGRIME1idEtVdFhJY3ZHVVNXcDF6bmN6RlpL?=
 =?utf-8?B?MlBwcTkrNWp1cTZNdnR6SzVpSEFVd05sb0Y0Nzdla3BJQkhkZHNGT2JYZGR2?=
 =?utf-8?B?QWpLRTNXdzhDTFdPSVNheE9xdGhmL3p0d0Z1VEdnYjAxUmovd2lqVk4rTU5r?=
 =?utf-8?B?VmVwZ3NNZlhSMHEwTEMwSndORTNxaWhVVGdYVU1ZdlhxZmFsMldJL1pPMGkr?=
 =?utf-8?B?RzdlUEVtN3RQWlZuZ3p3L0NWWDRCYTk1R0JLMUlZb09kaXQ2Unc3MkZpakpR?=
 =?utf-8?B?b1l4bml5d000UzVYOHJ0SUdHUGFzNU9PaXdUYzNMaWs4eE5DTEhVcHd0M0RV?=
 =?utf-8?B?UGY1M3V3NTY3T1hNOUpNNG1QcTRqQmhKRUZEUHJQQTNTKzhOTlk4eUtmOVEz?=
 =?utf-8?B?M1hxUXZTK3dwUUpGYVR0V21UTmRxWkk2NkpHeDBIR0x1aXJZQWwvbHFIc1N3?=
 =?utf-8?Q?MO7Gz4mxl2U4uF0tO4p3J55G9rqInmuy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0orY08xWm9Danl1d0x0NjlNTDZwSXZQYU1hODV1VzllUWgycTN3V2RVYjkv?=
 =?utf-8?B?Uk13UllvTisyMzZkL3M5a25QNnNiSVhaZzd5WEdDQ1ZNUGNCbVFJc0hseFZz?=
 =?utf-8?B?OUpOQkNrZm45dWVpWkJIY2Y4eTRTMFVYSHVWU0xQK0xEQ0lmZk45RU4wZy9R?=
 =?utf-8?B?QVg1UW5LRFRNdlpzTzVCYmx0ODBqZC8vS0Y1QzNaekFJaElhTGMxbWdjaStY?=
 =?utf-8?B?SWxSdUR5QXlDMjF0aEJvV20vUzZEaWRIckZnTkVIZ3JNQ0RyWDlLaTlZQWRT?=
 =?utf-8?B?aER4b3IzTlpQTGRNTk5KQjFrNWZCYTVsVDVZMnZwZFV6WHFhemJPZlVuQ0sx?=
 =?utf-8?B?VWUrZzZ6WXRjWWxMdHdhRnJweDcwUnZzUVA4TGpDZXBaSG1FWmR3akhlNXB3?=
 =?utf-8?B?S2x4aEUvU2RiWWw5UFdRR0ZVeWNhNTFRemRmZTJvSk9rUmJyNERoVjJseWlL?=
 =?utf-8?B?RHlpdmtiaHBLT2hKbXZXNzBHMXhGd1dscHVNYWRoZHlOTW16V2xGNnVrZmNr?=
 =?utf-8?B?NzkyZit1RVZFMHZPdVl6YmRFTE1kM1VSRVg2L1lwSStZTi90WGRiRHZHN2N5?=
 =?utf-8?B?TDRrRG1rYUN3VDBNcnZCWTFibGJOSlRGek1pMWVrUUk3V1ZmTGhGYThWN2pJ?=
 =?utf-8?B?Vjc0eFVHdlRiU1J0c0Zyb1UwZGJ6bSt6SVAvSE9Ob09jZktDVVFEeFRyZnpD?=
 =?utf-8?B?Mys5ZU9xdjBVb3VzNlVNWXd3TmdVdzh5azFPdElMOVdIRFIzNWhLQWtnUDly?=
 =?utf-8?B?RmNCZUZLRGx6U2N1bFZQcnY4bzJEZncxVE1Od2Y5dDd2cnJ3SC9Ub2RQN0Zr?=
 =?utf-8?B?bi81UDNDV1B6Q0RveURnUldBbUExT3h6MjRWZ3U3K29tUEluREgwOTlXUEpk?=
 =?utf-8?B?UnkwVWdhRGo2dXYwQW1BRDFLZld5ZlBpN2gzejIra05LU0NkMk1GTEdCK2x3?=
 =?utf-8?B?VEViSU9BYjNGNnlnV2tvTncwaktldkkrSzBsTEdEcDEwMUhZd3J3MHMwbkts?=
 =?utf-8?B?SEsvTHRqUEM1dG95UVVzTFJrUDUvajdhYUtnd1FSc1BpajExMGhWTTRBTjQy?=
 =?utf-8?B?NHRNVEhBZHZYOU16SkJuYk1ZTmhwUXpsSGVYNEJ2OUtsNXpaT2swdGpQcURu?=
 =?utf-8?B?ZGpvdlZaTG93V1hyRGo3S0FtNGg0eWRHNnVzSGh1U29rN01ubmlmdG45YWlE?=
 =?utf-8?B?b2ZqenVPb2ZMaVFITkxhbStZZ1BaWmNLYkdnbUZncDZYMm9Ea2c4S0UyVXBs?=
 =?utf-8?B?VHl4UDY1K2cybUdtaFNmMHJMdGJZN1hWSm9vWkt5R0lYdWxseUJyS3RLNEhB?=
 =?utf-8?B?WVpHalFHd3ludytVVXBpUjUzdTlScndpTHNJSTVJV0plc25iYW5Fejh0NlU0?=
 =?utf-8?B?SlY1TEhaRVRiZ3dGb1l1OVhoZGN6c3dkUWZhd2gzWFY3eHlQbWF0ZDBnMzhy?=
 =?utf-8?B?WTFtU0piWE9JQTF0eEJDQ0pNU3pGaVlhMVJtN21vcmRIQUk4Y2ZNZDluTUJV?=
 =?utf-8?B?RmtDdjBTdy8rb3VwSkI4Q2VHOUlmUVlDdElpRzZoMklpUzhRTmtjcVJyWkRa?=
 =?utf-8?B?eWwweVh4Tm1RSjRSS1BGc3pRM2dad25qQ01qSWxVWE1sWjJMaTlhbjdyellZ?=
 =?utf-8?B?VVVpbVJ2WksyWmdUekhBNzNkRE5FV1hPQ0NMaVlqRlg5cDJKNkt0dDlOcklI?=
 =?utf-8?B?UTJVN2tkOHF5SUVPSTM2Y2JKWTh4TDR2eDNYN0xwYm54Mnd0MytGakVYQ201?=
 =?utf-8?B?ZFBWY1RtRkhrdjM1akZEekx4ZHdJdnRpckRKQWtVUkl6QjFJNTFOZElPa3Jj?=
 =?utf-8?B?R2luT1ZMTjc3d3BPL3ZWOThnekg0Ym9Qdm9NREpCUkFMM1NxWHF6VXFGYlUy?=
 =?utf-8?B?R21HZDRuQjBDa1FVSE5nUENMQXRzM0QycE5sdEtpYityVXpQaEo3RFd4ZlNE?=
 =?utf-8?B?K2dicjJMZVYzQTRoK1lic3ZEaU9MTThIV3RkV2VIcEg2YXIxQmlmVDB2ZFZh?=
 =?utf-8?B?NGQ2VjJVUlkvQ0wwVDNialRCcnZXclFrNWlOMGlLM2U0ZUVoVDJ2QWt6TXZN?=
 =?utf-8?B?Vi9nU1pSLyszTWZ5ZDRPNFAvZ1JHTEVUQTkyN1k5cXJrZVIxdDUvejdpYXdu?=
 =?utf-8?B?TTA2SGRIUmQxUFBaV0VwdWZYNkRMRFBIUUM3NGN6Zm54c1FBQjltb2RDRzhn?=
 =?utf-8?Q?zXiCRq8Ono4u+ReJBImaEz6CZbliCOmp0ssp2uX+fL4B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F82B54BEEE2B3F4AB3876272DCA28439@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8d5455-fbf3-49ca-0e75-08dd343488f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 00:43:59.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vBj1q7BwOPo5F9wjursaJxKOmFQC4Z2OWc7c7lXVOT+97BR0RdkbvVg04DIpDnSHfxQRWOh6UrduzM8gveX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

T24gMTIvMTgvMjQgMTM6MjIsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gSGVscCB0aGUgQ1BV
IGJyYW5jaCBwcmVkaWN0b3IgaW4gY2FzZSBvZiBhIGNhY2hlIGhpdCBieSBoYW5kbGluZyB0aGUg
Y2FjaGUNCj4gaGl0IHNjZW5hcmlvIGZpcnN0Lg0KPg0KPiBSZXZpZXdlZC1ieTogRGFtaWVuIExl
IE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxz
dC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlPGJ2YW5hc3NjaGVAYWNtLm9y
Zz4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
