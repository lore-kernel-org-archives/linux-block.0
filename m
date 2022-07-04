Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A37CC43334
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 05:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGDFoz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 01:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiGDFoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 01:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9696265D9
        for <linux-block@vger.kernel.org>; Sun,  3 Jul 2022 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656913386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shRKojcJ3G+YzL1IOXUVI5CglVJvwXcRL6/hy+eLs54=;
        b=VTJF+6Z1K3SRw6wFcEL/c5eFhlFz7VCPPnqMVv4WeQom5hHleKIzmdW5FuVArB1D18BKuw
        j61QeJxRDLOhXGHlv7+BQe68uZsMU51ZrtG37YTLN8JcYdKVIWLer98Qa4f8tvP4eTwMxw
        J7CPG0kdtDyXsmozeQCwUa/nazQ4GBY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-Hyrc0iGjO4CEGtSonaj8RA-1; Mon, 04 Jul 2022 01:43:03 -0400
X-MC-Unique: Hyrc0iGjO4CEGtSonaj8RA-1
Received: by mail-pj1-f71.google.com with SMTP id q8-20020a17090a304800b001ef82a71a9eso1789179pjl.3
        for <linux-block@vger.kernel.org>; Sun, 03 Jul 2022 22:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shRKojcJ3G+YzL1IOXUVI5CglVJvwXcRL6/hy+eLs54=;
        b=IZYSLGHpHfwrnEvPTxFuYWT+Zy4rO5o/dqdGlWeDDapDv7lwBkujbA3Cb8NQyUgiTs
         laQdwoiGcp2Sr2zhPvazqkIn/49xrnLguKIuO3Cio+9688XEYkxyctgZhfDqbJmIKOfm
         XDyVz6cGBraaxA8KMve22CwQbfL+2Ati4HeyBvq5ZtiwRfsjOAvQCt8+8fkND0XpWO7S
         6U80YJUi5+tL/DmTd9z1hAQfR/GE6lm8ms0DBj8tFEuDCK5Au1fEuoBh2EWtFX1uDYKB
         jRjeocZow1/nTWnZYFTQ3+XBpnuLwkWeSVdkXFQJSxuCFE2pPLBx7z70JOjBOMekpW8u
         r1tQ==
X-Gm-Message-State: AJIora+1QtqUEfZxFSmblRADeOOrBX0OXc/n48juvkhzywcklMd24ayc
        ZtIdCzKdzDzvngJgTC0tMeMpfHoHyTF4ZlO+L7cuz/QsOQx7abx8+FM485wPBpzI1FWIlcBMyqe
        IA/zSlraiIeLE6n9+eNnaPeLPsuwwTHYn4P3csS0=
X-Received: by 2002:a17:90b:1107:b0:1ef:8d13:542f with SMTP id gi7-20020a17090b110700b001ef8d13542fmr1413941pjb.204.1656913381998;
        Sun, 03 Jul 2022 22:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssPv5US/9hTXM4IwbZyG12cYdBYO0ipfRCJpKknxcM7kMZQIrRErxpj8o4hR75Ei4mE+tWsnqxPdSSk8zw4PY=
X-Received: by 2002:a17:90b:1107:b0:1ef:8d13:542f with SMTP id
 gi7-20020a17090b110700b001ef8d13542fmr1413913pjb.204.1656913381692; Sun, 03
 Jul 2022 22:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
In-Reply-To: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 4 Jul 2022 13:42:50 +0800
Message-ID: <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
To:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

update the subject to better describe the issue:

So I tried this issue on one nvme/rdma environment, and it was also
reproducible, here are the steps:

# echo 0 >/sys/devices/system/cpu/cpu0/online
# dmesg | tail -10
[  781.577235] smpboot: CPU 0 is now offline
# nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
no controller found: failed to write to nvme-fabrics device

# dmesg
[  781.577235] smpboot: CPU 0 is now offline
[  799.471627] nvme nvme0: creating 39 I/O queues.
[  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
[  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18

On Thu, Jun 30, 2022 at 2:02 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
> I found this issue when I run blktests after offline cpus on
> linux-block/for-next, here are the steps and dmesg log,
> and from the log, the test failed with the target connect, feel free
> to let me know if you need any info/test, thanks.
>
> # echo 0 >/sys/devices/system/cpu/cpu0/online
> # ./check nvme/004
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]
>     runtime    ...  0.725s
>     --- tests/nvme/004.out 2022-06-30 01:50:53.637275584 -0400
>     +++ /root/blktests/results/nodev/nvme/004.out.bad 2022-06-30
> 01:55:22.321399448 -0400
>     @@ -1,5 +1,7 @@
>      Running nvme/004
>     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
>     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
>     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>     +Failed to write to /dev/nvme-fabrics: Invalid cross-device link
>     +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
>     +cat: /sys/block/n1/uuid: No such file or directory
>     ...
>     (Run 'diff -u tests/nvme/004.out
> /root/blktests/results/nodev/nvme/004.out.bad' to see the entire diff)
> # dmesg
> [ 1526.169417] numa_remove_cpu cpu 0 node 0: mask now 1-31
> [ 1526.170619] smpboot: CPU 0 is now offline
> [ 1531.030430] loop: module loaded
> [ 1531.115255] run blktests nvme/004 at 2022-06-30 01:55:21
> [ 1531.305557] loop0: detected capacity change from 0 to 2097152
> [ 1531.354299] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1531.402815] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> [ 1531.404124] nvme nvme0: creating 31 I/O queues.
> [ 1531.448181] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang

