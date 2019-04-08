Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C860C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D141A20883
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wvktmTqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDHOIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:08:44 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:33118 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHOIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 10:08:43 -0400
Received: by mail-pg1-f177.google.com with SMTP id k19so7416991pgh.0
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zF+WAgdXstfJGx28YvwgdyT0+OmlWLncurQnEu5QHcs=;
        b=wvktmTqoZyiIktbZlJ/uX5dLTj/YCveTyukLRs4iCsDVBZ8ntlSkBQ0gNt/nUJhKul
         4jcjBKYdEo77dEyfOg8459AVSZ0KQCbovfaBUND44svTKlHApt7sHdo4Fz9bm6ybVTnx
         fZM4Q+LG/egJy6djWldQsVVmz95kdwFJAZz7OvNPNt/iSrvXJHkZef3+G6A1tHO0nKCo
         NuG2rbg0ewvryjqW6MA8kZGoVVajyhgvaV4N53/zl9C3Cnnqf0n4APGbYxeo2JgvAHoD
         IkyL4DSLTzuQSKYVqLD7suZhhcsA7ed+EWmK0b0fn3A+MVCAIqs2n1kC/Krpy2qkhEbr
         RPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zF+WAgdXstfJGx28YvwgdyT0+OmlWLncurQnEu5QHcs=;
        b=YHyGkH33GqdeI/olniSWoAK2wI+R/mShuLS++SGu+JUpD7Cgpiifb6gpd0Em0Mh+sO
         YsamwOHr7zxS1oA0wMwvpUS0JMYLin8XdaE3mb9AZPnVR1ZNOVo97OiiDVUUZfuy0ENL
         DwsFDtTPlTVfAA4Tpc2v4THrWSzhNIAYYRkfQ2Viixgeac8NmiXRNRxx0w6af5jXAkaM
         DseFDI4JlLSJFTDu3TUkJtVzcrIqBTGsSJ6pUjmBMp2JNkgQQqAmx/rfZEj0+mUE3CHl
         eNa/LA5upvCeY/c0ZLptppURHnDRWRzL0pNQ4D6pzQGHok3NfHQRDr28br/gVyDmnZsz
         3usw==
X-Gm-Message-State: APjAAAXPb6zaR32VIE9y/SX0+PE/UmSUOQ+ApJonTQuOTJu6dzbeoEmA
        ANWhqLFUKgY7rt8G3NkX7Tkcwg==
X-Google-Smtp-Source: APXvYqxFK96T5IWKcan85n860h0JHEQlFVUHe9LfLmkMPM7UUmZtXvQjnPzFjimgwSoIazu1BmHqxw==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr2627548pfg.36.1554732522919;
        Mon, 08 Apr 2019 07:08:42 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y5sm34468379pgv.15.2019.04.08.07.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:08:41 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio_blk: replace 0 by HCTX_TYPE_DEFAULT to index
 blk_mq_tag_set->map
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com
References: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22ed96be-fa8c-a30b-980c-9777afbfcae6@kernel.dk>
Date:   Mon, 8 Apr 2019 08:08:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/19 7:31 PM, Dongli Zhang wrote:
> Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.

Applied, thanks.

-- 
Jens Axboe

