Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C970CA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 18:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4F20578
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 18:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YUpC81ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfKDSY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:24:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKDSY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 13:24:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so12860409pfn.11
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YPl41oSIsCAJuy90UOB+5X1/eG022rGJfVCtM5pYZeQ=;
        b=YUpC81ZHIjVyk182A+EjromLt89QER+6mCv1aCyF2m/EGpqjrRglpGgtM6idl8Qe89
         uZnewRA/Ls8mmY7UT/w/Xwe+LkwQ5aLubNqaUkCu5G9izKDsN1FugoTX6LdfaXUo3m4f
         B1w0J8l/Nak+3tiA0bvuThVDAK2xfnBz+N6iuMlu6gScvFlQhxTlAll+Afezz6K86B7D
         PmGm4m6EEERb+pPWUCjom0RSFjCeernHCqyaIoEUjhaU6ZwVoLVKgeU0ywWif6gJJc59
         wROxVt+vLf4t7/dC46yAFOhlMiWKDoW8DZOHNTcmYGjDvm6xV+RMihc4niXVm5iwGgZG
         QQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YPl41oSIsCAJuy90UOB+5X1/eG022rGJfVCtM5pYZeQ=;
        b=kWgOc4lZSBHeNQFQQ9esqiFTaIVrZIelKAYBaUsy6oBDLeNZ7GEwb6hq9Kq9HzKVLs
         P1HUADtb7kfe+LGkdre0NPNVxrwMv8c0VO+0hfG0QkM4yw3wVVzEwEshjGkwaT2O8QMl
         6Kmb0PU8qfJD7heGAFVvchLQV52p55fcTk5hXv0bfywBiVzOyknOgMsHrbJ2mbhT8mhx
         yEEr8E1SeoB+ZOEakMLvh+7/VNbLd0GgHbbX8gbiySCU98ZWBAMHenDLqDINfZH/WPtp
         S96afsLbv7LwafxCJGA2M7WC/VSem5NUdhwOUE9QulVwUnOwkQnWq+9voFLOAJ4UUxly
         oEEQ==
X-Gm-Message-State: APjAAAV9FDLvtBqjGkMstOVFFq+g/e9Wbx27Lv6cHmtD1YEodesNAfhR
        8KLe4M7m/gVCkPSGBy/mVAaXK/1qn3v4/w==
X-Google-Smtp-Source: APXvYqwuZEdVN7Q1+vvbIepdk4ddsnwfPL4UXD3iC2S/IeLAacvLerv3C8hS6j/JwYDTl0FVjjgdZg==
X-Received: by 2002:a63:bc11:: with SMTP id q17mr31714482pge.223.1572891867453;
        Mon, 04 Nov 2019 10:24:27 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11f0? ([2620:10d:c090:180::8a43])
        by smtp.gmail.com with ESMTPSA id u36sm17181073pgn.29.2019.11.04.10.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:24:26 -0800 (PST)
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
To:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20191104180543.23123-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22bacf28-c17f-91c8-e30b-ccdc367b1c21@kernel.dk>
Date:   Mon, 4 Nov 2019 11:24:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104180543.23123-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 11:05 AM, Christoph Hellwig wrote:
> __blk_queue_split() adds significant overhead for small I/O operations.
> Add a shortcut to avoid it for cases where we know we never need to
> split.
> 
> Based on a patch from Ming Lei.

Applied, thanks.

-- 
Jens Axboe

