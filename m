Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E981C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 21:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250B660E0C
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 21:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJXVZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 17:25:13 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34404 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhJXVZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 17:25:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id d5so8866552pfu.1
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 14:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z6IJc5iG3UhO8vpGbbBX8X/x190JoIwsooZzfjQ2gsc=;
        b=0KeRioVpYLFMFmU2F1lxSST4Sttflfn1d6KwqoYMDJ4fMXpInEYDHPFe4eTcJJbQym
         /4tRyHhLRHW6BwluPIr1x6/i6Gg1W3uGiOATv1UlDKaWU87zvTyK0dYWEZsO4/eRrADz
         etKdFBN88rLN1SLLb+gxkLFOcG4gud5Uml9DlGHqetDUUMvZGXgt3ZvqPG4WOp/yRKJY
         4/4tSxHGs+SZv/wWtdQ4/FOs4/6e8gUSl5PEeZUMIjx8dL03NtGqyZJbrAm+kT7ElR8d
         J2Y7vhgQHoEZ4lixCrbISuxdXeAL36Pvwok5yRWdc8QMA3DueZyBWTINDfBJDhqz7lq3
         MLJA==
X-Gm-Message-State: AOAM5313RCQrYzexBQvfIwGkPe0R2+dXgi3Cvo9gMln2KFOZoc+gm2lu
        eCyUS7SS+RIPj7CsTgCVBIjf2CGQLEI=
X-Google-Smtp-Source: ABdhPJxwFFJyBHyT8Psew4HUgwvcgN8IAj/xsK/JRFZJyLQBwj6cSeFx4xzG3x9FVFHHVAP0k0xVyA==
X-Received: by 2002:a05:6a00:a94:b0:44c:ecb2:6018 with SMTP id b20-20020a056a000a9400b0044cecb26018mr14141551pfl.57.1635110571228;
        Sun, 24 Oct 2021 14:22:51 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:1d23:4f1f:253d:c1e1? ([2601:647:4000:d7:1d23:4f1f:253d:c1e1])
        by smtp.gmail.com with ESMTPSA id v9sm16896185pfc.23.2021.10.24.14.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 14:22:50 -0700 (PDT)
Message-ID: <e1740f8a-07d4-0c7f-4099-2d6a37dfb899@acm.org>
Date:   Sun, 24 Oct 2021 14:22:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH blktests V3] tests/srp: fix module loading issue during
 srp tests
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org
References: <20211024124258.26887-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211024124258.26887-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/21 05:42, Yi Zhang wrote:
> The ib_isert/ib_srpt modules will be automatically loaded after the first
>   time rdma_rxe/siw setup, which will lead srp tests fail.
> 
> $ modprobe rdma_rxe
> $ echo eno1 >/sys/module/rdma_rxe/parameters/add
> $ lsmod | grep -E "ib_srpt|iscsi_target_mod|ib_isert"
> ib_srpt               167936  0
> ib_isert              139264  0
> iscsi_target_mod      843776  1 ib_isert
> target_core_mod      1069056  3 iscsi_target_mod,ib_srpt,ib_isert
> rdma_cm               315392  5 rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> ib_cm                 344064  2 rdma_cm,ib_srpt
> ib_core              1101824  10 rdma_cm,rdma_rxe,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_isert,rdma_ucm,ib_uverbs,ib_cm
> 
> $ ./check srp/001
> srp/001 (Create and remove LUNs)                             [failed]
>      runtime    ...  3.675s
>      --- tests/srp/001.out	2021-10-13 01:18:50.846740093 -0400
>      +++ /root/blktests/results/nodev/srp/001.out.bad	2021-10-14 03:24:18.593852208 -0400
>      @@ -1,3 +1 @@
>      -Configured SRP target driver
>      -count_luns(): 3 <> 3
>      -Passed
>      +insmod: ERROR: could not insert module /lib/modules/5.15.0-rc5.fix+/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko: File exists
> modprobe: FATAL: Module iscsi_target_mod is in use.
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>   tests/srp/rc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 7239d87..b3dfd4d 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -497,7 +497,7 @@ start_lio_srpt() {
>   	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
>   		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
>   	fi
> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
> +	unload_module ib_srpt && modprobe ib_srpt "${opts[@]}" || return $?
>   	i=0

The "&&" above seems wrong to me. It is not guaranteed that the ib_srpt
kernel mode has already been loaded before this code runs. I propose to
use the following code instead:

	unload_module ib_srpt
	modprobe ib_srpt "${opts[@]}" || return $?

Thanks,

Bart.
