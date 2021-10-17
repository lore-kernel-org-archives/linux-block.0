Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9EEC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 23:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CE560E9C
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 23:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhJQXt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhJQXt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 19:49:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D03C06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 16:47:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 133so14207777pgb.1
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=KFiSVc8Zko5CpBjPKP65FXAChRXWPf23yfUAec9Ysaw=;
        b=jEwmiqtm2GSLjOOcE5MdG2hvJc0ao/68t5Z+XsY4UrfCjDhXjdqaill750WxLS0zLZ
         1UhoY71Ef2qlFgJo4AjXTa4ZLm92IbaKaeaa9c/xvPLBYYbeD+CHdfbPIPrzfci1wMmV
         FJZWIhNFPtwJyML6W+3m5kc0knnHGMBJGwmI+ozTHosZa9fbMH8CgSf0sgJNqDMxjiHb
         zNfGm1acdVSBTUadMjw0BIzuEQ/xKsd5GMpChfaWSMX39F3G22TrmM5jtQTqYZnBl9i9
         A3aUSpqmfu2kX7RZZlC91VT1NCbZA5EBy4de+g+/hOnA2WdPQ21PKLOIzmNFrcbJqkV5
         DlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KFiSVc8Zko5CpBjPKP65FXAChRXWPf23yfUAec9Ysaw=;
        b=g56K9j5/tt5kZfeXJfGlQ0dFcxnasq3cj7Ty+7bshz3MYbEVyKOYwsxEUm+WdHJ8w2
         rOSsvVZdTMQHyK5lSVU35nAkaad5WW6ZPvxSpxBaRwT6ei9A/FnbJw0KCImwE0qCKkTZ
         oq7OQrBFtdff2IRtRB1KfM051U0bjDw8NKGvgKrzWjrB9r3ntipwpnc856X+M/ky3kOF
         yLuI7UjeFYexlGhbmUATnCssOFkIDCbIpzRzariofi8fKA0EMjSvo1QuEiCKTaTbgcCW
         zAQplupaGF5X8LG+B7cXrS3zW3kdtAXz60LibATg0CHLN57bVEZODhERfrt0xGGX1VIw
         SPow==
X-Gm-Message-State: AOAM530MOaXf9Gkpn4W1T896ZHHF2Y4sjDOdEW5+FKZYmm7V7zWFSHNu
        a+uXlgaSwODB+yil4wtQlg4=
X-Google-Smtp-Source: ABdhPJySUKTRPsdxDRhXDtz6cpPbVLRvuO/9AcLU0zfFKWcqhdhzABYFLZ7DDoTMe5wPK4AdeVuSng==
X-Received: by 2002:a63:724a:: with SMTP id c10mr20499384pgn.224.1634514437907;
        Sun, 17 Oct 2021 16:47:17 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id d19sm951332pfl.129.2021.10.17.16.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Oct 2021 16:47:17 -0700 (PDT)
Subject: Re: [PATCH v2] ataflop: remove ataflop_probe_lock mutex
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>
References: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
 <6d26961c-3b51-d6e1-fb95-b72e720ed5d0@gmail.com>
 <5524e6ee-e469-9775-07c4-7baf5e330148@i-love.sakura.ne.jp>
 <7bf8ba1a-ed7c-059b-f4a1-cd7cfb5c21da@gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <156eaf61-a225-d560-ebfe-617756ad2c5e@gmail.com>
Date:   Mon, 18 Oct 2021 12:47:02 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7bf8ba1a-ed7c-059b-f4a1-cd7cfb5c21da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

nevermind - stock 5.9 doesn't work either (mount hangs indefinitely).

Might have to do with format autoprobing - I'll try that next.

Cheers,

	Michael


On 18/10/21 08:05, Michael Schmitz wrote:
>> Michael Schmitz wrote:
>>> Not as a module, no. I use the Atari floppy driver built-in. Latest
>>> kernel version I ran was 5.13.
>>
>> Great. Can you try this patch alone?
>
> Doesn't appear to work, sorry.
>
> Regards,
>
>     Michael Schmitz
>
>>
>>  drivers/block/ataflop.c | 55 ++++++++++++++++++++---------------------
>>  1 file changed, 27 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
>> index a093644ac39f..adfe198e4699 100644
>> --- a/drivers/block/ataflop.c
>> +++ b/drivers/block/ataflop.c
>> @@ -1986,8 +1986,6 @@ static int ataflop_alloc_disk(unsigned int
>> drive, unsigned int type)
>>      return 0;
>>  }
>>
>> -static DEFINE_MUTEX(ataflop_probe_lock);
>> -
>>  static void ataflop_probe(dev_t dev)
>>  {
>>      int drive = MINOR(dev) & 3;
>> @@ -1998,12 +1996,30 @@ static void ataflop_probe(dev_t dev)
>>
>>      if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
>>          return;
>> -    mutex_lock(&ataflop_probe_lock);
>>      if (!unit[drive].disk[type]) {
>>          if (ataflop_alloc_disk(drive, type) == 0)
>>              add_disk(unit[drive].disk[type]);
>>      }
>> -    mutex_unlock(&ataflop_probe_lock);
>> +}
>> +
>> +static void atari_floppy_cleanup(void)
>> +{
>> +    int i;
>> +    int type;
>> +
>> +    for (i = 0; i < FD_MAX_UNITS; i++) {
>> +        for (type = 0; type < NUM_DISK_MINORS; type++) {
>> +            if (!unit[i].disk[type])
>> +                continue;
>> +            del_gendisk(unit[i].disk[type]);
>> +            blk_cleanup_queue(unit[i].disk[type]->queue);
>> +            put_disk(unit[i].disk[type]);
>> +        }
>> +        blk_mq_free_tag_set(&unit[i].tag_set);
>> +    }
>> +
>> +    del_timer_sync(&fd_timer);
>> +    atari_stram_free(DMABuffer);
>>  }
>>
>>  static int __init atari_floppy_init (void)
>> @@ -2015,11 +2031,6 @@ static int __init atari_floppy_init (void)
>>          /* Amiga, Mac, ... don't have Atari-compatible floppy :-) */
>>          return -ENODEV;
>>
>> -    mutex_lock(&ataflop_probe_lock);
>> -    ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
>> -    if (ret)
>> -        goto out_unlock;
>> -
>>      for (i = 0; i < FD_MAX_UNITS; i++) {
>>          memset(&unit[i].tag_set, 0, sizeof(unit[i].tag_set));
>>          unit[i].tag_set.ops = &ataflop_mq_ops;
>> @@ -2072,7 +2083,12 @@ static int __init atari_floppy_init (void)
>>             UseTrackbuffer ? "" : "no ");
>>      config_types();
>>
>> -    return 0;
>> +    ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
>> +    if (ret) {
>> +        printk(KERN_ERR "atari_floppy_init: cannot register block
>> device\n");
>> +        atari_floppy_cleanup();
>> +    }
>> +    return ret;
>>
>>  err:
>>      while (--i >= 0) {
>> @@ -2081,9 +2097,6 @@ static int __init atari_floppy_init (void)
>>          blk_mq_free_tag_set(&unit[i].tag_set);
>>      }
>>
>> -    unregister_blkdev(FLOPPY_MAJOR, "fd");
>> -out_unlock:
>> -    mutex_unlock(&ataflop_probe_lock);
>>      return ret;
>>  }
>>
>> @@ -2128,22 +2141,8 @@ __setup("floppy=", atari_floppy_setup);
>>
>>  static void __exit atari_floppy_exit(void)
>>  {
>> -    int i, type;
>> -
>> -    for (i = 0; i < FD_MAX_UNITS; i++) {
>> -        for (type = 0; type < NUM_DISK_MINORS; type++) {
>> -            if (!unit[i].disk[type])
>> -                continue;
>> -            del_gendisk(unit[i].disk[type]);
>> -            blk_cleanup_queue(unit[i].disk[type]->queue);
>> -            put_disk(unit[i].disk[type]);
>> -        }
>> -        blk_mq_free_tag_set(&unit[i].tag_set);
>> -    }
>>      unregister_blkdev(FLOPPY_MAJOR, "fd");
>> -
>> -    del_timer_sync(&fd_timer);
>> -    atari_stram_free( DMABuffer );
>> +    atari_floppy_cleanup();
>>  }
>>
>>  module_init(atari_floppy_init)
>>
