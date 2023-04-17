Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30DC77B76
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 13:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDQNsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQNsk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 09:48:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345121BEB
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:48:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2465835cf6fso764754a91.1
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681739318; x=1684331318;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHg8YyCx2xNTrsopj4h1edhvH1uexqsIIEbf1PiCdJU=;
        b=cTT1QFY3N3vCQgxN3UdgC4oWj8Nv/WABDvSZ4XliH7WQy6NObF7JURr0Nn0w5n8F5y
         5vdR1p22xGRuKM1sO0lDiWRMCVkjPppZ5oz3ymUBOGjkPU9Yl6L0z8ksSkCMhWl/PdMD
         Vd/uaIHE5/sMukmGe+x06ggs0hhu1NTB2GfprrTFDHytML+DHk1xGYNuXTrSTBbvmYU8
         rAerxB2i9QooHWWqN9y//KklB2mhh0zW+rk3lKYYjgM/y6xt+DR8aJq+lfrfejX1FvmC
         hphFA6Zjrs2RaZa7OqmLJo01jrneng6BjbhuShcHe7+BZas5pUaQRLqeRTULkZOekHY1
         5oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739318; x=1684331318;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHg8YyCx2xNTrsopj4h1edhvH1uexqsIIEbf1PiCdJU=;
        b=I9KoJAub7dyazxPcN5riUXfBMJ6xt6Tnvf/dFTNuOYM8z/NMl3gQmHvmcqSxpKoyCV
         td4ZteSK7WgvvBy6T0YPeRdTXUoHdmcsJwJ+L0MuZ0ALSBLWuWItMn9FhQoIFI5/9fLu
         O8TLcEM3S1xrupBAlSZ7APXO/GulkWbwJ3DM2i2WmG1cAe4Wcqm7Z+Assk/Fw62lXSIq
         DOnfSDRNtsZSzrF8KySwblph6tcGlVShnEybaxfBotyjK6BryYYuy37C4tn0F2DNJpE0
         XsGsf8mdu9wcgsvyVu65cGZ6e16E9IwSAN7fA9YhWl9fNUylPcYmngga8SjpNAwXNZ9B
         PQGQ==
X-Gm-Message-State: AAQBX9ck05FBkZk7BUng68f/upwRT0xLuM79zbR7vhCQ8XQHKypJAnY8
        m/qYLUvGfsGRLeXFZf57nO1V7w==
X-Google-Smtp-Source: AKy350ZsvqcPhW6H6wNx86fi0atUBZQkuxHTaZ57q1x/i9eRxrLUDxUCPD/Jiw09W1ZiGmH0vxoyxw==
X-Received: by 2002:a17:90a:19d1:b0:240:c067:6f50 with SMTP id 17-20020a17090a19d100b00240c0676f50mr10207702pjj.0.1681739318596;
        Mon, 17 Apr 2023 06:48:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a088e00b0023cfdbb6496sm8927319pjc.1.2023.04.17.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:48:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
References: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
Subject: Re: [PATCH next] shmem: minor fixes to splice-read implementation
Message-Id: <168173931746.319007.17265276905089710599.b4-ty@kernel.dk>
Date:   Mon, 17 Apr 2023 07:48:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sun, 16 Apr 2023 21:46:16 -0700, Hugh Dickins wrote:
> generic_file_splice_read() makes a couple of preliminary checks (for
> s_maxbytes and zero len), but shmem_file_splice_read() is called without
> those: so check them inside it.  (But shmem does not support O_DIRECT,
> so no need for that one here - and even if O_DIRECT support were stubbed
> in, it would still just be using the page cache.)
> 
> HWPoison: my reading of folio_test_hwpoison() is that it only tests the
> head page of a large folio, whereas splice_folio_into_pipe() will splice
> as much of the folio as it can: so for safety we should also check the
> has_hwpoisoned flag, set if any of the folio's pages are hwpoisoned.
> (Perhaps that ugliness can be improved at the mm end later.)
> 
> [...]

Applied, thanks!

[1/1] shmem: minor fixes to splice-read implementation
      commit: 72887c976a7c9ee7527f4a2e3d109576efea98ab

Best regards,
-- 
Jens Axboe



