Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020142.outbound.protection.outlook.com [52.101.196.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AE47D460;
	Thu, 10 Sep 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041198; cv=fail; b=jM4TU+/cn8c9euL5sqrE53TN6uO4/WQcKbLl4UtXGaLnnnEwRk7x0GXr7DH+2VsVmGET5ljkwihlpnUlNW2riZk7DhiAZoJkd98Wb9w19hFItQTzyAOC7qoKBeRB3CQ1mnmhGHlo6tv0HjSJb4tulRMDphEQqv7iHGKVFvunrm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041198; c=relaxed/simple;
	bh=mis+9m4PePU+MlURn0+BRA5EoyBVFRTh+oM9u97uSZk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=f/bSRQt0AVxxT3EWWWEBfRQ1tHClPQgcfXBaSsVdFANbrM4vin9pElq1N2Ca1sXfXPeGdxod6ji+EH0iydTXMZhg0ciplebBHk4PntAfI+1vcSUhdtEzk/WLgHfjhciOcS6Rb/l58nqAPuoqj7ATR1J+Kjx/yZ+O6jQ2y2JIzX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KdRU7BpB; arc=fail smtp.client-ip=52.101.196.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KdRU7BpB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eopGiQ/H7JUlqKhYEeLmGaLFzqVWMUssNIL5gGSz+UFqaLF/icw4mBmor5kgdyn9c9fhwnZ7RM6715jbtKe9dZ408NCYfu5oAuyaTLHBNQb1lfGGAEvb6VnLv6hfYQFqtvSSjGpa1cSgFGO2iaKZifdqCspbdPODHkJkcfCPTfWiFUgboybRAZT1clbt6BJQxbSyTEbsaPvqBZnQhjCZ9NV1HhkReEdmHyNX4xHMYIeX/P+noF6K4YpkkQZdii7Td62/PTn0aX5ceaFEAzNkBcZP/u3QtFqiHSk3Uzxk8kcNtF+tl9VZhPEY5vAduGN5HDA06BSauCZa16CkXIcOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJi+P5rJVUgbxW7rvcOQda+09y57Bnf36RvvQnm92Zw=;
 b=jzjeO9nagkfoPf6RfcQgwW0VponxZYSJLTl/FZBSwHx0hBgZlxeRq9cSNI3E4hkJZGhjTCG4oJfvmVdBWSKv/1djhQNXLW4zn7jY7DnBn8TnyaviGTcbtdO+iCPdMChxhpJrI1Y/B0/8ar/LOyZGPzDEPfoMfEdbB7YQpqjgM5AowvoyHHQHIf+JD+wOJ8TD8ypFPN4zy0U0l1Elalcy5+ZmGy8n7/fhntv3vsAUIMBnuuAlPr1DERhHqUfndHPHguR3hWWrHAWZ6wWrnCGhEa6apBt3AB60P+E8fGr/xF5YifAStuhDI13zErY+uAyfB2sOLZdIc6LJicMw9C4NuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJi+P5rJVUgbxW7rvcOQda+09y57Bnf36RvvQnm92Zw=;
 b=KdRU7BpBXyp0jqV+Jnr1zaWtw7US63BRALU44j+0/KpRovWKiZMfWC491CMpRfPZVNkuadilhVsfa4EM/iK+PmABStJdWXMTJBVYd3yzfamsWmf4U6jS1NXySaGx36SO2Fu12DsvrSOEt8VJdFaAnBVfjKZpLcZw2OCatKQhAXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7437.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 11:53:03 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 11:53:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 12:53:02 +0100
Message-Id: <DLBM64YIHJ5U.3NZZTGR2NP75Y@garyguo.net>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Brian Foster" <bfoster@redhat.com>, "Damien
 Le Moal" <dlemoal@kernel.org>, "Hillf Danton" <hdanton@sina.com>, "Markus
 Elfring" <Markus.Elfring@web.de>, "Ming Lei" <tom.leiming@gmail.com>, "Qu
 Wenruo" <wqu@suse.com>, "Tao Cui" <cui.tao@linux.dev>, "kernel test robot"
 <lkp@intel.com>, "linux-block" <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: Add post_release() operation
From: "Gary Guo" <gary@garyguo.net>
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, "Jens Axboe"
 <axboe@kernel.dk>, "Bart Van Assche" <bvanassche@acm.org>, "Christoph
 Hellwig" <hch@lst.de>
X-Mailer: aerc 0.22.0
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
In-Reply-To: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 7742ebed-9c5d-4e66-a1fe-08df0f321175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10070799003|10067099003|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C48v3JlltlBsh73fIJSjsiZKSjfuHD6KTqYgol3dhnx838bbaOc7ovhJy+xqOkgqi8uYuifuw5jw3Wf6lv5G5GgXYwGo9WjhK5hfXj9+Q2aIXP7nk507+Vqy7qUZNnrU21vkW6e1yHcJRF3TNOZfplgEaG84lqpWnBFq2HzuKVXXQfGbiNpNQ+FBXLFbFWNtwXm9ZKEosBhCO1qacyMkldQS0Zp5glUDWK10RCe5mAQ4Nh0xBANaCVVixPjO/v9SkVzUmR3ZOPJCxVIRgevJBrojTAhp4GlgDA15d1Wh4fhYuGBrM3H3pgxQ/hJ7C/QejqaB6CpY6vmMDhhmEgtLVeNsNJB2bkInM56qA8sn9nVpqfa86aXLxwum9W0VmsHjhuNBX5/3V0u1ub0dgpZnu6dFOePWKaVt6NZ4GPqz1tHxcqFTZe7c/KhDB2e5eLCInRODoR2Mw6jke6UC4lTWyQf8Y+zE45gGIfSYBXPncuAN7d+XsZCxw9c2cPMTrwmc3CLOa87R049XzVJj4SfUa4sbKPtC2NIg0n6W3KU9o6HyNVZqQ95H22cVgknEbpqV3IHazfG4iNMmO/M7legIpw5l+ugsTdutJwF/Ri59m0XqAq+s0ICdJQ81MuS4uVFSlMOTWvuCEOmy2ctvHzty9JdL0QYdz6UqTqqwXmD+HT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10070799003)(10067099003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWZjNXJUUTZkUWlwVkU1bktJVmJjY3crbTRNVy9iR25DVks4bWdVRVUzYkE3?=
 =?utf-8?B?ZCtlMG9hVktGcFp1Ly9qeGVnaXhla1ZDTFB1WW5FTHlxRXpOVDFhU3U2WjJF?=
 =?utf-8?B?TXlQS0ZOMEh4dVhiWFpKMjFEYnpaRXQva3JoYWs5cE83STJndnR2Ym1hUGk3?=
 =?utf-8?B?Zm50V0xVekhXRURtZjBBSXZaOWZISXE3YlluYk9FWjJxVDdJcGxQa0dQck83?=
 =?utf-8?B?RjI4b0dZOWtCdHBqc053L1hkc2NvNldNZm13bDFmSHVJK2NvNnZPVER5Z2hx?=
 =?utf-8?B?NUdRQXRLTmJCQ010aFdTT1ZubHdqT0djWko3SUxDODlwZlJtcG5OcnB3ckRj?=
 =?utf-8?B?REhkdGs3WW90UnF4bE5pVnlHdSs4T2VvTVJHdTlhcWtWR1hZUzBYcjFLZHBv?=
 =?utf-8?B?ZW9sV0lEeE5hNWRCcXVpWEx4Zmd3eHVCTm1CakxEV2FzVW1JM095ZFhGY1Fx?=
 =?utf-8?B?YVkzWmgwY0lVb2VHU1lEYXJpd044WkNVUmsrMWdmUFg5SE0xZTZwV1AxajNX?=
 =?utf-8?B?Ly96VGk0SGpPemFKRWQ4cnNLSEV4ZkE3azNqNUtWRC9KZTcydUVXbm9rSEFw?=
 =?utf-8?B?Z0twYnpnbGtPYXppQ3RKeTNZSEN0ZzhaR3VPUVYwT2x5T0k2aW1WQVJQQ0NT?=
 =?utf-8?B?SENBazhmNXkrNUs0WCs5S0l4bDh2Wkw5R3M0cWZVWFdXSzNoanFFRUtueW9Y?=
 =?utf-8?B?TXllRjh3OE12S1FwZHh5TkpPR0Z4dDZWQXB5Y1puZGZpcXplbmE0YVlVdFVn?=
 =?utf-8?B?WjFxNC9Pck1JTTVVanpTV2xrOElrZUtzeUZJa1lXMUsrb29hOTFKSVgyS2tC?=
 =?utf-8?B?TEFrSStUeHpuNWd5RG1rYTYzQmZyM0RVc2RoOFdWZkJuRDlNZHc3NXl1OVBU?=
 =?utf-8?B?WHg0NHl6R25vVEc4V2szMU93Q09iczk2T3JRdmVtVnptMWdjeEJGQmdxZUxw?=
 =?utf-8?B?dTZlUDVLS0hGOU1zZVJwbVJUTGptd2FLV3N0V1NnbDlCVm9qV0I5S3MrWkIy?=
 =?utf-8?B?WDhmbzFyMG8wSHZFdkpTRDlZS1lnc1J2N0FZSWxxd1JncjZ5VWNQRXpHMHY3?=
 =?utf-8?B?WDVUYkpXVWJGbFZlaEw3Q2FwZ2ovZnZFV2Y1aFptbCtneDYzY1JCcHZJKytV?=
 =?utf-8?B?M0tOajNwMjI0RDcrcllnelZBWUpJNEJpelhacG51MFNqT1FRTUwxS2RrR3BE?=
 =?utf-8?B?djZobndmMEpJazRnL3JwTTRVcEIvczZLM0pUaThhWTYwbUlSMStRdVFqSFpk?=
 =?utf-8?B?eDhIb1RkazZlMzVGZjhiWUdqaUJ5aFlVb1pUNVJoVEk0dEFmVnU4cXphNmI4?=
 =?utf-8?B?V3ZnSzNGTkpzNEpQVXdlQ3k5YytJV1lXOUxYWXNWby9YRjVNYVVhbC9sN3dW?=
 =?utf-8?B?TDAwaDhVUVN2K3ZiRUVkK0E4VDQvNFVtSjg0M09zeXV5NTNnajY5eVRIUXVu?=
 =?utf-8?B?WTFiU2hVeWNYdk51ZGtqSXUwZzY3dElnVUJDOUhFT0Z0OWdaM3pGWHdFR09X?=
 =?utf-8?B?bmEwMFRmY2V5N0FRSmh3TlpzbThSRjZnMXN1bXpVbWo2WkN5QUVJMCtXSDVs?=
 =?utf-8?B?K25TYjhRRHhFTk14R0MvUEVhQzV5ZllwbVZ2VFIwSE5jSTd6ZzF3UklUYytC?=
 =?utf-8?B?c2FxSWtxMWUvU2dYSGtVWXhNckdhcnhabjJYblRuV3NWMUl2OElmd2J5eGhP?=
 =?utf-8?B?dW9TOWR0c1BBK3hTUEZXQTJqSzU2Q01wTkpQZzF5U1Q5VVFSWWtLYWNPdW1y?=
 =?utf-8?B?VjN4OXdFcE1RY3pKekZTNHByMk82eXBBdXUwMTFiUThjcXpRWDYrMUw0UjFH?=
 =?utf-8?B?dFhjWW5iWmgrcFpBNkpwZHFRTWRZQkFRRzJPY21IclMvdVJVZlduZ3pDOGt6?=
 =?utf-8?B?ZmtYY3RvcmxDL2szMHFYREhRQkFUWVoxSlVwci9JUlFkYTZ6SUxLUHViN1JW?=
 =?utf-8?B?aWVkTDVzTEUzVFpRQXVHNmFYMVhCZklUMVFGQ3pKQVhTbDVhd1p2Wnh1QWI1?=
 =?utf-8?B?VWxFeElnbzMybFdXbXFXVExjZ2N3Wnp6eCtUTmRuME81K2JPa3pURUJLOVBl?=
 =?utf-8?B?N21vWHVCZCt2S3Zxd2cva0FnSml6VTRRTENqRHQyK3lYOHZqSWpYZ3VVMFFE?=
 =?utf-8?B?dmc5TVJEaWJ5SjNwOXBOMEdqK05mRzJxMDVBd0R6NUZTYTJXRGNJQlFHdHJr?=
 =?utf-8?B?VUt0dUtrdTNreDFiaVhlR1ZDYTNqWWpURXFuaklvTHdJRFk2bGJ3WTk1cFRv?=
 =?utf-8?B?YmZGWXR1ZjlQRWtiNEVmOFZoUXNFcFdCb0pjTkt3ZVgzREVIR2Y1dmcxZEI2?=
 =?utf-8?B?VVY3WERSTUx5akxzU2lycTF6Ulkrdk0vbi9mdVJ6NlFjaE1jSHhkUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7742ebed-9c5d-4e66-a1fe-08df0f321175
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 11:53:02.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x975aILJj0Q6chZXRQGFYYhWChYx+UEPsCmG34yrzUDottTq4D3sP43q+UuB7KRXBmfjKKnjjgbpkdFvsclH5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7437

On Wed Sep 9, 2026 at 11:48 AM BST, Tetsuo Handa wrote:
> Add post_release() block device operation which provides a hook for
> performing synchronous cleanup without disk->open_mutex held, which is
> needed by the loop devices.
>
> Real-world container engines, test suites, and system utilities rely on
> fput() from __loop_clr_fd() being completed when lo_release() returns.
> But changes which went to the v7.1 merge window broke an assumption that

What change? You should mention it with a Fixes tag.

The message should also explain how the assumption is broken, not just stat=
ing
that it's broken.

> there is no outstanding I/O when __loop_clr_fd() is called, causing NULL
> pointer dereference problem in lo_rw_aio().
>
> In order to fix this regression, we want to allow __loop_clr_fd() to flus=
h
> outstanding I/O. But calling drain_workqueue() from __loop_clr_fd() with
> disk->open_mutex held causes lockdep warnings. We need a mechanism which
> can flush outstanding I/O without disk->open_mutex held.
>
> This post_release() operation is intended for performing only idempotent
> actions such as flush_work(), for nothing prevents multiple threads from
> concurrently calling this operation. That is, the loop device schedules
> a work_struct for calling __loop_clr_fd() from lo_release() where
> disk->open_mutex is held, and waits for completion of that work_struct
> using post_release() operation where disk->open_mutex is not held.
>
> Also, this post_release() operation is called from only bdev_release()
> path. This is because loop_configure() is not yet called (there is nothin=
g
> to clear) if something went wrong between an initialization lo_open() and
> an error-unwinding lo_release() within the bdev_open() path.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  block/bdev.c                     | 2 ++
>  include/linux/blkdev.h           | 6 ++++++
>  rust/kernel/block/mq/gen_disk.rs | 1 +
>  3 files changed, 9 insertions(+)
>
> diff --git a/block/bdev.c b/block/bdev.c
> index cd8323083740..7ce5acaacf43 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1188,6 +1188,8 @@ void bdev_release(struct file *bdev_file)
>  	else
>  		blkdev_put_whole(bdev);
>  	mutex_unlock(&disk->open_mutex);
> +	if (bdev->bd_disk->fops->post_release)
> +		bdev->bd_disk->fops->post_release(bdev->bd_disk);
> =20
>  	module_put(disk->fops->owner);
>  put_no_open:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4f7905c3412b..f05dba1b5962 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1605,6 +1605,12 @@ struct block_device_operations {
>  	 * driver.
>  	 */
>  	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
> +	/*
> +	 * Called after disk->open_mutex is released in the bdev_release() path=
.
> +	 * Used by loop devices that need to perform synchronization without
> +	 * holding disk->open_mutex. This operation has to be idempotent.
> +	 */
> +	void (*post_release)(struct gendisk *disk);
>  };
> =20
>  #ifdef CONFIG_COMPAT
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
> index fc97dd873974..2ff77ef49781 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -129,6 +129,7 @@ pub fn build<T: Operations>(
>              submit_bio: None,
>              open: None,
>              release: None,
> +            post_release: None,
>              ioctl: None,
>              compat_ioctl: None,
>              check_events: None,

You can use

    ..pin_init::zeroed()

to have all other fields zeroed. It might be beneficial if we care about kn=
owing
all new callbacks, but it doesn't look this is the new case.

We probably should remove all `None` assignments so it's all covered by the
`..zeroed()`, but that'll need to be its own patch.

Best,
Gary

