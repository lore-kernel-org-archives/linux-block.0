Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A038C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 00:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353519AbiFVATj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 20:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354519AbiFVATh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 20:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032B226AF6
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655857175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKNQVwaSLNSh+eD0PBRgjlzVSMR3W5YlfARMW7bhi/k=;
        b=CqxnQsrZgj/+J3Ewb9veIQKwLoVj4ng+arW2bBk1+IJuzqBfOLnb/GAw4zmLia8Jkp6Jik
        cvIXYN3uc9xFsJL67P2gAH5xzAMXGL+9LVkoFNG0x0+Tg+KePVQqnBHOLozFfmCUY+1Dr1
        baYhsoKLZjx6IlM8qn5lueuaXWUJt1w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-QizWgWEKNl-eHwgqua7n2g-1; Tue, 21 Jun 2022 20:19:34 -0400
X-MC-Unique: QizWgWEKNl-eHwgqua7n2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417261C08968;
        Wed, 22 Jun 2022 00:19:34 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B26C52166B26;
        Wed, 22 Jun 2022 00:19:31 +0000 (UTC)
Date:   Wed, 22 Jun 2022 08:19:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH ubdsrv] tgt_null: Return number of sectors read/written
Message-ID: <YrJgDO9JD/le5tKK@T590>
References: <20220621224839.76007-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621224839.76007-1-krisman@collabora.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 21, 2022 at 06:48:39PM -0400, Gabriel Krisman Bertazi wrote:
> Hi Ming,
> 
> I wrote this against your devel-v3 branch.  I'm wondering if you plan to
> send a new version of the kernel patch soon? From the latest

Yeah, that is on my todo list:

https://github.com/ming1/linux/commits/my_for-5.19-ubd-devel_v3

there has lots cleanup & improvement.

> discussions, I don't think there were major issues found on review. :)

One problem is the driver name, and Christoph thought we have
'arch/um/drivers/ubd*.c'. Not thought of one good candidate yet.

> 
> I hope people don't mind I cc'd linux-block about this userspace code.
> Please, let me know if I shouldn't do that.
> 
> -- >8 --
> 
> The number of sectors read/written is used to verify forward progress of
> the request inside the kernel.  If we return 0 here, the kernel
> understands that as an IO failure (see first check in ubd_complete_rq),
> and will reissue the request, causing an infinite loop of unfullfilled
> requests.  This can be reproduced with:
> 
>   ubdsrv/ubd add -t null -n0 -q1 -d1
>   dd if=/dev/vda of=/dev/ubdb0 count=1 bs=4k
> 
> The approach minics nullblk, which returns the total IO size.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  tgt_null.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tgt_null.c b/tgt_null.c
> index 85636c405f0c..61850a2cd046 100644
> --- a/tgt_null.c
> +++ b/tgt_null.c
> @@ -20,7 +20,9 @@ static int null_init_tgt(struct ubdsrv_tgt_info *tgt, int type, int argc,
>  static int null_handle_io_async(struct ubdsrv_queue *q, struct ubd_io *io,
>  		int tag)
>  {
> -	ubdsrv_mark_io_done(io, 0);
> +	const struct ubdsrv_io_desc *iod = ubdsrv_get_iod(q, tag);
> +
> +	ubdsrv_mark_io_done(io, iod->nr_sectors << 9);

This issue was actually fixed in master branch, and there are actually lots
of change in master:

- switch to liburing
- switch to c++, and use c++20 coroutine for ->handle_io_async()
- all kinds of cleanup

I am actually working on ubd-qcow2 with above, but that may take a while and
the code isn't posted yet. The motivation is that the whole framework can
get verified well enough with one complicated target implementation.

Thanks,
Ming

