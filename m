Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6C1C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiKVNLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 08:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiKVNLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 08:11:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D163142
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:11:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t17so12534255pjo.3
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9N6VoykNRu/Vv9Z4jsJODEvG8uWFfnROjw18lJc5Zc=;
        b=VLVSODZKuzGlMQO522s67z6LBvxD+71zOEdmTm8doHnPUY1325AFkWcEDQOY1mSqgM
         ZpzY5PmOMrcBYkCzOJc2hj8QhGJrFLsXx9FiIPjnCJlqI0rGNapPriTjlkO71VvD5gJs
         xvwlIuifQQaV9gpolF+Q1nXoVFpnKxCEFxfzd9J89ANEAE9HcFJ+p/3p5KGhoVgAG6s4
         6D8TIxYn5TJWwUMxQCY66gcf4NbNA6x+kkvrz7JFDhAKPmWCV5h0K8c7UNoL6Dmq8l+R
         fKpBk8nX15MQfWBJyslNxXuTiIaMX9VIzBJJn7htNMmsvDbKIVYvrk1NqHfUAc8LuaI7
         r0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9N6VoykNRu/Vv9Z4jsJODEvG8uWFfnROjw18lJc5Zc=;
        b=pImWvFvEmOkz+hKu11cQ2sYySVm9Z+qvNK23wHMeKIBp25KGjhMi1EGTKmvFDxV4HO
         4qdocdrdFb3IlzpogWbIXxG/4nDe9eDssH5XElzxr+1bnqFwjaeCm0x+CNbJk6Vda6+Q
         BGbb4PdPPmJnUjV6yg6nbo3ffejKhZBypH2YbloAvqriYb+ylH358827vrcVABnSS8/h
         T4JdgImjVyENj7H+ntd3lJAvRidKTiD/mmn7mr49A86I3efvVDlrVQ7AiR/qCSUBp6OU
         9wyBbupw8feSQS7i8/WcM4YJjYddvy4mPfQ++2D2R6xI+jXedrMkR+x6gim2PvcM9hpp
         TtsQ==
X-Gm-Message-State: ANoB5pnIoo5lZYVMtMrg99++hvwuf4KvHHt7s0PTJW9A43DrtZoHtnLK
        ecPgsStSreeDFfGSsOyrVqpOqg==
X-Google-Smtp-Source: AA0mqf571N+3HpDYFJN/VAaKGm0VgcXalUBxCO34awQVAUxrI0VU8E3efFQS/3+aAWpcr4//nL/7AQ==
X-Received: by 2002:a17:902:9897:b0:186:a98c:4ab8 with SMTP id s23-20020a170902989700b00186a98c4ab8mr3915214plp.118.1669122667879;
        Tue, 22 Nov 2022 05:11:07 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w13-20020aa79a0d000000b00562a237179esm10583992pfj.131.2022.11.22.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:11:07 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
In-Reply-To: <20221122084917.2034220-1-shinichiro.kawasaki@wdc.com>
References: <20221122084917.2034220-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH for-next] block: fix missing nr_hw_queues update in blk_mq_realloc_tag_set_tags
Message-Id: <166912266675.4175.5366360904287464294.b4-ty@kernel.dk>
Date:   Tue, 22 Nov 2022 06:11:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Nov 2022 17:49:17 +0900, Shin'ichiro Kawasaki wrote:
> The commit ee9d55210c2f ("blk-mq: simplify blk_mq_realloc_tag_set_tags")
> cleaned up the function blk_mq_realloc_tag_set_tags. After this change,
> the function does not update nr_hw_queues of struct blk_mq_tag_set when
> new nr_hw_queues value is smaller than original. This results in failure
> of queue number change of block devices. To avoid the failure, add the
> missing nr_hw_queues update.
> 
> [...]

Applied, thanks!

[1/1] block: fix missing nr_hw_queues update in blk_mq_realloc_tag_set_tags
      commit: d4b2e0d433769cb7c87e4c93dc048733388d1c46

Best regards,
-- 
Jens Axboe


