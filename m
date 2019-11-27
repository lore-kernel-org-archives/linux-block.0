Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD42C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 00:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CEC206CC
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 00:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0A01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 19:26:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39441 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfK0A00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 19:26:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so7558300pga.6
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 16:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJuYe+PsCI6P+eyyxdVgUH9g533Ua741q9WNzj/EUVM=;
        b=kUWOLLmWI9kz66t9DbLDrQi7Y3S6vZEuX7cMoYPwcQRG0sfL7doaWG+giJPo+ogRFz
         6nYOCs3wQbFr5dTJy5WtxBons+n+Rvol5xzaoijRiE6VsG6lT+DAWPEE4sOLkdLBZQ1X
         3u6NZakLCMXxirS+/MlVGtlrCbyn8bplSrP7XmVtlehvwbzMOhpNIBgfjWRvLXD9HXm7
         hmUVg4NR8ll9hG09BDAPSPZDoMgdT0mUwBmA2FkrhU6/oMFKaSFf3DAd6/CrDieLYyiC
         JElNM36CVEwlkc8H/4JX4ZA6s5+v8NH08Pw82p1yDnlNfG5GloyMW5ss8EOY6CcCPm9X
         BOaA==
X-Gm-Message-State: APjAAAW5WwhhwC0UbtpMU+nESLbi3vprQqEgx6WT7oHsmx2Sxq2eow2n
        oTc43sKhZEU3VdMSkpCp1D7FSQvN
X-Google-Smtp-Source: APXvYqzjZTX6fmhqFABNC532Y4PEHVT/UlkyhJAkO1xDLgIGWSlFTM8V2xLtBiqisoVpKh42mt00NQ==
X-Received: by 2002:a63:6882:: with SMTP id d124mr1453726pgc.281.1574814385476;
        Tue, 26 Nov 2019 16:26:25 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f59sm4583829pje.0.2019.11.26.16.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 16:26:24 -0800 (PST)
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
 <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
 <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
 <20191127000407.GC20652@jaegeuk-macbookpro.roam.corp.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3ca36251-57c4-b62c-c029-77b643ddea77@acm.org>
Date:   Tue, 26 Nov 2019 16:26:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127000407.GC20652@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 4:04 PM, Jaegeuk Kim wrote:
> Subject: [PATCH] loop: avoid EAGAIN, if offset or block_size are changed
> 
> This patch tries to avoid EAGAIN due to nrpages!=0 that was originally trying
> to drop stale pages resulting in wrong data access.

Does this patch remove all code that returns EAGAIN from the code paths 
used for changing the offset and block size? If so, please make the 
commit message more affirmative.

>   	if (lo->lo_offset != info->lo_offset ||
> -	    lo->lo_sizelimit != info->lo_sizelimit) {
> -		sync_blockdev(lo->lo_device);
> -		kill_bdev(lo->lo_device);
> -	}
> +	    lo->lo_sizelimit != info->lo_sizelimit)
> +		drop_caches = true;

If the offset is changed and dirty pages are only flushed after the loop 
device offset has been changed, can that cause data to be written at a 
wrong LBA? In other words, I'd like to keep a sync_blockdev() call here.

> +	/* truncate stale pages cached by previous operations */
> +	if (!err && drop_caches) {
> +		sync_blockdev(lo->lo_device);
> +		invalidate_bdev(lo->lo_device);
> +	}

Is the invalidate_bdev() call necessary here?

Thanks,

Bart.
