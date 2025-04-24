Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA131F37CE
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529049; cv=fail; b=PcydHn/92xwzBWmRwW2WW3mJdmGyJ1hQwM63oDx/bY6Zzn26zuq/zI/kHuFoGpOkkEGkKxOw4yyZhlCOZcr5iHlvWFgh3Ct0kRylE9N/0d0VEh/U592Cb2eKwL13rpnl4JZNGg0wJRINSzmQjfXX3SKhwCY5Ad0p8XKEPbx1y3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529049; c=relaxed/simple;
	bh=TqprpXupYpwwMSFaFU0rO9Q4U4XO6O0ZzVnMtk8QDPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5w6yfox6402xBf/UuFDwjToCUbtyy7Oc7AcpmEPb4BKjsWtoPeI/80mlYMP1rDym3PQS2SpZJ1udIgq4RxSPnRr3zAd9S75UiODTNNsna80nuEWMsHQC8plTqb+DHRoNNbK5cu8yV/CcupLA/1KEpVrOO1a+dcms3Mk/PvO278=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E3zFlSrw; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E3zFlSrw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/Kn+HiQtDIEx+Kb4ampINvcapX6l6s9Filv3F9XUy27o5QL4K+3ORC3T69pWb+Kim0kTnovDpeiit3zwrn0QR5JXuWzSbwUTNaBqRRAFzYa2vNjA1AuSvoEGoKuO6bIQeIi//810BzRixAIsFOHEuvmSXDjnszctNgjDxrYhqMtQX3FtbJLfZOcbXbGsbK0u8Z81FDLwTm80ShQt/m5kXFu2ZqFkjzy3f8zakkLOHK+J4clscflxqmDyWUSc51iiDMWxjFwG1ySul7xzjWttLETZu972+tGcXo+6F1k80Pn8AI6DdPpVu/DyMZ4BHLkdIdxd13zF4/fFgKm6mYZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fee1tGmyIkeWrNOkIXu6hPiiHiAncbjf6c3+S//dHEg=;
 b=ckTjBzB7H1u63Lf99z/MS3g9R054t5+VFeOytzlv023RH8KvYaxUBDPRMMFnDAi6oEdKIdIPdwGayn3m3cjr4fBMyUWne35pNBDGkzNQmLsq5bHLq3sFUT67KRD6qyuifHGcqB1UHbc7fvxs2w1oPKqZrAlPnF+Br8BSICfG6mjEUaIrQVGAwCU60CyQhJbxQVZ9voAGyjpk3uNVAMKQouGfwhz4D+aQFVtj4QsONsmPZvjfH2NJaMZVetD3CuvibrQgmY02/gbxjhiojUOy37NNz+mbaEma/oYKny1XRlLPVsfKyKxgSPcHRylsbYpAjIxxTWwziLyTFldpeQoqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fee1tGmyIkeWrNOkIXu6hPiiHiAncbjf6c3+S//dHEg=;
 b=E3zFlSrweyH/KuMUFUBHe8JtG80CnnI+lm0wZTSLcemzZyKyKBHsezej1fHRF91zEd/akCXwtbKZim11H0lfwEfl18+1XyKK8TqGnHG6u2EkF6E2oMqcpGhjvwvfxZ4sE97NurBbfm3fTt6eBFVCEzOYQr2/otMYFithEItEes0YL1rZF4IpZDvbiPFI8Ku/UrqSurrwcNIdx5HXDV3rWBGlUfNvLblDzliGNlyxC4FuU8NkNmrrfLN7BETrIZ2XtUEGXBXonpZfW4G6+rrL8k7rSOcHCqSZB1tQOdmNkOFIZoN445umkpHQOVqCFg6OvlT7yauck3LN+0yJMTPmfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CH1PPF6D0742E7B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::613) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 21:10:43 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 21:10:43 +0000
Message-ID: <f7d8a462-7685-47e0-a206-77d358ff4639@nvidia.com>
Date: Fri, 25 Apr 2025 00:10:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
 Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
References: <20250423092405.919195-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <20250423092405.919195-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebd02c2-37b2-4ade-4f50-08dd83747934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE8vRlhjT2pZN2hGRys3L3NBWTJiUWEvY3ltZEpjUzRZMzkxVVY5a0VVL3hM?=
 =?utf-8?B?SnpoQTE4UHcrSXFTUkFySzNlTktvUTd1RWFKSkxwdFp2SjFsTDR0SlFVSHVK?=
 =?utf-8?B?M2JVN2VObElIUk9GTWhmNjZpbC9DRVlQZllBOWsvMGlOWWNxYzNzMUo4WnZY?=
 =?utf-8?B?VGxpSzlzbGV0dVQvMXJsaVI2S1lmdG9jT0VVS3Q2YTQ2d2trR09MaGFkYzBH?=
 =?utf-8?B?cFVOSW5POXY3NlltMjNINFRSN09wWC9Rc1pPRUFITGNQbGdHRVlWanozR2VN?=
 =?utf-8?B?Nm4rZ2w3dDNMQlJ0NUF5bXB6dzF3MUpGY0xRNmRDbWozV2tRbGZPSW5xWWNw?=
 =?utf-8?B?d1pPdVFEV0JSWDB5YituTVA4UlZuNUxNamNoNExOdVVnSUFreTR2QTdYV2FJ?=
 =?utf-8?B?aGZwMFJuRFRBRmhndUtVUmtzbDdrODY0NWM0K3R6cmVKOE51QkUyQ2lHZEMz?=
 =?utf-8?B?aGRReW5ZOUl4UEJnNnFyK3J6cjFSbG1hKzhEcmFuMEtCNUo2M1VqOVJmYWxi?=
 =?utf-8?B?VE1yVnI2RTA3NDVIZ05QaFZLVHY0SGxwL3RrTklHY0doYXFGNUgvTXgrb0xo?=
 =?utf-8?B?enhiQ2NzdVA4NHZZdm1BeStXUTZjWTVycEdIWDVuSlp0dGtJeHZpam1ydWFm?=
 =?utf-8?B?NzN5dW1lbXcrR0VlcS92VHRyeDdNYlpxejZZSUk3VWhGSUg0d1VPaTdzZEpK?=
 =?utf-8?B?bmNuMFJ6SldDTHZadVRqeEJHaW5uZlNQNXlFU0hoTGxTRUFoQ3A5bVNTSzFw?=
 =?utf-8?B?aCtMQW1CTkM2SUZBenBxZGtEUlVNUEdLenpaMTFJWEljSXRXbGViek4xUllD?=
 =?utf-8?B?TS9IWnZVTjdCYkF1amh6WmJqNzRsbGsvbkJyc3VCeS95OUJUQjZJdnRlM054?=
 =?utf-8?B?c1o3SDVRcENRSmh1SmZwaGRGTURyMm9ETWdNdmZUNjYyMDFKT0JzaG5Fbjh6?=
 =?utf-8?B?Q3NJZk8wSEhYM0NmZis5VXFtTWVsYXhRYkRocFQ0Q2M1Ynh4ZVpvb1ZlZGtW?=
 =?utf-8?B?OUg2UU5OeE9FQVpnQjR3RVZVdmJHVE5IRGFyeWVkM3VYU28vY05wbms5enNq?=
 =?utf-8?B?eXdQa0JQSUFwd0ZwVUtOMm1VRXJxNGVwQlhyZ2E3VUFzNHhzT1dMdVlVNzRU?=
 =?utf-8?B?WUN2MjB1d1dhbHNKeFczSnBDdnFqSENFOUNEWE5IVWFLS2ZYbm41T2kwYUlx?=
 =?utf-8?B?TVQvQTNmbm44QzdiYjZ2R01VeVZYZnM1MjcxRDNDSThaVkNQZnVkK0lPWGhJ?=
 =?utf-8?B?bFNkbmlSMFZKUGlUdlVkVEJ6Yk9wblNCU2R3dE1kOFlsMDRjc0VDZ1ZZclVR?=
 =?utf-8?B?UEo0RmdBdXNmWkhuSkQvUUdteXFJdWw5Y2E5T2hQOVIzcjhhdWd5ZWFrNEIw?=
 =?utf-8?B?QzdzM2hWOUlxUWFrVUdnUVlTd1Z0cGJDNjJvY016TFlmeFJrVWVFWGhZdjBH?=
 =?utf-8?B?VXRuYVhNbWxpZG85cy9xc0VWSXdXNFU1NFhDU3AyZkpTN04rdHhWQ0RPRlF4?=
 =?utf-8?B?V04xd0FFSS90alAzUTY3aG9MekV3Zy9DWnVSZld2TFgxVnhic1Fpdm9SUVVN?=
 =?utf-8?B?cUVMUEx5S2NLcHdUYjViRkwwNkdjc2hoSUxWUVQ2L0Y3T1UzQjRVWXg3Zjlp?=
 =?utf-8?B?L1EyYUgwQy8vOXc2a3JDLzFETWZ5NTFBWGtZMFBhaGF6TjRPOFlKY3VYOTFV?=
 =?utf-8?B?NzUrM0NjOExSZW5rTGtCVEhQb3dCemVsbUgrTUIxS0xBMXlxaTZ3N0cvc1pD?=
 =?utf-8?B?NTI3RFZURmhXaGhiZ3l1T1BQSURVb1Z5ZjBSSTdKT0l1cHhoTmFuZU12aDdJ?=
 =?utf-8?B?U2NpdGNJaURJaGozTnhHZ0h6cHdJSTBIT1pIOWZqUlVOYks0UXQxT3ZGU2lG?=
 =?utf-8?B?U1VadjhYQWRFb3JFV0czdGZpUzkwNHIwS0FDR096Tm5XMjFoVkQrRWVGd2Q3?=
 =?utf-8?Q?hPoC+PFpRvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UURrdjFpN2x4aXFkL2tZc01UUVVqOFZtcU5jUTlsUldYSDJMUGNWdVhmNWEx?=
 =?utf-8?B?Qm4ramdhcndrQitMdUQ1Sy8vbFZvT0hnaGtqN3ZYNzlVWjlNRTZKM2dFOXky?=
 =?utf-8?B?RW9pTXM4RVN0bENPZUFlSUtoZHp2WDFRWjVsOVcwQWR2V3pGNDBndlhKaXJD?=
 =?utf-8?B?TXB0VEFSekJZaTgyLzMvNTN2YjQxWXZqZFUwRnVXYzZOUVZZWnBURmNqYnRT?=
 =?utf-8?B?MStseHQySURMNVhGa3RCditnY25PWkMxZit4emYwSmY4d3MxS3FxaENjRDZG?=
 =?utf-8?B?OTIzUVRIQ0o1YndaUUhGcHBZU2JFUFd3TXFqcTJaRUhKR05jeUV3cTJTOHdM?=
 =?utf-8?B?RXlxcG1QU1V5MkxCenF0V0lsQXFFVHl4U0huQzRUdE1OSHRFYUhMU1UwV1RJ?=
 =?utf-8?B?MHlFblFsL2EzdUdGeFVNc2tCeHBZbDc2NUJSSWZnOGdTSmtLck40dDRPcWlB?=
 =?utf-8?B?WUtNa3NORFp1Y0IwZk4xcnpFU0MwdkNkUDhjZWFOZ0tscyt3YmNFNTYxZk9V?=
 =?utf-8?B?T2J2UDFrZ3BmSGFwbkhhdFlsRXF0Zlg4UGg1U3JNeU1mZWZOL0xaRzZuSWdq?=
 =?utf-8?B?UEpKbnd5b3VNRWYyVlpmbGJGd3hPZkJDdUtWK201WnhpOGxQSm9rUXRDUUJH?=
 =?utf-8?B?MVBLd3pFMUVFRUZGNGpRYWQzZ0pNRmV1TnE5bllmbWJ5WEl3ejFaR2dyaWNi?=
 =?utf-8?B?MTFDMXZpTFJ2K2N0cWdHUHgrZU11TU9IWFY2Z0V0WGtwek8yRXBYMTNJcGhl?=
 =?utf-8?B?elF6UU9nbUcwT1REbDFSS0YyaldtNXUrekh2OVJhdERHVHQyOVVHcDk3akdQ?=
 =?utf-8?B?VzFPWXRGNmpTRVBtNWxZREdvNC9rNlp5eENRZHp3NFdkSGREVDU1VlJLRXFN?=
 =?utf-8?B?RVJvY1JoTFpQbUNJejluNmRVRERkU1VWNFhjL0VqdldtMmxGT3E4YStQcEVT?=
 =?utf-8?B?UUl0enE5QUs1UkVjVi92QWxGSkpOQUx1a3d1WlkyTHhCaklGQlZkRDJPbFFx?=
 =?utf-8?B?MzBjYlREMDV0UFI1elBaMmozQzlYdjFLMXVkdmlPMWlvdGRhWUVOblp0dGdR?=
 =?utf-8?B?ak9aNDBTcCtCbENsODBPTm4zNnBTZnlObUtad1doTGRJaTMxdHMxUHFZUnlM?=
 =?utf-8?B?WWdjVENaYWtDb3ZOTFB5aHdaeXVCdFhEY2pXNjN0dnBRSDhjQncyZC8rS0dB?=
 =?utf-8?B?UVREY2EzcURWbEpDWS94K3RGOFJQQWttME1hUHgxLzRxWndmWlhaQ3ZwSzBV?=
 =?utf-8?B?dVU2L0drNTRGSDNMN2orbDdxZmpVNGU4eUg1OHA0TWxsSk5LaE5hTks0TlpV?=
 =?utf-8?B?dmlNUVBYZnNKVzYwVnpZRHpIbkJJaGJ6RFhWTHpjR0xwVHFZcFZWY3pYU21U?=
 =?utf-8?B?R3BOU0pxakRsUGtrb1ZMQW8xbGdZdVhiSkdsdFo1Mk1obzlJeWIwSC9OWGkr?=
 =?utf-8?B?clFnb2F0a2FxZmo2NldlNjBocXpkeURjS1hjODB2RkJHOUovMWpxRDVXN3BY?=
 =?utf-8?B?S2lueEFXeXBhRUdKekFtYUozN0lucWJYVDYySlJNVGNwUXJaRWlIamFtc1E1?=
 =?utf-8?B?Z3lORkRJOGZIcllxZTdNdWNYUXV3NWRzQnRoN0lEeExMTUxFZmxiM0hxQkpt?=
 =?utf-8?B?TktCVFVzSXZDdDRaQnhpN2RNY0V2czdlK1Rsa3RTYWR6YjVzQWVHSE5zbUpB?=
 =?utf-8?B?QVJVanE4a0w2UExYUUd4eDdpeEFRaFBwanBINlNlY0JVWEJUSHM5R1ZwOUVt?=
 =?utf-8?B?TVV6V1E4VzA0LzMrTENWeE5jek5DT2lubDl1dUIya3VSQmNvQmpobXJXYlBt?=
 =?utf-8?B?SG1jWDV4a1N6a1NJa3pVNWRZcFQ1T2NWcHhiRTNaWGREM1JYb0lxeWx1QUZQ?=
 =?utf-8?B?WTVPRDB3NHN5aEM4QXlZc1Z2OFdHcE1jcGFHcU1Ob2tsejI1RWFHNTQwdkxD?=
 =?utf-8?B?OGtreU53RldTT3ltNmlGN2lGbnQrR0Z4U3hjdGxJR3dJbmVMWDMzM2syM0p4?=
 =?utf-8?B?UjFmRVplaU0zVGxTNUZiN20zZjhhcEFwRkp0bUkwVTI1c0U5YlJOUW9MSE9T?=
 =?utf-8?B?TS9RSnM0aFNyc2s1b1FUdG1TN1c2dzZNcFFDM0xqL3lmN0N4NExRakduT3VF?=
 =?utf-8?B?SjhxOHF5dGMyU0d4SlphNzdZeitaV0pLamhvVndBdndMZThYbHJJbVM3QVpF?=
 =?utf-8?Q?c6fHAS30QBquCedIbMlZ0BsPDHiemHY/7PvYkdFAT1fZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd02c2-37b2-4ade-4f50-08dd83747934
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:10:43.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+gKzco03pq1usI4eh1+xBh8mehSTS7GC6nAdSB7b+fYeZXWwKEmuTtL7drESAn0jpcBn40yDOhqu419J6BVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

On 23/04/2025 12:24, Ming Lei wrote:
> Hello Jens,
> 
> The 2 patches try to fix race between between io_uring_cmd_complete_in_task
> and ublk_cancel_cmd, please don't apply until Jared verifies them.
> 
> Jared, please test and see if the two can fix your crash issue on v6.15-rc3.
> 
> If you can't reproduce it on v6.15-rc3, please backport them to v6.14, and I
> can help the backport if you need.
> 
> Thanks,
> Ming
> 
> Ming Lei (2):
>   ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
>   ublk: fix race between io_uring_cmd_complete_in_task and
>     ublk_cancel_cmd
> 
>  drivers/block/ublk_drv.c | 51 ++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 

Hi Ming,

It's a solid fix. I ran it through our automation and it passed 300 iterations without an issue. Previously we were getting crash after less than 20.

I also back-ported the patches to 6.14 and it works there too.

Will these fixes make it into 6.15? Or only 6.16?

Also is there a 6.14 maintenance branch that could also be fixed or is it end-of-life already?

Thanks for the help on this.

Regards,

Jared.
