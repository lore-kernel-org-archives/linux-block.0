Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC194C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D2120850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D2120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLDBOv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:14:51 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39601 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:14:50 -0500
Received: by mail-oi1-f171.google.com with SMTP id i6so12804745oia.6
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=X3+DDHd/vh/AnyU9pr/fgrZYkj+w0BTo6gyboGB56+Okgu71izH0IqEDd7SIIfdQdZ
         YgUFPpVJ5dppnlWxd6LAyUhd6Y2jY9dZYJHMpSPA4Onkbrae0Y95BDSVnuoQqYkomSwW
         uAe/0PAT9mYRqwtDLvscnYxV1akxueiYeHnR9LIU9XaGxz4maufXo6EMN24UaokFUbIj
         ZBB1cqtr+Uyd7Un9rpGXucpbXDI5WK8r3WcpN665PIuQBPvNWxIlNAx/xIp3eSpANk85
         T+lEdAgmWXokiJwRLngke25FXHyXwu8S47XNCOe18oSrOSMcSIhmsqwOjANx8JuUiEWm
         gZJw==
X-Gm-Message-State: AA+aEWa/GpOHuunuWVCnz4AzICro4uuyJZ7FAhx6JaLRtcsJhROqJPjy
        8hH4KHR4ARa0YyhMh0Np558ckcRa
X-Google-Smtp-Source: AFSGD/WlZoNdHvkwVrmqRHtQlpCN1wDVm6ZAXAslN8LlJcAu9Ztjh0C0t6w7WKs68H3HnNTLg7eHZA==
X-Received: by 2002:aca:1918:: with SMTP id l24mr10787029oii.236.1543886089936;
        Mon, 03 Dec 2018 17:14:49 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l1sm11665615oib.10.2018.12.03.17.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:14:49 -0800 (PST)
Subject: Re: [PATCH 13/13] block: enable polling by default if a poll map is
 initalized
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-14-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6339cedc-d360-953b-fb0d-71855780e6af@grimberg.me>
Date:   Mon, 3 Dec 2018 17:14:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
