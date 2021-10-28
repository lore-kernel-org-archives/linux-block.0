Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C0C433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAD86108F
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1OhI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhJ1OhI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 10:37:08 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44996C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 07:34:41 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i14so8309311ioa.13
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=StzVdKGodmqbJDIBUR9DWwgevNhH96RBF+XBEeSZ+Sc=;
        b=3RsmBvVPdTBjYaF+2TyhLfAVi99JBUcFXoqh52NzCZE0+LzxkN+oglT3A++0MeDz9Z
         Wj2QIBdmUIrh2DOmyEEw4jUmP70Oop6a1A2suFabE+V9NNuPWEMYZ6ZVegvBspGmRQgt
         PZ9ZQ/GL1+tIr9Yn68q4QNJ+rLCsFU9zgArB3SPyzLrc3+iKbxBRLpR+ckt0PNWwZyEH
         UibLIHuRNTMK68sU0xGy0c8EBhTKRG4G2fQbcagqAfXMPsZpO9ScFntcSoz+iIDGfo1u
         GSed7G/kjt2wg6on6xCeSTnLf55QVhMCnhej3DxIyFSNqzH9ZssK4B2VeDiNa2uEjVXK
         puOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=StzVdKGodmqbJDIBUR9DWwgevNhH96RBF+XBEeSZ+Sc=;
        b=LJZI1D4DAZa9BDmfKkYZT1j42perqgaHV4JCDGg7V095Y7Sy2/hYtGlP7P72XD0rcB
         vJSJzaiOsrfuowR/XrzHIB9MXhCvSYyKQW86LOwBhqU0cj4u71w0MM3TPwJKtgPe0Npz
         8pvK6/2cEDONTSA6PZfeGrj7qaGWx5jU6vJdJWte6Fbltjc30zAYhh9qs/OnvfqRAEkM
         GUDl2fKXVGv8BRsg+Ddts4MikpBiV7fXhBJX2rIhsxzyCWayZdEi06hW3y+xzpSA2A95
         GwB9tNcY8QNgjS0fDAmqz4ivC0P600/fqlVa9+Leai1OrUfkOndpO+PA6bXvVaXGgtf5
         NRNg==
X-Gm-Message-State: AOAM5316EhLra4fRFm9HMGkCxY6fAH2Rm4JT2/Z9TFQeZwIMxr43mCn3
        Wezc+MWP0gT8QJRN9a0oJJSyvA==
X-Google-Smtp-Source: ABdhPJypv9niIA/4OLY+bTE84uanziUPjfRe2C4Q0c12WIcsYwYvgYh1C80AtEYMNh+2DRR4SSDl2w==
X-Received: by 2002:a05:6602:1487:: with SMTP id a7mr3396502iow.203.1635431680546;
        Thu, 28 Oct 2021 07:34:40 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y5sm1751855ilv.5.2021.10.28.07.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 07:34:40 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YXqyyRRUV4GJis4I@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf58cc3d-a919-df7a-86e3-3b183fc4ff58@kernel.dk>
Date:   Thu, 28 Oct 2021 08:34:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXqyyRRUV4GJis4I@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 8:25 AM, Christoph Hellwig wrote:
> The following changes since commit 9fbfabfda25d8774c5a08634fdd2da000a924890:
> 
>   block: fix incorrect references to disk objects (2021-10-18 11:20:38 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-28

Pulled, thanks.

-- 
Jens Axboe

