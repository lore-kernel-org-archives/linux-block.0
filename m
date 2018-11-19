Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633EC43610
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1769B206BA
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ih6r76k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1769B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeKSN2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:28:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44957 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeKSN2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 08:28:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4497242pgr.11
        for <linux-block@vger.kernel.org>; Sun, 18 Nov 2018 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BYQRzulUfKMZkwHjgjrhWbw0fQOF03QCMk8NzJ9SnoE=;
        b=Ih6r76k2RMyAhFhV7fDhDQZ/tHcEzgeN8iJJQ6Vy4xm82fa8aZdOw9rIHBfbeMQlB3
         x6U1UTgM2juuNlw7uH7TmZWCmpdDK5BgcmLKKcCzgXfLVVo3C9Xh4I6UvD+7qR2h1hTc
         OQp17cuuQuiK+23s+ORwqfnbfHekQ7IwBNl6kuPeMGB8b89Ornvm9n5Ng9PGX6o0hQwK
         kcbIBstPvzTKg+BY5agIF+EM8E3F4wWP+HNzDrPKQVFSSZvWspsnOHezD7rsxObgUguq
         zPu+8AJk/Eh17xxCpEPhwiGEuBO6MYFEmSqNF5MgzQMtZIV19jDRPkgBEU4JB2StYNea
         wwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BYQRzulUfKMZkwHjgjrhWbw0fQOF03QCMk8NzJ9SnoE=;
        b=uVkdcG2dsHkpzo2bjEunecNPhTtoUu05THqiA8vlLRzBEogI2v1S2v3HxvhJy1xJH2
         Dzz9apNmyBzBfhKyS4zrZU/yIyRc4HsLCnpyRudFxyz+L7pmq5c9w2wKMEIuAjWku5vf
         5xJAPxTqpMnoP5o+JUpiZCtvrFgKps/e8ty0dlpjDobycixDY/B6wEBTiLVe0CkVnGFB
         9JZeI2pgId7G09ckDFfXDLbvErSBMtX+VtyhGWog1NF0iA4gW1aNEbRPvT+pjjAzXMPc
         QGdwDY0xTigdW6Mz0lnLuzIZFAjxlVqDGi/KsI7urD9ZEjLPnIH5vGV/yL1ph+9qFkZn
         +Xog==
X-Gm-Message-State: AGRZ1gIKPORUGSpSVICHNU2EjG6d4F+zJApaAd5dXAGbRUpvE0EBulHV
        pbmEgK9esNPWUbk69AecpYp//92/agE=
X-Google-Smtp-Source: AJdET5eEp31TgAM+Cq014NBy8M9y9cP3x48x6GHmbV95nrI46G+trLqeqWEAknJKSUCJsrHbKoeRJQ==
X-Received: by 2002:a65:66ce:: with SMTP id c14mr18390406pgw.450.1542596788529;
        Sun, 18 Nov 2018 19:06:28 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c14-v6sm43375003pfc.92.2018.11.18.19.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 19:06:27 -0800 (PST)
Subject: Re: a9f38e1dec ("floppy: convert to blk-mq"): INFO: task mount:661
 blocked for more than 120 seconds.
To:     kernel test robot <lkp@intel.com>, Omar Sandoval <osandov@fb.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <5bf0d0d9.2S1lqKo/21KXGcuH%lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4baa37de-8ec3-45cb-2a31-f5eff0806f48@kernel.dk>
Date:   Sun, 18 Nov 2018 20:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5bf0d0d9.2S1lqKo/21KXGcuH%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/18 7:39 PM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit a9f38e1dec107af70d81338332494bf0a1e76597
> Author:     Omar Sandoval <osandov@fb.com>
> AuthorDate: Mon Oct 15 09:21:34 2018 -0600
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Tue Oct 16 09:50:14 2018 -0600
> 
>     floppy: convert to blk-mq
>     
>     This driver likes to fetch requests from all over the place, so make
>     queue_rq put requests on a list so that the logic stays the same. Tested
>     with QEMU.
>     
>     Signed-off-by: Omar Sandoval <osandov@fb.com>
>     
>     Converted to blk_mq_init_sq_queue() and fixed a few spots where the
>     tag_set leaked on cleanup.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

This should be fixed by:

commit de7b75d82f70c5469675b99ad632983c50b6f7e7
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 9 15:58:40 2018 -0700

    floppy: fix race condition in __floppy_read_block_0()

which isn't in the tree that you tested. It's in -rc3, and in Linus's
tree since:

commit 59749c2d49bf28df69ac4bcabf1f69b00d3dca59
Merge: 9b5f361ac4a9 8dc765d438f1
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Nov 16 09:31:59 2018 -0600

    Merge tag 'for-linus-20181115' of git://git.kernel.dk/linux-block

-- 
Jens Axboe

