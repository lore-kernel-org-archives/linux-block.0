Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEAC76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A87229EC
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfGWU1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:27:18 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36622 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfGWU1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:27:18 -0400
Received: by mail-ot1-f53.google.com with SMTP id r6so45438381oti.3
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kyUPX9yMizG5W9mrnjDUMwMWtxizpMYt3i21YR6/Gg2SxaZneGHDRlgZQogjzl7YeA
         vlwPGbEf9nAnfZ664GNhncLdQm/QJulCmnTPk26zZYoaGWPZF7qVHfwYv1tuJvUPvB58
         DXE+I6v8QZtbBQoioZmhgo7aSJEc2mTZWXsUrSd4TcoHXq+WeCqPCQDw23O6S1/KY1Oo
         ETW3Tm5OxUE6F7r9m8O2E8aLi/U+dAYlbJyk9/nC5l/CTAiCGo1CLaj3uMByOUX3Nm7Q
         kotZToM6TDoj1233yJ5c8IEJCu11S2Q1pFyvHwZopd240AbNRFzps3sPuoGlYzgHKFIv
         QPdg==
X-Gm-Message-State: APjAAAU/OflPPsQoOjduhq05cvGhS0qTu655mJDJY7EUUR3WXLMm7jp3
        QRWVDQYTHb7+++Z4P+2J2qQ=
X-Google-Smtp-Source: APXvYqz3tGhs0ah9FOqsqlpkNq5fYu8sbVIeTUmh4QGOgVnTLRZ7uViD1YXTwfY+0XHGhATcEdJkhQ==
X-Received: by 2002:a05:6830:1291:: with SMTP id z17mr58968634otp.194.1563913637769;
        Tue, 23 Jul 2019 13:27:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e24sm14903297otp.14.2019.07.23.13.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:27:17 -0700 (PDT)
Subject: Re: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <83a1f188-7e33-2e34-ce45-2875844af31f@grimberg.me>
Date:   Tue, 23 Jul 2019 13:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
