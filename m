Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B19C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D03610A4
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhJ0USt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhJ0USs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 16:18:48 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB77C061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 13:16:23 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h196so5290641iof.2
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=LjqtuKqFcXICmEO8DHfW9oWVMqViCZUkTv+u2qOQRJE=;
        b=KuMjthfzFhs0jK3AOFpblR8xZlZVm6q0z4TLSnjUhqXDXOi4Ll6dDA2+z6kI+9lIYa
         w5P2ygcPS4qczrFtKPmS7Ccg4ws2sZpgU26vVHDpHsS8/uOcARKoqvAxOEUM/hbqiHaK
         zhEzcjDMEOZhMNyCQLQCK0YCLJwL9q0v6xK5BynD6Y6gSFi+noyloZUHcltMIac7N9Fq
         XTELJqnhHRsSs4NTmmZkKQ8kGQyqA7+O9hqu0dZ7Ncho0W+bOpvSwg8oly13QvVjJsiq
         s4win3Lo+0ss2ww17hLS4GwWuO28c+/ewZMhfksh0fuXQC86RNsY9yt6UvmIs5zGieHX
         4xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=LjqtuKqFcXICmEO8DHfW9oWVMqViCZUkTv+u2qOQRJE=;
        b=E1TDAMpPRmvcnCRsgx9Rxd+uawedVTLbgHnH27lA+PK66nZC8/jMnuGIkUaPXTHAvM
         9rOjNBcYqCxGslJswUTIKuJQhkPq/YDVCk9vW6IKJtTbyBUFA+AzKtlHIWa0LUf+bNgU
         fvgVBReMgXm02EKESB6YJ69jYeYUwdn+TOpzSgaUTH0bTUgy3Ra228oHUX5o65GZA1bq
         G5Zg+66BMt3fImTMc3f2C6OGJQ6H5VPk2vBfG3q2PzgyEkvdp5+NeCxWNGv0VSCU6zs4
         EP2OUvy6Jv97T6HehUGH1etsHq14U55X1+2bw8CecOCOBcxJdfrSfujR2/CKTArwerX7
         yoaA==
X-Gm-Message-State: AOAM533UMEAlvEy9STmUcxvlEYfFlTJFBRgpGV3W7OLMszn47KkDuiGZ
        vv5ieRdxjNwoCte3W8OHnZjSNw==
X-Google-Smtp-Source: ABdhPJzjKGWTU7Qj+ZS/+X6wIjVKvNDsihkCZ+0ht8OW7V4lQgdI5hSbFvSWgvIzOVN/9L+2pQ/5LQ==
X-Received: by 2002:a02:8484:: with SMTP id f4mr15430jai.140.1635365782499;
        Wed, 27 Oct 2021 13:16:22 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j15sm513419ile.65.2021.10.27.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:16:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     kwolf@redhat.com, hch@lst.de, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com,
        Xie Yongji <xieyongji@bytedance.com>, josef@toxicpanda.com
Cc:     virtualization@lists.linux-foundation.org, nbd@other.debian.org,
        linux-block@vger.kernel.org
In-Reply-To: <20211026144015.188-1-xieyongji@bytedance.com>
References: <20211026144015.188-1-xieyongji@bytedance.com>
Subject: Re: [PATCH v3 0/4] Add blk_validate_block_size() helper for drivers to validate block size
Message-Id: <163536578184.77381.1471415825529034425.b4-ty@kernel.dk>
Date:   Wed, 27 Oct 2021 14:16:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Oct 2021 22:40:11 +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than
> page size yet, so driver needs to validate the block size
> before setting it. Now this validation is done in device drivers
> with some duplicated codes. This series tries to add a block
> layer helper for it and makes loop driver, nbd driver and
> virtio-blk driver use it.
> 
> [...]

Applied, thanks!

[1/4] block: Add a helper to validate the block size
      commit: 570b1cac477643cbf01a45fa5d018430a1fddbce
[2/4] nbd: Use blk_validate_block_size() to validate block size
      commit: c4318d6cd038472d13e08a54a9035863c8c160bd
[3/4] loop: Use blk_validate_block_size() to validate block size
      commit: af3c570fb0df422b4906ebd11c1bf363d89961d5
[4/4] virtio-blk: Use blk_validate_block_size() to validate block size
      commit: 57a13a5b8157d9a8606490aaa1b805bafe6c37e1

Best regards,
-- 
Jens Axboe


