Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E0FA373E
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 18:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiJYSlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiJYSlU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 14:41:20 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6B5E670
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 11:41:18 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i9so7350165ilv.9
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXSxEHYnUhkUbZb6rFET5zyBIaSfPPsa4EsCa0wV7yg=;
        b=jyw166v+0YMUohw9j/zmHGY/9zSSB9FYPkXV3MIkVcNItcA036amlf43ouRcGQhfHN
         bW9ZsJeRIR4WEeZK778nS6qP5Urp07E+iRc9EjeVe2F7xs9Pc2SmkzPWJ6SUMHZYKRHo
         IUMYNicoGy8Rwn8nM+Js3Jd1T5c3SGuyne0X0lto9Jp2vsXjLxkxJR1MtxqoY2j71gNx
         n7SNA3MD9O6CnDIAZKO4VpSTWqvfulp957Y44LODTjrrpc+pUdxI0VlzAC5nVMng/ngi
         JdRREriNLVNYUgAK+yagUHHiRJB9ZhnNlWfFACWMHakF5uCTbT4DmTL1APkti9vkaACq
         FqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXSxEHYnUhkUbZb6rFET5zyBIaSfPPsa4EsCa0wV7yg=;
        b=IzxpwlsZH28gRNwZxmufd3M63XTNqAtmuzni++AmOrTX6szAVnK7fqE8d2mc9GGyun
         TLlBlyWj5wcdtvTe+oFkAl5EcXU4h2tgA7KKlisTsHHr4vjVvci7jS8VIkdqjnonP91f
         EPwvfN1PtqQ9x57xUarisqI1my3wMHhz6hVzT7uf8L2QyNgmCizGrg3VF47D6OT55/4P
         Hqu940zjOpIiSowe1YNMMclua+wig6mH9VjclxoEp3CAqEAdpqtPmNwu3pYXd4Et96p7
         6iwCyy6qaVfBT+GBctwqR5+8K+qoKO+SSjsn+6FLTUkTfjkv7U/HBTZp0N3dYKcYD9lE
         TLEA==
X-Gm-Message-State: ACrzQf0P1/UhInbSuYswGiL6OiTlOV9N+TDix/IgQmy4seIKSW7etYz3
        TgPY3OO9Ow73T9mE5JyT6JzT87A36WugLT/s
X-Google-Smtp-Source: AMsMyM6Asauq7jTSGKWXm/Zx4yt5HdSemhllxjO87Df7NveeBhxy1a0xbalLaLprlSEBoqMKlRIQow==
X-Received: by 2002:a92:8e0c:0:b0:2ff:c5c8:792f with SMTP id c12-20020a928e0c000000b002ffc5c8792fmr8348976ild.313.1666723277440;
        Tue, 25 Oct 2022 11:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r28-20020a02aa1c000000b00369a91d1bd4sm1133820jam.138.2022.10.25.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:41:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221025155916.270303-1-hch@lst.de>
References: <20221025155916.270303-1-hch@lst.de>
Subject: Re: [PATCH] block: remove bio_start_io_acct_time
Message-Id: <166672327669.26838.1363984765623637169.b4-ty@kernel.dk>
Date:   Tue, 25 Oct 2022 12:41:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Oct 2022 08:59:16 -0700, Christoph Hellwig wrote:
> bio_start_io_acct_time is not actually used anywhere, so remove it.
> 
> 

Applied, thanks!

[1/1] block: remove bio_start_io_acct_time
      (no commit info)

Best regards,
-- 
Jens Axboe


