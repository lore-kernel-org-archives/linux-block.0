Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C77C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 13:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiBQNpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:45:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbiBQNpS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 08:45:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D02AF92E
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 05:44:43 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so9496805pjl.2
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Zo8tZz0dQI0lIkkvs+bcvl1kwCXKp/TLbDK3P6lafec=;
        b=Bj9881Ghb45ibpMfXVA7QkFyY1LibxlCn0fjA4JW4jbtxsObNYNmfIa6XKklDItJLU
         Q5eK+BZs+E9EtR/BES/MfVFQJEv3Gd0ziS3PmNjncLKhwX77UeOh1KQVqoSsvni0dkDV
         fydoC4g5GgklE/jnY1er/YYfveRgveCD4Sg1//HQyy6HAIXMcPtnhisOeXn2Qb28Q54W
         vSyovcTP8KN19d1FrhDwLti5XXzsedIvXO5Hm9JZs3+8MvSKUsZ/wc+3cytW+mHsNss/
         W+K2/cyTL8xuER4fP5g60lp6Ti4lZP6DCZ7i1NNen4m/MSxKwGRFSFB1GPs/JB2RuWbC
         pajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Zo8tZz0dQI0lIkkvs+bcvl1kwCXKp/TLbDK3P6lafec=;
        b=Drk6lf7+TQGMRtAYPhJ6NwQeQw4bok6E2cOXfBQCG0oEAiPe3tn5u5hkVtD1wXPogP
         DfEipJUl9huZiWvw7Wfup38AoXEzpHLxPMX5xNluJWeBuAdLIClMkPnP+hXU2yQhM/Un
         nCQpLY4ecPfoP0gio/wvn7bMcR4uvKWlOF1Wozc8M6BsB8G4GiutKh7BsR4yNAgz5WM2
         tJ1tO/JZirJReFZYOQx88inbRj5pHIUnYWFPrYMxxNeElYlykQyLNXorixGjXDaed5f5
         4/Uji24iWoxkjBjIXzyrJOxWXfw2RrxXD94Brr7+LsSUV0mmIfCS5n8xW02wyF3zoPlb
         s+gA==
X-Gm-Message-State: AOAM5333z0EMlrcMghCL1fMRlj5R71sys33E2w6RLmUbr4UnZIZnUUBQ
        J/9H87wjyf7BCmuKe+EJVixH+oeMlDm4VA==
X-Google-Smtp-Source: ABdhPJxMU7lcTYigsQf8wyx8/5dPGMnNfX0sEb9TJg2xhS0OA/uD2BXKHtEXxv4dRCSGk5+0GO/Tjg==
X-Received: by 2002:a17:902:f605:b0:14d:bd53:e2cd with SMTP id n5-20020a170902f60500b0014dbd53e2cdmr2972758plg.164.1645105483015;
        Thu, 17 Feb 2022 05:44:43 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id il14sm2043781pjb.18.2022.02.17.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:44:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, kbusch@kernel.org
In-Reply-To: <20220217075231.1140-1-hch@lst.de>
References: <20220217075231.1140-1-hch@lst.de>
Subject: Re: [PATCH v2] block: fix surprise removal for drivers calling blk_set_queue_dying
Message-Id: <164510548193.7592.4301337271554848551.b4-ty@kernel.dk>
Date:   Thu, 17 Feb 2022 06:44:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Feb 2022 08:52:31 +0100, Christoph Hellwig wrote:
> Various block drivers call blk_set_queue_dying to mark a disk as dead due
> to surprise removal events, but since commit 8e141f9eb803 that doesn't
> work given that the GD_DEAD flag needs to be set to stop I/O.
> 
> Replace the driver calls to blk_set_queue_dying with a new (and properly
> documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
> only remaining caller.
> 
> [...]

Applied, thanks!

[1/1] block: fix surprise removal for drivers calling blk_set_queue_dying
      commit: 73af72f93af41cd280423579c4ef9e8100c5edb4

Best regards,
-- 
Jens Axboe


