Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B667C54FCE
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 01:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239242073C
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 01:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JnWILv2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCYB5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 21:57:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34397 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCYB5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 21:57:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so272955pfj.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 18:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TKJZ2EyBquqQdCJAnm1fCNBjZhc0RxxaKIcaLb96M+M=;
        b=JnWILv2XSxfFTkMsH5mZuj5NnVozL/ZKc+7f71oIWMRPfGsIeYA6zZgC/ezMw2wCag
         BaXewB8VnN8AHgS1++FR3sZ0C/zRnOvO3pHr/ZM4hg265WD36bc+Clu5qHukst6kDcb/
         zrVg+VC77vF9xCktekjV2CYj3dAd7pzCCZBIWiUrUyh19nGev9kwBCsF741mEuy5kryn
         JNvU2oUn5LnmxJCwy5XgU72yvb3HLRv4Ix1gpjW2ekYmP5Hilis0pO/OrhDtgo2n2ChV
         rNM9sR1fHMNE93JXPR+UHckPvgXWA4ILqBI7ih+rmGyiFsgmTaIpY6ZUuff9BkL9B9ax
         5qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKJZ2EyBquqQdCJAnm1fCNBjZhc0RxxaKIcaLb96M+M=;
        b=BlQEL4q4a9Q4f74XILs77efOd3swmbJJ8Dv+/R37jBi9wb+EFiAC5azVtTuJaIXdw+
         4wQJL4VgHKu6+wW6E3C21ySxQS7XjlMGo5cMOrOk+6WY7lf0+rHffPnCEeaPnODS+qUo
         5PiN1MbGATpsLWxIEtOdgxR/QORrVNvCOE55hqUoLMQwm5V0dC2rLJNEyCtyNEx5ao/5
         aMxBsClxp4l4TdIS+l7D6kDxrMPDy5+UAWYL0kKaDLVidHm/aXSawG/bbyVemaEw/v8N
         hVwOCQJwNhcUuaLzlJMYx6kwYG1DCALZ+a3y5oBI4wdBakgztjrHt3V8QwwmscI4vkgD
         NNeg==
X-Gm-Message-State: ANhLgQ0vexuJMYmGDIUu4HxX120vODUz18KCQLVmG4Aote63mfx2Xb/k
        PkuwH5okFJZSEqIgVHFgH28epw==
X-Google-Smtp-Source: ADFU+vtMD0QarqHpIYqdQGPD9iq0GlbQ+BMyJgFUmsWmIJRUUXJs+yNdZUVjO/GzZZMZssOCOFj7Iw==
X-Received: by 2002:a63:f002:: with SMTP id k2mr747467pgh.14.1585101451389;
        Tue, 24 Mar 2020 18:57:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y9sm13323532pfo.135.2020.03.24.18.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 18:57:30 -0700 (PDT)
Subject: Re: [PATCH 1/1] bcache: remove dupplicated declaration from btree.h
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
References: <20200325013057.114340-1-colyli@suse.de>
 <20200325013057.114340-2-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6577c33f-5e57-f34a-8bbc-a4c17e124e11@kernel.dk>
Date:   Tue, 24 Mar 2020 19:57:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325013057.114340-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/20 7:30 PM, Coly Li wrote:
> Commit ab544165dc2d ("bcache: move macro btree() and btree_root()
> into btree.h") makes two duplicated declaration into btree.h,
> 	typedef int (btree_map_keys_fn)();
> 	int bch_btree_map_keys();
> 
> The kbuild test robot <lkp@intel.com> detects and reports this
> problem and this patch fixes it by removing the duplicated ones.
> 
> Fixes: ab544165dc2d ("bcache: move macro btree() and btree_root() into btree.h")

Applied, but I fixed up the commit sha, not sure where yours is from?

-- 
Jens Axboe

