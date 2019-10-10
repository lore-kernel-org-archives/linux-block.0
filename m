Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957C2C10F14
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6205321835
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NcletWvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfJJQKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:10:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45762 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJQKD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 12:10:03 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so14861710iot.12
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQetYcgR/x/uWcigrez5bebNM1KKPgjUfbGnnIlp6+c=;
        b=NcletWvP+JT+Tt9yDkrs+ROvFwpxsz4P6JnZ+AqpB6blR5p4H3kXAB1f6W2GBnKnMh
         azbvAa+N+BCuFY7OcBTahW5qxReosTgJy7FkHG3r9uEl7W06BFDitOCVNG2gIfc85FZo
         /hgnFlmAPDF2Zf0sE5K1x3bU/XbHCB24S5BMO75aZhJtiRZJFGnWG5Vb5akZrYXRDhO3
         QYBg2RjTIRjfcJ3ZV7u+p4C8T4BSEywztKRdaiPQb4P1NwRy3irnIBa3y6I/r9ErQGw/
         fbNZ60qNee3Mi6sZSQ31grdw8ufa1Im2jC6yP3IlaNLKFbbfvrh397I65eshS+bT+5tb
         7+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQetYcgR/x/uWcigrez5bebNM1KKPgjUfbGnnIlp6+c=;
        b=Zy/caBGmt25d/j3sxTOZB0CPIUZR4S5MAlkrUYVwM6WMcIxlY18jv8ANfWilCJjT7k
         YVSps+G7Xc39jHEsPa6/FeDBEhHd0CdT4oQ6KrOViGomtjriFYVGFvAH4mi3bA6CpV1H
         SmGSSN57QQRHI+ZUwrboEMChoUobmS8UdimB/MaLhZPR7n5Yp9Z7cG9H9Mg53zVmI1PY
         dix9+ho88xYaBNnXdsONpNo5fRmjuGFjH8Fmm7rSvUWAH9rN4awEBm7d6XlKw7tEZBi9
         sch9NHJQTgN4exJyUtd4cCieD3l7AiXJIKjqqfqksbbJ1MX/rGsRejBWiMw/UOgI/I/V
         dkrw==
X-Gm-Message-State: APjAAAWr2I6sdsxN7bbrFSrPfd2mHdPGMuBqdoq092ZuJhgXhQGsDyiY
        NSPnw2/rA6rPoMxUA/9ccHEFaFnZ6CQh4g==
X-Google-Smtp-Source: APXvYqxIgvsD6LpH4ceUXrXJ70IqBjOP1uuU9nRMT2xdMaM4PDOc40F1rD7Gtn30G3PVTk2REikG4g==
X-Received: by 2002:a5e:9513:: with SMTP id r19mr10860535ioj.66.1570723802721;
        Thu, 10 Oct 2019 09:10:02 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 80sm4134345iou.13.2019.10.10.09.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:10:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <063bc803-44b9-d1bd-7744-e7042ce6cf14@kernel.dk>
Date:   Thu, 10 Oct 2019 10:10:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009011959.2203-1-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 7:19 PM, Jackie Liu wrote:
> __io_get_deferred_req is used to get all defer lists, including defer_list
> and timeout_list, but io_sequence_defer should be only cares about the sequence.

Applied, but modified to keep commit message at 72 chars wide.

-- 
Jens Axboe

