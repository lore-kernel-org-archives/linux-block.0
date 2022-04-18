Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E05C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 01:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiDRBhg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Apr 2022 21:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiDRBhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Apr 2022 21:37:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1431C
        for <linux-block@vger.kernel.org>; Sun, 17 Apr 2022 18:34:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k62so10110869pgd.2
        for <linux-block@vger.kernel.org>; Sun, 17 Apr 2022 18:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=cDrEu5ECPQngwQ7qY85gN0RpRhG9BYL2AboDNu25nDM=;
        b=Oi3OY+0URtNO6t3jqW0FqpirxWf+/Z2Z4vE6ty/CjGWa6kzoJAVbE8kvGrvEvPh2RG
         gGSuEuJCMsKpbqwqVqx/6OkTXmSRnRo5Bs7YUjYjGw90yqvm7d0lDmzkFmRaTbklGDyH
         wIMBwkGd6TZRm8VTUuXR9scW3RROIoHd7hG5gm1J+X7XM1mO7BMFTQ9k9zxjWFR3crrw
         eegTFCvB5JtojWJ8G5fpZGdG6ZrMXHEX8/utK9K60SXDOOVpsNe6tqJoa3U3BNMWIyDe
         DOjBn5JC1E4n3QaoCo59DmDXEtQUaau6RkR9Ye9lWP+tpVXvpN1h6kzqyaha7YaepVyD
         US8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=cDrEu5ECPQngwQ7qY85gN0RpRhG9BYL2AboDNu25nDM=;
        b=ATaRqcGhBXJD7mp4G6Ng9EqpK6w7JW+LisOPGn/8FlDxlbNxiGscmzuJTSIP+t5CGD
         XtkiXeZDJHe5LdUmktnOwdeS8yo29iPNd4fWY/Cd74rZ+kBu27JUyFqIuoeDhfbdNGQl
         UTqfVKgpHieoHmqB0eIuTOQGxWzleYPlItuI/FeZqzRS9L1YDRH7ADjbe/r2PPVcWtx7
         l+4mKneUSQ9Rpsiq/ntQk5KTWgbM42ZFhpNZanq5oUi4gM6pr1QW+331Sl/mjeCJims0
         DplvL5M/8zkxUmhSM95mnJKG+q/QwOjsqRJ63WsCXHmTM32NNBHiXSpSi8aGfdB5F+3n
         JA1w==
X-Gm-Message-State: AOAM530O4hdNKwTdS8G44oqnJI+ONJt54mHcI8lhkXhri9DmcjLdcHYG
        YkTydlIliCH75ImdTTBqoqsQkg==
X-Google-Smtp-Source: ABdhPJx4By4SYKSI0QwhGCU/wBjAuvQMy9/qUw+EYbdxAQd/mdoxNmYTYXpY2GKceyZ5iK2lF4HEhA==
X-Received: by 2002:a65:614e:0:b0:380:bfd9:d4ea with SMTP id o14-20020a65614e000000b00380bfd9d4eamr8064743pgv.92.1650245697061;
        Sun, 17 Apr 2022 18:34:57 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b0039912d50806sm10897380pgf.87.2022.04.17.18.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:34:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, jack@suse.cz
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20220401102752.8599-1-jack@suse.cz>
References: <20220401102325.17617-1-jack@suse.cz> <20220401102752.8599-1-jack@suse.cz>
Subject: Re: [PATCH 1/9] bfq: Avoid false marking of bic as stably merged
Message-Id: <165024569613.260290.5525085558574709509.b4-ty@kernel.dk>
Date:   Sun, 17 Apr 2022 19:34:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 1 Apr 2022 12:27:42 +0200, Jan Kara wrote:
> bfq_setup_cooperator() can mark bic as stably merged even though it
> decides to not merge its bfqqs (when bfq_setup_merge() returns NULL).
> Make sure to mark bic as stably merged only if we are really going to
> merge bfqqs.
> 
> 

Applied, thanks!

[1/9] bfq: Avoid false marking of bic as stably merged
      commit: 70456e5210f40ffdb8f6d905acfdcec5bd5fad9e
[2/9] bfq: Avoid merging queues with different parents
      commit: c1cee4ab36acef271be9101590756ed0c0c374d9
[3/9] bfq: Split shared queues on move between cgroups
      commit: 3bc5e683c67d94bd839a1da2e796c15847b51b69
[4/9] bfq: Update cgroup information before merging bio
      commit: ea591cd4eb270393810e7be01feb8fde6a34fbbe
[5/9] bfq: Drop pointless unlock-lock pair
      commit: fc84e1f941b91221092da5b3102ec82da24c5673
[6/9] bfq: Remove pointless bfq_init_rq() calls
      commit: 5f550ede5edf846ecc0067be1ba80514e6fe7f8e
[7/9] bfq: Track whether bfq_group is still online
      commit: 09f871868080c33992cd6a9b72a5ca49582578fa
[8/9] bfq: Get rid of __bio_blkcg() usage
      commit: 4e54a2493e582361adc3bfbf06c7d50d19d18837
[9/9] bfq: Make sure bfqg for which we are queueing requests is online
      commit: 075a53b78b815301f8d3dd1ee2cd99554e34f0dd

Best regards,
-- 
Jens Axboe


