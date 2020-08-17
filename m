Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09438C433DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67F520786
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uyWRi1As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgHQOAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgHQOAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 10:00:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822CC061389
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 07:00:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y10so6006207plr.11
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=An2KNCFpnH6vvJ59vBprp1LzYHVcdHgSt+tChXh5IFQ=;
        b=uyWRi1As/S/tDFJe9bjWWvPLR6snoL3glNssO21uX55S/mwgz7+quix6OoZp5P8dAK
         5HOkv9Cz+wxRAMyMNuFRlloE0MfVZmjGssmIsD8fdN02roQ68boegKayzh6bWdULvr6z
         t+pzxnM/blvxzysyx6UAiXRzjjQwyMLajUSylDdYiFyuVjgPdTPyO6n0GtCbTUdhj9Hy
         tZW487R2qMqWw1CzFqcHJlSwCd6Hd2M2olZxoylNhXFEKdDCnQr48biYa1scweCt4yuB
         kA4uuID5xINb5KWraGao19KBdF2bUKLGYOwrKK3XKksIWLxRpzNoWJJV9hFBDymI6rNV
         bB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=An2KNCFpnH6vvJ59vBprp1LzYHVcdHgSt+tChXh5IFQ=;
        b=Mi+LJdftfCKl8WquVOc4oB8xRWuKm4/PBtgz8Y+11DJbpgW3vMSHE5BPCvNQ0U29fq
         LYD6BEauugTK3YbEjjffrtRlgMUoiDl1cR6sDW9Cceql/20reFJ9icTAuy/SN1uAOYj2
         JJHMMoQtDVzkXWtrKr3keSa+3VyReMoDFxwpY2uC1aYXcZ3L1qlbQlsRTIjyr44qNHx+
         a8acuNQndUHOC3bxunXR6oh6nQIBmLc3278P24pmfKNzmNd6faFQdGpNOSe5QFdqIbLe
         2yV8OzaRVErSzFyX3fp92L229loYcQg3eT8gXj4JBz/fMXPh38lyq+i0HE9cXESVlGh0
         GlDQ==
X-Gm-Message-State: AOAM530FDbDX+X4p/aEEuTIz7LhA/6g6gLhKnPVlJR7v7eNnueAqzNT6
        B3EfwsSf0AoKp3f6sPta8HM7Fw==
X-Google-Smtp-Source: ABdhPJxq2nGX05prqRuTD5fgbYCBbc/NzRYdpZj5mW3BSIF1Ct0eP2Y93NTEb0oCw3V6nmPrIU6NTg==
X-Received: by 2002:a17:90a:de10:: with SMTP id m16mr12694033pjv.34.1597672810186;
        Mon, 17 Aug 2020 07:00:10 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ff2c:a74f:a461:daa2? ([2605:e000:100e:8c61:ff2c:a74f:a461:daa2])
        by smtp.gmail.com with ESMTPSA id q66sm17721954pjq.17.2020.08.17.07.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 07:00:09 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] block: fix discard merge for single max discard
 segment
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <20200817095241.2494763-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c1ee843-82a9-b7ee-ad95-f7caee6bd318@kernel.dk>
Date:   Mon, 17 Aug 2020 07:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817095241.2494763-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/20 2:52 AM, Ming Lei wrote:
> Hello,
> 
> The 1st patch checks max discard segment limit in request merge code,
> and one discard request failure is fixed for virtio_blk.
> 
> The 2nd patch fixes handling of single max discard segment for virtio_blk,
> and potential memory corruption is fixed.
> 
> The 3rd patch renames the confusing blk_discard_mergable().
> 
> The biggest problem is that virtio_blk handles discard request in
> multi-range style, however it(at least qemu) may claim that multi range
> discard isn't supported by returning 1 for max discard segment.

I have applied this, but dropped patch #3. We can do the rename for 5.10
if need be.

-- 
Jens Axboe

