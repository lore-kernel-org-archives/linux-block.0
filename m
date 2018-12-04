Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65AFC04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655620851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7655620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLDAzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:55:11 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45927 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDAzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:55:11 -0500
Received: by mail-oi1-f174.google.com with SMTP id b141so12753979oii.12
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=VYFq2/V1GuOyTG4y2sjrg/k5m3IHyzRAzqUk/K6lnnZZlBupt9xpEMsNevapJC/09I
         /PcnSoA8E0nshCk7JE6u85XC+mAkfu1QgfXpp7e8RZjVDUs/ZRSEfdbXFnSh79vmZjbN
         c18B7445vu4kzZqRKg1buvdGk5l433T1dQg+znKqypaZvddl5DboiNUzeGvjBOjU8ozG
         HiV8n3kyfAx16FE1oGMw44p7vVqZf//vfvow4BeZsCsVnHvgbDOvj1XkMI8oaBS6zfZA
         yKjF7m1iKzEzHz75ELxbEzBo46S9ZPr4g1PhakveXK+0ZJMMhhbT5ls8utTW1DHesHbb
         vg3g==
X-Gm-Message-State: AA+aEWaMDcXeYxI0Z4JwutwDTtsAQK9ZZLj32cTXMqOBX4m+V57sP6uL
        0jHwnU7S0bYpUI+uLGmX+IapW7SW
X-Google-Smtp-Source: AFSGD/VJXYkvXrdJNh0TatsVYPM2gsiNKXDBOu6874jFzc11wc0dHX/UvUnBDVYayFaDNd4LLth6ZQ==
X-Received: by 2002:aca:ce10:: with SMTP id e16mr10617597oig.317.1543884910637;
        Mon, 03 Dec 2018 16:55:10 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x92sm8300202ota.55.2018.12.03.16.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:55:10 -0800 (PST)
Subject: Re: [PATCH 03/13] nvme-pci: cleanup SQ allocation a bit
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-4-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <275b2fd0-fb87-e33f-fef1-7061208b9f02@grimberg.me>
Date:   Mon, 3 Dec 2018 16:55:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
