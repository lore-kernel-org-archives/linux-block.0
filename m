Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F7C19F2B
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 15:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiG0PBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiG0PB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 11:01:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A945F53
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:01:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q14so13764068iod.3
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=L5UacVwG0lbVwucGqKo14VXKqBeHk9LWn1czFrvGea0=;
        b=ut4Aa56BWSgeclJ3UzZDlu8Fwk64Q8C2yInY2Pef+40G5lluPXi5m3/L17t1NTKl90
         QkBqz+0F3mWSeQ8mV/nyMzuatIemV5mQ3qywoTn3RuP+4P8dvyWsnkokt2cojzLK7j0I
         oa0JuIYzlMbq92w0ma7eeuLEv4bcJoi8tnUxJ6JLT6N/2GdKpWZB44fL47FMQrcoDjJ0
         x7OF9Aa74Wsf+0whylDT+YQCLaz/eNncWnk7qMtVhd4hHhnTiPR7wqFkZYJdInA9d3rb
         kNuEM4lLF2WCu/aJ7AOxZKabCgsOKIeCW5XIov/smXfPw3Jl/gr0HfDFkBWO1jCDc3Kp
         X8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=L5UacVwG0lbVwucGqKo14VXKqBeHk9LWn1czFrvGea0=;
        b=GNt4zd1u4cbIJZwLluEdqLJ8wEYKWjPgqGTRrJBr06La1WWTdDHtP/QoPazdF7/aIe
         ShkhxjKw3HI8eLkzMAOm7eZoeD0KS/h+jl3RNy5PsVBz6nnL6Zfso/pWZLMZQOM5+pfh
         S5MPZ//F2lmZnG5rBLaSNFVQ/xkFNxhX2zLGLRfG0Lra98/MmYWtmWY6zonC54AgQUXe
         Z+nEsdH8v8RbyYdjiYzl1ztpCGsJmFw4FG8NCOJSxnJCZhh6NKHTNZjw+4Bxpa/Dx2AP
         YN18yriBRqv3R6SDJ64YL3jpd2H4VPoW92V/W4I1jzB2x+0p6qIBTo0WKZuPFJZ/hz7z
         TUWQ==
X-Gm-Message-State: AJIora8Mh4BhZDsUJYnA5mtqPNXadtSfL3lIatIqv8Tg5dOqvis/UgOS
        hyYELpyndM+88FvFpHPn2/l3+HpmwsVfxg==
X-Google-Smtp-Source: AGRyM1vJ6PW/Vjyjod8odFOvakWIAXIX+RMaGgeV3lHIE6lMfcM9AEVk+TvN99ktLTZxUjbLZzNNrA==
X-Received: by 2002:a05:6638:1448:b0:33f:89bc:2f0c with SMTP id l8-20020a056638144800b0033f89bc2f0cmr9338710jad.187.1658934084754;
        Wed, 27 Jul 2022 08:01:24 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u8-20020a022308000000b0033f4a1114a6sm8011453jau.178.2022.07.27.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:01:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220726183029.2950008-2-hch@lst.de>
References: <20220726183029.2950008-1-hch@lst.de> <20220726183029.2950008-2-hch@lst.de>
Subject: Re: [PATCH 1/6] block: change the blk_queue_split calling convention
Message-Id: <165893408403.1574811.16168104000091144664.b4-ty@kernel.dk>
Date:   Wed, 27 Jul 2022 09:01:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Jul 2022 14:30:24 -0400, Christoph Hellwig wrote:
> The double indirect bio leads to somewhat suboptimal code generation.
> Instead return the (original or split) bio, and make sure the
> request_queue arguments to the lower level helpers is passed after the
> bio to avoid constant reshuffling of the argument passing registers.
> 
> Also give it and the helpers used to implement it more descriptive names.
> 
> [...]

Applied, thanks!

[1/6] block: change the blk_queue_split calling convention
      commit: ab3b67b638fe2f99eae85935650e033d07fb1c2a
[2/6] block: change the blk_queue_bounce calling convention
      commit: c822f1c10f6cffc444ce2b998ee9969c02a172e8
[3/6] block: move ->bio_split to the gendisk
      commit: 8ecf459ff220c90dc11960524d38dd59472c169e
[4/6] block: move the call to get_max_io_size out of blk_bio_segment_split
      commit: 34c0966ec6710bb65db375dd717a1e3e02bf9bfa
[5/6] block: move bio_allowed_max_sectors to blk-merge.c
      commit: bb9f90089379540f8935ff5d705faa4b32531f8a
[6/6] block: pass struct queue_limits to the bio splitting helpers
      commit: 1e58f07b91f50fc6b50d82e6d4075923c511b9a2

Best regards,
-- 
Jens Axboe


