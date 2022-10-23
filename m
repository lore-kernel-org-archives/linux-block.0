Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD31ECAAA1
	for <linux-block@archiver.kernel.org>; Sun, 23 Oct 2022 15:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJWP2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Oct 2022 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWP2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Oct 2022 11:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1963FE8
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666538880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzfcPBHbnFwCrM0V1+OphN3pJsk2fWiVLnQnXpHchzY=;
        b=iOO6Eb+newa7rcV3ImbFO4PgpeSEVdrFb0tpgWkM1Ud74aJHBl/eYP5gJgf/cMoRtuyoHk
        99HkhD5ZHPowGUGC2FLp+FFP71MFHL4MzxVRWDUBvbd5Lbl3LkUs9krMopWS/ZBXaoses8
        lSSTM6oep157ZYl60EdB0jPNJafMvgw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-2v7xK-BqN5yXzrklHWSLlQ-1; Sun, 23 Oct 2022 11:27:58 -0400
X-MC-Unique: 2v7xK-BqN5yXzrklHWSLlQ-1
Received: by mail-pg1-f200.google.com with SMTP id e13-20020a63500d000000b0045bf92a0b5aso3430445pgb.22
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 08:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzfcPBHbnFwCrM0V1+OphN3pJsk2fWiVLnQnXpHchzY=;
        b=7qNwmIX9z5ulnIvrIqQq48BaoDzrabPlaWlRKXPb/rIcZnKRNj2jArzldhBKx5ONlQ
         xS3pkIamOBNtJVbgEBAF/cnnDdv0fDneFwQpjL38bCf/yTPoegfN7OrW/t/LhnwZwvP0
         wh+WTGrTGPo42ZcHwdlAA3XtWy7pJD5KE5ZOLj5nf5mWt2DI/QilHoFlE1Nsj/HvdW9T
         hEJsF+zZ8rx9wLmejEsM7RSsTR2WqQbPfkYaSOw6HqvCIAB/qVF6KeF/ju/s10stQcD4
         kfq8K0A8dqAJXsStCthusmT165BosqF3e+1YHwD7w81T3/LLWBfw59niSduZB8psmvVn
         9uzQ==
X-Gm-Message-State: ACrzQf0Sd4MEdXY0PEpJlArC7tr9BMh8hZmckOSwEq8pZ7jF4QP7TkFp
        CVnGMzYTwZSSUkQN92NX5tRk545mnjNCsJHPsKd9/RSYxYXsHxBlDHVgcnqSfebIfSMUCvGOsbS
        aeVUDQx0T0Lo+QwCoFWAwRCi+FP/irRnhYYrFlEA=
X-Received: by 2002:a17:90a:fa46:b0:20d:5efa:84fc with SMTP id dt6-20020a17090afa4600b0020d5efa84fcmr67673671pjb.20.1666538877574;
        Sun, 23 Oct 2022 08:27:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MZRr/BeD7JuUqv6S0zaPw3xHPC2OqYhpJzpU29xbRw7/M8PbcgPoj6PnM4YwfLQ5oAWgtcok6GnMk+BUS9AM=
X-Received: by 2002:a17:90a:fa46:b0:20d:5efa:84fc with SMTP id
 dt6-20020a17090afa4600b0020d5efa84fcmr67673647pjb.20.1666538877236; Sun, 23
 Oct 2022 08:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221019051244.810755-1-yi.zhang@redhat.com> <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net> <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev> <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
 <20221021235656.fxl7k4x3zjbbaiul@shindev>
In-Reply-To: <20221021235656.fxl7k4x3zjbbaiul@shindev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 23 Oct 2022 23:27:45 +0800
Message-ID: <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during mkfs.xfs
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 22, 2022 at 7:57 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Oct 21, 2022 / 21:42, Chaitanya Kulkarni wrote:
>
> ...
>
> > I think creating a minimal setup is a part of the testcase and we should
> > not change it, unless there is a explicit reason for doing so.
>
> I see, I find no reason to change the "minimal log size policy". Let's go with
> 64MB log size to keep it.
>
> Yi, would you mind reposting v2 with size=64m?
Sure, and before I post it, I want to ask for suggestions about some
other code changes:

After set log size with 64M, I found nvme/012 nvme/013 will be
failed[1], and there was not enough space for fio with size=950m
testing.
Either [2] or [3] works, which one do you prefer, or do you have some
other suggestion for it? Thanks.

[1]
nvme/012 (run mkfs and data verification fio job on NVMeOF block
device-backed ns) [failed]
    runtime  54.400s  ...  53.514s
    --- tests/nvme/012.out 2022-10-21 10:21:12.461157830 -0400
    +++ /root/blktests/results/nodev/nvme/012.out.bad 2022-10-23
09:10:01.125990759 -0400
    @@ -1,5 +1,22 @@
     Running nvme/012
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=292646912, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=336576512, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=144633856, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=149147648, buflen=4096
    ...
    (Run 'diff -u tests/nvme/012.out
/root/blktests/results/nodev/nvme/012.out.bad' to see the entire diff)
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
ns) [failed]
    runtime  172.121s  ...  292.743s
    --- tests/nvme/013.out 2022-10-21 10:21:12.461157830 -0400
    +++ /root/blktests/results/nodev/nvme/013.out.bad 2022-10-23
09:14:43.493752127 -0400
    @@ -1,5 +1,17 @@
     Running nvme/013
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=665759744, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=198172672, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=369643520, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left
on device: write offset=195624960, buflen=4096
    ...
    (Run 'diff -u tests/nvme/013.out
/root/blktests/results/nodev/nvme/013.out.bad' to see the entire diff)

[2]
diff --git a/tests/nvme/012 b/tests/nvme/012
index c9d2438..25bde25 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -29,7 +29,7 @@ test() {
        local file_path="${TMPDIR}/img"
        local subsys_name="blktests-subsystem-1"

-       truncate -s 1G "${file_path}"
+       truncate -s 2G "${file_path}"

        loop_dev="$(losetup -f --show "${file_path}")"

diff --git a/tests/nvme/013 b/tests/nvme/013
index 265b696..602c86f 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -28,7 +28,7 @@ test() {

        local subsys_name="blktests-subsystem-1"

-       truncate -s 1G "${file_path}"
+       truncate -s 2G "${file_path}"

        _create_nvmet_subsystem "${subsys_name}" "${file_path}" \
                "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
[3]
diff --git a/common/xfs b/common/xfs
index 210c924..0018212 100644
--- a/common/xfs
+++ b/common/xfs
@@ -26,7 +26,7 @@ _xfs_run_fio_verify_io() {

        _xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1

-       _run_fio_verify_io --size=950m --directory="${mount_dir}/"
+       _run_fio_verify_io --size=900m --directory="${mount_dir}/"

        umount "${mount_dir}" >> "${FULL}" 2>&1
        rm -fr "${mount_dir}"
>
> --
> Shin'ichiro Kawasaki
>


-- 
Best Regards,
  Yi Zhang

