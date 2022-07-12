Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB0AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 20:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGLUIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiGLUId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 16:08:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB52AB43
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:08:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so87218pjf.2
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Lqpato/f28eA3XrWVfglz0yLW5AQKseXQr9k0rsUFA=;
        b=AOS1c0MnsFBWYlHDV3+MxRFb4d7gp80FtjneMJJL/D2A2H8UNFY0SMd83YCafnLUpe
         et/ra3hUgxEdRTj4OKLEDcRGRBiWSGrcK+q/tDN5LX+bcUcyqeluuU6LHYdHr2wg76wQ
         qSC+xtb1eYsd4b4QeXbV9tEcluq35ki7YyHS710UlKz3xd+44bfreIC+dRnZkHrC2kIo
         7dHHaOMbWGfXwsICl1pqj5Ya7hUNrjMvJjZ74qw8ImFoPxsnJIJn3JnFoefsqif7fJgP
         ngEKrL0UROOhR6GHg9oAFJPlBTqBd0PvvO0vEYgRM2TV9q2jgZrxDlGICNnAT0zfysAN
         hpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Lqpato/f28eA3XrWVfglz0yLW5AQKseXQr9k0rsUFA=;
        b=4Hc1drCajPNF5dNxM5ZaReR29pSZj6JHqYG+jJ5Cxz+40wvCWrI3DoPR0RojA8GNVQ
         YM1iwXp7tFBcHnja83Fw115kKdAOdXsNMQld5ngla5K2md+FyEdSnhGhnJap7EYs4LSp
         mBJOrOssJVDrdDiXaR02+8aOzxtlfyOV3Px8BUfUiuJdkunrjqI77Ks/Ybrt/EcO3ZsK
         AwnaVaCpowy8ZmDr4lKAJKk8IjUDXAbUmcEBA3vBgfunr8ZqTUmtwj88u/4NFXluz+U6
         BBkS7s9X+uDhXCgotg+F7ho4hqj8PwvA3/53RoBEuOk7IBtJ09yZlacj8nxZO1oqOgwj
         aIZg==
X-Gm-Message-State: AJIora9k4xeounMyHdEbq3YTQaU7VrTYolxt1R/A7+rsGZUo7bED92lK
        s7ihBO1OZ7bl5pkfBxo/LZ/Tlg==
X-Google-Smtp-Source: AGRyM1tVNec+WUDrx8OTAhKe8cXaZzH+MyRRdelXOlWxsLuJI04HBOCf5joSuyHVSN+utVixIgIYlA==
X-Received: by 2002:a17:903:1c4:b0:16c:4e45:38a3 with SMTP id e4-20020a17090301c400b0016c4e4538a3mr10888515plh.41.1657656511314;
        Tue, 12 Jul 2022 13:08:31 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d124-20020a623682000000b00528d4f647f2sm7461362pfa.91.2022.07.12.13.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:08:30 -0700 (PDT)
Message-ID: <149a582d-500b-611f-ce64-7c697ba9c0a2@kernel.dk>
Date:   Tue, 12 Jul 2022 14:08:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCHv2 1/3] block: ensure iov_iter advances for added pages
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
References: <20220712153256.2202024-1-kbusch@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220712153256.2202024-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/22 9:32 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There are cases where a bio may not accept additional pages, and the iov
> needs to advance to the last data length that was accepted. The zone
> append used to handle this correctly, but was inadvertently broken when
> the setup was made common with the normal r/w case.

Al, how do you want to handle this? I currently see you have that
block-fixes branch, but I don't see anything depending on it. I can do
one of the following with these three fixes:

1) Apply them on top of for-5.20/block
2) Apply them to a new branch off the tag I made for you

And that still leaves the question of what will happen with your
block-fixes branch. Did you want me to pull that in? Or?

-- 
Jens Axboe

