Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0A5C38145
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 15:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiIBPqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiIBPq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 11:46:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2975F97
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 08:35:08 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i77so1900580ioa.7
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=kmWx6GQdEOtF/uL3thdhLU+yeJiJgGxBRHmkDdY8oDM=;
        b=u022k6EYXiOXMch99qyEGcZPDNWmlAKj0DNCn+w1cCZ1xdp4kimxRT8y3JB6kTXXlu
         dJo1S3YC7adSKZULoccPxd/74sppKhrenMLOSlqKR7V//ezSBTsQSZOFsLUhCxXFxcSR
         b8krgNQFz+GYhd+MnQAN1zJ9CfU6vp+uecvw604ydbfuULNwxQC+fUrnVy22Vgbod+Tz
         ZPMCX/M7xo2odcW06zRyET9u7dAaWHMw9pS2mXqYGngdoAuSkPEBztjWYyv3LDp/TYvw
         0J5S3AmLE0BA7OAdA0JM9ySULTOK7k+fSmc5cKMP3F+L4vOAo3/WKAOKeOuzXrUqppei
         L3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kmWx6GQdEOtF/uL3thdhLU+yeJiJgGxBRHmkDdY8oDM=;
        b=jIgf+O3mScJIMkhamlddm+WNrxg3L/h759WjthNpZqbU9qXUYEIJOIV5Fvoh+Kr13V
         8snoWopt/CkYz/iKJoVXdHRzSn3ScMNGzDvR4DVfYTYE8ZOkKhir3IvapCzt7Cv8nzC5
         k1sFWIKfs/Uoq+5bnra4ulYB/v7EDuBqlFqN8wPHh9/RFazIVmOlfIoXhVcTQWOzvw9F
         AqqXr5zRMCdI9SfLWCllm5WsYcbAFp6CqTk67+6UVMlh14peJLcdn3Sl/PxpmWJyCn/H
         lm/7ce5iulaQfJalxfKMSLQNqNi26kjJbJ8RwQ3fbXPZLZ8CB6iU9ATWjd4G+IiFg5G6
         FF2A==
X-Gm-Message-State: ACgBeo2c1gJaeR3PohoPlGe/L4DaTQijJSrmNNgdIMw1AOiBY2OGu50S
        j7o6nTsineieAjGpBvOx9aqcmMxESSdySw==
X-Google-Smtp-Source: AA6agR7vi1T5kgnb2NiyyRAj3pUZQ0IJrIIFQrve79mFhm3NWuLo63V9wBE9wZcZmYId2u5+g2bnsg==
X-Received: by 2002:a6b:ba44:0:b0:688:876b:61c6 with SMTP id k65-20020a6bba44000000b00688876b61c6mr17159855iof.51.1662132907624;
        Fri, 02 Sep 2022 08:35:07 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i3-20020a02ca03000000b00349eece079dsm946495jak.35.2022.09.02.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:35:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     kbusch@kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        asml.silence@gmail.com, hch@lst.de
Cc:     gost.dev@samsung.com, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220823161443.49436-1-joshi.k@samsung.com>
References: <CGME20220823162504epcas5p22a67e394c0fe1f563432b2f411b2fad3@epcas5p2.samsung.com>
 <20220823161443.49436-1-joshi.k@samsung.com>
Subject: Re: [PATCH for-next v3 0/4] iopoll support for io_uring/nvme
Message-Id: <166213290569.98725.590739918203033888.b4-ty@kernel.dk>
Date:   Fri, 02 Sep 2022 09:35:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Aug 2022 21:44:39 +0530, Kanchan Joshi wrote:
> Series enables async polling on io_uring command, and nvme passthrough
> (for io-commands) is wired up to leverage that.
> This gives nice IOPS hike (even 100% at times) particularly on lower
> queue-depths.
> 
> Changes since v2:
> - rebase against for-next (which now has bio-cache that can operate on
>   polled passthrough IO)
> - bit of rewording in commit description
> 
> [...]

Applied, thanks!

[1/4] fs: add file_operations->uring_cmd_iopoll
      commit: acdb4c6b62aa229c14a57422e4effab233b2c455
[2/4] io_uring: add iopoll infrastructure for io_uring_cmd
      commit: 585cee108ddaa8893611f95611e32ed605fc6936
[3/4] block: export blk_rq_is_poll
      commit: 2dd9d642edf01043885cefeaaa06d9c8e1aa4503
[4/4] nvme: wire up async polling for io passthrough commands
      commit: 5760ebead11801cdb73cdf3841e73231968f6af4

Best regards,
-- 
Jens Axboe


