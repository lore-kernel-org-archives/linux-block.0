Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E6C4CEC6
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 17:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F8A21479
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 17:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B/9+9cuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfILRUp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:20:45 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:33561 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfILRUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 13:20:45 -0400
Received: by mail-io1-f41.google.com with SMTP id m11so56650995ioo.0
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LfDDG1yPuXvqWqb0gH52F3FjqH4jap+10Padj/ieipI=;
        b=B/9+9cuqZGLD3Vtugi5f2NQ/MaQhy+eQHvFLFqAACT3HI+d6J8mU+JVNsbaa6wfecZ
         fqAGGe9Nuu46CEJzrwfmgQEC2SlvwAHlCLDNTjjTGyJiTiozRquCy/nUsTL5J55/6/cX
         4+xtXSLLzrckIg2xJ2F623vHBtNhrddjhn7RcQRcGJyBoNDwuOLQGkTDEy9keNX1Amod
         4cPOgo7MddK+U/qD/TnSOGUB7tkocdgvpw1EzuAs4TG86zzCmQuyc2TdZjXmMxQb5vbQ
         73lw8vHkOAdazk2cwDmBcdTYBpX8lAuXIR79C5HIqlin58C6jsDL1D3SA5k/k04fwTGv
         BCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfDDG1yPuXvqWqb0gH52F3FjqH4jap+10Padj/ieipI=;
        b=gYHhx1l5EixBxASUjByRThpbZRkiQjEqQjk+0HAzyY25H8you1d3rd81wu65rF1n8J
         Q//v4PQvLHrdCX753LAVuZ1ctc3t8FNLYBKtC77kVVYrhg54v5N5G/0E73F7mZXjzaYl
         aFw5kZKCBYLkaWokkrCkNEnMNSF4f+jgqPNx/L3lkrCxIT9ZxYDWmwHusYKtzqqZhKwR
         Bmch5MCX82JSA6TfEOokXpEcKeH9VsSfWd8yZaPNI2yV6shMAnDtCF4Ui1hmLAwHHhQE
         BIG2WQb+eJ3XBdDgsnzbb0SwTGZQZ/1aGD7jc3R1130/ZmE7Fxr+qab6YYgzcMNkwgGA
         7Gpw==
X-Gm-Message-State: APjAAAUeYK8BU/V8vv6Jg3LZ9WchNZ92X6xndbu7ZwGIZX+Ufv1Ry0UX
        bOYqSbYM4l1MBVq+ji5/9tykwHvc1m9BJA==
X-Google-Smtp-Source: APXvYqwqg3S/10FiraOdZzfZuwSW85lEHXjS7ReQ3aSr1HSPhYxfVqv+BvscIl/xNEXkqLNfd17BCQ==
X-Received: by 2002:a5d:9a01:: with SMTP id s1mr5943898iol.255.1568308843836;
        Thu, 12 Sep 2019 10:20:43 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n15sm18674391ioa.70.2019.09.12.10.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 10:20:42 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for 5.4
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190912164151.7788-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19027784-22ec-e479-b963-ae6b1c93fdd0@kernel.dk>
Date:   Thu, 12 Sep 2019 11:20:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912164151.7788-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/19 10:41 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> This is the second batch of nvme updates for 5.4.
> 
> Highlights includes:
> - controller reset and namespace scan races fixes
> - nvme discovery log change uevent support
> - naming improvements from Keith
> - multiple discovery controllers reject fix from James
> - some regular cleanups from various people

Thanks Sagi, pulled.

-- 
Jens Axboe

