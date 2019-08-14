Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D7C32753
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F405206C1
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 19:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfHNT0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:26:25 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38925 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNT0Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 15:26:25 -0400
Received: by mail-ot1-f51.google.com with SMTP id b1so642439otp.6
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 12:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pf1aHa+HA8zdtvnUqDaVWZWevKPDMWYFSyVoW4j9X00=;
        b=eKmTYwZprVqRFmiRyEEKqye23Fpiep4eXtF9OcdRjtRy549y6Rw6MgfCln4pYhgpSS
         hCHBPvWXqtlB3oq/NRhgKahGF4l3afAcCGWF7WYAtFW2GtXK+Wg62PO0p16FyStob6Mi
         gpE/532RcUbHSNsoyBfmMeDMs+CYf3JtjIhh3fAfOK889HCxa1SBc0zT8SKjCJll2hI3
         5akRB9anFFFB2wCwcSfULtGOn4J0XJCCd0zJapmUuQG49E4QVmnwfy+GMnYihmLS6HPa
         ZkVPS3xiHRGDJL4WGaq5EZ4OJYTHk9LqZVeJm63I3MWNiSUeYyw7ywS3GJeURJvOalfJ
         U5iA==
X-Gm-Message-State: APjAAAXVkEN/SWjV+6zjx+LgYd9ZxZ0cR7tQ77HDg3a84xgf+BLxSFgL
        xTY/mnlwrJydc6V7gI64pcg=
X-Google-Smtp-Source: APXvYqzMhhPS8tiRICfmJM7C9DzQzfp2+sZqNN7gTKC2hV5rLLTKpRfd0iYTHzjSO+RD0sX7insnJA==
X-Received: by 2002:a9d:7d0d:: with SMTP id v13mr617129otn.153.1565810784959;
        Wed, 14 Aug 2019 12:26:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b19sm288042oie.34.2019.08.14.12.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 12:26:24 -0700 (PDT)
Subject: Re: [PATCH] nvme: Fix cntlid validation when not using NVMEoF
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
References: <20190814142610.2164-1-gpiccoli@canonical.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <58533d94-1390-f21c-236a-d8f226499582@grimberg.me>
Date:   Wed, 14 Aug 2019 12:26:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814142610.2164-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks fine, wonder how this wasn't detected before
as this area was tested by Jon Derrick..

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
