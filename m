Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95A374FB
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918040; cv=fail; b=Flbw8LyS/8dC+MqyjqSKaI8NsgahbHAI6fhouC4UIIwAloTigUMx7Nm8Hkvqti66QOQ9Wj/qRNfiKx5nFtm5qvlyd0/MW/unwa8zSy/I7+riQqZFa5vah1TprU8YrN0DltUUBQiXoIr0heZTctX/VcwjxQCUlIiV/xxnoZ+4h44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918040; c=relaxed/simple;
	bh=ClmCSO6lPZmem/FHSVc/kS+ZTB+HTw9mRrd0G+N0Ot8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e5Aej1XTw43IYZvEvEtETA4I5RVho4918KnecJCTsN7DTebCHgfNuzWX1bt/jI7gBt6tIBhHZ5NPsKGIHx4XJA46TPiAdJWGLL06B5JSU6CPA3MKFoJsUyVS3IJZrJfISrnp+7vNufSHlKwnuDa+LXFIjuEDJTc+VJtZkVnmKXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGSb9k9f; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bGSb9k9f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdMzHFc58o9o+o2S1Blh6N2kg0W2vt9xM+DauhwxHC41Z4kTq9Y/CApSYIK3+t7lSdgEsjPu+2SyKksSjEMA5VbFOyTL32MamcW5T1L9TYJz27cxpKQcw5M6qpXsfqqvLZiQEllQqHpeXqKYAv1XPXjHJrQm7f/iGyttgEwRW/dxDLaA7WpT7pVdWideXtHSR2SdrSApTNKlAXrWprPjjr4ouuRs7hM0hcWefeqOAArKcxsji4uKSVHxnQ7hrBoMSCWVZrSfiJiBU9ZdYgkGW8/OQWXbbo+xvnlUD+rQKVqk1FWJnvaJkuowzy6aQenKqvmZQVu5/+QSq8rnpDWb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq6JFGjMn79MA8jYqvr7oIIns0hr2rZvhQpGFgz67x0=;
 b=c0XnIlc6OlocccYlwUJok/OMn/xz3jsSD5fWbvEToP/SoZ9YvPvAzvyVcWFfD3K/Ir5a1Ro5tdDWbsI5ktWcbA5WooeKXOQI5CJ6HYDvdtDdR/MjgY6ECA75fmsFn6NnjaR5iDM3yPVIesdIY7pe3885B/UK2TYEncdoXxf1P5p4GfdmaOae8K/NNtMYYY8MpKXTCIYxlP2UeGwUMUoG5D2jCdgLBC/xmzcQTQYGi7o/4jp/zjUTISx25UW+nfxVsLWKdTrLT5PQeaPG5QJzrOQfhk/EH3GHXHgCKU/Q1TliEoY2R2BEBJ7RhIhIultYYT4Z+KefAxv/pTkqWlQcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq6JFGjMn79MA8jYqvr7oIIns0hr2rZvhQpGFgz67x0=;
 b=bGSb9k9fz+Qhnwv6DALr6dr92krLRddGZSFwtJ12+PvS78R3G35kV/NSjL7NsbbPJ3oAr8vNNrPW92wNy9k4goi4EombRW3rByi2uFWxl6rqnVJHM6zTjAWDtaSWS1/I+OP3q1hN4ioPoHVbeh/f8KufRKA+VYKBFtfR2g5O5ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Tue, 28 May 2024 17:40:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 17:40:35 +0000
Message-ID: <80ceceba-ac9c-4ab7-a0e3-bdb9336a86e6@amd.com>
Date: Tue, 28 May 2024 23:10:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
From: Vasant Hegde <vasant.hegde@amd.com>
To: Joerg Roedel <joro@8bytes.org>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, iommu@lists.linux.dev,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 suravee.suthikulpanit@amd.com
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
 <ZlVk95sNtdkzZ8bE@8bytes.org> <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com>
Content-Language: en-US
In-Reply-To: <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce26597-3e81-4211-c181-08dc7f3d47d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVFBZVE5eCt5bnN4MFpmbHNLS21ucEZ0bnJHeUo1SncrTkY1aTI2cFd4bHJ1?=
 =?utf-8?B?V2h6cWxkRlZlTjl2M2hGWi93WXllU3Y1eStTalBVYmtCOWJsMXhEL3d3SW9W?=
 =?utf-8?B?Y252ejM5dnJVNVNkOFB6SW9xNXUvckVwKzhrWXA4c1g3TVVDREE0K1ladWZs?=
 =?utf-8?B?NU1VL0Fxd3VYc2tjODRyUWQxb3pDaGE1OFFOOE8rT1lld0xhSzgvOXhPY1da?=
 =?utf-8?B?R0lRcHBEYlN5SGFEekROUm55Q21JaFpmam92QnZuRHpGWllCVUd3cnZqeCs5?=
 =?utf-8?B?em53QmFhWDBuSjNONlVENWo0V2pnd3EvU1JBZkVhdnFMbXpUMWJzVVJkNEZx?=
 =?utf-8?B?OXMyS212Wi9xa2lVczNVdE50WnJzdUZqK2FLQXMvRDl2cnJlYk12bHVBUGla?=
 =?utf-8?B?VURDUWV4K1ViQ29JWll5T3ZmMUJwbmNtdG5aQ1dxbEZXRnB1alhaUWF2b1Fj?=
 =?utf-8?B?aldTa1RRaStvcjMrUndzVENqaVBQdU1SU21rbDZGQXNnd2RocGZSRHhVMDh2?=
 =?utf-8?B?NW11ZWhtbG9Hak9LMXFvcVFoa1c0aEhaWU0vdUVMdDlzYmxWT3h5SGhzZXFW?=
 =?utf-8?B?eVhIT0RyL29PbzQzb25WK0lCOW5WdnEzdVBaMGVtWUFKRXd5YkJ6VWxEMGNp?=
 =?utf-8?B?WmNoSUZrbkUzalIxdXMvWWk0Z0RTYTRjNkFnOGxmczNFSktPamRaY1krMlJo?=
 =?utf-8?B?d1doVnljMnNpWVUxcVJlK3MxM2NqUGkxRExRM0pQVkcyWWxjMFpYN1FVUE5F?=
 =?utf-8?B?dkprYW4xMndYNlV3QmxvN2ZBa09GZDBQa1BCOUZUM29ESk9NUm9uckJaK0w5?=
 =?utf-8?B?NmE2NEIzako3VmJkd0ZUSVdFSEJpdkxJZEVrdFlVUHlrK0FYZTVoSkdBVUVJ?=
 =?utf-8?B?aXZJQVB0UFIwcDQyQW52ck9tMkxseVVHQVNtV3RlSGh6WFJvODZjME1HTWxX?=
 =?utf-8?B?S2hselduUG9vY1ZlaXI4WkRkZlg4S09UQUQzU0tDcGh0SmozM1o5Wm9FKzVV?=
 =?utf-8?B?WnNlWHFrNk51MnhjellOM1VRTXBFNmsrckVyOVh6L0t2YlZqaGF2V3dZeTlI?=
 =?utf-8?B?Rlo1d3NYL2FPRXlRN2RETS9nV2FsaldrS1ZCemJOQ2Z5LzJKTHNuQTFIU0NP?=
 =?utf-8?B?MlpLTnZzWlRaTFZJS1ExV3JRQ0hqOFM3RlBFKzNDTEFXWTZJUVYybG9sR2Js?=
 =?utf-8?B?QzRDRTBiSzJmYUJ0TzBabjIxOEVmRmk0cnUvRGxvTXgycFJsWW9lTGxGQlZV?=
 =?utf-8?B?NEZzTVVXL2dQOHA0aCt0cFh6bVY1bm5XdS9SMm5SRHQ5LzB6ZEIxMUZqdGY5?=
 =?utf-8?B?S1plbkRHUThHQTFyRGY0UnZYc0RtRFVPZzRpZHJNdWtIRW9sbGhDK0c2YWl3?=
 =?utf-8?B?WGtSYmJ4bVJPaTVwaTRTRkpDVFllUnNtTmp1ZlBpSkhmQzhNdTFtaGwrVTRO?=
 =?utf-8?B?K1Jzc2dTNEk3YjhibzZlRjJwcXprVFNDYmpMTmpQUmhWVHpMQTJDRndnZHVi?=
 =?utf-8?B?VWFzeGRORzB2VFliQXBMUlZBUW9pRXZHZ0ltQ3J2dnBnUjU5cmtvRXM4VG9u?=
 =?utf-8?B?OWZyOHRjYWJ1UldSQVZ2Wm5VNkJYNFhEV29DVHZNNVVCU0NQTFFHVTJqODBI?=
 =?utf-8?B?dVdtamoyOVE0Y3g4dGQvVmptTHYycVB1aVozb0RCMkJ1NnkvL0lSNmFQYnFh?=
 =?utf-8?B?eUkyOVk0RlRWZXQvRkFFaHdFNXg0MllzbUYwWnZQblFKN05rbGYvb1lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1Y4K1hNV3N3eHN4Z3k0Z2tOTmI5UzRGQ0lVTHBUdUZRSDFHL01qWHNWTlBC?=
 =?utf-8?B?NU1jcEJXQjhHNVhoRnV2MTc4NmZSRyt5eFg2V3NRVjRxSkRaMGpESG1oT2Jn?=
 =?utf-8?B?eXRZK2dJUXNzcytPbi9ZQk9YSDhLbGdidEcxcTB0aUlRUXRRdnZreXoyenJ6?=
 =?utf-8?B?NFBrYkFQSHJuWjhwUXVjK2RKWTB5L1BnUzVBMkpIOUo1K0xud1ZMZzNFYXpV?=
 =?utf-8?B?cXBnZjJqQ0NIcWJFUlhzb0x4cjRTYjkzaDlQT1BhbXFmdVdBa1RkMDBtRG5W?=
 =?utf-8?B?UUhxZWhRZkVWellSN0hnT01XZFBFUmNvT2Njenk1eTJpekZOeDdPK0h6Q2tS?=
 =?utf-8?B?Q2R0VFRUVnozUldMajdob0NYUmNNL1Fab0xRbGJHTFdPemRmQzJpMzhkdVZw?=
 =?utf-8?B?SW9RZ0lZN0ZuSmJHVlp6Nm5RYjlxaS9UUitVaDhNdjZMd3F5MDQxNC82WGdQ?=
 =?utf-8?B?V2JIcHB2eGp6c1pZc2N0NmtjeXRRL3JHUzY2UTNDeEF2Y0Jkb0plWEJmQ1Q1?=
 =?utf-8?B?ZHVObTk4YlA0NlcrQno0TGY2ckE3eXFueFJPdmNkWjJiWTl0S3V6cC9lWnlh?=
 =?utf-8?B?UmNrWmVmUkR6VDFua0NVYVpCdDZIbldZbzhyWTNvWUhkbHBaK0J1aUtCSS93?=
 =?utf-8?B?dHZTSUIvR2p5ek9oQ0NuTnp4RjB3dTBGa0JtTDB0Y2VkWXBZWkNwMExmS0wv?=
 =?utf-8?B?eUVoTUtvT0VnVmFPRm9IejYzVWV4ZG9NWHBzam5xMTQ5ZHlvcCtMWllKR1Ji?=
 =?utf-8?B?elJDNlVXRldZMGRlOGFhalpvSnZxSE5ZNFo5TmlLUkJhSTRoTjZJSDIxMHJO?=
 =?utf-8?B?V29uRTRoRlMwSWs2QWFtMmxvTG9TN0dkbEtkZndidGcxNWNzOCtxK1dXTG1G?=
 =?utf-8?B?NnRkc254SGU4cGpGcXk2T2RmSklJcGE2N1N1czhzZ2hkMmJQWkRZcm1LWGZz?=
 =?utf-8?B?aG0rYTFDaFhUL1RHSSsvN3FBSFZsTjVHMDBkaUc4R1Q2cFVNZTNhd1pTc0x1?=
 =?utf-8?B?MG56Qno0NnpOclhHR0llaWN3Ymt3T09zTERaZ1ZDYk9GaUt3bGdNTnlqWlUr?=
 =?utf-8?B?Z0xJWUNvckZPTHAwelhXN05mME45bXBpamxoUnpEQzZvblo2VFpJUWpnU3VI?=
 =?utf-8?B?TW0yNjlrNXE1VkJNeVhqM0Z0VlRNUm03d0Vud1hDUkcyVDduclRWTG1hTVRp?=
 =?utf-8?B?cG1xdkhCcUVCODFWVW82SmtsaTN2TERLMWVhNThENHM5SU5Va01qUVhRdEZC?=
 =?utf-8?B?aUp2L0E3eU9rSW9UQ2JqdFdCSFlkQWE3S1B1WHJJT09aMDJWcGh0TmZiSE54?=
 =?utf-8?B?Y0VpRnZaSkVrbHFxUXAwNHB6SjRlR08zMzhVcmtDOWtzU2h2MlVTRTJhMHJq?=
 =?utf-8?B?UFp4T2dTUWtmN1F0VTB6QWw4TDVUa2E1c1liUHpUdjlROVZlRkl0ZU5qY0RF?=
 =?utf-8?B?U25kY1B5MXg0Y1IzYVl4Uzdxa1pVVXZBZm1DUGxBeko2YmJoYVZoVjFKUzZt?=
 =?utf-8?B?cHl2UWZrS0hiNVNYL0ZxbGMwdVpzS1BSd2JrMnhVRDNFeEJyUkJjTWtQTHBO?=
 =?utf-8?B?SmtudHZYK3dwOHAyQm9tSkdnRW53MGg0eTVsV1J5dm8wRjZRWXJwUmMxSG1h?=
 =?utf-8?B?WW5BbDM1Y2FmSDg4eWdKQXMxQkQzMVZyYVVNU0ZaNWhXNmlITy9sS1ZxNDFr?=
 =?utf-8?B?YjJIUkdoVzVLYkFQekRnZzUvYU9TTU5iMk5wejZIbmJUcmozMmszNUphZWh1?=
 =?utf-8?B?cVVNYmRDdmREdVkzcFhQdzFRSFl0YzlzWEVRVmhQY1ZwRUEzZXBsQkEyYjRW?=
 =?utf-8?B?U09WVk10VHhXcXdNT0RHL0dvZi9hUnBKWDZuK3E0WExyZnFTMmhxQ1NvSUZN?=
 =?utf-8?B?eUxianNEOWRkaDIzZERWM2VoVTlpTWd3S3dISm9SVTRhVUF3bElON2ZWdy9q?=
 =?utf-8?B?ZXQ2SWFBRG5FckNGOGpRRk9RRDREVWlNU3dmdjNFSnhRMWJVb3RjcllscGZ5?=
 =?utf-8?B?QjNRelJvaW1SQlFqUnBneU1ZUDFqRjROWlRaTlQwYkdOS3pRR29wWGloalEz?=
 =?utf-8?B?bEk0L3p5SVRZaVBVSXhnaTBDdjFaTnlHMXJvblh3eUV1M0xGTGxJTXppekND?=
 =?utf-8?Q?EjZv1rZpZ84uDewC6E0wiAvdF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce26597-3e81-4211-c181-08dc7f3d47d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:40:35.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSItW1yt2s1C+44igsmcTe2yUhaqW84Ux4gMAmEdGYQ1nipnbA3u93EwHxCGyj+28EnxcMhngfCUlwY/Z081bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201

Hi Yi,


On 5/28/2024 11:00 PM, Vasant Hegde wrote:
> Hi Yi,
> 
> 
> On 5/28/2024 10:30 AM, Joerg Roedel wrote:
>> Adding Vasant.
>>
>> On Tue, May 28, 2024 at 10:23:10AM +0800, Yi Zhang wrote:
>>> Hello
>>> I found this regression panic issue on the latest 6.10-rc1 and it
>>> cannot be reproduced on 6.9, please help check and let me know if you
>>> need any info/testing for it, thanks.
> 
> I have tried to reproduce this issue on my system. So far I am not able to
> reproduce it.
> 
> Will you be able to bisect the kernel?

I see that below patch touched this code path. Can you revert below patch and
test it again?

commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
Author: Dimitri Sivanich <sivanich@hpe.com>
Date:   Wed Apr 24 15:16:29 2024 +0800

    iommu/vt-d: Allocate DMAR fault interrupts locally

-Vasant

> 
>>>
>>> reproducer
>>> # cat config
>>> TEST_DEVS=(/dev/nvme0n1 /dev/nvme1n1)
>>> # ./check block/008
>>> block/008 => nvme0n1 (do IO while hotplugging CPUs)
>>>     read iops  131813   ...
>>>     runtime    32.097s  ...
>>>
>>> [  973.823246] run blktests block/008 at 2024-05-27 22:11:38
>>> [  977.485983] kernel tried to execute NX-protected page - exploit
>>> attempt? (uid: 0)
>>> [  977.493463] BUG: unable to handle page fault for address: ffffffffb3d5e310
>>> [  977.500334] #PF: supervisor instruction fetch in kernel mode
>>> [  977.505992] #PF: error_code(0x0011) - permissions violation
>>> [  977.511567] PGD 719225067 P4D 719225067 PUD 719226063 PMD 71a5ff063
>>> PTE 8000000719d5e163
>>> [  977.519662] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
>>> [  977.524541] CPU: 4 PID: 42 Comm: cpuhp/4 Not tainted
>>> 6.10.0-0.rc1.17.eln136.x86_64 #1
>>> [  977.532366] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
>>> 2.13.3 09/12/2023
>>> [  977.540017] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
> 
> amd_iommu_enable_faulting() just returns zero.
> 
> -Vasant
> 
> 
>>> [  977.545329] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
>>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
>>> 00 00
>>> [  977.564076] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
>>> [  977.569301] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
>>> [  977.576433] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
>>> [  977.583567] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
>>> [  977.590698] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
>>> [  977.597833] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
>>> [  977.604963] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
>>> knlGS:0000000000000000
>>> [  977.613050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  977.618795] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
>>> [  977.625927] Call Trace:
>>> [  977.628376]  <TASK>
>>> [  977.630480]  ? srso_return_thunk+0x5/0x5f
>>> [  977.634491]  ? show_trace_log_lvl+0x255/0x2f0
>>> [  977.638851]  ? show_trace_log_lvl+0x255/0x2f0
>>> [  977.643213]  ? cpuhp_invoke_callback+0x122/0x410
>>> [  977.647830]  ? __die_body.cold+0x8/0x12
>>> [  977.651669]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>> [  977.656979]  ? page_fault_oops+0x146/0x160
>>> [  977.661080]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>> [  977.666392]  ? exc_page_fault+0x152/0x160
>>> [  977.670405]  ? asm_exc_page_fault+0x26/0x30
>>> [  977.674590]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>> [  977.679905]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>> [  977.685215]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>> [  977.690527]  cpuhp_invoke_callback+0x122/0x410
>>> [  977.694977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>>> [  977.699593]  cpuhp_thread_fun+0x98/0x140
>>> [  977.703521]  smpboot_thread_fn+0xdd/0x1d0
>>> [  977.707533]  kthread+0xd2/0x100
>>> [  977.710677]  ? __pfx_kthread+0x10/0x10
>>> [  977.714431]  ret_from_fork+0x34/0x50
>>> [  977.718009]  ? __pfx_kthread+0x10/0x10
>>> [  977.721763]  ret_from_fork_asm+0x1a/0x30
>>> [  977.725692]  </TASK>
>>> [  977.727879] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
>>> dns_resolver nfs lockd grace netfs sunrpc vfat fat dm_multipath
>>> ipmi_ssif amd_atl intel_rapl_msr intel_rapl_common amd64_edac
>>> edac_mce_amd dell_wmi sparse_keymap rfkill video kvm_amd dcdbas kvm
>>> dell_smbios dell_wmi_descriptor wmi_bmof rapl mgag200 pcspkr
>>> acpi_cpufreq i2c_algo_bit acpi_power_meter ptdma k10temp i2c_piix4
>>> ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs sd_mod sg ahci
>>> crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel mpt3sas
>>> ghash_clmulni_intel libata nvme_core tg3 ccp nvme_auth raid_class
>>> t10_pi scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash
>>> dm_log dm_mod
>>> [  977.786224] CR2: ffffffffb3d5e310
>>> [  977.789544] ---[ end trace 0000000000000000 ]---
>>> [  977.883220] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
>>> [  977.888532] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
>>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
>>> 00 00
>>> [  977.907277] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
>>> [  977.912503] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
>>> [  977.919633] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
>>> [  977.926767] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
>>> [  977.933900] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
>>> [  977.941030] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
>>> [  977.948163] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
>>> knlGS:0000000000000000
>>> [  977.956251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  977.961995] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
>>> [  977.969129] Kernel panic - not syncing: Fatal exception
>>> [  977.974439] Kernel Offset: 0x30400000 from 0xffffffff81000000
>>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>> [  978.087528] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>
>>> -- 
>>> Best Regards,
>>>   Yi Zhang
>>>
