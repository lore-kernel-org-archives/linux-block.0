Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65FCDB46E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 06:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjJLGB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 02:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJLGBZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 02:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DAAA9
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697090437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O52tl4F35Am9yQbT3fYNHue/eP3kHx51hVlfb7jJELo=;
        b=Rny4o1BYwqzfn4+igHB3oXv2swSrF9Kx+QOQnl2dpyCGyJfwcaNEVI3yDsYkivNgAFDOQq
        NZ8ls0exuAXq7VrB/vcGGzeszWWOJpJ3N0jFarhp90qTmj1GEATcT9PtHkvCbKcHyu+euw
        kH50pneKFQH/clwh3oWXMaPWCwB1n44=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-9JXYfhG4MH-aF9L9i9me0g-1; Thu, 12 Oct 2023 02:00:36 -0400
X-MC-Unique: 9JXYfhG4MH-aF9L9i9me0g-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3af85efc4a3so885593b6e.0
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 23:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090435; x=1697695235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O52tl4F35Am9yQbT3fYNHue/eP3kHx51hVlfb7jJELo=;
        b=F3ZwRWA+M884IHGx1/msyMqkX5YZBtif0qgbaqC2E9ox9V3ay9BR4v5++YjkplKzTV
         Q0RTzUkEtaMKgATF3gX3njXFWUDIcwGjQB0aGADoTHDoK/rPjDhRmOMH3eArXABrepn8
         5hKe7tO82Dm6Pbn78R65Wos0w5MAj+v21F72LlJSie2aZ4mVFTBmdoJVzt5hgfb/qODe
         nKlUEsXsFlytJsuBsGmcrr5y8UmRCxOeFuQ9BCX/bgc1pumkR/nqDklwCTDEINJgPZRt
         zqd92cBSW/YP104+g9LnDU2AR6ZejjZelrMkPqY9HdnJWRMd4NoDEsHvOM0Hhn+pJPnn
         B0yg==
X-Gm-Message-State: AOJu0YxZqhE5PFE+P82R4kIQ8Af5RlRhV0VHG2T0whl7Tnj8P6VALBV+
        +Y62b+bptMt5F2OSJLmu4N+PAL0doy874qaW8nmx0GjmbvMJ+GCSMNWbEvRMh3DKdBA/Xkx9xXU
        QMuMCM/vh6zey8YzaddnAZpPQXFTr0dv/JFVY8hE=
X-Received: by 2002:a05:6808:13d1:b0:3af:68f9:86de with SMTP id d17-20020a05680813d100b003af68f986demr31886356oiw.25.1697090435365;
        Wed, 11 Oct 2023 23:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhaMFlpQuDZ31aRhM5h8F2DPF1gTpgX1jGTblpKlM2xDsmqdlADpXi+6eMBocqZ3KbCJR0lJpg9eQNpp/Q+jA=
X-Received: by 2002:a05:6808:13d1:b0:3af:68f9:86de with SMTP id
 d17-20020a05680813d100b003af68f986demr31886345oiw.25.1697090435186; Wed, 11
 Oct 2023 23:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com> <20231012021152.832553-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231012021152.832553-2-shinichiro.kawasaki@wdc.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 12 Oct 2023 14:00:22 +0800
Message-ID: <CAHj4cs8PmhUR4aEFOj-sq0c9x9HPYjpDH-6OxZ4G2icNgSzx3Q@mail.gmail.com>
Subject: Re: [PATCH blktests 1/2] nvme/{rc,017,031}: replace def_file_path
 with _nvme_def_file_path()
To:     "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 12, 2023 at 10:12=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> The commit b6356f6 ("nvme/rc: Add common file_path name define") defined
> a global variable 'def_file_path' in nvme/rc, which refers TMPDIR.
> However, when nvme/rc is sourced and def_file_path is defined for the
> nvme test group, TMPDIR is not yet defined since TMPDIR is defined for
> each test case. Then an unexpected path is set to def_file_path and
> temporary files are created at the unexpected path.
>
> Fix this by replacing the global variable def_file_path with a helper
> function _nvme_def_file_path(). This helper function allows to refer
> TMPDIR not at nvme/rc source timing but in test() or test_device()
> context of each test case.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: b6356f6 ("nvme/rc: Add common file_path name define")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

LGTM, thanks for the fix.

Reviewed-by: Yi Zhang <yi.zhang@redhat.com>

