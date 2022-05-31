Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbiEaTAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiEaTAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:00:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D998089
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:00:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x17so10833932wrg.6
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+n7oqdn8x8KCoI4HSKetaET/n/0PIQKmbRu5HcvcLWY=;
        b=U7zDo/ofXTVaKPPuBYlTxa9FwYRnKzQcrijtSoIPyvG5XoIfZ1cieyfV4rE8WmQr1I
         pQhq2HrBaAdtDBIb7gomL3sHv6HHbBUzG6DvGm/2tG+NQmmSl4dZoTQtOFQTgOaga3d1
         S3XY1HLzV6J5ZlWoeLh8XI1Xow7ij3CWRnbC5QephQhCA8hlKdJ4Moo2wiLzFh7jrWKi
         wXWg2mRcclKMts0Z250t9Ckqhx4OnMf/jI4s1mRmV7Ok3z+6mKvcN0Mv3akzEVaaqMHT
         4dpn+V5zCKN/xeiVPt9BJq00Ts/d+qNc6bYSr7IktX0/EZMbuNk+fZTiVA9Xj/DaKQFW
         wn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+n7oqdn8x8KCoI4HSKetaET/n/0PIQKmbRu5HcvcLWY=;
        b=VFw2v3Pxj9R10+bd51Ygujka3FstZOTYxAOoEZjJBIQ2SRjBY5PN3OjeA/IaNYieub
         X6M3NOsnZpJAaHuGkJAvXF5Kk3ljnlfJgTZT+p3DcT4c7UjSFTB3e0Q6zQvfLvwRBQsM
         pYOkCRINmD0KHrnikixytJTHOUFcYyAxyE9HLkJvFYcIItcggTxAg9HQv3hcAdS+CwcO
         8AXXFoYwgdaiXGu61Y3ckuM6zEB5Z8w2917bpucdfHH/a2jRgE+GOZAVJAhOMF24InWD
         cKqsPIEOXHy2aXD/6Aubv1wnccZiMeJ340GDV0mGNzhuRAiMi6oD4Rs9bYVDG/A5a5Wa
         56DQ==
X-Gm-Message-State: AOAM533C1vx+uiiDvbYlXU0H4V2OuQb1qL+XYfzjSmOpOy+ZPd1BPDWV
        5vACqSpWpspUaeul2hPDABgbvA==
X-Google-Smtp-Source: ABdhPJzBVpLjPA2tgT5qJl5yKAl6VPqRpZaQih1JoCwzRA32BYdfcBHAfSGLA7m6z1x5lR13iJZzUw==
X-Received: by 2002:a5d:5005:0:b0:20f:fe3b:8c18 with SMTP id e5-20020a5d5005000000b0020ffe3b8c18mr14355734wrt.126.1654023604349;
        Tue, 31 May 2022 12:00:04 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600015ca00b0020c5253d8d0sm12837934wry.28.2022.05.31.12.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 12:00:03 -0700 (PDT)
Message-ID: <6995e822-79a0-ca17-9c32-6089d14b5be5@kernel.dk>
Date:   Tue, 31 May 2022 13:00:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: bioset_exit poison from dm_destroy
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YpZlOCMept7wFjOw@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/22 12:58 PM, Mike Snitzer wrote:
> On Sun, May 29 2022 at  8:46P -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 5/28/22 6:17 PM, Matthew Wilcox wrote:
>>> Not quite sure whose bug this is.  Current Linus head running xfstests
>>> against ext4 (probably not ext4's fault?)
>>>
>>> 01818 generic/250	run fstests generic/250 at 2022-05-28 23:48:09
>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>> 01818 Buffer I/O error on dev dm-0, logical block 3670000, async page read
>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>> 01818 general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
>>> 01818 CPU: 0 PID: 1579117 Comm: dmsetup Kdump: loaded Not tainted 5.18.0-11049-g1dec3d7fd0c3-dirty #262
>>> 01818 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>>> 01818 RIP: 0010:__cpuhp_state_remove_instance+0xf0/0x1b0
>>> 01818 Code: a0 f8 d7 81 42 3b 1c 28 7f d9 4c 89 e1 31 d2 89 de 89 7d dc e8 01 fd ff ff 8b 7d dc eb c5 49 8b 04 24 49 8b 54 24 08 48 85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 c7 c7
>>> 01818 RSP: 0018:ffff888101fcfc60 EFLAGS: 00010286
>>> 01818 RAX: dead000000000100 RBX: 0000000000000017 RCX: 0000000000000000
>>> 01818 RDX: dead000000000122 RSI: ffff8881233b0ae8 RDI: ffffffff81e3b080
>>> 01818 RBP: ffff888101fcfc88 R08: 0000000000000008 R09: 0000000000000003
>>> 01818 R10: 0000000000000000 R11: 00000000002dc6c0 R12: ffff8881233b0ae8
>>> 01818 R13: 0000000000000000 R14: ffffffff81e38f58 R15: ffff88817b5a3c00
>>> 01818 FS:  00007ff56daec280(0000) GS:ffff888275800000(0000) knlGS:0000000000000000
>>> 01818 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> 01818 CR2: 00005591ad94f198 CR3: 000000017b5a0004 CR4: 0000000000770eb0
>>> 01818 PKRU: 55555554
>>> 01818 Call Trace:
>>> 01818  <TASK>
>>> 01818  ? kfree+0x66/0x250
>>> 01818  bioset_exit+0x32/0x210
>>> 01818  cleanup_mapped_device+0x34/0xf0
>>> 01818  __dm_destroy+0x149/0x1f0
>>> 01818  ? table_clear+0xc0/0xc0
>>> 01818  dm_destroy+0xe/0x10
>>> 01818  dev_remove+0xd9/0x120
>>> 01818  ctl_ioctl+0x1cb/0x420
>>> 01818  dm_ctl_ioctl+0x9/0x10
>>> 01818  __x64_sys_ioctl+0x89/0xb0
>>> 01818  do_syscall_64+0x35/0x80
>>> 01818  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> 01818 RIP: 0033:0x7ff56de3b397
>>> 01818 Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 da 0d 00 f7 d8 64 89 01 48
>>> 01818 RSP: 002b:00007ffe55367ef8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>>> 01818 RAX: ffffffffffffffda RBX: 00007ff56df31a8e RCX: 00007ff56de3b397
>>> 01818 RDX: 000055daad7cab30 RSI: 00000000c138fd04 RDI: 0000000000000003
>>> 01818 RBP: 00007ffe55367fb0 R08: 00007ff56df81558 R09: 00007ffe55367d60
>>> 01818 R10: 00007ff56df808a2 R11: 0000000000000206 R12: 00007ff56df808a2
>>> 01818 R13: 00007ff56df808a2 R14: 00007ff56df808a2 R15: 00007ff56df808a2
>>> 01818  </TASK>
>>> 01818 Modules linked in: crct10dif_generic crct10dif_common [last unloaded: crc_t10dif]
>>
>> I suspect dm is calling bioset_exit() multiple times? Which it probably
>> should not.
>>
>> The reset of bioset_exit() is resilient against this, so might be best
>> to include bio_alloc_cache_destroy() in that.
>>
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index a3893d80dccc..be3937b84e68 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -722,6 +722,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
>>  		bio_alloc_cache_prune(cache, -1U);
>>  	}
>>  	free_percpu(bs->cache);
>> +	bs->cache = NULL;
>>  }
>>  
>>  /**
> 
> Yes, we need the above to fix the crash.  Does it also make sense to
> add this?
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 49eff01fb829..f410c78e9c0c 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -681,7 +681,7 @@ struct bio_set {
> 
>  static inline bool bioset_initialized(struct bio_set *bs)
>  {
> -	return bs->bio_slab != NULL;
> +	return (bs->bio_slab != NULL || bs->cache != NULL);
>  }

Should not be possible to have valid bs->cache without bs->bio_slab?


-- 
Jens Axboe

