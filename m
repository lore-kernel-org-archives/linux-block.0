Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1511C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 06:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiGDGsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 02:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiGDGsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 02:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E6506446
        for <linux-block@vger.kernel.org>; Sun,  3 Jul 2022 23:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656917289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1W2oKiAfgOrM/hQSaCrdSWxyEMSTYnMXq6wengs+l2s=;
        b=fRfPXcNUwbcCMx1x754bnvmiXRaZXxNPxUrbw1rDt+TFPL7/nsAMTMePAskzDbLILrj8GI
        sXwQ4DkPElVnIqeKW9jJ4gwAxF2XeLOZ1uKGk5hjjwnjSx6W0q1uxOyQmWcBLocxh1+PlX
        EyDAKZuILd0uX4Ce2ZHkv+L+3X3AeQA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-AB7XRW_VOOysqT9iSoJMJw-1; Mon, 04 Jul 2022 02:48:08 -0400
X-MC-Unique: AB7XRW_VOOysqT9iSoJMJw-1
Received: by mail-pl1-f199.google.com with SMTP id y9-20020a17090322c900b0016bd9731021so1949230plg.19
        for <linux-block@vger.kernel.org>; Sun, 03 Jul 2022 23:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1W2oKiAfgOrM/hQSaCrdSWxyEMSTYnMXq6wengs+l2s=;
        b=06eInfXdeyjwI2BBhKcEVxwU2bYj8nY0preLWNLqs5eu+NXBg4t/hGv6qF/3rMpAYR
         x55epcgyaFJBSa0uk8Y2w87GhZa9aCDgvE4mSXQ5W8zbLGbZrUICZQlrJodFt8ezijG8
         dShiUd4F+PbPqrvZxjFxMOkapRPkwDwtbSoUMB+/diWf4DyZQAHI8TxG5rIZnuGJrrvx
         VzzSgYAXF9w1+Bf7F+ZlHX6tab9+tbSrmatIYTFaVom2h5kIK2W9YfJWh4xsyoaHasUe
         sgvFTTIpURIzFq1YlaclQmbVOLN8Mzm7UsOJxKvOmTQQsdHeIXbY+5EnLKw7bXCkB/wH
         YWeQ==
X-Gm-Message-State: AJIora+azGEWcL0nW+RI+/aPRyLq56lXsHCScF7st7ZUvqYQPGp11/bt
        qaVUyrJd0psFalxFmyv3IWH7hwCXWv/eSVwrXfeoexSqLpqtKQAHAD1VUCVfQMHIZd2VTx7vUEM
        D8Jwp1m6TjYVhKaZ97tisE85XxpGprosexvBKMEc=
X-Received: by 2002:a17:902:7fc2:b0:16b:dc53:5060 with SMTP id t2-20020a1709027fc200b0016bdc535060mr6963141plb.95.1656917286865;
        Sun, 03 Jul 2022 23:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t81Zib3H7FkA8CGqSzj3o2rS6eYEvi1+XTnBiZtt6boqMn8F3nZgSejTS4spj3hEyAF9cWW9QFoEUBdEeeJe8=
X-Received: by 2002:a17:902:7fc2:b0:16b:dc53:5060 with SMTP id
 t2-20020a1709027fc200b0016bdc535060mr6963125plb.95.1656917286607; Sun, 03 Jul
 2022 23:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220703180956.2922025-1-yi.zhang@redhat.com> <20220704052008.jegtbiposiy5aipg@shindev>
In-Reply-To: <20220704052008.jegtbiposiy5aipg@shindev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 4 Jul 2022 14:47:55 +0800
Message-ID: <CAHj4cs-aOQitbv0cqmW7v-Qii8YJvHMCsqUEkfwEFheBQnDUQg@mail.gmail.com>
Subject: Re: [PATCH blktests] block/008: fix cpu online restore
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 4, 2022 at 1:20 PM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Jul 04, 2022 / 02:09, Yi Zhang wrote:
> > The offline cpus cannot be restored during _cleanup when only _offline_cpu
> > executed, fix it by reset RESTORE_CPUS_ONLINE=1 during test.
> >
> > Fixes: bd6b882 ("block/008: check CPU offline failure due to many IRQs")
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>
> Hello Yi, thank you for catching this. The commit bd6b882 put the _offline_cpu
> call into a sub-shell, then RESTORE_CPUS_ONLINE reset in the function no longer
> affects _cleanup function. When I made the commit, I overlooked that point.
>
> Your change should fix the issue but it makes the RESTORE_CPUS_ONLINE=1 in
> _offline_cpu meaningless. Instead, I suggest following patch. Could you confirm
> it fixes the issue in your environment?

Yeah, your change works well, feel free to add
Tested-by: Yi Zhang <yi.zhang@redhat.com>


>
> diff --git a/tests/block/008 b/tests/block/008
> index 75aae65..cd09352 100755
> --- a/tests/block/008
> +++ b/tests/block/008
> @@ -34,6 +34,7 @@ test_device() {
>         local offline_cpus=()
>         local offlining=1
>         local max_offline=${#HOTPLUGGABLE_CPUS[@]}
> +       local o=$TMPDIR/offline_cpu_out
>         if [[ ${#HOTPLUGGABLE_CPUS[@]} -eq ${#ALL_CPUS[@]} ]]; then
>                 (( max_offline-- ))
>         fi
> @@ -60,18 +61,18 @@ test_device() {
>
>                 if (( offlining )); then
>                         idx=$((RANDOM % ${#online_cpus[@]}))
> -                       if err=$(_offline_cpu "${online_cpus[$idx]}" 2>&1); then
> +                       if _offline_cpu "${online_cpus[$idx]}" > "$o" 2>&1; then
>                                 offline_cpus+=("${online_cpus[$idx]}")
>                                 unset "online_cpus[$idx]"
>                                 online_cpus=("${online_cpus[@]}")
> -                       elif [[ $err =~ "No space left on device" ]]; then
> +                       elif [[ $(<"$o") =~ "No space left on device" ]]; then
>                                 # ENOSPC means CPU offline failure due to IRQ
>                                 # vector shortage. Keep current number of
>                                 # offline CPUs as maximum CPUs to offline.
>                                 max_offline=${#offline_cpus[@]}
>                                 offlining=0
>                         else
> -                               echo "Failed to offline CPU: $err"
> +                               echo "Failed to offline CPU: $(<"$o")"
>                                 break
>                         fi
>                 fi
>
>
> --
> Shin'ichiro Kawasaki
>


--
Best Regards,
  Yi Zhang

