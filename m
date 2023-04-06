Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1AC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjDFGnc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjDFGnb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:43:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C1659A
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:43:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o2so36682745plg.4
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680763409; x=1683355409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCoUQn6xPK/eoImnOnY6ingDvjUkNas+YUDcrVabC18=;
        b=ZkpcmuiJp6l1U3u1xAbSoLGQX1qLrG+XuI1g9j115IJYCIdQQifkiED7DV1cloWnDZ
         PmMApHZuK9ub1JrmDjoXpc/wEKFWKcSm3Y+EIF6jCcHKTrdLH8HPC3mRxpLMWI73gIGU
         pfs1hA6KmP/O9HaS5x8yKPy1hM2gQvD/WSW7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763409; x=1683355409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCoUQn6xPK/eoImnOnY6ingDvjUkNas+YUDcrVabC18=;
        b=TcUJJI7LG4Tamrj2oto1rc1lgXsGWFFBMdWaZAl4y581s8378fl32tbmSJiW2fIRwn
         h8C3EZObXoc1GmdMZESYykefGA2ZSuV4dcG0dnyRL1KWFTDXUbhPRkgWX5Azbp3kFM6X
         QNABbFBu5cSV0rlOxrzIiJdoyJs8PSqPwnNKU6c5un7d6ydbTXlY+4fRats++DrkSWqV
         Uxagsxl0yw+8GVOLWA2ZHxaAIzQdlrYeQTpZ3aWnCgAjz9tZv4+qL8IzMyZ7rXfgQ/hQ
         +n0pPZZl9hjP1og8pjx7cucrRTiK2H8AYKGv5cRgiQGCZnNkEjDd+gHQ+Xp1aWeUdKZ0
         qYCQ==
X-Gm-Message-State: AAQBX9cS+KQgR6NdFyRVS/M3TE5HleeGmqBbuaGTXVAMQa4QExuGTAUn
        Q2NGUBfC7ory8PVSm5tO5zK5UgFIFd+srwagNDc=
X-Google-Smtp-Source: AKy350aDGHVoSBy/aZQU1L5EUAf6N/ZgMYRiVzUereAkA+lSj7NrZCyEEypepC6CAfKx+ytM0gzZSQ==
X-Received: by 2002:a17:90b:4f83:b0:23f:9445:318e with SMTP id qe3-20020a17090b4f8300b0023f9445318emr5358300pjb.3.1680763409542;
        Wed, 05 Apr 2023 23:43:29 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902b78300b001a19d4592e1sm593588pls.282.2023.04.05.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:43:29 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:43:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: zram I/O path cleanups and fixups
Message-ID: <20230406064325.GI10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> I don't actually have a large PAGE_SIZE system to test that path on.

Likewise. Don't have a large PAGE_SIZE system, so tested on a 4k x86_64.
