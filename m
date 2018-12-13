Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4FC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DB820879
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 03:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DB820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeLMDAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:00:24 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45661 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMDAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 22:00:23 -0500
Received: by mail-ot1-f43.google.com with SMTP id 32so516260ota.12
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 19:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=n8KHzv+PZReuBfTQl/LNRP32+gdaZOZcGrPGwm4+96SnsqHncuU6/4qXVxr1P4WV8F
         yKN2ajuVXkrBZDsyenmKP/qB3ROV2PuXsYnqpSjna5RHHO6vagw1ZrExAA17j+27Y98M
         1A38nfcAzmDQFihPHGHIf7Hi89JEh5YFfkkCsjYExZCabayo0HUc+rUYfAHNFro0OdPi
         0TPdCVkEteQubyTtQ8DeyveAewOJXpcZy5PyHXnAA3GKlkfMXLCZwM6vVTR4mtAA8GzT
         gFyrBe/PlRwq1ObgXvD8WD9R6BPh63tSnPizobvMxV1EFkb3eZ2pUjcle4yW97v+EBX4
         njMA==
X-Gm-Message-State: AA+aEWYm294YdvnVkdnz5GWGhvlbLPYrFgK9k95rhOyVeU6jNCbXX9nf
        3H+wkNUF98GmrTGwSXFgPZc=
X-Google-Smtp-Source: AFSGD/UScCsWzSpZsrfmDfs/UcB4wV0Lq7I8CxjookHqQRU2KStq52dRcIQihW5IFRQfTz8yqE0eMQ==
X-Received: by 2002:a9d:754f:: with SMTP id b15mr15162719otl.231.1544670023043;
        Wed, 12 Dec 2018 19:00:23 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l1sm485326oib.10.2018.12.12.19.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 19:00:22 -0800 (PST)
Subject: Re: [PATCH v2] nvme: provide fallback for discard alloc failure
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c9ab7dc-48c5-f365-6bca-abb4aff0ef42@grimberg.me>
Date:   Wed, 12 Dec 2018 19:00:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
