Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5627CA0FE6
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjIAPNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350148AbjIAPNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2023 11:13:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77B10D2
        for <linux-block@vger.kernel.org>; Fri,  1 Sep 2023 08:13:33 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34ca6863743so1806385ab.1
        for <linux-block@vger.kernel.org>; Fri, 01 Sep 2023 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693581213; x=1694186013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edIR+17IRvQEwvaIneCldAoQziG2QEd+kuiT3QxzLp8=;
        b=fUqxqROy+5EJ/mMW95HeCr/kNkK50OcY6sVGcvE53eRVqAF2ReE1qZwMO/ULPZQOVg
         TeyrcFYrl3pK81VgklF5G1dVPALhJ+sP9BVgndfr2TUiNKb+RKWHLApyzOpEKEK4v0TI
         NsQgJRfZjp1V6tVnyWtkqbPlnt9No8gCaWEFwxuag1/P4WM6kFgu3K2D25ToAhzxFDW7
         bVU/LrAiWOGbAL8c1qRAGToYdr5n3h0Kr8wxD7t5bJsA7kDBuIl2/zjTUT9oXPVmY14w
         pT4Qz1H7QGhTdESQrv/4E4C3zuRTVa6Wdm5lyjlNgslBAtSx/Z1vVHrrI35GcPiSwIsP
         qjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693581213; x=1694186013;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edIR+17IRvQEwvaIneCldAoQziG2QEd+kuiT3QxzLp8=;
        b=IMav3sarR3jXILk+eGUUVdqPVyUD20TlFLLxviWo9M0/6PFU1j/iNTY5sCrE3nI+1R
         R6YsSt8IZ1upn0aY3PYWVlzkodalXgYIzu6vVzhMzfXskyq/LzBsZj7IGPhzKcK6HINX
         hvLb9kcgS4F68il0d2lc7aMsMAlRLFFhdIhq/hZ5aq4BI9xHNTpDhGUZgiefv6RIwfeW
         jo9Flspu6aocdcvFALexk0yvbeF0S5YAZd38MHwENl1XHhSivyLmVY9PbaFlqkAsxhoe
         3+lxxRyhedoOPMgGtHbOLadRSuN6kwN+XBXRsP/G+9USM+EksagvLv6gvpcAIzUp7W6H
         MkUA==
X-Gm-Message-State: AOJu0YzXplCYnymRuU86hLDIaJ/a4wgiP+GbXkzsm6c9TyYRHpThynrs
        MoTrk79reget2kHZVXzfpai4pA==
X-Google-Smtp-Source: AGHT+IGqlIx9GJ9FZunCEA6Fzch8LLHhTfhQHpYi/vWX0iHn1PyagtxMV9eMvflVEncOwxrnQt+syg==
X-Received: by 2002:a6b:3f82:0:b0:792:5f79:ef9b with SMTP id m124-20020a6b3f82000000b007925f79ef9bmr2525872ioa.1.1693581212733;
        Fri, 01 Sep 2023 08:13:32 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h13-20020a6b7a0d000000b00777b94e8efasm1096099iom.18.2023.09.01.08.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 08:13:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230901134916.2415386-1-ming.lei@redhat.com>
References: <20230901134916.2415386-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Message-Id: <169358121201.335729.4270950770834703042.b4-ty@kernel.dk>
Date:   Fri, 01 Sep 2023 09:13:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 01 Sep 2023 21:49:16 +0800, Ming Lei wrote:
> io_wq_put_and_exit() is called from do_exit(), but all FIXED_FILE requests
> in io_wq aren't canceled in io_uring_cancel_generic() called from do_exit().
> Meantime io_wq IO code path may share resource with normal iopoll code
> path.
> 
> So if any HIPRI request is submittd via io_wq, this request may not get resouce
> for moving on, given iopoll isn't possible in io_wq_put_and_exit().
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix IO hang in io_wq_put_and_exit from do_exit()
      commit: b484a40dc1f16edb58e5430105a021e1916e6f27

Best regards,
-- 
Jens Axboe



