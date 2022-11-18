Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECCC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 14:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbiKROsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiKROs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 09:48:29 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B565D6
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 06:48:25 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y6so3941071iof.9
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVcITqTfA54zxh/oCvajvqJSOWC9JNP1bYO7WRHqeV4=;
        b=Qu74ZOqOn6GKVY7GcuRh5r705PYSo/x2FT/b2dlQGJ008Y74TU6wY1ZXp4w4OCbIvz
         qzKUl3sCkKLFlcmaoAj+N0CLsL16krvnTvUEHOG4CDwmFA9L0HUu6PY4xMvFGT5/Huqd
         UOBj0Ya8xdutcRW0zot8LC9ch57dQzV9rBXqEL5vDL9m0Bw2eRywq965Oji6Olh2WVGj
         XxSivFzi4xwZv1fpivoPzViIxBywWbFfaB+tSdLmC7gio6YB3H+3AOBCF32DtHyZWMgp
         MRWoSKDP492kPX4LfRwMgEkSnfr78olLGg9XF9DmpAsfQWFAfVMCYPMi/11MaZ7xXLxH
         /wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVcITqTfA54zxh/oCvajvqJSOWC9JNP1bYO7WRHqeV4=;
        b=0BtMYqaNKckQ0dBNcMqA1JPFI2gVY3v80couXw/F7TM4bSSy9cOAfWouga6+FZjuFx
         7LxaIAaLJGG90VBbEEAFEZ8MzHjG+t4II5xr+dt4kEYVWkvBafU1O6HKTAL7BticvJdv
         7nDWFeb8E3Nnbj7a8QLeFRdxiGTLw6eqCmH9BgsNT71QUuulmuaYJW5hZOCYE43xDaNV
         6WXLgDEQJQBmozrQidv23P2k/jt1hjZjZ647ePrLgggEmiJzVWsmhP6ZuFGnEr0r5ixh
         s8a+SajZqCP/O4KfeUvBjrBUmb0HYkL4zep+k70HfiLf8ghElGPK/cslZHWkQ49S+kyi
         neug==
X-Gm-Message-State: ANoB5pkdYQ9WhfTg2R4Yvbhk76VIwBQFyGTzDRZmSNGeuZHrpg8sckhl
        KCCL6iVhV9+oQemVQrlRXFhYcA==
X-Google-Smtp-Source: AA0mqf7IBDSvCR5oAnITMb+Bw+FQ4OldTb0hwnyud9yl9790sGvW/UfndzhvSrYWV9V+9SKiMD5Dtg==
X-Received: by 2002:a6b:8d87:0:b0:6dd:f2f4:b335 with SMTP id p129-20020a6b8d87000000b006ddf2f4b335mr3454515iod.99.1668782905144;
        Fri, 18 Nov 2022 06:48:25 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a26-20020a027a1a000000b003495b85a3b9sm1279672jac.178.2022.11.18.06.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:48:24 -0800 (PST)
Message-ID: <8bf147c6-4d1a-5440-93c5-84d735a931ca@kernel.dk>
Date:   Fri, 18 Nov 2022 07:48:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] nvmes fixes for Linux 6.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y3d7EA+VHiylXGu+@infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y3d7EA+VHiylXGu+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/22 5:31 AM, Christoph Hellwig wrote:
> The following changes since commit d7dbd43f4a828fa1d9a8614d5b0ac40aee6375fe:
> 
>   blk-cgroup: properly pin the parent in blkcg_css_online (2022-11-14 12:13:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-18

Pulled, thanks.

-- 
Jens Axboe


