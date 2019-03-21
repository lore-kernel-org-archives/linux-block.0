Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63740C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3179D218D4
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="KhSL1p2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfCUWHt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:07:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34912 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUWHt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 18:07:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so53025pfe.2
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JWlgGDPazr9x0GAZKDPiEflhcxZjjcn9Aaih/Na1+V4=;
        b=KhSL1p2FGZhBQkKQrIhnzYkyVeikv9bXKCBYGhwfAsQ4tWlWakfCcHPoys5zs46qnj
         e+12Z+Iwxid1OyB5g2JsIV+MiDqLxGoBwy1i/h9duXqNGbmsVAOiM23hTMemk7tKmE/P
         nbCtUqfvRoXPibtmHBuUR9nviqnbLZDaXHlmkaDLPXlSI1/DoUJ8sxxG8uOoTKodg33x
         gXMTqymXKL2H2YURu0X3DN0cCa8nIuitKo9dwPqasnDUEgiujqblVlxQ6/wzcL9hfsh2
         +2hjwH+mdQx/mK/8Xo8+EGPE1LjJGFE7+ebktXW0NSs3zbrDj3XetaGRj6ZTVHFo8HoM
         FuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JWlgGDPazr9x0GAZKDPiEflhcxZjjcn9Aaih/Na1+V4=;
        b=HKid4bwnpWZGYxqN8aZ4XCBSy6PMRbEOMeL/9wfNilP1+oiNnHSuOo8ownYm3GYxO3
         VlsibCeNn885ZhWkSE7FBqJF3G3m8ybnozKV76+OLA3bcndeLNCMtyor07j1p4/Pi4IT
         VuRVSW/ysgddTtMUhWsvGZYhghdEofjxxXt6F2F6atQVm5LLS3zpDghkbCp1e6yZWica
         4QCoSxe85owdE6aUX9fIlOYOhUMa+QnnnY0opzcPC67R7dSQlsFVnIfaAFbH6J5NxvVe
         FqzmGE7vTWnJVVJbU3u6JvtKt8XozQDPh4M9bAuo3CCplgpDS0zumeHz+Ka2ATWw0DKk
         N/RQ==
X-Gm-Message-State: APjAAAUNHrXTVx8PmGovUJMNHb4+0NS65iwUv/9N4g0l9FqvXGvucKc5
        PIjd5G98+0/ylBBRpeUMUnSF77yIH8o=
X-Google-Smtp-Source: APXvYqxs0Uu8rCn8+vJVtYB9wz9zPgRjqnt3/pu1nvr6qBoxAZWklGWvd1IixMdmwCDzr4w0o++A4Q==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr5800720plb.59.1553206068126;
        Thu, 21 Mar 2019 15:07:48 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:1643])
        by smtp.gmail.com with ESMTPSA id e184sm8774970pfc.143.2019.03.21.15.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 15:07:47 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:07:46 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests] zbd/006: Test revalidate during other I/O
 requests
Message-ID: <20190321220746.GB20838@vader>
References: <20190314034633.13233-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314034633.13233-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 12:46:33PM +0900, Shin'ichiro Kawasaki wrote:
> Since SCSI scanning occurs asynchronously, the kernel function
> blk_revalidate_disk_zones() called from sd_revalidate_disk() may be
> executed while write I/Os are ongoing. As a result,
> blk_revalidate_disk_zones() must not cause write I/O errors by changing
> zone related parameters of the device queue unless the disk has changed.
> This patch allows checking this behavior and catch regressions such as
> fixed by commit ccce20fc7968 ("scsi: sd_zbc: Avoid that resetting a zone
> fails sporadically").
> 
> To trigger disk revalidate, fio is executed with the --loops option
> causing the target device file to be closed and reopen at each loop. The
> file close triggers disk revalidate and fio starts issuing I/Os before
> revalidate completes, resulting in the desired simultaneous parallel
> execution of write I/Os and blk_revalidate_disk_zones().
> 
> Also move the _find_first_sequential_zone() helper function from zbd/005
> to zbd/rc and reuse it in the new test case for target zone selection.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/zbd/005     | 13 ------------
>  tests/zbd/006     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/006.out |  2 ++
>  tests/zbd/rc      | 13 ++++++++++++
>  4 files changed, 67 insertions(+), 13 deletions(-)
>  create mode 100644 tests/zbd/006
>  create mode 100644 tests/zbd/006.out

Thanks, applied.
