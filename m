Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F243C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 12:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiESMwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiESMwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 08:52:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D845EBD2
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:52:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 31so4965266pgp.8
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=XBvJMrl14EnC34WYBVBw35o7wIoCcHMgKelu8t+rPK4=;
        b=QcmoNqpX1VO9kAs3ivBI15PfPUrgIwce04JLhOsVqAD7YVEdH2mSpYmYshlfgg9tTR
         i9N493MYyx5kSNoYMRadJGGqI30ivQdOhf1aWzq2/Z0Qc1iU5Xw+B0eS1fDtqJJfAyF/
         7F/VnNXK2aKX4XbYIZwVBrcQb8u5FmOdt74xcZGbAPo46eAFMRj3GzHa/r6bpTachOOj
         S8qxZebT82hCvmpYru774OKbsZkXTQFAvNciw3wF6tvR1Z9pB0iojsA75MPnU8n1ibBT
         +VxijKfFGafrv5U2JxTJNNx4trI5auSmblBUNijMFahGQ2GzqKmV1EfW4T8oT4J2RyUQ
         rhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=XBvJMrl14EnC34WYBVBw35o7wIoCcHMgKelu8t+rPK4=;
        b=uGo7sTszN7HLaCahd+G/hYYzGtEePY8sMtHkDeC7I/BEQYuauaSD4BefLM2TI/m4se
         iv3hsdNLm5XyNp1OiijPlY6BX4ZtP7XvrEFRDzGbK3efrPoiOpBGZr8sgi274uLIIExS
         A/cVrqvxLk+PavENPEFJWPFi2Lg2dm+hmach5rE38GQgZz+7grpizjB/7inDQEglDXfD
         m850ql8fYmo3QVkdkcR49lJIb+pvo9swh91RO6zatvPPa9KVjRojAI1nw8K7jugzVUhD
         e8F+TH5Cb1QPMhkYkP1VlT2IKWvl4Cv83O0Z4g2GkDW+xdCp0sVevm2kunqwVFJ7WhbG
         CvnQ==
X-Gm-Message-State: AOAM530BO7DbubgOSplRFWsJPetSjNcXhD/elKAazhQ8/QYu3ZYCByKT
        93sJMOs4j59b9MvntOYvrrZG0Q==
X-Google-Smtp-Source: ABdhPJwHmZPlAM7IpzSh9YZsTPk0t6DVSZIqFFAGrjeRLl1aROMXGBClqrSJ1yX4gW190vyNF+amJg==
X-Received: by 2002:a05:6a00:1891:b0:50d:e6e7:acae with SMTP id x17-20020a056a00189100b0050de6e7acaemr4647371pfh.26.1652964774074;
        Thu, 19 May 2022 05:52:54 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f13-20020a631f0d000000b003c6cb43a9aesm3489136pgf.41.2022.05.19.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 05:52:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, jack@suse.cz
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220519104621.15456-1-jack@suse.cz>
References: <20220519104621.15456-1-jack@suse.cz>
Subject: Re: [PATCH 0/4] bfq: Improve waker detection
Message-Id: <165296477295.22920.8265546871543348179.b4-ty@kernel.dk>
Date:   Thu, 19 May 2022 06:52:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 19 May 2022 12:52:28 +0200, Jan Kara wrote:
> this patch series restores regression in dbench for large number of processes
> that was introduced by c65e6fd460b4 ("bfq: Do not let waker requests skip
> proper accounting"). The detailed explanation is in the first patch but the
> culprit in the end was that with large number of dbench clients it often
> happened that flush worker bfqq replaced jbd2 bfqq as a waker of the bfqq
> shared by dbench clients and that resulted in lot of idling and reduced
> throughput.
> 
> [...]

Applied, thanks!

[1/4] bfq: Relax waker detection for shared queues
      commit: f950667356ce90a41b446b726d4595a10cb65415
[2/4] bfq: Allow current waker to defend against a tentative one
      commit: c5ac56bb6110e42e79d3106866658376b2e48ab9
[3/4] bfq: Remove superfluous conversion from RQ_BIC()
      commit: e79cf8892e332b9dafc99aef02189a2897eced24
[4/4] bfq: Remove bfq_requeue_request_body()
      commit: a249ca7dfbce1eb82bcd3a5a6bb21daeade20469

Best regards,
-- 
Jens Axboe


