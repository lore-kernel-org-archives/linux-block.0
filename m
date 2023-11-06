Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA349C4332F
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 00:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjKFAep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Nov 2023 19:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Nov 2023 19:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206BC0
        for <linux-block@vger.kernel.org>; Sun,  5 Nov 2023 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699230840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdyE9OGU+VbT072flSIg2v5D5HKxsWBL8J2WzZYAR4M=;
        b=cI5pJMIL3VRxnnHB+09vGkePYUHpDX+omJpiE1nZBiof+Fo35kxrG2fp/kcgcwtX0UzF4k
        JjgA56AQrnlgj3mNecc2U1LvJbYIoz5hNeqBhEbHDJwrtwnMYzrv0JS9f+vgbLAzRA6GNC
        CET7n2vvMu9x+ilLgLDd5YsTPB1unqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-1agQ4pa7P-mZ63R3Fylqcw-1; Sun, 05 Nov 2023 19:33:58 -0500
X-MC-Unique: 1agQ4pa7P-mZ63R3Fylqcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14AAA185A780;
        Mon,  6 Nov 2023 00:33:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBDD02166B26;
        Mon,  6 Nov 2023 00:33:55 +0000 (UTC)
Date:   Mon, 6 Nov 2023 08:33:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] src/miniublk: fix logical block size setting
Message-ID: <ZUg0b/iv5ie2D7AU@fedora>
References: <20231104121742.178081-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104121742.178081-1-akinobu.mita@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 04, 2023 at 09:17:42PM +0900, Akinobu Mita wrote:
> The miniublk always sets the logical block size to 512 bytes when setting
> a regular file-backed loop target.
> A test fails if the regular file is on a filesystem built on a block
> device with a logical block size of 4KB.
> 
> $ cd blktests
> $ modprobe -r scsi_debug
> $ modprobe scsi_debug sector_size=4096 dev_size_mb=2048
> $ mkfs.ext4 /dev/sdX
> $ mount /dev/sdX results/
> $ ./check ublk/003
> 
> The logical block size of the ublk block device is set to 512 bytes,
> so a request that is not 4KB aligned may occur, and the miniublk will
> attempt to process it with direct IO and fail.
> 
> The original ublk program already fixed this problem by determining
> the logical block size to set based on the block device to which the
> target regular file belongs.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  src/miniublk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/miniublk.c b/src/miniublk.c
> index 1c97668..565aa60 100644
> --- a/src/miniublk.c
> +++ b/src/miniublk.c
> @@ -1440,6 +1440,8 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
>  		p.basic.physical_bs_shift = ilog2(pbs);
>  	} else if (S_ISREG(st.st_mode)) {
>  		bytes = st.st_size;
> +		p.basic.logical_bs_shift = ilog2(st.st_blksize);
> +		p.basic.physical_bs_shift = ilog2(st.st_blksize);
>  	} else {
>  		bytes = 0;
>  	}
> @@ -1512,6 +1514,8 @@ static int ublk_loop_tgt_recover(struct ublk_dev *dev)
>  			return -1;
>  	} else if (S_ISREG(st.st_mode)) {
>  		bytes = st.st_size;
> +		bs = st.st_blksize;
> +		pbs = st.st_blksize;
>  	} else {
>  		bytes = 0;

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

