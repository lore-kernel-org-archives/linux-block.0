Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DFC5519F
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04D121D93
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 20:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yYnOju88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgK0Urb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbgK0UrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Nov 2020 15:47:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5486CC0613D1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2020 12:47:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b10so4100343pfo.4
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2020 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YiPUdAEKof8QSeTGDontfiIjhYgQ6O7+xiP2zueOI+k=;
        b=yYnOju88SvxJVTPnjDOqro7kvYH7ySOzSSDcHRb2t4qHiI7KPrTKKCdjqQ4n3fzzQw
         MQQjbfGqjVJjHbGmbRk48ycxh8O3/9XGv3oaM7TU9m4mY4972INjaSxbEKemAiXqxuOR
         vZDxRxn5aMEtNRmhMCF7Fbegh54/kEZl6pOhY/q+ozADyqon91k3QcBh0famAwiuXxNv
         NRmMoas4BAzkZ6OwCuWv09JxWz9Yim1Qr0BNb1m+ZMJak2KrnFb57lvphY9wW+QMDpvr
         ThmSADs4lWFFltmJPK6oA3gaMSN9ouROd72UEv/uz9ewUKIKQEsy6xhgKbxwbjH4tI+I
         fNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YiPUdAEKof8QSeTGDontfiIjhYgQ6O7+xiP2zueOI+k=;
        b=Ba+lFI1mbNgoskCZR9OmPbq/iQBEoc+qiZUVYlmJsVoHwY4N/rFzIZ1DCNfxiDFroF
         MY4gsRfXQOpMuquU4i15WeSOH16Esy/GyJmMOpON4tC7qzG0CZX1JZJGZgkaB/7lOv/w
         jdfFdmWAwUnVmpWRPK6g5PJO5icFKUQwxYDpGITJVNPa2ATEQtuwlmfHRfKIGx01ZtvV
         Nln1PZz5yT5fEfWSivhYF2koqEp891zvybINlcnY0dGvVEKEJnvD1vRDQMgGAqlR7dBa
         hUgsCNRmxG1v3pfUxpxYiREsybnBg4Qw2NJameNPpZwG5R8p4jpsWRvUCKb5SE68VF8Z
         6j/A==
X-Gm-Message-State: AOAM533VQp6Nc93rJ6k8DXh1y2UrzX4weoLy3QuKkfCapAwIO2G4qnkB
        GNbrF0hxUXINs/PvaXlS9aIW1LdD3akBFg==
X-Google-Smtp-Source: ABdhPJzTTWNJuWkhFG+IKWp3/wJLfg4+O4bm/FQB63Sya4t8UJw0ToKe5cTqWg9QCNjqsF6+NiWGRw==
X-Received: by 2002:a63:154e:: with SMTP id 14mr8051456pgv.49.1606510025878;
        Fri, 27 Nov 2020 12:47:05 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:9f8b:f9ad:5d0d:795? ([2605:e000:100e:8c61:9f8b:f9ad:5d0d:795])
        by smtp.gmail.com with ESMTPSA id a16sm8700865pfl.125.2020.11.27.12.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 12:47:05 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.10-rc
Message-ID: <5287b66c-74e6-c86c-a55b-b1cb5da39399@kernel.dk>
Date:   Fri, 27 Nov 2020 13:47:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix, for a crash in the keyslot manager. Please pull!


The following changes since commit 45f703a0d4b87f940ea150367dc4f4a9c06fa868:

  Merge tag 'nvme-5.10-2020-11-19' of git://git.infradead.org/nvme into block-5.10 (2020-11-19 09:23:27 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-27

for you to fetch changes up to 47a846536e1bf62626f1c0d8488f3718ce5f8296:

  block/keyslot-manager: prevent crash when num_slots=1 (2020-11-20 11:52:52 -0700)

----------------------------------------------------------------
block-5.10-2020-11-27

----------------------------------------------------------------
Eric Biggers (1):
      block/keyslot-manager: prevent crash when num_slots=1

 block/keyslot-manager.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
Jens Axboe

