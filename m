Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCFBC433E6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA264FF6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhCKOsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhCKOsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 09:48:19 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E89C061574
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 06:48:19 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y20so3843256iot.4
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 06:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maBOO7WosP6+l6DmgX1UwQ0O/fVFPB0FoQ0zTurHWl0=;
        b=gkzYX/HVgLNw5Y73NEEpWWaOgrvv43GVM85kjJQhktYEGLvuWKSMQeitKJi4GvA79c
         uEAwPqS30volo6MJ32Y82V3KyeCSC38tKLQmKk3nTKxCC1msLOe22CnrwO1lSLKQfWuW
         +rkHXZL1PZAJWtQrYORJ5qcTINo25QRhKVj4QdXXRlFGnca1hnsJQLhx++Kx1lZ21esw
         A4Cuea0boeFOEdDoQqj3Dc+CC/1nhg+9e9t8ZNywLVnRJpX8Z79R3Qta55x5Y40dav64
         gnURzfdBp8oPwmOiHu7wvmqgOlBqaRAW31oCe0RbLHCEAOv39edqRPwHRR0jxCV66GI4
         1JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maBOO7WosP6+l6DmgX1UwQ0O/fVFPB0FoQ0zTurHWl0=;
        b=S6VO/VUrAuxRj0U5kJQJgv3wRVXJPzfJE9+Nf6C5w4symVvsL6FZkl+oOn3W4SAZcq
         2orXRIZ9gWzDnWmeCM+EpyT3QE4DDtsm1doyeNR56wlAgEb59WPcsCyfdHvBtCTG7bes
         ry10N7yGLoYG2UTq+qXtP3NjYlS2zL7Y2ZJDj9cgwhiowSF8G9j2g9ffnE050pyem3z/
         wX7mevNCWrFFaby1Ektr880eSDVFQAKH5lvc2R3ngUOni4tLNxO0qGNXZYQQMhnq4Pj5
         KRk9q7Pi/AHiMzJJ/zU2b5RcEUbbRIrLx8+1MlIJMx/CShG9tSLYFIsiBcTgxWWE3KFk
         HWOQ==
X-Gm-Message-State: AOAM533nb3+AZAI5ZvG8/X1MthkDpYhH+SU1Q4PipKLs4CIFwJ3ZSsKt
        hTmj07siBm9H8pKwS1wVIGbuhw==
X-Google-Smtp-Source: ABdhPJxzStox16rZ3CO9GtmiQhDbKRU1imgRkL4KjkpIy0ln8EVSoVKzKdztVsoJX+Ob1VGPT0OVvw==
X-Received: by 2002:a02:6a14:: with SMTP id l20mr4104335jac.12.1615474098636;
        Thu, 11 Mar 2021 06:48:18 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k12sm1513146ios.2.2021.03.11.06.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:48:17 -0800 (PST)
Subject: Re: rename BIO_MAX_PAGES
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210311110137.1132391-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45639533-59bd-3634-b8ba-6dea07417384@kernel.dk>
Date:   Thu, 11 Mar 2021 07:48:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311110137.1132391-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/21 4:01 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this patch renames BIO_MAX_PAGES to BIO_MAX_VECS as the old name
> has been utterly wrong for a while now.  It might be a good idea
> to get this to Linus before -rc3 to minimize any merge conflicts.

Sure, better now than carry it for the next merge window and deal
with that...

-- 
Jens Axboe

