Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD713D897
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661194; cv=fail; b=DAuLiez0lO1kPPVVIMEUSKL7Wqz4vb6xO/ONUSwH/6NFlokPUafT0bf4aE+ywg+Y7cDKX/K0f4bw/0WqxGt/zxf6If3NASeabnUp+1qdCY2Hxx/QY7PO8icLfIihnrc+UEPKMJEN401UzT/wJ0fbF4OyWKZQfRw7Nt3vf8BxyZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661194; c=relaxed/simple;
	bh=1jUDR7kyrK/YB1yU3x9LbviKkUXwPDDAxZLl337j42U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LO3E9U45P56cv8C7EkBx/pHNAEeL7OQ7QpwKwk/JHRYtmNmmkE8sTVVGjjHTQeYkCm9IpnIBAQZb478M7ByIWkvaiAUpdB1vfbqEMJAm7VelhIurkXFNYx5cnPAqwidwqvPtrARMOlJ2RwSO/EU5kDLJkVL9VdvSqWFap80gJBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BZ7MZQoM; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZ7MZQoM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRdf/S+q6Vt4rQlpAL9dU+0zGzFy00hd54fS8tnQHd3VoWZ9OewGX/+NJCz6qm4+tXN9Yy9yiCg+CIoKSIq3QVh191B1IlyQnudDBbdQskQMQuQbkSKpi0xtbgdfkLd/Qkpjwt2OVVfpBV8mhWtRu/BsPcrublm3xCpJpNrnNTckogdlVAUeAbM+UVK1w1AbzMZKTuDKy0qg3/Gd28eTwqLUwZ/K4FxwpN89952LviyV7f1IBBDH2rWWrxW+SbuzIs/64cPHHU5gOip51SAea7eDHRiKT8ILy+gWwE9CMgbN0aibwlRE/DRPIqZ+o37jVQ/L7UMdUiJXjzScyuSkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jUDR7kyrK/YB1yU3x9LbviKkUXwPDDAxZLl337j42U=;
 b=i9/9JpsZRu9O8xpdSudzXUPq7P2kc8BkaX++diq5Ltb1biU+N/99onYWZw6uRRgcWM5UaOwuAUlJCwNdfSUxKk1WlV0zvr4jSZUNG0H8kdDK8HXiR6XO+p88Pr7zGyP+UmeqBdP7JCUso9R8FH8AMeI0YYRquEJB32ZC5yi246isS9rvZj25gQU9pim1ZdPJbp5/BjpiJlQtsqJJ5EMpzYf+gypXMIyM8aYwCl+33aJeyRpPSYmADoq2OFVc/1g73vYBVDWTjHBthLx9jJ+kPpbbvbvZ+W9wF/irG3wsoK5deUmHNAzU5cx71MpPvc8BiftBPjMCaGGEuFMbwv0LoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jUDR7kyrK/YB1yU3x9LbviKkUXwPDDAxZLl337j42U=;
 b=BZ7MZQoMa7mZ8RihrWfXB0bVTZAifhhqQxqHqyEQMEtd5S5cn9SvUnIx2+IkNlhMW8Vw7lfzsZrlvVpFGjPf0qmTEcqB0zvvLbk+Qid0HNmZzBLLKn9d4Pb5mEBcCjL6YQwYBr7WbXVp5Q9V2z7WefuhO/Q5uG48lJ/vGA8+iGAW2f33ezuuMY8bUrvvGQPTqk1dfwi83DGLn3uqomSkYmeLgPlvUCTCRhm9uZ29nrdsSvsL3ObPIJA/y0R9u6pf06EYTk3kPjM9nIxLsDhx5wedmDup+bZ8+xzYO/iDyGhUqqJk4g7UZ0JbnbjmeBnm2XSfzBKRfhWl4JXqEwC3fw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 05:26:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:26:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block/027: setup scsi_debug with MQ
Thread-Topic: [PATCH] block/027: setup scsi_debug with MQ
Thread-Index: AQHbJE1uWX3vk8j8DU2fyjuc/sVRg7KTz56A
Date: Wed, 23 Oct 2024 05:26:29 +0000
Message-ID: <cdcdddbc-b81b-427c-9863-39e15ead06db@nvidia.com>
References: <20241022064109.3303704-1-ming.lei@redhat.com>
In-Reply-To: <20241022064109.3303704-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7363:EE_
x-ms-office365-filtering-correlation-id: 9ff47535-54ac-49d0-5eb9-08dcf3233fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEZpTnJYY3ZaSFJpNEdvc0dDbWdwa0VoVDNHZk1nWGQxTHBaSUtUTzE5dDFB?=
 =?utf-8?B?M2V0N2xNOWsxbmc0YU1WUFFFRzhhRG1TSkYxUnRkRFhNa0hEL0g2Qm1lTFVO?=
 =?utf-8?B?RXBnbStyWmZOZXVPbU0yUjhFdGYycHN4cDhTUnBlVDZtM09RVXJpdTVoNVVT?=
 =?utf-8?B?QWVhWU01VUVFUDVhNDJSNmlGdWljYkFRVm1KMWFxUVpONGUzTG1Ud3lveGxC?=
 =?utf-8?B?M1FXTmt3UGZRckQvVW1GNi9QVGRFeHU3UmgrOWFqem1Gcno1ZEV2djBtWUZp?=
 =?utf-8?B?MUFYa3hnaGZUbEZkN21uamtrK3RkdHFjbnVZSU8rT2ZNNzM5YTNaSGxLenRJ?=
 =?utf-8?B?U1NSY0VoK3NDMVluTlRJWG1aZTFlOWV4ZlNrb3BWbTZQcHlRbldvVWRiSFhj?=
 =?utf-8?B?NUhSYTZtSU8vZnRQL1lnN0pxWkMrdXNNcEFRWVFkYVJRS3lTWnR3RUdJckFK?=
 =?utf-8?B?QktCZFZKZUJEUFI0WU1jOWp3YWc3OGtVN24ySDgvZDAycEk0aFBaOEtYYVU0?=
 =?utf-8?B?WWJvV2hBQyswRmVXOVFwTUVWZFRXRTZMclU4NVgwQmZXdWhWaGFxZ1puUWl4?=
 =?utf-8?B?Y0NRekwxbGFBbC9mSWVyY21DTi9NSlAwZjFDQnA3Z0JvWWF0cDdJR3Blbkk3?=
 =?utf-8?B?dENPblFtSUZ1bjAwNHFScldxVHB1N3FzY0ZvTFFzcG1MWUh5cW5kNlcrZktB?=
 =?utf-8?B?alE3RitvMGFaRGFTVE5jdmZyTEhYMVExTTdPTVE4MCtudmNQT3IxaGVKK2dC?=
 =?utf-8?B?MVd2OEo0OVorRXNzbVdJeENVeWN2UFZzaTdlVVE1bnlqOWFsbE9rUmMwZkg5?=
 =?utf-8?B?WFFrM2VBQUgrZ2RuZjVqRitwMm9sdXpBT05aQWJkVmhTakV5a2oxWDFuSktM?=
 =?utf-8?B?OHJPcnROU3JvY2p0bTgzWmVKQTV6V0JhM2llQlQvbFc4VnF4TkovZUp0clFD?=
 =?utf-8?B?b0Q1ZSt0d2piVGV5djlpRFVhczE0cXBRU3RGTjQxdmFQVlh0T2dFd09QZmwz?=
 =?utf-8?B?YlY0UFl3NFVEVUl2V1hqTW5oNEVkTXZyZ3UxdTVFREtSdzBDR0RTdExzUExP?=
 =?utf-8?B?aWp6N2hvZHBSeGxBc2pTVGtqR04ybktRZHl6V0U3ZEtkOGVRRVhycVVNVzda?=
 =?utf-8?B?aU5WZ3FhMUdxbitZT0dGcXp5cnFCZG01ay9sZ2h0Q2gxZ1dQUVA0Zy9vSDZM?=
 =?utf-8?B?SmlXT1ByWDlkS1krMC9mNFhQbDBkQ3NmSE9HVGs1TThUbytCdEFDcUIzaktv?=
 =?utf-8?B?VXZOK3F5UTV2UmxuWGRoN3ViRTlzdlYvVHRwREZISXJRNmQvQ2tKeFdhcGxy?=
 =?utf-8?B?T1U1WTBPSmxLVTZnR29ZOE0xYnZTRzViS2xhb2U1dFlGYURlWmFkR2t3aEdS?=
 =?utf-8?B?b0IyNmQ0Z3pzVWRUdGZwYUs1eExFRzY1bjFZdWhId0JveC9ISUxvVGozY05y?=
 =?utf-8?B?azA4dW5ibDBSelQzbHRCMm9xRmROZkUrTDJoV2d1T3FqcDBKTWlsbjJ1cnBV?=
 =?utf-8?B?b0M1dUc1Y1ZhMDlDb2g4MUMyWlRTMW5KOWd5NVBuZEhSa3BCSXdGNWpNb3hw?=
 =?utf-8?B?dk9pRFE4RGJpZmZzL3hUa1Ewbm5kWkVOTWhqcEZweFZpbE13L3NkeG95RWJO?=
 =?utf-8?B?ZDVBTkxyc0poMUg4UEs3anovMjRnWFVUekREemdtUGVuSlZOcG9scWU5Lzlv?=
 =?utf-8?B?bWlNM0lsMFRxKzJIOUtoTi9POENwbnpPTmYxUlBtQ1g2Nm1GY3dZM296cDVF?=
 =?utf-8?B?bWpuUTBDRWVPQVNGa2JGcEdlcmRYV3E3ellrbSsyYzBMTzAvMk1ySW5CRGJh?=
 =?utf-8?Q?zmetEBQE1POBGLONWfwA02Pc6cTZRptRZmc00=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHN5WCtzV0F2WWFkVkZ5TmFneVZBQmZXSGJrT2hnRVFVWmtXVjhPdWZGUDV5?=
 =?utf-8?B?Wk8xYnVZV1JsUUpzSDlsUGJUcVYxaGwvTzY4US9aMStpQ0piOTNYTXhmbnhu?=
 =?utf-8?B?bVRqV2ZCb2JJMXdBTy9qamFmOVQ2VDExU0k2WnJyb2hlTlZNbGIyZ2pRRGNo?=
 =?utf-8?B?M1dGSVF6Lzk3T25nQVQvanZuOHlCeG5XaG9SYjl6ZDU3WHhNaXg2bGpyK2lB?=
 =?utf-8?B?OFVnZ2tCck5VcmJiQTJpVEFLMW9DM3hEaitHK1FHVXdMV2xwMGVzWml1ME81?=
 =?utf-8?B?ZW1YbVduYUlwSGZWWm93RTBsdUhObVBBUWw3YUI5ckViVE5QcFZqWE1HQ3My?=
 =?utf-8?B?Umw1R2p3clRPT1dtWEMzcWpIRU5WOHI1c0pwMGo2T2FTbFNqdGJlRU1kRlBV?=
 =?utf-8?B?VGRUZHNYalI4Uzd5RnJZaURCWVFYWTFUbm1aZThNcncwUk5OU3dQKzZEcWpU?=
 =?utf-8?B?MmZsOXZxT2Q2YWRnOU1HVFFrN2tyemYrYUwyQTFUTW4vNUljeWVZemJSUXdx?=
 =?utf-8?B?SGYwYUQ5cGhYLzdPS1orUVdtaTcxM0txK3gwT3VEbUhJaVowbnllVEs2UERJ?=
 =?utf-8?B?NUxuaDdySnlXL3hpY1d6YjFWTkdEM2lIY2ZRMGR1amszbCtlZG5nRW9PNGpK?=
 =?utf-8?B?dHFodjJoL0djellReWY4Nkl1S3RKS3pNTzZLSzJ0M0poOHc2N01pcnVRamFq?=
 =?utf-8?B?VlB4VUpKeGd2MkFoajViaW1RR3ljVGp4M3lsekowanJYM2tPdHpHUlNGamxT?=
 =?utf-8?B?c0dMNTI2NmZWQUJtVE1BdXFMN0p2MUFwbi9zUkxpaGpZRktKb05jYTM4UzNr?=
 =?utf-8?B?Z3VFYS9TVFJzWVlDS0V5eUZieE1Qc3E0aEx2S0ZxYWRKLzhoTmQxZ29pZEox?=
 =?utf-8?B?ZmxqQ09Bb20waEpIdkxCcFN1WGl5NmV6UE52cHFpYXJWN0NwbGJzazNudnMx?=
 =?utf-8?B?bi9WRTZIMzZSTzNwbTN1ZGthNUd2OUFxdnk5NmQvcUJqYmN1NDNidTZPUjc2?=
 =?utf-8?B?VzYxNFZsOFdBcHhSOEErQTBYelorVzBSdUdmZGdudjBXYTJ0MWllNERSMnN4?=
 =?utf-8?B?S21pM0wzNnlJeXAyVkJRMFp1U0ZncVdQZTZYdE5sL25aOHdQdlg0TVBtRVVo?=
 =?utf-8?B?WXozbGtoWGtvbFNHSjB6T01odnpqUkhwekNZVjFjYk4xc20xc3FIYzlNYlBy?=
 =?utf-8?B?eE4wRGxpMG1rUFYydVE2QUwzTnJLMWFJeCs3RjlUN1pNR0pybm5WNHorM3RS?=
 =?utf-8?B?WUdnSmlsblMyNzhBaHZJNlBTVzRRay9aN1VGaGRVZlhXZDNoQSs3UEpzTDgx?=
 =?utf-8?B?ODJWMUxVZFhqN2JlTjBBUW5vVklGVHE1MDlaSzdJMGJhWk95QjJ2QVBSK0NW?=
 =?utf-8?B?OGprR0ZPblRoTjM1b1ZYemM4Q3M5QVpVMUFTWW9QZ0pXRVN3eGtRQWpsYUE4?=
 =?utf-8?B?VXBqN1pTTlBjeWlOSXAwK3lXZ3hFU2U3RjkwVm51YlIva2pjejRjMVdlS09z?=
 =?utf-8?B?WDg4K2JQcFBYN2hsK0YzeWgxVDM2NENBbTZGTWRqWG9GTDlabk9kQ2RHNVps?=
 =?utf-8?B?SE1qUWZiQ2ZpeVlzZXAzU216N1djRFVEQ1cwNE94Y1AvUzBSZHVwcU5lZk93?=
 =?utf-8?B?NWpuaUhOblRsL3k4SXFwN2ZJa3JMRE9XR3EwZE9MVURSa2p6WThlNC90Vjh1?=
 =?utf-8?B?bUozUDZudmxicWhraHZZOHFtY0t4OEZJMTBxclFZR2hNVGVreGpueXNOVWtG?=
 =?utf-8?B?Vyt1cVc1bTRHZ2tpbkllcHJ1Ny9jMis5amtKdFdZUUVoS0szajhyNVJuWGlG?=
 =?utf-8?B?czdMMzh1RnZMd3o3b1VkNCtWYks1bkp4TXJjV2VhZ1huNDlObzcyeVRWUWRH?=
 =?utf-8?B?YlVrblozUjM1TnhSYnltMVp3VWpTVkZxNTJha2RTeklBcnNXTU96eDRocDIw?=
 =?utf-8?B?ZGFWQ0hjdlBqT0RNRlFXTXhYd3VSNVh3V3dZSDhBYmRwenErQmd6KzZGSVZ6?=
 =?utf-8?B?MGdQUkpRSlB0OGRhSEt0TDMzTG15ZUkxc2JBNko2VDZDODFEUklIbUZzby9o?=
 =?utf-8?B?MWdTQjFmb3pSWUJtT3Z3alJXYkttN3pFblhvelNWVTZvQVNzQjVCU0NoVUdX?=
 =?utf-8?Q?eXS66BljeZxhFf55k2Na2hoWh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54C4DF33FB8C2748B96518084B602426@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff47535-54ac-49d0-5eb9-08dcf3233fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 05:26:29.6494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0mob59HlOBRKx7jWHMBFOgFLjJ/e3SLpsH88jSVpIWJE9KjK0SlgJf6bWbqb3p8eYcuDVhr5i6xuu7fab8dUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363

T24gMTAvMjEvMjQgMjM6NDEsIE1pbmcgTGVpIHdyb3RlOg0KPiBibG9jay8wMjcgZm9jdXNlcyBv
biByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIGJsa2cgYXNzb2NpYXRpb24gYW5kDQo+IHJlcXVlc3Rf
cXVldWUgc2h1dGRvd24uIFVuZm9ydHVuYXRlbHkgaXQgaXMgYSBiaXQgZWFzeSB0byB0cmlnZ2Vy
DQo+IGxvY2t1cCBieSBzZXR0aW5nIHNjc2lfZGVidWcgaW4gdGhlIGZvbGxvd2luZyB3YXk6DQo+
DQo+IC0gc2luZ2xlIHF1ZXVlDQo+IC0gMjEgTFVOcw0KPiAtIHNtYWxsIHF1ZXVlIGRlcHRoKDEx
MCkNCj4gLSAxMHVzIGNvbXBsZXRpb24gZGVsYXkNCj4gLSBmaW86IDQgam9icywgd2l0aCBpb2Rl
cHRoIDIwNDgNCj4NCj4gVGhlIGFib3ZlIHNldHRpbmcgY3JlYXRlcyBiaWcgY29udGVudGlvbiBv
biB0YWcgYWxsb2NhdGlvbiBvZiBibGstbXENCj4gY29kZSBwYXRoLCBlc3BlY2lhbGx5IHNjc2lf
ZGVidWcgdGFrZXMgbWVtY3B5IHRvIHNpbXVsYXRlIElPLCB3aGljaA0KPiBkb2Vzbid0IG1hdGNo
IGRldmljZSBpbiByZWFsaXR5Lg0KPg0KPiBTbyBzZXR1cCBzY3NpX2RlYnVnIHdpdGggTVEgYW5k
IGF2b2lkIHRvIHRyaWdnZXIgbG9ja3VwIHdoaWNoIGRvZXNuJ3QNCj4gZXhpc3QgaW4gcmVhbCBz
dG9yYWdlIGRldmljZSB1c3VhbGx5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIExlaTxtaW5n
LmxlaUByZWRoYXQuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
