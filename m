Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE663C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiBPPcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:32:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPPcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:32:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87743DB866
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHEkkF5tP9T9Y+tlK9XtB16US9pXy1mjV6koVgaB+IRKYkEt5c7ZZ4rhUbZ+sZQyHEzvXMuLgua/ZQE1hjBNm0OrRV5KFZ7vpSKEY1d/vZQ5IH3E+cUtGvJlUi0YPfirns2S78sGutVquVqjhVYhiyeBtcAQ4Z8oOaMsdmTxNRUmJa2/UmKxdokM+2Rt/xmD6dLWDj4zbK4ZBWfh8hUhl1ej7C3gRPph1iC63wdj1eCuDKwnbvrkyrps1erhycjiNIApdHePFl8jA2+0R3/7/pwrTCPkWi0FP6QUbSE1E8BOL/JpBRVm+okFoL6nfkKMmmOZ7UlPcHU2mOPnFvQG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyAEip20uQH1U0R29O46boRelCpOwfzoOT/sM/5uaCw=;
 b=Dl1UIbuZ7nZAVCTT2FvvXav57a2wlFxvHaIjZFIU874BrH5Qm2WbQ9HPYXGd7/YicNUCWkHAvPd5Q73L0odce5XK4PO75OxdvL+DcPWJmlqkxBh+Y1fN6CuyacO47XdLDhqlcVFEumE5LUf6sl3Iu5YwYgK3L0iTHdWNRO5+R1z26MQ+5GisxNLznShg2klp0W58d1MDOx0D5+4sbd7HZlAinFqXzx4ZyqYXMAQAezzFeH35w0WxjR7omkJox2psaNoCyuUWwFyw3sAKnnjCRLQ2Wy8/Gk5zuOesPSngsIdC6+YAUO6H6/OpJGv09zkm97NldweIJ1qFx1x0ZHFiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyAEip20uQH1U0R29O46boRelCpOwfzoOT/sM/5uaCw=;
 b=rmwRoG2ge4tnPspI+/X4mjV2gygZS1VSi46w/sl/+TDvmXdHoldU3w4zHORMLWvRKoy7+4KyY2dd9DDT5tV+nxRsSScyxnH2b8f0cLuTmfJgFg/RCT4gt4VhrpV+Bu3leH2G9XoVdvXbgpH/RarZMiguJ84cxGyquYrBFATAxOK6iSKBKNwm790p01KiBEuUmwt9wZ9L7vvJK7nrIKgvRR1trzAeBlZ5go1iIGND3g3LEAFk65/dU/Y5gONmIDCZ2igciAUvNO1MEf83sy1aQmJbSrP56rAAFMKT1IGUfBAQNbpqkZPDd1GbH1ZqGwnl7Wdmx3Ua8s3zuE64Rwu2bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
 by AM6P193MB0296.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 15:32:27 +0000
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0]) by AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 15:32:26 +0000
Date:   Wed, 16 Feb 2022 16:32:26 +0100
From:   Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216153226.cgwaigrhjdjeuqo7@ipetronik.com>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150901.4166235-2-hch@lst.de>
X-ClientProxiedBy: AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::14) To AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:307::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96dc2bc7-6d92-432d-6113-08d9f1618961
X-MS-TrafficTypeDiagnostic: AM6P193MB0296:EE_
X-Microsoft-Antispam-PRVS: <AM6P193MB02968A71EDEE9D4F76C122CD92359@AM6P193MB0296.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXgesevewGD0rGcBwzR/vq+txTvUOmlkX8FWBok3Ws18fnKPHCY70F0rF+yodgxxBSWoS+XVpJgj3B12XNeCSYbnUJhBPiSZF8MYxbMP9FHeWCYUgsDcrUS+piNMR6gbh/llcZXU+E3w2RLl0IZomFKordxT7UecW5A4aZwHebV8ze3nveCoEu7gBtw4EP6OmEr0HWQie3zNyqs9jUoIF2y6Ba3lufyQSQ98w4Snn9pHQDr7gfwyjEKEygOuF3uklOcDZ5NEt7bvdjZRJYVeWE3TH5w8DZtAGb+Qklj3NF0I9+dptOwFC/JZTaB8U8S0bzsqLm1uVpNxxm+B98cl+icZDQWdomvgt27fjCUQc1W3Q67JqJ5v2Kr0lqMRWXUmhfPOjCviCWgyACcgLQ4LNI/ZsdmPjNxoMyaeJuEPLgAHq5mR32rR2lWVldys3RSgtjNnABTFTjwWtwUDMJPj3e1UINAP5KOt7zhzI9R3GVwBuAHSQ9oqxXrLaRa1ln9CshOxHnUz1GhKT6i+xN++aPSSL42/Q/hZMeAYiuBfBgWiePCh4SYaLRrU//ELZYAKuTlwogOmQ9aWaS3tecZXy/g8KgDK3RNmRVyh+OIm+cigHnVkXnbrBGm0iSO2JLpOtM8wBOATtaN4wLuK3VCvIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1572.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(83380400001)(38100700002)(36756003)(8936002)(86362001)(2906002)(6512007)(5660300002)(66556008)(66476007)(66946007)(4326008)(8676002)(186003)(2616005)(1076003)(6506007)(6486002)(6916009)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8gymghPQZIn3IK01KjznP8MErTix4KsJTUioxU1syrzNP0SrQnzRo2lKy8Bh?=
 =?us-ascii?Q?TQmgB0zd9H9YaUtvnzAqPATCA7VI0mb67M+tz9Zi6uvjaKTPB/pDrX1+5n+/?=
 =?us-ascii?Q?vtGsxooKPLPIyDHqZ06ZGbyK9am756CUNKxwgfLxgzGz9QuSXUJVd5lEOwop?=
 =?us-ascii?Q?ifmEzmAoKoILz+8kXVIeqv7SEwObVVO8GEm5GVnw25ZShzkbeE/2kqmj9xbM?=
 =?us-ascii?Q?m2cdP26AMRgSw3uPpRIw4AxzlrbbAeLgMNzCyiYOLG+V4OllIeA6zJF/P2Re?=
 =?us-ascii?Q?nr7FrKGgnlWXonXNVm7WeBfq1cnMFn9skJYU3O01NEgBqIjikSwGaJEEyYy3?=
 =?us-ascii?Q?RVu67bPqoUqawdcBYuCzFBwc2zetxdNS3QZTSsIMTAXwBY47gWiJj/gMRlBJ?=
 =?us-ascii?Q?Lk6id4PEZtF9KavzBTSvcsjffp5zhkK5WZMeJUOlZyW98034Abq10DfS3WaQ?=
 =?us-ascii?Q?Lj+JKuoMTDvAHSIqT9FFU/7RJ/O5/fcHCPjKZh8SfNlY+wP0I9CTpMYM6cRt?=
 =?us-ascii?Q?fyzTp0ksoaF9t4OmJ+rAiGUZRJ29JdmB4Q+OtJvuZljLewozjDrUjPX9Uc75?=
 =?us-ascii?Q?6uPgN2HPj7xrxpu2gNLSi7UiPT9tHN4J3AYgNtm8aHrjkgcPSHg88vJU3TB5?=
 =?us-ascii?Q?TKOyMN1MXwRWuFG+ilrSZYc/0JSn2+AkrAtvujqogw0E+jWCK18C5RUHZyAC?=
 =?us-ascii?Q?5ZO7jh3eWjcJsrFfa3oiwBd62tkTQC7Hn6pAxw8hSJWe1NAN+rnKU9PDaRI4?=
 =?us-ascii?Q?WljuZvOsoifDy0UwdUk9ejTrW8DZDXz1ng0C3IR+f9j6xFENjYAkwQBc1jIk?=
 =?us-ascii?Q?tCJTx5WK81RSmO3wyhTudHPVm/prIvB6mjVb+cgQKw3vpwb1/09RNZ1tl9Nz?=
 =?us-ascii?Q?+YXk7I8j0LceI7HHMOjYw3NXO+Ri6s7GRz2UDb5etayGWE1Ed44DW2OjUvOU?=
 =?us-ascii?Q?EBVZ+a/55wS+fyZZ4wyliB0JmEgrKw+dhmK3jaiQbEMNKKWy6pghJU1XUzdi?=
 =?us-ascii?Q?o+iVzVqFDgKviJBMy99To06YY7U0knAr28Hdp3qjteTWVxDaFOWzMRbL4z9Z?=
 =?us-ascii?Q?6puP6Ahpu6dfFIig53iWKnw/jMBoUmolI3G/kJQm0xuqeS7kdD/awP/m5w/u?=
 =?us-ascii?Q?MdvNzMQTkoRHQbwv+dW0INEf0Ue26EBtjykzL3eC1L489szsTK/dHvSS81X8?=
 =?us-ascii?Q?TmrMqLD2XS9OUbKdqBeq/4DPSfhw36814rzUA6cai8r/rB5SCLx1P05Jq+jc?=
 =?us-ascii?Q?bJ/XnO6Il3ZvylrmeSDuS9n0wbqrJRekkj2Bp2Zo5DMXQ1pEcjo4OnG7RHdm?=
 =?us-ascii?Q?qgDZl0GqKf7y0Y7BJI27EvlXwWZnVl6gyo9FIEJkRJHtPu0T5Bl4v6Hzx9KZ?=
 =?us-ascii?Q?iZTD6/SOrxpyunWDP3s60a7zBBvkCk6HacjvhAGNSEEroM4+sEzyP8tV/HND?=
 =?us-ascii?Q?+CpV0vMgFHy0dJhl98h7RfGBWaZJyErjxseKfnMet16sN9LMF0UKUmjcDQMK?=
 =?us-ascii?Q?fGbWw+DufdTkT0POM2n0XJxmq1tx0gBUm3jVfEpsG5qMlc3tev82BozA1oUm?=
 =?us-ascii?Q?wOiHmBbnYteiy0oRVz5eeDAA5suRopdE1Os22obxanjbrgvECwwyY1dBVx8f?=
 =?us-ascii?Q?4Kcj1xhNBnSqQnxiUYt8McpNCHQjayrcSBU75kfDMnodYFqGYv98JgmfII6l?=
 =?us-ascii?Q?PC+mNDYS1HDQR69CbrQLYF8qKHSwxtvZ1trwoiGQrjJqiW6txrjS27Lu8i6B?=
 =?us-ascii?Q?m4SX1ghCEA=3D=3D?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dc2bc7-6d92-432d-6113-08d9f1618961
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:32:26.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWdaNFIOJmrClmpawZg8ouMyYTz7zVnDF5d1xkOusuZSBfNWoLmcY4JVpVi/pLgC20BzOE69vMcqr+nS2Tl0vAoghPr/Y1JKXdIy80ESpt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P193MB0296
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> For surprise removals that have already marked the disk dead, there is
> no point in calling fsync_bdev as all I/O will fail anyway, so skip it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 626c8406f21a6..f68bdfe4f883b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -584,7 +584,14 @@ void del_gendisk(struct gendisk *disk)
>  	blk_drop_partitions(disk);

blk_drop_partitions() also invokes fsync_bdev() via delete_partition().
So why treat them differently?

>  	mutex_unlock(&disk->open_mutex);
>  
> -	fsync_bdev(disk->part0);
> +	/*
> +	 * If this is not a surprise removal see if there is a file system
> +	 * mounted on this device and sync it (although this won't work for
> +	 * partitions).  For surprise removals that have already marked the
> +	 * disk dead skip this call as no I/O is possible anyway.
> +	 */
> +	if (!test_bit(GD_DEAD, &disk->state))
> +		fsync_bdev(disk->part0);
>  	__invalidate_device(disk->part0, true);
>  
>  	/*
> -- 
> 2.30.2
> 

