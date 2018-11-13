Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90000C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C41216FD
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sAVLfeU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C41216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeKNB5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:57:22 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36121 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeKNB5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:57:22 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so19175399itd.1
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t44LMP3n91DBozkqMvyyQAsGah4IRlXgUbEbF824tJ4=;
        b=sAVLfeU8CDmx1viWbDJ1zhKKUHaTf4gGMRGUoDlZEUGEKUASFKWgDHK225Efsb3ERe
         1utKoJti+ERv3YjabzwpKrdIxSZ9+rkFvr0w4I8E5FJdqp3zDaK30AnIUN/L/0sPmQde
         O/FQO2IQUkEWOWujUEQ9SnwwwutVY2lvY9lBQi7cc94BlePE/T1ZgY6Mwoq2XNPpNWgs
         n1yASY0qwJhB+R6cy3P7ytSCXSIDi5wWiFF/5ksyOIcbaINiDfLmtz22bY0hIni+FZDO
         F6verDOhSV9efmR4HnVE2yyjRQAvSVbJj/wGn1Jy0sRd9D4Xkj0nYHYHQaTqEeI2S8nu
         gjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t44LMP3n91DBozkqMvyyQAsGah4IRlXgUbEbF824tJ4=;
        b=gvE6GgU7UGPjtaAIwGhkhaxJVl+Wx6Y1T0GOsVMtiZ24WU+ptmUEhS2y2DU49ho18v
         gHeI65/QL8WXs7CTQVbvuMeobDcnASEArK27HRqz9zbUAg76HuJx5wnbIxejpAm5fwCB
         QQAq3Sw6XiEJY8qwlyuhqHZ038CB7K8jogkc5BjCGMpnJgVx+valutis7TpzX7+pw2aH
         F1Ni4imIh67hC2mk8yIqQmvVadIR+OvzDVs37914ptzpp04OtXhkAZA46f8VqnkL1Qdm
         koEEIPHhypigolnnKxpmHCt3UhnwQixQJ/8vdkz7hbwB71JBwyN2CQqYgvwg9zJK3T9h
         thzg==
X-Gm-Message-State: AGRZ1gLpZie5VHaL5qnzpcibx4/A9UagWFOIhGn+B6bVb34RMt3bbNyF
        6ESlPETiH/jyug/5PY4Z4IJGpg7AMyE=
X-Google-Smtp-Source: AJdET5e/r3vsKwl14HChzv85Ll8nfLZtdC0/INk5BjCXcmH+YC5bLKtcXLTMTrbTrfCN4FC+/Pm/aw==
X-Received: by 2002:a24:250c:: with SMTP id g12-v6mr4235398itg.169.1542124719512;
        Tue, 13 Nov 2018 07:58:39 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x191-v6sm6544858itb.3.2018.11.13.07.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:58:38 -0800 (PST)
Subject: Re: [PATCH 06/11] block: add polled wakeup task helper
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org
References: <20181113154233.15256-1-axboe@kernel.dk>
 <20181113154233.15256-7-axboe@kernel.dk>
 <20181113155255.GB9827@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a811ef9b-c72d-73ba-93aa-27c6a4b2f112@kernel.dk>
Date:   Tue, 13 Nov 2018 08:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113155255.GB9827@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 8:52 AM, Keith Busch wrote:
> On Tue, Nov 13, 2018 at 08:42:28AM -0700, Jens Axboe wrote:
>> If we're polling for IO on a device that doesn't use interrupts, then
>> IO completion loop (and wake of task) is done by submitting task itself.
>> If that is the case, then we don't need to enter the wake_up_process()
>> function, we can simply mark ourselves as TASK_RUNNING.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c         |  6 ++----
>>  fs/iomap.c             |  3 +--
>>  include/linux/blkdev.h | 19 +++++++++++++++++++
>>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> One more for swap read:
> 
> ---
> diff --git a/mm/page_io.c b/mm/page_io.c
> index d4d1c89bcddd..57572ff46016 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -140,7 +140,7 @@ static void end_swap_bio_read(struct bio *bio)
>  	unlock_page(page);
>  	WRITE_ONCE(bio->bi_private, NULL);
>  	bio_put(bio);
> -	wake_up_process(waiter);
> +	blk_wake_io_task(waiter);
>  	put_task_struct(waiter);
>  }
>  

Indeed, thanks Keith! I'll fold it in.

-- 
Jens Axboe

