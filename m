Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039B0C433FE
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiE1MVA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiE1MVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 08:21:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC31E3F0
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:20:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x143so6525989pfc.11
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=RoMqQf8W8SliVlnivaAh0H42j5dJae11noFwMPMPR8U=;
        b=FfGczZICGPjughJ1kflvcCs9VfyGXvmr71CwKo81TR3q+NeAj84zs2ZFL8Cn/eB2S3
         NGX+AqTrEpjKFCQ3FCTXnx6H5e9IyQaAyT01uziL8akbnFlx1OeKpEMRcSCr9Qtp5agg
         CnKys8pALu46LoziKDqtv1yavtpah1y1ZepvCTIRmE538xa2fAriQe317dmc47ZpP5sE
         lTn47keJNxn1r5bU4IWkmKWU0jowXDz3eKlGuFNgwSwyoe5XO80YfiwvwbAllJExqsib
         GsseWt7WVifkK/bCmQBpXb5TOb4Gri8w2YGMT2VNKsZurao7Ei6Hayyx34IzxrPfhHB+
         wUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=RoMqQf8W8SliVlnivaAh0H42j5dJae11noFwMPMPR8U=;
        b=LE7lOkxr/4IzVDiOqXw1vRXUO7FUDE7+tGm9Ea8E+BFlNbCXZtPUqO3ulgEQPi3Fk8
         yJbm9Ln8/zgs5J03ngv28sdF2qvVS12KpsBR+zbTK0OQcnP27V+W1HmnIlww891Y7p5t
         PuZ0bVOYbx4Tf31+Uhh5rNsNe5Ngn7XCzd1KsCIkkEhahJCuu41vlXvbIG9PuKqsZwS3
         XbI5lOfCx29GGBSL93fcf+y8W4NY/09Xo+MuuZNNj3ML6JL6MYLaINnoAkk6mSJoy/Si
         sfrHiiRlLuz9SdGtM2uqaBwe5BuDKlwJhL+VMKSKfCNBhqsfhf+QUqjZGLbYjM2jn9oI
         NZXw==
X-Gm-Message-State: AOAM532/iNInRmcrofJsmEoJ+R1Ouj+842uLzd5wzWxNN/Zdf7erCcwv
        v4fb7rZ+VbtfAnPYqACFZaszDagCYe7ndA==
X-Google-Smtp-Source: ABdhPJwigl1qtySWCV2s41x+5NR7Hm1wu7CUqtRcH52VHAVX5ZxbN0JxCCdv5uiZF2cHJKUjXKlmMw==
X-Received: by 2002:a63:914c:0:b0:3f9:195b:ccb2 with SMTP id l73-20020a63914c000000b003f9195bccb2mr34365845pge.7.1653740456092;
        Sat, 28 May 2022 05:20:56 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e17-20020a170903241100b0015e8d4eb208sm5488541plo.82.2022.05.28.05.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 05:20:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, linux-scsi@vger.kernel.org, ming.lei@redhat.com,
        target-devel@vger.kernel.org
In-Reply-To: <20220524121530.943123-2-hch@lst.de>
References: <20220524121530.943123-1-hch@lst.de> <20220524121530.943123-2-hch@lst.de>
Subject: Re: [PATCH 1/3] blk-mq: remove __blk_execute_rq_nowait
Message-Id: <165374045505.754049.8905617096889900246.b4-ty@kernel.dk>
Date:   Sat, 28 May 2022 06:20:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 24 May 2022 14:15:28 +0200, Christoph Hellwig wrote:
> We don't want to plug for synchronous execution that where we immediately
> wait for the request.  Once that is done not a whole lot of code is
> shared, so just remove __blk_execute_rq_nowait.
> 
> 

Applied, thanks!

[1/3] blk-mq: remove __blk_execute_rq_nowait
      (no commit info)
[2/3] blk-mq: avoid a mess of casts for blk_end_sync_rq
      (no commit info)
[3/3] blk-mq: remove the done argument to blk_execute_rq_nowait
      (no commit info)

Best regards,
-- 
Jens Axboe


