Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169DC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE51A20830
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 07:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="IDaNDVk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfDCHUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:20:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38392 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCHUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 03:20:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id s2so8302360vsi.5
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hM07C2u6Y9yDMn6jglerSnoVl4T7upPpq2Q9E2Fo8hE=;
        b=IDaNDVk8hY3SzZfCF/NaELTFZ1LJsyHXHaYCZUGmdYttjS3u8svzF1JQ+oTi3jy2mA
         +Jc9oX2TnYuaWt1eNU010WPfP7ILAmd7nrWr7XJxzN4K2nz0rtnCpCnNkHYPscreNG/O
         ZGuLXyt/BfHfdpvSsOk5DnS9QSQSnbzrP9izKdTlUT3tpuN5GV+h0MYmfezi81lPfuke
         OszJ+dotScPF5nkX8cfQjZhdzlieReFdmJTu0eLVFqx309xI/IZRHg3NNKKaGjRqKxAR
         OPwXFNAnxnT7j9oq/DHGDzN/9qk4GaVqCfF/ucz2V8wTx7ZyFsqa5Tp8++IzSL+hNChg
         hWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hM07C2u6Y9yDMn6jglerSnoVl4T7upPpq2Q9E2Fo8hE=;
        b=EZEjqyM1eBu946J975HdtBd+nNiqEHxZ2cpXRyomHKYO05KGGEP89miKEhIAMM5YZy
         slVBUBXUrEuGFcp/cqxorxijG4WR/5IjIxR8VJ2e8rduXKQ5dnuRZ2uhX6hG7wPkSPw1
         zKxoH3bM83mbrBARq25IX0F6pRa/d+mVveMQddpuWwZEt0Ax5vS7AzrDHwc3N5TClv3P
         8CrDVJeULneILUVmX3gliZ2BFPeZk9jPaZFTxetrbLjbVsjPMrX/Hbqv9g/bt9K8cuBH
         c380talUp2tJ3oMMCAJ4jNbME1+YtzLTXpr96cAuV9S0qbvw9rrAb59TyoHnxqP4IsD+
         5IDQ==
X-Gm-Message-State: APjAAAUhfdKwTzgwX3bxgC/scnWzUDwn44Ojh3o7AOt/Q/3NHCfC0JmS
        0xIp3UmYaYsRl58xLtyd+NSEdv+q7nNmEf+D0p/Rzg==
X-Google-Smtp-Source: APXvYqxHVCpNPOJ1YYivWgS5BDjN32NFCs7bHZE/3Rmq8wDYZVRHnPcH7A6JgsPhqLw9tyquUhc0ae4ZFZ4rqVOiQws=
X-Received: by 2002:a67:f105:: with SMTP id n5mr44672441vsk.181.1554275581737;
 Wed, 03 Apr 2019 00:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
In-Reply-To: <20190327123901.12323-1-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 3 Apr 2019 09:12:51 +0200
Message-ID: <CANr-nt0d7DJ_-gYPKiJXBAUopSTATXVM7X5_=BeqDH-dZq-A8Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] lightnvm: next set of improvements for 5.2
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 1:41 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> This is another set of fixes and improvements to both pblk and lightnvm
> core.
>
> First & second patches are the most crutial, since they changes the approach
> to the partial read path, so detailed review is needed especially here.
>
> Other patches are my other findings related to some bugs or potential
> improvements, mostly related to some corner cases.
>
> Changes v2 -> v3;
> -dropped some not needed patches
> -dropped patches which were already pulled into for-5.2/core branch
> -commit messages cleanup
>
> Changes v1 -> v2:
> -dropped some not needed patches
> -review feedback incorporated for some of the patches
> -partial read path changes patch splitted into two patches
>

Hi Igor,

I ran the quick xfstests and generic/247 hangs with this patchset on qemu:

FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 u1804-qatd 5.0.0-rc6_for-5.2/core_igor_v3

generic/247 95s ...
<hang>

Note: If i run it with Matias 5.2 core branch with my biovec fix, it
completes successfully, but with this in dmesg:

[  358.028158] Page cache invalidation failure on direct I/O.
Possible data corruption due to collision with buffered I/O!
[  358.030768] File: /mnt/247 PID: 4431 Comm: dd

(I have not looked into that any further)

Best regards,
Hans


> Igor Konopko (10):
>   lightnvm: pblk: IO path reorganization
>   lightnvm: pblk: simplify partial read path
>   lightnvm: pblk: propagate errors when reading meta
>   lightnvm: pblk: recover only written metadata
>   lightnvm: pblk: wait for inflight IOs in recovery
>   lightnvm: pblk: remove internal IO timeout
>   lightnvm: pblk: store multiple copies of smeta
>   lightnvm: pblk: GC error handling
>   lightnvm: pblk: use nvm_rq_to_ppa_list()
>   lightnvm: track inflight target creations
>
>  drivers/lightnvm/core.c          |  19 ++-
>  drivers/lightnvm/pblk-cache.c    |   8 +-
>  drivers/lightnvm/pblk-core.c     | 179 +++++++++++++++++----
>  drivers/lightnvm/pblk-gc.c       |   5 +-
>  drivers/lightnvm/pblk-init.c     |  37 +++--
>  drivers/lightnvm/pblk-read.c     | 336 +++++++++++----------------------------
>  drivers/lightnvm/pblk-recovery.c |  69 ++++----
>  drivers/lightnvm/pblk-rl.c       |   3 +-
>  drivers/lightnvm/pblk.h          |  31 ++--
>  include/linux/lightnvm.h         |   2 +
>  10 files changed, 343 insertions(+), 346 deletions(-)
>
> --
> 2.9.5
>
