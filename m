Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2572DC76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E32253D
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGWU0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:26:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39043 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfGWU0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:26:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so39404571otq.6
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ljLInu1eBr8QWvD/46ENCswJJi3XDqWK6jZvGNMZo9hAPP9gt20/C+BuuxYqgWweO7
         O0JYoeaDWo966yEh3A1ozX5WCrXt9K3SpwMC6K2OnhesglCWMr97yzcZuyhlMkNzMIk5
         FhetyzJ9M1AFMA/p8QZ4aFOYT6eJtpaQRC1vYNpLX3wxPeHqYByA9tillmreIKYK+PtY
         zFAYDw608txx+b2GcqeaiWHo4OT6dIftzWbox2EKjuFMw05rBA+eg3ygOvOhks6pQ68/
         Q7oPZ9e4npJu5H39LJbYSHDAcQ6OG8watlr/5oGknV3i7NztaAuILBBABKiLyzIlw/Ey
         729w==
X-Gm-Message-State: APjAAAUKoQS9n6uPQQxBX4UnvQglswZkno1q+cabJaKLHflLC6Y9lhvs
        WTI9GHlNCJw3c7K/Z3KEygkw13Bx
X-Google-Smtp-Source: APXvYqyImRGHkCa4ehPFItKG+s5UmjCxA9i/WdJAEsBhdV3pdYzZYeaCF9xFEhq0VyAyDlwIwbj9gA==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr47375238oth.257.1563913614566;
        Tue, 23 Jul 2019 13:26:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q82sm12695965oif.30.2019.07.23.13.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:26:53 -0700 (PDT)
Subject: Re: [PATCH 1/5] blk-mq: introduce blk_mq_request_completed()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-2-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f89fffec-59ec-c911-83e9-bbe5feaa40f7@grimberg.me>
Date:   Tue, 23 Jul 2019 13:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
