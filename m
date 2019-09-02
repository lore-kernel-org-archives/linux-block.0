Return-Path: <SRS0=3Les=W5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978DC3A59E
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2E22CF7
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j/KvpmYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfIBVrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:47:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43565 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfIBVrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Sep 2019 17:47:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so6982549pld.10
        for <linux-block@vger.kernel.org>; Mon, 02 Sep 2019 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bE3CAGhnJZegvIyfQXiX7dFDWRKDXbLDv++b0LQi4ZA=;
        b=j/KvpmYKp5WcE2QOK0RAlwqt+IgtxvzMAxVB8SmfSj0/pOnQV6c2CsE3AhMxEGZ7LO
         QHoUNeRRlAwj6j2iwtZMqBLNwFsXOT9docsS2b86DNBZRE7vNX7MG+axOrC0MA0QnjMK
         luQSr0KbW9tQ2SEmb7nPpFCRhkC0RIOVXlh6YM9O9Sg5g4VbVYdjagxeLsMMSHm1rQ8e
         aMJlnnuzI09Dj53mES7Bzt4WXwZ7m8nyMMU4IWG3o+BPiGpZheP82fcUcJgEI2yw7ZfR
         eqQhoJTb5btqwS+2uAS9Etps6GRDO9Glz3AxMp0Z2mFP73H+Vhjy02G6cpdk6gJVBPny
         pEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bE3CAGhnJZegvIyfQXiX7dFDWRKDXbLDv++b0LQi4ZA=;
        b=UEzQu9sv4L/Nc3m+3O9N1c0+i3NyqTE4mpQmYjtP2S/7pkY35ea2Psi6d6zzYQMMSa
         8LNCIy/l3lQDZ+PSVP2zuzim/ZEmtAYd3nZ8tYgwiUy+7HBuObCt1a3Dcn98fggNAc8Z
         urwj6iVnBRwjt91mJvhuMtco34vHmC9Fz3fHr7GhL+WiMk4FUt6ttYn/KaYZ44Dp31PC
         uKuUrjpmJwSPs8lOcdpWhrpQau8D6pay8CHx8rRQyq14/84crFEFxd8K7w1wXh0dz4A0
         mp4cbnFxET6Xrpa3LkDwmp4NVUnfhEK02BB2ALF2MvLj7uVK7g8MzGvYGwxQPWT/hGta
         lj8A==
X-Gm-Message-State: APjAAAXoBYgjdfxCwaG80COdpcYIi7p7xhKz1rMqnRW8In9ZSMz6bg+b
        2bmVvwrH8OUhVp8+5pB5OfwKsg==
X-Google-Smtp-Source: APXvYqyJzfQKPBEQy19FPz3Lq5G4NPwWwbdV/9eJxkhq7nV/UN/iSGM54S9/O1hVayoRRjcFiYFOTA==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12mr5329126plr.92.1567460823386;
        Mon, 02 Sep 2019 14:47:03 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 71sm20770525pfw.157.2019.09.02.14.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 14:47:02 -0700 (PDT)
Subject: Re: [PATCH v10 3/4] block: add a helper function to merge the
 segments
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org
Cc:     wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1566995743-5614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566995743-5614-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e549e8e7-9dfe-6f68-2148-f49a9089db37@kernel.dk>
Date:   Mon, 2 Sep 2019 15:47:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566995743-5614-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/19 6:35 AM, Yoshihiro Shimoda wrote:
> This patch adds a helper function whether a queue can merge
> the segments by the DMA MAP layer (e.g. via IOMMU).

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

