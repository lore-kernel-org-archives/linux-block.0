Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1735C43381
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C074264ED0
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352585AbhCCQj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 11:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245588AbhCCNwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Mar 2021 08:52:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339DCC061793
        for <linux-block@vger.kernel.org>; Wed,  3 Mar 2021 05:49:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c19so4190253pjq.3
        for <linux-block@vger.kernel.org>; Wed, 03 Mar 2021 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+P5PA6F/xv0ug4/O/dd/kkDv2kA9O3dbirrGi+yQBcE=;
        b=KVj58zmD4vVcP45HzjrJnvqZmHxTxJd/QDVVHINViPLqNt8zVm4NbO5XrlrcpU5BUU
         A/RiXNqIJgjZ8y9yKt0NvLGD9DmVVJm7OuREOYcjii6AYuBcepaYBrcr/yk+PYJRmoFv
         TtpSSivPzijP6nqcLt9P6okLyYkXIw53ug6JZyjWzl93BCyJR62jVX2hX7zk3HZO2Yiz
         /ikx4s1cXEaqNTHlcvqGOX6DwcYTZzBPhrgeQgLGRCm4Uw2y1hFM4oGAiAzwqT8OWUv8
         yf6bxPmqCjYHnSGgL+Zia5NiigQKZ+EEP9JjFcCLnNzcOCu9H6end/c2fMWGjUlmB8OQ
         srcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+P5PA6F/xv0ug4/O/dd/kkDv2kA9O3dbirrGi+yQBcE=;
        b=UTj4OV+6rJEMVgUysf+0Dl2StIqIJEMQYXGpcDOIiGDS+GocGCHbM0B6rQEpmoKYH9
         Dc2McBIhKT/lAQQ06GDl3k2Mk0np+Q9WJ3OrEQuevnkITGtp2VzePNahzOcPCw7lKAhK
         kNAGqPZOqeHPlP792mTuj8oUTLlQFJgEz+UWpfVRYlS5fsntaufQ/lCsn34GeQR7fzG/
         WmfNmq6zD5gXBH0Uf6DATs/a+KV4HZcXGf47JioC/Vp+W2X91QjH6DkmpkDOcBKFRjcn
         6dVEKqruPVv9PbU6VrKLC89X9qPc7JQPQHmkuvG13hlF5kN1JBDQSXh64HoVkXFDSdrx
         uJ4A==
X-Gm-Message-State: AOAM531ck05uv9v07TbelMsBlAWXVFXHkrXg8UqpeBn3BCsMXrG6vd9d
        On5Vbd285gL1sTuWKvwdcAJHgQ==
X-Google-Smtp-Source: ABdhPJxStOZuuF5WCJNbeubaT2iUv66NtiARKGwV2jlN1wxLw1mNbTST3CFURi/V3Rz+MkyFT72UcA==
X-Received: by 2002:a17:903:2283:b029:e4:8a:d7cb with SMTP id b3-20020a1709032283b02900e4008ad7cbmr8369263plh.5.1614779374776;
        Wed, 03 Mar 2021 05:49:34 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w203sm3018766pfc.185.2021.03.03.05.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 05:49:34 -0800 (PST)
Subject: Re: [PATCH RESEND] rsxx: Return -EFAULT if copy_to_user() fails
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210303105912.GZ2222@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b5e3720-70a4-caa4-1709-e95f2dc94233@kernel.dk>
Date:   Wed, 3 Mar 2021 06:49:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303105912.GZ2222@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/21 3:59 AM, Dan Carpenter wrote:
> The copy_to_user() function returns the number of bytes remaining but
> we want to return -EFAULT to the user if it can't complete the copy.
> The "st" variable only holds zero on success or negative error codes on
> failure so the type should be int.
> 
> Fixes: 36f988e978f8 ("rsxx: Adding in debugfs entries.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I sent this last June as part of a 2 patch series.  No one responded
> to the patches.  The first patch was a NULL derefence fix but I now
> think that the correct fix for that is to remove the "enable_blkdev"
> module option...  Anyway, this patch is uncontroversial so I'm going to
> resend it.

Thanks Dan, applied.

-- 
Jens Axboe

