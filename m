Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4FC07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 01:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI0BTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiI0BTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 21:19:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B7DDDAF
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 18:19:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 129so6638426pgc.5
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jqX1tl7nMADrdAO+1pQ5dK38aaaTINdXRGcOWUQycBc=;
        b=PiSXrzwZeHFT4Q0UZTiavj54OmOiwl1PJBuLlh7WbH411Mquo5Vph/yq2ViqpDsp6V
         Cv2rdE8qPhT1wwud5K0Hg2FLmsAz7FFGL+azJI+ZzoAdvWjpvBD8oG9sfy6DkIePnhBr
         vs+w13Eb5emxJLIEAdMra9kZPdt8u2E9mExsYqmHOKkARI4CAxRZjtapkiXFo0/XB48a
         Cy0DlnJIwP8U6hJK6TEgWtszYOt0lisXYv1QetjXy+kztB74vHDga5ggG9rGnuEHWiIX
         W4NCj/gT/WLReeiBUK6Wem5abJqCY3W6qMUOAc2oERAkynnoQa4x0S4I19taMypHtD94
         PqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jqX1tl7nMADrdAO+1pQ5dK38aaaTINdXRGcOWUQycBc=;
        b=WyaZoZnJX04A10EzdCW/zQVXKXIw9vElWeGtdiFZEB55v9V4Qwxgrmhiz+2ieIkPNp
         X6qY504uornBrX+n5zzElWuZRGSBCNmNjgG+uReSTyA4dCN5Ogw3XP790GTjH6AQgahF
         vf9APbqsghRLhENNnKGY1R2FPq8ZCkcy7d3IkhpAFmlVv6Eou3pKW/cS/YTvupaTliJq
         +kI+nwgjE6CCiylRin12U2OoJGCZICllfenmVixa3z9PfxcLLSd7GXrT8whSvzUnGTYj
         7vKzE2iorADiOtXRj8f+I8vDuqQBE17hzV5wbYVjR0MU1r0Sazdz+8RybUpN7FSSJWJN
         WmVg==
X-Gm-Message-State: ACrzQf24aw8O8XWwH7uzDn2BY+z7eKcEp03AOxPmiQD4hfrqp7Wc5Exb
        2FplXjlnSVPYfbuU9OpCVTfvH5Bt3luWhA==
X-Google-Smtp-Source: AMsMyM7LfQMiMFDRwcNQGDuN2R4li6iqH1rfH5EdToBUAz+sIGmyg2/drm3I15jnZRCPWUuNrYFRQA==
X-Received: by 2002:a62:ee0c:0:b0:558:5c4:97dc with SMTP id e12-20020a62ee0c000000b0055805c497dcmr10589541pfi.14.1664241542040;
        Mon, 26 Sep 2022 18:19:02 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id cu18-20020a17090afa9200b001faf7a88138sm80712pjb.42.2022.09.26.18.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:19:01 -0700 (PDT)
Message-ID: <d32c5100-09da-954d-faae-fdbe59e9abea@kernel.dk>
Date:   Mon, 26 Sep 2022 19:19:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/17] blk-iolatency: pass a gendisk to blk_iolatency_init
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-9-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220921180501.1539876-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/block/blk.h b/block/blk.h
> index d7142c4d2fefb..361db83147c6f 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -389,9 +389,9 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
>  }
>  
>  #ifdef CONFIG_BLK_CGROUP_IOLATENCY
> -extern int blk_iolatency_init(struct request_queue *q);
> +int blk_iolatency_init(struct gendisk *disk);
>  #else
> -static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
> +static int blk_iolatency_init(struct gendisk *disk) { return 0 };
>  #endif

This is missing both an 'inline' and a semicolon... I fixed it up while
applying.

-- 
Jens Axboe

