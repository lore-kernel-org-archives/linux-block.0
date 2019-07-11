Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE3FC74A35
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 14:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9D2166E
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y5H/caJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfGKONS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:13:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38790 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKONS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 10:13:18 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so12850077ioa.5
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=16Yz3BOasQd0d7r+jsj7ibx3CTf61ox/R+rnrtS0DFY=;
        b=y5H/caJCu1O9QNsZ2//okCjT4/T0R1Vhj5J+Go/Mm7utx4+xSzmkYSDeN1MzirZIOL
         0Iej55gx4e846buButpi3ZPYrz4xNdkDHsmmNa8ivU4M/6Hg+GQdo4qwifoQuC8bv+hJ
         aIhKxcrZ/k15Z4SgUxoUcZB4c0UoSxJFZzIZjyGlsqI6wrOaHPhc4EfqJkHVb+ItxsCm
         4HJQIWKLV7R+PxxorUbRsR9RWotjJrYM+WQpCvXmUfu/VIYScD/PBbJYs47gg9QT1egD
         q+mDA7f/5Np3rRT5WEr2a2lnttFmHwL/ykaJF6QWZ2LkdrhRwuuC08UPGITL6SnX0nyh
         h06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=16Yz3BOasQd0d7r+jsj7ibx3CTf61ox/R+rnrtS0DFY=;
        b=NYa+7lpYUgbIuNAJK++i9cQ+pdTFJ4hCZk7nMtK+Fzdmhck9lEOZh6UV/CNiXbp01H
         7hOsJfHk3VYvkXwdbd9DUKMdXut5vAzwAz7CGrpL1sm3ONKbIliLEVAh3/9HyUfeLsxW
         1ZtFc+HtkVfylh1WGnsuKybeTyOffBydAKrdolAWvBjrDcCBzgxrEvoIGcrImFZjMtDG
         DuNYNN6KYvzIDEb18MpnvuwgKbCYLS16e7wtxISjezJnsW0woRe0taYmfI9fRDcgJf4w
         1WN/BbgECfKsjDEUoLEJuXXHdNZsS0EmzyWbxTpUJhix0+Nm6Uak5V23NLU/5IJuFE/6
         nwUA==
X-Gm-Message-State: APjAAAUILhsatqTcR1vc8f61+DePZmw7H3uejyAyr85Et7hR2Lws3fzS
        xAqRoG2uny8bLR4q6XyAppE=
X-Google-Smtp-Source: APXvYqy6T8wuuDVkyo1Evus0rMXuKhUfA9IFHzpodzDqmB4NGwZK3nFkJaSdkSURIW/VFWu5y7EfWw==
X-Received: by 2002:a02:ce37:: with SMTP id v23mr4708810jar.2.1562854397332;
        Thu, 11 Jul 2019 07:13:17 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c17sm4321271ioo.82.2019.07.11.07.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 07:13:16 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.3
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190711112031.GA5031@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33e106b8-aa93-89bc-ea78-5571e8c11272@kernel.dk>
Date:   Thu, 11 Jul 2019 08:13:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711112031.GA5031@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/19 5:20 AM, Christoph Hellwig wrote:
> 
> Lof of fixes all over the place, and two very minor features that
> were in the nvme tree by the end of the merge window, but hadn't made
> it out to Jens yet.
> 
> 
> The following changes since commit c9b3007feca018d3f7061f5d5a14cb00766ffe9b:
> 
>    blk-iolatency: fix STS_AGAIN handling (2019-07-05 15:14:00 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.3

Pulled, thanks.

-- 
Jens Axboe

