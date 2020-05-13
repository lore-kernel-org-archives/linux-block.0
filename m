Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE7C2D0F6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0035D23127
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cXEFkIcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEMCcQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 22:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEMCcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 22:32:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB7C061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 19:32:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so7088280pgl.9
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 19:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=imu9L77crqtoA2SmZi6G6kXcpu11IQYsJ6/ryBEJs6A=;
        b=cXEFkIcHzHwAs/wkjPQCBfu2piLh9+qWk4HAmRgtgRWfZdJYms3n/yVNbEYGtADZtX
         1vTb0w0sAskgSdnYRwta9jYf9UunMoeZSIa85NScjEgncIwWo2g9SjmaAp4Rt6QUlQF5
         JRx3eTJHOLwuyl920HIzWHYcrYpxhtodnKRZlnNbS59a5GOgYmy7J/jN+6d94uOIz0JN
         o7LQZ4lmT7E9+ly+CtOmTbMxKC0I69tN5FOFNvq62TCnB4Jm2bX0FYEvb+HqfwPsQOuZ
         Lj03SghaQPeflZR1nqUfv1RHmkKZxI4Gt87nqYX47WcmSY8KEMc1P8YK/hRFgt9z0+j3
         Q3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=imu9L77crqtoA2SmZi6G6kXcpu11IQYsJ6/ryBEJs6A=;
        b=WuZ/4b8CXnkyq0YmPOVncoin/MlYtOcECCeWNWmmj2LGwsFIQTlLNuskIerYYNzjWg
         0YhIMyL1FfCUE0/9GMZY336ltZS75jZ25UWcGXfKTH4Hu54crd1Mas+2n3ResIey6c7L
         azRWOsAImCoYzxObRmvE36oisVlBVRyMFqDU9QAAjHpoLU0Zu4xi/zZJoMNelJBsCgKX
         OMYi9D34GSlY+86llydW+6I3dYZGUKb0GhU8khoubs4cdDLZKFJ6X16sGZqgy8dq274a
         jt3eXNuq5Esbl0L0XT1nVbCXKcCfE2nur4TqB22Lxh0IgzjnE1YJJt2QF6BoEU95AqAE
         zj8w==
X-Gm-Message-State: AGi0PuYOr8vFCyWpB7/RZJaQ45VZzCgouoE6DlWRzY0onC+suMaf1MPb
        zslWRCkrlDqu+RvAbHFy/cH5VQ==
X-Google-Smtp-Source: APiQypKaLwXSRhSkCwX4LnO8pt4XlRWviPyxutuqJBzfeR0bzK52nFSR9fbsd6bItrnRK2GMNd2wVQ==
X-Received: by 2002:aa7:979d:: with SMTP id o29mr24519391pfp.90.1589337135368;
        Tue, 12 May 2020 19:32:15 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id 10sm32464pfx.138.2020.05.12.19.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:32:14 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] block: fix partition use-after-free and
 optimization
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
References: <20200508081758.1380673-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <647fad2a-ad08-1d9a-85ec-6e29b2dadb2b@kernel.dk>
Date:   Tue, 12 May 2020 20:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508081758.1380673-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/8/20 2:17 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch fixes one use-after-free on cached last_lookup partition.
> 
> The other 3 patches optimizes partition uses in IO path.
> 
> V3:
> 	- add reviewed-by tag
> 	- centralize partno check in the helper(4/4)
> 
> V2:
> 	- add comment, use part_to_disk() to retrieve disk instead of
> 	adding one field to hd_struct
> 	- don't put part in blk_account_io_merge

Applied for 5.8, thanks.

-- 
Jens Axboe

