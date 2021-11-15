Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D045C433FE
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487F463259
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 22:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbhKOW1F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347024AbhKOWVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 17:21:14 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD42C02555A;
        Mon, 15 Nov 2021 13:38:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 188so15697884pgb.7;
        Mon, 15 Nov 2021 13:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPVmrbQVel0mA72if0mZWdLyJ4gRhL/uwg+URLpfYkE=;
        b=CUHZ/mHKViMS9M8ILAx4J8v1IB1bL7pb4V+2Jc/fQqJmJ4Xf2KyzHJ1t6JrYP9EFX9
         KgiVyDD6/sejqc98LZaUQ1iK0aSnCodS3sU71BRUpbUC1KcJbb+4M3GLLuhdyBBo/9Oz
         vQrfsQUWXOSrWzWc68qGSeWfhBN6LqjfasdFEhWNiUqA7fRLPyz1v1u3HyOtnYdJ1Aha
         dVmZDPZ87tS9eOLoqAIiZnj3mCS42EeEk5A66e1Ysrpd+ywUXpoCCUEiwZxtjFsbzcfD
         Pdx5nY/BzV6BlAX0QyY6IjT02XND9xS9GDq7UbLnXiPLJ1XccC4Z5rbAAzslT70i0uWv
         uXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VPVmrbQVel0mA72if0mZWdLyJ4gRhL/uwg+URLpfYkE=;
        b=plkbBnHM1tPJBg5yiHXXJ4Kxom2NIKth4bkjKNFk0byh1k472zWGjthdlfHlZsH0SJ
         YJLVWThKAlXc592TVidiDj2sWghfmafUPwmbKHsmHipw394kqoIGil2Va49WOnFVOhXg
         KFxenqMsKhtyTI+4+h5LKE4bp3EXk/zE22mrPPsm61F3J6YmPeH+l3ob0D5HQTMKgrO9
         Q4MPsoD6mc7bcqy7ObmNp/MZDpOKeHEflBVsGk6+YxmfIycUL/LoykMONfJ+VD9h+QCR
         /6QMCsF8NKFYBT7FsFVJq6AbGG2Hordn6kd4LjTx/vzm1ZITL7+RTzmgJvV9LWWqudI3
         8slQ==
X-Gm-Message-State: AOAM530T8Lg6BSQy6ZGnPTBnsnaILeyyf+xxPQkU/rINtTuJS0CvVqY3
        9by6qyHajwYND0uILFo9QeXRnvwO71vhimDT
X-Google-Smtp-Source: ABdhPJyYigmgnN+saypor+aJ9s3iqqA70d9Ql7CehyLHbL4vlGM/gb4O6Xq8thqvwWJjho7VO9jcNA==
X-Received: by 2002:a63:5c6:: with SMTP id 189mr1396152pgf.187.1637012284358;
        Mon, 15 Nov 2021 13:38:04 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f19sm10758886pgj.7.2021.11.15.13.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:38:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Nov 2021 11:38:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: drop selecting undefined BLK_RQ_IO_DATA_LEN
Message-ID: <YZLTOnv3PDmQMTKY@slm.duckdns.org>
References: <20211112093728.3237-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112093728.3237-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 12, 2021 at 10:37:28AM +0100, Lukas Bulwahn wrote:
> Commit cd006509b0a9 ("blk-iocost: account for IO size when testing
> latencies") selects the non-existing config BLK_RQ_IO_DATA_LEN in
> config BLK_CGROUP_IOCOST.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns:
> 
>   BLK_RQ_IO_DATA_LEN
>   Referencing files: block/Kconfig
> 
> Probably, this select is just some unintended left-over from an earlier
> draft version; BLK_RQ_IO_DATA_LEN was never defined in any commit in the
> repository. So, drop this dead select to an undefined config.
> 
> Fixes: cd006509b0a9 ("blk-iocost: account for IO size when testing latencies")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
