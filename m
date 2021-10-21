Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D35C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A4661212
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJUOYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJUOYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:24:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50977C061348
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:22:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o204so999883oih.13
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=pwU45kqabGOIjTCLFTiuvnWVscRTVq0V1Wg7F0FQWnM=;
        b=m1DSHkBkyUSgDKySogEvw+YytcjK9ePNfALveLH480YxprvTUn561zQPcVWTdXZ43C
         aOW9u2N6kxwvcBCSPrvEkLoCyjn0JWlSYiBXeM6ciNAgshZEvRwP2LaDQ1jCyVluvtRr
         DDOGShBfvr1fBwNgXu3lEqi7qDOgo0izVQOiaU9XUHZRQGooSxNbMz5qdgkRfZNNwVpX
         cWN2ikXLZp5gWvJEtfIkieFeO5YhAY9SwXOvFzxhfoBlXwUNmvZTdETRMHGPDyO06JVr
         NvVRM7HYSip6VlXExetUcBtZcOz/ESLYA9zWPHzNmcbEC9nb1DeltJNKValWimMrK2LL
         3STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=pwU45kqabGOIjTCLFTiuvnWVscRTVq0V1Wg7F0FQWnM=;
        b=zJyErFs755Ut8aVPseqO8Uo/PmiSJptIfMmJDlfLFa71mI2dfMIx4h3irIeCc2Ndd7
         7YAC6+RiP8u+KaTZ4U2btNSUKXJUnwTMDmRQUNeRnJ0UScucBoh0mhnPzfa4TYpiHC+E
         tPRAQqavji5SD1XhuH9YHBRzYXe4lBMGOlv0U+fZt/zK6pZ4FYcnMLGAa8tBnncnE42Z
         giBwivnSMJNbKZAvUbQ+hrdJmdPodBPb8mt/1Nqo2l/2YSuRLZb2eGEH/43psMo28mTb
         eJICHMQnNJoKsVAb+Hnn6RuU6reQIWt9S+dnPKkOq8ByWU9euDKzLouoHVbyIExyHOot
         wpkQ==
X-Gm-Message-State: AOAM5303zfIeGgtGk9/hExt0NR9nhIpANGTv8j/y9wg+iis5bELl8PMg
        YSz+HtV4hfZqwdg7c5tVxQmpIAME+1qrOrw3
X-Google-Smtp-Source: ABdhPJxMonhDxnh1DsuGFr+RKw9Ii+GujTV3nMHKAOveBQ7hDy+tCxtaPkG2CMQ4uym5tIf1Wegscw==
X-Received: by 2002:aca:1712:: with SMTP id j18mr4532065oii.33.1634826119457;
        Thu, 21 Oct 2021 07:21:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id z8sm915785oof.47.2021.10.21.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:21:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, hare@suse.de, ming.lei@redhat.com
In-Reply-To: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
References: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Message-Id: <163482611742.37241.15630114014516067630.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:21:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Oct 2021 17:41:23 +0800, John Garry wrote:
> Since it is now possible for a tagset to share a single set of tags, the
> iter function should not re-iter the tags for the count of #hw queues in
> that case. Rather it should just iter once.
> 
> 

Applied, thanks!

[1/1] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
      commit: 0994c64eb4159ba019e7fedc7ba0dd6a69235b40

Best regards,
-- 
Jens Axboe


