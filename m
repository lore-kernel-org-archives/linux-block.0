Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 14:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355180AbiELOq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355568AbiELOqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 10:46:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD2519036
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 07:46:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j12so6701167oie.1
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Wjwrz8eauGYsUo9yAzQVALp4iNWY2BF0n5UeeEWs7Gs=;
        b=dA2jSvBLR64YISeGzK0RkP7jCOcVZ3W0vnfN0ESOTDCQMhcn17heKIvQQyOsOvQkdc
         e4iXmH9grp1gX6c7kq0Nlo0xCa+Wol/h1Y5OHq91YW6dHn6raBfuzKlELLYZe3y97bBL
         t5KQn7oh7sBVW+hf+T4HlwQw7qyEWTE9cPKzyKuBeO8o45XDCovaGtBUIOZX185siXuP
         fEIxw5Mwm2IgAuZ25wy0vCEGtLdFaK+NuOXjxrD3j7fxnO8tZDCe7++SeAqUsopSeX5O
         FI5+NBJlioKUZaofxAtCYN8reR8piYM6bstNJW0OdVuoR22Wv97nU0f8FTBtkVtrmzpk
         Vf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Wjwrz8eauGYsUo9yAzQVALp4iNWY2BF0n5UeeEWs7Gs=;
        b=pv/Vwqn4GJvSfJMCu6NeDRftBwhUR3tL+qzGArqR9zvAErDZqZxc56KuR6CX3W/M17
         uXQoZHRoz6kq0D81O5E9P9dk/7nA4v6i115MzQDcTWFJEqABpV1oET+j3JSROXI8uF0i
         Q3xwHwu5OtiM9XozK/6gqcGbfq7pXLKTnENxKv06241f3cXOcrWyBOs7r9Vf6+3FMrst
         Brvr8XozMDOsYnrRHgyqhzCPNAn2jdr67VjgeIeTZe+godT0yYECLrhDjf2tbJNNF69R
         68M2mfHFcIRax2SAzJ5TSGr0xvqzJVpJLcvoQRmBoxjAlEvB0Nr4gtYGOcUKwWiBKY7F
         gJkw==
X-Gm-Message-State: AOAM532sbPEgpmxl+SlYipfkeKgCigI+tWUQkM7uxPOvMMB8dKQwxwGd
        1WiYgv7BI0zG+a6mMM8SRQ4XKg==
X-Google-Smtp-Source: ABdhPJwk20g+9fTKO2b7RFm0xosjR1RL98q/Bdn5nOeGTr0wFJbg79Z+utHlq1joTwBA5XgtfSE55Q==
X-Received: by 2002:a05:6808:218a:b0:326:8755:8b08 with SMTP id be10-20020a056808218a00b0032687558b08mr5474938oib.183.1652366761058;
        Thu, 12 May 2022 07:46:01 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o188-20020acabec5000000b00326bab99fe5sm1830829oif.40.2022.05.12.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:46:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
In-Reply-To: <20220512140010.1458645-1-ming.lei@redhat.com>
References: <20220512140010.1458645-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix passthrough plugging
Message-Id: <165236675953.266833.7301121151394105931.b4-ty@kernel.dk>
Date:   Thu, 12 May 2022 08:45:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 12 May 2022 22:00:10 +0800, Ming Lei wrote:
> First we can't add request into plug list in blk_mq_request_bypass_insert
> which may be called when flushing plug list, so nested plug is caused.
> 
> Second if polled passthrough request is inserted via blk_execute_rq(),
> it can't be added to plug list too since io polling needs the request
> to be issued to driver.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix passthrough plugging
      commit: a327c341dc65e38af7a2398e7313e6f2c4a813db

Best regards,
-- 
Jens Axboe


