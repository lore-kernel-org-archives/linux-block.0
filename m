Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67479C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 02:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbhLCDBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 22:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbhLCDBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 22:01:20 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6877DC06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 18:57:57 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id t8so1395415ilu.8
        for <linux-block@vger.kernel.org>; Thu, 02 Dec 2021 18:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=6X7KHTzv1KndbnPEFJDUymxroGE661H/W/HnmgndvsI=;
        b=oScf3C/9S3zhS+2xiEPmr/TB0sbU7LBLQhejIzBHb+QVzyABlXMdOD/8WVxHuDpvJo
         KuXMMOxbBUsDloxAX2v+DN0NK/xkBwcnpxWVv3Lj6rgTIM/h/hfx0bLqTlvyIbsjqYIv
         XVLDM+5LQHavvbbEvMXqLf4XsdytJ5H2XpADtu1mRe3TJ8pppw3qMGCHrQbj4N3AwS1I
         cTuMQk+cViYw/J8kfv5bqkjqqwvSkzMV2Y9ba9DtdtDVYU2ty5vQgog5wtO7yU4eZoPx
         BHhXghpb6o2zgxM8FgSd44g6JQ7Z8By+JOSHeTSsXYwt8xi03dpeHrvFCAE9Dtgxrmis
         kAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=6X7KHTzv1KndbnPEFJDUymxroGE661H/W/HnmgndvsI=;
        b=6oTafQZW3YEWXWugaxE/piS35oNgi048+r5R2HKweBX355gGxjdWNmZgMlWLdbMhNy
         1eDBl9Kct+ZaPJm3egtukCkRQ2LIBdpPOWHd9zF7EcaIBuAZNnJEqllwfJDPLkvSuCGm
         +A5ULH/zAnnfSrmxwUABd6gObfPN8mk9IRskxtLsYlujOG1PeuvDXQ7ufL3FuFfRPMVv
         nioJtAuGAbanuM5sB/xhz8bnWkGeX7tWn7QQzKBPDL23PO9b1iucaBjVGwwj/XrteTas
         YCdcgBHsy2SoDmehwruXO7gZ6228Ez39zz1kmEE8+i2uSG8eJJFymaZ9H7HccXjMdg3f
         FevA==
X-Gm-Message-State: AOAM532zOLir/rVizkB9fPn+KbwxTgomM/v2BS0fqwjgIoFtLtKVSWsC
        sgZ/a1+ymOHLugL9ER0N3Pw9gVoQBSRzIqS3
X-Google-Smtp-Source: ABdhPJzqdbAH5rPVnf0TYnM4azPcipTEpuUcGsLHoawbqFsXBLREOTCP9/fAgSOsT8Xq1OsRLgQjqg==
X-Received: by 2002:a05:6e02:1ba8:: with SMTP id n8mr18874161ili.254.1638500276733;
        Thu, 02 Dec 2021 18:57:56 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w19sm1254877iov.12.2021.12.02.18.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 18:57:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20211203023935.3424042-1-ming.lei@redhat.com>
References: <20211203023935.3424042-1-ming.lei@redhat.com>
Subject: Re: [PATCH] null_blk: allow zero poll queues
Message-Id: <163850027619.228927.313747953937341896.b4-ty@kernel.dk>
Date:   Thu, 02 Dec 2021 19:57:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 3 Dec 2021 10:39:35 +0800, Ming Lei wrote:
> There isn't any reason to not allow zero poll queues from user
> viewpoint.
> 
> Also sometimes we need to compare io poll between poll mode and irq
> mode, so not allowing poll queues is bad.
> 
> 
> [...]

Applied, thanks!

[1/1] null_blk: allow zero poll queues
      commit: 2bfdbe8b7ebd17b5331071071a910fbabc64b436

Best regards,
-- 
Jens Axboe


