Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A1C433E6
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E054221E7
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbhAYSn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbhAYSnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 13:43:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CB2C06178A
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:42:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j12so127824pjy.5
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pf3PHu2OFluDfmQCuWJ4Or1an7uayPJEkaL31BqG8mM=;
        b=Wvi4vtoazMM+IYZjRK9Rb7YjxDa3JmEGgBruFAGrtyMmWOuj7EcpNiX9aOBnG+i7ZI
         ks3oHiSwShiuWmOWbwcpC6WaySQRXKqAH26yfkt7u5xlORJFpo0Ez2HwwA6tD7rXat/p
         rIaHoBV6nsUDQM6J6rukW83Vte2EsXJ0rEckcficR6BynCWB9+M4uja85Vr2SXjt3usW
         iJaJRvOFX/haWAlw8fH2mTJjfHgkRP4/cNGDs9m/ojfqFRWoFQuMK8OAWx3zQ+QfEcip
         DwRAisQMheg5AxNjG790kktlTKUMtMg4VvhrQ4/GK2XSnX9SFCXxzm0AlsybMzEETLg4
         1ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pf3PHu2OFluDfmQCuWJ4Or1an7uayPJEkaL31BqG8mM=;
        b=WBIvPsI1RD0ETJvFFZmOXHnrgOiMTflIA12ZFiiikeYgWfWCyZyHqKBxl10E59ne2U
         J78Z3tawwr4r1xPuRf5QEZFucDLsSYc88OCdWZ1RtteVxOTjjzU8+zHN85LQOHgkFfT4
         scCYyDIIwyYvvgA6bpWKoXTJJ+CvQM7nIlehGJKlUV7MdGmH7tVJ0eg0nb/1W4EsUyHr
         gNjaa9WUufdz9cXeLCL2XfZL2fi6ZfHmBThL7Vqn3R6EMCYK0hxPMAQ/v5LDWAo6QwQh
         NNTNJaGYUguM0Qsz/D84Y0Mb/HlBccDEp5nAj+b0EncKwtk8SnSfBVkiP+c4p+30GOgW
         2JrQ==
X-Gm-Message-State: AOAM530NIp4ggHp9QvLXDCPEkpWNRPhgZ9g3+uER8dPwvyXtt845QLic
        veG8AdqZ9iWGtFJ6fVQ+jHbCndAVloMX8A==
X-Google-Smtp-Source: ABdhPJwz6OcuZr88v6HDv27DiOQZOL0BEsBj5ImogJTgChQhfoYuh3AU4Gmbtm/6v+6ErWPjXL+P8Q==
X-Received: by 2002:a17:902:ea94:b029:df:edfe:fac3 with SMTP id x20-20020a170902ea94b02900dfedfefac3mr1801406plb.61.1611600164392;
        Mon, 25 Jan 2021 10:42:44 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u187sm9828893pfc.158.2021.01.25.10.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 10:42:43 -0800 (PST)
Subject: Re: [PATCH] block: skip bio_check_eod for partition-remapped bios
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210125183957.1674124-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c5ffcad-31bf-2ddc-8b66-d6d2b5b65418@kernel.dk>
Date:   Mon, 25 Jan 2021 11:42:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125183957.1674124-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 11:39 AM, Christoph Hellwig wrote:
> When an already remapped bio is resubmitted (e.g. by blk_queue_split),
> bio_check_eod will compare the remapped bi_sector against the size
> of the partition, leading to spurious I/O failures.
> 
> Skip the EOD check in this case.

Applied, thanks.

-- 
Jens Axboe

