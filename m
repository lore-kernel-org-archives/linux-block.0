Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C44C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F762253D
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfGWU1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:27:55 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46242 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfGWU1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:27:55 -0400
Received: by mail-ot1-f43.google.com with SMTP id z23so17101149ote.13
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=GW/QoOtyoeM7THksqKaHM8/P5V6WlG1/zqVc7edqULjkn5si6yA1BxC/PBR9kcgqlE
         OEn7iWUiGOPmKrboSJxGvJU9bpAFhco2ik7baCBki5E0sWN9C6XJ0myEyZGh9u8XI49S
         5dRP+Zq9b83WdYE+vFoLtghXE9eIvhpSKjW69+/CW2N3HI1cqHaddmhOJ5S3hqilwdSI
         pY3krdGN4YJ+XPNrXWqNYM5CslLeeaXaGCiGA6gWHHc4YJqKljejRoP13KZJol6MYr9v
         vpBPLB5Hsx1g5VxbXm7/YQeQgYm3M0DxIT7yyTKk0PN8H3idHFWR+xizr0BVURydZoZD
         J3Eg==
X-Gm-Message-State: APjAAAXxSU5aylbsCgnwzEqtpry3m9W8pHXs7x2QsreaOFSU3wT7434J
        iYuw3FjWB6PEpDWj0d5ebEY=
X-Google-Smtp-Source: APXvYqyvdJz6ECAVkdYcycWZTYo4/m/NFlawsIYmlAN8eK0NxpKcBTmsDAz5qFSQ2kknDX9HOWuPEQ==
X-Received: by 2002:a9d:3d8a:: with SMTP id l10mr55592530otc.343.1563913674727;
        Tue, 23 Jul 2019 13:27:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v22sm15926510oth.19.2019.07.23.13.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:27:54 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: don't abort completed request in
 nvme_cancel_request
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-4-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e037ecb1-1ab6-f768-40ad-b523a002fd91@grimberg.me>
Date:   Tue, 23 Jul 2019 13:27:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
