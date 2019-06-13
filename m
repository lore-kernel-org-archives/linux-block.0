Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C73C31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221862063F
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d4vC0uGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFMPwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:52:50 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:45217 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfFMJGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:06:17 -0400
Received: by mail-yb1-f180.google.com with SMTP id v104so1826670ybi.12
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3csrMBOtkX+fLniyEKnrD/Nc/OQItJgg32xTDLzGepA=;
        b=d4vC0uGxj7ildIWUF7dKVVwBbue0iL81lYD9Sw+s0C3TOjIcqOUTZuKts7uooqeStG
         el2gCPdBGj4/N1kpWCWGvORXPbu3J9uU8eB/vY55wcImD1OwHtjsQZEeV5i01+n3d6b0
         ZRurmEPtJa8WMO80tUjnZXVBsOVeP1u0gS1k3C9yAZSHPcga+6Q9HFdvMPo7okYT2rl2
         UJaALLeaf3a8/PqFbPrs2UQJtZUN9w85XgFItxatQR9O+TwxJmFdVOtVvkh+3EDcs3az
         yya6yfgJgsP+Xstp45LSDKjo+4HPWN+0EWLme84hyBW8r33HvbwGx0JH79S+a6852f67
         vVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3csrMBOtkX+fLniyEKnrD/Nc/OQItJgg32xTDLzGepA=;
        b=VjSiSXCBWRjjIkxgDQY18ai/i6Iw/lmsYHSFHaiJ6MvfgTW1+3DoP/1Xy0nALjN4FK
         cvrd5ETTU9tvBhodndWjocPlxyeAP6R1/t4/WcxmV6cR6TDEI+4vCW/nchendCCaV2JY
         aeH2bTPYKRhcfwHbNmi2n1lIs8nMC+Nhs8cKaHCkro2vVIhDuKsTLlA52Mm5ECVnOcSt
         6NfzjVKIHBF4l1W1Ehk7ol6YnW4OnAf5PsBrBEDjnYxcEQDM5Fk3bbBHgNxsrRvYyM7E
         RC+WuFxbyEUZf38H47CZf6nBtn7IzkGKHdmlo/R69oOLhHLeFpq8OO057SPQCn+QYE3u
         Q8bA==
X-Gm-Message-State: APjAAAUg+/3+YNtf2NSeNluNpKiLw0eqgsJsi5BarQ4Yplt5lu56Wmbr
        GzQ9VbTg1xodjMBePiFvAGjefQ==
X-Google-Smtp-Source: APXvYqyUSaAicfo9rA8XcfWudJ6WuvN58kZ6oQ3fyGOwHMUaOQmG7BRsUFaBQYTwclfXebW+BnSniw==
X-Received: by 2002:a25:2986:: with SMTP id p128mr40856299ybp.168.1560416776637;
        Thu, 13 Jun 2019 02:06:16 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id j127sm650716ywe.32.2019.06.13.02.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:06:15 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove WARN_ON(!q->elevator) from
 blk_mq_sched_free_requests
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Yi Zhang <yi.zhang@redhat.com>,
        syzbot+b9d0d56867048c7bcfde@syzkaller.appspotmail.com
References: <20190611093153.7147-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29bc5206-7598-c65d-bef0-d8ec34c0934d@kernel.dk>
Date:   Thu, 13 Jun 2019 03:06:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611093153.7147-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/19 3:31 AM, Ming Lei wrote:
> blk_mq_sched_free_requests() may be called in failure path in which
> q->elevator may not be setup yet, so remove WARN_ON(!q->elevator) from
> blk_mq_sched_free_requests for avoiding the false positive.
> 
> This function is actually safe to call in case of !q->elevator because
> hctx->sched_tags is checked.

Applied, thanks Ming.

-- 
Jens Axboe

