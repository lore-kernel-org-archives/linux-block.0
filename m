Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF43C4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359F360F14
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhHPQ52 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhHPQ52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:57:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A090C0613C1
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:56:56 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bd1so20162034oib.3
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QX4ks5jEbADrBKL2S0MNfqw+r43q1WO7tEHO0nENCIk=;
        b=BbATPvyySBsHiD4X6LlcNoorERrrsncim8+jXRiFqDA2nT5I6DauYiw88uZzfw5ygm
         ZAZ1HXAB4FtrHpzN7K4m9krfenv65F8WB0DHFatV2SXdv3hW7YVzIWWV1P9lOs8oV7b+
         Ad8+RxMAmgyk7nQhPGxsU9Mjzps7hMfpoNRfWbrt0/bTfGKNRbE/jF+xwv96/A5nHhJN
         A7QzK3QfrdSjySEve6URoWlGw+5c3IR2yM+Fno9TPP5lKT/7yxmPEj3rPZf6/ejiULpN
         ZAybaMEqfIhLwM/bG8OnVEWMXBdpL2TzsKfM1Fs4AR4VPB4aZ0PFS/RZUebR9PHBppYM
         7giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QX4ks5jEbADrBKL2S0MNfqw+r43q1WO7tEHO0nENCIk=;
        b=KBlkwg/sWVgacINMmP4oIoRDfOMtqQZrp8Kzcf9gO8yZ6OBzF0a5H6I/hp6jyE60Uh
         ZBpknTj2EYsN3oVTtYfI+ikAWtO9PwwpM5Td7fHq1L/rP8H31UVXJfAvLqyDIWd1mouB
         Sr7BRrqB4TGNVWl44pqW0PGkMv0xpt7BXnhWiFp/gUE9P17jk1ldy8fEzVGTVN4vEOKf
         3S4hbGIIw2JdBBdYgXQsl50lZGhWPKuj88hla1JFLgoDfAz1B/NIRzEjvo2ENJ+8A1f7
         5g62WRtUXSshLzUt3IvsGw94a3pLeVw0tQUwzK1Uv3a/AJIbDAXRduTyqAsdAwpUMvF7
         K1sA==
X-Gm-Message-State: AOAM531kOXGlDKum43UQFbhuRk4g39Di9fByzu6sLYKooIkNPfbG1Sfq
        Sa6DnsEyRWq0NkSw49RwQ0fbSQ==
X-Google-Smtp-Source: ABdhPJyBPgXPWG1S8us14BFNk3bFnMIsL9w6Le25xuw3T3je5uxgT9MBjZb1fDsz6TYd/TRax+JiOQ==
X-Received: by 2002:aca:ea54:: with SMTP id i81mr65816oih.174.1629133015798;
        Mon, 16 Aug 2021 09:56:55 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y66sm1181002oia.12.2021.08.16.09.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:56:55 -0700 (PDT)
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
To:     Pavel Skripkin <paskripkin@gmail.com>, josef@toxicpanda.com
Cc:     hch@lst.de, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
References: <20210812091501.22648-1-paskripkin@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a04bfff4-bb38-0d21-3432-5086efaa6c69@kernel.dk>
Date:   Mon, 16 Aug 2021 10:56:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210812091501.22648-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 3:15 AM, Pavel Skripkin wrote:
> Syzbot hit WARNING in internal_create_group(). The problem was in
> too big disk->first_minor.
> 
> disk->first_minor is initialized by value, which comes from userspace
> and there wasn't any sanity checks about value correctness. It can cause
> duplicate creation of sysfs files/links, because disk->first_minor will
> be passed to MKDEV() which causes truncation to byte. Since maximum
> minor value is 0xff, let's check if first_minor is correct minor number.
> 
> NOTE: the root case of the reported warning was in wrong error handling
> in register_disk(), but we can avoid passing knowingly wrong values to
> sysfs API, because sysfs error messages can confuse users. For example:
> user passed 1048576 as index, but sysfs complains about duplicate
> creation of /dev/block/43:0. It's not obvious how 1048576 becomes 0.
> Log and reproducer for above example can be found on syzkaller bug
> report page.

Applied, thanks.

-- 
Jens Axboe

