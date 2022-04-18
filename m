Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 15:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbiDRPte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345756AbiDRPt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB735DEC
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 08:25:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r12so8793357iod.6
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=J/SdugHxNre+EwLFr61Vazy6vhBUOD+w6dfnA2gFP8c=;
        b=axBRFhMi3+2zB9bjQ+sHCDe04tJTnhhkstg7Fzwpvdnuu1z3gdbcjQv0xCgj0DDiPn
         8Dpu249gV07Nnt4TnBYVFSVOodY3QFTA14jCjOcWi0m+sU45syTGy6B1nVS+2WZxqUFr
         aLbYs2lZoI92qXQHI7s1s5Tlj0L17O0FxGARmEO8qlFvtyHDwsVcp+BKM330Nlox1WfG
         HtIiPQn5i/Z4+OCqZc0eOML8LeOEYjn7YfWjjUbQRXZMTLdDyTQpjZ/kNsDbTWx3jwuA
         WmI5zV340dj13tXGUCH193Efu6lEXipikraPF15+ejvZOHBdiTrN+bG2CMgIzo1VS+tN
         SUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=J/SdugHxNre+EwLFr61Vazy6vhBUOD+w6dfnA2gFP8c=;
        b=vWwNIUqPowLBExdwAWD02KaUEjaGmWdTWU8kwKau/IAP7nWb7Sv1OTb+mbuW9IpIfu
         wfyg5Go+LcTX/+GE+uzP8hRtBi1Bve57G/XYEBxl6Zvdo3Cpmz+2dtT+fLbOe/h0WkxW
         Ummfv9KBs4aTxMLrBbepwdyiVZeTZ0KzIv4yzT+NtSHzr8FRYOEqRp5KwiaOQX0bQ5Ow
         BInTQM8Go8XlMMUEfu8j3NraqQP7293jy766GbOSWTN6hNIUfWe9EXWxddnL2mAYq0PN
         LEzii9pddHVt01gzNVl4zXyFlK8rglCfOjg0LZYO2QXcSJobT1BNNMKIecBA83DDSi9m
         mLGQ==
X-Gm-Message-State: AOAM532e5g6rXJCByjC7vLiGEsU7fZbVrjVb9vorrmdtD3VMI26u9UwD
        PQsKPcscjhqWSBP7DzzGkWWcow==
X-Google-Smtp-Source: ABdhPJxXgafkLWqHQvzNiStOc1rfCouXOBQMnp8Do04Twt7fltmyCtfpiKkbOOeX417xSBXPCCscsA==
X-Received: by 2002:a05:6638:25ce:b0:329:91ac:782 with SMTP id u14-20020a05663825ce00b0032991ac0782mr408177jat.22.1650295521416;
        Mon, 18 Apr 2022 08:25:21 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o2-20020a92c042000000b002cc1f9e8dd8sm2711288ilf.44.2022.04.18.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:25:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jinpu.wang@ionos.com, linux-block@vger.kernel.org
Cc:     hch@infradead.org, bvanassche@acm.org, sagi@grimberg.me,
        haris.iqbal@ionos.com, santosh.pradhan@ionos.com,
        penguin-kernel@I-love.SAKURA.ne.jp
In-Reply-To: <20220413123420.66470-1-jinpu.wang@ionos.com>
References: <20220413123420.66470-1-jinpu.wang@ionos.com>
Subject: Re: [PATCH] block/rnbd-clt: Avoid flush_workqueue(system_long_wq) usage
Message-Id: <165029552063.51804.8437792369057437632.b4-ty@kernel.dk>
Date:   Mon, 18 Apr 2022 09:25:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Apr 2022 14:34:20 +0200, Jack Wang wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> 
> Replace system_long_wq with local rnbd_clt_wq.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> 
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-clt: Avoid flush_workqueue(system_long_wq) usage
      commit: 5ea7c1339e3ed094dd4df48d598f9018a2587283

Best regards,
-- 
Jens Axboe


