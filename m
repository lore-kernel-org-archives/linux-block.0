Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3225FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 23:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiEQXqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 19:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 19:46:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8664ECD4
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 16:46:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so590990pgl.11
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qIDtcTE4GF+Bd98SUlN4+a8vN7qNorxzRLqPxTW49SM=;
        b=5nKadTpfXno/Mt/YQ78+VOAanXukImZGYnXlPWhIfQsOUir7bl6KV9x66pAmytzYvU
         enp7Huoam4W2EjHyFH+ykjCOY36XbshO6deTQUzXkPqL8YanDeUigi2i+pfc4NkmqeA0
         UY9FrDFdhDDB0zzEbH5lBuYOcMIkFYGsJGo+tDe/Xjs1s9/3Qu05oCftS66SRigU3Ud5
         3lpYXIHt2iX2xgeNGc6jX/GNWk7U7nAY9y/igeZmWIs4qUkkz4Z0jI4R2UO2l8M0donB
         dlKodMb8+QdD9XIj7EK+bB4+2jZLEci+SBOKY1jWUB7LqpcpfjSI7ydxFjgZ6O6M69pe
         4PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qIDtcTE4GF+Bd98SUlN4+a8vN7qNorxzRLqPxTW49SM=;
        b=HIvYqAvX13uLg3tzgCAmNZ6NZFDbrRo2+zO9nimDaoqRSGFFmeKg4liTavyhPicVM3
         YBbRXUU72oHy02vm2TaF89+BPElMPyyPPxWvYU6+8ZFUHnEf4uktGxmbKg3GsJlWUclu
         3bYTtaNqFJdTmFuCC7FoUhGqZnJjOMJ5KdaeFDHi74PiPRmspr4q83d0EAygqNvkkP5C
         AQPNDcFHSQW+upyrkoLfzujlleJNtAkgIwEtBOA3XzVLhhuKgkV64vE3hS7jXX4+fxmO
         tf506k4m2q6pOfYGxjbYVoLhywIyfNxuMJRS9C1CltKVOX9HvbQ8+uyUh/tlUOtIcA9k
         /uYA==
X-Gm-Message-State: AOAM533J0GzJKzfWKUsO71QGz2d68t8wLSI1xsJ4xbxvr8Vey0xF0E14
        C0gs/d8bq1FbPuu1QmwWNHd40g==
X-Google-Smtp-Source: ABdhPJz6uagxOWHhsT2iB07Xio0TjdRe6xfVO+GkPWH2xNGbHQNn5xW2YlCFeMp/EHlEemGZgqyFFA==
X-Received: by 2002:a05:6a00:b85:b0:510:4275:2c71 with SMTP id g5-20020a056a000b8500b0051042752c71mr25161038pfj.31.1652831201855;
        Tue, 17 May 2022 16:46:41 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::e2ec])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a001bc900b0050dc7628199sm287059pfw.115.2022.05.17.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 16:46:41 -0700 (PDT)
Date:   Tue, 17 May 2022 16:46:39 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, bvanassche@acm.org
Subject: Re: [PATCH blktests] common/multipath-over-rdma: Remove unused debug
 operation
Message-ID: <YoQz36ABFpjpnHHT@relinquished.localdomain>
References: <20220517035258.43945-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517035258.43945-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 17, 2022 at 11:52:58AM +0800, Xiao Yang wrote:
> The loop ("for m in ;") will never be entered and it seems
> unnecessary to debug sereval modules during test. So I try
> to remove the debug operation.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  common/multipath-over-rdma | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index cef05ec..8b285e6 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -655,12 +655,6 @@ setup_test() {
>  		fi
>  	)
>  
> -	if [ -d /sys/kernel/debug/dynamic_debug ]; then
> -		for m in ; do
> -			echo "module $m +pmf" >/sys/kernel/debug/dynamic_debug/control
> -		done
> -	fi
> -
>  	setup_rdma || return $?
>  	start_target || return $?
>  	echo "Test setup finished" >>"$FULL"
> -- 
> 2.34.1

Thanks, applied.
