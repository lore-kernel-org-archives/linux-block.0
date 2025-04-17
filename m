Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48D8489
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744923936; cv=fail; b=ornTVdWA2tdnWWJZOdOZd35brAi3/DM1qtHqTGnCQlbKD7V+iHGojbf9uzfEkMm7Z4h0cYjudqMTmJY+4J3z+gIhuwlRM1lmO7+TmKBtpqG7pX6ZkQLKljYCEk+y4jPP0xEDDChqQOY3OcjciWVcHENho2HbDvmfqK+wQugYK+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744923936; c=relaxed/simple;
	bh=QaVtp8pJ2vhIYZ+SIIz6SOi+dIT+MLV5UTxKzU0J6uA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5s2EBGX1ejLF0ErK4g7jjvtm6L79ZtKO44H2dBxipj9GtiqXl5gZWWP71UMIgdk9HA0OExE9IW6d26WKSWfYw8m+5gD4OOIIqhmdP+7nix9521L79oKVelRl3pdjHFWqlcMkfOInFtAMeEE60gwE0OUVZXrQwh3zfUhOwkNelc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HpUZFunA; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HpUZFunA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICCvllpC4SCxXyFFEQWZhcVFdVkmdpOHn4xVK7kVMTObfNrKjXL1ALFmbzrt16Tkn5J9zC1kWR/qkniTw8oTwf/MhVesgduVtJDpQ4kZZ7/i6LWwbzMV6uX1+2jtpi8VzqkDR6geDX+4LVy34Dg2S9MDMzE7GNNzuLom/f3DVMNmlK45lIeI71XGjuToV4LCezOXfVkerpSFJVFGR7ciIG+FPYiviWGFBJEgxAxohQpUj5oPyqBh65FDsos42p8GsktodpVUQmvt8zImfmHnygtnCPN13l2hh+lhoHdb4c0NLXiv7YX4mCmExPn6PY6jDD/5d4qPinrGGu2mTRINrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhDe0c52YOBReeoVn97AF2U9rJhNwI9OjIupS2Pxn8Q=;
 b=V8/hU1tmztiaFGfVSvQtfvoC96vNPsj6AmfQRimazrL8HwFDZgJOGSMW39/AIDWfjarvQBrcz11cTezING/pbg6BwK8wYkrammxNa6sSgxywl9lO3akoc7auH0ounrOOIaw+cr0TqbyVK6noiuEOrZPX6MqPmlNVwckMi+sZJ9i6DbTQ0iPs037ptyj1S/VcuK0WDcq70MhNyrG3V5cK6S4mj3F4fidJNfnxRxvUsTVO1LRM+o/+f9mRHsl1Sx2wlpI3/74bVF0yaMribCcNLw3vnxF/dT4he0glNz3HuP/5b9UgxTEDltMQFVg/UiKRyjJzqU53Wo8QJOTzDPSgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhDe0c52YOBReeoVn97AF2U9rJhNwI9OjIupS2Pxn8Q=;
 b=HpUZFunA+2mPLYvknn/qwFw5l6qZX+Nux7Oc9Z5S9VgK22slyfthS/MeJmGmoHW4BXlIRjvF969xuAm6dRppPjDDSkLHuF26rjz06p/EtrZsgbjO2comP5J5qYLtzg6uhCgz8kZavhw6d2vMWTRhDxWIZnYNvsCOUEIjK/INj+ypoxpkp4Lp1iWTQYfggt7p037T2lhvz0yhHNUPxncEeRziZVD+L8rHvzZqg7NAQGTjIWYCn08OyITVSr5i5gdcZXKbttDW0XRG3aSFokxxEC2HnS4djRLTprrIhDRagzYpGpkcYkhZ3gj1kNlW5TiDPF4EAaS2DKEm/yg8FEuMUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) by
 DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 17 Apr 2025 21:05:32 +0000
Received: from DS7PR12MB6357.namprd12.prod.outlook.com
 ([fe80::cd09:cc72:6b5b:c6eb]) by DS7PR12MB6357.namprd12.prod.outlook.com
 ([fe80::cd09:cc72:6b5b:c6eb%7]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 21:05:32 +0000
Message-ID: <31fc36d9-4523-4ae5-bb7c-46c0748e6175@nvidia.com>
Date: Fri, 18 Apr 2025 00:05:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
To: Uday Shankar <ushankar@purestorage.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 csander@purestorage.com
References: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
 <aAFHMx/HopIv9DeU@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <aAFHMx/HopIv9DeU@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To DS7PR12MB6357.namprd12.prod.outlook.com
 (2603:10b6:8:96::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6357:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 427e5ddf-3a7c-408f-ffcb-08dd7df39739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkIrTkNpRWdXZEd2L2FUUDRCclF6K0hRMzhuUW8zT0h6WWpGeGNRWThXSFRS?=
 =?utf-8?B?WElMRDh2eHZkbE03Yzd5SmR4RENoVFNMcHpsOUxQN1R6ODIrS0xqRmpSMG9w?=
 =?utf-8?B?S0pXU1JrN1ZCSXZlZ0UyaHlXQmpvYnloSDREeExRRlJ4VytaU3lmanMra2Vq?=
 =?utf-8?B?cDdHclZDK0dvcE5PUFJhcVRhcENPUjV0c3lEcVNoeFY3SDVKKzdpQVBCMWM1?=
 =?utf-8?B?aFpCZ0dTRXltZDhubjNNTzIwUm9SRjZIRU1YaGh1RE9sa25WOUZmMDJvaXZr?=
 =?utf-8?B?c2lOa3ZJK2o4REdDZ3R6aEJLVTBMQTNvL0ovV2dVMXF1WmVpUlViWGRoVHF0?=
 =?utf-8?B?TnkzOXVnYVlHdUkyUUpnUGtRc1RnVllpVTJDSmwwMEl6ODJ6MmcvTzRIcHI1?=
 =?utf-8?B?NzJPUmNiTm9QdFRuN2VKTi9tTmxjbDNyYkFZZDBEZW9IbGlIRjdNK1B0NTFn?=
 =?utf-8?B?ZGk2aU9Sc01WMU91UUdKcjJqN0JuUlQvdm5BSVFyemU2dnV3OE1Ca0tIdXgx?=
 =?utf-8?B?YXh0OUNXV1BDeG1QeTlQR1EzaXltNlpQWlBJd1EwbXBNaU1QRVNwSkRXYVJw?=
 =?utf-8?B?Q284Y2VEYlBHa2FXNG5mT2FyMXNIcCszYVQ4V3IzenJjYUw5eUV1VXRFb3Av?=
 =?utf-8?B?QUIydzhWOHpLU1EyKzZpQ0pQK2ZlTm5NczZXWVFlRkR0RXNLSWtLTTJoT1NH?=
 =?utf-8?B?WmdLUFNUbzJBSzljb0xxcUpYaUszcllQa3NiaUVIS3krZCs0eVlKMW5xTUd2?=
 =?utf-8?B?TVVHNjdsWmdDNXhubG5BeG9CanBsbysvSTU1TXg3cXhkOE8wTVZFQUNMbkhZ?=
 =?utf-8?B?OGVuUGlBZUU4RnNQWVFtUklyK3hGaGFjd0Q5NnMxWnY3SzBCQ0ZVMUFJeWts?=
 =?utf-8?B?bGhESTJBTVRZRkJ0L1lvNUREVXIxWEVBZHQxek9MUCtBcmxobWVaeVU0R2ZP?=
 =?utf-8?B?S0VvcTFLTVZBS1dYUUFiWWNyMWVwaEVSdk5TQ0NpS3ZDU2srTU1oamdCemJp?=
 =?utf-8?B?V3UxUVk4VVV5STNIM1MvaVV6NlBCM0srTHlhUVVUZ3czaVU5Q2hScnJ4dWhr?=
 =?utf-8?B?eHZzWUthZkxiaWMzazdBbDhpUldMMjBYcGFha3NkNGtoN1N2UjVMWTRhQWNR?=
 =?utf-8?B?MzVlYUlJWlMxazlndGtXeDFGZzdFaE9kY2ZyY3g2SVN6OGluVjE2V1ArWXJm?=
 =?utf-8?B?VFpOaGJMTFB3S0V5UVpkbXFFdmc1SXUxN0QwMDFTdjdXczI0MWxLeVQ2Zk8v?=
 =?utf-8?B?STJCSVBMQzJ6L2NEYWR4dll2S2tEVGh4R0E1SFl6SlUyR0dNL2RxZlFWVGJr?=
 =?utf-8?B?TTB0bjJLSDIvdFgrQW44QkU2UTVjL00yNHk0dHdlWURUUURCWFI4c3g3Skg1?=
 =?utf-8?B?SGdwU2JsUDNGbTVuNkN1bzJzNkFHYXA1cU5Hcno1bk5ycjg0dXRSQVpnYlR1?=
 =?utf-8?B?ZmV4V09XOHd3c0N5WGNvcExaUGp6NVUrOW1CeVpwaDlMVnFyWEREQnhYMWlL?=
 =?utf-8?B?MnhaWis1b3lpalJsbms1aisvSUdDYkpiQzJNTGt6R1hkQUFib05JaFdjODBP?=
 =?utf-8?B?QjI5Q2cySWdHdmxkM2xGcXdkb3FVVGlTVEJGVW9FMnBEV2xIYy83ZkwzV0ZB?=
 =?utf-8?B?MDNzVW1KajN3R0ordGpGeUlYR2VPRW5HMm94MzhWWTZWdGd3L2tWR2JQWmRX?=
 =?utf-8?B?NGlwM0M1S0FTMS85Q1NlS0Rkd0JWN1RzNTJQNGJtUW9uMDVsa0lGMVkrTFJl?=
 =?utf-8?B?UGdxc0Roak14LzFCcllzK2d0U0ExeG4vdnVJQWZZRkJ2MlY2dGRHOXRkU0k5?=
 =?utf-8?B?SjExSlM0alQzQXlqM3djZEtRQlkyV0NiVzlEeUl0bmVhMHVCMU9QZm1tRG1J?=
 =?utf-8?B?dVpTWHlCV2NHd3RSVkVHZnljMnRBcWFVU2F1bkozWGQ5MjVoa3YycGhmY2RC?=
 =?utf-8?Q?PinD9I6Wqc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHM3OTMrQmpubGdjMnJBV1pnWm5XU042V094WkFqRzFSeW1OTzVqSnZyQW1q?=
 =?utf-8?B?VnUwL2x1OWJDendkMlRRdHpRcjNJRWwvUzlJZjFUNExDM1BYNWErQ2dYd0t0?=
 =?utf-8?B?NkZpRUR1dTk0ajFKTTFESUY1NlQrTXpKU0RzbmNGUWd5WFhQaHFMSStpL0k3?=
 =?utf-8?B?alNNTDNmTmdVMHIyVkJnazM5c3pRL1pjN1J2Wk1ad2VGRUpyVURmSFNsak1z?=
 =?utf-8?B?VVBCN1JjVVhISVJkcWJMblYvY3hHSDJhSWlyN2tRV0ZmQlVXenRpMVVvVUM3?=
 =?utf-8?B?dzVDZXhQRUxLQzY5RldPU1Vpa2l6clBjeXc2RzZKaW51dkJBT1FtVmlCMm81?=
 =?utf-8?B?ejBWaEEyNVAwai9FRWxQc0xNR1ZmbzFMYUVlY3lhZlFVUVdjOG1JTDFXYmVp?=
 =?utf-8?B?QlljRTgzbURXQ3JXZzlITEJiTWtxQTRXcnpRUC9rZmkzdEFWUDZpOVhuQTVO?=
 =?utf-8?B?R1FmVy8rU0RRL2FxRHpKakhVNDhaVkFYS3hhUUswSlRmNFV5UkNBYW5YYWk2?=
 =?utf-8?B?Qlk4ekQ0QXBWUDNnQ0hnb1VOVkhXR0lXNWRtRkJzNDFzTWlwb245OHJYVVpN?=
 =?utf-8?B?dHVSc3c2NEtIQzZhWkh2VlM0SisxbGprdnlUK3FCV0gwN3Q1ZzBtUXZTN1hQ?=
 =?utf-8?B?SmZEc3czdUNJR2t3MVBCdm5aMnJzWEJUL3hhOU5jN0lRM0pyZ1lxZHVjVGF0?=
 =?utf-8?B?OGYvK2hZN1laTjI4TVJkTkQvdXQwZzM3VGZsTTMrL1BHekZ0bXN4SS9CdGlG?=
 =?utf-8?B?RVZ0eHFkTzVuY1MrdElxY1JCc2h6cm41eno3QzlZTUhLeWhFSmJlNHJmQzl1?=
 =?utf-8?B?OTRFSldPMUx5ckoySDZUWXJWY01NeXpqNm9nbC9xZ053ZGhtbEQwLzVVY0dZ?=
 =?utf-8?B?SElLUkFZOVovNzRCUzBjRFNib25ma0pqL202bnRuR2w5VGF2RzBTVysyTmZQ?=
 =?utf-8?B?YVB6d1NlVDgzT0NsMXJ2eVVnTHhRNUdIZEIxMzdmajRUK3QwTWpXLzE2YzRE?=
 =?utf-8?B?VWdzaS80ck1naHRFME8xajRXWWFTNG5kbDNVbDNMY1g0by9OQWg1ejRRUnNk?=
 =?utf-8?B?NU1idFh6djh4Z05XTUYvZ0ZNS3hUT0pvVDRzdlh0ZkpJYnh1VWxkck42WDZZ?=
 =?utf-8?B?TGRMdElqU09VWStRMVBkRVNadTNTSnJsK1N2eFJVS1BKckIzUDdISEhCSytJ?=
 =?utf-8?B?S1pRZElCYzJHVk1uWUIyc0FuOW9wWWFIQWtmYjlBQ0h4U2lpaU9OSWV6dDNE?=
 =?utf-8?B?TEs0SWYrV0ZVUUp4NVNzWWd2ekdBbTN6djk5eTF6RVoxeE1YUk1aOW83L0Zh?=
 =?utf-8?B?Yk9odnhLUm9QVEN5aXk2MUNtZTJBM2lvc0dLQ1BCemNMa0wrUENDaUtPdWlz?=
 =?utf-8?B?TEJjUHB5UkNZOXN2bTE3Z0J4bGpWdG9IY0N4YUh0Y2R3em5YRHFGS0pUS0RZ?=
 =?utf-8?B?VnAvY0RTNDNRRTBNVkorMGxqVWNzOHRRVXl2bW5wNmZlNldFQ2dSZUt2dzJz?=
 =?utf-8?B?QnJza0czYWZta1dSNFRpTHhDb3Znc2RWamJYb0c1U25LRUc3UjVrS3B2SW4v?=
 =?utf-8?B?SWRlVEZ5TmZPdnFlK1hvVy8zSE1RcWRoZzkvVmdZUnFOUS9HWi9rT2xIM2F0?=
 =?utf-8?B?N3diRG1PbXIzeDNIODl3amxkNy9kaDdhM0FSVVU0ZEUzWjBVcTRjamhBMFp2?=
 =?utf-8?B?bUdmcUJwNEhzanVseGducW5kSHhMTnV0Rmt6RkJUUWJpVkNPNzNReGZEN1M3?=
 =?utf-8?B?dGhKd0JGcFc4Z0NVQmQzcmxKT3RLbG9jekVtSDlxbDRYejVZeVFUNGtvOTI3?=
 =?utf-8?B?YytyeThoWkczK29tR1RUNmxSckxGWHQzc2VrQ2VvZ3czRXc2M3QxbDJwZU5C?=
 =?utf-8?B?cHRSTGJlMTJFRXhwbUVQQVhQUWUyYjFiMHNHZWtlMXpVVnZmRXk1VWhBaGFw?=
 =?utf-8?B?cjU2ViswM1FsSHhtelJ5aGRuNGRGOUZyQ3BTR2x1bmh2S1VZcFlMQlZ0RmlF?=
 =?utf-8?B?bUM4UUhCL0ZYdm5FeU13Q0ErekR2OURMa29XZ1NiT00ydFc0TzVsbnc3N05j?=
 =?utf-8?B?ZnFFWFA0dWhmcmdCVjlYcTJzUjVLMDJQelc3WElmNVpWSld5OWFjK1pFUDEv?=
 =?utf-8?Q?bSMXsJ7MJyRAbZCW8FcLuJq8F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e5ddf-3a7c-408f-ffcb-08dd7df39739
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:05:32.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzVxlhCQGxLahoF2Bxigu+pQlVw6CtuyLwVI4bsH/KlkzhmHGAm8hxGP5FmwI4vfWHpZVKonTwOUX+lbN+9HpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614


On 17/04/2025 21:23, Uday Shankar wrote:
> On Wed, Apr 16, 2025 at 01:07:47PM +0300, Jared Holzman wrote:
>> Currently ublk only allows the size of the ublkb block device to be
>> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
>>
>> This does not provide support for extendable user-space block devices
>> without having to stop and restart the underlying ublkb block device
>> causing IO interruption.
>>
>> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
>> ublk block device to be resized on-the-fly.
> Many of the other parameters in ublk_params/ublksrv_ctrl_dev_info could
> also feasibly be changed after initial device creation/start. Is it
> possible to design the API in a way so that we don't have to have one
> command per parameter?

Already spoke to Ming about this. Changing the size is reasonable and 
easy with a simple api call i.e. set_capacity_and_notify()

Changing the other parameters I struggle to see a reasonable need for it 
and is significantly more complicated.

>
>> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for this
>> command.
>>
>> Signed-off-by: Omri Mann <omri@nvidia.com>
>> ---
>>   drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
>>   include/uapi/linux/ublk_cmd.h |  7 +++++++
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index cdb1543fa4a9..128f094efbad 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -64,7 +64,8 @@
>>           | UBLK_F_CMD_IOCTL_ENCODE \
>>           | UBLK_F_USER_COPY \
>>           | UBLK_F_ZONED \
>> -        | UBLK_F_USER_RECOVERY_FAIL_IO)
>> +        | UBLK_F_USER_RECOVERY_FAIL_IO \
>> +        | UBLK_F_UPDATE_SIZE)
>>
>>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>>           | UBLK_F_USER_RECOVERY_REISSUE \
>> @@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct
>> ublksrv_ctrl_cmd *header)
>>       return 0;
>>   }
>>
>> +static void ublk_ctrl_set_size(struct ublk_device *ub, const struct
>> ublksrv_ctrl_cmd *header)
>> +{
>> +    struct ublk_param_basic *p = &ub->params.basic;
>> +    u64 new_size = header->data[0];
>> +
>> +    mutex_lock(&ub->mutex);
>> +    p->dev_sectors = new_size;
>> +    set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
>> +    mutex_unlock(&ub->mutex);
>> +}
>>   /*
>>    * All control commands are sent via /dev/ublk-control, so we have to check
>>    * the destination device's permission
>> @@ -3152,6 +3163,7 @@ static int ublk_ctrl_uring_cmd_permission(struct
>> ublk_device *ub,
>>       case UBLK_CMD_SET_PARAMS:
>>       case UBLK_CMD_START_USER_RECOVERY:
>>       case UBLK_CMD_END_USER_RECOVERY:
>> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
>>           mask = MAY_READ | MAY_WRITE;
>>           break;
>>       default:
>> @@ -3243,6 +3255,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd
>> *cmd,
>>       case UBLK_CMD_END_USER_RECOVERY:
>>           ret = ublk_ctrl_end_recovery(ub, header);
>>           break;
>> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
>> +        ublk_ctrl_set_size(ub, header);
>> +        ret = 0;
>> +        break;
>>       default:
>>           ret = -EOPNOTSUPP;
>>           break;
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>> index 583b86681c93..587a54b3cfe1 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -51,6 +51,8 @@
>>       _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
>>   #define UBLK_U_CMD_DEL_DEV_ASYNC    \
>>       _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
>> +#define UBLK_U_CMD_UPDATE_SIZE        \
>> +    _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
>>
>>   /*
>>    * 64bits are enough now, and it should be easy to extend in case of
>> @@ -211,6 +213,11 @@
>>    */
>>   #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
>>
>> +/*
>> + * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
>> + */
>> +#define UBLK_F_UPDATE_SIZE         (1ULL << 10)
>> +
>>   /* device state */
>>   #define UBLK_S_DEV_DEAD    0
>>   #define UBLK_S_DEV_LIVE    1
>> -- 
>> 2.43.0
>>
>>
-- 
Jared Holzman
Senior Software Engineer
NVIDIA
jholzman@nvidia.com

