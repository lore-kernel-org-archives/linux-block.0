Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD4C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055CE2070B
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 18:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDSYs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:24:48 -0400
Received: from server907e.appriver.com ([204.232.250.40]:60590 "EHLO
        server907.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726352AbfFDSYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 14:24:48 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 14:24:47 EDT
X-Note: This Email was scanned by AppRiver SecureTide
X-Note-AR-ScanTimeLocal: 06/04/2019 2:09:47 PM
X-Note: SecureTide Build: 6/3/2019 7:34:16 PM UTC (2.7.9.1)
X-Note: Filtered by 10.246.0.224
X-Note-AR-Scan: None - PIPE
Received: by server907.appriver.com (CommuniGate Pro PIPE 6.2.4)
  with PIPE id 272567096; Tue, 04 Jun 2019 14:09:47 -0400
Received: from [10.246.0.39] (HELO smtp.us.exg7.exghost.com)
  by server907.appriver.com (CommuniGate Pro SMTP 6.2.4)
  with ESMTPS id 272567073; Tue, 04 Jun 2019 14:09:46 -0400
Received: from E16DN29A-S1E7.exg7.exghost.local (192.168.244.206) by
 E16DN06C-S1E7.exg7.exghost.local (192.168.244.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 4 Jun 2019 14:09:45 -0400
Received: from E16DN29A-S1E7.exg7.exghost.local ([fe80::a19c:46b5:a8a0:4aba])
 by E16DN29A-S1E7.exg7.exghost.local ([fe80::a19c:46b5:a8a0:4aba%21]) with
 mapi id 15.01.1779.000; Tue, 4 Jun 2019 14:09:46 -0400
From:   Justin Sanders <justin@coraid.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: aoe: no need to check return value of
 debugfs_create functions
Thread-Topic: [PATCH v3] block: aoe: no need to check return value of
 debugfs_create functions
Thread-Index: AQHVGkVIjKqm4AaW+k6RowxiyHwjOaaMD9+A
Date:   Tue, 4 Jun 2019 18:09:42 +0000
Message-ID: <B606EE6D-38A5-41BA-8544-163B949EAB5A@coraid.com>
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
 <20190603194754.GB21877@kroah.com>
In-Reply-To: <20190603194754.GB21877@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.71.233.237]
x-rerouted-by-exchange: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AC85A9BEEBD6D4FA432B24773C0A97B@fwd7.exghost.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Note: This Email was scanned by AppRiver SecureTide
X-Note-AR-ScanTimeLocal: 06/04/2019 2:09:46 PM
X-Note: SecureTide Build: 6/3/2019 7:34:16 PM UTC (2.7.9.1)
X-Note: Filtered by 10.246.0.224
X-Policy: GLOBAL
X-Primary: GLOBAL@coraid.com
X-Virus-Scan: V-
X-Note-SnifferID: 0
X-GBUdb-Analysis: Unknown
X-Signature-Violations: 0-0-0-5861-c
X-Note-419: 15.6269 ms. Fail:0 Chk:1358 of 1358 total
X-Note: VSCH-CT/SI: 0-1358/SG:1 6/4/2019 2:09:38 PM
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->
X-Note-Sending-IP: 10.246.0.39
X-Note-Reverse-DNS: 
X-Note-Return-Path: justin@coraid.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: G586 G587 G588 G589 G607 G608 G756 
X-Note: Encrypt Rule Hits: 
X-Note: Mail Class: VALID
X-Note-ECS-IP: 
X-Note-ECS-Recip: gregkh@linuxfoundation.org
X-Note-ECS-IP: 
X-Note-ECS-Recip: linux-kernel@vger.kernel.org
X-Note-ECS-IP: 
X-Note-ECS-Recip: ed.cashin@acm.org
X-Note-ECS-IP: 
X-Note-ECS-Recip: axboe@kernel.dk
X-Note-ECS-IP: 
X-Note-ECS-Recip: linux-block@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

> On Jun 3, 2019, at 3:47 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: "Ed L. Cashin" <ed.cashin@acm.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Omar Sandoval <osandov@osandov.com>
> Cc: Justin Sanders <justin@coraid.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3: Justin is now the maintainer of this driver, properly send it to
>    him.
> v2: fix uninitialized entry issue found by Omar Sandoval
> 
> drivers/block/aoe/aoeblk.c | 16 ++--------------
> 1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index e2c6aae2d636..bd19f8af950b 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -196,7 +196,6 @@ static const struct file_operations aoe_debugfs_fops = {
> static void
> aoedisk_add_debugfs(struct aoedev *d)
> {
> -	struct dentry *entry;
> 	char *p;
> 
> 	if (aoe_debugfs_dir == NULL)
> @@ -207,15 +206,8 @@ aoedisk_add_debugfs(struct aoedev *d)
> 	else
> 		p++;
> 	BUG_ON(*p == '\0');
> -	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
> -				    &aoe_debugfs_fops);
> -	if (IS_ERR_OR_NULL(entry)) {
> -		pr_info("aoe: cannot create debugfs file for %s\n",
> -			d->gd->disk_name);
> -		return;
> -	}
> -	BUG_ON(d->debugfs);
> -	d->debugfs = entry;
> +	d->debugfs = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
> +					 &aoe_debugfs_fops);
> }
> void
> aoedisk_rm_debugfs(struct aoedev *d)
> @@ -472,10 +464,6 @@ aoeblk_init(void)
> 	if (buf_pool_cache == NULL)
> 		return -ENOMEM;
> 	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
> -	if (IS_ERR_OR_NULL(aoe_debugfs_dir)) {
> -		pr_info("aoe: cannot create debugfs directory\n");
> -		aoe_debugfs_dir = NULL;
> -	}
> 	return 0;
> }
> 
> -- 
> 2.21.0
> 
> 

This looks good to me, thanks.

Acked-by: Justin Sanders <justin@coraid.com>

Cheers,
Justin


