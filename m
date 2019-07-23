Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A5BC7618B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 13:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF482251B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XRJOd09f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390187AbfGWNZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:25:33 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45221 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfGWNZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 09:25:33 -0400
Received: by mail-pf1-f182.google.com with SMTP id r1so19144560pfq.12
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W9fFRtycwBGl1XfsXz1J8YcCRRBJH8xSkRJL0Hp3dnU=;
        b=XRJOd09fhZ4nCE55m/F4u3Y9IVCGcHG0seMTcSqayIn5d1xDWKLkCRyMBOJzCPLuzC
         aJB/dc1OQOwkLsSMtiUbCYI6LiORSnFKz3Q44tUhAZj98liw3JaIGilyRrPVp3tGPAoA
         mkx2YC4GEClZTUU1IJzk+3r4eaIjRL5bFRQCUr9RODbq+HF7azLwv1aSiwon57pDIGLY
         JMDlI9vkiB9ebXjzZAEzx9T3JPaySfnVtArwoqsQkS3DYWrVoQyoZj/M08LzF8YWFGe0
         /bpVe6i1jK3IRjKtqedDd7wN7UTewzh4IK4lCCYyJ1C+KvReZbJmzTJ2w+xcClDHgz44
         GoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W9fFRtycwBGl1XfsXz1J8YcCRRBJH8xSkRJL0Hp3dnU=;
        b=BC8nsgrC21tPhsissDf8GDs49sTRUn42lNedp7/qR/2Ssw4nilhWRqmlaoo2l0yJmB
         7vmCTMWgJr1UAUMQgaHxV5SXLa4oyzIKvYPcXKRot2HFegYU/zcopQEm4z1QZMnyC/QL
         7p34xEUrdvuFw+Xz7RM93haX6GCVE/6js0XAUPBvGd+vmYbyfKv9KsoQgi4HS2A6sg9R
         8Lj0Q+ZNJIQvcGDZ8Y0ZWGrtYE9dJy/v8LelaqspOwbdoJ/kAHMY2m86+qk7EEYNZ2Bu
         7RYc1VgO+GC2mqeFA2x5J0ffKQ0ahfXCQu46KYnxzgR0blwHhMsYEhmxTEjrfwshAe9O
         Bs9A==
X-Gm-Message-State: APjAAAWsnasUprlFDDYgPQnSvn5KG4o4+eoRDlDiJxnib2AC5Fo4OmLP
        YpeRupLNdPotw6uTEaf7b3A=
X-Google-Smtp-Source: APXvYqzVepc8390YynESunq2g1ntX4TTlPC264IA8b/jW2FzaKMPeNxbbirr08FA03ninB2G664W+Q==
X-Received: by 2002:a63:6d6:: with SMTP id 205mr78459972pgg.262.1563888332132;
        Tue, 23 Jul 2019 06:25:32 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id a12sm81713541pje.3.2019.07.23.06.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:25:31 -0700 (PDT)
Subject: Re: [PATCH v2] block: blk-mq: Remove blk_mq_sched_started_request and
 started_request
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20190723032743.10552-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3c5d7d9-1b25-ba73-18b1-08f53758dbb4@kernel.dk>
Date:   Tue, 23 Jul 2019 07:25:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723032743.10552-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 9:27 PM, Marcos Paulo de Souza wrote:
> blk_mq_sched_completed_request is a function that checks if the elevator
> related to the request has started_request implemented, but currently, none of
> the available IO schedulers implement started_request, so remove both.

Applied, thanks.

-- 
Jens Axboe

