Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9E8C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AF720832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cVcPrLt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AF720832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeK2ALF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:11:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35040 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeK2ALF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:11:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so10157967pfi.2
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vOlU3SjXz5jT6T2wwRkWysUOmYMIbLr6hNyHrpkpI14=;
        b=cVcPrLt8drwWbON8kf3wNxlJ1hYWFz4gfC+Dx96/t+0QS5Ax0hVz3sUir3Iu5M4fYM
         C66Nd1RGOAGnRHadTT7Tpi5gtcm396G7RLx1Agofe9T4yC+INj+ErlbNvmI2eqGpjNoG
         vmHc5J2RUrTA2oj7jLoAemUZM98JXcpOPEnUdyMTfBOPj+VJa9iM94GQAaQrNtFdEfjZ
         aD3/Q5zUyqAY9skb9e1ce7PgAHKmc5VJmwDmQlzlJYvEa9jI/0Am6dv5r03hpMu3Gov5
         ZG+ADQJ/A/VMp0gucfc/l0rJnIu4F04ptlsOUS3USXqRBCaEdnYpytQMAmHDe3bIfC5W
         eWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vOlU3SjXz5jT6T2wwRkWysUOmYMIbLr6hNyHrpkpI14=;
        b=FKeGT+p66sacno3GOox0q/pc3oFyPNlZcdByH/frXdKiBiE0zKsHhr3BK6WzJec8AJ
         eJSXYZyQdGmMpSxpraGHeVy7CRgvKMxwbUN2ReIxBznn58iHT5HzVmpEiId42lNCSqLR
         hZlNyrzVpOFexPrvmAF/rI5zCLiTapAIYO3ethXdndaQ/Ohu6uQyDxW9GBxOagOUmuVk
         UTTAWBk6oX7LJUUhIhSqa6b4ikvY4KVb8S3nFHZKXXjPiJrnTHqlgUB6SVS/OvbucMAi
         58wnZXnb4zYzEeNyP+TQpdvwRkncwNve5mjXP5bU/WmqhN9I7kUwlAF8H9LIi3brqH2m
         XiPQ==
X-Gm-Message-State: AA+aEWba/K4KMvB1W1Flom5fdVo607ASKM0MFZvWAOzd2gDoC24bTHr6
        iwwof3DaFAMPSu6TEwkbUSyqHUwZTHU=
X-Google-Smtp-Source: AFSGD/WwUZFP1Ch3km8j4bdT6Rc7Kq+Jro30gW7D1qN4Kf1EULJfHGuPz6dG7FCXL1oB91Ng5W3t/Q==
X-Received: by 2002:a63:441e:: with SMTP id r30mr33564218pga.128.1543410567579;
        Wed, 28 Nov 2018 05:09:27 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q7sm7054256pgp.40.2018.11.28.05.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:09:26 -0800 (PST)
Subject: Re: [PATCH 6/8] ataflop: implement mq_ops->commit_rqs() hook
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-7-axboe@kernel.dk>
 <20181128072236.GD11774@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc3f92c0-35b8-9763-746b-cf470453da0d@kernel.dk>
Date:   Wed, 28 Nov 2018 06:09:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128072236.GD11774@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 12:22 AM, Christoph Hellwig wrote:
> On Mon, Nov 26, 2018 at 09:35:54AM -0700, Jens Axboe wrote:
>> We need this for blk-mq to kick things into gear, if we told it that
>> we had more IO coming, but then failed to deliver on that promise.
> 
> queue_rq also calls finish_fdc under atari_disable_irq( IRQ_MFP_FDC ),
> do we need that here as well?

Probably the safer choice... I'll fix that up.

-- 
Jens Axboe

