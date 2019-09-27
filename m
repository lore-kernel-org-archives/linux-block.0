Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C36C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91875207FF
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m5o62d4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfI0Rar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:30:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53408 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfI0Rar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 13:30:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so6860128wmd.3
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lLqwdnQvqA6hdhU8KemS6zg3akiFmKybgYAwJQ/FBUw=;
        b=m5o62d4HcIILeLiNoieRrlJSgD187+pniUA9Yi790F07qUm+s6GYPLoVB5+Wm9q52B
         tyDCb1RM9bzOCDwMqhYpyqfWIHTJ1vDp9Vc4AVvT1lGTkYxacy+wyL9J109aq36HVBpZ
         mJUnMwvau3Ur8NgjP/wzFcWqAz2Rd0GU8bY6WyVRPD4XWfXhz0fGiq6L1V4wNkAIQk8G
         d09iqKwQPdQMbiP+Z4ybP8pSjknojulzIZkch8VT4R87cc4uTvOaJMsUcjXKFxnPad2B
         hgzxwQynsx5O0tOJZupP1PqT4uFvL3SD6RWznIaGM8JRUqn4c8asHl/J8jaay63AFdNw
         kyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lLqwdnQvqA6hdhU8KemS6zg3akiFmKybgYAwJQ/FBUw=;
        b=I/GNIqgQeOq3855zJKcDGkGPqoLrUBJI+66OgycYWoiGm87RPAMTsTHe0kwMjd7Y1/
         R3NKH7Dm13aadjRrzw56uimYmAtweH+o+jQAViYR4eGuBceZ3WiVIdeBWG1XFON8TeNI
         dO0CF8vQ59chLyBTVMYzvY+2cOTpo3gT2XbyEX9CEZqOxgPUal+yu2SanWYkEzDPpUFZ
         OUIJUazOEVhzmK2X9T3+gU68qXNAHXxED6md4uQpbnJoqqtl+x+SsPh6LMnhWlnbOo3A
         2poOSWC+40NPxsWaVXOOfgO6W6/UQHmRIxqrDOCc3HjngUL0kEmfeqx3fvrAhN002qxz
         bf7w==
X-Gm-Message-State: APjAAAXWZahqQ4WeefaeNOIVWYFgc+UBImZU6uxhxzbK+Mj2EAfLcr5Z
        0oiTG1ZPJ7oVJMkgledL9IU7ew==
X-Google-Smtp-Source: APXvYqzeyEb0YHqQgJCTIMduNbMWT7WekCOUIpA3Xuo+nbW/WALYLsHwV6EpcLZ/hfwDxRX1eD3JfQ==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr7738005wml.97.1569605444059;
        Fri, 27 Sep 2019 10:30:44 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id t123sm10377031wma.40.2019.09.27.10.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:30:43 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-mq: two improvemens on slow MQ devices
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <681ba5fb-749a-25ab-616a-4943d547d83d@kernel.dk>
Date:   Fri, 27 Sep 2019 19:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927072431.23901-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/19 9:24 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch always applies io scheduler path if 'none' isn't used,
> so that sequential IO performance can be improved on slow MQ device.
> Also write order for zone device can be maintained becasue zone device
> requires mq-dealine to do that.
> 
> The 2nd patch applies normal plugging for MQ HDD.

Both look clean and fine to me. I will wait with queueing them up
until I've done some testing.

-- 
Jens Axboe

