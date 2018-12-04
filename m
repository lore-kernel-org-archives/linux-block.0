Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C057C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD11B20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD11B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLDBOJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:14:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37147 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:14:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so12828843oia.4
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TjSvjpn08SEsYMZq4Hk1IebklwvR9Jyf6F60PoHE4Fw5gFIbkdLw6yL1F1JYk1RAdH
         VvfVDG7LvhGtOxmPh095pUKRle7/aHqojLxiiQ7mJSITS3s3OwEFcEHQJJ5o+j5dT1Ku
         sjX9/NvpNi+p/ir44XMUc3mRekSfmUkRSZBEYf43kX1dTc39DNGI6X+EajLE2msRjFb8
         5CMy+rMVH6I3fA7/2SgHTxF3Ue+4YKPE9SMRSdkTZe5l8Kj2Z89NAre+JN5P0Qb14nFP
         urH679uYjKBzeUH5up7NI64Ezc3dKsM8VfLDtK09J9PRMpsOttAT4ATe17R0/wW5zP1u
         lU7g==
X-Gm-Message-State: AA+aEWa9cmtknazbBbwrNczkILcMCU2xmU8Gwe5ycUvvf6+0YgYzNAsX
        yO/G0TjnJ0bAoZCupJus3yr+UPV8
X-Google-Smtp-Source: AFSGD/W7sU/U4YdqCFD0ZbYK5qajlCwYqbljV+61Ztiy1T4tfEnFG+1iqgm0eY8Jre95hc2Ovl8TXQ==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr8573553oic.233.1543886048181;
        Mon, 03 Dec 2018 17:14:08 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r9sm14771512otq.81.2018.12.03.17.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:14:07 -0800 (PST)
Subject: Re: [PATCH 12/13] block: only allow polling if a poll queue_map
 exists
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-13-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f2a8eed1-cb55-dd88-9c9a-3445237cf701@grimberg.me>
Date:   Mon, 3 Dec 2018 17:14:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-13-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
