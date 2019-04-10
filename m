Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CEFC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A1520850
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 15:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VCaqBCA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfDJP6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:58:02 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:39940 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbfDJP6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 11:58:02 -0400
Received: by mail-pl1-f171.google.com with SMTP id b3so1682344plr.7
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NSyMXJCxRlZRVxvvW2wtQrbmnM0Z79C2MRn6nSz/UEQ=;
        b=VCaqBCA6KyCo2TS1/sZnLspV7tllgw08L6Zr/BZFdIsAiDVEcz+Hhte85IQtSDo+Q2
         +2IzCpNcOcAzQXepAFUOXdOqPZy5kG4cW1MaMKzRUSeDVDM21DJEDXO5HvUZTez/L7P1
         6+S+92oX5k1H2+VJkVTRCPRp4yZa6r+YjHtlrRi3XGXZdqo/7p227xpz9VJVBSduXDzd
         7T8j6yKCchfm2mNNGzKQS/wpPcvriboYRXqpuYvc8a6CXmKsFVvdWiU0ymy/vifdRdTY
         h+9D9QyAb1kj/j3lpXd2kvyaCi+FHKLgnd11G1S8I+60MkqqhnLgmkbz6X+3qousXA4w
         4hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NSyMXJCxRlZRVxvvW2wtQrbmnM0Z79C2MRn6nSz/UEQ=;
        b=Qoz6hswmJ39+4KVR12wIlv1s5d4g85VaiaoEz7+DSEewfVR+I57AfXybdMczoZmJ8k
         gm08mKruT+q0gpeki0O3Sk5z47ElLr2CPCx9ekmi4BLqggL9x/MmUQFYcDIzSd46q2TM
         M9WN+XayuC6jDNqjyI/Z87f9aFWvBohFFKdoVAaP7I8O9yoyspQ+ndXRcnrtTiVjQtUj
         BXvRgDTgnqCWLkys15A1vhcPYELcR6Lyx7ok5G9E1fX1wdztA4uKvlwqSDOxqHQ2lUo9
         hjIoPze6NDb+0S7HmSYkQRlNln9f+uqEsAYEiD5Wmxm16mo6xVDAG9d9o6fw8lN0AGc5
         AnUA==
X-Gm-Message-State: APjAAAW4uOHSDx0teZn9V9zvFV2EY+5pMbx7O+bTqU1Y89v7e3rFKQVt
        jYugeXjRmNscxxw4yxJrsfzitw==
X-Google-Smtp-Source: APXvYqz9m6a4sqhjW6FzJCwbHlRIz6x+0L9CGP33jwhvWDM72C7Io4uhP9LTC39YEMSmx9VO79dXQQ==
X-Received: by 2002:a17:902:bd41:: with SMTP id b1mr45076588plx.221.1554911881522;
        Wed, 10 Apr 2019 08:58:01 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c134sm68670568pfc.87.2019.04.10.08.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 08:57:59 -0700 (PDT)
Subject: Re: [PATCH V4 0/2] blk-mq/nvme: cancel request synchronously
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190408223122.29844-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <adaf6255-09a2-257d-a061-8a9b3f2b73a6@kernel.dk>
Date:   Wed, 10 Apr 2019 09:57:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408223122.29844-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 4:31 PM, Ming Lei wrote:
> Hi,
> 
> This patchset introduces blk_mq_complete_request_sync() for canceling
> request synchronously in error handler context, then one race between
> completing request remotely and destroying contoller/queues can be fixed.

Applied for 5.1, thanks.

-- 
Jens Axboe

