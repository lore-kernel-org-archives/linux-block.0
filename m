Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E600C38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 17:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIGR1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIGR1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 13:27:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D353881B04
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 10:27:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j6so10995681qkl.10
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sOJSFaykwA71BM98SyYsFLb6fIMi8ySU+zYqTYP9bc4=;
        b=lN8CxxKRIuPWjEOgSoZDvX6twhOYfL3Ethh3d6ax4lwlse73go5Cw5kUAxPRZ5EHc6
         o5+7VylM43zMPXYIkijSH5ew6ssQ/yLKhWFU8fl/WwkW/RiCtsI69TJznTs5U4aCV78L
         InhhnnupX/mZOKVEcsBBFXLxfy/BNtXcMr+cvM3j2+MrxY6WsvWnrlOJbTpkjTIzutt7
         VhVQj4sLhWbs4Z/7haL7TyhFBLilcPMku892+BkzblD4hbgt47OTujp7oMSIhF2XCGhk
         zTzddwz/KbRAHpOaiA0f3Vo2w8LoiAkXKUCIQ9ZmzYx4CsMUdnuylkcVaxQSnUswzv6m
         r7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sOJSFaykwA71BM98SyYsFLb6fIMi8ySU+zYqTYP9bc4=;
        b=pdbLdMfPfN+XYKHR9c+coY875yJF5Q+gH6Zd94Ts0+phigpIP6n79p45NmALgeaxVd
         BBzBiBZsQT5igI4F+f29HTNLvrccLao4sJqgZYf1hEF61aDrGOgbxtKL3GZx37oxhUNZ
         i4FcioySg/39UE1iNcu+SN3d63yIbQFjmgzpTOh/sLdWRPkIQBO5u54Wr7CVWSR8nEPp
         V5YRRPO7cJ1w51G/q1Xyulk9/x02uVKgcnhlABs//8AGW2arjnxO5E5Y/wF/CSIsgyPF
         W/9o2prpl+AmPjsTrhNPwLBkBp3383pjFPF46pmGyk+Blj83V3VMajEaemfyOCN5GbOM
         5PrQ==
X-Gm-Message-State: ACgBeo1yZDmZdNsfb+EWcn0lTTSfSkI4UCPgmY40RAF5OBMmKJ+gVBvL
        IAkdK5jTTdx3fgIWIfmY4eiLGg==
X-Google-Smtp-Source: AA6agR4+oBzuazP2mneC5bji7XTtzimB5QvY91JcE6Zp0ly/g79PWWAzf5vSEBI6QH793GlX1IP5Gg==
X-Received: by 2002:ae9:e519:0:b0:6bc:475:abd4 with SMTP id w25-20020ae9e519000000b006bc0475abd4mr3475473qkf.310.1662571652857;
        Wed, 07 Sep 2022 10:27:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id gb3-20020a05622a598300b00359961365f1sm1647235qtb.68.2022.09.07.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:27:32 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:27:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: Fix hung when signal interrupts
 nbd_start_device_ioctl()
Message-ID: <YxjUfQUc66B+N1e7@localhost.localdomain>
References: <20220907163502.577561-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907163502.577561-1-syoshida@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 08, 2022 at 01:35:02AM +0900, Shigeru Yoshida wrote:
> syzbot reported hung task [1].  The following program is a simplified
> version of the reproducer:
> 
> int main(void)
> {
> 	int sv[2], fd;
> 
> 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
> 		return 1;
> 	if ((fd = open("/dev/nbd0", 0)) < 0)
> 		return 1;
> 	if (ioctl(fd, NBD_SET_SIZE_BLOCKS, 0x81) < 0)
> 		return 1;
> 	if (ioctl(fd, NBD_SET_SOCK, sv[0]) < 0)
> 		return 1;
> 	if (ioctl(fd, NBD_DO_IT) < 0)
> 		return 1;
> 	return 0;
> }
> 
> When signal interrupt nbd_start_device_ioctl() waiting the condition
> atomic_read(&config->recv_threads) == 0, the task can hung because it
> waits the completion of the inflight IOs.
> 
> This patch fixes the issue by clearing queue, not just shutdown, when
> signal interrupt nbd_start_device_ioctl().
> 
> Link: https://syzkaller.appspot.com/bug?id=7d89a3ffacd2b83fdd39549bc4d8e0a89ef21239 [1]
> Reported-by: syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
