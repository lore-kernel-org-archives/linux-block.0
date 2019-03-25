Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE9C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A959D20854
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UK0EsupO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfCYTNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:13:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43907 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfCYTNj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 15:13:39 -0400
Received: by mail-io1-f65.google.com with SMTP id x3so8608050iol.10
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zpomA/yvf9UXS0FI/GkXCgHhKM9Bf1K+M4jH5d25t7Q=;
        b=UK0EsupObmUDMpE2NSuEpGh052U0DimXPgND1a2SvSdKp4vYKfnLD+/jxiZZ+UL2I4
         01J88D9QAsQMCtzQGCLsGTTsAkSdaG3pLNg63bm1gbP6lmHFDoQRinBf8E1CxgUp3T/9
         Dg5Hxlcxmp/lBj5k0LYMeukfezzIoeldufq/l80/t2VtbZgpDapA6CHpoVv9x9LEB8sU
         RHJSW7gqtGKRHJkp/+Kuo4QBXT1+/xqjSUtKOa+Y2GDdKNwA7LiI0lJFKEsHnLpTGGSd
         VPXKq0HXV22ifqpn9YLlt0QR9kNziDcs/4UWPswovpgxaf4d7+nh2fXnyJDhptay17Ee
         b/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zpomA/yvf9UXS0FI/GkXCgHhKM9Bf1K+M4jH5d25t7Q=;
        b=paThNHV2J2buGw8FM5X+NiN8c6v48MVHZJIXRlrY5ps7Y/2hfyz5eIMagMI7zzyG3I
         PUAi5EN/HVYgZwpI86wsBUMZDqsPiGViarBk5+X7gcLALeUMNVNDn02fXc1VhSO9Dafq
         J2w8yHdQ1cHbjofC1JFaWqmYJxjKBsU5GSev61tT0wBKZfd8R0EFyL8clTjYt8X+S0mS
         4HBha3swPiSFuEBF+9YnCnhX4MrH1F2b0A9h+uu3LRkIjPbP7cBqBVFfTFL4+y8V98e3
         d2wKMfEOvVEOrf8R4uTAOTdqC+LILHL5VFEJhg4QBdX11rlxfI2dNWWr+B1LZ1S3bhVP
         xz0A==
X-Gm-Message-State: APjAAAVJ9wS5ih7c8UJXsEsF5A3hlIwFS3aKmtPsaMs0qKIs7srBjG9A
        /pj9Lin0i4VLBELUMgNBkCs25KND2akqFQ==
X-Google-Smtp-Source: APXvYqzecGiVC9aoDswa/P/Ph0IlnrjXo3GpWqH7dk50vgphHaVXSkUFKHbs+Nm2rtLWwG3bolFr5g==
X-Received: by 2002:a5e:d616:: with SMTP id w22mr17999152iom.118.1553541217246;
        Mon, 25 Mar 2019 12:13:37 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 139sm6305124itk.28.2019.03.25.12.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:13:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: offload write to async worker in case of
 -EAGAIN
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-block@vger.kernel.org
References: <20190325190924.11174-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d07af437-ae0a-d1cb-4b81-51ee861f7e1a@kernel.dk>
Date:   Mon, 25 Mar 2019 13:13:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325190924.11174-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 1:09 PM, Roman Penyaev wrote:
> In case of direct write -EAGAIN will be returned if page cache was
> previously populated.  To avoid immediate completion of a request
> with -EAGAIN error write has to be offloaded to the async worker,
> like io_read() does.

Thanks, applied.

-- 
Jens Axboe

