Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD1C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiBQCnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:43:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBQCnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:43:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3801139109
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:42:58 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so4146370pjh.3
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=VQwupMkuml15X4XCUJ5gnxsl6W+UGm/inheXCXHtoe4=;
        b=CQb1fFlOZ6k4lIyKOQFnODXtJ9Z1X9QF1ZtXTN3CSJdUgcCSPE8UpXWSc38nf19bDR
         DmVIEUaPS8KygUEZ8ssknS+4B0csusMkgebCUERwmRGAq0+TUWnxF9SaFDOUvGcBBID7
         W/dMuEIxOS8QDrAbx1A+VGsE6BVSh6xO8ChKffsxa59TWUo9z9yD8P2+ZFeYNXVxCD+u
         U4zTz9i143/U6xYDqe1ZFww0+9crZXCO6f6m9CMUQMfhflVqrNdt0N5cBpDqFVLXXIvb
         2A1PN2rN5E8kceD9IThtbobOyHeAIq804pkkFYaDfkoVBoR7btxLtn4o0ZEBuT+oOHM4
         gq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=VQwupMkuml15X4XCUJ5gnxsl6W+UGm/inheXCXHtoe4=;
        b=dV38Sw6FVAJApiUeEiiE4cnSHpuPlsWEuAStVZ7km8vGk1kcUsEfXn2jUssX5ot15k
         tKrmU5ErhkYAXQ8Lvzu1Vy/HgFGHu1fd9fNOrWJLgJeAIZA4G1k1woXzgSlQJgIebnNG
         VUFGxXoljdvRVSz8g2OKWMtyeB/svDeHXtDtJCqKPS63VSW6JKgdXQAnSdbMvJyo7NJl
         lw5lg32r6qf1Ey3ZcPgExiahbWhSQ78nrbUGAu7DnXcrno7oylK4MDwx+gTF1byhXI+c
         /8Yn4uAZQHraCugfq0kuW/POWz/6C9p/HG9QKLvYWO5s53ldsT2ovpBh5lwHCdKYP9n+
         32Wg==
X-Gm-Message-State: AOAM532G+5uePNf6bNCDblKjrR55OG5OXGrxpWHR7COgT/g6B50rW+j0
        CAQjoVdp3DSepVwnVJN9WYlLv9YFGSiXKw==
X-Google-Smtp-Source: ABdhPJyE0KcuzZAj07I01uphvfUg60finwzJxOq1oHLoyBsMRNN+FAqs0OVyH8qtWJ0E90iY26sZzg==
X-Received: by 2002:a17:902:8bc1:b0:14c:f41b:b3b6 with SMTP id r1-20020a1709028bc100b0014cf41bb3b6mr915626plo.168.1645065778363;
        Wed, 16 Feb 2022 18:42:58 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id kb17sm390122pjb.1.2022.02.16.18.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:42:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Chunguang Xu <brookxu@tencent.com>, linux-block@vger.kernel.org,
        Ning Li <lining2020x@163.com>, Tejun Heo <tj@kernel.org>
In-Reply-To: <20220216044514.2903784-1-ming.lei@redhat.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4 0/8] block: improve iops limit throttle
Message-Id: <164506577727.48067.15872775943104157586.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:42:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Feb 2022 12:45:06 +0800, Ming Lei wrote:
> Lining reported that iops limit throttle doesn't work on dm-thin, also
> iops limit throttle works bad on plain disk in case of excessive split.
> 
> Commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
> was for addressing this issue, but the taken approach is just to run
> post-accounting, then current split bios won't be throttled actually,
> so actual iops throttle result isn't good in case of excessive bio
> splitting.
> 
> [...]

Applied, thanks!

[1/8] block: move submit_bio_checks() into submit_bio_noacct
      commit: a650628bde77f6ac5b1d532092346feff7b58c52
[2/8] block: move blk_crypto_bio_prep() out of blk-mq.c
      commit: 7f36b7d02a287ed18d02ae821868aa07b0235521
[3/8] block: don't declare submit_bio_checks in local header
      commit: 29ff23624e21c89d3321d6429dec8ad3847b534a
[4/8] block: don't check bio in blk_throtl_dispatch_work_fn
      commit: 3f98c753717c600eb5708e9b78b3eba6664bddf1
[5/8] block: merge submit_bio_checks() into submit_bio_noacct
      commit: d24c670ec1f9f1dc320e59004e61f3491ae24546
[6/8] block: throttle split bio in case of iops limit
      commit: 9f5ede3c01f9951b0ae7d68b28762ad51d9bacc8
[7/8] block: don't try to throttle split bio if iops limit isn't set
      commit: 5a93b6027eb4ef5db60a4bc5bdbeba5fb9f29384
[8/8] block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
      commit: 34841e6fb125aa3f0e33e4eaac9f5eb86b2bb34b

Best regards,
-- 
Jens Axboe


