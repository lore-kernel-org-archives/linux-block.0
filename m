Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F1EE49A4
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 02:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjHUCZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 22:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjHUCZK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 22:25:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9DF9C
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:25:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a7491aa219so447135b6e.1
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692584708; x=1693189508;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgrETHiOUQ03lunTUuznNbf8WaMcYMpi/SHoW7uIK7g=;
        b=lIx+n5JiTcuKWofVyOJ+xpT0xfeC7QVEeVARoAjjJxp/IZ4ykZaGOMgvUqbR4qM8KY
         4Y9tbruBqW5DhkOxN5gNAkr7hTpON7ATiEmOSTVWEHrS0NJZGAvTLkb28Smyq78vvPIv
         TqhLi9Yn6QdpOulqxFYZs9pm1BHXTeISdhEJSpHuxod7u3vgbaQCMNfi2LWKGqI5+nSj
         I5WDekk3LqpXZBggUwBz/0ME6B8jmZZwCoLhL/64ktkJjdSzACKWQKpST/Ukp5oAiSEo
         LXRoYqMYnaJrebcmKTCNZbFavsdHTxsgg4JCkODu6OsTgFM3m6wpy+XEzBgHaae+zvkc
         8pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692584708; x=1693189508;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgrETHiOUQ03lunTUuznNbf8WaMcYMpi/SHoW7uIK7g=;
        b=Aj4gDNILAbtT2UWMz8Ht7uJI7SpU17ZATLmvQBQCstnZLOtMXfd436CYT/lWbiDLiJ
         V4wV6GZX73uNPc+Hyryrs590GeoyguNbhZvwCK8Tx2IVnPBpP4fkAeXn2/13foy5Me0I
         CMdf1CwaAX7dzO7BpppGUrSXnPV0+c1Dcpa2nXv2S+PwELVDFXm2mSYDDE4XktfovQQX
         kgJduiM0nL/5zlIcqpQzq8AMspPlEtgx7VU7tzaNd20FaOgw/UgC85iUFByTK7XeUgfk
         I1M/8f2ylO8x3+tj57HkeGpC2xPN2uvC/ki7gXssdXZ+BdChNmguEXZ4MPR1KASmi02P
         kq/w==
X-Gm-Message-State: AOJu0Yxl2uCGrlKoY953hY9x2am/NVFAn4LjFbQsOpzSkZIToVrO5KK8
        kv56c9LP86qim7ULokGnuYwYBi52uVLpCJoK+WA=
X-Google-Smtp-Source: AGHT+IFh13xHFptguzQTQm38k2v4PtF6q01ceL1gXwjzeqB8a54tpI+PF8MO7KRNFBbRDzZI4/j8DQ==
X-Received: by 2002:a05:6808:180a:b0:3a7:8e1b:9d4f with SMTP id bh10-20020a056808180a00b003a78e1b9d4fmr6583902oib.3.1692584707777;
        Sun, 20 Aug 2023 19:25:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e4-20020a637444000000b00528da88275bsm5293034pgn.47.2023.08.20.19.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 19:25:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
In-Reply-To: <20230810124326.321472-1-ming.lei@redhat.com>
References: <20230810124326.321472-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Message-Id: <169258470658.81998.838665667506239798.b4-ty@kernel.dk>
Date:   Sun, 20 Aug 2023 20:25:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 10 Aug 2023 20:43:26 +0800, Ming Lei wrote:
> There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everything
> is actually handled in userspace, not mention it is pretty easy to support
> RESET_ALL.
> 
> So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.
> 
> Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
> libublk-rs based ublk-zoned target prototype[2], follows command line
> for creating ublk-zoned:
> 
> [...]

Applied, thanks!

[1/1] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
      commit: 851e06297f20bbd85c93bbf09469f2150d1db218

Best regards,
-- 
Jens Axboe



