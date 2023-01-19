Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF675C38159
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 01:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjASBYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 20:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjASBWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 20:22:35 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E202B689C0
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 17:18:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e10so316538pgc.9
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qobjLpEuxGX3xdvqrIZDZFHZE7PU5XKHK0RePQ+jGnI=;
        b=nFz7CwgA3p8y+mO43XetfLCQceWdrv0a1Vo2Frm8Vi7NS5qLz2aVt1D3diCEB9hs+1
         i8XDPgy0iKsAHNtvDGcH1eR5emwNflCewTnO+b5UH/XSSrEf9wJqyHfFStiZ7XOpjdhj
         KuN1cTOgANA5/6RAcQ9DTW6Xow2YgyQ549spE66zMOnO63axzZNhl6Q5JzcR9VQU5Kfu
         kaqYBGykfPLYplwe+AT/SaiWrwVL93//v8VUMzOPwBR0RmHCfLS9+XcRxCTxFcAUeiit
         DdIhR2VUPRYwNaLymkSPm5PgShzBHaoXFygEwHTvgcfRujKau0po55UwlPXyGp1CCPrb
         vr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qobjLpEuxGX3xdvqrIZDZFHZE7PU5XKHK0RePQ+jGnI=;
        b=oHcWegqR4thBAj0LM7vMzBNbySQUBgdHkcSBWzQ1Wb+Lc2F5t1GufW4xIn4XI/TY+Z
         0kDE1zj7OTsCK5M6SOvQFurH90kfH+cYuiD5eY1SKOhRm+vX9FpdHsptAIZkW0NNgiWp
         ssRnI7tafh+jEzRE5wOHC0MlnVZw5qO4/Yx6WvUt1N4O16M7pHKdXR0WWkbuQ9sT6of1
         odQgG8/6IkcJEGUZi3VbKsxay7nHNGeI2uZQuWlagyvEucXAUg9k2/iZxSfmhbbManyN
         b0dXNOBwZB54td8jCdsosyeU8fya3ZougTMkLQaHSSMmzAJuhf16br6d/w4k21Yw9rcd
         /WqQ==
X-Gm-Message-State: AFqh2kqadzLRQJsvh2Ie0D+rZUaB0oie7J16tBEaedlrqa2a7mcjoF8g
        NuTHiOPgrNYFnK+PsGQQ3mslNA==
X-Google-Smtp-Source: AMrXdXvqvczVFdli9BliWRtKxeXFWX+U7PgVoK8yHRaaHEhsE0vGRGpeQ1SU+eQ68nRbTm36XbYfMA==
X-Received: by 2002:a05:6a00:27a4:b0:58d:fc29:430c with SMTP id bd36-20020a056a0027a400b0058dfc29430cmr135956pfb.1.1674091136366;
        Wed, 18 Jan 2023 17:18:56 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y127-20020a623285000000b0058abddad316sm15905948pfy.209.2023.01.18.17.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 17:18:55 -0800 (PST)
Message-ID: <52073ee8-72ab-f424-1738-c56bc8d5cd67@kernel.dk>
Date:   Wed, 18 Jan 2023 18:18:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/9] Add support for segments smaller than one page
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230118225447.2809787-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230118225447.2809787-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/23 3:54?PM, Bart Van Assche wrote:
> Hi Jens,
> 
> Several embedded storage controllers need support for DMA segments that are
> smaller than the size of one virtual memory page. Hence this patch series.
> Please consider this patch series for the next merge window.

Before any real reviews are done, I have to ask "why?". This is pretty
hairy code in the middle of the fast path for some obscure controller.
Why would anyone ship that with > 4k page sizes rather than ship it with
a controller that is sane?

-- 
Jens Axboe

