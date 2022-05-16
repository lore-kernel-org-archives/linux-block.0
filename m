Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E40C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 12:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiEPMi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiEPMi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 08:38:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40D387A2
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 05:38:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso14240691pjg.0
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=JgvJ8ikDy1uFWNDRVpxtC+ddCByVmlyJ25IbZX7zpV0=;
        b=QX0Fj6rhOa0DB15vFqBy5gkJ+3yTOqFLUUFsCmbwTbwY5pTy+f7c/Pgqtba8IUlEy9
         ctqsAcxPtlkw92aUhzuEIqdAe7cuLZSsLXIC0NNHdbnbUFZvD1SrUEQ4vCaM0rM9hb/f
         kwIcF2yvH89PGUkUrsiZWAGoBzQHh794fDTHeTro3axhmSggASIFCsMmDrPqXPGHILTl
         oSmvvLdo1ehljifr0BC12ztG/MHC3oXQhMq0HhIQMa2m+0oS4KiiqCbaImO4OMk5wSzQ
         34opqlLetKnmoVl2Jcv5QI6B0cvFMKvaJH0UO5Pw6ARvB+fpN6HCCFZMjqzW/XuHybtf
         Mhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=JgvJ8ikDy1uFWNDRVpxtC+ddCByVmlyJ25IbZX7zpV0=;
        b=Yp0c4CoPN4FDsAQhJVuoF/Y7Ygk5B/uytcvKg+M0F2+rYdu2SjKxrXJAGTT/P2VyvL
         SySEthwfvNjaSl7tOY74fvHiTBFID1FlGo0v13mrMHgMV8HhCXZVsoGd5UjYGpTk5zv+
         Z3hALCkk89PPx+g+p+76n32ar3iOSZ697I3BZC7RU+hxsi9RCLNmZAoLTTh5Ckj53Btf
         pj8ISumeuS/8JMsScwmypvtqnx7yZxwAUOYO6hg8CTdUohRxsDYtaBQ4UHjr3crKvyjL
         KERBH6plA3tWa1fayM901BR8wJyyhOttjlhsD74KZysnR3CzuddruG4CM0dNqqkatTg+
         Uhtg==
X-Gm-Message-State: AOAM531sNYamOgYKPOXdsJukqwwpLx3813nxqh9Q8O3fubIGsLGmMM0f
        Md5DL+Th7P9LbXq//dHHw4SsVg==
X-Google-Smtp-Source: ABdhPJwT2BD6fwwESkJEV/Sg4epQCNNo3+2DjErSrwPDu8kTmQ5HNPZxlkaqoYy6kFYT4NusZGe2Gg==
X-Received: by 2002:a17:90a:cd01:b0:1db:d42b:f3df with SMTP id d1-20020a17090acd0100b001dbd42bf3dfmr19051151pju.17.1652704706062;
        Mon, 16 May 2022 05:38:26 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0050dc76281c9sm6707445pfa.163.2022.05.16.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:38:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220516063654.2782792-1-hch@lst.de>
References: <20220516063654.2782792-1-hch@lst.de>
Subject: Re: [PATCH] block: cleanup the VM accounting in submit_bio
Message-Id: <165270470501.18921.3993603396894417426.b4-ty@kernel.dk>
Date:   Mon, 16 May 2022 06:38:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 16 May 2022 08:36:54 +0200, Christoph Hellwig wrote:
> submit_bio uses some extremely convoluted checks and confusing comments
> to only account REQ_OP_READ/REQ_OP_WRITE comments.  Just switch to the
> plain obvious checks instead.
> 
> 

Applied, thanks!

[1/1] block: cleanup the VM accounting in submit_bio
      commit: b1ec1bae3b425e145e134fd63347576c478b85db

Best regards,
-- 
Jens Axboe


