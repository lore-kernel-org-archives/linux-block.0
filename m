Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC4C43334
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiFYQ7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFYQ7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 12:59:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128C1581C
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 09:59:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g186so5234769pgc.1
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5n9b9moDbqljRj9kvQX7qhYgh+0pii4Py2IK3zMO58Q=;
        b=XzvRzakJXRYQZX8QkrA/Kx1xy/ONHkwgjIDx+O97k9TCTw5f/MOi0SXpPjcuyE+kxy
         5hb86vs53b8scNOxGfcI7pI3IF0/LkYuST7RE8t5lBJKROuzRpYQMLotGwr2V6fdEbyA
         jIq8stNOA1QFaXrFSF3s8ZH6Oy62qavozYlLG/AWa9eC7tXL+JLyniRrLyeNDaCtR4bS
         zG4g2pt8irHqzlshE6jnj+Y0tnySEGeInGoB1Q5JiUBB0z7PEvhPzYsUoEfj0d7gFiBZ
         blZLwcbZqQdjSp11YdOv9fsXX4+9EWg87qn5ihiY4L+teS/INZnVhP9gou5ApPzQxR0j
         i7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5n9b9moDbqljRj9kvQX7qhYgh+0pii4Py2IK3zMO58Q=;
        b=J+Tax2isesrS34ZB3xG4x+2wptkIAs6klnqSKFtaq9H3E6j/rFi2+At5mMKd3hUjZi
         Fh56G3gp3jFQhcWbGud1XxTWg8W1ZRcNM9KJQh7/6rTZcgjCzYA/sBU+XGersCaCnxIX
         5EVGuKJfCy5YbwZlovQmnauUmrw9H69Nl8+2/p0xVuU29XFO2wSpS9CfN/RocT5Wn9ru
         ERn+TR0CmX6PhHaclOilTeF8wRW0GEWD8ue+ZHnW5CoIdVjnMDCqPzR2M6hB3d02GYBq
         LdKw1iy+0CAQo5dQ9+bP7Af6wC97J8YqApCwlSC2sNsN/KbNkb6AViQ5nUXiXeJgDsNF
         8Zmg==
X-Gm-Message-State: AJIora93OVtX+VucqNEKGsJegkVcBSHHzDtrQQo5jJiaAIUbSPOeq1sP
        TkR8twcwnS0B3eIWKSfJhyeeKA==
X-Google-Smtp-Source: AGRyM1vJ4KevW8A3IUQjaIW2xTcG2zotUtlZLa90K5/1vUOKScWXZ9L2XVgPTwxHhN+H2sw1h5dwgQ==
X-Received: by 2002:a63:6b08:0:b0:3fd:1b8e:3932 with SMTP id g8-20020a636b08000000b003fd1b8e3932mr4345566pgc.552.1656176371452;
        Sat, 25 Jun 2022 09:59:31 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bu5-20020a056a00410500b0052521fd6caesm3835774pfb.111.2022.06.25.09.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 09:59:30 -0700 (PDT)
Message-ID: <b80206fa-21b7-448a-0586-c5b17f737bfb@kernel.dk>
Date:   Sat, 25 Jun 2022 10:59:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lib/sbitmap: Fix invalid loop in
 __sbitmap_queue_get_batch()
Content-Language: en-US
To:     wuchi <wuchi.zero@gmail.com>, mwilck@suse.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220605145835.26916-1-wuchi.zero@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220605145835.26916-1-wuchi.zero@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/22 8:58 AM, wuchi wrote:
> 1. Getting next index before continue branch.
> 2. Checking free bits when setting the target bits. Otherwise,
> it may reuse the busying bits.

Applied with:

Fixes: 9672b0d43782 ("sbitmap: add __sbitmap_queue_get_batch()")

added as well.

-- 
Jens Axboe

