Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F416C433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0755960F5A
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 22:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhKAWZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhKAWZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 18:25:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA2C061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 15:23:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j1so10068397qtq.11
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnYnqLqd12gaQARTKVAqqyWq5HzzIA2bkgQBVsVg4s0=;
        b=gt6wFXhTP2Om3mCyDlaPZAclh5WszLcpD8FoKutfVj8kgeF1LLfIUwzLFBUYIe1Zzb
         1wZFR2yisz7vylQ/KZ2Ca9Df9MstkiyosiVMAmFpqNmIMQkvqBA+nLzzouUtMElvy+Eh
         Rbk0LDFkDyDxgzsMF1BjOwes+AihSB4ohirmWfuyQuEPhbNOYQo3ZZbJWFpSxD1bVbzT
         FS39TzcCWib50StejXPsjWz9cwjpT/8kr8xl1HOgo5uhKK4PDMfbwiLzgnBEMV/tMEiB
         61A4v1ss0uZPfPNO5JdiHRX1eLDVszL+ITaYkQuWJonGx+1xIITEZQk7hszS792brO9q
         yfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnYnqLqd12gaQARTKVAqqyWq5HzzIA2bkgQBVsVg4s0=;
        b=pemLr+oKFhTYD9m81SDxGmsXzyo6qkHJfYGNa7DBsusYLgD5wqoNz92gQRVLtVu7fJ
         aVStXmXRHT3QaKvrG8wQDV7oI++YdelPwxhP2/lEKcOaNJL0qqQNena8vhGuto/aEfLZ
         bgId7SbczAGe2nMvE9LFWrffSOZlH2cmxc94DzK+LKKK0toZwR475CO2Iru5DPSHq+iG
         Sx5/H0l3B/nG1lfrV1EF5kDVxq7Z0/JkOfOWZlmU2he1sPzsJrTtkYQcUk2ZE9rZpnry
         1OyES+LLMwop1x8QDMbbsfWnkAnNLuf5VnoRjXMZupXQQJbWLykmyXZ9Ewathehq5XhP
         lEww==
X-Gm-Message-State: AOAM5315vzvm/zL2bVs8RN+izXJkqzsU58SA/G0kZwqzcujET+X1fSyK
        F8WtgtaAaHAoB+QM4np7kfL9oA==
X-Google-Smtp-Source: ABdhPJwD/QBrvyYQQ+Lee0e7aoTE8Wb4w7Mf/o3QAWnE91gfpf4OCl5iUbc9xxSha65pB7Z2vE2heA==
X-Received: by 2002:a05:622a:105:: with SMTP id u5mr16022514qtw.163.1635805388070;
        Mon, 01 Nov 2021 15:23:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h3sm2063742qkn.73.2021.11.01.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:23:07 -0700 (PDT)
Date:   Mon, 1 Nov 2021 18:23:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] nbd: error out if socket index doesn't match in
 nbd_handle_reply()
Message-ID: <YYBoyqYaMdTWro2m@localhost.localdomain>
References: <20211101092538.1155842-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101092538.1155842-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 01, 2021 at 05:25:38PM +0800, Yu Kuai wrote:
> commit fcf3d633d8e1 ("nbd: check sock index in nbd_read_stat()") just
> add error message when socket index doesn't match. Since the request
> and reply must be transmitted over the same socket, it's ok to error
> out in such situation.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
