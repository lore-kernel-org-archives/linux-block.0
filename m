Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CCC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiGYUZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiGYUZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 16:25:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2D637C
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 13:25:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c24so9579449qkm.4
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQ7HI45z5wixFb+/1Im4pHzErViUmi/CF5+gTInj3AE=;
        b=oqOA072L/kD87nOMc3gKe/vkv/qvVP0z8KtLLpIDVI1nhUlt9u9vM/8Kza+NEHD8WV
         CId7cKZYxhcQywmKBqKVftF223zsI+KZQEcZ0FieRSM3rEih+WvReAub29AapTxNn5sF
         kzv+rzDScT0ARSmviIiEonye1f7pEosRNcEgKVr6yQPOB+YkNTL5DUIYNtM7hXtiz3TC
         UHpwY5pyj1pGB9YV7fD7AHA2Y16v8uIKmYp/NCSiC4VYZuOKbJLQWLz8Wywm66uCZhvw
         J+bXiJTHp5UaYiqs4ZCE1LtVegqkjCmmO/ROmd6WF3qotpciJby5fOS5elY0ik5pesBy
         ozlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQ7HI45z5wixFb+/1Im4pHzErViUmi/CF5+gTInj3AE=;
        b=glPI+YJCpVB9cxhbKX1Xxct+dtNbmoqLR+13a/Ib8LUeTRZ8g3tGWIE2yxDPSE00Vw
         zheuo+jfMHK40jOfQqA62sITPCl02WUI35aPWdfceuT+SoNEbZZkNL34fF9yhdeVR6sp
         xqipv4a0ZnFzEYRszTPrdnw/GB9Z3mLzljxnrIJ06AkR2520Hkq1gOqHumoe5RGvERM3
         rmTN57xpm1q80kye6mm6EPmOiijBq+doqC/EvZB/FfouLjUpLvNh4Y6+lr7xuII/UZsb
         AyD8tHegxGvglG8wrbh/iz+Z6bAn4TNjDOY/9XfrZwI78i4mX+FlGE4mxnrBYQl8BZwL
         c2Dg==
X-Gm-Message-State: AJIora9A2vilYUI8vvlhdYGJBSuRNLcL15M8Lk3OGUd0ESTbSS3KdYcH
        pKr7R+IElVh/C2fhnO6r8e2ds/Vb3GmIRA==
X-Google-Smtp-Source: AGRyM1uTG4HZVwBBzArzy/8u/TGwyAfj5s8K5Dg5PUsYAJUdOT12doKcBg3ssTXnOYySh4d4KA3L5w==
X-Received: by 2002:a05:620a:13b9:b0:6b5:f7a0:ff7a with SMTP id m25-20020a05620a13b900b006b5f7a0ff7amr10539094qki.298.1658780740285;
        Mon, 25 Jul 2022 13:25:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i10-20020a05622a08ca00b0031e9fa40c2esm7822025qte.27.2022.07.25.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:25:39 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:25:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     joe@perches.com, axboe@kernel.dk, yukuai3@huawei.com,
        houtao1@huawei.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2] nbd: add missing definition of pr_fmt
Message-ID: <Yt78QrEvSap5YadH@localhost.localdomain>
References: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 23, 2022 at 04:24:27PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> to define pr_fmt and use short pr_err() to output error message,
> however, the definition is missed.
> 
> This patch also remove existing "nbd:" inside pr_err().
> 
> Fixes: 1243172d5894 ("nbd: use pr_err to output error message")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
