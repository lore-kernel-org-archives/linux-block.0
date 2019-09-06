Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C8C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776092173B
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405772AbfIFXkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:40:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43114 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405729AbfIFXkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 19:40:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so6421025oih.10;
        Fri, 06 Sep 2019 16:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=LNe2LUW/uHScJNOtn+2zSOOXQzVqCrrEjhQQqoc2x/owcLYRTDFBErhKZKfNiNUUVX
         mSyNIE6RhRp+91wG5mUCIL4wA2YXiDGVjQFq3CctT+p+B6fWuU2F87tMHiqbdiYMzBqZ
         9huuqAkkKIJj5bvKyzMISiEIR7FRGiFlHjvwKwdSb9XTABoK4iimZ87ZddiutHm3J5mB
         /EpL8ADgYeUH30PD11BSQycqMy6ZpYgp3dOcla8UdPNhoxPjTiY9Klw7qPdhV8kEkpBC
         hEistFd3GCy+1WqaywR+Bw/6neOt6QkvK3FhQzUzCIIYGSiE3klnq9Xkvqo9++pjU/5S
         0qyg==
X-Gm-Message-State: APjAAAXYPFdznFQ76j5dnTaviNqnm2dwHPqFLUZ3H9t3DkOB5umOHl9L
        epBoGbKdzeJBl7loWbOHxqUN1J9j
X-Google-Smtp-Source: APXvYqwIj4G+yxyw390JPsYAPQ+j0LZYO7Jfo5X/fJwmq/xVN01yp+lhcqixc0ggg122plDaAo1mZw==
X-Received: by 2002:a05:6808:195:: with SMTP id w21mr4987809oic.109.1567813234565;
        Fri, 06 Sep 2019 16:40:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p15sm2769865otq.37.2019.09.06.16.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:40:33 -0700 (PDT)
Subject: Re: [PATCH v8 11/13] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-12-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6684bf33-5151-9f09-8cfd-7586cc9be99c@grimberg.me>
Date:   Fri, 6 Sep 2019 16:40:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-12-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
