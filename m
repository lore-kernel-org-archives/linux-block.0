Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7612C433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF829610A5
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 13:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhJDNbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhJDN3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 09:29:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DADAC061797
        for <linux-block@vger.kernel.org>; Mon,  4 Oct 2021 05:59:18 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p80so20087149iod.10
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1MYzuDUCNQRkhVuy0PfcVG6GLgeduoGScLuIa5uErT8=;
        b=f56HXCfLtPbTMyXkgasNOIZpM9VE9ErvlkSJU41M90Lg93K1qtfoV+2PTeipmerq5I
         BOUxBp7g5OrdXlIb7yAZCRgQF9mStXX7GH2FSPsd9lMNaiuqF2wDnVmQywI1qS5en2CC
         wKYtm1GHwRsIRQbvXadR78+FIwxr52izy7QtkXvRyb2aS5TfgkTrG+vDVCTI5CayPdbb
         cJxZcpRv4Ii6xbcNDb3e68aZkrG4smMCRHdtJe7A8JHTUeEG0SOwqWiNF/hO/o0Wh+9w
         N68e+u1j9BoLqNmAcDqXtwtDDr+7JUBdw88E6FvM+CVAJI/HPErtYxN+CfCcG7NvJ7TY
         63nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1MYzuDUCNQRkhVuy0PfcVG6GLgeduoGScLuIa5uErT8=;
        b=JOL3abhLIAwvv2Yc5nRLD5pdRoZUCh6fnlzBLoxaV4aRQxcM0DPkXDAAycwYcVY09Z
         jG7T/tBvJDAI7FBDB9oGtQcjBSjURyJiHn3DwNHxuAIYIpejtlUdnmEHlEWq3j0taDWn
         swKNJsV0ifa5LTAhVHy4GgxkS2Iqizxro0W+KG0BZszvoYtuz0qCdZbBqx7ltU6X7PEH
         2JEo6X9zScyHN8TeSVYpsddo9CVWfAdpu4VO0w4BMREIUaHeMuL2iS8D98AbMKAZNX4Y
         S+HZ0luu9oe8eRtJotf67mvFl4hqFOmWLm98eLgLO274QqgBu3ubVVVIhDOwIrBdONZE
         fHgw==
X-Gm-Message-State: AOAM532guBDo6LT7Zx0WtAxkQhNDjdZdzGmC7XZ2bg/qRujXNpp7n8My
        APfiA6JN7yB14An7XoivF2DX1cxwSwZQfQ==
X-Google-Smtp-Source: ABdhPJzW06/dijqfHtgIzw1uI2SG5pPtWH6xqXYS1Wj+r9p+J1NK7OFxLVCROOgj2tjJnjEdflT4vA==
X-Received: by 2002:a6b:f301:: with SMTP id m1mr9284940ioh.3.1633352357476;
        Mon, 04 Oct 2021 05:59:17 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o11sm10505258ilu.0.2021.10.04.05.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 05:59:16 -0700 (PDT)
Subject: Re: [PATCH] block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-block@vger.kernel.org
References: <4351076388918075bd80ef07756f9d2ce63be12c.1633332053.git.johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <381376ae-35c4-43a1-251b-977740f79f57@kernel.dk>
Date:   Mon, 4 Oct 2021 06:59:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4351076388918075bd80ef07756f9d2ce63be12c.1633332053.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/21 1:22 AM, Johannes Thumshirn wrote:
> While debugging an issue we've found that $DEBUGFS/block/$disk/state
> doesn't decode QUEUE_FLAG_HCTX_ACTIVE but only displays its numerical
> value.
> 
> Add QUEUE_FLAG(HCTX_ACTIVE) to the blk_queue_flag_name array so it'll get
> decoded properly.

Applied, thanks.

We really should have some way to catch this at build time, this isn't the
first (and won't be the last) time we run into this.

-- 
Jens Axboe

