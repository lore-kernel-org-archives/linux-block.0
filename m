Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D904AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 14:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiBVOAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiBVOAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:00:33 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C781275F3
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:00:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p23so17107659pgj.2
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OYGvkou6t6u8e1bfgXALw0P6fudskRCL4vAoBoZnxTs=;
        b=lZAXckA4EooRL6Vftdr9Vv5S6wLf249lTZyVXKcW/hSqGnwtbrQFqEtI9tZhqd67Eh
         uq2c7k1+c81sj40hO2f2TUz/AjSaLESe84gHk8HNJ5+AW/He/KS6Z8nwiFXS32Uwu6As
         CUwYUa+G6ySDZRHf0HJ8eHIp2F6J3BqWhSGkNVB3U0fG+mOa08aFFNrYM9+kOdEvIhRq
         Db73IA4CBk9ObWq10BHB+lEh/jQZJnkxzd5NxTVpN4E4/VQ1NzM8AcqeH265NEibjyZN
         UdwWQHUXMKoXgUoSZLGLDnQV22J5KYUraCkp8IvEO1Pb+lY+sJGkoiTdCtfuWfAVs/MS
         SQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OYGvkou6t6u8e1bfgXALw0P6fudskRCL4vAoBoZnxTs=;
        b=AZ7oAi6v3rrLJ2Maxw33Ux+AuVwrmYc5KTxRyZ+pgRu2rR2Sti8tJU7oQa/8TzVjX7
         ksXYvDtpO8+Ap4mkUodwIqYc6r5jP6X6sBZq2RjHtu0ex26Ko8Vt8rBKJiqEQ+x4xjSZ
         EtyLYpa47cwUkKV1J+CZpLGF/apFqxfCU/6Nd0gMs+fK532r+UJ1GBEGSFufB+kQAD2z
         A/4ZtNaGToTcjLWC3yENwycB9FkILafgzAJa+7aCJ+ooEfcDgbQ535oxJE5PkadU/AXm
         u3is8UCFYPmOyuj8tdS7EZ217QiSqq3NhXh99LGztD+ux+Eqwsu7Yx7tLFpikqFhGi2c
         1RNQ==
X-Gm-Message-State: AOAM531XpVVBzpkDgbFdFlXx3SpCd7T2DOaS2KTdCl+kaHyRB4YdaHUl
        L+A8pHmiJ0YZjcQVBHnSktiHrw==
X-Google-Smtp-Source: ABdhPJwxUq4rYahW3uu0UEQDGfs1WW+/+oCdiiFWL56ktdrW6ecztEhsIAFjWsT40OJfk5UK7xhMkg==
X-Received: by 2002:a63:2f87:0:b0:374:4ebe:2048 with SMTP id v129-20020a632f87000000b003744ebe2048mr7265092pgv.157.1645538406837;
        Tue, 22 Feb 2022 06:00:06 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d18sm17641501pfv.204.2022.02.22.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:00:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220211090136.44471-1-sgarzare@redhat.com>
References: <20220211090136.44471-1-sgarzare@redhat.com>
Subject: Re: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
Message-Id: <164553840592.21302.5942854488206786597.b4-ty@kernel.dk>
Date:   Tue, 22 Feb 2022 07:00:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 11 Feb 2022 10:01:36 +0100, Stefano Garzarella wrote:
> iocb_bio_iopoll() expects iocb->private to be cleared before
> releasing the bio.
> 
> We already do this in blkdev_bio_end_io(), but we forgot in the
> recently added blkdev_bio_end_io_async().
> 
> 
> [...]

Applied, thanks!

[1/1] block: clear iocb->private in blkdev_bio_end_io_async()
      commit: bb49c6fa8b845591b317b0d7afea4ae60ec7f3aa

Best regards,
-- 
Jens Axboe


