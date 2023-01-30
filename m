Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F0C54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 16:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbjA3QnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 11:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjA3QnD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 11:43:03 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4094EC7D
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 08:43:00 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y2so1137751iot.4
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 08:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpgjZckYLztvcV7QaalQFibYSLZqpEGZ7gtC9W6bdz8=;
        b=Afcz2fTE+YSsGPS35qV0/dfhcg6EXXNCfjLLjhvWFbb6GTv/9L4aeaZYTTtgqudl44
         KMdzZnO82RoyAdsvs/MR5PW7j4ZMMkBDfV4ZdzqfRbzaNk1NhPkgLKFyU72OV4uRVwrn
         utN2m0aauf8YznDYM5xgLLkoo8GR7bBdrIyMH2qAD43GSyYbxI9Gb0EvPVQtocm+EAKD
         u883jNUA/Tri8FNC0e4V6+Cel7P1Vm8K6HXkJzYY/mgAGjhtakdP6cBhSb9q9bZbON37
         Oz+BuqkCVVngX0T3E//8ifpDbB2Gz43EtRcXWCD1RREav8a9KQOtR+npJwl80oDzupQ2
         j7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpgjZckYLztvcV7QaalQFibYSLZqpEGZ7gtC9W6bdz8=;
        b=yoopVHSH3CnUd1+Bxas2wE2aUW20oCw4casbr8h5yzauKOsPFHBIYv7cUUgUFZK+7H
         SzHl988koEr15E1F1RNZsT4x4LjZxrRSLQndjqK99qMC23t0gM/zeZlsiqDnJJvmYzwa
         U9qtfM7/g5VT+OL8S8wx8m6pxfBpENNivCX0bf6y97j//LnSe+WiZ/0Xc4nnOkuFJezK
         jj3Jri/6C3fz2WqSC/BcxESLg+1jqqul4bMGVYmXcwBuLVXlf7q2WwSNG9h0jxLdKZg1
         JKUAjVrNFZQGC5qZa6MlYhY+6v4ao2lpXIge2VF/pBQPfdAW4CjcNkoOHNhKpDIeJgLO
         aLeg==
X-Gm-Message-State: AFqh2kqR1+G47yJ9A5Q1XDOaPWvC/ROjU65neJYDdopjqR2lsC67OwTS
        4X5kCSpyOspiKb9j+iVRrSPJ5Lwda2EGU+sV
X-Google-Smtp-Source: AMrXdXtnhT4UZe4nXa9KXjxZ0fYwopxfn3O5t7qzwwKB75N7Bao7hUdLU/LFIAHTV1KsEZDNkV50TA==
X-Received: by 2002:a5d:9e4d:0:b0:707:6808:45c0 with SMTP id i13-20020a5d9e4d000000b00707680845c0mr6332948ioi.1.1675096980275;
        Mon, 30 Jan 2023 08:43:00 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638169000b003a432de0547sm1858710jat.163.2023.01.30.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:42:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130121240.159456-1-ulf.hansson@linaro.org>
References: <20230130121240.159456-1-ulf.hansson@linaro.org>
Subject: Re: [PATCH] block: Default to use cgroup support for BFQ
Message-Id: <167509697947.219033.9483130158448775537.b4-ty@kernel.dk>
Date:   Mon, 30 Jan 2023 09:42:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 30 Jan 2023 13:12:40 +0100, Ulf Hansson wrote:
> Assuming that both Kconfig options, BLK_CGROUP and IOSCHED_BFQ are set, we
> most likely want cgroup support for BFQ too (BFQ_GROUP_IOSCHED), so let's
> make it default y.
> 
> 

Applied, thanks!

[1/1] block: Default to use cgroup support for BFQ
      commit: 4a6a7bc21d4726c5772e47525e6039852555b391

Best regards,
-- 
Jens Axboe



