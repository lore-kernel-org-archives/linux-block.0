Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286BC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180A222CA2
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAYEgw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAYEgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 23:36:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91177C061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:36:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id kx7so7600433pjb.2
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eqqx1gni4Q4abmvsdVexzq6eMIJu3GVUnZLPq6wIbFo=;
        b=Y2TplnQ9iYj65TLPlSyyE6QipJSeTh2Pj+iCGthqP1bCGfCKPVAXQAZtssww6b4Uu4
         q55bCtBN04czu06KWVLIatzqCSavXLUQE7opvY/k4XIZQsJ0WoKOcZr1nYAuVXgyJbpq
         BIxlEAXuvk2UEBjGsc6o2kqx3qI5ByWXhUTuMGMHIQ/i0C60O157mzLjGnpmB9cFtvin
         iTsfY3lnwB/Z3hGYYPBV655TnZmENYxmnV+oC1Tw308HNRnNknu3RZKzJfTSi+Zu0swT
         hDgqgluDTyHRKyB0QR4EAHSjr+6uGIPtcvea6btppiItIs0UaN9KeKfc/C+82q6Ncm+P
         uM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eqqx1gni4Q4abmvsdVexzq6eMIJu3GVUnZLPq6wIbFo=;
        b=siEQt7WtfUITfL2BARNetIjSY/ihY23m3+pA8xUSFvPGI33BFS650WW9KAJ/QvpOMF
         E53pHgN3OtUIMBnQXjGjx6WjVytPX44aRMha+GLA0tcHSpwoKsOXBYNosQ+Hu5FSOIIx
         ILWuYN/vpeofvrf6FUbfwrKSMW6tZonu5FdIV/xqKS0DPdVIqWQwzF37KZ51vs4DyYJx
         1KbQW48cHk7JDT0+YsGS34KQjpuCr2rtOAAN2hs6SoLdthB2B0RSQBLlSqtf5xXJ2Ii4
         wbdq/E8EGQ8ab3LER0HXan3J4yiE37s821jI+FfQUBmdQ9WUbRhTE4TGm/cEPJFYH+9X
         Tadw==
X-Gm-Message-State: AOAM53370m6KptU4HAY7Nwn3P5tXt4bMV/uKPnKtYIvoAuFtVjRNbDrG
        n8dACyupjL0M1ZYftejngR7vdw==
X-Google-Smtp-Source: ABdhPJx3lPBpwUJl7dARi46jEU8sXgzhA40DeONLxaK+kkCYBeLzfDrfg42AwsVn4afHZcri1JOFXw==
X-Received: by 2002:a17:90a:dac6:: with SMTP id g6mr7759003pjx.178.1611549371102;
        Sun, 24 Jan 2021 20:36:11 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id k9sm16243155pjj.8.2021.01.24.20.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:36:10 -0800 (PST)
Subject: Re: [PATCH] block: Fix an error handling in add_partition
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210117085023.24352-1-dinghao.liu@zju.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfd373f2-8101-d1a1-549b-9163718ec658@kernel.dk>
Date:   Sun, 24 Jan 2021 21:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210117085023.24352-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/21 1:50 AM, Dinghao Liu wrote:
> Once we have called device_initialize(), we should use put_device() to
> give up the reference on error, just like what we have done on failure
> of device_add().

Applied for 5.11, thanks.

-- 
Jens Axboe

