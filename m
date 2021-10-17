Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F011C433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 13:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B1A60FED
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 13:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbhJQNLc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbhJQNLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 09:11:31 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FF2C061765
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 06:09:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w10so12100864ilc.13
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9Jyn0+UnK3sc3mmvA7he3hRp8rjj2TT3D6AT72yd4M=;
        b=ASbJHIes5zFbIZLmT5kVad1Gphz/29iN5mRZeqZ3tlpfB2PUdfQDCYxs075KhC+NRv
         +usb2/LkAXg0fIeSB6mt8w9pH+E6c/OzEkv6tDGKbfXIFAQ8t5oyEn+o8Dm+lUJUNx5+
         Ul8uzxE52kgKEL4dvh9ifK8Bs7hDbeWzFDtGBQT9pQvuXKgTknQxbbEBf0BO1vBzF4qy
         L/DyRrQaJNeIc5GfM9JkFYQXD4eGf7eTOnQDguECYJz6ORTo/TEr2I9lvVJ6/rauXUJO
         VfwfWz2j/mdzCKbXt9/EaZfgdFsXIAT6UuwcRy3z9fFP2sHhYSEzdGkFLIglkDES37rW
         UmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9Jyn0+UnK3sc3mmvA7he3hRp8rjj2TT3D6AT72yd4M=;
        b=jzPEtAYk54iHNjkC3WF7lg1v9k1DACozgpZrFHom/pjxeMs7F01Lkf/PbUIiLF0g08
         wU1UnWeXY1ecKUoUL0SVFISupuqUXO8BN00T91ixFBHyFNOm6cLkN0N9YUsiagtYxe9v
         0qCC+kuWLp3lEDLNNccVYtAmBS2wRric30kq58O2BacAveVJm0/RBmQ2CxnddwLIBLFI
         d4JmlbBmIwtll1+xaShlWKtR/9S7xp7he93XkUcrUfLF6XUD+1IPV9UWNvkynk6YW4bu
         A9SnCEw57q4VCZfUu13DI3VtzkHbW+cYnXqV3XIGXpQfzcX4zDJIZOaE/jIWIiLkLW8a
         xNXQ==
X-Gm-Message-State: AOAM533qyJafpG7Dr3i5dQU90Zi0m3rq+5lGzJ4WjY/u3iyhD2i3NkXd
        DD9aCRcZitF9IqtLbS6fScBj5g==
X-Google-Smtp-Source: ABdhPJyBQfKmB09Bzd5teZfNePKIxWO5jVUrQL469Ya6l1IO9E9yjwNbDWiexPCRyhhuJXu+WSpsNw==
X-Received: by 2002:a92:c244:: with SMTP id k4mr11177912ilo.3.1634476161731;
        Sun, 17 Oct 2021 06:09:21 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h5sm2543282ili.12.2021.10.17.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:09:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai3@huawei.com>, ming.lei@redhat.com,
        josef@toxicpanda.com
Cc:     Jens Axboe <axboe@kernel.dk>, nbd@other.debian.org,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v9] nbd: fix uaf in nbd_handle_reply()
Date:   Sun, 17 Oct 2021 07:09:16 -0600
Message-Id: <163447615283.94076.11299323774180750344.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210916141810.2325276-1-yukuai3@huawei.com>
References: <20210916093350.1410403-8-yukuai3@huawei.com> <20210916141810.2325276-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 16 Sep 2021 22:18:10 +0800, Yu Kuai wrote:
> There is a problem that nbd_handle_reply() might access freed request:
> 
> 1) At first, a normal io is submitted and completed with scheduler:
> 
> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>  blk_mq_rq_ctx_init
>   sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> ...
> blk_mq_get_driver_tag
>  __blk_mq_get_driver_tag -> get tag from tags
>  tags->rq[tag] = sched_tag->static_rq[internel_tag]
> 
> [...]

Applied, thanks!

[1/1] nbd: fix uaf in nbd_handle_reply()
      commit: 52c90e0184f67eecb00b53b79bfdf75e0274f8fd

Best regards,
-- 
Jens Axboe


