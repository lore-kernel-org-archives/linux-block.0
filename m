Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F3C5518A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746F7206CD
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVVm4k47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVHJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVHJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:09:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C20C03C1A6;
        Wed, 22 Apr 2020 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6CVFGqxG/v/g0amb7iSB8Lo9w38X6pIJaoEOXJitxb8=; b=gVVm4k47Cvu1PFJgzjX/SkUM/m
        mvRKEQwrpXa1IE/gVbfgEUWuuszxNoovUJu15JMZgWzrCRfyN73Fck5PoKuWjMhziZZJeZtmIhaxY
        D4ZhMQ9oFzhcYu4spFvEIFFTkOs8zS+lEk0iXcaFNb8clfGgk5iiWttuKWRtrkvh1jjpWOLOnOCkM
        skr5o8kmUWltstkREV5B7RnSndEOMVodXnR3iEuodtYEgGoi/pDdLYb3jAP8o/MfPyhVf1naK9xc6
        xttmP0m9qaXteU7GTEV2zMI4AMmS5+utVZfYJ/Djtjz51ZCC0wEZL2ca7Xd088t1j/QscM3h18l9J
        HDXefL4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9VZ-0001HQ-MH; Wed, 22 Apr 2020 07:09:21 +0000
Date:   Wed, 22 Apr 2020 00:09:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Message-ID: <20200422070921.GA19116@infradead.org>
References: <20200421125722.58959-1-efremov@linux.com>
 <20200421125722.58959-4-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421125722.58959-4-efremov@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 03:57:22PM +0300, Denis Efremov wrote:
> UBSAN: array-index-out-of-bounds in drivers/block/floppy.c:1521:45
> index 16 is out of range for type 'unsigned char [16]'
> Call Trace:
> ...
>  setup_rw_floppy+0x5c3/0x7f0
>  floppy_ready+0x2be/0x13b0
>  process_one_work+0x2c1/0x5d0
>  worker_thread+0x56/0x5e0
>  kthread+0x122/0x170
>  ret_from_fork+0x35/0x40
> 
> >From include/uapi/linux/fd.h:
> struct floppy_raw_cmd {
> 	...
> 	unsigned char cmd_count;
> 	unsigned char cmd[16];
> 	unsigned char reply_count;
> 	unsigned char reply[16];
> 	...
> }
> 
> This out-of-bounds access is intentional. The command in struct
> floppy_raw_cmd may take up the space initially intended for the reply
> and the reply count. It is needed for long 82078 commands such as
> RESTORE, which takes 17 command bytes. Initial cmd size is not enough
> and since struct setup_rw_floppy is a part of uapi we check that
> cmd_count is in [0:16+1+16] in raw_cmd_copyin().
> 
> The patch replaces array subscript with pointer arithetic to suppress
> UBSAN warning.

Urghh.  I think the better way would be to use a union that creates
a larger cmd field, or something like:

struct floppy_raw_cmd {
	...
	u8 buf[34];

#define BUF_CMD_COUNT	0
#define BUF_CMD		1
#define BUF_REPLY_COUNT	17
#define BUF_REPLY	18

and use addressing based on that.
