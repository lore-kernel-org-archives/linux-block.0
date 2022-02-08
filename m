Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3FC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357832AbiBHNz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377047AbiBHNz4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 08:55:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E6C03FED4
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 05:55:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x3so13902702pll.3
        for <linux-block@vger.kernel.org>; Tue, 08 Feb 2022 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=EKe2FDok1vDN1Qrt/TFEsKKKayW/IcHkTy7KAKgN/N0=;
        b=aB1bmi6XBYOafm4v7Xv9tBP6s3rEWBH814Hppn28SZTw96W7/6XPYpB3DaepS3Qv0z
         v+rIs0ASLGZsKClVHjUZrYGZ2ZDAR9P07XR4HREpDibXv6mYoihl2c0wMTqTrUfzUHl+
         yAOMy3C/4Sur4vBxKsuvaWM1zKz+zYwvOdoWqSJBiZ0RweofciwIDywcfqgexTWlC4+E
         A3ffPZqPet+qcE/MtVyk8pf/D5LUrTd5J0Rj6/U6BNxEfyr9zRFdXFhKQ8AdOHW/MPPA
         A7ajuACR6ruzjUl3v48tHDLtCerb0uc5cSk0cnYA2Nkzfa3PXJWOHYdvdt0HIyX6/u38
         nRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=EKe2FDok1vDN1Qrt/TFEsKKKayW/IcHkTy7KAKgN/N0=;
        b=tsEhR1p4frtycK2lyXsUb318StbZ2IKa3aKyTpPC1LsfdsXbbAddAwAOMhrENW3ueb
         ZH1IAGbZdsriGjYkZqVyNMjzNBg1czmedfKW7+zM4YvdZvMLUmiLpYsFVO2P80trpcK2
         lfch0ZUFiRonEa3ojfhwntoGB8SCuLw3ER9cuQZHmj68iIwn0ga19lgDTlCSQ2tAydoS
         qziG/cW/9T4T47BMLlgbZWc2ljlp6eCV6XOERkEI5THdQVRUw0jfQiaw6kDiBmtBuKVt
         C+fc99OzM0EY7YBvbfcbmqL26AeS8UGMb5WW1OQ0TzAc5K0wdnQ2mBKFRD4DZbBm8bKe
         GvkA==
X-Gm-Message-State: AOAM5339kIPBJJp2m9IRjd/KQiJWAHnd8FC+84Dva5/5FqXvldnLrQJg
        bAnbvo5wscET3c0PhuhwMUK+OnKs3FozXw==
X-Google-Smtp-Source: ABdhPJw2DbY44CxqFKwVzHF8+IqK9tnPQDJOED8fVoUNfNb7vC3e0XwGhEPhYo67xEmA40aK1mlBzA==
X-Received: by 2002:a17:902:a509:: with SMTP id s9mr4530771plq.134.1644328554913;
        Tue, 08 Feb 2022 05:55:54 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g20sm16741663pfj.196.2022.02.08.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:55:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
In-Reply-To: <1644322024-105340-1-git-send-email-john.garry@huawei.com>
References: <1644322024-105340-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH] sbitmap: Delete old sbitmap_queue_get_shallow()
Message-Id: <164432855377.112661.15719927048269186816.b4-ty@kernel.dk>
Date:   Tue, 08 Feb 2022 06:55:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Feb 2022 20:07:04 +0800, John Garry wrote:
> Since __sbitmap_queue_get_shallow() was introduced in commit c05e66733788
> ("sbitmap: add sbitmap_get_shallow() operation"), it has not been used.
> 
> Delete __sbitmap_queue_get_shallow() and rename public
> __sbitmap_queue_get_shallow() -> sbitmap_queue_get_shallow() as it is odd
> to have public __foo but no foo at all.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: Delete old sbitmap_queue_get_shallow()
      commit: 3f607293b74d6acb06571a774a500143c1f0ed2c

Best regards,
-- 
Jens Axboe


