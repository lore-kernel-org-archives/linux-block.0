Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C4C4708F
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCB2613BD
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFARRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhFARRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jun 2021 13:17:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E94C061574
        for <linux-block@vger.kernel.org>; Tue,  1 Jun 2021 10:15:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x73so4700376pfc.8
        for <linux-block@vger.kernel.org>; Tue, 01 Jun 2021 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PS7Fw0yuzJL8KYIpqXwQ7F9pknx/QEuj3QUJbyAit8s=;
        b=N4S7oVvfIHtcrA9GJhZiDa3p+B34fxhnCPyX7XMjEETQBDm8GQQFxLez00QQEWOk/8
         WDgFzjfO7DzhmmURZLg2WZSHxk7Q3Qyz0a+4CwTmh9SKQEWi4FfoQboxQGkOJ+AHJNBJ
         ngdqX8RKxuSVZA1qAsic0PEqYpG8XMfoKVxj53jvRr2vE3J3JaNvKrJA6xB6WyZ4Pghn
         lSGyf7AwKE52Hao1tlcANwjVDfEzqrSlvWtKFPGhCFwTu2oa/oBcr+W9NmyGQw9mn7DR
         PEoKc1A/Fu5eDpxV6Yjarg9DcYsXVkVRG77khIVkO+eSsVib7DnIKDEKiHSLu5X+JlJw
         lycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PS7Fw0yuzJL8KYIpqXwQ7F9pknx/QEuj3QUJbyAit8s=;
        b=nX3OGlVXIaYFavACN1kgVVU+N1mwo/ELmv56/OfQCJBsrPCJ0LR1myxxEiRulf3lz5
         Lwz2REFxe1mWo4dfMe44B1pBRiUq4s0c7ntpbCkhNYAGhnihhvJbvGCHEJr/HhRYTjhn
         78WZKT6OUrJZbvV1dv2gjz7jHV/uetoevDhx3d7hVLvABJCxa4PkxicZAeAb16gSASao
         6jKXqSAxUFhAX9FFauHwRxriUzk3Mz/HvCAiOk/IEwcMELEhfAXDmH3wXNoBaNIv730Y
         c02XBnBJzQK/xpSaWZoyMwJR6psUCRiBF52Jkn3/pIc5ZE/Q1wiMOAAo/2XaItxoO7/f
         hANA==
X-Gm-Message-State: AOAM532EbXg6LwuHw5RqZh6KKG45MY/0OPq1fF6Sovi0siNOwcyMFhpc
        HoSZwvvRaJOi4s55n97rqxwSdQ==
X-Google-Smtp-Source: ABdhPJxnKnL39OzeYxRWoVIf3YoGd6CUBDsLnsgRLKOojV89Tkij7HKru1iHa5TB+vYHlE5fsWVLvA==
X-Received: by 2002:a62:3242:0:b029:2d5:5913:7fd with SMTP id y63-20020a6232420000b02902d5591307fdmr23280453pfy.30.1622567727601;
        Tue, 01 Jun 2021 10:15:27 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:aec5])
        by smtp.gmail.com with ESMTPSA id g29sm14436618pgm.11.2021.06.01.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:15:26 -0700 (PDT)
Date:   Tue, 1 Jun 2021 10:15:24 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org, logang@deltatee.com
Subject: Re: [PATCH blktests] tests/nvme/031: add the missing steps for
 loop_dev clean up
Message-ID: <YLZrLKk0YWwR4mRq@relinquished.localdomain>
References: <20210531044621.25514-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531044621.25514-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 12:46:21PM +0800, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvme/031 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index 36263ca..7c18a64 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -49,6 +49,8 @@ test() {
>  	done
>  
>  	_remove_nvmet_port "${port}"
> +	losetup -d "$loop_dev"
> +	rm "$TMPDIR/img"
>  
>  	echo "Test complete"
>  }

Applied, thanks!
