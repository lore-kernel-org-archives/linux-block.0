Return-Path: <SRS0=t6Xx=AJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC79C433E0
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 15:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DC6206F1
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593359928;
	bh=TABu29BI2c2+MRgRU1Lp6FgWpAUZToEc49ZuYWCqrwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MSJv2DuAzzxd6a9AxWWqbvcR+1+HV6NDF9TiHNZIp5SGHJJe9BDj+u00u+4CQSiDA
	 71NFbs5Vq3/FDfFQUHl2fSr2TKHKI/q7zPCvNrzFuF16vKzcZ416QUgfVgRCyfOs+J
	 6jMCry0/DA3snByTah2gmfvVBDMv1GCgN9nIxtaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgF1P6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jun 2020 11:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgF1P6r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jun 2020 11:58:47 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E207B2071A;
        Sun, 28 Jun 2020 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593359927;
        bh=TABu29BI2c2+MRgRU1Lp6FgWpAUZToEc49ZuYWCqrwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2VVzPPuS4p+UcSYmiyCkYc3MuRC/eV0+XGU3zj9Oy0Z5QZZ8nKO9SMZRuThM2ho3
         V7UduENIdaHhvg/HRkpUL/8SKz4HVUM+dnZ06VXaDQR+OI1k7sIgG3exEfYTFfZxHB
         JPxCeEiqUYsMECWRPKNaXVM/fEZh44dOXH+oX13g=
Date:   Sun, 28 Jun 2020 08:58:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Zheng Bin <zhengbin13@huawei.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] nbd: Fix memory leak in nbd_add_socket
Message-ID: <20200628155845.GB2310@sol.localdomain>
References: <20200612090437.77977-1-zhengbin13@huawei.com>
 <BYAPR04MB4965BCC5D59A22A417274A5486920@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965BCC5D59A22A417274A5486920@BYAPR04MB4965.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 25, 2020 at 12:16:33AM +0000, Chaitanya Kulkarni wrote:
> On 6/12/20 1:57 AM, Zheng Bin wrote:
> > nbd_add_socket
> >    socks = krealloc(num_connections+1) -->if num_connections is 0, alloc 1
> >    nsock = kzalloc                     -->If fail, will return
> > 
> > nbd_config_put
> >    if (config->num_connections)        -->0, not free
> >      kfree(config->socks)
> > 
> > Thus memleak happens, this patch fixes that.
> > 
> > Signed-off-by: Zheng Bin<zhengbin13@huawei.com>

This appears to address the syzbot report "memory leak in nbd_add_socket"
https://syzkaller.appspot.com/bug?id=08283193956ab772623e65242b3ed6d0e7c7d9ce
Can you please add:

	Reported-by: syzbot+934037347002901b8d2a@syzkaller.appspotmail.com

> 
> Not an nbd expert but wouldn't it be easier use following which matches 
> the + 1 in the nbd_add_socket() :-
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 01794cd2b6ca..e67c790039c9 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1209,9 +1209,9 @@ static void nbd_config_put(struct nbd_device *nbd)
>                          device_remove_file(disk_to_dev(nbd->disk), 
> &pid_attr);
>                  nbd->task_recv = NULL;
>                  nbd_clear_sock(nbd);
> -               if (config->num_connections) {
> +               if (config->num_connections + 1) {
>                          int i;
> -                       for (i = 0; i < config->num_connections; i++) {
> +                       for (i = 0; i < (config->num_connections + 1); 
> i++) {
>                                  sockfd_put(config->socks[i]->sock);
>                                  kfree(config->socks[i]);
>                          }

That looks wrong.  The + 1 is just nbd_add_socket() preparing to append an entry
to the array.

Why not just check whether the pointer is NULL or not:

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..cb8e86174edb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1206,7 +1206,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 		nbd->task_recv = NULL;
 		nbd_clear_sock(nbd);
-		if (config->num_connections) {
+		if (config->socks) {
 			int i;
 			for (i = 0; i < config->num_connections; i++) {
 				sockfd_put(config->socks[i]->sock);
