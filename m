Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77116C77B73
	for <linux-block@archiver.kernel.org>; Sat, 27 May 2023 18:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjE0Sqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 May 2023 14:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE0Sqt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2023 14:46:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4710099
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 11:46:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d2467d640so2453700b3a.1
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685213202; x=1687805202;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYsRt3MiDR1O9eBbuP1CMxCbL6hgj3SPt6TEdEgHYAo=;
        b=GO1x2Bj7vXteIbaGIrcIm3ocjbcABu2YIyrROurPKGBL2sZBUmPHNxlW6PygzafEFM
         ffqu/AjxlLCdcAgv3pmAJxDKTPxkvqZl0o2lBf7wWa7hdGYDMZ5TkAm21qAQp/zT3hN2
         rRZV2ymwG48BBrn80JbW5SoKLM9cQRU/0+NCCr8jO5Fuora0xqQfQBB5aQTvAXRwJVTE
         /lXwNhhNtgH3C36Fa6iEuH/wo9aP/ITzBpVgdrjN2/WF+hCOyikz6Wf+9GrLto+GNQ9l
         jG+jaO6/mTwyNwalqRaqxcD/A/W1+mvpbFDctTpBizlDCfaWuQ+2mYXi8KyDxzInK6Yg
         K0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685213202; x=1687805202;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYsRt3MiDR1O9eBbuP1CMxCbL6hgj3SPt6TEdEgHYAo=;
        b=HK0OHLzBi3tt7A0UVmg1/56bzs4gcjL2v+rSbSazzBRTKCsKjcTHzv/MUQgiqXYWr9
         sJ/46vnSjZ67vCSW5/iCy3e1VgE0MBqzjJM5PtnLZV1WgcNkBPQdwn6J6TIkeeJlDa0y
         dKRuHu3F9qrmiSYGzyKLnQSihxWHvJdujpo+654M2Vo1bmY4TqeU+pJw/uYjafBF+3MR
         4j+GJhDvjlJdMF1R/4Ke+6yh3uov3z7tQBrTw+OjXToeEPtqXcz8NQ6aKPTK3qT+8oHp
         +PFHGSJIDuo0S+ht/mz+9kBdVeCd00XKIKf0PHpOM0I9atGuFbVoSlANsdn53Z01nBxc
         PjfA==
X-Gm-Message-State: AC+VfDwUGqNUsXxY8rZHLZdkIdXcm9Kv0RdMIp7O6ZQxlZYgg/Ukm6m5
        ifMijhHcK4KjIqn0qWxiPB43xzoONRGs5id9zFs=
X-Google-Smtp-Source: ACHHUZ4tgtAmYzaDW+bxEgewduwYbZbHiOMX3Ryq7AeULYO9xlcdfdEC89v82sV1lsHGifZvKY4lpA==
X-Received: by 2002:a05:6a20:a129:b0:104:1f67:1157 with SMTP id q41-20020a056a20a12900b001041f671157mr3782884pzk.26.1685213202433;
        Sat, 27 May 2023 11:46:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:6970:bea0:7062:f728:d545:50d1])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090ace8800b00246b7b8b43asm4441636pju.49.2023.05.27.11.46.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 11:46:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: block: significant performance regression in iSCSI rescan
From:   Brian Bunker <brian@purestorage.com>
In-Reply-To: <b7c9d102-ff68-a8c6-c33d-9dd730a13c12@kernel.org>
Date:   Sat, 27 May 2023 11:46:30 -0700
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0359CF74-A712-49F2-8E8B-276306535A4A@purestorage.com>
References: <CAHZQxyKsym0E-GaV0cLQKH8GgO8X_4QR8WjiGghdjswhObLG0g@mail.gmail.com>
 <b7c9d102-ff68-a8c6-c33d-9dd730a13c12@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On May 26, 2023, at 4:31 PM, Damien Le Moal <dlemoal@kernel.org> =
wrote:
>=20
> On 5/27/23 00:48, Brian Bunker wrote:
>> Hello,
>>=20
>> One of our customers reported a significant regression in the
>> performance of their iSCSI rescan when they upgraded their initiator
>> Linux kernel:
>>=20
>> =
https://forum.proxmox.com/threads/kernel-5-15-usr-bin-iscsiadm-mode-sessio=
n-sid-x-rescan-really-slow.110113/
>>=20
>> This was determined not to be an array side issue, but I chased the
>> problem for him. The issue comes down to a patch:
>>=20
>> commit 508aebb805277c541e94ee14daba4191ff02347e
>> Author: Damien Le Moal <damien.lemoal@wdc.com>
>> Date:   Wed Jan 27 20:47:32 2021
>>=20
>>    block: introduce blk_queue_clear_zone_settings()
>>=20
>> When I connect 255 volumes with 2 paths to each and run an iSCSI
>> rescan there is a significant difference in the time it takes. The
>> rescan of iscsiadm rescan is a parallel sequential scan of the 255
>> volumes on both paths. It comes down to this for each device:
>>=20
>> [root@init107-18 boot]# cd /sys/bus/scsi/devices/11\:0\:0\:1
>> [root@init107-18 11:0:0:1]# echo 1 > rescan
>> [root@init107-18 boot]# cd /sys/bus/scsi/devices/10\:0\:0\:1
>> [root@init107-18 10:0:0:1]# echo 1 > rescan
>> ...
>>=20
>> (As 5.11.0-rc5+)
>> Without this patch:
>> Command being timed: "iscsiadm --mode session --rescan"
>> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.04
>>=20
>> Just adding this patch on the previous:
>> Command being timed: "iscsiadm --mode session --rescan"
>> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:13.45
>>=20
>> In the most recent Linux kernel, 6.4.0-rc3+, the regression is not as
>> pronounced but is still significant.
>>=20
>> With:
>> Command being timed: "iscsiadm --mode session --rescan"
>> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:04.84
>>=20
>> Without:
>> Command being timed: "iscsiadm --mode session --rescan"
>> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.53
>>=20
>> With the second being only the result of:
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -953,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum
>> blk_zoned_model model)
>>                blk_queue_zone_write_granularity(q,
>>                                                =
queue_logical_block_size(q));
>>        } else {
>> -               disk_clear_zone_settings(disk);
>> +               /* disk_clear_zone_settings(disk); */
>>        }
>> }
>> EXPORT_SYMBOL_GPL(disk_set_zoned);
>>=20
>> =46rom what I can tell this patch is trying to account for a change =
in
>> zoned behavior moving to none. It looks like it is saying that there
>> is no good way to tell between this moving to none and never =
reporting
>> block zoned capabilities at all. The penalty on targets which don't
>> support zoned capabilities at all seems pretty steep. Is there a
>> better way to get what is needed here without affecting disks which
>> are not zoned capable?
>>=20
>> Let me know if you need any more details on this.
>=20
> Can you try this and see if that restores rescan times for your system =
?
>=20
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..4dd59059b788 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -915,6 +915,7 @@ static bool disk_has_partitions(struct gendisk =
*disk)
> void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
> {
>        struct request_queue *q =3D disk->queue;
> +       unsigned int old_model =3D q->limits.zoned;
>=20
>        switch (model) {
>        case BLK_ZONED_HM:
> @@ -952,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum
> blk_zoned_model model)
>                 */
>                blk_queue_zone_write_granularity(q,
>                                                =
queue_logical_block_size(q));
> -       } else {
> +       } else if (old_model !=3D BLK_ZONED_NONE) {
>                disk_clear_zone_settings(disk);
>        }
> }
Yes. This works to eliminate the delay since it doesn=E2=80=99t penalize =
the device that came in as BLK_ZONED_NONE.

Command being timed: "iscsiadm --mode session =E2=80=94rescan"
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.53

Thanks,
Brian
>=20
>>=20
>> Thanks,
>> Brian Bunker
>> PURE Storage, Inc.
>=20
> --=20
> Damien Le Moal
> Western Digital Research


