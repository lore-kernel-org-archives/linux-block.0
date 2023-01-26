Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89118C05027
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjAZSpC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjAZSol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 13:44:41 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC713C11
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 10:44:19 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so1147547ilu.8
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mawGGYl3xNzEUxiRbmjEZ0yUhhxKM/y8ziqjypj5Hbc=;
        b=CQx57DH6Eeo+qgKuXMRJqhwzCCxkOX+3HyvZpvJA7Lu0mF8EcXY014KBj3nPMgXZYg
         5r8s2uRObOhGHGCUDv4jap2+wbgGmN+feoeAwb2mYW/xle+KvOKYqevSeSEBH+CtsTsV
         /d21+ih+RrNSgiWmBLDNSNOxl4FwOcXABy2Xeu6jgExVTGuwG12Z+tOB65ag97GqMs40
         p/sv+rUIcDulF6Rg5ix5R782jNOptQV9bDTfCHXyaIIlQ7kn/IzT7l1uHNyvmorf2DTq
         jlwFcwEPyPJ5Gz0H9iN5XGOqlSeXYx3QpwO/Ly8rdwEdsHV9he9/wpnYKvgWhcX9Mj40
         Sylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mawGGYl3xNzEUxiRbmjEZ0yUhhxKM/y8ziqjypj5Hbc=;
        b=KhEcNtQHPBHEt2vNo+x7/dm62C/fUK+9lXNirDqRbDAxwhyV9rTJ4w4th/qXuV7kqk
         FwJKz/7NQw4A5YnH3GuXSfdBH+dSi/6QTZRHYLsAYa8oQknQuNbBhzeWrUP3mMOWAfVr
         /fHjfMs/8c5F4Of2e41QrZM2idtatE7HOQkbl8B9VYTXo10s23gNA5EF3OJ0hNpc+sqH
         /fJ1yuz6JQMmwWtJeCZ3qOA6E7ZAxjafCZQdxTCcjz+hG5WgpKSp2L8pJMIuwLL77vov
         PEIOlYInEJHN4rEijq0r8CyLqY71Pn6gmUu9YFD+sO86mZzXXnQt79X7zdd3m98ac8g0
         zvlQ==
X-Gm-Message-State: AFqh2konCRyqo9+yHRQFjfWHk2qgVvTH4f408eNf7NOwAp8ACu6nsgTA
        RzEcKvhKHdD47hFqq7XCHMPCKw==
X-Google-Smtp-Source: AMrXdXvrxP1Mfi9c66OovR6VnwlvB8hiVUCItG1eLAdItfplPqowUFYgb9MaB10+ckqksUQ+yOFRig==
X-Received: by 2002:a92:cda4:0:b0:30d:bf1a:b174 with SMTP id g4-20020a92cda4000000b0030dbf1ab174mr7145796ild.1.1674758658715;
        Thu, 26 Jan 2023 10:44:18 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u15-20020a02aa8f000000b00385f2a30781sm195589jai.72.2023.01.26.10.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:44:18 -0800 (PST)
Message-ID: <6bea4ea1-9dac-6d74-c3b8-54982fd3de66@kernel.dk>
Date:   Thu, 26 Jan 2023 11:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y9K6fTTrhXSWkVeZ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9K6fTTrhXSWkVeZ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/23 10:38 AM, Christoph Hellwig wrote:
> The following changes since commit 955bc12299b17aa60325e1748336e1fd1e664ed0:
> 
>   Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2 (2023-01-20 08:08:29 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-26
> 
> for you to fetch changes up to 85eee6341abb81ac6a35062ffd5c3029eb53be6b:
> 
>   nvme: fix passthrough csi check (2023-01-25 07:09:38 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - flush initial scan_work for async probe (Keith Busch)
>  - fix passthrough csi check (Keith Busch)
>  - fix nvme-fc initialization order (Ross Lagerwall)

Pulled, thanks.

-- 
Jens Axboe


