Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77202C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 12:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiBKMwG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:52:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiBKMwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 07:52:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F8B6B
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 04:52:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso4133705pjb.1
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=iZ79BtVLU7DegA0rBBUNiSYQ+lHijlAQoaGIpVypItY=;
        b=SqrtYeLwDjNCJVVVAs2IMD5DyTF32aBVrt3dg3FsVBEQ7ffGkzLM4ddU8CwQ/ef2S3
         j+LEKUozhiA+6sE+ptVPcEzvd/hIwNaI71LVrlCJS/cQw5Xve7xBik6hLquhWKKoDWZn
         Rw8f7WxHqkc4T4+iMblwBwISbKXVhACaVQMn+tcnvESxlzQGzsYob5ihht1ljbJHVxET
         +0JZDgnV54BllAGkDFWcNxZ6969lLrgXmJ5U4YZmNFQQFNDWDzQ4XCvDc0Wek6/B6fRB
         4twYOpQzArzHgOrZGDXOebJCe3lRpmnnZZAmhiuqt+Sy0xNMLiRhqhgFXlWTIQU6aYtb
         X7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=iZ79BtVLU7DegA0rBBUNiSYQ+lHijlAQoaGIpVypItY=;
        b=GcMrt8nWTzvMpS1XJF/6xQ9t45/VrvpkeXgy1U3XNf0pjIR6I41TQhK5oprtJgSpix
         J80fGyFTNg/fc9MhZj0EBKf0ZcZcTIggX6v6SRU+EMokVxipDbS1KGnuIlpGCZSIEOLH
         HeIwkpOdql4w1zkrhQmd9Yan/Nm4KRPnlsbuVLaejjHmLBLXQtf+4TezKXtxSPbcgjXX
         GznqXsDOhwmZdiL27Ayiwt07oxT+MqVlARo7w5TuvyNF1cLSl04tVivomp8EU7+zlQC8
         v/R4K9uqVkwbJtAY67Z7hsaMRqxkTQOwWjK6rh/mQg/29bRmiqz65hSBQrrB4yO0TimV
         gQJQ==
X-Gm-Message-State: AOAM530mmj3Ez6N5df+tL/QpMR99uNk8ytziGNAeunfGlpRCMlH7bbQ2
        j6yOBX1mX7zfqmSAaTwtN7lPZsrM6t+BCw==
X-Google-Smtp-Source: ABdhPJztF0/YF3QFWAdtL+MSq14Yp01Tu9baILHQCgve/1WDZHsfFn/gyfJVY4+MBTEe3IpuJbxnyg==
X-Received: by 2002:a17:90a:1c10:: with SMTP id s16mr203018pjs.115.1644583923850;
        Fri, 11 Feb 2022 04:52:03 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q4sm27569071pfj.113.2022.02.11.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:52:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        kernel test robot <oliver.sang@intel.com>
In-Reply-To: <20220211071554.3424-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220211071554.3424-1-penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH for 5.17] loop: revert "make autoclear operation asynchronous"
Message-Id: <164458392139.59442.6810114995328131315.b4-ty@kernel.dk>
Date:   Fri, 11 Feb 2022 05:52:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 11 Feb 2022 16:15:54 +0900, Tetsuo Handa wrote:
> The kernel test robot is reporting that xfstest which does
> 
>   umount ext2 on xfs
>   umount xfs
> 
> sequence started failing, for commit 322c4293ecc58110 ("loop: make
> autoclear operation asynchronous") removed a guarantee that fput() of
> backing file is processed before lo_release() from close() returns to
> user mode.
> 
> [...]

Applied, thanks!

[1/1] loop: revert "make autoclear operation asynchronous"
      commit: bf23747ee05320903177809648002601cd140cdd

Best regards,
-- 
Jens Axboe


