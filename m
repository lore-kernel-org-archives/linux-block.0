Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1922FC31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 23:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E458420873
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 23:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFRXJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:09:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRXJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 19:09:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so8477565pgp.11
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 16:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+0rxfcxlZwIeqW8jrMcTilk3njKwpQzURkuH6tHapw=;
        b=fdYz2v872P4+lq4WvCSsGabiHbBRp2AhiG5F1v/m/908ICYUEFAR4TMfwQaBR4xd/L
         QW63z60HT6WtLKyLHAdbui5OnRdwVcJ1lEPnDxGCg7PoZggTviIE/UoHqmyAfkr3Yn/I
         dyW2XfV/ZglAVPCVb8kmKMmeeNK80thH+dl1cxtEWB/LCS03niqpJbD+QEYSEazDhuTo
         B0DlEtUUTbkr7Y1/4960xUpC6xMZrwh7XdH+D5kS8fe0MvzUGY+tIjIrdvF3i48ST8F1
         sDXMZga/yIbcGIy8q0a8R+oUIQenzkQwTDAVThcJaw956lCn30xVLf+vHtd5gnYuZN0f
         AHFw==
X-Gm-Message-State: APjAAAUYo+872TKm/Mjx+EdQ12e8VQPLie3SDdRdwKynrOaEB3NynSy1
        IFyDnaOlkqJEGl9ICBdvH2APQ0vsi3M=
X-Google-Smtp-Source: APXvYqxrUDA8zOlW+dIfm8e9oQuC2my0pPGouhgNyTDD3wOfwVhDJblZwQccbYWc5K9kfQgNt9b+pQ==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr4657956pga.397.1560899368978;
        Tue, 18 Jun 2019 16:09:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y23sm19724195pfm.117.2019.06.18.16.09.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 16:09:27 -0700 (PDT)
Subject: Re: [REGRESSION] commit c2b3c170db610 causes blktests block/002
 failure
To:     Theodore Ts'o <tytso@mit.edu>, Omar Sandoval <osandov@fb.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     linux-block@vger.kernel.org
References: <20190609181423.GA24173@mit.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e84b29e1-209e-d598-0828-bed5e3b98093@acm.org>
Date:   Tue, 18 Jun 2019 16:09:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609181423.GA24173@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/19 11:14 AM, Theodore Ts'o wrote:
> I recently noticed that block/002 from blktests started failing:
> 
> root@kvm-xfstests:~# cd blktests/
> root@kvm-xfstests:~/blktests# ./check block/002
> block/002 (remove a device while running blktrace)
>      runtime  ...
> [   12.598314] run blktests block/002 at 2019-06-09 13:09:00
> [   12.621298] scsi host0: scsi_debug: version 0188 [20190125]
> [   12.621298]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [   12.625578] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> [   12.627109] sd 0:0:0:0: Power-on or device reset occurred
> [   12.630322] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   12.634693] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> [   12.638881] sd 0:0:0:0: [sda] Write Protect is off
> [   12.639464] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
> [   12.646951] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [   12.658210] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
> [   12.722771] sd 0:0:0:0: [sda] Attached SCSI disk
> block/002 (remove a device while running blktrace)           [failed]left
>      runtime  ...  0.945s0: [sda] Synchronizing SCSI cache
>      --- tests/block/002.out	2019-05-27 13:52:17.000000000 -0400
>      +++ /root/blktests/results/nodev/block/002.out.bad	2019-06-09 13:09:01.034094065 -0400
>      @@ -1,2 +1,3 @@
>       Running block/002
>      +debugfs directory leaked
>       Test complete
> root@kvm-xfstests:~/blktests#
> 
> The git bisect log (see attached) pointed at this commit:
> 
> commit c2b3c170db610896e4e633cba2135045333811c2 (HEAD, refs/bisect/bad)
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Tue Mar 26 15:18:20 2019 -0700
> 
>      perf stat: Revert checks for duration_time
>      
>      This reverts e864c5ca145e ("perf stat: Hide internal duration_time
>      counter") but doing it manually since the code has now moved to a
>      different file.
>      
>      The next patch will properly implement duration_time as a full event, so
>      no need to hide it anymore.
>      
>      Signed-off-by: Andi Kleen <ak@linux.intel.com>
>      Acked-by: Jiri Olsa <jolsa@kernel.org>
>      Link: http://lkml.kernel.org/r/20190326221823.11518-2-andi@firstfloor.org
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Is this a known issue?

Hi Ted,

Test block/002 removes a SCSI device by writing into the "delete" sysfs 
attribute. As one can see in __scsi_remove_device() that triggers a 
synchronous call of blk_cleanup_queue(). The "debugfs directory leaked" 
message is reported if the request queue debugfs directory is found 
after SCSI device deletion has finished. Request queue debugfs directory 
deletion happens upon the final put of the request queue (see also 
__blk_release_queue()). I don't think that there is any guarantee that 
the debugfs directory disappears immediately after SCSI device deletion 
has finished. In other words, I think that this is a bug in test 
block/002. Omar, are you the author of that test script?

Bart.
