Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E974C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C155364E8C
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBJPYO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhBJPYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:06 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910CC061756
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:23:25 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n201so2226387iod.12
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WYxqkeO1q19BSemE4UNLh4F4qf/IejsMhUmOOpVc1lQ=;
        b=zdAlkKWkkq9L2ijt+GKthr1xcatmbkJEUEZuQBXqdklNBrpoSG76VZQYEhCS4afxFO
         nE19j+QRrO/f8fQ9JER3zJG1+szyiG3TKbiGSqLwDCAbKREKYqb7k8Pymv70OPsomYxm
         ao1e57PgepFcnWyQ2dHakjKXK6xU5JROyf9qCj/du7smOBGIkX31Rn2Af9vUbTOp8NLq
         WTgzgSMM3mThV9nRf3QoBuUIgVA1mmCx1L+1gl6F4pHIqtxV99FmyRUzBDyrUVCwEo6g
         U5thg29oZ0XX+VoU3x6TnCYHWqa2sECnXIHHbcHTrL63Njx5H6N7RDV+fPZxgaCk66j9
         2QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYxqkeO1q19BSemE4UNLh4F4qf/IejsMhUmOOpVc1lQ=;
        b=oDYqdTHkTX+3JJyyETU1BFIq6RvNbUG5z33Xv4mULHNfxthj+SGkW/w6XzSBifoRMh
         9SgurVVTHezL6N5dNVX9KH/Li9Dr6hKcXkGICOcDX10MXVSPxn2LjL0qxs/QA9ABu0BO
         ZzpLdkHu4eFVw74EUn5rljdkn1r8evmHOumElNhzcK+sXddM4cbW65TNM6WPO/hAdBes
         zxenIglPDiqXcsKzK1bx53ToAk3eaSXzncCZaC6X/GPvXNzAUN58am3WVpraFiLKaID8
         uRYO4RTcTSSITMvCjOJAInzdDMzWx6lpogoHFSYmPDboaYYQT8APSSB+CmwpUs9kP5VB
         RDug==
X-Gm-Message-State: AOAM5336zsD6VvJ8zZ4DFmFS6H4brR0B+9bN6LANIMLYDS0Tzngx5taa
        ahfkIGlTA/xuuQVMuOZzbSM0tfJ0vk/x6/0h
X-Google-Smtp-Source: ABdhPJyS4hEWO82zW0anCMqj5VGal45/DOG8xg5yJyd3MVc+yoDM16GjggHWY0tYRj9NmIg6FY4mjw==
X-Received: by 2002:a02:cf11:: with SMTP id q17mr3801855jar.45.1612970604693;
        Wed, 10 Feb 2021 07:23:24 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f139sm1160121ilh.60.2021.02.10.07.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:23:24 -0800 (PST)
Subject: Re: another swap/hibernate code cleanup for for-5.12/block
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <20210209171419.4003839-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dddf7281-da5b-9794-9c77-e963f5748d66@kernel.dk>
Date:   Wed, 10 Feb 2021 08:23:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209171419.4003839-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/21 10:14 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this cleans up another lose end in the swapfile.c after the previous
> bio related cleanups.
> 

Applied, thanks.

-- 
Jens Axboe

