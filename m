Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462D192D8F
	for <linux-block@vger.kernel.org>; Sun,  6 Apr 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743970635; cv=fail; b=TLYxer3muHeJLW2JAS3bZi7UDNEIFsutekE4a97Kwgzc0G9eBx3gi8TDZd5sSzEud2V1ybg9gHzgj0GSZM5Q5QhgRE68x3702l6U9OCx5MfH/PDowwqH/k03HyBYzgjWFslpyTcUmBggZCqJYxOacHbtZZPjQ/IQH3WcO+kKtQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743970635; c=relaxed/simple;
	bh=raTL44F4v8n6N5/AXCpTQsZ4nOQLkBo1m9mTpUtTF+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RRsX6etJsDuQl1GQS0nMyHkXHDXjX1f2vLMcvWUaw/OxfGJyhIG7cNfnZsr5yVSNUSlME96vI38jY7ZCPo8CEbb7AHvw+bDFWvAqR4Sp9N9Z3znd4v24XkcycFR2HyYoceMtghX8/mbyELqyD8LoV2qqM4/Xw3NcAZmLeZuJ31c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hgaSwujU; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hgaSwujU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ7lCdoJgMgj+7kt/SdS18e+hw81TT8l0bOewfNQJf3hJhZrsV7Cu/EIkPlQtDHmOW0EwrIblb79UeQXMidVS11uasRx8sH/FLgQFXAyIZxs50ahdoFHS7Gem1Co6xN4fvVmE6l75iucHTp3kYkc9TacNgSoH0S5qq9CanVjWe1Q6jrtSdnGAlBy9Aw0CIEhDAY2oNffeKv5AfKzdVPFPdwcn41i4oYHI0eOgKyVkuSUUX2y4XULC22Bx+Jxi2cO5E1GMgAZiCbHqkXYDW3T+la6b1MdWRHpV3ZxvQArHZPfwSlgo8XVpeaMcjWWBvm0ycY63nRCvMuaBw4YLRiecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9ZFZg6PKNq4wgviSg1rgwbRFFM+8mIWwwDn2WihmdI=;
 b=buDb1E9+oJzoPmzpD+Qo+zN666G3nR8a+DfxXphV7sTlOKqv1L0qEOjL9UjnfHqJUlQGqgylhTbiSrhVIRl4ifCbRoIUER1cJYBnq7ddPAR8Nyw2vwdzFSXzaiZiygPUIql7Yxoj3wvgEzrLl6R7FflFO49F7qjy/Cb1TknkK54/JcCvyfdYkEizFe0zB2SkFYh7scrTszbtF7XWz+D6v85yxXx4ZuCBUu5pNGJrdyY1J7HByWFzEQtHIgwVS3Afu3qaytOoh32Bbk+MPov/zB319LxMd4FaD3gdxj0895uFfj7+9TDaGzW5TLaIZdy5YDkDVsdgszY1nebc/W5afw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9ZFZg6PKNq4wgviSg1rgwbRFFM+8mIWwwDn2WihmdI=;
 b=hgaSwujUOVheUREEaCPo56j8cmonJHPRQdIuJvN29+9QX0m8u3OCvRHvHXopSHqtdJE73MDq7aElSKgm3Y9d3lcaOYJaaDXsfpEG9aD/lx4QeKvD9Tv3ZZ1I1ecN0+NQym08YxGh8+mRlcL814jhSYKUlaAW4O/KFz4ovy9c8WvnCnvis0SDEOc0wPE/IW30EFQ6gdfxOteI75Yq3aeIdi+WfasgtzTJasP1HX3mSZ6lBCVboXZBXCBBpcKlbM2kMjxh72JqTDRTZLgqpERTKj9zWklHQNah8lljVznuLQ1Os85N4BbKQDSNL+NRWj9o/OQx1yCj6ZLM3xY2Vqj5CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Sun, 6 Apr
 2025 20:17:10 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8606.029; Sun, 6 Apr 2025
 20:17:10 +0000
Message-ID: <07db9a34-c5de-4ea4-afc5-e740e87923c5@nvidia.com>
Date: Sun, 6 Apr 2025 23:17:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250331135449.3371818-1-jholzman@nvidia.com>
 <SJ1PR12MB63639AFCE9BC8C1EC4D28795B1AE2@SJ1PR12MB6363.namprd12.prod.outlook.com>
 <Z_Cana4Ibs8zN_wA@fedora>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <Z_Cana4Ibs8zN_wA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8112ab87-ac11-4ab1-4c59-08dd7548029c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ald4a3grL2dvVDh1cWpRWmNqa2Y2MEJJbTVBVWdYWkJYcVp2RG50c09GSUty?=
 =?utf-8?B?OVU3a2I1NnUrVGJVSm9pN09KaVBZaERsa3h1aTRZS0N1SzI3Z3Z2a0VGTnhJ?=
 =?utf-8?B?RG9XODNUeDB0cWh0NE9ZTEdhVlFpOGFHQ0VwUlVXc2JoM0xsclBlZk5JTFBX?=
 =?utf-8?B?aVIybmt4cVBQTDlEZEhiOGROL3pjbC81eWhSZko2MlVDN3BXZ2RFYjNXSEJo?=
 =?utf-8?B?RUhKOVFwMlRUQzZqbEV2ZHh6MFluOUVzWTRSN1NST0k4STdQYlhYbHJQUkEw?=
 =?utf-8?B?em5CVVU0NDYyU2RZNWltckJYSXpIRDQ2Y1QvaWhDZVpjMlV1c09vYmRqMVpZ?=
 =?utf-8?B?bEhOSFZIK0l0dFBzZUEybGdJS1o3UTNsZ3FrUE9SSzNLdzYwbjRtNGhURHNh?=
 =?utf-8?B?cWhQTjVlODlWTnFIbGtWVUYwbHplR002Y0E4eWZTM1NENWFMNkh5d3JFOHBT?=
 =?utf-8?B?NXo3M0gzZ2xKZEtOTTlHTmNwTjFLNTF4ZCt5MERNc01UN2puWkRxMVhHcGlN?=
 =?utf-8?B?VEY1aDR1L3FJQmdQS0pVYjIxVERxdENlbXZTTFhCMld5amFKaEwvSlJMTnhL?=
 =?utf-8?B?M1YxQ04wWVgxRk1QL3ZiV2dQUWIxY0lucUxzNVJ6R290N1VobHJ1NjZtKzV6?=
 =?utf-8?B?dXpyNTgyWkxIVWlCSlN2czlGa2hYbjVDMXVYZ0dxQWQ0aVFSZUlsMXREUGVp?=
 =?utf-8?B?cTlSZHRHZHB1QzNBdk15cjNKcG5LRlVzaDVhcnE1Z2VvRHJ3cGlzM1llakdQ?=
 =?utf-8?B?ZzludFNzMjNYUTMySTdzeThsZy95bWVUSjZ3Y0VpVGpjd1lYVkFUdlNBZEpr?=
 =?utf-8?B?bk1SVEV6RnU0T3MyMUdDVmpkWTdUZzNDQTZJZFN6VnRJdktxNkVSTUdaRWRI?=
 =?utf-8?B?dFFpancyaUVtL0p6aEVQeFJSdUpKdUMyMWw0WktrZ2srTWhoZHFDc1lGUjNY?=
 =?utf-8?B?amQ0WTVDeE9EWktaTWJQQ1ZvUVhUTFBzNzYzSnlVTWErWVZrWGc4ZTBOdzd1?=
 =?utf-8?B?WFU1Zy9URUtjbFlYWEhRLzROU1haZEdiMTRqQnBQTUVua0UxSUg0NVk4dXJR?=
 =?utf-8?B?VTRZSXUxTEJsampuRGVVQTRNQU95SVBkVnBBSkJsM3V4Vmd4Q01qampVYkU1?=
 =?utf-8?B?SUwwV0RrUHhISWtCaXRhUzBJUTZFSU0zMkxZWUNBUCtpR1Q2U3dtdTA1WFF1?=
 =?utf-8?B?S0E1NnFneDYrc1NpZWpzRFh1WUpJUEtXMUhpVUVXVzlWalRFZnNHNzRWM0Ew?=
 =?utf-8?B?VjEyd0FTeUgxSDBqS1FKUVlTeWRMVUVrTXQrQUlTei9wTDJQcks1eWJZRkNw?=
 =?utf-8?B?cEI4T0ExR3M3MVp3LzY5VURXMkpyMHo3b0doa0JvMkpOWStuNmZ2V2U1amZW?=
 =?utf-8?B?ZFJhY0o3QXFCRUVQeXdVTGFsNitPUGNjMXpWNFpQRXRvZ3hEUEtXd1d0ZENz?=
 =?utf-8?B?emZPZFJuSm9HOUdZMmU0OWkxMUpFOFI2cE5WOFUwNkNrVHN0VUtNVjcrVXo3?=
 =?utf-8?B?dmhtdk5oNzM1WUxwSVNMakRMQjdrTExZNnZBV2NFYzdKdTM5WE90U25TRm96?=
 =?utf-8?B?QmtaMjY4eEtnTzVBVWN6STJXQm90eEV5RkxMdHI4bHF0RGRnRGtYNFRuZCtR?=
 =?utf-8?B?N0lwL3lVejg4U2tsU0N4L3V1TjJEM3Fac0R1aFlzUk9JZEMrVEd4YnZ3T1Iy?=
 =?utf-8?B?MlozQnE3SmtRTWE4MUZ4UXZMR016bFh5L1pnZnVTRkF1bG4wQnUrTjd3eFdT?=
 =?utf-8?B?b2EzZk9neHNvanQ5VlVWWmtLV2p3L292TjJiL1N3dmhPT1RKeWRXRmVmWHJa?=
 =?utf-8?B?cUEvNDJnbE5GOEtQUndvMEc1S0N5ZTk0aExKZ0xiVXZpdUNDb0NSQnFSV2ZH?=
 =?utf-8?B?enBxSTQ1Nm93b0RFSXBBTkVBSmFMMlVoUFdMVXlNaTZ0RU5qNWJhZGg1ajBX?=
 =?utf-8?Q?8nvX141IpPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlNVK0tuaGlkTnRvTjFaOWEyVkwxVC9sdDBFbFpmZll4ZkljK2pKbFhsNkY3?=
 =?utf-8?B?TlI5WTJqZ3lRMWVZTGkwN3duMW42aThMSE5nOWdseWw1NWFLdnhsYnNZUTNL?=
 =?utf-8?B?bVM5SUwwejZvSzBER1BqOXJoNzZoRDZrSHFVVTNCK3o3dWNxWld6U0prdXkw?=
 =?utf-8?B?aU54OUZCZ1N4dm5Qc1ZTVEVRZXlJMkxCckdISDZObXFxUEZYNXR2M2orNlJK?=
 =?utf-8?B?Mlc0dnJnTTF6N0lRR0tLV2RTdWt5bm5uTUVYUkpSZklCRHNKVkxRTktXbDQ0?=
 =?utf-8?B?VStxZGhWSlR4bkhrQk52dWZjVUxjc0tidDZJek42Z0QwUS83eUs0ZzNCcEU3?=
 =?utf-8?B?cTJ5MFhZTU0rNExhOGJ3NWRjUDg2blRSa0o4MlFCM0c4elJhZEJJZUhpVGRW?=
 =?utf-8?B?cEVmdkRON25Yblczcmo2QUR6YkdhbU9yYXZidENJNTYzRVZWZTNPR3N1M3c1?=
 =?utf-8?B?VEhuMXUvaTRBWWZCRGIyUFFsUkpDcjZFMkxtNnRCNUtDWFFGNEQ0ZVpoNk81?=
 =?utf-8?B?RXpjekZtQm4vUEc2d0lEcGl5WWZVTWRoMENwMHdXV0hVbmpPd1c2SmR3Nm5t?=
 =?utf-8?B?WnlZTzV6K29BUE9FV0JCd3Fta0NMbUkwVFRCVVBRZktBa3p0bk94b29HV3Fq?=
 =?utf-8?B?U05aVlJ0YlFKVlZnR3NPYm1mQjNQdnhGZzRGalA2czBFeUNaMHhnNGZCY0Zo?=
 =?utf-8?B?T1lVckRCeXlNRVR6bWdvTVhPejhlUmpmSytWWGpsYm5Ib1Fha3BJNUxzcy9P?=
 =?utf-8?B?ZUd4Y0t1bklBSjRNbFhOSDlvMUxkMzA0NDB5a3AvT1ZWb05mYUpSWmRxK1d0?=
 =?utf-8?B?dTgzKzlmTXVOOUx2UFQzRi9HelNhbFNBTzVvRUVWMTB4U216YmRxanVqQksv?=
 =?utf-8?B?Q1dRQUljc2JIOWNGMkNEcXdMMXJORUtSZ2tjbm5VenByeG90Z1Z1QkZmZEJw?=
 =?utf-8?B?V3J0WVE4RXh3bFl5YmZNd3dkMTNubUwrUEJzbElHRHBQRm91MWtzY1laOTNQ?=
 =?utf-8?B?UTVGRUZCS0M3YTVldGdCZmtYcUdLZGkvRlErSU9zbGxTQjJaS1VsN2pTVCtG?=
 =?utf-8?B?dDgweXlYdUVtZldMUEJxSU1PTSs0T0MrY1RUc1JDNVZSWjNJbDdna1hWS3Zu?=
 =?utf-8?B?c1VCK0Q0TEUxY1lYenZkSkJSRURDb293dFUzOVBEKzdIU3JjUDhjUkFsSFV3?=
 =?utf-8?B?bmNOM2owVEQ2QUx6VFN6aytEZTBDc2l5ekVaMXlPcnpyK3FhZUU5ZkZwWnBE?=
 =?utf-8?B?c0xYK256WlNObFpDcUtHT1lrdkdUajF4Z0Z6UWZLSUltUmVHTlJ2eU94dnUr?=
 =?utf-8?B?Q2ZYTGJZTU5laDhHTjRvNGhXRWJIN2NBbVFKZ1JReGVwV09xalhKNjlkdk5k?=
 =?utf-8?B?citUbEJTdnNXZWlUUFI1NmRBTHR2MC9MVlBpZHlyV2dPeVhlek80RzgwOE9X?=
 =?utf-8?B?YTlCcHFNT1I0ZFVZdHdlL295RjdMOFFtMDdrU1llZ2dhOG1aRFBqYzZOTXcx?=
 =?utf-8?B?V0FHMytjeXlsSkkwekp2MkVjbkpQK2E3S3BHVDg1TldDTSt5SkUzcDYrRHh5?=
 =?utf-8?B?WldBd0pSWHJmR3pZUVdINTBmNkIrbVIvNjRuMFdUb09sLzluY2FpU1owQnBX?=
 =?utf-8?B?M25TR0hOOTZKazJNMGpVK3ZCeHREcFZjNkpYYzBjdVd3Q0dQMmQ3SXBGK0p2?=
 =?utf-8?B?N1RRVEVlNldzdUVHQXhXcU9mMlVWTHNuYVNKdGlOcEw5SmRHcG8xQVY5MjEz?=
 =?utf-8?B?SkdlZDNpamUxYVN0TTQrczNraDBCTHRBTjF6RUo1R0srcnI1dFAzZGNKemwz?=
 =?utf-8?B?VUljdkE1Rit3WUlvdXlHS3A2dmF6UlB6RUpMR2JrVldjWFVXcEtzZmg1OFNC?=
 =?utf-8?B?R0l1SThMazBBWGN3R1hVOHRZdE0wVnZ4UGhITXhqdVpYVzdTYUhkRXdiZm9O?=
 =?utf-8?B?dW1pSk1CL09BV2tTOEM4OGZYczFuOHY0ZEI1ZzRWNmNlTUY2aC9GYjRMVTVJ?=
 =?utf-8?B?ZTVQV0tCcUIzdlBiTWJYaWc5cTNjQ0xtZ0dTSklPY1NjZnlsVVZJK2Z4clA3?=
 =?utf-8?B?VnNyT0tHZE5jSkQzZXJJMnRPNVZkN0dTeng5TDlxcnJoOHV3eTNwcVhzWitM?=
 =?utf-8?Q?e27gR0WOvTZSf75/k4HlBsNx9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8112ab87-ac11-4ab1-4c59-08dd7548029c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 20:17:10.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoW5GMcKxF6sIxgaGgw9u4bp7wQ2HHMXl0WI53/6k3cVEp+8BFePNoh1ibCXzWgK3xRunG644WVJzETX6VjF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Hi Ming,

On 05/04/2025 5:51, Ming Lei wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Jared,
>
> On Thu, Apr 03, 2025 at 12:37:11PM +0000, Jared Holzman wrote:
>> Apologies if this is a dup, but I am not seeing the original mail on the mailing list archive.
> I guess it is because the patch is sent as html, instead of plain test,
> please follow the patch submission guide:
>
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

Sorry about that, I originally sent the mail using git send-mail, but 
our internal smtp relay does not support outside addresses. I then tried 
forwarding it from Outlook and it decided to add HTML without telling me.

I'm using Thunderbird now, so hopefully it will be in plain-text as 
required.

>> ________________________________
>> From: Jared Holzman <jholzman@nvidia.com>
>> Sent: Monday, 31 March 2025 4:54 PM
>> To: linux-block@vger.kernel.org <linux-block@vger.kernel.org>
>> Cc: ming.lei@redhat.com <ming.lei@redhat.com>; Omri Mann <omri@nvidia.com>; Ofer Oshri <ofer@nvidia.com>; Omri Levi <omril@nvidia.com>; Jared Holzman <jholzman@nvidia.com>
>> Subject: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
>>
>> From: Omri Mann <omri@nvidia.com>
>>
>> Currently ublk only allows the size of the ublkb block device to be
>> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
>>
>> This does not provide support for extendable user-space block devices
>> without having to stop and restart the underlying ublkb block device
>> causing IO interruption.
> The requirement is reasonable.
>
>> This patch adds a new ublk command UBLK_U_CMD_SET_SIZE to allow the
>> ublk block device to be resized on-the-fly.
> Looks CMD_SET_SIZE is not generic enough, maybe UBLK_CMD_UPDATE_PARAMS
> can be added for support any parameter update by allowing to do it
> when device is in LIVE state.

That's fine, but we'd rather not take on the burden of verifying all of 
ublk_params to see which ones can be safely changed on-the-fly.

Would it be reasonable to have UBLK_CMD_UPDATE_PARAMS accept a different 
struct "ublk_param_update" which contains only the parameters that can 
be updated in the LIVE state and will include only max_sectors for now?

Alternatively if you know off the top of your head which parameters can 
be easily changed on-the-fly and we will add only those.

>> Signed-off-by: Omri Mann <omri@nvidia.com>
>> ---
>>   Documentation/block/ublk.rst  |  5 +++++
>>   drivers/block/ublk_drv.c      | 26 +++++++++++++++++++++++++-
>>   include/uapi/linux/ublk_cmd.h |  7 +++++++
>>   3 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
>> index 1e0e7358e14a..7eca87a66b9c 100644
>> --- a/Documentation/block/ublk.rst
>> +++ b/Documentation/block/ublk.rst
>> @@ -139,6 +139,11 @@ managing and controlling ublk devices with help of several control commands:
>>     set up the per-queue context efficiently, such as bind affine CPUs with IO
>>     pthread and try to allocate buffers in IO thread context.
>>
>> +- ``UBLK_F_SET_SIZE``
>> +
>> +  Allows changing the size of the block device after it has started. Useful for
>> +  userspace implementations that allow extending the underlying block device.
>> +
>>   - ``UBLK_CMD_GET_DEV_INFO``
>>
>>     For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index c060da409ed8..ab6364475b9c 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -64,7 +64,8 @@
>>                   | UBLK_F_CMD_IOCTL_ENCODE \
>>                   | UBLK_F_USER_COPY \
>>                   | UBLK_F_ZONED \
>> -               | UBLK_F_USER_RECOVERY_FAIL_IO)
>> +               | UBLK_F_USER_RECOVERY_FAIL_IO \
>> +               | UBLK_F_SET_SIZE)
>>
>>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>>                   | UBLK_F_USER_RECOVERY_REISSUE \
>> @@ -2917,6 +2918,25 @@ static int ublk_ctrl_get_features(struct io_uring_cmd *cmd)
>>           return 0;
>>   }
>>
>> +static int ublk_ctrl_set_size(struct ublk_device *ub,
>> +               struct io_uring_cmd *cmd)
>> +{
>> +       const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
>> +       struct ublk_param_basic *p = &ub->params.basic;
>> +       size_t new_size = (int)header->data[0];
>> +       int ret = 0;
>> +       unsigned int memflags;
>> +
>> +       p->dev_sectors = new_size;
>> +
>> +       memflags = blk_mq_freeze_queue(ub->ub_disk->queue);
>> +       mutex_lock(&ub->mutex);
>> +       set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
>> +       mutex_unlock(&ub->mutex);
>> +       blk_mq_unfreeze_queue(ub->ub_disk->queue, memflags);
> Actually if it is just for updating device size, queue freeze isn't needed,
> because bio_check_eod() is called without grabbing ->q_usage_counter, but
> for updating other parameters, freezing queue is often needed.

Gotcha. I will remove it and send a new version of the patch.

Thanks,

Jared

>
>
> Thanks,
> Ming
>
-- 
Jared Holzman
Senior Software Engineer
NVIDIA
jholzman@nvidia.com

