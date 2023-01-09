Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96CC54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 03:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjAID2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 22:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjAID16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 22:27:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A45F94
        for <linux-block@vger.kernel.org>; Sun,  8 Jan 2023 19:27:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c9so5191938pfj.5
        for <linux-block@vger.kernel.org>; Sun, 08 Jan 2023 19:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=publwhW5FZ+u6rfywE+948y5DOeI7KUwkKClunLQpGs=;
        b=xWHBhakPkZkq3D/B8WEgvacsCZ5Jm3UCFWcX98pqv3niLSCvVKRruISpCx0hRCjkVe
         H5eudRdZCfMkpr111SAPprnU2S8U2UGSMtcB94wo/C69x+5KlpVYJ54QQP0zxL+Pa7+b
         +uhAd1B6VPrZ+neIh9bM/u9txg1DflE2zSne5pxC7lKjRC8hq+xvbwQG9XNixk1hp3Cl
         ZOO1MoMUoU2vqX7MHhS+2eRutIpExrmPg3jhlOLKney9X/TzkUXa69ljpPdIUqgM2H5w
         92IYBnSSy812oH45TqSLEkTlAeHvz435RvTcQRHnv+qcB9ur/XcxeGO1XBXPZs1YcZ6u
         b01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=publwhW5FZ+u6rfywE+948y5DOeI7KUwkKClunLQpGs=;
        b=h7recTFcK48Cia9EgqwQYH18GN/du1W+7YiuPDQooybNBaZFYvOAoCfSdfEzFP9+Mx
         Gv50lwp15Sgv2WAbRXVQVgWHvoX1SRWK1txHC0KajSWM93ovAfE9xv78kzaiQ8j8awaD
         0TB2bQg1e1jPhAUN8IFPVdG4nNrbQUAPjFKb/RfsQF8lEMDBHF9KV7vrlnQj87RlZl4d
         vUEv4I71xA0cc9ZEvhXh+hiHQFA1Lgha8AaqFK1Wdb1h/O4XY+bduKl+k34i4lbdOJn6
         m7Ebuy+NRBxzhJopwNmAtAWYrwP+xWM4acRvk5o1yFZfgD+A0BkDNKLzDeTFgpXja3aa
         78Qw==
X-Gm-Message-State: AFqh2kpKa2S8sFrjwL3xN+ReAiv4NydAa7KE7L7HYqqld78A84OxrSyq
        H/zPPJ9J+l5JRwUWWLNB7gRs7Q==
X-Google-Smtp-Source: AMrXdXvdtx4KFUZv8oD+5N3lTqyXDcFWKvEHzSEZ9vHcdJ38rKij6rIlo+JXY99mKtAe48KYCj/9kQ==
X-Received: by 2002:a05:6a00:781:b0:57f:d5d1:41d0 with SMTP id g1-20020a056a00078100b0057fd5d141d0mr14422936pfu.3.1673234877499;
        Sun, 08 Jan 2023 19:27:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c29-20020aa7953d000000b0058866a160ebsm1108831pfp.69.2023.01.08.19.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:27:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc:     hch@lst.de, martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230105205146.3610282-1-kbusch@meta.com>
References: <20230105205146.3610282-1-kbusch@meta.com>
Subject: Re: [PATCHv4 0/2] block: don't forget user settings
Message-Id: <167323487662.3080.9555727584420710644.b4-ty@kernel.dk>
Date:   Sun, 08 Jan 2023 20:27:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-cc11a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 05 Jan 2023 12:51:44 -0800, Keith Busch wrote:
> If the user overrides the max sectors for their device (which is
> currently defaulting to quite a low value for modern hardware), their
> request is lost on a rescan. Save it and fix the weird type issues.
> 
> Changes since v3: Fixed the unsigned long/unsigned int issue raised by
> clang.
> 
> [...]

Applied, thanks!

[1/2] block: make BLK_DEF_MAX_SECTORS unsigned
      commit: c749b9c6de40f0882d9c83c8a3780e631603eb9d
[2/2] block: save user max_sectors limit
      commit: 39001023bf1dfcee0ad1602501fbdea6f0d3d3bb

Best regards,
-- 
Jens Axboe


