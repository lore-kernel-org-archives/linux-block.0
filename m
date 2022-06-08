Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62574C43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 05:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiFHFZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 01:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiFHFYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 01:24:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F66466
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 19:39:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso5372528pjk.5
        for <linux-block@vger.kernel.org>; Tue, 07 Jun 2022 19:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6bOa4esw0xksLVfNdAT6B93rV/P/8VSGEKMP6EjzR0E=;
        b=K6KpXwM81tTGGNFDdq17Lj1eMk1q3eODHH8nocGcaU9nWe7rFntrd/gnI4dJmrX5ot
         jelT47mS9pdJT0S2PzSCrNgL5Sh63CeXCG+aYcN+ywbxrVtSsSCUllZRXU38BSZmlUri
         DAKxKJgyjtIwfLg5ysES88sOtfU39kmTixM4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6bOa4esw0xksLVfNdAT6B93rV/P/8VSGEKMP6EjzR0E=;
        b=MKZUKujbxIr5npY0+KU3Ac6rjL7EJZpbeQMXa4E7swKtvtcoIc8deEMo5hUlC7QPrG
         tv0ozxYZWWMV5b2VZtTAagSbe6Xf8CrO551En6fh+hOAUHwcxh+razwUH5t7yjsJayA3
         Aw9UZ3Wi19Jlw4y0tZ0pve/q88AXlqWijqFsPNID8Hn8QiFrhI1bS7Y+EAWsMURdjJyt
         3lwlTqsEHRci1RPmskYR4uLes/wSUa3y/TyE8ZZuYg3qKrLn7ilpbZEdq26OiQzyM/4t
         cFA6plve1/gN5mV2n05EbR/jtr55TI4b0QPJta8F7R3WJ4LzNIXgzuq7h0lp7zwxUm5d
         u0VA==
X-Gm-Message-State: AOAM5315CFWMAOWnWKD5RrBgHaQIsQF63Aw6wEsMVPd4mDUnJxYM/rdm
        QpA0aEkodP67iYraMGkDnVwesA==
X-Google-Smtp-Source: ABdhPJyJZwIgrQupdT+vh6Z2lrRhM1s6jhssKdeRPoFc/TqToiSIDBj6GM5p6VPlbfki0O4rCxkesQ==
X-Received: by 2002:a17:90b:3a8f:b0:1e8:7669:8a2f with SMTP id om15-20020a17090b3a8f00b001e876698a2fmr16728205pjb.55.1654655998366;
        Tue, 07 Jun 2022 19:39:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:463d:a192:6128:66e])
        by smtp.gmail.com with ESMTPSA id 84-20020a621857000000b0050dc7628158sm13612168pfy.50.2022.06.07.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 19:39:57 -0700 (PDT)
Date:   Wed, 8 Jun 2022 11:39:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqAL+HeZDk5Wug28@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp/kpPA7GdbArXDo@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/06/07 16:52), Minchan Kim wrote:
> > rootfs: https://oebuilds.tuxbuild.com/29zhlbEc3EWq2wod9Uy964Bp27q/images/am57xx-evm/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4.gz
> > kernel: https://builds.tuxbuild.com/29zhqJJizU2Y7Ka7ArhryUOrNDC/zImage
> > 
> > Boot command,
> >  /usr/bin/qemu-system-aarch64 -cpu host,aarch64=off -machine
> > virt-2.10,accel=kvm -nographic -net
> > nic,model=virtio,maaacaddr=BA:DD:AD:CC:09:04 -net tap -m 2048 -monitor
> > none -kernel kernel/zImage --append "console=ttyAMA0 root=/dev/vda rw"
> > -hda rootfs/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4
> > -m 4096 -smp 2
> > 
> > # cd /opt/kselftests/default-in-kernel/zram
> > # ./zram.sh
> > 
> > Allow me sometime I will try to bisect this problem.
> 
> Thanks for sharing the info. 
> 
> I managed to work your rootfs with my local arm build
> based on the problematic git tip. 
> However, I couldn't suceed to reproduce it.
> 
> I needed to build zsmalloc/zram built-in instead of modules
> Is it related? Hmm,
> 
> Yeah, It would be very helpful if you could help to bisect it.

This looks like a NULL lock->name dereference in lockdep. I suspect
that somehow local_lock doesn't get .dep_map initialized. Maybe running
the kernel with CONFIG_DEBUG_LOCK_ALLOC would help us? Naresh, can you
help us with this?
