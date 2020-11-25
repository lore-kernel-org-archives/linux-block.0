Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F540C56201
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369FA20663
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJm9YKDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgKYT4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgKYT4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 14:56:12 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34703C0613D4;
        Wed, 25 Nov 2020 11:56:12 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so1625501pls.10;
        Wed, 25 Nov 2020 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aO7nHZ3iidLNpLtaZ8hYAxZ8E3lo7sKmwA4IGxVrTa0=;
        b=uJm9YKDO+df2eIRvigDeQqFJxJ8u6+7yNU+GutLF+qxJQpfv9mSol4g5LDMB/uCUmy
         hChR44jXf+Jg0mpFMSRKU4rjUKUkT+IC1A1aJ4mRIUl9HQtZV4qP+4Ra5dWEAG4hG8ro
         MNzR5phLa7ly/Kt7V6LBgAKOcEliMJpL2qoDLrttRAkC/CHwF13x2KJu8oqoYkvqI98x
         zlN/4CLQGNCyYDxx5n96XFSmvU6SQmzBKQYebfsbztDOrAcb/FPiuTQcdvbPBi/2tG4k
         z80/ZU/bKLu7PhHh2x3IY5CBqPKLFcOi7L/0FATJpmPh1Ob7U5u7MJzWUUdbcDqKokZc
         8SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aO7nHZ3iidLNpLtaZ8hYAxZ8E3lo7sKmwA4IGxVrTa0=;
        b=bKRVIzxRkhL7awp4vdxNg5fn854kZyUWGEmZ3HwSGbDd6ghjQDE7/uojYtj9J0r4zx
         JBEsNjUbUVCPxCCUpfyxwjqVJqjXObh7WHGSgJNlpshJhA81mXKqszrWiXWAFMpSBALh
         bOuUTZm9idobld6S0h7wHRr/aSkiP09zGY21ZO+oYADDc1aMHEXXYvBH5L1CHksqdyTL
         Ujhhu2bhWVMXhYAJTiiAp5ULmA48C5a6/idAmhSPv1mI5M/Bk+P4JQQT/dJlyXQ4kOJT
         6Lctn8nlPUQxZzk8QATkoaIWx3CV7VUJyXYoM2HJ64lvAPWlpBjpdTpIOhjqDVUW4bLm
         M2pg==
X-Gm-Message-State: AOAM532Gjdxm50dyj0sptF1NBGwXaFaa40FfDKSUAVrWzEjmKWKTd/wS
        ZarFDgCNG+dXGV+ZdKbHZT0=
X-Google-Smtp-Source: ABdhPJwXHtJQ8ksYS4HG3PEOxCnVjkFLCviulNtej1y18JUoVAu0t8LpJv1BpantRgFcAmZO6OlFnw==
X-Received: by 2002:a17:902:70cc:b029:d7:e8ad:26d4 with SMTP id l12-20020a17090270ccb02900d7e8ad26d4mr4432616plt.33.1606334171743;
        Wed, 25 Nov 2020 11:56:11 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id g26sm2670327pfo.57.2020.11.25.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:56:10 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 11:56:08 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] zram: break the strict dependency from lzo
Message-ID: <20201125195608.GA1484898@google.com>
References: <20201122095051.4819-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122095051.4819-1-rsalvaterra@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 22, 2020 at 09:50:51AM +0000, Rui Salvaterra wrote:
> From the beginning, the zram block device always enabled CRYPTO_LZO, since
> lzo-rle is hardcoded as the fallback compression algorithm. As a consequence, on
> systems where another compression algorithm is chosen (e.g. CRYPTO_ZSTD), the
> lzo kernel module becomes unused, while still having to be built/loaded.
> 
> This patch removes the hardcoded lzo-rle dependency and allows the user to
> select the default compression algorithm for zram at build time. The previous
> behaviour is kept, as the default algorithm is still lzo-rle.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks, Rui!
