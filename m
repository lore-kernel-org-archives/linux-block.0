Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B60C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF201204EC
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="afmZcDKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfH0Qks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:40:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42990 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfH0Qks (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 12:40:48 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so47697866iob.9
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WxqIZ7hBym91EeqvkxTLORsUCq5q+ufriq9PT4cLg0I=;
        b=afmZcDKTkX8pa6zKr4/foKCZgTWa6wXgJ0FYYbIZf1X8NrE56c9HTWQS7ZnA8zh0a8
         3oNrkZ5IH6JfcUFcw0egGrZZJefqiPIW9/Sw8KgHAn1KRJnwiw4XUnEoQ+V8qv/uBICo
         YOk6e/LYL69L5x+/4FA+mWtpY/PSAfCglRy9vD80g5H4BOghfKYSfqgyDHZY4SV9GSEm
         5u5xxYyFtZy0XF13CAeFH161FwEPZVG7c1Saxdqw3wezLCnzpZuuZclSswOETlS8qY42
         GAFpVab6WLchqC1x2qTs72NM2D82btFdhldz80FFxu/uMQNYMpHBCBpCOeQFDUalpwE/
         C5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WxqIZ7hBym91EeqvkxTLORsUCq5q+ufriq9PT4cLg0I=;
        b=U7+WFjI0WZAnEEP2umcA5KdmdvYUOaK4IkFtrMN4trqs/i1vGOkTkmsDsF0hKI1YRA
         ybYhnH3pXtiHNXC4n/sebr4+OabljpHz2N60KNYqfV3wRW6655h9i08T7+2WAd+zBH8K
         HacaSOI98XHLOiBbCtSBt2qtJQxmZoEiu0O91k8sm13BpfwKo/W9TfA+62/2Kj1cmNY2
         /PKvoFfzrM44ehphoLaePJC2tXZjb3UOyEjqQfDnZKdzqzXKdBZ0necjSZxC+KsSkbyO
         Z7BFoFESUlN7Ru6CMtqe6/Yrkfdpxlh2CfOv8JeopYxyvuol/KdOrSoFD1zgwESEpa7E
         F0jA==
X-Gm-Message-State: APjAAAVbkGVHzh4twenOwh9FDmtcDBMOIFi+eRGauqpA4SOoPWDi49kS
        OXhIGvBeHYk5IF2sRl8wiOnnvw==
X-Google-Smtp-Source: APXvYqxkwqxqrZx4eFUSZ+gWXptakBRrBID4eDkEg+UR8mw/8VBctTtUVUfrP/NAV/4Z8knJzNgfXg==
X-Received: by 2002:a02:3004:: with SMTP id q4mr23651468jaq.55.1566924047337;
        Tue, 27 Aug 2019 09:40:47 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p9sm14510450ios.1.2019.08.27.09.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:40:46 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] block: don't acquire .sysfs_lock before removing
 mq & iosched kobjects
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20190827110148.808-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e383447-e82d-6962-683a-7b12f7466a2c@kernel.dk>
Date:   Tue, 27 Aug 2019 10:40:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827110148.808-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/19 5:01 AM, Ming Lei wrote:
> Hi,
> 
> The 1st 3 patches cleans up current uses on q->sysfs_lock.
> 
> The 4th patch adds one helper for checking if queue is registered.
> 
> The last patch splits .sysfs_lock into two locks: one is only for
> sync .store/.show from sysfs, the other one is for pretecting kobjects
> registering/unregistering. Meantime avoid to acquire .sysfs_lock when
> removing mq & iosched kobjects, so that the reported deadlock can
> be fixed.

Thanks Ming, and Bart for diligent reviews. Applied for 5.4.

-- 
Jens Axboe

