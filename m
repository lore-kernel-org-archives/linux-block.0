Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43AC38145
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiIHOjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiIHOjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 10:39:16 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B27146626
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 07:39:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n202so14225099iod.6
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=rzm8TQHe9gl6P7pIMQLwU11bCbB3fo6dFTISRAfXJZE=;
        b=UntEMM9h4WWHfaUsNMwGapgQg1DErJ+mXNDRHnZzJAAvVYkppfo6gJ4VB2GOYnKOq/
         6YRMRAOO+5stEtJExJLUatN16oR5tIhW0X4aSMisD5Ou6nlmSU6ytXhbld6nM9wt2fq/
         LIDmdh7SfsaXx1fbCkGU9rhSmnZ1ieKr5Kg7QaDYB0v8cvyNMbyJU0k2Xs2oTBP3KCeR
         PGVO/6bAnm7oPmVGnIDRCEVK+LF189bjsLm7bku7PCiP20v1P/oEJZfoD4gZP+8QXYI4
         iuv+nXyzo66gfrqEXLhEAoUvaX7KHhCeWWAcfHLiLC4j9st2Mu4EcmJ55FEGB2K9kCRk
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rzm8TQHe9gl6P7pIMQLwU11bCbB3fo6dFTISRAfXJZE=;
        b=DipDTCVH2MKOlI8TrBah/fnwYIGI7zBzYika+l6ISzyGNattuKdQQD99Hpjb1gWGK9
         /joOTVJ9RofeuWTkVcvKOyYbQ41p1HlIiBZkPdJGKM/fveBrH8rXUUM54adj2LDW95HD
         HmHixpPFsSbhKEpwbhR4fQ9RziF3Zec7BuwJxgN8QPPsXBOJMDWIUOjdmwZT6z4kHbhU
         TH+fVstergV9ghDmJNAMqjQEZRTejFKO1KqNXaBHpe8i0/toiyk7ZA/CCku0D1YlUd+r
         9rCIXF71xqILyn6CNcbmose76eb1HayyfpGT0rolpRdvOHCBjk3c4qDJyjHcMC0hongd
         Qwxg==
X-Gm-Message-State: ACgBeo2/WB5YnuTdfpVktc8FsDhXdrNl+MKme9PMXVMFfckQJo1eQMG5
        qA/BScSi009ZLjBX1x00z3hbJMSnbEAYNQ==
X-Google-Smtp-Source: AA6agR4SLtTpmvHBLjqvB4W/gyaaF1tbTBeaMZhtiocEcrjhJ521UkFXVUMQd2calUHLTqI3lcNmew==
X-Received: by 2002:a5e:9417:0:b0:689:f25c:6f7d with SMTP id q23-20020a5e9417000000b00689f25c6f7dmr4140607ioj.123.1662647950096;
        Thu, 08 Sep 2022 07:39:10 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q5-20020a02b045000000b003572ae30370sm2137453jah.145.2022.09.08.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:39:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>
In-Reply-To: <20220908130937.2795-1-jack@suse.cz>
References: <20220908130937.2795-1-jack@suse.cz>
Subject: Re: [PATCH] sbitmap: Avoid leaving waitqueue in invalid state in __sbq_wake_up()
Message-Id: <166264794928.470510.10920690449555414358.b4-ty@kernel.dk>
Date:   Thu, 08 Sep 2022 08:39:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Sep 2022 15:09:37 +0200, Jan Kara wrote:
> When __sbq_wake_up() decrements wait_cnt to 0 but races with someone
> else waking the waiter on the waitqueue (so the waitqueue becomes
> empty), it exits without reseting wait_cnt to wake_batch number. Once
> wait_cnt is 0, nobody will ever reset the wait_cnt or wake the new
> waiters resulting in possible deadlocks or busyloops. Fix the problem by
> making sure we reset wait_cnt even if we didn't wake up anybody in the
> end.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: Avoid leaving waitqueue in invalid state in __sbq_wake_up()
      commit: 48c033314f372478548203c583529f53080fd078

Best regards,
-- 
Jens Axboe


