Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63916C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 14:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A7E218A4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 14:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfA3OJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:09:04 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:41579 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA3OJE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 09:09:04 -0500
Received: by mail-lj1-f178.google.com with SMTP id k15-v6so20798557ljc.8
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 06:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPT4aGlEOE0VHpTZ28DSjXPsAhanbj4kwcrostWAe44=;
        b=azhblLGhzcWcVaLW7kjEkoCO4aOz1HxOavn3vtDdabUuzahkyMOs5QEDfHGC8sy8J8
         1d9xp0Di1GHXBMcZj9DeLxXFtfv2Dl7KW80OjnM53u2OPpMJKTkYE9heZMJfwJgx1SCb
         azj0O2iEL2qVRLgiWbMWMAAnb/I0jfrYQKWWL8FcDcbAUj62Z0/wPj+2XboSdC6O2Acr
         6QTGxWiavcI0nhfH/B4dAzeFAcw/Vu/FYVzzFp60GcaAqY/Tem8Vz8byz7T8OMi1Fk6w
         3dAcSHA71b5nP6MfYRSOIgVd/cVrh0/aPys0uT4a2dxVcMN+mIjSw6wqFr7m4j5Nu9zj
         qJCQ==
X-Gm-Message-State: AHQUAubQ7xcxOD2NvlDWDgLZlj96AKcdlWMk64+coJ6d/TvXWq3IQlxf
        FosdOyOuqzNXkyr95udEt9Dhwd9USzpFAL0W8t+eLQ==
X-Google-Smtp-Source: ALg8bN6u4umQwD6AR6Uy+2PQFQhUJYebQGxiGvZiDe++rqWSD9dolfXNkK0ZcVMGSQ8WqJZI2/j6xaNqDBbJI/ph8g0=
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr15953823ljk.128.1548857342379;
 Wed, 30 Jan 2019 06:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
In-Reply-To: <yq1lg34f4i7.fsf@oracle.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Wed, 30 Jan 2019 09:08:50 -0500
Message-ID: <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 11:54 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> We rounded up LBS when we created the DM device. And therefore the
> bv_len coming down is 4K. But one of the component devices has a LBS of
> 512 and fails this check.
>
> At first glance one could argue we should just nuke the BUG_ON since the
> sd code no longer relies on bv_len. However, the semantics for WRITE
> SAME are particularly challenging in this scenario. Say the filesystem
> wants to WRITE SAME a 4K PAGE consisting of 512 bytes of zeroes,
> followed by 512 bytes of ones, followed by 512 bytes of twos, etc. If a
> component device only has a 512-byte LBS, we would end up writing zeroes
> to the entire 4K block on that component device instead of the correct
> pattern. Not good.
>
> So disallowing WRITE SAME unless all component devices have the same LBS
> is the correct fix.

Alternately, could possibly WRITE_SAME bios be accepted with the
minimum sector size of the stack rather than the max, e.g. 512 in this
example rather than 4k? They'd need to have a granularity of the
larger sector size, though, presumabily necessitating new queue limits
write_same_{granularity,block_size}, which might be too much work. For
devices with bigger sectors, the block layer or DM would need to
expand the small-sector payload to an appropriate larger-sector
payload, but it would preserve the ability to use WRITE_SAME with
non-zero payloads.

(I use WRITE_SAME to fill devices with a particular pattern in order
to catch failures to initialize disk structures appropriately,
personally, but it's just for convenience/speed.)
