Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E940C432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7712068E
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 22:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKZWzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:55:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38216 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZWzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 17:55:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id o8so4472375pls.5
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 14:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgEEW/UH3kb15X6JqzbKcUuYqMs8pruCu+p11nAmg3E=;
        b=JmVUX+a+0DK/6mPW8DPoP60HBUTiczDEiBF2gESG74t6UjVlWyzYAthF6KQyaFfUd5
         dp+H427YtAJ1DwHEqnB9Y9YB/wuw1O/uhjT0KxdqsFAiFs51nysXfxSeiLBjFhfubvg4
         1bkQh/df191kiTX8DLyMz4lL4j0nMI3inmG3z1c34WIKbAm6iTOPJhypeHax0X/dluEj
         1ugsFoMEotP/0e7C+n7SBu346WkmfllCMmlg9BQSjQ5Uj70KLAxEu8JnqQTKDIpHDSGS
         uuO8ewC+SiFTqrY4YfxTXD1HxVfhYGgEud92X0dJah4zA5QE6h1+xSk4CJv8xILCoPeH
         10yQ==
X-Gm-Message-State: APjAAAV/w4GTTTv4biVvyiF5RuzNP7YaJ4tUFYxETfTfcDdKDLQXHk0G
        gcEtjMBX4G2lt7Wnqu5lpnTUHdQE
X-Google-Smtp-Source: APXvYqxZteb5uuNImTu5eLUPhowbUrcU+l+zA6shN46J9++t/1X98zUUrtr2H9fPmdy7Mk/7lBw/YA==
X-Received: by 2002:a17:90a:e50a:: with SMTP id t10mr1920774pjy.67.1574808899953;
        Tue, 26 Nov 2019 14:54:59 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s15sm4041991pjp.3.2019.11.26.14.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 14:54:59 -0800 (PST)
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20190518004751.18962-1-jaegeuk@kernel.org>
 <20190518005304.GA19446@jaegeuk-macbookpro.roam.corp.google.com>
 <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
 <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
Date:   Tue, 26 Nov 2019 14:54:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 2:32 PM, Jaegeuk Kim wrote:
> +static void
> +loop_mq_freeze_queue(struct loop_device *lo)
> +{
> +	for (;;) {
> +		sync_blockdev(lo->lo_device);
> +
> +		/* I/O need to be drained during transfer transition */
> +		blk_mq_freeze_queue(lo->lo_queue);
> +
> +		if (is_dirty_bdev(lo->lo_device))
> +			blk_mq_unfreeze_queue(lo->lo_queue);
> +		else
> +			break;
> +	}
> +	kill_bdev(lo->lo_device);
> +}

Maybe I overlooked something, but how does the above code prevent that 
pages get dirtied after is_dirty_bdev() returns false? 
blk_mq_freeze_queue() freezes lo->lo_queue but not the filesystem that 
uses that request queue. Did you perhaps want to call a function that 
freezes filesystem activity from inside the loop (not sure if such a 
function already exists)?

[ ... ]
>   	/* I/O need to be drained during transfer transition */
> -	blk_mq_freeze_queue(lo->lo_queue);
> +	if (drop_cache)
> +		loop_mq_freeze_queue(lo);
> +	else
> +		blk_mq_freeze_queue(lo->lo_queue);

How about always calling loop_mq_freeze_queue(), independent of the 
value of 'drop_cache'? I think that will make the code both easier to 
read and easier to test.

> +	/* I/O need to be drained during transfer transition */
> +	if (drop_cache)
> +		loop_mq_freeze_queue(lo);
> +	else
> +		blk_mq_freeze_queue(lo->lo_queue);

Same comment here.

> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9c073dbdc1b0..81fe3beef92b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -74,6 +74,18 @@ static void bdev_write_inode(struct block_device *bdev)
>   	spin_unlock(&inode->i_lock);
>   }
>   
> +bool is_dirty_bdev(struct block_device *bdev)
> +{
> +	struct inode *inode = bdev->bd_inode;
> +	bool dirty;
> +
> +	spin_lock(&inode->i_lock);
> +	dirty = inode->i_state & I_DIRTY ? true: false;
> +	spin_unlock(&inode->i_lock);
> +	return dirty;
> +}

Since the Linux kernel 'bool' datatype conforms to C99, I think that the 
" ? true : false" part can be left out. From include/linux/types.h:

typedef _Bool			bool;

 From http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf: "When 
any scalar value is converted to _Bool, the result is 0 if the value 
compares equal to 0; otherwise, the result is 1."

Thanks,

Bart.
