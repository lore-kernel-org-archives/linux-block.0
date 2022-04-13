Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C05C4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 15:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiDMPfl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiDMPfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 11:35:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94439142
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 08:33:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s6so1635827qta.1
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CP/ShUgEz3hGfuLXYLYOHJuLvNzIwOaBQUi6eoZGsQ4=;
        b=UfPSrLeJ1wX9rxwivW7q8Xj1gWZnLNdObN1ay9AplmU1pV+fJ/B6aoxD/Avz3mCD05
         +iirVS6RJxrl+ViKFG62p9/VXgIWBs8by//lIsZvkCkGAIMgjnovJ5axTwjAzsMb56vG
         n2nQJVwWhkp6TC3j01ARtLrWbVcSJ8b3DxXmRvRhynyH4tgLbfR4mUazXz82jRpFBjnd
         ygFDbVKe3lVFp572WAb1v+hZXAE4yGtlMZ+SXT3OWcM5r3BKGpm+iwcQIsrev26l6YDR
         JG7blW36u7aOhU4FPi2Wbqd5RqJRQPwEY5o5Yq2KKMWFpp1wHvsQ7ONUjwweQkfuTw5D
         esqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CP/ShUgEz3hGfuLXYLYOHJuLvNzIwOaBQUi6eoZGsQ4=;
        b=ai3FOK0/oUAksAE0v7df8w3lDKsOdjtvPYHQBar0QnYMUm5bgG5hE7gWcdvRFL6oHZ
         Oqp4wP3Vv54JAboZLREe/mdRzirYM3cvLoe0ICPe7J9MBj8W+DnBfQeX+ZJFP9S4qG4a
         3m3LXC/ELGEPpY/eXeMcqNTsSMgYzZNxFVrdZKdxrS1/o1p4A5ZQpla0nocuaiMYmjMV
         xCrB5IoM93jGbveIs7tAIqemEi8AGZYcy0+5e62jrv+ROXAhaz9EA6T/1WJ3Q/gTzh11
         7NNZ8YP940oLLucNXIHCWGheF1r2ppYZoPpazWIFdyYzBsSYoxtmUVn0CWcXdoiEsguk
         9yVA==
X-Gm-Message-State: AOAM531x64SH4EtcbyJ/dYz8gK4zPe6W55t5bjNWjzpiNG42O3xiYV1a
        YjeKNMx1Ephkdj3egUV85aGnpw==
X-Google-Smtp-Source: ABdhPJyFbysCc5+lrVtBTWljqavmdMjrO2deJmL18DhfybMCpNTalRiikBHMLQ9d05crlDN+tFCHfQ==
X-Received: by 2002:ac8:5f46:0:b0:2e1:da61:9734 with SMTP id y6-20020ac85f46000000b002e1da619734mr7724566qta.205.1649863997638;
        Wed, 13 Apr 2022 08:33:17 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c091:480::1:5987])
        by smtp.gmail.com with ESMTPSA id z19-20020a05622a029300b002e1a763dac1sm29000360qtw.9.2022.04.13.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:33:17 -0700 (PDT)
Date:   Wed, 13 Apr 2022 08:33:10 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Alan Adamson <alan.adamson@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: Re: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Message-ID: <YlbtNrIZ4pEgNPeY@relinquished.localdomain>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <20220331214526.95529-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331214526.95529-2-alan.adamson@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 31, 2022 at 02:45:26PM -0700, Alan Adamson wrote:
> No matter what was passed in with nvme_trtype, the target was being
> set up with trtype as "loop".  This caused several passthru tests
> to fail when testing tcp or rdma.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>  tests/nvme/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
