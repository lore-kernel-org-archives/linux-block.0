Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5795C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 16:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351749AbiBKQtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:49:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbiBKQtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 11:49:15 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391218D
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 08:49:14 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e8so7275676ilm.13
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=2zNxzE6G1D3CsiwShudI9cGchBWXBlrR0eBoDe8MKNQ=;
        b=n9HB2pOegZmFnBjFckQ2QtiPeOTontDgGwbpjB1AKyv6FegERh/0V70gPphGNFiQsQ
         mFaEpCRgvV8mOHN7zsFIwmaJS0i/Ycd2cBD82u2Xdcn48JI7PB4EduB4dUN6WsccCVzY
         UN4l5eTfsP44CZlxcCBuTvZq2ldv9P8K812GYAZyL6LCtscFrclKwRDqQ99r5FDdzVm8
         Gvhm+1uDzuoSj+/jZiFTC9nPAngOTpiczhOtXit45TvR5w7ts7h9wzveYxqSpWL9oPX8
         IHzNfyDwB6cFtyAtXmtnGb6FZuAYWenmwR2gPtJ3JSIg3VwuZWWj04KfLKv6hyP9oqUb
         7edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=2zNxzE6G1D3CsiwShudI9cGchBWXBlrR0eBoDe8MKNQ=;
        b=Q8PdK5OxPoHd38JL1x/7b0KdAYXoFrHFty1gqbgSv/pg7Bhr0eCxhjNvAuGH2m3UVT
         Jc6CtRgu48PfZzm3DSI9MKDldInRjpNELd7BZPYB/BF24TE8/c2YqilFzvc3ZfQdThr4
         tTexWHJkSvK4YhNz8KAqA2fDWEBdrgSwxSMZ+y37/2W+8NyIrUfLJ2ihAOO2hVWEuuwm
         +VpZ55TvBe5jexfL9pYg9+ybq0TvQnCdGECxs9U+ozql6NJzzM/xu4Ks3sQilmthdr5t
         +KXOyUl4WQVdF1HtCLopXHKJvr3HKHpD4QHLHt5ys4MPPwRfbPxTMdN5IjveLbfzg2y4
         mJ2w==
X-Gm-Message-State: AOAM530SfnHsbcs0UG3LFrs+nylBdPSW4fNSYALxc0wRa0wGfmoy25A+
        4eEKsM1HKcONK+6HLgaTMhzR6Q==
X-Google-Smtp-Source: ABdhPJwKhIOSDVw0HAok3UsA5R6n+rkLP75sjEFxj660oB1Dh9qtFm2aIn8sO29ppchNJfE9sVCeYw==
X-Received: by 2002:a92:c26c:: with SMTP id h12mr1369980ild.280.1644598153524;
        Fri, 11 Feb 2022 08:49:13 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b9sm5396703ios.21.2022.02.11.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 08:49:13 -0800 (PST)
Message-ID: <f20f0c25-503c-31d2-aa20-f1205fc5c98b@kernel.dk>
Date:   Fri, 11 Feb 2022 09:49:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block changes for 5.17-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into this release:

- NVMe pull request
	- nvme-tcp: fix bogus request completion when failing to send AER
	  (Sagi Grimberg)
	- add the missing nvme_complete_req tracepoint for batched
	  completion (Bean Huo)

- Revert of the loop async autoclear issue that has continued to plague
   us this release. A few patchsets exists to improve this, but they are
   too invasive to be considered at this point (Tetsuo)

Please pull!


The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:

   block: bio-integrity: Advance seed correctly for larger interval 
sizes (2022-02-03 21:09:24 -0700)

are available in the Git repository at:

   git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-11

for you to fetch changes up to bf23747ee05320903177809648002601cd140cdd:

   loop: revert "make autoclear operation asynchronous" (2022-02-11 
05:51:23 -0700)

----------------------------------------------------------------
block-5.17-2022-02-11

----------------------------------------------------------------
Bean Huo (1):
       nvme: add nvme_complete_req tracepoint for batched completion

Jens Axboe (1):
       Merge tag 'nvme-5.17-2022-02-10' of git://git.infradead.org/nvme 
into block-5.17

Sagi Grimberg (1):
       nvme-tcp: fix bogus request completion when failing to send AER

Tetsuo Handa (1):
       loop: revert "make autoclear operation asynchronous"

  drivers/block/loop.c     | 65 
+++++++++++++++++++++---------------------------
  drivers/block/loop.h     |  1 -
  drivers/nvme/host/core.c |  1 +
  drivers/nvme/host/tcp.c  | 10 +++++++-
  4 files changed, 39 insertions(+), 38 deletions(-)

-- 
Jens Axboe

