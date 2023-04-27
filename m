Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D46C77B73
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 15:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbjD0P6J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbjD0P6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 11:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396AA30D3
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682611038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssXffoZ5KWKgkUGOV3qKi7LYtVGbIjuWX6RUv9lZErc=;
        b=KlNhu9EUArRb65tFFp4cjuWza1zw5Y6To61vUoFqW24E3Lp2NIrw3kX1A1/riC1xhVviII
        +n5yA4op+OQ3i9O/Tz8txTRwLXLXyB/8iwTCJ+63zST5awz7vFlvEiuRNcyTWEeLc2GLdb
        EmxVnMfSmVBqyurSCEyg+p+MJ8xy/kE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-XVSjKOwdO0KnjOfZS4DmbQ-1; Thu, 27 Apr 2023 11:57:17 -0400
X-MC-Unique: XVSjKOwdO0KnjOfZS4DmbQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64115e69e1eso4707485b3a.0
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 08:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611035; x=1685203035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssXffoZ5KWKgkUGOV3qKi7LYtVGbIjuWX6RUv9lZErc=;
        b=G5LxQeSPfZshw//VWKLl3rDbKVMhbKE/KUpifkMpTCaVqWAhK4IYvAkZq4xOtCnZrQ
         Om25+O1aiU3o/hZrGIbH2iiv9YKwmpihw/GZgELLQ09Z4W5kRQTSO6F2qvFXRisJY0dY
         ygJUP7Z3RlaH1Agzpge7VlkOr+HUnJ9yCAj5OspeK+CiIcCbDfM7IYZ3a+cg5XLIOWO1
         U4U3ufwyMWEE7yLMv9GLN+91QJAWqsEl6rAi4kMG333cuv/6Heq1G3VvRyS9EDmuuNeZ
         Nx1uw+EEBPgtwY3g38bhkKzcOLl8kVC32CxTDcHAJPLv/+lPgkGwuvbVRoQ0oO24sv7P
         RS9g==
X-Gm-Message-State: AC+VfDyTJg7zVRpMW8zQZzQx4sSSNTH2WdexCSpLVjbZdX5U6pmiUDOf
        YDihOmXscqcMz39UocUN8gGceOYDPtWk+lDPa8gKAbfLu0VlclIZhN3P9v0B4bUhTE/VOaNCtCa
        N/iUMz4Xng4btyJLdTyRxrtHmWlgKiLYc2kM46fM=
X-Received: by 2002:a17:90a:f598:b0:247:714e:94e5 with SMTP id ct24-20020a17090af59800b00247714e94e5mr7694352pjb.23.1682611034849;
        Thu, 27 Apr 2023 08:57:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YKz9Sj3OyAqkMQ+iyHUMrCyxoXzXFm9BOgPpPT7kDZcLjY05CvM3kvXBlUsP1e2rJj+I6DNMSVdY0zIrP+Rk=
X-Received: by 2002:a17:90a:f598:b0:247:714e:94e5 with SMTP id
 ct24-20020a17090af59800b00247714e94e5mr7694331pjb.23.1682611034504; Thu, 27
 Apr 2023 08:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me> <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com> <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
 <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
 <CAHj4cs-MtUM=7w=YG2ohATeA1HSZp_5CT1Y9DATDEqPPMZ8MMw@mail.gmail.com> <e5717ee0-e2af-9266-4bfc-e792d53f4403@nvidia.com>
In-Reply-To: <e5717ee0-e2af-9266-4bfc-e792d53f4403@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 27 Apr 2023 23:57:02 +0800
Message-ID: <CAHj4cs8DPVKPs8o+tN7cdZrvZKVRAjG5-cEZspL1N0JG-a4Oag@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 27, 2023 at 6:58=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 4/27/23 00:39, Yi Zhang wrote:
> > oops, the kmemleak still exists:
>
> hmmm, problem is I'm not able to reproduce
> nvme_ctrl_dhchap_secret_store(), I could only get
> cdev ad dev_pm_ops_xxxx. Let's see if following fixes
> nvme_ctrl_dhchap_secret_store() case ? as I've added one
> missing kfree() from earlier fix ..

Hi Chaitanya

The kmemleak in nvme_ctrl_dhchap_secret_store was fixed with the
change, feel free to add:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> once you confirm I'd like to send
> nvme_ctrl_dhchap_secret_store() first , meanwhile keep
> looking into cdev and dm_ops :-
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1bfd52eae2ee..663f8c215d7b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3825,8 +3825,10 @@ static ssize_t
> nvme_ctrl_dhchap_secret_store(struct device *dev,
>                  int ret;
>
>                  ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> -               if (ret)
> +               if (ret) {
> +                       kfree(dhchap_secret);
>                          return ret;
> +               }
>                  kfree(opts->dhchap_secret);
>                  opts->dhchap_secret =3D dhchap_secret;
>                  host_key =3D ctrl->host_key;
> @@ -3834,7 +3836,8 @@ static ssize_t
> nvme_ctrl_dhchap_secret_store(struct device *dev,
>                  ctrl->host_key =3D key;
>                  mutex_unlock(&ctrl->dhchap_auth_mutex);
>                  nvme_auth_free_key(host_key);
> -       }
> +       } else
> +               kfree(dhchap_secret);
>          /* Start re-authentication */
>          dev_info(ctrl->device, "re-authenticating controller\n");
>          queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> @@ -3879,8 +3882,10 @@ static ssize_t
> nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>                  int ret;
>
>                  ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> -               if (ret)
> +               if (ret) {
> +                       kfree(dhchap_secret);
>                          return ret;
> +               }
>                  kfree(opts->dhchap_ctrl_secret);
>                  opts->dhchap_ctrl_secret =3D dhchap_secret;
>                  ctrl_key =3D ctrl->ctrl_key;
> @@ -3888,7 +3893,8 @@ static ssize_t
> nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>                  ctrl->ctrl_key =3D key;
>                  mutex_unlock(&ctrl->dhchap_auth_mutex);
>                  nvme_auth_free_key(ctrl_key);
> -       }
> +       } else
> +               kfree(dhchap_secret);
>          /* Start re-authentication */
>          dev_info(ctrl->device, "re-authenticating controller\n");
>          queue_work(nvme_wq, &ctrl->dhchap_auth_work);
>
>
> > # cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff8882a4cc6000 (size 4096):
> >    comm "kworker/u32:6", pid 116, jiffies 4294699939 (age 1614.355s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >      00 00 00 00 00 00 00 00 00 03 10 03 1f 00 00 00  ................
> >    backtrace:
> >      [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
> >      [<ffffffffc08cc68e>] nvme_identify_ns+0xae/0x230 [nvme_core]
> >      [<ffffffffc08cc8b9>] nvme_ns_info_from_identify+0x99/0x4a0 [nvme_c=
ore]
> >      [<ffffffffc08e0696>] nvme_scan_ns+0x1b6/0x460 [nvme_core]
> >      [<ffffffffc08e0ae2>] nvme_scan_ns_list+0x192/0x4f0 [nvme_core]
> >      [<ffffffffc08e1271>] nvme_scan_work+0x2f1/0xa30 [nvme_core]
> >      [<ffffffff85e98629>] process_one_work+0x8b9/0x1550
> >      [<ffffffff85e9987c>] worker_thread+0x5ac/0xed0
> >      [<ffffffff85eb2902>] kthread+0x2a2/0x340
> >      [<ffffffff85c062cc>] ret_from_fork+0x2c/0x50
> > unreferenced object 0xffff88829782bc00 (size 512):
> >    comm "nvme", pid 1539, jiffies 4294914967 (age 1399.449s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> >      ff ff ff ff ff ff ff ff a0 73 bf 8d ff ff ff ff  .........s......
> >    backtrace:
> >      [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
> >      [<ffffffff873658c5>] device_add+0x645/0x12f0
> >      [<ffffffff867c38e3>] cdev_device_add+0xf3/0x230
> >      [<ffffffffc08c77c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
> >      [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
> >      [<ffffffffc0d38177>] 0xffffffffc0d38177
> >      [<ffffffffc0d38613>] 0xffffffffc0d38613
> >      [<ffffffff867b5056>] vfs_write+0x216/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff88824216a880 (size 96):
> >    comm "nvme", pid 1539, jiffies 4294914968 (age 1399.448s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
> >      [<ffffffff87395fa0>] dev_pm_qos_update_user_latency_tolerance+0xe0=
/0x200
> >      [<ffffffffc08c783c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
> >      [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
> >      [<ffffffffc0d38177>] 0xffffffffc0d38177
> >      [<ffffffffc0d38613>] 0xffffffffc0d38613
> >      [<ffffffff867b5056>] vfs_write+0x216/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff8881b00f4900 (size 64):
> >    comm "check", pid 1587, jiffies 4294922730 (age 1391.686s)
> >    hex dump (first 32 bytes):
> >      44 48 48 43 2d 31 3a 30 30 3a 79 68 33 70 6f 45  DHHC-1:00:yh3poE
> >      61 47 37 31 68 45 69 2f 33 42 41 75 54 2f 61 6c  aG71hEi/3BAuT/al
> >    backtrace:
> >      [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
> >      [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nv=
me_core]
> >      [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
> >      [<ffffffff867b5642>] vfs_write+0x802/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff8882b4567700 (size 64):
> >    comm "check", pid 1587, jiffies 4294922738 (age 1391.678s)
> >    hex dump (first 32 bytes):
> >      44 48 48 43 2d 31 3a 30 30 3a 79 68 33 70 6f 45  DHHC-1:00:yh3poE
> >      61 47 37 31 68 45 69 2f 33 42 41 75 54 2f 61 6c  aG71hEi/3BAuT/al
> >    backtrace:
> >      [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
> >      [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nv=
me_core]
> >      [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
> >      [<ffffffff867b5642>] vfs_write+0x802/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff8882b6fbe000 (size 512):
> >    comm "nvme", pid 1934, jiffies 4294932235 (age 1382.239s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> >      ff ff ff ff ff ff ff ff a0 73 bf 8d ff ff ff ff  .........s......
> >    backtrace:
> >      [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
> >      [<ffffffff873658c5>] device_add+0x645/0x12f0
> >      [<ffffffff867c38e3>] cdev_device_add+0xf3/0x230
> >      [<ffffffffc08c77c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
> >      [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
> >      [<ffffffffc0d38177>] 0xffffffffc0d38177
> >      [<ffffffffc0d38613>] 0xffffffffc0d38613
> >      [<ffffffff867b5056>] vfs_write+0x216/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff888288a53b80 (size 96):
> >    comm "nvme", pid 1934, jiffies 4294932237 (age 1382.237s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
> >      [<ffffffff87395fa0>] dev_pm_qos_update_user_latency_tolerance+0xe0=
/0x200
> >      [<ffffffffc08c783c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
> >      [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
> >      [<ffffffffc0d38177>] 0xffffffffc0d38177
> >      [<ffffffffc0d38613>] 0xffffffffc0d38613
> >      [<ffffffff867b5056>] vfs_write+0x216/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff88829e6a3b80 (size 64):
> >    comm "check", pid 1981, jiffies 4294936167 (age 1378.307s)
> >    hex dump (first 32 bytes):
> >      44 48 48 43 2d 31 3a 30 30 3a 61 56 6f 56 44 4f  DHHC-1:00:aVoVDO
> >      79 69 31 6c 59 33 74 79 77 47 33 6a 4f 6e 37 33  yi1lY3tywG3jOn73
> >    backtrace:
> >      [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
> >      [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nv=
me_core]
> >      [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
> >      [<ffffffff867b5642>] vfs_write+0x802/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > unreferenced object 0xffff88829e6a3a80 (size 64):
> >    comm "check", pid 1981, jiffies 4294936885 (age 1377.589s)
> >    hex dump (first 32 bytes):
> >      44 48 48 43 2d 31 3a 30 30 3a 61 56 6f 56 44 4f  DHHC-1:00:aVoVDO
> >      79 69 31 6c 59 33 74 79 77 47 33 6a 4f 6e 37 33  yi1lY3tywG3jOn73
> >    backtrace:
> >      [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
> >      [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nv=
me_core]
> >      [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
> >      [<ffffffff867b5642>] vfs_write+0x802/0xc60
> >      [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
> >      [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
> >      [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> >
>
> [..]
>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang

