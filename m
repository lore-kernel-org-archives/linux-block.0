Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C107C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiGUQwm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiGUQwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 12:52:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A78BAAB
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 09:52:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u20so1779577iob.8
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=6A3jgiNS2ZdT0pRk+w5xfn2bnxGIB5waXkp7N8Lx+1o=;
        b=18AODXB7C8LMjTljg5BtYgAnmTMSqOHH4tAD8RRqVci8hqLQ2Mn6698kLowHpy035x
         6SKeZ795F/kjRFAFys7v5ma8a+aAlMFp8qDwiE1mLf5iqVkgTEy7OQXJYHpfvHaUwqO0
         50MxRA8xx0Sr/l/jv0Dpga49mBqNYFF3PjwgIq6ZAKv23/E+LXD+DAwaC8mvqsmRuCg1
         f8AdF2M6lGE1vkbyHM5He/q+SQocG31CxQSJbecwbnu7wEEG51cFebuRwZYMA+uZhBAr
         ItCaZ+tSCspTjyiR8G6W6vZ2dba0hA+fpBXWO484MmUuz0b9lvurVClfT/nqM3v9vANb
         hTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=6A3jgiNS2ZdT0pRk+w5xfn2bnxGIB5waXkp7N8Lx+1o=;
        b=mzUkuq7lCWobFXoAJM7OexmdFmqwUW8ioqsQzycgqDt7fBbkY/v1KmLd+zbHn1Qxwc
         Sq0vE4M1UkHAv/9t91gDVdQCVJOOTiOR1IwqvgzVHGjfq0bX4TktTvC8UnJ0Qt2dc3tB
         aVJM/AblpO1SbgySC4CimWJ2L/2m3Msp1JLKv/sk/JndoYU1CR1/XS2EFzo9WFsibGiv
         sauR9fda74YkkAUW7zkvMR99fXM/UOO4aXHAvbB8MIiQy+k1H6GzCm4ccGb3PMShmwBJ
         zPg9iWGFjcvx3Ucel6/QXJtjXn0cePniLWJTCV9YJZQpSsBURsIqjEXFB1USaJBSfuJx
         7ypw==
X-Gm-Message-State: AJIora9sdMkBI3c4/4FbVwUrqayiSzC2glJzo3psrG8IavAU1C9zb7Ne
        8+PfCmCv8spvrNAP69wdsdgp8w==
X-Google-Smtp-Source: AGRyM1uC5YJUsroESYYRA97s5h+7Mit9fwe9LA0teSwWumUOtONLvlYBRPiegrjjNPCSblJ5+Mmc6w==
X-Received: by 2002:a05:6602:150e:b0:67b:e8ae:fcc6 with SMTP id g14-20020a056602150e00b0067be8aefcc6mr13946440iow.155.1658422359691;
        Thu, 21 Jul 2022 09:52:39 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z30-20020a0293a1000000b0033f043929fbsm975489jah.107.2022.07.21.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:52:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
Subject: Re: ublk fixups v2
Message-Id: <165842235902.62272.7348959572645847369.b4-ty@kernel.dk>
Date:   Thu, 21 Jul 2022 10:52:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jul 2022 15:09:08 +0200, Christoph Hellwig wrote:
> this series has a bunch of fixes and cleanups of ublk.  The most important
> one is the last one, which moves ublk over to a proper gendisk life cycle.
> 
> This series passes the ubdsrv tests.
> 
> Changes since v1:
>  - keep allocation the tag_set at ADD_DEV time, and use the tag_set mq_map
>    for the GET_AFFINITY ioctl
>  - call the debug dump helper on the right structure
> 
> [...]

Applied, thanks!

[1/8] ublk: add a MAINTAINERS entry
      commit: c229686b26ee5b371bdd7e637f2d18f191861c3e
[2/8] ublk: remove UBLK_IO_F_PREFLUSH
      commit: 5f8bcc837a9640ba4bf5e7b1d7f9b254ea029f47
[3/8] ublk: remove the empty open and release block device operations
      commit: 49d686cceed2e3148ba2bd2dec7e09b86eba0337
[4/8] ublk: simplify ublk_ch_open and ublk_ch_release
      commit: fa362045564ea7641e7d48295b54f4eb4df689ea
[5/8] ublk: cleanup ublk_ctrl_uring_cmd
      commit: 34d8f2bea52928626aefd6f7e0ba7e69f67c8e62
[6/8] ublk: fold __ublk_create_dev into ublk_ctrl_add_dev
      commit: cfee7e4de2870017a4cbfdcf2d17329cc025b742
[7/8] ublk: rewrite ublk_ctrl_get_queue_affinity to not rely on hctx->cpumask
      commit: c50061f0f1a90df72aaa87eb17c459fa77952ad1
[8/8] ublk: defer disk allocation
      commit: 6d9e6dfdf3b207701471f364121c67eefb000682

Best regards,
-- 
Jens Axboe


