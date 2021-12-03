Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F0C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381253AbhLCNkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381252AbhLCNkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 08:40:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8725C06173E
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 05:36:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7so2410881pjn.0
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=MOLQR8mevyA52OCMDtB/DQRrywquOz+wMeEsbV16LIg=;
        b=ltUmekMqU6NCuW7ZfwjdyfSwV1ZwnH9MUuWhsL4eeYmqhTXI+gRbkC02O4wDEGGcPE
         PB1k/QHQWSdTj7eJluviedCHuG7dOqLmX7+/PkRXsSB3QTSb4wHx7nU7jQlTQV1AiGxh
         fJJn9Lk7FkBq+ee8jcP4nkYhbNUW3GydovdpI9Ff92IK6mN1DzW8wvqqTYgT/qyXQG8h
         93I9Xx+P9Vw/v9ZGv445DrVOxdQfbrjyOWS3v227iw2EJxYD7Bg+vWlAgafPiJ0Huj0K
         ckntJGpdDzcVcPsV2bA7s9Nro8NxZ2PlFtuCgxOYUaqMlUrvnu7BrWwk4jFNkL+kCZEL
         oGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=MOLQR8mevyA52OCMDtB/DQRrywquOz+wMeEsbV16LIg=;
        b=N3//9zhtI/vJhnIkYoSm4X0B/F0ZqyFil15ZxiYY6PI6o/Z7+aKAnCZoNr5PZ6B03J
         JPQpNGu6vTcV1uAE/WpcRs6IUGwHTDYTuu2hCAHfs2JiXEe1M+IQjnxYVCRvlqsFxPwx
         uCu2InC0UkWkdjHURLZMIptvl63+VxcqO0FMu+O0L/yMqYjWeFQHPa8fWyJLSCI6ta2Z
         t1Ol/hWL6EJPq4OqVst7BCUpSYOcPtCh52/ri/aYCpOvy2yxmxuzxLCPv+Rk12Hx/4aG
         vB9UwYlgK4VsYGiqY0RGWpxHZ66n/uyWn7ntp5Cp4+yk2W27Oc/kk7gkaTED1yU1QzqH
         ZJ4g==
X-Gm-Message-State: AOAM532jJhSKY9W1/L5dAz2JgQTdqVjMklTUQSrYGwiAH4wa/CFHOXAU
        QdFHczc3ejiyZx4domWQG/7AcvdghUOEhLNa
X-Google-Smtp-Source: ABdhPJwdSOK+P6oeZ4YEuC/pr40/cq8XIBVnsza2S4XGK1SFZzdUhXC1HuHEfeQHFR+6qmO9JZ++eQ==
X-Received: by 2002:a17:902:e5c9:b0:142:53c4:478d with SMTP id u9-20020a170902e5c900b0014253c4478dmr22138189plf.33.1638538609972;
        Fri, 03 Dec 2021 05:36:49 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id ot7sm5986837pjb.21.2021.12.03.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:36:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211203081703.3506020-1-ming.lei@redhat.com>
References: <20211203081703.3506020-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: null_blk: batched complete poll requests
Message-Id: <163853860815.273619.13690960637416723178.b4-ty@kernel.dk>
Date:   Fri, 03 Dec 2021 06:36:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 3 Dec 2021 16:17:03 +0800, Ming Lei wrote:
> Complete poll requests via blk_mq_add_to_batch() and
> blk_mq_end_request_batch(), so that we can cover batched complete
> code path by running null_blk test.
> 
> Meantime this way shows ~14% IOPS boost on 't/io_uring /dev/nullb0'
> in my test.
> 
> [...]

Applied, thanks!

[1/1] block: null_blk: batched complete poll requests
      commit: 2385ebf38f94d4f7761b1e9a4973d04753da02c2

Best regards,
-- 
Jens Axboe


