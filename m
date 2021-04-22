Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47EC433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CF0613E6
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 17:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhDVR1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVR1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 13:27:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CBBC06174A
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 10:27:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g16so7023003plq.3
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dxeJjC8xaA28k+BF1hGx31II1NdXhhjzduC0otju5aY=;
        b=bp2rjjtUFFVO9QSTi04ChUtq95jVgalQvzVqXeuLPn90lgjPiRLA6YYE1r9czQyfVl
         5Dyyu/BKCmvNYAVn1ueS4inqGR49t0f5oZ2e16+M1zuGMR2A7aVO681u6xeXpxeWDI2n
         4ZrCWT4sMhpWFRPElIyl2tV6BLVxmPrqHj/tpjX4gTLLQa3PgFXugSe1soucUiQtdp8i
         HJ8gQBlsyU5JPYLgADYPkomY/PqZDzByaugmv1l9StjUJ03eGCCVnXJza4Qtp+AoxPGn
         /jn/GdgkP457S2qre8LZHjsnE+cCc5V6QLJQmvTTeR2pnBF5DSAGQc8NyStc2gqq8WZI
         7bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dxeJjC8xaA28k+BF1hGx31II1NdXhhjzduC0otju5aY=;
        b=RphNghCE8WLKweloFjQ+g3aVpFnZTeR3JzmpcirkWooVFJC6qFPORVUhoAKgwqgOXy
         NV+NIFvpcba2YYQ164QncQGj/jYKGKOWcwGsX66FFhiLYND9bL+xXn3Tb/UuueTKMp0K
         lRg0daw4rghXirYKmw0ue1NT47OGQrbRHykZ78Y+6aMfIXQNVz46gkQNqDrCFN9XtiEz
         RqNMRVs8k6QMz5JxwE80T7gsuxcal8bcBkeiTPdblKIvWRlIeDOb9usxU1E2nBTcDxH9
         Y9dbI36Lt7tiY0EzeXs6bNBGnChVoDUB35J8hBKN53doGcrftmvJTv+qLwRgvJ3fFthT
         zwtg==
X-Gm-Message-State: AOAM532BX66ov20XW71l1F9YO0n2ms4UqTqz8TbaxmdIZuLGjeq3+Mq0
        v8R/GUe4OOtChYFVPieEpsLQ1g==
X-Google-Smtp-Source: ABdhPJwRKVK0pjzyWYqS6K+XwiHZeEsApp8eAMjpaBaIpLGwpeffyPdHMaTyzZlgeX4oX8mCGpbnoQ==
X-Received: by 2002:a17:902:c40d:b029:ec:9f20:72b5 with SMTP id k13-20020a170902c40db02900ec9f2072b5mr4757345plk.22.1619112427215;
        Thu, 22 Apr 2021 10:27:07 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:54b2])
        by smtp.gmail.com with ESMTPSA id c13sm2916956pgw.42.2021.04.22.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 10:27:06 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:27:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH blktests v2] tests/block/014: ignore dd error messages
Message-ID: <YIGx6ZnleZ4E0SCy@relinquished.localdomain>
References: <20210408043918.4265-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408043918.4265-1-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 01:39:18PM +0900, Damien Le Moal wrote:
> The kernel commit de3510e52b0a ("null_blk: fix command timeout
> completion handling") fixed null_blk driver to report ETIMEDOUT errors
> for IO operations failed with a timeout. This change causes the dd call
> in block/014 case to print the following error message:
> 
> dd: error reading '/dev/nullb0': Connection timed out
> 
> The presence of this message result in a failure of the test case even
> without a kernel crash or hang, which is what the block/014 case is
> testing. Avoid this failure by ignoring dd error messages using a
> redirection of dd stderr to /dev/null.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> 
> Changes from v1:
> * Add Reported-by tag
> 
>  tests/block/014 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry about the delay, I was out for a couple of weeks. Applied.
