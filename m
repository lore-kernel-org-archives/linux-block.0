Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDDC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF2A20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF2A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLDBL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:11:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35918 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:11:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so12809680oix.3
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IFJc3lvw0FiJHfoJp/qAs+qlKi48HJ8Ppe73zJOHOmoj1ynLY/BdTR2IM71ojKB9C2
         bkdJKK0EvJeyQiqf08bK5TjlCwANHPqD0mVXKn4a5ypcypwO4jMah/5pTZHVhOFsOQ1a
         RRJSkNOxCb3qD38Q2fuo8w/g5ddIhlsPpUirxQeezdbsBI7yW5cw2kf0bsGGuYMlqvnS
         GkdvB0SU8Od3wE6xXSXOgtpkIe0p+w8rHieW/jZjNv87tUSkuv41cetmLpycS2dsULdD
         7zaCs7yCDhUdITGzGNv9VxJz2ektcIDPJTLv5q723PeL9W511VNJDP9SZb1z8iHN/b1K
         k6MA==
X-Gm-Message-State: AA+aEWbjH6SKWxh3UNAyUhGt9W0P6uZ2qDFieYNKHwLdxuZ6hH8wzOi+
        ZvOcRbI5t+8D82Q6a481EUgdt4mR
X-Google-Smtp-Source: AFSGD/U+RYDUg83Ezn5fYLqI3Qn/IzCoNQo14qnC/UmUMfo52RcFz9+iGFpatiPZKkWDBcsocX3SXQ==
X-Received: by 2002:aca:d056:: with SMTP id h83mr11793444oig.67.1543885916158;
        Mon, 03 Dec 2018 17:11:56 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 52sm28172800oti.30.2018.12.03.17.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:11:55 -0800 (PST)
Subject: Re: [PATCH 11/13] block: remove ->poll_fn
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-12-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0dc77459-dbef-4ebc-238e-383d55c742cd@grimberg.me>
Date:   Mon, 3 Dec 2018 17:11:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
