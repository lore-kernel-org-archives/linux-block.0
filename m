Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A055EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DEC60E9B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJSTpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhJSTpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 15:45:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5425AC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:43:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kk10so780144pjb.1
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v7IXlcJ63PngQpS42PwgvrgNuKVIFj6tOFfl1reK+vk=;
        b=KcmMLBfHLVgPAFipclYGtwQoNmWLROKML+B1L4kO45NP6os0r5JGfyGyEKBxetJKBI
         8t0cMXfoaheXfRUXJXGZ+QtH68RZMenJmBmTWzOTzqQFKVvhNK076Ik61W8DR4EyAu7g
         025iuVr+maLMyd+jKyxI1dleU5I2EDQT9ebU8Yvbd/GwbUSzaz6oSlqEP8SGCcHRWj3q
         8YC8rwlsoEbGi7WxGKwrwczW+Ggbp2C9HTdxcN7RhPdsWBkc7M3XjIVU+m4hgOooFW3T
         KkDOz12rzN4e2qS+NcQab6rsVnLK/gYIoGvY9g5100dEVEfUkGXYzP3UINmBNkig1ZbL
         jLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7IXlcJ63PngQpS42PwgvrgNuKVIFj6tOFfl1reK+vk=;
        b=k4xM8R4eqZhmSeaVot+xbOa2piNTJC64Y5zgrnwGu1OfKesApKYKWVXY1uFnop5hc/
         fIPABQUCYfiINXw6EuLM8/L0hSCXabHp1UqCK76Zm5RQMKj7F/tXwnHIV6m+tSKa5HKj
         roYeyyUKKWpDwZ8gGz+Tsz3XCr8eO96zHA7sJGS/MSV4BFtYoRSQD5D7LOPvHGBHaXRP
         9ISNeRi6dpvQziYeyB00+EHgaJyOOmTpbIKGNbOgHhmel1NYggVGmwZU/K72vtBcffVo
         0dXD9beyQWNjxY6xdjm+ksT/5PGRCnkPlh6nRB1k8Xu3rtqm7My8mTlERMpfHqbTGOFE
         JL0Q==
X-Gm-Message-State: AOAM533g9Lb8eFWyzcjV01YY8NZ8ybeo/2MiXf9oLa/ePJVlTggTPkOQ
        8HeKAwhHXLUhWXRtVIEWYjnctecGd69FDQ==
X-Google-Smtp-Source: ABdhPJzBZY1tSAmyUUFkgYe2iD/o2GDjN3ZQETjGqrO9Z2pElYm20g7cIjvRQJqDNsrlBKw3uu8rpw==
X-Received: by 2002:a17:90a:df0e:: with SMTP id gp14mr2001697pjb.35.1634672597757;
        Tue, 19 Oct 2021 12:43:17 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id h2sm5454pjk.44.2021.10.19.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 12:43:17 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:43:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests V2] tests/srp: fix module loading issue during
 srp tests
Message-ID: <YW8f0x0Qx+IWUMtt@relinquished.localdomain>
References: <20211018024007.6014-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018024007.6014-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 10:40:07AM +0800, Yi Zhang wrote:
> The ib_isert/ib_srpt modules will be automatically loaded after the first
>  time rdma_rxe/siw setup, which will lead srp tests fail.
> 
> $ modprobe rdma_rxe
> $ echo eno1 >/sys/module/rdma_rxe/parameters/add
> $ lsmod | grep -E "ib_srpt|iscsi_target_mod|ib_isert"
> ib_srpt               167936  0
> ib_isert              139264  0
> iscsi_target_mod      843776  1 ib_isert
> target_core_mod      1069056  3 iscsi_target_mod,ib_srpt,ib_isert
> rdma_cm               315392  5 rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> ib_cm                 344064  2 rdma_cm,ib_srpt
> ib_core              1101824  10 rdma_cm,rdma_rxe,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_isert,rdma_ucm,ib_uverbs,ib_cm
> 
> $ ./check srp/001
> srp/001 (Create and remove LUNs)                             [failed]
>     runtime    ...  3.675s
>     --- tests/srp/001.out	2021-10-13 01:18:50.846740093 -0400
>     +++ /root/blktests/results/nodev/srp/001.out.bad	2021-10-14 03:24:18.593852208 -0400
>     @@ -1,3 +1 @@
>     -Configured SRP target driver
>     -count_luns(): 3 <> 3
>     -Passed
>     +insmod: ERROR: could not insert module /lib/modules/5.15.0-rc5.fix+/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko: File exists
> modprobe: FATAL: Module iscsi_target_mod is in use.
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/srp/rc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 7239d87..16638a4 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -497,7 +497,8 @@ start_lio_srpt() {
>  	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
>  		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
>  	fi
> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
> +	unload_module ib_srpt &&
> +		insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?

While we're here, can this just be modprobe ib_srpt instead of insmod?
