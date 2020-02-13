Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCCDC352A3
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 03:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510A921734
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 03:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581565701;
	bh=A/sum4cN+fJFH8KTL1/k6GWb/JisYfuI1zq3xrATJs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HjG27qdycOuBlnJGn60tUMRiFIYexuPv047Ud7myAXBxjqfZA8lAdvX33sdAzN4HU
	 LIZS2BL3so9aDZS9MZwE9JXG2Ecb7FWgEZrvI7hQGv6WEFciMdYihME8WGdxHLaDiS
	 Vrkuk8hMV+wzX2TfbjlxXt2dxMh4Qvo7z5NLAY5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgBMDsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:48:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41372 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgBMDsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 22:48:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id d11so4377492qko.8
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 19:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULklmq5xuSAElXIxdRHBoIDGPBXQTHQq92zMeFakWro=;
        b=vP6betWi1xiX+AUWZpTKau8Xl43dnfwdFUURuHLyisUsw1ISJ+loyf7yQb6tnds87j
         3gu3phiIepalzGhbOCwJwZapuD/BGhC+LnzPHGM3u7OG2wHTyIMa0zMNIzbDGbEjbiWU
         Ctmvv1g82/INRm/O46mhuO9vweSAhkuo0KpSsSy5Tj5F44q27SovS8TbBKW4jokymmK/
         2dyL006PFGiJ7NAJaIAcYCLxvsDhipqGn/rQRFETaxDTcj/7kjlx8AP4KXpR+T1gCkyQ
         L5JYNK6YeJF/x+nJ1pKSfbWtWU2LJ5Z+0G3773ReeFXXkzyzcJlrLkg4Dv3vCIW2kVdV
         dNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ULklmq5xuSAElXIxdRHBoIDGPBXQTHQq92zMeFakWro=;
        b=Odkh/8IokdeX6NWfCqHZ7D5C9NF3r6KvQdQUfk33WeSHvbhO0167E5+rWFqrEuN9cE
         tX8lBoBd9xp5vuhW7PSPv47Hg8VODwmP6Fg/HXNYo8/DihE15OzxrX7ZZveYiy1yogZO
         KtsUjPiOaG4dnoH+G8qApJaFdrCJcF5gM9ntQrTyiW3wnVtys5xVk3ST1H0vUpeMm/xD
         0dn9ruRygmByMBKrMJlUi+d404nNlDOS2CB4eg+J1gR2RciOxuMOZ2jtv+8QOUcYfq5z
         gG5WJWaYgxNpN3zu9vQuVJ57kbZ9AuwEdbYQnp7kMzVUz6911A8PfRBcEFuNKTiQTN1R
         Q/WA==
X-Gm-Message-State: APjAAAWX90myw1a/LggS1xLvCZSKfUdLOwYD2ZlhDJg4C0c2ucsnCD34
        qPVNs9iMl7XzTGn7+BZ+eL0=
X-Google-Smtp-Source: APXvYqxy9hG7aBYe+AWpCOoCp2Ghxg6jkwMbFQSlNgKkZVnOO+Za36nMXTShPxj5tqo+jl6WxaQ55g==
X-Received: by 2002:a05:620a:1537:: with SMTP id n23mr5163880qkk.476.1581565699477;
        Wed, 12 Feb 2020 19:48:19 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id i4sm617417qkf.111.2020.02.12.19.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 19:48:18 -0800 (PST)
Date:   Wed, 12 Feb 2020 22:48:18 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz,
        bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200213034818.GE88887@mtj.thefacebook.com>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Feb 13, 2020 at 10:46:34AM +0800, Yufen Yu wrote:
> For each time of register, bdi_register() will try to create a new 'dev'.
> 
> bdi_register
>     bdi_register_va
>         if (bdi->dev) // if bdi->dev is not NULL, return directly
>             return 0;
>         dev = device_create_vargs()...
> 
> So, I think freeing bdi->dev until bdi itself does may be a problem
> for drivers that supported re-registration bdi, such as:

Ugh, thanks for noticing that. I guess the right thing to do is then
going full RCU. What do you think about expanding your previous patch
so that ->dev has __rcu annotation, users use the RCU accessors and
the device is destroyed asynchronously through call_rcu()?

Thanks.

-- 
tejun
