Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E1C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 01:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiAJByZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 20:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiAJByZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 20:54:25 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A8C06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 17:54:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 2so5902622ilj.4
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 17:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/IYhXUeYlcLtV2gbjaiVtl/JuE7C66s8xkSvane2a4=;
        b=pKNvKiCaEKznnAJzvevjbPqn+Wu+ur04B1P7bE1UT5BNVc05n5ODbLftg1BFHwCzvo
         a8fAnkBPgW/o8Re3nJegb2fmJQvRzvkzv22NL+9hKdoIoXWbiSO67kwdIQs1eMVRfxKu
         iz4JHx7hFgxxsYJ25YnzUIE3CI0jsMzLYM2SwzSsHS4Qds5x1+bbaV0lrnIXBwsVoakH
         Yhja7M25/wQ4CLULb8Nb4U4r+FwhuTXPCrdscwXF1vPQy+I32mFF19dA3TDY0e3TGACT
         DZy2RyZOe7KUnb14oTPnyymD7jbLdSOLD/zXcUhLCPK4VB9eyrcBNVxrgT5KBkJGg0y4
         rGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/IYhXUeYlcLtV2gbjaiVtl/JuE7C66s8xkSvane2a4=;
        b=qLuhTWC9NFQKaKhZWidJUYbO5c7bTBfxM6sh/zEVgKs/AjhbQfwZOUINT5vSNJjUQ+
         HmRqxv9taXZDY1J2rFrwh/tekuK6/mt7G0v+Er1qS3JTzBY2BSZH+uEBXhvPSfpsRN6D
         KIf31ZeGnp+PDTdXtSFukbqYYRoJk/0AYvxwJ64MTsU9Xb0NizN7a1MVE43OEQ8pUWLt
         3mF+vSpmrlLXHcL1dm50sWHqW1wSu9PlagiAQfsCtmgk+F4gf9AwQCJfI8RRkfevQfgW
         QECMsr2aI+9a62IOy2HF+jH0qoM+OkPbo3hc+9rlr2f7HRtvrnESaXZ0mF3/ps89oTx7
         2bSQ==
X-Gm-Message-State: AOAM532xUOJYlwOZTSB0eIsgGixbtpezJvFpDnt/fc+FPaScBx8Ssrec
        8JF5kcJYJQTALODLBU1m6+VRb1Y78CUozQ==
X-Google-Smtp-Source: ABdhPJzQ6huCEkflY3p1Becal7sqh/FKGuy/VsRh0MXJAiwpvy/lQbZpVm1I16rVI23Sn55f/AXOpg==
X-Received: by 2002:a92:d08b:: with SMTP id h11mr1371897ilh.216.1641779664439;
        Sun, 09 Jan 2022 17:54:24 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s9sm3652639iow.40.2022.01.09.17.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 17:54:24 -0800 (PST)
Subject: Re: [PATCH] lib/sbitmap: kill 'depth' from sbitmap_word
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
References: <20220110015007.326561-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <020ba538-bb41-c827-1290-c2939bf8940c@kernel.dk>
Date:   Sun, 9 Jan 2022 18:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220110015007.326561-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/22 6:50 PM, Ming Lei wrote:
> Only the last sbitmap_word can have different depth, and all the others
> must have same depth of 1U << sb->shift, so not necessary to store it in
> sbitmap_word, and it can be retrieved easily and efficiently by adding
> one internal helper of __map_depth(sb, index).
> 
> Not see performance effect when running iops test on null_blk.
> 
> This way saves us one cacheline(usually 64 words) per each sbitmap_word.

We probably want to kill the ____cacheline_aligned_in_smp from 'word' as
well.

-- 
Jens Axboe

