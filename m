Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2E1DED53
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330248; cv=fail; b=J+o8qTXmwDdb8xRV6SHibS8jEk14u+KJd1ZZcK9+5VyU/e6nElUQvmhF3/6MygRU73mhgLxxLtn+LTL938WrzEx8hM1ryoXnZ2CutQsI0totKuiyomoxX/SYIkpc2F6XsYO6Kf7EcAqobpKNaEEGPQdllbWwbAQrP3mN443On9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330248; c=relaxed/simple;
	bh=4zLxTvirK5ENz8pq/uvClgUilh6EZaiwjI+Nm/MFRu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXSWrw9JCpbXsoGy1dNxQ5VBzigEJDDlZ1cVOlz1tix755SAW1sqZroc324mf9+hGQ7+uHCByiZJYds60+fu9nhoxGUwt8WyUiy1PisfQ8r0FSrQWERmG5q2DEOmI3gDkB7hXzOr8wdDmn51j46qqimGJsiDat1CnjyxFC22exk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ilKODwr9; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ilKODwr9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybxs32wEV4ezSSfoODKoDaxSLCRhwjOouyFmaen/eCxSj5psUmGBCW9YVNKtS6x10vaOve7LJ+bedWOtrms+f33uBYzK9IW1lBdOg+RaxAu8fskCF3ILEqXvrRCtKpp0Ncji/fIj4F80wSwKyJ1TckKtHfhEHZEftbJtAnMO4x+cyT5IVIA5J4TibBWTRQB2C3yp8J1WNakCSwJVQEEE/x6qCMOZJaCQ33TtzP6ye4m6behUBb+JGBrQSjKZE8DBTnv5UYyBpWKGTnnRrMn+Mwy4Wu/fDqZeWTLZ6ciC4FQuI/BaRYRBDyfK6YWv0oNkhvjNPZuwwnhhVxGKV14z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zLxTvirK5ENz8pq/uvClgUilh6EZaiwjI+Nm/MFRu4=;
 b=hrmH1wRco69/tTEtRcWbZZCI5Y1mRgyvffaCaI2w81r97Lq2sCDHZfF2udp6bp3qo22w0nQEKDPHYqnxcgd3quX/ln1uwwTdaWiienQ0GueIfuoBhgempo3NbaHzPKfWGoZ5DLGCPZHOjGrfNL60JxTR6FJ33XjHDxugo7r9i05zXYRHc0n/ySYgDx/i+4e2feZKY9bg9Lo5sKO1Rbjg1Wu8C3OrimIKE3krUydk3JBKEUEFqlPzAIImGZ5QmslYqHeJfu+4wt6pCMCRhPDk+sm+jQsQRwiTT6JrVMPPWFKKShv1duRT/N9i4vMV7wUwK1JcrmeS2lE3m0yZleaJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zLxTvirK5ENz8pq/uvClgUilh6EZaiwjI+Nm/MFRu4=;
 b=ilKODwr9ZcwucID2BFORvevpPMkikNU3+3XaSeUZKHYPWqn6ZALSi8+h5HQJalVuq7cv44xMzGRZYymX/JtztJmE56wPlIcYtqUwFtgsfWoWqGk0k2VEd2AD7KHzlQ8KKB9M2QRNjjTkN4s09/Tmy44vgezBP+pMvIUqyHEtZlClyi2VNKoMw8aVCoRzm0nw51KkrsGzHmdOGZk7ynFxYEYnlm9FuemKNhWxF6pLa+VYsTKudB27spkFVPYb3BJx7VszFD8SOgPRbX+jWLUffDxGyobHdY4GQ49nxvZpeBv6RSJbcSRBbeWfUJLisW5vH/uXYX0kfArEsiDlNn5lJg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:37:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:37:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <wagi@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/3] common/nvme: add debug nvmet path variable
Thread-Topic: [PATCH blktests 1/3] common/nvme: add debug nvmet path variable
Thread-Index: AQHbl/IVrZ38aCy+uEaiuiZ33ORLMrN5WzaA
Date: Tue, 18 Mar 2025 20:37:23 +0000
Message-ID: <1c4a275e-6f8d-4a45-bb17-d9190d596bd7@nvidia.com>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-1-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-1-01e01142cf2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7453:EE_
x-ms-office365-filtering-correlation-id: 4605c884-bd46-49b4-68cf-08dd665cb026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alhpMkVGMk1CQ2lOTDhGMmdkWVpsWWdDbGxWbTJwVzBjdDFZcVVHTGNWek05?=
 =?utf-8?B?NEt1aXluUnRQZkFyZThMaEpvcWVKZjU4UXhtNVJRSHROR0RGMzY1QWpCRm5z?=
 =?utf-8?B?aThQdVdmSm5oSjVTM3JXRzFIcEhZLzEvclBaMEhhZ2pZbUZaeHZZS29zc1pH?=
 =?utf-8?B?NFBlZGUxMGpncXF5S2VVejh0cUJKUmJFSHNJMm05Q0FMR1VOMGtxZWlnL0F5?=
 =?utf-8?B?dmVnblJGR0RiSndrUUpXRVhrb3psZlUvNzF5dmNtQUN2NTRFZGYzT3ZnOEFI?=
 =?utf-8?B?ekVHYklVcFBuNUVaQmtlVTYzczlaeC82dXh1eDZtUjJIL1UzdThBRUNtUjlU?=
 =?utf-8?B?MHg0Y3JVVnRveEJJWEVJTVBhbnVLdDUvYkcxaFQ5bWRMc3V4aFc3MXJuTVFJ?=
 =?utf-8?B?dVNhZ2MrYzZGY2tGQVR3dGo5a3lPdnVZd3BaS2R5cWJNMEU1dzRlOUFVODdK?=
 =?utf-8?B?SFhsZHA4NTBEWW9MdUlWQ1BUUnZQcTN2b3F4RHU1RUVCR0dpVW5mYytaZUtI?=
 =?utf-8?B?Yzcwc0FlQmgvSVYrL2NpL3VVT3B0Wi9KaXBaOWR5dXpaWkIySlhXaFFTM3lZ?=
 =?utf-8?B?bjhmSnBFS0FBanZ0VUhGcGQ2SDF1SnU5N2dDWmF1WWRkbGtkQXdFeGJLc3dM?=
 =?utf-8?B?aUtOdG1kZDR6ZjROVnlmeGpRNVFwUzQ5NjFTYWp6YlpHdjRMckZiWWNjcTlM?=
 =?utf-8?B?Nm5NZkRpOVF2TzNsa053ejZKREdmTHNsSXNYUldwS1lOWXNEODBpVS9yTExY?=
 =?utf-8?B?VFVWT3ZOOVpKNUVjSVhkVmUwc0cwM1FOWmdsL0tmZ1RhVGxMaVpFMDhNdHZi?=
 =?utf-8?B?WjlpL1BYZTcxcHMra1hqa0RhYUhIaVkxTmxZalhsZE44ZjRoSnZvdkpXQXFi?=
 =?utf-8?B?TFVhRXAwU0g4OFJzeXliUkFyKzRnOWl0RVJVSWlFVk8walNETysyVnl6WHAv?=
 =?utf-8?B?TTBLSXJIVUZIMmhHL1drblZjRHBIVGYzUjE2VlM2bHU0K0hHWXhlbWVCWVFB?=
 =?utf-8?B?d0I0Mk54Z0lLQnhLd0k1U092bjJQZy8xZUVyclQ4UysrZzZjdFl2WnhrK0dV?=
 =?utf-8?B?cm1zQTJ0alRub2J5UHA3c3hUOCt3OFcxNUZRdEwvK096T1JWaEZHMURGRXd2?=
 =?utf-8?B?YVJvTEZhWEMwdTkrblJVSlFocjJtODVhd1MwZDk2Q1hCY2taRVNKdThOVDFz?=
 =?utf-8?B?UFdTYzUvL05YUWVjclFrZW5vUHBjTVJDRHNSTFZLd0NDUitCZExFcDljU1dl?=
 =?utf-8?B?NElORlZzTTg3dTluSXE4a2IzU0svRFE0eXBGQUUrZllRNnVOWDNTcWJjaXVs?=
 =?utf-8?B?a0xPN3VFYUFDUURWVmdoZllkdC9vK0ZRRFFtMXdwTjVQWVhoWTBlR2ZSWWZw?=
 =?utf-8?B?OGVhV2E3QzNXY3FSa3RmSlhBeWhOZzhla3FRWXNoWEFJT3JkazRlc0ZpWnRU?=
 =?utf-8?B?eXd6WHRKUmprTE5aanZMOGFTQi9SSUlFS1ZRejU4VXZlZkEyNUI2eSt2Vkgw?=
 =?utf-8?B?SjdOb1BHKzNSZ1g3SjhkVTc4c0NJd21UNlkrempzdUZiUXR6dlFEY04yVFRX?=
 =?utf-8?B?U2hEN0RXanNRekRsZE54R1hPbGNzcFd4RGlKN25oSlNhOTVPbk1rblRTWk9Y?=
 =?utf-8?B?ekNYSHlqQTdpa0RUY0JRUGlqVGtaVEJlcE12SGk1K3hRWi8waHVMUFBqY3li?=
 =?utf-8?B?TElCUVFlNkMybitQM01SVGhVbktDKzRKdUVJVjcyY2pNcVRkMTMyWk5aQ29x?=
 =?utf-8?B?UmF0S0xmcnJnR2pPTzBwVDd1SDZJRE14ZndKQTVlUHM1RDhkOE12eWpXN05X?=
 =?utf-8?B?Y3VwZFB3UU1iS05KRFNvVTQ2STJna2dOVTEvcm5pczB2cjYwbGpQM3d0N3JG?=
 =?utf-8?B?V3RicWVwT1dubGdPNEdsT2tGbGtCTCtkTmJsNDlyaXVZNFVRTW9oZXBKL1k1?=
 =?utf-8?Q?pZT3GASP0YFUesnnzz7KQpbw0kyMfXp+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjR3ODJVQWVxMjJEdlBYTmhwMEVZck4zdWdkbDc4SDU5MTFSMVJqSVN3OCtI?=
 =?utf-8?B?clVCOGFQSmsxSWU4WU1MVFFKZVkzWWRZMm1iRzZiMGlhczBPTU5uaFRVa1Na?=
 =?utf-8?B?UGJ6TlFZODFGcTZPdlJhNWdPTk55R0dQVWlWUm1zeU0xNGlYNWZOdDNuT1Nt?=
 =?utf-8?B?ckdHUzJrcUM4NmJtU3dOSTltbkgvd2RZV1ZJUHZxT0dvRU4xVU5KcnJqaE4y?=
 =?utf-8?B?N3BlcUN1ekVMMVpyWTU5eFFqcVRpWUpqbnlVRzFmODZBZkVTRlhEa0RMdWJP?=
 =?utf-8?B?UWkzSWFXTXNYQ0diMXl6UXVXSTNCd3VYS2x6ZGhoYmRPaWlrR2FZeGFjQjJh?=
 =?utf-8?B?RytuSUhadnBJNHljUXdOWWEvSWR2ZytsbnhwNVFzd0RISjJuam1zaXB5MGtM?=
 =?utf-8?B?UTgzSTloR0dKeEdZYVZiSUZjd1lTTnJpMHZ0WnRmaVVNTXUzVnBmVWw1ckpX?=
 =?utf-8?B?UmVQa3ZIbmN5UEswNGJQT1RFd1hlbW9JQTVMKzdPUWZqQXdLUGV6TmMxSm53?=
 =?utf-8?B?YUF6K1RYODEvelUxeFR3WTc3d2Q3NU9TM1VuSlZ4NVNXNXZ4OTV0K2tUQVhv?=
 =?utf-8?B?c1RYdWxqcnpac3VqYUd4Wkp5SnBZdGpsUXhXa3phZWw0S09USUdLcXRLTHNu?=
 =?utf-8?B?VDdNeUR4MWp5WmNDTGFNMWR2eWFaOWVOMDhMTXZ0c1ZESE16YUVTWlduSXlB?=
 =?utf-8?B?dWg0ZnA2bWttVzdIbHZSMEFobDQzajYyL2RXMG9UcGRhc2lHNmhmY0FYb0RI?=
 =?utf-8?B?OHlFUVd1Rmg3cXhOeGQ4VDQ0MndRQWE0b09SbkNrZTFaVmNtQ3BFanhWazJk?=
 =?utf-8?B?SlFZazIxRFZDZ2k2cCthTHh3Ukg1WTd0OGIwZzFjSTM0V2thVUtjQnppcFRP?=
 =?utf-8?B?UmZ3bGIvNGZtcEllRHBNMTYzSlVkUFlUb3hxSUR4azBCVW1DWWkvODVDZjZC?=
 =?utf-8?B?ei9aVjRDZnN2Q0RIN2lwZmpNdmMvOTJHQnRtcXh2QVJpSnJhNU83UnNYaUkv?=
 =?utf-8?B?YzFBSmxUS2RMYVFCZFNKTGVXYm5hQWlhaHdwWk9vR2Z0R2NlUTh1WHFuZGcr?=
 =?utf-8?B?ZHJXWTFxdjJjSjB4VWF4RkNyang2ajZ2dVBuVFl4cG1jQS9vMFZuYlIrOXA1?=
 =?utf-8?B?emdoQS8zaHZVNS84OE9GZGpOVU9TcU0reXVKWEtFN1JCUXc0cFJMNUJidnJD?=
 =?utf-8?B?cVgxR2VaM2E1NEZZOUtGLzFRTUY1VjdXTDhYV1RWVWVJbTZVNnpaK3NmTFBj?=
 =?utf-8?B?SUQrazlPNlFlN0JvZ1RhWDJIWGd1dkpKSW52bnJNQW9DRERROEhJbHhtRUZC?=
 =?utf-8?B?ZnBCeExVYUE4RzBRSzl1anpHRE1mZnpMYldwaFZ4NUZTYm5zM3pIMW41Z2Vt?=
 =?utf-8?B?Yi90K1UvYzJ0N1hPVldTWjYyKzFWd1Y0ZWJkT3BWa1lTOGxwVmovT2VjL0Fo?=
 =?utf-8?B?WjVKTkFWcVptYUN0UEVoYnJCZ3NoRUtGRkVTZmpld2VZUk96QWwxSVQxSVh6?=
 =?utf-8?B?SStMenlkRFJpZUM4UUphZCtBUE16STVkc0YycmgyUVVScWIxYXk3Qnk4WFNN?=
 =?utf-8?B?TUxaakJnQ0pteWhaaXAwcFRSQVQ5TVhsd21xcmd4b001Wm9hclFvcnhLbUpl?=
 =?utf-8?B?UUxyN3lIaFdPS3J2dk15eEJST2xqRTVGTlFaQU9KNmtnRkJRSW44SVZQQUp3?=
 =?utf-8?B?NkJBN05sKzFvalFPV1B3NUQ4ckt4aUVUV1lHY05WV2ZWMzV5U25tWGUvSWpQ?=
 =?utf-8?B?RTZna3N2V0FKZmoxd0RIekdSK1Y4WXZ0UCtQR24reE9PbHQrWG8zdlJPSHpC?=
 =?utf-8?B?QWlheUlvRFhMRzRyMTZyUkdvRWpTUk1CSUJOb2xTS0dkVG9VRzVwb3k2cElz?=
 =?utf-8?B?bG85bDBiSm5pMW4yK0N1S29lMWpUU0tLOXlRMkhQamlmdmNtTmZVc0tseEJo?=
 =?utf-8?B?MVlxQ0luSzdGN1BidDRZOGxhdVVxV0dOMU90ekZyMU10SE5Ya1YvNnNEQzls?=
 =?utf-8?B?ZjZEOGVLVFBNaU1OUXVPVjZ5dUhuUnladFZpckVCS3BwSVIzREtvcVBVOC9H?=
 =?utf-8?B?Mm50ZmNwZVBsanc2S0xMTjdja1dRNWRJRVVoZU1qRmI5WUNnZEhpZ1FnUW1u?=
 =?utf-8?B?ZVUwS1d3azJuUnhtZzJHSmxaUGtSZFpnT3BTKy9nRDh4YUtWbEN6R3lyc2ZM?=
 =?utf-8?Q?1UhRs+95KuDO+3UF2gvII9J3TuphpD7tACIStj1RyJXG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECBC61A864A8FD41B4AA2290AD59725A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4605c884-bd46-49b4-68cf-08dd665cb026
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:37:23.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpvXWTJiXxoiOBkbyf/eEqkPP3qG5s1iKaXI5Lz/SPBR3IQT7FTSFDxdZZfIidf/jdEqyQiV745pkPujmRHhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

T24gMy8xOC8yNSAwMzozOCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFdhZ25lciA8d2FnaUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gICBjb21tb24vbnZtZSB8
IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvY29tbW9uL252bWUgYi9jb21tb24vbnZtZQ0KPiBpbmRleCAzNzYxMzI5ZDM5ZTM3NjMxMzZm
NjBhNDc1MWFkMTVkZTM0N2Y2ZTliLi5hMzE3NmVjZmYyZTVmYmMwZmJlMDk0NjBjMjFlOWY1MGM2
OGQzYmNlIDEwMDY0NA0KPiAtLS0gYS9jb21tb24vbnZtZQ0KPiArKysgYi9jb21tb24vbnZtZQ0K
PiBAQCAtMjYsNiArMjYsNyBAQCBudm1ldF9ibGtkZXZfdHlwZT0ke252bWV0X2Jsa2Rldl90eXBl
Oi0iZGV2aWNlIn0NCj4gICBOVk1FVF9CTEtERVZfVFlQRVM9JHtOVk1FVF9CTEtERVZfVFlQRVM6
LSJkZXZpY2UgZmlsZSJ9DQo+ICAgbnZtZV90YXJnZXRfY29udHJvbD0iJHtOVk1FX1RBUkdFVF9D
T05UUk9MOi19Ig0KPiAgIE5WTUVUX0NGUz0iL3N5cy9rZXJuZWwvY29uZmlnL252bWV0LyINCj4g
K05WTUVUX0RGUz0iL3N5cy9rZXJuZWwvZGVidWcvbnZtZXQvIg0KPiAgIG52bWVfdHJ0eXBlPSR7
bnZtZV90cnR5cGU6LX0NCj4gICBudm1lX2FkcmZhbT0ke252bWVfYWRyZmFtOi19DQo+ICAgDQo+
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
