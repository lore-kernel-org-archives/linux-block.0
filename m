Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BF1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A45F61279
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJRIRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhJRIRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:17:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE06C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:15:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ls18so11666827pjb.3
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=+gRjmRbNTKt74z2UFAAwwuQCSuKaxEzIjqTRQN3aeG8=;
        b=RG7v3W2gNkqLw6EpCrgupvmWxyvM5x4IsFutW11bMF99Dag7hClOEyt65qqX8Ol8Ss
         Nl3lXDK22Z2jffvIH0JFvJw8LmbLO40JzOJFhgthHecZvthsxAQHtnLnvcfWo8jIfQYc
         /z7kdUcZqTcfrknsoyLvIHUkpgzDh33tN1Py23x2mG6jn+lljSK/Iq4kWZuPo+dEDiHY
         7UnEzSOI8roVXWNN5XUvlpxR4UfhGsJrOKGeuxM7f2JmPGdfUqrFqLAfXg9sBwrKR9ra
         65B9bl9DK/s/qU7KCQqmdCWLxgk1tVRe+U4CLMTR4AwmKXJd+rZzxKvqLdFGUNkDObW3
         +YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+gRjmRbNTKt74z2UFAAwwuQCSuKaxEzIjqTRQN3aeG8=;
        b=ihesLOjMfUR0joq+XSLnUeDoimPZ9MYyR/S8BrGEd8DwTmfBW02ndHzp+k4ThMIY5i
         u+NsS2gqRTOhSdxkWGxKf8+fSAF17jX/UsrrNMOe0EkLTP0FOyYQsDO6hssto/uxSP7G
         8nLq5NWWs6aDnSU2jqlaOnM4RaXA8eM6UQ6SLdzUQ2xD3IexeKmcx8eT64qkX+g3Ntsl
         0BxcCZPB6pTsWlkmEkAMiMQMQg+9KweHeGTl/oRTWesb4sEw/sYKuvilqQewPVEwrPab
         JKYaZB0Osmw/T9gchR7do0ypXDS/+NhLu0yF7O94n7SG01oftAWMn78C5N8IyyKtDmmU
         HDAQ==
X-Gm-Message-State: AOAM531e4BIPnPNZsXYbdT14SvfbeY90VbC5N+umDzBfebWx/zQ1mckg
        /So73P3ezEXAJQuIRR+b+mRJphAAfnk=
X-Google-Smtp-Source: ABdhPJxxnLeoaC67wFszySNH5nXz+8J7I5tvzuHiYPFiYwnQ5XvBlVjdV5Y59en/JK6TmeoOHqtojQ==
X-Received: by 2002:a17:90b:3a84:: with SMTP id om4mr31928959pjb.153.1634544941629;
        Mon, 18 Oct 2021 01:15:41 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id t3sm11612883pgu.87.2021.10.18.01.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 01:15:41 -0700 (PDT)
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
 <156eaf61-a225-d560-ebfe-617756ad2c5e@gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <4b2fb355-b54f-bf55-fc64-1ce4a081994a@gmail.com>
Date:   Mon, 18 Oct 2021 21:15:33 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <156eaf61-a225-d560-ebfe-617756ad2c5e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

the ataflop driver got broken in commit 6ec3938cff95f (ataflop: convert 
to blk-mq), three years ago. Can't remember seeing that one before.

Looking at a debug log, I get:

[ 7919.150000] fd_open: type=0
[ 7919.180000] Queue request: drive 0 type 0
[ 7919.200000] Request params: Si=0 Tr=0 Se=1 Data=00541000
[ 7919.200000] do_fd_action
[ 7919.200000] fd_rwsec(), Sec=1, Access=r
[ 7919.200000] finish_fdc: dummy seek started
[ 7920.550000] FDC irq, status = a0 handler = 001ea00a
[ 7920.550000] finish_fdc_done entered
[ 7920.550000] finish_fdc() finished

I would have expected an interrupt from fd_rwsec() (which sets 
fd_rwsec_done() as IRQ handler), but calling finish_fdc() from the 
request function while interrupts for the controller are disabled but a 
request is in-flight pretty much ensures we never see fd_rwsec_done()
called:

         ReqCnt = 0;
         ReqCmd = rq_data_dir(fd_request);
         ReqBlock = blk_rq_pos(fd_request);
         ReqBuffer = bio_data(fd_request->bio);
         setup_req_params( drive );
         do_fd_action( drive );

         if (bd->last)
                 finish_fdc();
         atari_enable_irq( IRQ_MFP_FDC );

The old driver used a wait queue to serialize requests, and only called 
finish_fdc() when no further requests were pending. I wonder how to make 
sure finish_fdc() only gets called in the same situation now ... 
bd->last clearly isn't the right hint here.

I suspect this isn't the only thing that broke...

Cheers,

	Michael


On 18/10/21 12:47, Michael Schmitz wrote:
> Hi Tetsuo,
>
> nevermind - stock 5.9 doesn't work either (mount hangs indefinitely).
>
> Might have to do with format autoprobing - I'll try that next.
>
> Cheers,
>
>     Michael
>
>
> On 18/10/21 08:05, Michael Schmitz wrote:
>>> Michael Schmitz wrote:
>>>> Not as a module, no. I use the Atari floppy driver built-in. Latest
>>>> kernel version I ran was 5.13.
>>>
>>> Great. Can you try this patch alone?
>>
>> Doesn't appear to work, sorry.
>>
>> Regards,
>>
>>     Michael Schmitz
>>
>>>
>>>  drivers/block/ataflop.c | 55 ++++++++++++++++++++---------------------
>>>  1 file changed, 27 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
>>> index a093644ac39f..adfe198e4699 100644
>>> --- a/drivers/block/ataflop.c
>>> +++ b/drivers/block/ataflop.c
>>> @@ -1986,8 +1986,6 @@ static int ataflop_alloc_disk(unsigned int
>>> drive, unsigned int type)
>>>      return 0;
>>>  }
>>>
>>> -static DEFINE_MUTEX(ataflop_probe_lock);
>>> -
>>>  static void ataflop_probe(dev_t dev)
>>>  {
>>>      int drive = MINOR(dev) & 3;
>>> @@ -1998,12 +1996,30 @@ static void ataflop_probe(dev_t dev)
>>>
>>>      if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
>>>          return;
>>> -    mutex_lock(&ataflop_probe_lock);
>>>      if (!unit[drive].disk[type]) {
>>>          if (ataflop_alloc_disk(drive, type) == 0)
>>>              add_disk(unit[drive].disk[type]);
>>>      }
>>> -    mutex_unlock(&ataflop_probe_lock);
>>> +}
>>> +
>>> +static void atari_floppy_cleanup(void)
>>> +{
>>> +    int i;
>>> +    int type;
>>> +
>>> +    for (i = 0; i < FD_MAX_UNITS; i++) {
>>> +        for (type = 0; type < NUM_DISK_MINORS; type++) {
>>> +            if (!unit[i].disk[type])
>>> +                continue;
>>> +            del_gendisk(unit[i].disk[type]);
>>> +            blk_cleanup_queue(unit[i].disk[type]->queue);
>>> +            put_disk(unit[i].disk[type]);
>>> +        }
>>> +        blk_mq_free_tag_set(&unit[i].tag_set);
>>> +    }
>>> +
>>> +    del_timer_sync(&fd_timer);
>>> +    atari_stram_free(DMABuffer);
>>>  }
>>>
>>>  static int __init atari_floppy_init (void)
>>> @@ -2015,11 +2031,6 @@ static int __init atari_floppy_init (void)
>>>          /* Amiga, Mac, ... don't have Atari-compatible floppy :-) */
>>>          return -ENODEV;
>>>
>>> -    mutex_lock(&ataflop_probe_lock);
>>> -    ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
>>> -    if (ret)
>>> -        goto out_unlock;
>>> -
>>>      for (i = 0; i < FD_MAX_UNITS; i++) {
>>>          memset(&unit[i].tag_set, 0, sizeof(unit[i].tag_set));
>>>          unit[i].tag_set.ops = &ataflop_mq_ops;
>>> @@ -2072,7 +2083,12 @@ static int __init atari_floppy_init (void)
>>>             UseTrackbuffer ? "" : "no ");
>>>      config_types();
>>>
>>> -    return 0;
>>> +    ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
>>> +    if (ret) {
>>> +        printk(KERN_ERR "atari_floppy_init: cannot register block
>>> device\n");
>>> +        atari_floppy_cleanup();
>>> +    }
>>> +    return ret;
>>>
>>>  err:
>>>      while (--i >= 0) {
>>> @@ -2081,9 +2097,6 @@ static int __init atari_floppy_init (void)
>>>          blk_mq_free_tag_set(&unit[i].tag_set);
>>>      }
>>>
>>> -    unregister_blkdev(FLOPPY_MAJOR, "fd");
>>> -out_unlock:
>>> -    mutex_unlock(&ataflop_probe_lock);
>>>      return ret;
>>>  }
>>>
>>> @@ -2128,22 +2141,8 @@ __setup("floppy=", atari_floppy_setup);
>>>
>>>  static void __exit atari_floppy_exit(void)
>>>  {
>>> -    int i, type;
>>> -
>>> -    for (i = 0; i < FD_MAX_UNITS; i++) {
>>> -        for (type = 0; type < NUM_DISK_MINORS; type++) {
>>> -            if (!unit[i].disk[type])
>>> -                continue;
>>> -            del_gendisk(unit[i].disk[type]);
>>> -            blk_cleanup_queue(unit[i].disk[type]->queue);
>>> -            put_disk(unit[i].disk[type]);
>>> -        }
>>> -        blk_mq_free_tag_set(&unit[i].tag_set);
>>> -    }
>>>      unregister_blkdev(FLOPPY_MAJOR, "fd");
>>> -
>>> -    del_timer_sync(&fd_timer);
>>> -    atari_stram_free( DMABuffer );
>>> +    atari_floppy_cleanup();
>>>  }
>>>
>>>  module_init(atari_floppy_init)
>>>
