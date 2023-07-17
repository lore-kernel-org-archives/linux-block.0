Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DBC001DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 15:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGQPQs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 11:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGQPQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 11:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A63B10A
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 08:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2807061121
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 15:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7149C433C8;
        Mon, 17 Jul 2023 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607006;
        bh=nXX5U3Wy/uzuYdNNloz6mHy7t8LtYCxpWlLoF99FxDQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=CsjRT3HQRDgaDIOwyPR3PRm91KqKsTsOBhJbjXmP4wPTlSVBg3Iom2xz1NeDZ1L13
         DpgBvAQSgFn8/b4aiGaH42Mi8rOpl3p7oK70uQvCTN/hWtsquGJhhVwegkhNj/gW1r
         iXeTkdbKbzKmfEDw3NZldNiu31dB0GvTet7OENFbJp5H3WIA+zpzAwuJx7BNIRaT4p
         EDKV8c+I/JJBDSVb+dV5dT7TR69xICNxzsTNWS3kyBF0lw+WeNoEU9Dv7WWSNjICr4
         HtQoqI2ZDo8qAQY1hnr26O6XPbUJ5IUU2UdxGGlIJ0cKD4JLjNZ+I8FIVZHs4lNjAE
         WKaEnGG50dgPw==
Message-ID: <bb6503f1-30a0-dc63-5b28-527bfe722135@kernel.org>
Date:   Mon, 17 Jul 2023 23:16:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com>
 <20230711050101.GA19128@lst.de>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
In-Reply-To: <20230711050101.GA19128@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/11 13:01, Christoph Hellwig wrote:
> I think that's because it doesn't look at sbi->s_ndevs in
> destroy_device_list.  Let's try the variant below, which also fixes
> the buildbot warning for non-zoned configfs:
> 
> ---
>  From 645d8dceaa97b6ee73be067495b111b15b187498 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 7 Jul 2023 10:31:49 +0200
> Subject: f2fs: don't reopen the main block device in f2fs_scan_devices
> 
> f2fs_scan_devices reopens the main device since the very beginning, which
> has always been useless, and also means that we don't pass the right
> holder for the reopen, which now leads to a warning as the core super.c
> holder ops aren't passed in for the reopen.
> 
> Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
> Fixes: 0718afd47f70 ("block: introduce holder ops")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
