Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5152848A1;
	Tue,  7 Jul 2026 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410489; cv=fail; b=hpxwTq6TJKjjOtK3vjiNy4y3pzvF9KXyUbryETSqFnh0EsWCbirIaBC5N0AJ6KNcMXgLj8v9r2CCqVn4EGM2uN74j0TYFIBr+Cv8BNFKg8LZsVoNXq8v0pV0PyXLGKqPHqOGbNrqevXVzaqFIm4zGG/I4JdCTT0I1VrRa1+T/BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410489; c=relaxed/simple;
	bh=662F2wfP9PKVbwvQuFp5f8VzX8793OFlTFknhKRtd/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUtv/cikYav9n+CBydst863YJCM265GIldw3xl3TXqaIyX+Althkyw4xoaqUjhy9K7IWr+Zj4yJNPl7Js/RdxQWBD0qaQSMXZeHvNk5/6rATGK6vZVRLtrgoGKyxuGBzCSMCbp8hOnD2719+v9yNxc8+Om52FIy8NBoi12l5G+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=HtQpoDCC; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="HtQpoDCC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/27Gq3wTdpePlpHPohVGSLvzKI3HTY1f2H3yeMOFZnkLJ5GeAWCQ6MA1iv42dK1ioG1oQt5WXyP+I8awaNhjzmjTrso/uUrHz3bCRBuLOt6504l/36xRazNPi1ZI5FkJBbpe/ECcUqc7dXDLohHP+RshHhnAIHgIp6JXxJzIKgAaSOpIGOePVEO27e8CSvyYSO7WZh6T0cVUWEp4ZECI43A6iZDv9GJ7ESuPZ38XrmnW+tYYQPh+vWt1xYf6EJZ228wrnl3eca8jPPFljhyjF/CWOZxB04CR4ve0zduOpAz1U5NYqFunKN1gLvfXCLRepnBTGCzWrDES/OjwOqEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9klClZThwOFWr8Eq1f2cJVfOPhQAKdEE9+HWrji7yI=;
 b=Iqn0Z4OAMLysIlh0Ck4U//DUEqgTRD1QL3T4DdYDfZY6PIwwjKbc8Tczy2xI4b5f0cvU3Bl7EHTiR051+Qnz/eStmD1W534SJwLCtMu+SYq/EgkG7LLhZ29tIKjKcCB8ZBoCUh3M9kOlhOqtQykvGHCdWlR9wHGUxMXkBJvBqH++xth3u7Bx/1lH1xlwOyhPpGlfp+Nb610IsRqoIZL01HqtPiFUGL/4uL1xXU4mfbNcAZoz4181bjY23IlaOulgoBrewMOU0NW6k4r1y3vB5GmFqO1h78CDeKU20ovY15fvbdvMc2mPPAgbjtdT81SdjUKN6QzGyUrLakQOAp5pRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9klClZThwOFWr8Eq1f2cJVfOPhQAKdEE9+HWrji7yI=;
 b=HtQpoDCCf5CPpLmdisfVbuCoH0xdKmNNYj9WIAmx++SyjigucAB9DphQlROHgWIZWsAcSy6uUxL/2ShXT75i7CsUPzHO1VFmasv3tAUaSj+PyLV9rpWGy8nmLVRb7F7vRkXi7R2gvtvsVGzmAoGFppJCBcpRSFu6lXrY8SVN6Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH7PR03MB7860.namprd03.prod.outlook.com (2603:10b6:610:24e::14)
 by SA2PR03MB5771.namprd03.prod.outlook.com (2603:10b6:806:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 07:48:05 +0000
Received: from CH7PR03MB7860.namprd03.prod.outlook.com
 ([fe80::f5ba:35df:1c9f:b343]) by CH7PR03MB7860.namprd03.prod.outlook.com
 ([fe80::f5ba:35df:1c9f:b343%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 07:48:05 +0000
Date: Tue, 7 Jul 2026 09:48:02 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-blkfront: fix double completion of split requests on
 resume
Message-ID: <akyvMpT0fBT5EDME@macbook.local>
References: <20260705115639.72805-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705115639.72805-1-doruk@0sec.ai>
X-ClientProxiedBy: BN1PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:408:e0::31) To CH7PR03MB7860.namprd03.prod.outlook.com
 (2603:10b6:610:24e::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PR03MB7860:EE_|SA2PR03MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9b05b3-6502-47a9-dcea-08dedbfc142b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	H7d3jbU+9wzVWfvTDFwVBphO8Hd0j/vam5Q6Ggzvw3A5pNuVyoyYGT3pqY1xyjktgQRs006l074VxqzyfoQSUB4qNccoTOOFAh9p/bNeKd00FfVxbezTy9UcuGsB1kMZFhVlG6YsJ0yDo67VxlFBFOAVgEkb8z3UH8qUic0q6g5oNMZiVKyZtGh5jR+A14tDzPD4O5QriLJJ82p5md+AO0p+9uiWEPlcUySzjN5F/9KalTBFT0ZhN7CPvJ88FjBwirTnP4AtAGec9uTXG5eJpQo4Q4nNhW5f6IpQCoITRV47nOtCaWyxQlWUhjepSZfpQGlrJqiDuTn0A8pKjpnYrtbSJdqV4TN8pkMkk+po4OTkLpNQNrwz3653VPjHe0QGhewxTdZ9xn0nA//E7wT4326iH2rudKbIkuzL7QkJeY4MD6qLZsAJEg0e/hv+HW/lEoGQzwF9kCVaslDMwOYJtKUrMqmYDedMiaMo8+6lEJ0ZzufFYvKFVH+k7wt6/xmwFay5X0d/eY/W2uaWjHB4jnscS2/IbzW5bjZpZg6WyPri1I39cAfWH79pfrN4x+zVeukMht32reA6LDZAw0VvwUzVFXZ1FuiaLGwklaVCqAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH7PR03MB7860.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3YwYitQdGJOM1Rob0NXODJQazErNGhkKzU1c00xOUFwM2piYlRwZXF1N3Zw?=
 =?utf-8?B?YUp6bUM3SE5CekNQUzZxMGZORE0vV2FWODViamJpeUFOWTN4WXlYaFVEVUoy?=
 =?utf-8?B?cFVNbEtRTGFiOVRKbGtlUHdUTFc5KzdVaUpobzJwdld5Q0ZxTG93Zkc1RlJP?=
 =?utf-8?B?Z3luSis0TThSUGxyOFkvc3NjNzNiVFg3cGF1MUV1cFlGc0p2VVI3WWg4ZWYr?=
 =?utf-8?B?MS9GRWFJZ3FZRkNPQTNHQ3ZZQXhUU1REMExrL1JLTmJjYVF3ZHRUbWl4N042?=
 =?utf-8?B?aC9UK3hpNWF2ZUxpbEZaTkdsQzVGWlBwYlVXdElUa2tJMmdjaTVNVjJUeVpJ?=
 =?utf-8?B?eXNjeGJjSlA4aHZYQ0tiNmpnSU1LYSs3MTVST0NVUWxzRVBNeWNJR1NRQk9B?=
 =?utf-8?B?RGhyQkxGZk0xa3lIbnJtemczdDlrTzZkamhnZTlGOHdsMDlhdFV2ZHB1QXFF?=
 =?utf-8?B?YUhkUVBiN0FmWFFPUEY3WTJsOHYzRVVneU0xRlorV21pbHBiZXR4aWw2ZlNs?=
 =?utf-8?B?dXNpM1BabnVQSUE0WmllVXp4WWVVWTJ3WG1mQ0FzV3dMUVhjTmdiazlhQmky?=
 =?utf-8?B?R0NXZXZSZ3BzTm94YW9GMUdlY0sxNHlvRjQ0MWkwZ0N0ZC9SL1NUN1FLQ013?=
 =?utf-8?B?Zi94RjBwbTFjc3kxU3hUY1Vzd2dKdUkwVEFwOExRcG5yN0Y2NjMwNGpiZEVq?=
 =?utf-8?B?VHYyUkhqZDFLZjNaY0U1TjlWalRvY0VLR1ErbzlORmxrWUhUeGZJWHpXaDkv?=
 =?utf-8?B?MDU2bEswZHZVYjZBUVc5d0hVS3E5d1NMK1dleFJvUWdGa1lSUTlQYjVyVVNP?=
 =?utf-8?B?dzJ1ZXFQVS9LR0pnS0hrNVVrZHBFVURRMXpBbDV6aUVlbUVVMEk3SWFkL0lm?=
 =?utf-8?B?aHMwNEtTc3NNM05uZjd3SnNrOElyK0hob3dXd0ZqcDkxVW92aWFGRmNHWHlT?=
 =?utf-8?B?NkN6RmpkQ0pCdnNLZUdvcWU5clJneUxMZEFFcTJ6NkRxMk1OVUdTVHQ3bDI5?=
 =?utf-8?B?MVBXTUcyS2dLN0ZEUUlnamFLL2xJR2xKWlF5dk1tOUFNeXJoVnN2ME9DZVJl?=
 =?utf-8?B?TEtjbm1sUjJRVUpNOUJ1Q3o4K25MK3Zxd0RCTUFNRVRMb1kzVkVzVWw3Nk5Y?=
 =?utf-8?B?MCs3VWtIL3ZKNFhkTmd1RTRYTm13eU9CaWpSelRKZklSVWFjRmV2UDBiTU1y?=
 =?utf-8?B?aDl6bkZTQTJQbk9LNlV6eTRQZ1lVMi9mUGczL1dKTjV2V1FpcERQbk5NVHgx?=
 =?utf-8?B?Lzh3Qy8raUZrbVUzNWlNbHhXb2FCOVpZUWZKUUpMKzBvZXJpZ0dNMVZzTlJu?=
 =?utf-8?B?cGg5U2htU21zLzJqTVZsUGtJa0tCaUN2YXp3bHNjcWN1TXRLdWpZaE01ZDNO?=
 =?utf-8?B?ZktGOFMvNm5zZ0V2N0YveDVnSnJLYllEcHQxNDdVM2VQY1JVQ2xPQVNTYzN0?=
 =?utf-8?B?dE5kYmJ6ZlpDTFR4L0RkOGh6emxZZkNtazZyUlRtcFZ2eGdwc1Nrb0Ruc3NS?=
 =?utf-8?B?Z21wc0pibGh2UG93aE4zZDhRV2Y1enQ4RFF0YkZ5NDZSYzBRSmhieFVtK1JC?=
 =?utf-8?B?VEowVmVSK2JIYmhJeHkxeDFMQnExTExIOHM2UUhOSFR2cUxEWUpoNGtCWjAz?=
 =?utf-8?B?c0VDanVPRnp2MjZmR2xoYU04K2pQbmRRVUtMVWdqbjJTZUF2RHRGeXNZR3hv?=
 =?utf-8?B?QmZaam9nWDAwWkJsUDlrWFN6K0YzRTNScXhzOWlBUHJ2bEVRQnV3MS9TRFBn?=
 =?utf-8?B?a1h5VzNFR2VFbWhkVHZMVWhROGFBSTlYeVFGU3hBSm5JWFdYS1YvOVM2R1NH?=
 =?utf-8?B?R3lsc0tZbFJVM1JHNjgyNUNkNG5za2pYZllUb2o3K1ZaVytOdUxsYjRRdzBu?=
 =?utf-8?B?Rk9rVk5mU1NXY0RGcXI2UmxtRHpSdlFnazFSV0JZcGp5bldQTk1MbDM4RUVa?=
 =?utf-8?B?NXN3OFZya0FqUjlrbVVaemRGSVNXMlhjWGxiOVFhSXZFVDQxVUJvODc1TzBL?=
 =?utf-8?B?UkRZTWFlbENPYy8zTkRBMEFyTERnMmZSK0xXYkhueDBhY1dIM3NzYjE4dmxP?=
 =?utf-8?B?SlZkd2FUMm9hNGliOGl3dTZNTHNhZzJqK1ZTQk5PdzJpVEpFeXp1K0JOdnBF?=
 =?utf-8?B?Q2ZYa2VqLzNPeTJKZUlQUEpNSzhGNEoyVDFvMHBKN3ZZQStON2FzYjNKS1JJ?=
 =?utf-8?B?Sm9ROEdpUmVuTTZNM0VqNmcza3hvc2JsbThpRlVyMDRrYnM2cVNNV0RzYVpN?=
 =?utf-8?B?KzY4YWE1cVpRSklPY05rN2RwblpJak1Ib3cyZ3lWM2F3QTRpdWxsOExKYzdj?=
 =?utf-8?B?by96cFl6cDQ0UUxPa09UUEN1Zm9ONjN1VnZyR2dwRVVTTGdIUVdSdz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b05b3-6502-47a9-dcea-08dedbfc142b
X-MS-Exchange-CrossTenant-AuthSource: CH7PR03MB7860.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:48:05.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXGZ1e1/nwuWdOdkT8PPwJfGfEBqVut+nheTaI/rvWNxrGyjv1XawuUpAHLqvOZwzV1uKRfWKgkkjmGqPlcS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5771

On Sun, Jul 05, 2026 at 01:56:39PM +0200, Doruk Tan Ozturk wrote:
> When a block request is too large for a single ring entry and the
> backend does not support indirect descriptors, blkfront splits it
> across two ring requests.  blkif_ring_get_request() is called twice
> and both shadow slots (shadow[id] and shadow[extra_id]) are made to
> point at the *same* struct request, linked together through
> associated_id.

This is not exactly accurate.  Under normal operation the blk queue
parameters are already set to ensure the requests match the maximum
size the ring can accommodate.  However on ARM there's a corner case
when the guest is using 64K pages, as in that case even a single page
request cannot possibly fit into a single ring slot, and thus needs to
be split.

This needs mentioning explicitly in the commit message, that such
splitting only happens when the frontend is running on a 64K page
kernel.

> 
> On the normal completion path blkif_completion() collapses the pair:
> it recycles the second slot via add_id_to_freelist() and only completes
> the request once.  The suspend/resume path in blkfront_resume() does
> not.  It walks every physical shadow slot and, for each slot whose
> ->request is set, calls blk_mq_end_request() or re-queues
> ->request.  For an in-flight split request this visits the shared
> struct request twice, so on resume/migration the same request is
> ended (or re-queued) two times.  The second visit is a double
> blk_mq_end_request() (refcount underflow / double free) and a
> use-after-free read of req->bio, which was cleared on the first visit.
> 
> Skip the secondary slot of a split request in the resume walk, so each
> logical request is completed or re-queued exactly once, matching how
> blkif_completion() already treats the pair.  The secondary slot is the
> one that is linked (associated_id != NO_ASSOCIATED_ID) and carries no
> scatter-gather list (num_sg == 0); the first slot always keeps the
> scatter-gather list.

I find the above slightly too verbose, I don't think you need to go
into details about why freeing a requests twice is bad, this is
already well-known.

> This was found by 0sec automated security-research tooling
> (https://0sec.ai).

Isn't this information already conveyed by the `Assisted-by` tag?

> The bug is only reachable on suspend/resume or live
> migration of a guest whose backend lacks indirect-descriptor support, so
> it has no local reproducer; the fix is by source inspection against the
> existing blkif_completion() collapse logic.
> 
> Fixes: 6cc568339047 ("xen/blkfront: Handle non-indirect grant with 64KB pages")
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/block/xen-blkfront.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index f765970578f9..b2e83fd0c77b 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2079,6 +2079,15 @@ static int blkfront_resume(struct xenbus_device *dev)
>  			if (!shadow[j].request)
>  				continue;
>  
> +			/*
> +			 * Split requests alias one request across two shadow
> +			 * slots; skip the sg-less secondary so it completes
> +			 * once, like blkif_completion() does.

I would possibly avoid mentioning blkif_completion(), as those
references tend to get stale as code changes.  What about using:

"For requests split across multiple slots only process the underlying
requests once."

Or something similar?

Thanks, Roger.
