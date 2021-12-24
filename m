Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A3C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 05:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhLXFGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 00:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhLXFGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 00:06:11 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3370FC061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 21:06:11 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l5so5788521ilv.7
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 21:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Xq/p+tXHD8kU8ZVjCviFG7eeWeKctn/LYo/zWdhdtTM=;
        b=uRBQl+9gDcLoc8ArWNtxfm/3+ktcPnIuVBGwCXawgjE2h8RtdIcMMv7vyP7NXEe3k+
         iG+N+AdoPTgF/0ef6RKpdLp4FXHCx7luKIbY9o+q5ZWF/CP5/7tkajEqr4kpxySD+z3M
         MN0KoGxzXpUD0iASNpyI9qC99lSYKImtHdHd7t9d8dgoX754da76A3LHDedwcdwrUOxg
         MbuuMWLnAUtH0/uEaHtwOWEQZpWUiMAM5A6kga9CxI/JFgPfVjnVsm1n8+JbHe54L2jk
         XOV65h1uHn/Drz0F9m3870iu0QtUTAC26ACtCrNFAOmDlF3G8OlgE18kr6jvsZ5ApbsS
         EDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Xq/p+tXHD8kU8ZVjCviFG7eeWeKctn/LYo/zWdhdtTM=;
        b=5p/GAwEJAcixNxZ9sva5i4yO1LRg7Ki517AAuz+LDG8wPKFR1Mlz+qOZWjZ623a9qG
         da6S//IrwdP90E59Qqm/juLx7FP5oxf7Q7v7I144ELDAbGne3WJ+HHmX9d2ylugQmNj2
         m9Enr3YIDblNzKruL8TlSsVDXY1krRbmsujv0PAnCR0gaUc+HKsl1D7kiLKwx/qeqVqw
         U5uPKi1UeqesfLmyNSSDARBGjUeARB+xnasGVO92QIjfHbyoUuHdovl1agrunc4rk3nM
         9ILtWKMCyrL2BZelerwBN80nb1rQPwLySk19WKxYENlQLiZqwqVzjYdEJpDrRKQbutdB
         f6dg==
X-Gm-Message-State: AOAM5306gavAH8CffqUXXLZyo9fQOdleW7mhVNCHLpXkXhYWQNE5xN/U
        Teovq/mrTaHFqRrENsgisZme4Q==
X-Google-Smtp-Source: ABdhPJzg+1CxWN1o1uFVPSppd4yV5UNfRJGNgYn/AYAhCmSftnvZXhrhCOi4SJoxqlmnQ65Zg1BcZQ==
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr2542036ilv.317.1640322370351;
        Thu, 23 Dec 2021 21:06:10 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w12sm4368098ilu.27.2021.12.23.21.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 21:06:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20211224010831.1521805-1-ming.lei@redhat.com>
References: <20211224010831.1521805-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: null_blk: only set set->nr_maps as 3 if active poll_queues is > 0
Message-Id: <164032236905.919063.8882037687804425617.b4-ty@kernel.dk>
Date:   Thu, 23 Dec 2021 22:06:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 24 Dec 2021 09:08:31 +0800, Ming Lei wrote:
> It isn't correct to set set->nr_maps as 3 if g_poll_queues is > 0 since
> we can change it via configfs for null_blk device created there, so only
> set it as 3 if active poll_queues is > 0.
> 
> Fixes divide zero exception reported by Shinichiro.
> 
> 
> [...]

Applied, thanks!

[1/1] block: null_blk: only set set->nr_maps as 3 if active poll_queues is > 0
      commit: 19768f80cf23834e65482f1667ff54192d469fee

Best regards,
-- 
Jens Axboe


