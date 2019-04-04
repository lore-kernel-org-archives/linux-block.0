Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58792C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C917206C0
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="zk5u5rw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfDDSK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:10:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39589 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDSK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 14:10:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so1548616plb.6
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUzfBQhyk+Fkl+/tWLRUMMxy9LuyArSyJfsu+VSZcpM=;
        b=zk5u5rw098Mj2lf1n8vI5dDl3GnvPUyYbH/s0XRHypR+8zk26rPQcr1sPoj8xiQpPs
         Cr9nC3VewdstPvKTDjgHCjRRTSp8WIJyEN8SgUHY7oruASl8PAt3eaApSMgsQj5UeK0W
         Iqn5CMmHIr7i0qTsfdv2xQGlsEOMPkhiVSXWITGsnnRXDDgj5vBFjCBgnKtGxEUHhOES
         3pXgX627XNFgaZv1cwc2O2HSOMkV6G8YDxHK+yAa84Tld5f++5j4A37rovy4rZDOuAlr
         4VU+fJ0G8kUDrMn+LtgjdyPCpuaXW2F01lR+dHU+vayttfOEh6gmYc0q0oplbEBR7vVq
         GRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUzfBQhyk+Fkl+/tWLRUMMxy9LuyArSyJfsu+VSZcpM=;
        b=XHCQvnPYDmGg6TGTxvodFwKZ9vcrn/GvITYlFaQV2WOPueYi/lFZsT9b1Y4I9sQX+w
         bhVeW5sxcZKY051pok6cFvfbH28gnoiZFR64RX6aUilubvgoL1nycwZjq8Hn9Os4C//D
         3rpWF6ZI+MAeytINXkKqQwWX9Y6KqX3ZFEjR7lf5uWtdtkE55hWO3vmFYqpZDSSz0iY1
         +Xa4ttrFtVx/wpVPWo74oXNbA+siSJKY24Po7A7PRchp7KivgeXB6CH9LqyRmylLCkhM
         0MX1di1Vxnb6Aj6iLCgqvtoSFJg+hFep/h7Nb4oCGvti7aDJRTWkenUttdtcY+k7svRq
         rtgA==
X-Gm-Message-State: APjAAAUYGZ0rX2cQS2RD75ND27FBNCb0KNlcGFjEKwc/C3dUwtHNRvY6
        cjYvOiRIFaQL/nch8DdDjiwmuw==
X-Google-Smtp-Source: APXvYqwckbTKDP9A+daX47m9f1ZwXKoq0YXjC4bxijs+ywoIHNSNVyCyk6CC5RZ7EpddILKGHg4JFA==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr7937864pls.136.1554401457171;
        Thu, 04 Apr 2019 11:10:57 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::3f62])
        by smtp.gmail.com with ESMTPSA id v6sm24382919pgv.92.2019.04.04.11.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 11:10:56 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:10:55 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Liang <xiliang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests] block/020: dynamically change iodepth if test
 aio-nr lager than aio-max-nr
Message-ID: <20190404181055.GB25741@vader>
References: <20190401033800.6032-1-xiliang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401033800.6032-1-xiliang@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 11:38:00AM +0800, Xiao Liang wrote:
> When system has large count of cpus(eg. 96), the test failed as aio-nr over
> aio-max-nr limitation.
> 
> This patch continues to use 1024 as default iodepth, but change it if
> iodepth*$(nproc) > aio-max-nr.
> 
> Signed-off-by: Xiao Liang <xiliang@redhat.com>
> ---
>  tests/block/020 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/block/020 b/tests/block/020
> index 39dde66..f03c131 100755
> --- a/tests/block/020
> +++ b/tests/block/020
> @@ -29,10 +29,16 @@ test() {
>  	# shellcheck disable=SC2207
>  	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
>  
> +	aio_max_nr=$(cat /proc/sys/fs/aio-max-nr)
> +	max_iodepth=$(($aio_max_nr/$(nproc)))
> +	iodepth=1024
> +	if (( $iodepth > $max_iodepth )); then
> +		iodepth=$max_iodepth
> +	fi

This has a few shellcheck errors:

tests/block/020:33:17: note: $/${} is unnecessary on arithmetic variables. [SC2004]
tests/block/020:35:8: note: $/${} is unnecessary on arithmetic variables. [SC2004]
tests/block/020:35:19: note: $/${} is unnecessary on arithmetic variables. [SC2004]

Can you please address those and resend?

Thanks!
