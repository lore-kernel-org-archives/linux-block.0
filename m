Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EAC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 02:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjESCU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 22:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESCU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 22:20:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADFE4A
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 19:20:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-645c4a0079dso495085b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 19:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684462856; x=1687054856;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyZR3CXk9eblx3Piiqf00V5N9zRwPHTLyxqFqmAiBwo=;
        b=yWrkzEFZ2obKBPa1U3mmOKMs46LgyDtr9h0vYzZ8X98Jp4WLoji5Kg61xga7sMdC7J
         JsmEBAdC80h2jbARvjRDHLHKNtT0Ry2LTI+PNA8l91ScKNFJ58inarsiqACT6m4S4L9C
         ydom16KybCkVnlLEsygxejurmVcqQyWoRr54RcSSJkKpN0r4+b51njsKS7DCyL6HmrY9
         jFGjpVIscdW/lyTDF7McP6JZAv/iydOUsBKl16W1xcGe50b0/Y32BQrGpkngKl4IEP5Z
         RCdseRVfzFUSiPa/fOQrahfNWzztcxIzFJTCNyhGemxGb+yyoSWe8hOagrw79mxzMgBC
         gT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684462856; x=1687054856;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyZR3CXk9eblx3Piiqf00V5N9zRwPHTLyxqFqmAiBwo=;
        b=XOxOWU/79NQxPh+gx6+EyuGnpbOkgfqsIlDRo+p7VvDEa1fvscaIypea5DbR+EoIlO
         uRWrVUsCE1NRK5UhK7zKpBjyttLKdjZJQ2xhoIHtpz8moz9IhufIazHJOJWtTf9fKb5Y
         n0wPmyC0tgd14479ia9tGtyZ+dpgl7xlYUYy+CU7NB0XvSSIb8UCLXuxA5i12T+yQCRG
         hXILKDD56107dX0ce15lYEfIn/xCSx+qk1KQ1RSwNcp22tUfvo0CdKvlWQ4KVZDPcqgT
         0K78Yp3YnzgH04+MIymg8kHvs/VgeDvecsWzBV6fR5fnRa5NXFFOrLpCHrnuJe4lZL0A
         h3hA==
X-Gm-Message-State: AC+VfDz9NMqdy7OrMqay2ozA221jY+F6dYPTO9UV7Gx1/l39SAbMC3oB
        gGHBdzIoFcw8NVYuHRA8tTBNt6Eld+ZUHyDKvkY=
X-Google-Smtp-Source: ACHHUZ5sn8B6/p4Eo+T2WpnPnEBZzEKfyptbiJp+VsZZCXnDz+jazBXlnxk4bIAZs92a2Te+fk6dQQ==
X-Received: by 2002:a05:6a00:319d:b0:643:9bc3:422a with SMTP id bj29-20020a056a00319d00b006439bc3422amr957628pfb.3.1684462855989;
        Thu, 18 May 2023 19:20:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n26-20020a62e51a000000b006460751222asm1967259pff.38.2023.05.18.19.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 19:20:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20230516223853.1385255-1-bvanassche@acm.org>
References: <20230516223853.1385255-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: BFQ: Add several invariant checks
Message-Id: <168446285481.154282.1950812675230012642.b4-ty@kernel.dk>
Date:   Thu, 18 May 2023 20:20:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 16 May 2023 15:38:53 -0700, Bart Van Assche wrote:
> If anything goes wrong with the counters that track the number of
> requests, I/O locks up. Make such scenarios easier to debug by adding
> invariant checks for the request counters. Additionally, check that
> BFQ queues are empty before these are freed.
> 
> 

Applied, thanks!

[1/1] block: BFQ: Add several invariant checks
      commit: 3e49c1e4a6152b6ad758a28ecce8fb470f46f6ed

Best regards,
-- 
Jens Axboe



