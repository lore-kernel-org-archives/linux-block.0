Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C96EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiCaOJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiCaOJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 10:09:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0E2128C8
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 07:07:38 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c4so21465830qtx.1
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUo5kwiJz1bXcAqbqhS7EP1tVYXGo0oDgLG0Vt1y+Yw=;
        b=piasVfJJs0bqvNJ4PSZRAVyjHcXIX+f20OEUWIVbZrN66k1VJSR4dx7gqLu3aayp7Q
         270fgEB5o1cj86OnfA4+P3m/Lfik2iBL74oA9pmDfPB358bkLsO6KS1/yi5MrnrxLpqP
         2/PmwBHugQKp8Jg+9/HpgKLnulHPVq56TNbJAUJz66lV6aXiI8v31Ors3hXoU1tLa7Vr
         +vvKGo31JwJiNS8dfwtiBJbipCXMugjSYuBMb3blJcywsgXzbvPlmuO1/KMFZoshZgzN
         o43bkTuDeIplUupMKNaxvm2swmnVZJnb/pd27kwSPyjYbWW4hlXTR5xvlW+lRYXKQEJn
         /9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUo5kwiJz1bXcAqbqhS7EP1tVYXGo0oDgLG0Vt1y+Yw=;
        b=u1PJR6YfCunE1h+7NX/V0qZGwlvQfw82We2zsWGsKTfXv4V8Gn7hbWYCemseRRN3iI
         wJ6JEAby6LsYnXyLxByPIVB0tXAFBAcUpVIB1vQ6I3TyGOpl/0cJTgVG3eC1UlkGnBYd
         GfLURfNYFpx3hYNL3nxVvCDZ9lLR4vu8nEtZ8t4iXokzKcYvvWgasUtu3xAfx1KLTotD
         8B0aGkUFhEZLIIJS+FTB2G3rGo3eILBR3xXsQG4E3m54e0VSw2ZVIY9w9tZro7wxtvtq
         sfiIVv4W5ffsdkbW3G9DLhN/oMU+OK/WtB3AypWGvMIT9rC8GcTmC+5Gd6T070PMsrlA
         0kGw==
X-Gm-Message-State: AOAM532Ks+nRw5DapSZ7wbs6Fwy6AOUqlB/OSOAz4HK7GWOkuPTHHbGQ
        Pw9OybXt5YjCi4rWSle6M2yGSQ==
X-Google-Smtp-Source: ABdhPJy7PzQlsoFAhL/5nP5uePzyN9D+3lTBYWt8xfk4DVXO5W6tcsmGikWZnPr0rN62xnxYhv+yfQ==
X-Received: by 2002:ac8:5fd2:0:b0:2e1:b346:7505 with SMTP id k18-20020ac85fd2000000b002e1b3467505mr4464103qta.94.1648735657640;
        Thu, 31 Mar 2022 07:07:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85948000000b002e1cd3fa142sm20349064qtz.92.2022.03.31.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:07:36 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:07:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in
 nbd_dev_add()
Message-ID: <YkW1p4oP9mmcuwK9@localhost.localdomain>
References: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 05:32:24PM +0800, Zhang Wensheng wrote:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.
> 
> Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
> Fixes: 940c264984fd ("nbd: fix possible overflow for 'first_minor' in nbd_dev_add()")
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
