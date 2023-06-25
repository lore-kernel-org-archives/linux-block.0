Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB36EB64DC
	for <linux-block@archiver.kernel.org>; Sun, 25 Jun 2023 14:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFYOB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jun 2023 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFYOB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jun 2023 10:01:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CBBE4E
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 07:01:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54f85f968a0so245555a12.1
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687701686; x=1690293686;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uDKsGbrtbD09x/jlcXoPrb6oJCnZF5XAL714KLvRCI=;
        b=W8aM85GTLzRx0exITUGoL7wHh3ElA7vwYCi78MpEjxB+xiQrBznlrsyP4gSRv+P1ro
         1a2t+aQ5XW8O4CVnTqRj/TK66W4iSr6yNkwui9Gs1ExqRbenHwfsMEn4Hv+otWw+USTd
         unnBIYpz+4TSRdGBK6xnVV2k654da60hZ1fBYtZFLW2X+LxdhNJZjMwlYgZnuEqXzg0E
         hXl5S8LdPwqVjFgljPy8YEqxBzmRJYMqnb83iDHiwjyJzHFZB85LV52HJFylE0Ct1lFY
         q6ng90DOPXmwiqW0lYudRKEbKe+Dy0E1GpSbvCKjPIjf25sv0EZIITGq93hqfJVqfEs4
         b6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687701686; x=1690293686;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uDKsGbrtbD09x/jlcXoPrb6oJCnZF5XAL714KLvRCI=;
        b=ClIbu0wosvhdtuQp7+kauMnsAiMiKtdjPHrGkW9HKJ+QpVbOAdoKEES3xqhi9nuxIn
         8TEx4IJnrKi7pujMsitLkUPyqJ4pgLuQKaIhDkXK4OaqJpr8HUjkaDFnc9A+oKAaDXf3
         e+O5b/TTsJpeuTa7MpNBCfWSZ+FCvVImXuvHfdVZfWx3xWS58081/uBymgpZ1rCiJFub
         ID5FMYGLPho0Ce1yNJyt4tcG/t39N7T6BybqEF7rTR7sR0OcL6r9gdLct1qMBOx46g52
         FcMp304W5AfAin+T+lNFWMweUrKbMWTKzZrSBFdTi4iiXv6V2JCZuDe6daVZyBDjQIlV
         PiDg==
X-Gm-Message-State: AC+VfDwXxScM7ELAGykM/XGNvG1jTKMk2PseAdZHZNoHe49k7hjdN+bU
        Ep4HE9U0mCE1Z2NINhn8LxSHDJ9NjjwnBkRfF0c=
X-Google-Smtp-Source: ACHHUZ5QpD5QuDZprNvR8qgIcM/WLRxkls8lRjlLvaxvwbHLOcp2JOBOmu6O10elnz8/g68+nX94yQ==
X-Received: by 2002:a17:903:230c:b0:1b3:ec39:f42c with SMTP id d12-20020a170903230c00b001b3ec39f42cmr33113619plh.5.1687701685926;
        Sun, 25 Jun 2023 07:01:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w24-20020a170902d71800b001b7fa017498sm868215ply.124.2023.06.25.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:01:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230624130105.1443879-1-ming.lei@redhat.com>
References: <20230624130105.1443879-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix two misuses on RQF_USE_SCHED
Message-Id: <168770168458.14597.17658009222272198872.b4-ty@kernel.dk>
Date:   Sun, 25 Jun 2023 08:01:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 24 Jun 2023 21:01:05 +0800, Ming Lei wrote:
> Request allocated from sched tags can't be issued via ->queue_rqs()
> directly, since driver tag isn't allocated yet. This is the 1st misuse
> of RQF_USE_SCHED for figuring out plug->has_elevator.
> 
> Request allocated from sched tags can't be ended by
> blk_mq_end_request_batch() too, fix the 2nd RQF_USE_SCHED misuse
> in blk_mq_add_to_batch().
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix two misuses on RQF_USE_SCHED
      commit: c6b7a3a26e809c9d2a51ae303764c1d2994f31cf

Best regards,
-- 
Jens Axboe



