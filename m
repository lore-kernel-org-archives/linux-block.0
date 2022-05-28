Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8513C433EF
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 02:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiE1Cgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 22:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiE1Cgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 22:36:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9C5D5C0
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 19:36:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d20so1997344pjr.0
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DWc+62f+ehGb4CaXGVlvm/WHX2T5wwwIKgIRTU0HJww=;
        b=UdrCr4jzo6qbCjIwUIuflnZaZlcl9kWX+D7fCfnJrqXgAa/lwsrhSj/jxkRalI9Byh
         45sGWV19O+hvoOeycXu8Fy6CBWWZ+vZme1VlKB/xNWAf99CnX3frJIokkMAz+H90wQsh
         NpcKleo63hbNkc8WoBv3UCNl6W2NCnwl6Zw01I+kbPa78UPEUUx2nKbjqGAqKR1kspVh
         rOXocQjPutUE1s/HRHW4t5M+Z0+wNVyI1AN9gDun3od/Rg7rxhuKV1om+TSvqwN3pyeX
         XXQLs08yueW/yUodwpL0FNGcIHRgSPV7vwbGcHe8hMHO7FsH0xHoTCkKBkhc5wId7YBy
         jPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DWc+62f+ehGb4CaXGVlvm/WHX2T5wwwIKgIRTU0HJww=;
        b=HXypCb7BiFIcgdjSUoWU5ncVZRCVLGgB3ZExplS89T4LxoPL8xeL77UzbzXFe7JOHa
         f/qOiVXx39akmpE91qm1hG7bm5wk+OCsx9OQTk3t+gVp3aOvw9tSAhbClUolGJvLO9Ib
         xX89Cm50Oa0TZK3n1W2xsUBbWN8mXr3AG4ITOX6ldfCsSZ8UXhJQsCcOLgvAdxdLuQtg
         Gehb4tXa2NPuh7L/nRBZQ51L0YME1+/XY9RwyG4XYwLdsLdqX3ob+AnINqOWmvnID5JK
         xKnpwV1BtJNy8sUn7SYpxYTIeH9f3yHkJBO3ijKDdS/2H7PAOP84EPuNm33IvF+3R/eL
         lSkQ==
X-Gm-Message-State: AOAM531HvqEIz4J1CXdn9ybyn0oInMorwpw4EaOIwayA5LEZbCihhL06
        4YveeRZ1e36aXtPTXy9a2dXTWl9qu+fmfQ==
X-Google-Smtp-Source: ABdhPJyuK4I/7ciQNksUNg4/maDY4CHD9s5xp9HaN3AexqY+ZZBQKo3X8DGSFmk99uaVvE65r+g63w==
X-Received: by 2002:a17:90b:1809:b0:1df:de43:e56 with SMTP id lw9-20020a17090b180900b001dfde430e56mr11442646pjb.135.1653705408979;
        Fri, 27 May 2022 19:36:48 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g197-20020a6252ce000000b00518dec15dabsm4211586pfb.168.2022.05.27.19.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 19:36:48 -0700 (PDT)
Message-ID: <a1e6fd92-ed3d-f94c-43a7-ff4fca27b759@kernel.dk>
Date:   Fri, 27 May 2022 20:36:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] block: take destination bvec offsets into account in
 bio_copy_data_iter
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220524143919.1155501-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220524143919.1155501-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/22 8:39 AM, Christoph Hellwig wrote:
> Appartly bcache can copy into bios that do not just contain fresh
> pages but can have offsets into the bio_vecs.  Restore support for tht
> in bio_copy_data_iter.
> 
> Fixes: 8b679a070c53 ("block: rewrite bio_copy_data_iter to use bvec_kmap_local and memcpy_to_bvec")

Applied, but where is this sha from? The upstream one is f8b679a070c5.

-- 
Jens Axboe

