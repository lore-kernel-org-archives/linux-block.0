Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D96C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A708F6120F
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUO0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUO0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:26:51 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39768C0613B9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:24:35 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso629492otp.5
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=+jNPZ/wsArjJ8Jg9mpk8BPwkGKEDoRdxXViWQCg7VI4=;
        b=SSbxxiF7tRDldXinOprVUPe/7nTsMhUvOqCdGWKDN9yO8ZQLz+m/bFpTXPmW/44KS/
         UX9XdRlM33JDyMg/fJ17nz0oUodS+Nesk0ROWRnr/zSmrcGuBKmCpeQtxW9mYtc5iT+F
         dTvsDvWsUj9/L7syXPvj7E24HQbT1j1JdJ0uPTL2yKvmlY/JPsVbaES5BuCCWxOxyfVU
         WFUQOneeWr2M1DAkcDZob5MisHFtE17sRrOUqdDX8LNWfnx78x3h7w1TsiASKHP1A6Ca
         YRBQdp96BumTNcLiMtFZvjUVBPwqmv/pR/OdQOlqkmAk96obOLKtl28iJCmoZO6vFF+u
         FMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=+jNPZ/wsArjJ8Jg9mpk8BPwkGKEDoRdxXViWQCg7VI4=;
        b=lKD2iP5OzN7p2YWi9XYlk+vDc7KMmBPAY1Fv9ZHS68QbdOABZDXouQGNGH//Ts7F0h
         pfXBsyTKWzx9S0+cZFv4AzGdw2ZCeLOfCItXYf85mGyhp3+OD0kwsidtEPwcQbkIGNnP
         EY5xzk6rxTL3Oxmt97iPRnQwKvykv5GS6rDGIfRI+OYDZvKv6HLWyJIoyK6+lB0ucjq/
         EzOl8Rbw+8KDsK030mwDiCxYKqpjeC4UADUOkMFjzNhs38n2OG0zEPEuKhoVZG+txWP1
         5IxgsOcpxQ/W7+qUMueVu++yea7H/C5I/uqMd+VHuogpdE8FqKxaRclUxBoKqv3DvUZm
         QT7g==
X-Gm-Message-State: AOAM532s8OpF5lKuD4ISnm26R9aYLxq8alKivq2U8bQSo1vgADC8RDRg
        3e0pfI4oxgwhbypRuwvDvg1Y/HccTYuE/WOe
X-Google-Smtp-Source: ABdhPJz7KkiD3U8VF9BKWC2fzqwidzlZCfKXVwlT0lQVp++e76vOS3gAx0cnFUeIQtgwBmoN8KXVqA==
X-Received: by 2002:a05:6830:1017:: with SMTP id a23mr4772961otp.381.1634826274572;
        Thu, 21 Oct 2021 07:24:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id s206sm1116088oia.33.2021.10.21.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:24:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liu.yun@linux.dev>, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20211021071344.1600362-1-liu.yun@linux.dev>
References: <20211021071344.1600362-1-liu.yun@linux.dev>
Subject: Re: [PATCH 1/2] fs: bdev: fix conflicting comment from lookup_bdev
Message-Id: <163482627258.38562.7953994214106016215.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:24:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Oct 2021 15:13:43 +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> We switched to directly use dev_t to get block device, lookup changed the
> meaning of use, now we fix this conflicting comment.
> 
> 

Applied, thanks!

[1/2] fs: bdev: fix conflicting comment from lookup_bdev
      commit: 057178cf518e699695a4b614a7a08c350b1fdcfd
[2/2] scsi: bsg: fix errno when scsi_bsg_register_queue fails
      commit: e85c8915cf374af76efdc03a53a20fdec9d8eb5a

Best regards,
-- 
Jens Axboe


