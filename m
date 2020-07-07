Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB534C433DF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7860620675
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SjO0ay4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGRqe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 13:46:33 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223AC061755
        for <linux-block@vger.kernel.org>; Tue,  7 Jul 2020 10:46:33 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h16so13423746ilj.11
        for <linux-block@vger.kernel.org>; Tue, 07 Jul 2020 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9R+3nS+6lf72MGoAssRY+zCXXoW/UwC4DS/gYhCBvbg=;
        b=SjO0ay4xPGT/P7CSpxa0jnggN0CvA+unE55fp7EmXQdcq3xHf07/Wj9EX1lawf4nOA
         U/Z29s//mQ0y7j35CHEz9yNJsc1ovZQM6O2qzrr30k1EPQJRB8voYQXk84GZtAqaxR+z
         r5aNQpjxjU7ZbP5mS6b0VLADvji8ZTkLjxbCx1N9CmSMPQiSroy/+xwZNAoVi/rWe/+u
         gC9j/dTKnuchOkx4NVAhj5o0m8GmF/IbSlJh1wxlk91ebHaYOwQdHe997wbMrsJCRF+v
         iCmnKZU1uld+RRHnK1dSt3Gcsk3HMS8vHzawnk17iHsx8HSLVTLDDD6efWqcP9307a3R
         HWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9R+3nS+6lf72MGoAssRY+zCXXoW/UwC4DS/gYhCBvbg=;
        b=GKBsB+PRb4NBhq9SBjZFOmH+h0Z0R43o9N7avt+8g4OGgUdrIDKCLx77stQ0QC7eHX
         3RXAnO7sah0qvI813lPLincNmywdGv2N9U7felW+FT+MNFH2SCkk4Sk8fyo/oDGFVogn
         5BXS3m0Cziw5Jh+aaY7bh745QE12uLEgBkExlRcrPAlVTVOeX/hB7fsq/p6A/I56aXme
         w+ka4KnF9hiZwZPmPcJEVsRbBjJUu5yfffblPgDPktWYyoDVG5yvFID105vQhF6MgkWH
         SkPeY5CE2EfzXetdRmNNIblqFX0EMgxlinz+YieD2X5HlbXF8XPsYWDDZVDTvqTY8fCH
         9T/Q==
X-Gm-Message-State: AOAM532SE8zbUlTV0kYh1Y/NlV0EFUIceXmXJsxd2eRPgjjOr9ks1603
        M6xFGgWpn+dMMjtfxXq0+CUaF8+ML4kZGA==
X-Google-Smtp-Source: ABdhPJzFySWmDp9K1x3JstsNtG29Y87pAGodbxB5nOPB2PmBkA3T2Aq5c/XdV/hyM7qy8l/aa6foeQ==
X-Received: by 2002:a92:1f11:: with SMTP id i17mr8456884ile.277.1594143992948;
        Tue, 07 Jul 2020 10:46:32 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v62sm13558223ila.37.2020.07.07.10.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 10:46:32 -0700 (PDT)
Subject: Re: [PATCH] block: remove a bogus warning in __submit_bio_noacct_mq
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20200707174503.4162535-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb59f085-2856-8c0b-4fa3-b2aa619c7c2d@kernel.dk>
Date:   Tue, 7 Jul 2020 11:46:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707174503.4162535-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/20 11:45 AM, Christoph Hellwig wrote:
> If blk_mq_submit_bio flushes the plug list, bios for other disks can
> show up on current->bio_list.  As that doesn't involve any stacking of
> block device it is entirely harmless and we should not warn about
> this case.

Applied, thanks.

-- 
Jens Axboe

