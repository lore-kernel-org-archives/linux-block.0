Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C74C6370A
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLHQUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiLHQUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:20:17 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDB98972
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:20:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id g7so1229545ile.0
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci+3PfpyiglqixiPuSVaZGmmOxJc3KL2hsCnLav5NDo=;
        b=JtlpyFhBidmmGXzwyIQUx71czI871BlSt3L6Cu34lKtW/mqg1ysBIaTbyAnqpNJ+jw
         j/M2ng1uYWeH0rhEr1GQMmPjdfIUpRNZQAX837vRTR1ZjsQTroguQQKqWNxZrL3qJ8kC
         FHO8j8jP0pPK8iEHPt9YbiuGylrsRbgU4TXc/yXFXpZjXeei2PsJazOevcj3EK/TNjsy
         w44RLGGWVYKWkyMcX66m/a3ePi33opzAXYFaJC8cgxJve+N1elxf0fUhwUHZZHY9SXAv
         H43hpZKEPdzQoGJXHb6nlntz4gEpRCB2FcxCBn6+wevJ6gdNpxXrimgWwGTY534K40pw
         0gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci+3PfpyiglqixiPuSVaZGmmOxJc3KL2hsCnLav5NDo=;
        b=toFYkd9Bohn6cWxvtjjcOH3FFK7zuP3tyneU5/MCFQ7a/br73qDSXglFhuS2j7ew/i
         RJ77n4GtpcaJXoB1jERpV6WGoDOaPNKzIxiWB4ybOPpacCkBrbW4cIcD0I1eyMI1Xixr
         JIxkh7NRcS2VaKKGciueD3kd6WznqntpLE1mXi78tH/z9fYuc29WTo6PGbtr9fDgdxcr
         qZOL86gxpE1KdA8AvyJstOTLQhI9xADfq928xAyIiBF4wFi9ATldFwvCKXmhWs22IoLd
         tzd85lgG10oloAy7/D/dYaefzm2eLE+Yz1R/wJ8AAg5oKARFdaXIwv4TJkVldaLV+aTD
         Cb6Q==
X-Gm-Message-State: ANoB5pk1F13DzjFkpXzQ6RUOwnqkXWYtUka/eVpbbVksv1MMQRZy5VHG
        xN5TnjtVWXf/2asgqOGga9LUbw==
X-Google-Smtp-Source: AA0mqf6hxwZIjKQx5wfXX/MpNcmbFhITIIqGlq/XzU3PUz00A0wfCErh6OmOg73Z5xAL3vO08Fmb2A==
X-Received: by 2002:a92:c9cc:0:b0:303:238c:fd17 with SMTP id k12-20020a92c9cc000000b00303238cfd17mr18520794ilq.227.1670516415725;
        Thu, 08 Dec 2022 08:20:15 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a10b000000b0038a5083cfa7sm3573087jag.88.2022.12.08.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:20:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc1d479b39e30fe70c4579a1af035d4db49421f56=2E1670069?=
 =?utf-8?q?909=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Cc1d479b39e30fe70c4579a1af035d4db49421f56=2E16700699?=
 =?utf-8?q?09=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Subject: Re: [PATCH v2] block: sed-opal: Don't include <linux/kernel.h>
Message-Id: <167051641487.134647.687585099750506382.b4-ty@kernel.dk>
Date:   Thu, 08 Dec 2022 09:20:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 05 Dec 2022 20:16:48 +0100, Christophe JAILLET wrote:
> There is no need to include <linux/kernel.h> here.
> 
> Prefer the less invasive <linux/types.h> and <linux/compiler_types.h>
> which are needed in this .h file itself.
> 
> 

Applied, thanks!

[1/1] block: sed-opal: Don't include <linux/kernel.h>
      commit: 56fb8d90031f71fa8af48fdff8498b9263b9c759

Best regards,
-- 
Jens Axboe


