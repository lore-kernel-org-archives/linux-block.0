Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA8C433FE
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A8860FC1
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 14:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhJ2Ogo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ2Ogo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 10:36:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8BC061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 07:34:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h4so8639464qth.5
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XiM+B9qyPSJmz+1nGIcnoNS9xSSaJAUzee605rT86OM=;
        b=X34VJuP893dPnyKj7tKDZS5M8bu1vj5GUEbKqC0ehlOgup3it/mOc80zNH2MD7O5sv
         L6Sok1uA+G0ndCy/c83EQ25tJbqOJtJ+sWgYAEywCf+ODAJyahVsmS1V9Ya1uXi6P4dC
         9ROX96pWoQaIrPqYl17HUBgUBvM5U/qqKvGfg1uly5yQsv70bZo4C2jIj4glbnGDmot4
         XOyoyqzgMiMF+keg6zrOiKfwYEMBxCG4F8wVzYK93GabPXiPZC8vp3jOzx1lhuqgzlGz
         fh+Z0QQ0bvFp5KF/7DTgS5aG0LV3rQOI6ktMEFTXGWZr7W5Yff2fvK/rCTo9VS+bjGL3
         gMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XiM+B9qyPSJmz+1nGIcnoNS9xSSaJAUzee605rT86OM=;
        b=N9fvg3JsSBaLyheVSCmEVjVBxaAuPUAPVnIsVH6dcjklq3Fp/jMSha3HYlI+LHRZKG
         LiK+0HaLUh29seWq0JKZkJEEvxP1tJBq1eNuEIjiIQIm3AOzFlQwJbQSUj9G53OtX/VM
         ETfkS+cBaE5U5PZlYmFkc1YPPO+PubKSnjfE+fgNgdaN3DyEX+Zv4tbGlEDTTDMjs3Qs
         gLFv8b8Qn9vtRyXNUx09Hb2+1VDmIrkXsGSfH9/YYeXCuTuWqHuO81aomdv5Mj7oP2ZP
         QjCg4OhQCjRQIfyO7XGwiSrI99oaWlAhpUuQR2tPKY9FYf11yAWsJhpeOobrTBSYki/2
         sHAg==
X-Gm-Message-State: AOAM532Upv6nE8B0Mpgo+ZeCq7kAKXyrQWPhwxNJCUoP7PbeTme1kCtB
        6nE3b5xmfTF1ifWNEu9+OVGwwA==
X-Google-Smtp-Source: ABdhPJwT0NumwZK7MrMRroChOnTroI0bTN/bQxliWUiDYlevjctMF4EdTbVW+0hQZXtexw4bI8eU1g==
X-Received: by 2002:a05:622a:28e:: with SMTP id z14mr12014795qtw.24.1635518054536;
        Fri, 29 Oct 2021 07:34:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a15sm3925121qkp.17.2021.10.29.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 07:34:14 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:34:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] nbd: Fix incorrect error handle when
 first_minor big than '0xff' in nbd_dev_add
Message-ID: <YXwGZL+VIRhKwEgi@localhost.localdomain>
References: <20211029094228.1853434-1-yebin10@huawei.com>
 <20211029094228.1853434-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029094228.1853434-2-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 29, 2021 at 05:42:27PM +0800, Ye Bin wrote:
> If first_minor big than '0xff' goto out_free_idr label, this will miss
> cleanup disk.
> 
> Fixes: b1a811633f73 ("block: nbd: add sanity check for first_minor")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
