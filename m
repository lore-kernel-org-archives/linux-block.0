Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6BC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B7620657
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uNTNdfvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfCFQnZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:43:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36812 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfCFQnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 11:43:25 -0500
Received: by mail-it1-f194.google.com with SMTP id v83so11188580itf.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MkIzNjBFSlc8acVN7wz53mnZUSmH7dGKq73pNb3vuNU=;
        b=uNTNdfvM7AXqrwv8ldv00DFqTwcmdXbZUYw1HwDMFR/tJY9ixT5YlJoBKwqd4bDMX4
         OkegsEQTCnPnNwD/FOLHKjljw9q1bpM+qyzBPpdfAY9AgoOxyoLn25tVKk3Bqo+8fhjy
         pFFwzGOJzhvq2bxRGR03P5oW65zr6dYr45dxwGf52F/zOPscE1hLxffyocU2w00DVDEz
         xNr8FhnCI5WV5O72U5m1y2XRhwB7uqEs2Z8VGZFMlXrhF8RqTPocZDeMgRYJIuZeB1zm
         nTqgV9GomaGgTA7baxn+giD0bdl2WE7MntSmKA7mEjiuWDScrs/7Fk73Jv2Nu61aa/Mq
         Fbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MkIzNjBFSlc8acVN7wz53mnZUSmH7dGKq73pNb3vuNU=;
        b=OdAEuoPkRrJibwn33rutfYvPFprfuC+bhZWcfIQYyaZiJifmS/6TCJtpTSPri0UOAP
         QmCyRtmkhUrNvEVjeQ3UiDwKESYa3XeZHssmAzJ8NzVgz8RfpgruX3d56wx1m4yRBYCy
         uiNGVfPGBq/vW0MkXcs77oyU4u/rMD4B8m3dKk9UTZNnpoI35dAWIxgpHIZzDnD2iGxG
         YUSeiShss7XBE1uYpi3yvUZDh7/2totT15+KnYc48wFR1wt0XOqivJZwrK16pFlZH2sQ
         7Gr1ZVjLzXenMilDyLtE9OcrwAeGgnfs8Y0USXMiygxRlRWOpUbF63yLKsQH8mKwXF1g
         7AeA==
X-Gm-Message-State: APjAAAUU3AXLRzGJVMVSyOFhCF838Zo59850OWHM1phWd3vUxGZBvtj3
        Ao8Jk8vyYO1yA7VISkbNY+kTokJqpb7mAQ==
X-Google-Smtp-Source: APXvYqymaXFWMcFSikw2nNkxc3bJDwc6Ox1cau9FKk+ItbADr2nQ1e6T77/42e3yUMPZ5LTGEI8lAg==
X-Received: by 2002:a24:4198:: with SMTP id b24mr2889040itd.25.1551890604720;
        Wed, 06 Mar 2019 08:43:24 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u196sm1112361itu.34.2019.03.06.08.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:43:23 -0800 (PST)
Subject: Re: [PATCH] block: fix segment calculation for passthrough IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
References: <20190303131748.24646-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4e52de2-1d32-0b55-eaf0-24c86d9158a4@kernel.dk>
Date:   Wed, 6 Mar 2019 09:43:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303131748.24646-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/19 6:17 AM, Ming Lei wrote:
> blk_recount_segments() can be called in bio_add_pc_page() for
> calculating how many segments this bio will has after one page is added
> to this bio. If the resulted segment number is beyond the queue limit,
> the added page will be removed.
> 
> The try-and-fix policy requires blk_recount_segments(__blk_recalc_rq_segments)
> to not consider the segment number limit. Unfortunately bvec_split_segs()
> does check this limit, and causes small segment number returned to
> bio_add_pc_page(), then page still may be added to the bio even though
> segment number limit becomes broken.
> 
> Fixes this issue by not considering segment number limit when calcualting
> bio's segment number.

Applied, thanks Ming.

-- 
Jens Axboe

