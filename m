Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFB3C00140
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 18:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiGZSdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiGZSdx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:33:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7908720F65
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:33:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c6so10015019plc.5
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SYUKQQO+B9D4HsdUTzY4dBddAzyB3mOX8vLGkHBgReI=;
        b=HsCrB6v828BHxR0IeOAT4B2AKQZlHZZQyrsGwbJk9ugK4YIeYpxC9ohznWBUNYxcLp
         Iy3iHazdQXhHgLkg6HNaIofXYYWDTOK3Pqw0Ci6aMNWIQOp/axo/bc1bN6rvcgoG9IpY
         jT37CkIhoUpc1ch4Jx6jdsSrkE++H5quzDrNvH3gPsa7LNlFMfFE9zJWKuI6yTv3iPrK
         Amd4pcD35+5uKDBh9bxs06Nda5ueMvSvAIGzSReOZkaPJoYXS7n9iWklW7OQQcob6WNT
         frgwu36L6E/eTNe/YJYNKpXq5CcEsMqgmy9LzFnJP01SBdykiKSgwM802KSWI8eM7s8J
         +Umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SYUKQQO+B9D4HsdUTzY4dBddAzyB3mOX8vLGkHBgReI=;
        b=lla+bDxdNr79qHWQPyerlvmQo874lih+y6eGgyMmvvRlJn5GxQObT2YIU0y4XTlTVx
         lWthn6+N1o0SXE3rn/FFrEC7cr96tWqOdQ1ilkw4smx1dLIw6vKH/93nV2a0EnK3rlJm
         /xsfjTwngKjBMtL60OkcaJWYRgGcbFnsig/L5BiWx7q3QeNUOsBaFCLR+gCmh+Jc46fM
         xdybMKP9VsH0Vmb1qBSMeq7P+eEhypmUPyR0sMFXYckvnT2HIjk0jWpb04M857MRtrP3
         12Ndde0AynFQfO31g2t/W6whOfCZobiKVSRfkPY+rl4tcZL3FhHU02cgpjVDu52F5pJT
         vYlA==
X-Gm-Message-State: AJIora9GVUFkHHjZycRq8QnrCa/zeSGghZkVL10zunq46sgdJ6yTOFTu
        fezyNjKdz9XTou2BHxCPqoVuWA==
X-Google-Smtp-Source: AGRyM1s3eX5knPyIjzJ67pRAW2auHoNfXzbcf9efbkWFJYTjyu8U5/Thh77TB/D/v8nCkIXt8IVauw==
X-Received: by 2002:a17:902:f790:b0:16b:d796:3696 with SMTP id q16-20020a170902f79000b0016bd7963696mr17647790pln.97.1658860431935;
        Tue, 26 Jul 2022 11:33:51 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k27-20020aa79d1b000000b00528c22038f5sm12453139pfp.14.2022.07.26.11.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:33:51 -0700 (PDT)
Message-ID: <d8bcd233-680b-e822-d752-18dbb9048bb6@kernel.dk>
Date:   Tue, 26 Jul 2022 12:33:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: bio splitting cleanups v3
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220726183029.2950008-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220726183029.2950008-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/22 12:30 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has two parts:  the first part moves the ->bio_split
> bio_set to the gendisk as it only is used for file system style I/O.
> 
> The other patches reshuffle the bio splitting code so that in the future
> blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios
> under file system / remapping driver control.  I plan to use that in
> btrfs in the next merge window.

Applied to a temp branch so we can shove it into linux-next, then the
plan is to rebase this into block-5.20 once the dependent branches
have been merged upstream in the merge window.

-- 
Jens Axboe

