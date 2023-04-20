Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCAAC77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 08:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjDTIFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjDTIFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 04:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80B468F
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 01:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681977868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwERD+G7giKxQA3SDjjqSpdpwrLSJtI3yoWVYKc6qSc=;
        b=OmZ2t5wwEW5Jdozrnp1RfClEapr+UV2u+QcffRHd8lSQ5sKt3qHw3M8jAlnINRkdERj1WX
        DZzyf2R4sg2YJYiAyPb4SH62XNzHDDp8sMiYQJ1QZ6YwuHYSVujbs6Gen8mhruLm5XjmQ2
        wAjXmGzi8LNup9GfqUL37llSpH+l9pk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-w1w4aiLkMty1G5yW-p-Drg-1; Thu, 20 Apr 2023 04:04:19 -0400
X-MC-Unique: w1w4aiLkMty1G5yW-p-Drg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-24726c47c65so371529a91.2
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 01:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977859; x=1684569859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwERD+G7giKxQA3SDjjqSpdpwrLSJtI3yoWVYKc6qSc=;
        b=MROTmUzq2Adb6zYSolM77n39JhhaOUxCiKTbvDlZnNJq6zpaNV5toRmEXb9ZiJP5F4
         2hLPHQC0WF8HFquAiS54OpFXpnhzFBNBbOyKGaEFlwEv4iG5Zc0DK0a9RQ1a+0rr6z45
         /eDtpAUcvJfLiLEbKrrJN6FeYIpyKJdL/jXrmdTQCT+glVxl4vC5WmkU0Pz7hujcHG3/
         pi4fOuj48kBbE8mati2x/pymfhVs7BLfzv4GyGIz6MBOYQTrN0V31FEEsqHuJmcT23UF
         dAyghvrjw563B3gvCPom26OKfutLW9gfQcprhESjE8dgye5UvkU34/Pl5lJk9EchP7IN
         Te3A==
X-Gm-Message-State: AAQBX9e7nGIr9YJjtE2LKm1TFvp0uRP1luZVF7BIfkmXglNLbcJhkjSF
        g6Dz9nF1wBxMW5Txdbw7LwlSNCoMo3arIE5HUXOPGaT4w3Y8rdOPb7wNajC2XedNaieL6sO3gH0
        SCkZBz77qIZDlCVgxcuy9D8wwWFtgOZgpgdGX068=
X-Received: by 2002:a17:90a:d90d:b0:247:a53e:97a1 with SMTP id c13-20020a17090ad90d00b00247a53e97a1mr804029pjv.28.1681977858816;
        Thu, 20 Apr 2023 01:04:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y7bAFH3cnp45zLZ+ioG4qcHPcx6J0dzymK8Hevphdw6q2Jg7dsXQdRWpCGF6JzMAHmhXO0nhg4/UE6KANTPt8=
X-Received: by 2002:a17:90a:d90d:b0:247:a53e:97a1 with SMTP id
 c13-20020a17090ad90d00b00247a53e97a1mr804014pjv.28.1681977858536; Thu, 20 Apr
 2023 01:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9-PhuUM0ztSnCuryKkOa+tX-RGP+M=zX-UoCE5f9E6FA@mail.gmail.com>
 <a0a0d448-76f1-3e02-145c-cfdcff07cebf@nvidia.com>
In-Reply-To: <a0a0d448-76f1-3e02-145c-cfdcff07cebf@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 20 Apr 2023 16:04:07 +0800
Message-ID: <CAHj4cs_iamYa5XbyoBeDCNMHBfLqqnRd0o3_+F__gRbPs+bEDA@mail.gmail.com>
Subject: Re: [bug report] general protection fault at kyber_bio_merge+0x123/0x300
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Xiao Ni <xni@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya

Sorry for the late response, as it take me some time to bisect this
issue, seems it was introduced with the below commit:

23f3e3272e7a4d9fb870485cd6df1e4f9539282c
Author: Xiao Ni <xni@redhat.com>
Date:   Thu Feb 9 11:19:30 2023 +0800

    block: Merge bio before checking ->cached_rq

Here are the steps I used to reproduce it:
1. do fio stress test on three nvme disks background
2.  offline the first three cpus
# echo 0 > /sys/devices/system/cpu/cpu1/online
# echo 0 > /sys/devices/system/cpu/cpu2/online
# echo 0 > /sys/devices/system/cpu/cpu3/online
3.  update each disk's scheduler/nr_requests
for disk in nvme0n1 nvme1n1 nvme2n1; do
    {
    scheds=3D"mq-deadline kyber bfq"
    for sched in $scheds; do
        echo $sched > /sys/block/$disk/queue/scheduler
        max_nr=3D"$(cat /sys/block/$disk/queue/nr_requests)"
        for ((nr =3D 4; nr <=3D max_nr; nr++)); do
            echo $nr > /sys/block/$disk/queue/nr_requests
        done
    done
    } &
done
4. online the cpus
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online


On Sun, Apr 16, 2023 at 12:52=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 4/14/23 08:04, Yi Zhang wrote:
> > Hello
> >
> > Bellow panic triggered during nvme disks queue/nr_request update with
> > fio background, pls help check it and let me know if you need any
> > info/test, thanks.
> >
> >
>
>
> Is it by any specific blktests ?
>
> can you please share the steps ?
>
> -ck
>
>


--
Best Regards,
  Yi Zhang

