Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B98C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565E22DD6
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 18:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W9BlrBGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfHTSod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:44:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37642 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTSod (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 14:44:33 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so14360727iog.4
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Usw9us6bkdlk4P++pNXTPOsuudyUqBzxDiUmM+cDZFM=;
        b=W9BlrBGivG0rJXEKSjlBKQnuqXxJdF6wh49t/76hAwvQFbKazAoOylUW4P5VXfFRdF
         xGEmUL2SVoAZqXsAbvDkO57H26AETpUeeafk9TJggfzYULCAM3b2s7de2o7xwBcqEf2C
         0GIJxh7dGws7rIvj91qntyfxjpQRQ9XMXSttXhRH3hNDhRE/GIqDPc0m64/3/px7uW4I
         HRCg0UKmzyTqXWNDzQHprSBx2Xogi6PwtRleF0yZBxL0KWDJL78LmhBfXSipghbdnvbE
         0yeo5lGiidjjtucCNYWrzvbv6YPumBAxZSPjzmpVsePDfEnswnOPDiPwofbEi8TxKFnw
         L52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Usw9us6bkdlk4P++pNXTPOsuudyUqBzxDiUmM+cDZFM=;
        b=AQRDsfPbkPHiv6R3L3nLOjkLfOXIaBWe84N8ya/Rat3B1d/78jwWhBMDOLd/diJ6ht
         l0MZ0MB2oIPoAdkl/kKIiFqHfawtI3FUTWXNrkG5dj5Enj3ppqvoLszkN/QGvDlrOMAk
         LbONSvaHJhfPa2DB57IJVdRNECWJKsM7bgeWSIKoZ7ClLwylXj1mcWsteecvHbV838VJ
         6FMlFlZaOU7Zhv1gkGemDlbsef8iadAvHJNgK+WFH2R0rNbB4Peaq/PZxvK3A5KLnTaF
         ZY4690rJNOJOtbtJHm809IJk4x1C7ruPflOx1eSCuRaWKE/NTue0QNrQ+NhKfeSP8pjA
         D6Pw==
X-Gm-Message-State: APjAAAUpdd3+7kOUB0X0ybo2pdT9oFyS4aBaR89Cc7OharGGN4Xxholf
        /4mIIrG1Px+UaMdrM2gXVBnckHqvVFh4OQ==
X-Google-Smtp-Source: APXvYqwIm1JwS7z7yJu6V3qsY9YtjjqLbP1+XMfWoiqJXuII/apIPPe2xe/PSFVqulxQ1vPAohfxew==
X-Received: by 2002:a5d:9c12:: with SMTP id 18mr45638ioe.48.1566326671868;
        Tue, 20 Aug 2019 11:44:31 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q5sm2344250iot.5.2019.08.20.11.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:44:31 -0700 (PDT)
Subject: Re: [PATCH 0/4] nbd: cmd timeout fixes V2
To:     Mike Christie <mchristi@redhat.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org
References: <20190813163952.23486-1-mchristi@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8377c449-8cb7-b105-e4e8-696985729c5a@kernel.dk>
Date:   Tue, 20 Aug 2019 12:44:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813163952.23486-1-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/19 10:39 AM, Mike Christie wrote:
> The following patches fix bugs related to the nbd cmd timeout feature.
> 
> The patches were made over Linus's current tree and also apply over
> this nbd patch:
> 
> https://marc.info/?l=linux-block&m=156494582914495&w=2
> 
> V2:
> - Fix patch4 so it allows resetting of the nbd cmd timeout to 0 as well
> initializing it to 0.
> - Add Josef's revewied-by tag.

Applied for 5.4, thanks Mike.

-- 
Jens Axboe

