Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5995C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C620851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968C620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDBgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:36:51 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42835 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeLDBgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:36:51 -0500
Received: by mail-oi1-f175.google.com with SMTP id w13so12837772oiw.9
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OEF0gTRX4ox1F0IPpz6zlwRcLlFJRr/wndiyCjgb5o00E/riq+9jEg94feqWXeyRpi
         lmMALUPeIZsRVp29axW0yUObdjnT9Neh9YGkW2xHdwl6vEzb+SprjE1Bo9hobZnbqOHS
         +d2yYc2m61gQIQUCYh83GMxw9JaOdGc3J1cegssOBziZgOpUJNbeLiI2W/giA3IuMehX
         YJe+1zleCXrDahkLBR7GEya4/0l5WRVtnSHDYtb8ei6PRhrkABeBKyjOXJNpKwwT5oQj
         KPAii9TMeUtmmPy1iMEt86+Ow4FfQS0muWAus3+xliq7FtdTqvP78sMPzKYt7dsLqQml
         X5rg==
X-Gm-Message-State: AA+aEWarPJUxdfIZm2pZSqEU7aZwtK0SI9hwb/6ukAebTv/XCuxpdPD9
        XbbZjhrsM3Te4g8HSLCVlBA=
X-Google-Smtp-Source: AFSGD/W85agGxZh3Z+swleB+xXexO38wUOqS9L7qrHHCq5O7Sismn1rxP24wAHuVPokhO3Nfz+rjMg==
X-Received: by 2002:aca:100b:: with SMTP id 11mr10751492oiq.303.1543887410299;
        Mon, 03 Dec 2018 17:36:50 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l1sm11755695oib.10.2018.12.03.17.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:36:49 -0800 (PST)
Subject: Re: [PATCH 4/7] virtio_blk: implement mq_ops->commit_rqs() hook
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-5-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <62befc01-39bf-5be3-9b70-081e1dc28d92@grimberg.me>
Date:   Mon, 3 Dec 2018 17:36:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128133538.20329-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
