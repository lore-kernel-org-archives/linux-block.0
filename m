Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4178C433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D142173E
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ekuKHbJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbgJNRdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388981AbgJNRdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 13:33:12 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27FC061755
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2020 10:33:12 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l16so115697ilj.9
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2020 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRDSdNfW5xL0OCw3aVdBJS6qEgVKNgk2J6NDdHjZfMg=;
        b=ekuKHbJedsMbsSBm4oXfbppYsLn56Hz74NMTlNJr+xKtDh5yFePtpgQ1GFFcxHUv8N
         nwsmUKbc4LxenxdGNgx9QstVxdXZ1O1BY3Zqv3iWXR3q2TYE/9GcWroqAvNS9c0KPxVF
         WSTfHtl6TjcfKvKIidKc3j/Ra4IW/I22hwJdm+lojnXIyDMC/bNkIMVMEE/sH8Lgt+J3
         KlaGAY4qtSayId/pNzcJRJhyR/LTtsKJWDWW2z3USV7L6FjxvwXFXniusl9+Wdbg9FKW
         DF4+qQWvC+D2bnEZ/yH6W+CYnMrgAyZnAohl+UizJh7PBWZiI0YidEbjqVDwiaLKlA9n
         dsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRDSdNfW5xL0OCw3aVdBJS6qEgVKNgk2J6NDdHjZfMg=;
        b=aLnZPHVg9l//TqUX37N6ROQAfD1nc7oddnGaNZZs2MczheoDBJmSO/UpswsNW5rt5I
         bd96feSVieVx6uuj8/EIQ+jbsN3TBGidwoTHRf03R90z8mRdoANXI4i+VgqfZ74OCWC3
         qr+ZeKDTwa25Cnba1aeflvGzZPUsi3K+8PRbl3YPqxcy8WJ2DPk2jpAmSdRg0OCfG0s8
         1bcGGEsp28FVZo7KTgY6Lb7I8x1Y5CJcVLOK4dmnRcAk7CsPWMg+C0OqgLxLAfs1zOty
         hfvmBBbqlcPNWfgmr0rshTlZ0krp4Ij0FZWMIqkymsckUZQHT3CsEnMd2rlCS4u5CNgO
         dHKQ==
X-Gm-Message-State: AOAM5314cdG8ODnmX4AcgdHMWszOuoSIwG5Jjbfa8O7QjErdXfv2hqY0
        vAM2e1iV5s+fy/la8OqWYEkTgCncFDKDLQ==
X-Google-Smtp-Source: ABdhPJzUZ3vbf/cJ6Jcs6Wvjja4Z71dnbGwE2d9F+nzc8UuJ+lWQrsiUsOfP05LbDstKN4ZApmWJpw==
X-Received: by 2002:a92:a012:: with SMTP id e18mr157528ili.269.1602696791688;
        Wed, 14 Oct 2020 10:33:11 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1116? ([2620:10d:c091:480::1:1580])
        by smtp.gmail.com with ESMTPSA id n138sm143461iod.40.2020.10.14.10.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:33:10 -0700 (PDT)
Subject: Re: [PATCH] nbd: make the config put is called before the notifying
 the waiter
To:     xiubli@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20201014024514.112822-1-xiubli@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <454c2a43-a0cd-68f9-80ec-172d4bded068@toxicpanda.com>
Date:   Wed, 14 Oct 2020 13:33:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201014024514.112822-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 10:45 PM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> There has one race case for ceph's rbd-nbd tool. When do mapping
> it may fail with EBUSY from ioctl(nbd, NBD_DO_IT), but actually
> the nbd device has already unmaped.
> 
> It dues to if just after the wake_up(), the recv_work() is scheduled
> out and defers calling the nbd_config_put(), though the map process
> has exited the "nbd->recv_task" is not cleared.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
