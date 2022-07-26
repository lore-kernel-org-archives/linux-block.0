Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D30C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 08:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiGZId6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbiGZIdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 04:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4891F30F74
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658824428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/L41wz4KfwgumlSZP65sogrhzOFMrAJBy5CglxISY0=;
        b=IjU3RpDfiKM724eHzS3KUgLKac+cIToSUSSg5f1h0WLeqRJZB3O2V2DZXkf1lFwdGImvAM
        MEiy/2bChdqr7pNfyIt5vud+E3NaWGiT+hwGQXphdgLg/W0WvYUtZgAHAlKKgFPfUqAsMy
        EI0T3kyESuMpTwzlSZuD6XylQen98Ak=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-XQ4IWrfeO8ag-W3s7T9RUw-1; Tue, 26 Jul 2022 04:33:46 -0400
X-MC-Unique: XQ4IWrfeO8ag-W3s7T9RUw-1
Received: by mail-ed1-f69.google.com with SMTP id e6-20020a056402190600b0043bde36ab23so5135622edz.11
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 01:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/L41wz4KfwgumlSZP65sogrhzOFMrAJBy5CglxISY0=;
        b=6Q0yVObDpn1tXil90p4Hgli9imy2ufO2XoD62lslXfgGtbfQMwKeg4xXMIuZv1yzla
         3275uQ4e9mA9vLw96h7/5+rtZuo5+i/I2GpwbPCqWE2DD01H3zL+1GWGlbeBgyhQBcsb
         VNwrZ7mfqWbiymiXOT5CNbgQ0LU7EpEN+YYqkcdLLoDV8x4Y0Of8qy3svIsOIvfY0Cpz
         Wz43ywbAT8ZEsSEa9T8nIBMo0DTl9eAvFe+aDDrMnU0YMntcMe76bb1gUBNfnZ/PKqoT
         lTqKEg6vWGxIvLUZhr6A+fSraDOfu+HmNEsFMb+nPM+bksRYWG9SqfU3xWf5HltY+EbZ
         ltvA==
X-Gm-Message-State: AJIora/fOQSH2fg0bR/OBOje54E8bSAgA+uPhAWns9FqkYdJnN5UZNtk
        GQ5jUfcp3z/4sL1rRd+HvFXOwO92TSKDCHXtW+gThGthi42d+syDLNyp6SIvnl78mv3C1WJqHUi
        AD6A8jnKQqjVtkW/XnFK7J54YbOFoMjvaPyUlIPs=
X-Received: by 2002:a05:6402:270d:b0:43c:2e9:53ae with SMTP id y13-20020a056402270d00b0043c02e953aemr8774243edd.135.1658824425587;
        Tue, 26 Jul 2022 01:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tXBwVOVNTJFOTI1/3OFNE0xuh4x/y1Z/F50vSE0USDMvxeBb45wW+d5vqLult/8B2KtjlKRV3heicD+/8FRfY=
X-Received: by 2002:a05:6402:270d:b0:43c:2e9:53ae with SMTP id
 y13-20020a056402270d00b0043c02e953aemr8774238edd.135.1658824425401; Tue, 26
 Jul 2022 01:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220719025216.1395353-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220719025216.1395353-1-shinichiro.kawasaki@wdc.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 26 Jul 2022 16:33:34 +0800
Message-ID: <CAHj4cs_XGXhHZsipb-BA2O_acaeBjDXa-CDfY771=a_GfEaU6w@mail.gmail.com>
Subject: Re: [PATCH blktests v2] common/cpuhotplug: allow _offline_cpu() call
 in sub-shell
To:     "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shin'ichiro

This change introduced one new issue that the offline operation will
be skipped when there are more than one test devs.

# cat config
TEST_DEVS=(/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1)
# ./check block/008
block/008 => nvme0n1 (do IO while hotplugging CPUs)          [passed]
    read iops  336729   ...  343317
    runtime    12.791s  ...  12.498s
block/008 => nvme1n1 (do IO while hotplugging CPUs)          [failed]
    read iops          ...
    runtime    0.225s  ...  0.225s
    --- tests/block/008.out 2022-07-26 01:26:32.733912082 -0400
    +++ /mnt/tests/kernel/storage/SSD/nvme_blktest/blktests/results/nvme1n1/block/008.out.bad
2022-07-26 04:29:01.940374953 -0400
    @@ -1,2 +1,3 @@
     Running block/008
    +Failed to offline CPU: offlining cpu but RESTORE_CPUS_ONLINE is not set
     Test complete
block/008 => nvme2n1 (do IO while hotplugging CPUs)          [failed]
    read iops          ...
    runtime    0.231s  ...  0.231s
    --- tests/block/008.out 2022-07-26 01:26:32.733912082 -0400
    +++ /mnt/tests/kernel/storage/SSD/nvme_blktest/blktests/results/nvme2n1/block/008.out.bad
2022-07-26 04:29:02.210381850 -0400
    @@ -1,2 +1,3 @@
     Running block/008
    +Failed to offline CPU: offlining cpu but RESTORE_CPUS_ONLINE is not set
     Test complete

On Tue, Jul 19, 2022 at 11:04 AM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> The helper function _offline_cpu() sets a value to RESTORE_CPUS_ONLINE.
> However, the commit bd6b882b2650 ("block/008: check CPU offline failure
> due to many IRQs") put _offline_cpu() call in sub-shell, then the set
> value to RESTORE_CPUS_ONLINE no longer affects function caller's
> environment. This resulted in off-lined CPUs not restored by _cleanup()
> when the test case block/008 calls only _offline_cpu() and does not call
> _online_cpu().
>
> To fix the issue, set RESTORE_CPUS_ONLINE in _have_cpu_hotplug() in
> place of _offline_cpu(). _have_cpu_hotplug() is less likely to be called
> in sub-shell. In same manner, do not set RESTORE_CPUS_ONLINE in
> _online_cpu() either. Check that RESTORE_CPUS_ONLINE is set in
> _offline_cpu() to avoid unexpected CPUs left off-lined. This check also
> avoids a shellcheck warning.
>
> Fixes: bd6b882b2650 ("block/008: check CPU offline failure due to many IRQs")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Change fix approach: fix _offline_cpu() instaed of block/008 test script.
>
>  common/cpuhotplug | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/common/cpuhotplug b/common/cpuhotplug
> index 7facd0d..e91c3bc 100644
> --- a/common/cpuhotplug
> +++ b/common/cpuhotplug
> @@ -27,17 +27,20 @@ _have_cpu_hotplug() {
>                 SKIP_REASONS+=("CPU hotplugging is not supported")
>                 return 1
>         fi
> +
> +       RESTORE_CPUS_ONLINE=1
>         return 0
>  }
>
>  _online_cpu() {
> -       # shellcheck disable=SC2034
> -       RESTORE_CPUS_ONLINE=1
>         echo 1 > "/sys/devices/system/cpu/cpu$1/online"
>  }
>
>  _offline_cpu() {
> -       # shellcheck disable=SC2034
> -       RESTORE_CPUS_ONLINE=1
> +       if [[ -z ${RESTORE_CPUS_ONLINE} ]]; then
> +               echo "offlining cpu but RESTORE_CPUS_ONLINE is not set"
> +               return 1
> +       fi
> +
>         echo 0 > "/sys/devices/system/cpu/cpu$1/online"
>  }
> --
> 2.36.1
>


-- 
Best Regards,
  Yi Zhang

