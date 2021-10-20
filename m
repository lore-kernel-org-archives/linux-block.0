Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0836D61130
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTVmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 17:42:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5EC06161C;
        Wed, 20 Oct 2021 14:40:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so1528845pji.5;
        Wed, 20 Oct 2021 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+U+qx2DmYy6H2PYd1fdMoUt/wmgM7crfDdLGVqb55g=;
        b=I0uIxbByd7kLim0jPeqHP2LJ7SZjzOFo+or47RzRA3WfPk76GEOWMySNE23ht4Vxxc
         8FS+uMpXf6s1zmYY0gIE3j25TdKfj1km6ZfeLRWVwjdwp6/uRoSSabrc2PHguRoWFEA5
         u/uE9xhXIQxM8UPpLVV5T1YBvSt6n2iMEp6OpHm2cuUbM+vE3l4bwpLrhGQNyrsodSTr
         wvJkheGZRAIWKyPyoIMAySRG36X4lbTw/4m3cd1US2SYrFpP/yyLew/C581q9Q+clUov
         iQIElIeyge9VzyDgxQY5UnBog4qxbhnEuuWN33c71034jthLTrzKKU/xvgLHR8zi66dM
         K1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m+U+qx2DmYy6H2PYd1fdMoUt/wmgM7crfDdLGVqb55g=;
        b=57duzi/RokwzSzdOWR9qsdLSxV5nKwIkThlG5XI4N6iXE+ftjL1xpdPah3hTJumckg
         dwZn43y8Y4uInf9Bq69Er4jEtpk5XuLzKL5bo0cPP06YFkXmhCybHZo1x2V42i+QcUzj
         5HxP8yhuy+yF4ZLKwyGAYoeHWxerGNYHmb5IIaYWgkppTZA6vWKiwcY0WHMU/mwIUFf7
         LHk2+Cp0A1MBbEyxM5WJyb7snadQLV64iWvFaON2dTtL/geAXAB/3J0mwAIHZifmIcLX
         UNtpFtDaA8Q58m0FcOFvoqzy4IBUucRlmWryex6iYNBJb1nD8lgd1lEMJjMdYlBZo5sy
         PCWA==
X-Gm-Message-State: AOAM530TXXjApuP58iwsmZNUcr9idO8IRXHyAe2fVoqB0PuhMzhoyGND
        jDv8woNDPflr029QrL09QJc=
X-Google-Smtp-Source: ABdhPJyqIpzCjJABrYQAikx/aFdhvb612CSkcH2YE4u7Yy5p1dfOZnlUN3KXIstOoDcOgLFhswipdA==
X-Received: by 2002:a17:90b:23c8:: with SMTP id md8mr1757542pjb.210.1634766007878;
        Wed, 20 Oct 2021 14:40:07 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:76a7:9120:26bd:95ad])
        by smtp.gmail.com with ESMTPSA id p13sm6772932pjb.44.2021.10.20.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:40:07 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 20 Oct 2021 14:40:05 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] zram: fix two races and one zram leak
Message-ID: <YXCMtRVXrGOec6OR@google.com>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020015548.2374568-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 09:55:44AM +0800, Ming Lei wrote:
> Hello,
> 
> Fixes three issues reported by Luis Chamberlain with one simpler approach:
> 
> - race between between zram_reset_device() and disksize_store() (1/4)
> 
> - zram leak during unloading module, which is one race between resetting
> and removing device (2/4)
> 
> - race between zram_remove and disksize_store (3/4)
> 
> Also replace replace fsync_bdev with sync_blockdev since no one opens
> it.(4/4)
> 
> V2:
> 	- take another approach to avoid failing of zram_remove()
> 	- add patch to address race between zram_reset_device() and
> 	  disksize_store()
> 

Thanks for breaking the problems down, Ming.

To me, the whole patchset looks good to me since each patch solves
the problem step by step and finally fix.

Luis, do you have any concern of this patchset to solve the cpuhp
problem? (Sorry in advance if I miss some concerns if you raised
in different thread. I'm totally lost).

> 
> Ming Lei (4):
>   zram: fix race between zram_reset_device() and disksize_store()
>   zram: don't fail to remove zram during unloading module
>   zram: avoid race between zram_remove and disksize_store
>   zram: replace fsync_bdev with sync_blockdev
> 
>  drivers/block/zram/zram_drv.c | 39 ++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> -- 
> 2.31.1
> 
