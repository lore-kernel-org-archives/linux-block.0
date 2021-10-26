Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7068BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C10160F70
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhJZOrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhJZOrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:47:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975DC061243
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 3so15029369ilq.7
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Bms0tUdjVEk7s3z58zLYrHW8ZiKmg6Xf31TyfMyLYmA=;
        b=qENgBIIqT7KSIkOCdnv/CQZeP4z9PGNbNd3gNtqGhuBK/F7oVuSVCIo2c32+4wUixR
         HjqDWFr1zb3vL4p6SQERAPKSYZMM+2V0ZXNRfmPMo2rjIjyMaVk85CtIFxYVji3zjI/T
         rho20ikjVlHg3vxkOoGBfFGxCZUG7ALeo4O5Ayovgvcio3iGcExwEzpBCiIS0eyqQAIn
         fKZkdqBME14+p0+qYFzIpLGOdMNiLL9+GQmc9iyVUzls8std/+E1WRkSTGEnwYj8hXm1
         1rJUQ0YOpZMaplM+ItID8KDXziQX7XiXhTP0M2it05h/iKdvlj5l3aJuKTCJVZx4lmXq
         pMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Bms0tUdjVEk7s3z58zLYrHW8ZiKmg6Xf31TyfMyLYmA=;
        b=WDeV/5wXXI41xh4GgXHRLWFEEgY6BXg/S7Buakdo7pIzd405qb3123FG14eC2SmAV8
         vqZ5iFGdYah12Rbvdoj27ZHPPpmsoqWx7af5avgUG7QSCCuq4abvJOKBLV/yyET16KhV
         Le+8/44JqO7Mmfy61S7NIJH6q+HDEev/EPbRoohaA3pG3x32zZbMrDyyGs3L5z3xaLSY
         LVgBarJQUM3hgDre5by97pNEcqHGlEi8KV9VPBiEJBXbfOdgBx8AFd7/8n5MVI+S+BTY
         8YVJy9DLjtSTSMDZUDj4wBmNhe9OQWzXrbC4u30PYeU0cPd4tbjw2MKDttQfkLip/uHw
         FBgA==
X-Gm-Message-State: AOAM532H0VJndsoVI2yMulWQh0QGaoH2ZmMFFJzr9GQTBk11I15L25zO
        NsY8e6enu5d7E38TfqfrzQXZ+3A3U3fMPg==
X-Google-Smtp-Source: ABdhPJx6zxoJ2Uq+gQkp4aMK3ZKWIyjkzOXcrnvj+LuUseNIEV8+Fm698jT3fnCXe+lQ3qd+3zv2hg==
X-Received: by 2002:a05:6e02:1b01:: with SMTP id i1mr14732569ilv.157.1635259485303;
        Tue, 26 Oct 2021 07:44:45 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s10sm10994102ild.78.2021.10.26.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:44:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20211026101204.2897166-1-ming.lei@redhat.com>
References: <20211026101204.2897166-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: drain queue after disk is removed from sysfs
Message-Id: <163525948334.224837.7501575309877841006.b4-ty@kernel.dk>
Date:   Tue, 26 Oct 2021 08:44:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Oct 2021 18:12:04 +0800, Ming Lei wrote:
> Before removing disk from sysfs, userspace still may change queue via
> sysfs, such as switching elevator or setting wbt latency, both may
> reinitialize wbt, then the warning in blk_free_queue_stats() will be
> triggered since rq_qos_exit() is moved to del_gendisk().
> 
> Fixes the issue by moving draining queue & tearing down after disk is
> removed from sysfs, at that time no one can come into queue's
> store()/show().
> 
> [...]

Applied, thanks!

[1/1] block: drain queue after disk is removed from sysfs
      commit: d308ae0d299a6bb15be4efb91849582d19c23213

Best regards,
-- 
Jens Axboe


