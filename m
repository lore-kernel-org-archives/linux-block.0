Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618961FD4
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636615; cv=fail; b=cvcpVC+RxQKKsy4soxIa1FOxXJ3T9zQjzixrRxN+TEZ6ewprGgVHULxOkEl3TJkh9PIhy5AAv+c+e+52/cj5tKYImdZ0CoruHUil/0/EKp1jDbyPxonGX20Hx5dERDVmuGrwgIGcIsIY8uDseAOjLP1Fw5qHNE45OJQbt5gfRHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636615; c=relaxed/simple;
	bh=Iptx8JWBjwJNemNMgY+NsNedKtZiGvu+jf3M7Pcn53c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbtJvofdCldzUSDc+bJW2NrRpPYM6z1zOJFDg+F46yJGwbiSM6D3JTX0fge2L0MLVtDTZC3btvqfQZO0ve2uMonSOrWos3dwAbRaCDvcat9mn8WwNuCsr2tGDa9DiVNjYR3PCx8z6CM+vVHly1kzNCP/qM+/8CdJ6cWWIJyvE2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rVYOtErP; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rVYOtErP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1gZHKhckg09cSBm5NxWAIOHePYNwFOMHmhNflQdAk14AhWiT3R8xyxzG8dLdvl3xTsSmyeyM0Ya1tA1kquvHr8XF0+JMdTIjYAXBOqq5XX5HD3+91zRuVQkXPTJUMTcVin9W+UC7ORanUlGRUGg/qcXw++kHTgi3Pm5BVXlcdwq3N6/Yuvf960Yy4rh5brzk+FXgi0VE7ag5bRBE8C+BzY5qxqmhSKnpey5TTKcoxz0iSNb7JeIcQ72QiBz8PHoceDlUeilzaYftlsNMBZh24iOjIAb0FcG7muplXjTnfPp/zjvgC3/7yymUYlq4VK0gI0s0tm/aAy/fy2xpLcGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iptx8JWBjwJNemNMgY+NsNedKtZiGvu+jf3M7Pcn53c=;
 b=y9EB0jLaBvUAYTNi+4XTI3JeykmoGm4kEEktM/dSeu8J60PEtwpuGtDwn2Bo0NKdqaU6EuwwJrE4J6ijWP1FL3A8yA58q88xCXqrJFxoNSEMjN7l3TcgjRiMXoLQ3RVdEqq2kfoL3m2bwH7YSMLI7LbwC82IxsC7lufHb4oSKCfyqw6t7az3LDPk/z/5Fyk2VPXNfFmhaRfo0QfLn64q/4E9Q9/KTyjRsez5WbIFfNpdEI9WqtOdO+0vnCupuJon1btBxsuKcQ1D2wwk4hapqca7zVuL21iYLrMMVlm+udJ2mNsfmiznr3KCovBU49gPvgXokO1kbyayjmOFaeNBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iptx8JWBjwJNemNMgY+NsNedKtZiGvu+jf3M7Pcn53c=;
 b=rVYOtErPeTcvG82uBJyeekkmYdQXrZWdcyhfhSq7xIF6LlqoFm9YSV9jcSte2cr3vRu/M9iaORKDA5pLGObkpXwx+hs+o+Pk+vgBDwowMxw6iTPupUZsv6uKyC8HaFdn0sF+CGxnglEMjcccz2v/Mx9nd8Va5qkm8yjWfcQ3EE/NF1jB/UpK6wFkClatGDzVIQB1TK7uYk4vmsIoaEy9dsxybP1xetwRiHDgWqHgdrVBiyXkIDs6tfz/yN1pmjcuB1iqz+oLw3Ky6gl9EFD2Mq29MtZgUNLDOR9nUkObXrfHrtCaCPR9WMYmjplEUiIlVXmzDht2Ykrdyvv7uQDsZA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 00:50:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 00:50:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Topic: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Index: AQHcU2IiEOCHpn1A8EelxJPvuVBn2rUMqjkAgAD6OwA=
Date: Tue, 2 Dec 2025 00:50:10 +0000
Message-ID: <85eac98d-6185-45ce-9e2c-77c0b44b39ed@nvidia.com>
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
 <aS1l2pr50kXzsjuc@ryzen>
In-Reply-To: <aS1l2pr50kXzsjuc@ryzen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7938:EE_
x-ms-office365-filtering-correlation-id: 74baa102-83fa-401e-6787-08de313cbf4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVVFU2krN0RIck1OMVlZOXNWMWNFS085aFZabU1sV3RRYm1Ma2tuTDNzT1ZN?=
 =?utf-8?B?YUJRVXhUZkhsaDl4V01QR1VuL09NVEpUcHlqUElwUU5DTkllM2xhTGJnbEU1?=
 =?utf-8?B?Y3RjZTJUenZXSjdBOHhxL256c3cyRkdCMWROT2cvL29SOEp5UElOOVdmdG9Y?=
 =?utf-8?B?Y0NkUkxrMDExWDQrc1U0dzQvb1g5amhoNjVEazdGU3lERTYwcjJvYVhWSk56?=
 =?utf-8?B?TytKRGV5Nytvb0Vqc2RHbEZQekJidWp0c3ptZjlFTEZBYUZyay8zSGh0eEw5?=
 =?utf-8?B?TUw0NGpqRms2QzdhekdNWEdyTDdGZ05KMVpOTEJ6NHhtdjJxTGlja05JdmQ2?=
 =?utf-8?B?YXpYNWVhNFZBRXFrVHBRMlMrVXBTQWFRZjZqTll2R09Na0JkdFBkU04zRlNs?=
 =?utf-8?B?Zk5ya0VuYW4zUitlVjNoYjMzU1V0VEx0WVlPNDI3ZytpR0h5QzBwb0lwRmsv?=
 =?utf-8?B?bkFiaUIzQ3d1bGtFdGtrTk9XL0NqbXB0aWtST3V0L1F1VG82Vy9xY0VsS3Vr?=
 =?utf-8?B?SUIxbllUYWdselZYQ0R0Z0JVYnhxcE5OQVJ6RDVNSzJSMzJtNlQvZEVNVDJB?=
 =?utf-8?B?eDlEQzNuaDU0Slp3UmtJeGpDZWh1UGNmbmhqWTl5dDhsdWErRHhTa2M2ZlM5?=
 =?utf-8?B?TjJhNEtPZE9wNGh4elZ4UEZ3UnF4MTYxRDlkaGNSSmNOWVlBSjZZZ2hTZlgz?=
 =?utf-8?B?STlaREowZzV5Y3QybCttbDZYNS9kazAxaFZVSUZyUlBhb09oRnRSd0VzNjZ6?=
 =?utf-8?B?c1cxY2ZhZnpkazQwTmQ4MXh0M2lpTStoaHhldDFqb29aU3Nhbk9CQnBIZ3NK?=
 =?utf-8?B?QnpEV2kySUw3eFd6N2VNY0V1d2RiYkNJaWV0SkpYTndnRWt6YmJHVWcrNnpE?=
 =?utf-8?B?UVJuSWI0c1YzZlZlNnllWjlDdkJEUFRyUTFWUTF2QmQ3TFNyNU5PWDNJK05F?=
 =?utf-8?B?ZFh0RnExWlEvOXk3UG1nZjRGOUQrVTZNRXRSSm5CRFNlUHF0NXd1NTNSYjF2?=
 =?utf-8?B?b0dkT1pXcnU3VndsdHhmZXZCc1hxK2xJenR0a2k3NU1NSG9GV3VBNmdkbFRJ?=
 =?utf-8?B?Z2psSzg1NW1BRUpLTk50bDlCUEdHQTEvKzlhNWZWbnU4dTlFOEwwRDZJalVr?=
 =?utf-8?B?VWVqVkhyR0JWd0V0YlczSVNKUnBpV1ZJYzlZVkh6UVJvcjkrV0FnOWdzRGs5?=
 =?utf-8?B?UlBHS0VXOEtiaVhQTklmWmVERjkxRHlaSnpKS2dOdmp1bjI1ejdaZXBhaldH?=
 =?utf-8?B?MUkzaEJTOUt3ckNGOER3RWJQQ2VzMXR6ZEdSN2pOZjlZTGZMMVoreXFleGg3?=
 =?utf-8?B?NSswSE8xYWN3N2hnS3Z1T0lHRHRyMWRHTGRQajN1U3krUFBEZHlzUnJ6cFVk?=
 =?utf-8?B?MktsNHY1dE56QW5RM1FoWjN5OWRLNVJKSmR1ZG1OM2NWYnVjYzRkQ2tsY09y?=
 =?utf-8?B?STVpL1JOaE8ySXhsQXJReXFjUTRuOS9yUURmekJjU3NYMDJwMEVzS1JlOXgw?=
 =?utf-8?B?OTRNdGhqSDlCM3VNTGR6Ym9zaTVyVythaXh0WjRidmpyOGRzL25FRGl3dG9C?=
 =?utf-8?B?bkQ4eUdIVXJRa2tuaGZ2ZzlqK1FueThqQjlraHU0MFNSblpaUk8vSDk3S0Yr?=
 =?utf-8?B?VVIwZ0RlMG9ueGlSZEw2Q2JkY0V6Ri9SdmkzTkw0M2dEUnlmeDA4ajc4QTIw?=
 =?utf-8?B?ODNZWkRuclU3UlBEWitWZnl6dHg0S3JCclhIcHBzM05KZUpMTzk3a2l3cXVC?=
 =?utf-8?B?OUw3ZG9maXZmNUNjL1kyU3Y5d2U5b1VkM0YyaUxEUWRDSkZBajhZemhOY3M2?=
 =?utf-8?B?aDRhbXhSSmdvQUkzWllKcms1dFhBaXE5VHN1WjNtRzJ3SWhYOFBlVHFRdFp1?=
 =?utf-8?B?V1Y5TnFuWHc1TURJVHF3Z2RYd2ZPZjZYOFMzaWpNN0RuWFBXSVBvcnlsT09L?=
 =?utf-8?B?ZXl4Q0swQU9MSnF2cmVac1ErY1VDc0J1OFBHR25CRElZYUdJOEVzM3NZdy9k?=
 =?utf-8?B?NGIyRGh3OCtjc01JMjFLMnR0a3FaOHVkdDExMkpSWis5NVZSWkN0cys3dzFH?=
 =?utf-8?Q?qR+6/n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlJwNkxaUHhqeXo0UzRTSzZIa1doSTdERTBRZkpNQ3Vza2hmTG9PcWY4OG9S?=
 =?utf-8?B?OXdaR2h4T092RUQzUE0yTCt6UVJ5VS9FaWRpSVovZFprMkh4WnprT1VoK0tD?=
 =?utf-8?B?U1RIajVySEdVRGxkQURpdlo1R1VvWnpCaXpFeHN5VXo5S2d5bjlRNVE5YVJ1?=
 =?utf-8?B?UDFDSzVCKzhtRXVWZ1FGVXZOby9kSG5CbWY5bW1vcnJPc3I5ejFzc0JoZWgz?=
 =?utf-8?B?ZE9xKzVNaW55dk01R0poMmMwLzRQRjZmVnhZU0lGU29OK2xKYTdWeG41ejMv?=
 =?utf-8?B?WEVCQmJVclEwOTlkVGNsMlB4SWNHdzlJdHduUzVuTkNrbVF2UHBxWDFCQTJG?=
 =?utf-8?B?cWhvQ0FMSy9oNjgzck9MNkpNNCtWd29XUk02WUdZV0FLcThmUVlSR21QN1dG?=
 =?utf-8?B?bUkyd3J2UGhSLzNqVjFOWktGdmdHVlZzc1Flclo1YTdpcW10aS9IOHp5ZE9C?=
 =?utf-8?B?aXgvaUduOE9aVXNHcjIwOFJxUkE0VFg2NHcyd3ZSQi9zVGVXRk03V2xnZ1E5?=
 =?utf-8?B?ZS9xbmthaTVBYnRaN3ZjTnFBWnpVUjZzb2N3dTFDa0Z5YU5Oa2cycWZvUld5?=
 =?utf-8?B?cHc1UTVtSElteXpGNkZXb21sRnA3aVNQMDRYT2xFWDJCTnlEZEx1VUtZVzRJ?=
 =?utf-8?B?WW13YXlneGJ0Z28yaWhTZ1pNcERsNDBRYldZNm5PWGV6bk1abEJrU1ZnRmJM?=
 =?utf-8?B?STQ2Z1M1VXhPVnVaMjh2eG9nL2krR0RmZDhyVkVQdjFKWXJGVEt2SWVOdUds?=
 =?utf-8?B?M2hSeHFaSGF6a09DM29xSTFTTGpWWitLUjZSY3hRWGZkZzdFVFVQbEpOQ1M3?=
 =?utf-8?B?UHBzQVhTK1NVakw3QUxaZ2lLakh5T1c0MU9OYVRFMFAxQ2YzcXV2Z3FWVllo?=
 =?utf-8?B?dFB0WEFYeTFiYU9jamwxR0x3OTQ5cmxaTjMyNXp0SG9VWTYzdHlmT1FHckJt?=
 =?utf-8?B?bHdhOTFIY3BvRm9EdHQ1MUpSY28zMk9WbVhQUlN2NTZ4cVUwRjhDQnV1S2hO?=
 =?utf-8?B?RU1wc0NMVVNrblZrY1BWMXdDZEhPSXRsRnN4T1Awc2VCRTRlaHhNNjRQenhH?=
 =?utf-8?B?R3FFemE0c3Yrc0VQR3Q4YlE2T1ByOHpXT2tvdTlTcSs5MXpVelUwSkFtZytL?=
 =?utf-8?B?ZklEMm92S3pob01ZMk9JaFI3SHYreXJqYmpmc1JLcVV4amFyZHNyL3ZEejlu?=
 =?utf-8?B?U1kyRnFEMy9ZcVY0NWdtTVBOaGQxdnpXUVBKeWg3YjRqbzVXeTVwRURvUHZB?=
 =?utf-8?B?WGdNUEZkRGhhUU4xN3dLY0UxajRuTWlnSTQ4dEh1eXVJUDBHTEpjTSt0eGQv?=
 =?utf-8?B?R1E0a00vN1B4bDZSN2M0NmIrU25wb0pITG4vUTZidWhDVDRMUXM4YXZIS013?=
 =?utf-8?B?OXNHSnNqNHpZVVArYnlMSXYxK20xcGorcE40cUVMalJ1ZmtucHE4NStGbDR0?=
 =?utf-8?B?Mk5GM2QzVkpwUkxnMTQzcDdrZFVZMEV6eXdVR3AvcC9zRmI3cE5pcWk2QXY5?=
 =?utf-8?B?SHgxTFk0N0N6VW9maFlXZmVxUmZVUlVzNTlqRHBZbkhqNFo0cFJ1MWoydDlK?=
 =?utf-8?B?aFoya0ovbDlicTRFUFk1U1RYbHk3KzJhbmhNSktEcWxGb09Da2VuNFFvdEg0?=
 =?utf-8?B?UUhOU294TE1BSGpocXo4WmxBc1NmSGsrNyttblFMN1VIWE5hdlJ0SEVOdWlD?=
 =?utf-8?B?SkV1dlVRMzlDMnkwWUtVTklRUjl1bzBDWTdGVTM3NndYSjBCbmgwL2tDMUVm?=
 =?utf-8?B?Q090T3JEdkE4eVM3SlZlaEhqQXBqUHAzRUlvK0FrVzZQQVF6bVU5N3JiREZk?=
 =?utf-8?B?aC9GSFFSRXI3VTBNYjdSMG9GczlYb3JScFBlMnlUQ3JKMVJYVWZEQnR2RDZm?=
 =?utf-8?B?L1pYZDQxLzIvWlFzN0pWVWRQM2VoNHVYbVNvMm5vT3I1T21qckZXMEJyelRZ?=
 =?utf-8?B?bWZoS2szc0NCZFJyRkl5amxrMWxpZVZjRnNDMkw1T0NEa1c0RlRkdksvTm1T?=
 =?utf-8?B?R3A4Q21kczFMcVp1UkU4RlZ6UTM1bld4UEJLTEJIRGFQcytwZ1czbTFHUlY2?=
 =?utf-8?B?blVjNmJ3RlRTcHBCVGt0RGNIRmkrU0dJZmJ2N01EbjM0dmFPc3VmQmVEWTQr?=
 =?utf-8?B?REVYeVkzMnhENWxMbmpRTE1QUzJTbFdRR0lYUWpOQlQ5VHlOM2h6RnpYcXdn?=
 =?utf-8?Q?uU0PIgrarY0Ly+4Nvrx+L5NRLoMXAafvUE+08yJLQrtf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC907D4F766EAB4FAB02C698A6749AF0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74baa102-83fa-401e-6787-08de313cbf4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 00:50:11.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9lhyc1dfGtoNQXuloqqzn+zr1wEpdSZsqBgFfuWo+FkExnBxoJMS1Ao8wZHqKu1fKNBs/8sd0WAgMxfpUVBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

T24gMTIvMS8yNSAwMTo1NCwgTmlrbGFzIENhc3NlbCB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggYWxz
byBwcm92aWRlcyBhIGNsZWFyIEFQSSB0byBhdm9pZCBhbnkgcG90ZW50aWFsIG1pc3VzZSBvZg0K
Pj4gYmxrX25yX3BoeXNfc2VnbWVudHMoKSBmb3IgY2FsY3VsYXRpbmcgdGhlIGJ2ZWNzIHNpbmNl
LCBvbmUgYnZlYyBjYW4NCj4+IGhhdmUgbW9yZSB0aGFuIG9uZSBzZWdtZW50cyBhbmQgdXNlIG9m
IGJsa19ucl9waHlzX3NlZ21lbnRzKCkgY2FuDQo+PiBsZWFkIHRvIGV4dHJhIG1lbW9yeSBhbGxv
Y2F0aW9uIDotDQo+Pg0KPj4gWyA2MTU1LjY3Mzc0OV0gbnVsbGJfYmlvOiAxMjhLIGJpbyBhcyBP
TkUgYnZlYzogc2VjdG9yPTAsIHNpemU9MTMxMDcyDQo+PiBbIDYxNTUuNjczODQ2XSBudWxsX2Js
azogIyMjIyBudWxsX2hhbmRsZV9kYXRhX3RyYW5zZmVyOjEzNzUNCj4+IFsgNjE1NS42NzM4NTBd
IG51bGxfYmxrOiBucl9idmVjPTEgYmxrX3JxX25yX3BoeXNfc2VnbWVudHM9Mg0KPj4gWyA2MTU1
LjY3NDI2M10gbnVsbF9ibGs6ICMjIyMgbnVsbF9oYW5kbGVfZGF0YV90cmFuc2ZlcjoxMzc1DQo+
PiBbIDYxNTUuNjc0MjY3XSBudWxsX2JsazogbnJfYnZlYz0xIGJsa19ycV9ucl9waHlzX3NlZ21l
bnRzPTENCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmk8Y2t1bGthcm5p
bGludXhAZ21haWwuY29tPg0KPj4gLS0tDQo+IFdoYXQgaXMgdGhlIHN0YXR1cyBvZiB0aGlzIHBh
dGNoPw0KPg0KPg0KPiBGV0lXLCBsb29rcyBnb29kIHRvIG1lOg0KPiBSZXZpZXdlZC1ieTogTmlr
bGFzIENhc3NlbDxjYXNzZWxAa2VybmVsLm9yZz4NCg0KVGhhbmtzIE5pa2xhcywgaXQncyBub3Qg
YmVlbiBtZXJnZWQgeWV0Lg0KDQpJJ2xsIHNlbmQgcmFiYXNlZCBWMi4NCg0KLWNrDQoNCg0K
