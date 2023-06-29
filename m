Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E86EB64D7
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 00:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF2AE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 20:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjF2AEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 20:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B2A3
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687997014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sx3guVJL2WC5UvGEgGpdXl6+e1aLtSxlxlCaP4w5/lQ=;
        b=UTAygKtfP8wZ1TY8mWb6t76YbyPiZw/9Q/GZ8JOYQIfSr+KN3Cqw3aCn8trXxW7iXWPhzi
        L4uM7nlGTzPoJu7P1J2i/DdVOvDf5b9etNyhNBBllgbFPrvPJh8knlebQaFkmuasTcnG0Q
        DDy9wovLFo+XidoDjoSjxWW69g+PKq4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-dt5XBGrEMKybrY_iK8E8TQ-1; Wed, 28 Jun 2023 20:03:33 -0400
X-MC-Unique: dt5XBGrEMKybrY_iK8E8TQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262e619fb5aso59612a91.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 17:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997011; x=1690589011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx3guVJL2WC5UvGEgGpdXl6+e1aLtSxlxlCaP4w5/lQ=;
        b=MTI0D+e/KC6dfg/V9P8eOoXeWikyjwRS7dgpOd+0jjqQWwNXEGqeA/71s+YrVkkQ8K
         ZZRQ/XuoHbc8j6+Q/jVnNDtJmSmRHcAMvV+SnmFEyc81vLO5pK8LPnx6/d4tKab4RxDB
         4BlIF15bYjOmgVwmHEHVyWzUGqktvV0ys1ZmqaFx3bu97Tifpmr+kB0VtMF1p0SyVt6c
         nt5J8R4cO93BeGKQIs/3M2y7k3TNXjMq7GNGWhazI6s64ufsXvit2HInNwE/o+ffISdw
         Uw4wz+GK9+ozuFhZIYEp0l4J9HSGykR2DhinD0g4ZLFBYQaJqbmxrJAePkyH7OAFxpg9
         ek/w==
X-Gm-Message-State: AC+VfDybY5QhIsiUmUqMMMaIVIYVpRKMIFoX/GSzkJ20B6/qPA8rxEIC
        wdykFWcn8P5Dd//hpMGAVWugPTHwAFywHE6nAiQdStue9uOT0PCnqr7GtrsIR32iS1SzmdIliqm
        b0UbRS4h6Ux5tRnpu+/MZh7KZDj6xB/3ihuFKp8U=
X-Received: by 2002:a17:90a:2b88:b0:262:ceaa:1720 with SMTP id u8-20020a17090a2b8800b00262ceaa1720mr8892195pjd.5.1687997010840;
        Wed, 28 Jun 2023 17:03:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ561AomPYlPtzUqJ+aW+u6gvxozHO1/RACDoc2XPwj9tOvCwIck3lp3Mdozzr0I7b0LOE/oHMyAzdP2yX4hThM=
X-Received: by 2002:a17:90a:2b88:b0:262:ceaa:1720 with SMTP id
 u8-20020a17090a2b8800b00262ceaa1720mr8892179pjd.5.1687997010523; Wed, 28 Jun
 2023 17:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 29 Jun 2023 08:03:18 +0800
Message-ID: <CAHj4cs_H+oEhGqDz_Nwa1SbShhep0eSm+qtf+aEJVHxe5SkuNg@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
To:     "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've verified the fix on my environment, thanks for the fix.
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Jun 28, 2023 at 8:44=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), 'nvme discover' and 'nvme connect' commands fail
> when pair of hostid and hostnqn is not provide. This caused failure of
> many test cases in the nvme group with kernel messages "nvme_fabrics:
> found same hostid XXX but different hostnqn YYY".
>
> To avoid the failure, specify valid hostnqn and hostid to the nvme
> commands always. Prepare def_hostnqn and def_hostid even when
> /etc/nvme/hostnqn or /etc/nvme/hostid is not available. Using these
> values, add --hostnqn and --hostid options to the nvme commands in
> _nvme_discover() and _nvme_connect_subsys().
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/CAHj4cs_qUWzetD0203EKbBLNv3KF=3D=
qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com/
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/nvme/rc | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2..1c2c2fa 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,23 @@ def_remote_wwnn=3D"0x10001100aa000001"
>  def_remote_wwpn=3D"0x20001100aa000001"
>  def_local_wwnn=3D"0x10001100aa000002"
>  def_local_wwpn=3D"0x20001100aa000002"
> -def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +
> +if [ -f "/etc/nvme/hostid" ]; then
> +       def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +else
> +       def_hostid=3D"$(uuidgen)"
> +fi
> +if [ -z "$def_hostid" ] ; then
> +       def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> +fi
> +
> +if [ -f "/etc/nvme/hostnqn" ]; then
> +       def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> +fi
> +if [ -z "$def_hostnqn" ] ; then
> +       def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> +fi
> +
>  nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"1G"}
>  nvme_num_iter=3D${nvme_num_iter:-"1000"}
> @@ -442,12 +457,8 @@ _nvme_connect_subsys() {
>         elif [[ "${trtype}" !=3D "loop" ]]; then
>                 ARGS+=3D(-a "${traddr}" -s "${trsvcid}")
>         fi
> -       if [[ "${hostnqn}" !=3D "$def_hostnqn" ]]; then
> -               ARGS+=3D(--hostnqn=3D"${hostnqn}")
> -       fi
> -       if [[ "${hostid}" !=3D "$def_hostid" ]]; then
> -               ARGS+=3D(--hostid=3D"${hostid}")
> -       fi
> +       ARGS+=3D(--hostnqn=3D"${hostnqn}")
> +       ARGS+=3D(--hostid=3D"${hostid}")
>         if [[ -n "${hostkey}" ]]; then
>                 ARGS+=3D(--dhchap-secret=3D"${hostkey}")
>         fi
> @@ -483,6 +494,8 @@ _nvme_discover() {
>         local trsvcid=3D"${3:-$def_trsvcid}"
>
>         ARGS=3D(-t "${trtype}")
> +       ARGS+=3D(--hostnqn=3D"${def_hostnqn}")
> +       ARGS+=3D(--hostid=3D"${def_hostid}")
>         if [[ "${trtype}" =3D "fc" ]]; then
>                 ARGS+=3D(-a "${traddr}" -w "${host_traddr}")
>         elif [[ "${trtype}" !=3D "loop" ]]; then
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang

