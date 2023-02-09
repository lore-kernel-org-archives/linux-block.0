Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA3C64EC4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 15:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjBIPMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjBIPMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 10:12:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664F32523
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 07:12:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so3183552plg.0
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PDb/mD0FNcuvevCtgRwjkKj+UfK+Lh+rlPz9oXE0/s=;
        b=vLNKvMiy5n65JggsJYN5SAT5Mnwr2BIypMeL0NGLQkhSzBiL5FT37klJ85/bdysSYq
         8FBwnhmn6VF/Qjrf0v8i7zoC0U/DXfWvz+HwV+7lZySswUYZynnSsiWYOKr+cnMcH7iO
         BiSEQjvwvHYAVc/sQMJ1cQlBXmlqLPdFgxoYv9lV6pFF4PZXK3j+8g60qVIYNDO0cKZ/
         PPO+MJl71h/JgzU8AxTEkFguunRkIkiTQ/zhMUZ/JVpvGl0nxZFPvPahDagXs2k0vodU
         gBfh3AW2GHZiRcIZ30JYrofz5teupArrO8v5Y/eQENUprngvIV9ZbO/hYQ0B96UGacfQ
         br4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PDb/mD0FNcuvevCtgRwjkKj+UfK+Lh+rlPz9oXE0/s=;
        b=qOIFuf4mharswB0RmjU2yYQJ2s5xFH08V7kI0HY8q3pN4N0/pYB0QRmGkrEHm2M9d9
         gv1fTaCg8GL2VgNgThFKiuVQW4rJNufYsjPRjuc0CJlNHHiRqp2OOlISIK1eJ+6Owewa
         KxWqsBdh84IBGYNQAQ1fnHI4LDMt6aXGCu5bVYb1kwGOk9sUm/eELBl+xMoD0CoE6yCI
         9dbjL2Ys7lPIGtSfCh0OWe2f6R2qzAw3wNkxWJ6fu76n3DPhzu+Iwdy3gPcZwf68k/aJ
         QNo+VWnD/5UUrh+7FA2Vs/+8HwYPMECbqooLtAQDsy5Wpp/TiCX8PilnK1vQcd3PopfM
         qD2Q==
X-Gm-Message-State: AO0yUKVsXGRl5Qo3QXnqjZR0REylK7W+d4rQKvmMzVpFKfUcsl2hV4vF
        ONIu2nZXoc7Ufzn0sVH9OIrDmA==
X-Google-Smtp-Source: AK7set/Hp3peKbU9cWTP3s475Gtd1sd1IlOQINVNvjhBZ08vSzPAfn4wRTyIrfsIK67VvLsCOx9V4g==
X-Received: by 2002:a17:902:680b:b0:199:3f82:ef62 with SMTP id h11-20020a170902680b00b001993f82ef62mr7912671plk.5.1675955549810;
        Thu, 09 Feb 2023 07:12:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001991e4e0bdcsm1593336pls.233.2023.02.09.07.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:12:29 -0800 (PST)
Message-ID: <d3529d65-f505-a76a-7f3c-db1d8d2578a3@kernel.dk>
Date:   Thu, 9 Feb 2023 08:12:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y+SAN97vxJtL/l4G@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+SAN97vxJtL/l4G@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/23 10:10 PM, Christoph Hellwig wrote:
> The following changes since commit e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3:
> 
>   Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2 (2023-02-02 11:02:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-09
> 
> for you to fetch changes up to 70daa5c8f001e351af174c40ac21eb0a25600483:
> 
>   nvme-auth: mark nvme_auth_wq static (2023-02-08 07:28:16 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - fix a static checker warning for a variable introduces in the last
>    pull request (Tom Rix)

Pulled, thanks.

-- 
Jens Axboe


