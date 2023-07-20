Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BFEEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 20:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGTUCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGTUCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 16:02:40 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24D2729
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 13:02:29 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so15248439f.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689883349; x=1690488149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm9L8OGKEHZdmU9hnM3GKjbpRPyEmtA8o0crHfCp3hU=;
        b=4LjnEBByBbYMg48CJm/WiUWl6CGT7KLK3x1yg9e74apbaaiCjJKsG0LP+pH+C5XbpD
         1aQURjA7F3xiTiJ6/Wt0zs00qVbFZzPBiuuQig0lbZf2eHNKjrWr6awACXx6C43Croe4
         8Cndlkg1wBerLxo6OEWgL7fBwSPsEnlO7Uj4SkhGi5ts9s2VHSn3XzZlR2DawlFgCJyt
         g5l4ytQnFqyZdqCSAC3YUl9X6ZKXdCCbcG4PvXmalUn1qRda/jPe5oBVuIXPyeD1fMKF
         +DlQmLCX9ZNogRTJHsBHSvlrqF02hiYaPoPUX3auskDSRlzsITpO6mzsEkIKviViU/tx
         3Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883349; x=1690488149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm9L8OGKEHZdmU9hnM3GKjbpRPyEmtA8o0crHfCp3hU=;
        b=bU+qsb55Dbs32zONivZiBHwdLG9GTn/p9EBKo6fuwOblB0rOkwp6ltZ2zhwb24sw6O
         r5LalwijD3sIGDZHZ6rkgemATP0MZ1O3mV74tb3+jaR94CZTaSLkjs5xGO7YkWImC58c
         dTxq3RupwfY6al653rbtdcH3klslZUrDPPxRQPXt8Ayus+OHC9s0JpvpbEw7AZDBafom
         rxvJeN80fN12ZJKBvrH7dKTr3JsjYLa7kp1474wWy+44G+egLWvcL5YVBLLQJHOPYncW
         xZP8pEDqQb9B5EsSuUiXGR5/UysqAc/y5ifPr+nR/bLV7iyU8TIY5k0FZoku0dw3/0eU
         /dww==
X-Gm-Message-State: ABy/qLZrdrc4v7qqK1xjeQ2t2axhrJxY9yjf4KEf1ruUwxA+RiFr9G+p
        oULcEECmo92fRnO5BR9ysOw6rSHdV4dytl20RsM=
X-Google-Smtp-Source: APBJJlHB6goLkxYv5ILXE586pJX9Lga1Fj3ZiB6JnN3Vmp79WOMDRXlU2CCulL99gF+hoqYcEcVBtg==
X-Received: by 2002:a05:6602:491:b0:783:63e8:3bfc with SMTP id y17-20020a056602049100b0078363e83bfcmr5058938iov.0.1689883349116;
        Thu, 20 Jul 2023 13:02:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v6-20020a6b5b06000000b007871aa2f144sm534025ioh.16.2023.07.20.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:02:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, chengming.zhou@linux.dev
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
In-Reply-To: <20230720121441.1408522-1-chengming.zhou@linux.dev>
References: <20230720121441.1408522-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] blk-iocost: skip empty flush bio in iocost
Message-Id: <168988334811.126089.11961578901520630861.b4-ty@kernel.dk>
Date:   Thu, 20 Jul 2023 14:02:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 20 Jul 2023 20:14:41 +0800, chengming.zhou@linux.dev wrote:
> The flush bio may have data, may have no data (empty flush), we couldn't
> calculate cost for empty flush bio. So we'd better just skip it for now.
> 
> Another side effect is that empty flush bio's bio_end_sector() is 0, cause
> iocg->cursor reset to 0, may break the cost calculation of other bios.
> 
> This isn't good enough, since flush bio still consume the device bandwidth,
> but flush request is special, can be merged randomly in the flush state
> machine, we don't know how to calculate cost for it for now.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: skip empty flush bio in iocost
      commit: 013adcbef165c3eaf73e297b7482290593815ab8

Best regards,
-- 
Jens Axboe



