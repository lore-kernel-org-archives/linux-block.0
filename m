Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402E3C6FD1C
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 21:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCTVAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 17:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCTVAA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 17:00:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25888252A9
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 13:59:50 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h11so7154260ild.11
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679345989; x=1681937989;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2xtN+cTIO7H6iYMw46QYaYZEP/mnMZnzY869dDWxEg=;
        b=AO2z2Z0BFhA7itRoYIdGbWfs0r6HDbRjYfq3xhODwdTLXjVqNtPnkFpPkrDItl74o0
         /LSsb6JC1HuESORvq7QgMuiX7Bco/LvZqIkljGcNxaTrBNw0nMbNux5mTepjsEk7koxI
         dFw3WG0OwXYv/65eS7EHLlsrWxM44NsE2wxbAhXaP9naB4n4uEM2DMYHBO42DpfNY1RR
         KC7tfO+xPeu2/S4z3AcMVuw0vQ6KuqHmWpfbOf5NIMzq8A1X8TWqZ0042I41kU+FeavU
         6VDvHuTJvhrl9mjwjDn0AhusVHJaHurHbgOK3EDLKGii+aLuO+maLir1Apt87KFRDjw5
         Xxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345989; x=1681937989;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2xtN+cTIO7H6iYMw46QYaYZEP/mnMZnzY869dDWxEg=;
        b=Z62I9g3RIIRfTq2e7BSegyZ5n/iiz+zrcENQ3OE3nCB4Um7u0rpMjk8i1Yj85PYdoi
         vKzBc5llpLo9Wv/di/5hS9YTJIUtO7QzoWsHYTR5tD47t6mOTbwurI5QLGvpm/6YKo6j
         HiXyf0ngFy94N8He+ZWRtWAOAbvwuYzCiDtvtNCMPFuw0BppWLpTAOCQU5w0Fl+lt0OF
         SoskOidtwjEHqmRVF7iF9tw8g1gCmXVbU6yX+J0zmMTfiWkKyAdohreCXmAz/bvcc84E
         H1bk1Ro7zMqqWXM4v1SK/9fWDDTMUwJm7KeMNBhMpl6kabht4OQVs1OW8hVaw2PF1sQc
         /YCw==
X-Gm-Message-State: AO0yUKUSLhncYyrbDFo0gWGrIbzwlqSEYAH5vPIIcs6pVklWEak5MGji
        me5S4YqU9B6NxPxcumlu7w6O2w==
X-Google-Smtp-Source: AK7set9xj4UHYy0IFuaTHn7N+HXwbXU4TOrpC2SyZrHI1fEwCbAzSR6n4ZRdK5ZyJ5zO5oAzZnXXsA==
X-Received: by 2002:a05:6e02:1a84:b0:316:67be:1b99 with SMTP id k4-20020a056e021a8400b0031667be1b99mr622199ilv.0.1679345989306;
        Mon, 20 Mar 2023 13:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f15-20020a056e0212af00b00313fa733bcasm3091366ilr.25.2023.03.20.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:59:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Keith Busch <kbusch@meta.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230320194926.3353144-1-kbusch@meta.com>
References: <20230320194926.3353144-1-kbusch@meta.com>
Subject: Re: [PATCHv2] blk-mq: remove hybrid polling
Message-Id: <167934598874.203909.14226439075837496354.b4-ty@kernel.dk>
Date:   Mon, 20 Mar 2023 14:59:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 20 Mar 2023 12:49:26 -0700, Keith Busch wrote:
> io_uring provides the only way user space can poll completions, and that
> always sets BLK_POLL_NOSLEEP. This effectively makes hybrid polling dead
> code, so remove it and everything supporting it.
> 
> 

Applied, thanks!

[1/1] blk-mq: remove hybrid polling
      commit: aa939e415c6c49cabcab2bc16fda2bc38ca0c235

Best regards,
-- 
Jens Axboe



