Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F541C433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F264820885
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b2d/wZMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgF2Tm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgF2Tmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AAC02A57A
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 06:45:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u9so3510456pls.13
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9b0a0nIVXTUMafJGH2SwkMYNhfwopZmHugiUDzkOFMo=;
        b=b2d/wZMZ3aA9ZfZ0KpqzjWKIRIngidL362tJYG3Eq+HqvC2881PoG0AEA6Qxz8Ax3O
         d54v4x4QO+3JdgAD3uF00qWHLyxlN/IGsVcPh904ZetuRN6uc/THf9pTyhWwgG/rB+hU
         0pf3nd9LPLrvMlWOkp5BJz8RZ3Tv1cQ2xKB423RbMNTnMxZWHyUaHA9aQpKgbWnqBTTX
         y30Izqu9fdHtkUNCNqiKbSNpGYQDYYlKU7lEeiBML7vA3rd/7dP6vb1A6BCOmbHRrGO9
         B+tvXaRXjXsdNJ5adn85cwjX1gHg4DlRqffBby3VUho6AcECLdY3qorT+ovYHY/bsUiv
         vyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9b0a0nIVXTUMafJGH2SwkMYNhfwopZmHugiUDzkOFMo=;
        b=t8gpau7Fekdu2SzXiNEsz8yVgiD+YqkOtE6vbHd97IBx/l/0m91JwpnyX9am94iWrV
         Rf+zr8fTttLJPvoOZiHI969+62AdOdrN9Izgc/KPZIImBALLq7IXV+88InYti4JJynX+
         kGk25gcOoseWsaooLVJRiw8GpUjUj0OE0n4xHMhBhqD077q/5BiImp7tDmYzuOsy6Q4N
         foyiahNGRNwMX64GRy/k3voI2b/k0XPKnN02y3Asu0Eosz84Cris550qfXMM09S3b95u
         fB37rhNtlXCdWCcZL9j/JHxNJc1RSBOB/dxMXdeg0JQIfybBJ4b5qRBFVY6qqCKnH6Ps
         aAmg==
X-Gm-Message-State: AOAM5312hWEcpwDs6Wjh0dIJqhFZ6qIiRtT88jYds389yoOLyvV74+DO
        klUrhEqCcnSUW3TAz+0moSTG6Q==
X-Google-Smtp-Source: ABdhPJwqa7ghc99O/rdAJtO45DaUfONRsw5xzh7zjG9pliTlplqkbHzp8h43Iasr23b0enTiUHdOjg==
X-Received: by 2002:a17:902:c142:: with SMTP id 2mr13948469plj.222.1593438329229;
        Mon, 29 Jun 2020 06:45:29 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id n62sm66095pjb.42.2020.06.29.06.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 06:45:28 -0700 (PDT)
Subject: Re: [PATCH] blk-mq-debugfs: update blk_queue_flag_name[] accordingly
 for new flags
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200427133445.26215-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63977630-6715-ffe4-6fec-0941275c1900@kernel.dk>
Date:   Mon, 29 Jun 2020 07:45:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200427133445.26215-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/20 7:34 AM, Hou Tao wrote:
> Else there may be magic numbers in /sys/kernel/debug/block/*/state.

Applied, thanks.

-- 
Jens Axboe

