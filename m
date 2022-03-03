Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE0C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 05:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiCCFdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCFdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 00:33:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611EDF86
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 21:32:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so8296181ejc.1
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 21:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=k9DbjsP6WFNC+J4h8QcCzs1r9xuRRjUa93Fq1rh5ZEc=;
        b=Ip4+xxEH96Rb3KW8imBuBrwksfok+Q97maRk61mNQg4j458U4UmXvVawyCy+BEWRzg
         8QIItgRRo5vbUkTesi3yEHQsFVdOYA2+zTKdkegxqxCRwYuP7eDNx88mLOQPyeqniCmz
         ginPbDemJbV4lY3Zao2qNqvqunIYPMxw4aDQ3ykUypC4p3LugoTAdy8A8Qp1jrv3z4hD
         e5RwEXjU7D4ayGB3J0W88+mJmNbKbJSGqvs2Jo8h+XkcyqzsHqLKcVyPt43SVtQUGgjS
         S8FN+OfDBNC9FevXuQf4dy2dldRjNGpXjVFNL4/HBAg3f9qhyfLgP3MIg+pSvuBSdeQF
         VZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=k9DbjsP6WFNC+J4h8QcCzs1r9xuRRjUa93Fq1rh5ZEc=;
        b=Bz/Bb/1lq+KsydLKbL/7dfM2bp1kdZCobYnWXlgeyqYT3eUhr5ND8MqbUKXEypKvIF
         6MAQOR72e3SaZMw/TAnBxO4eDdjyZqTRWbM0CG5fF3/q7YsUCuBrAMIms5W5NffcCerT
         1JQzmWKKBHa3FAVdl0ZEnbwSZAA9gW+Bs/Mwtl6b/chhJ6R+8ofGTiTXA2AamtHUi1nY
         QJYzCtG2vt6hCXFvoUdvY7vRSHFKwGTMe9+V8YBBE8Fl5Wccm8Uv3JeDFyVQrn+uRKau
         38CvzdLL43M4n71q/KNXcj3FNNKZpDjJtsvnB/yYYtV9c+ulKcSmatdBuFtZQXkEkMjt
         LGeg==
X-Gm-Message-State: AOAM533rgknxDaJJNkkehOouIGSPMPSFi7lsbe0kCnm5a5Y+xyeA1RwN
        30j3KwiMU4z+bd0dCHrBK3Kgag==
X-Google-Smtp-Source: ABdhPJySZq2hp2zctLXxeWvK1heT0o3JqYxQAcom/La5E4F75RO/l0paSjlHETZhZuwU/UC8shWAZA==
X-Received: by 2002:a17:906:a147:b0:6a9:f492:3c4d with SMTP id bu7-20020a170906a14700b006a9f4923c4dmr25378881ejb.131.1646285548820;
        Wed, 02 Mar 2022 21:32:28 -0800 (PST)
Received: from smtpclient.apple (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7dac8000000b0041291913c15sm385062eds.1.2022.03.02.21.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 21:32:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Date:   Thu, 3 Mar 2022 06:32:27 +0100
Message-Id: <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: iPhone Mail (19D52)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 3 Mar 2022, at 04.24, Luis Chamberlain <mcgrof@kernel.org> wrote:
>=20
> =EF=BB=BFThinking proactively about LSFMM, regarding just Zone storage..
>=20
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of
> having folks in the room we can likely settle on things faster which
> otherwise would take years.
>=20
> I'll throw at least one topic out:
>=20
>  * Raw access for zone append for microbenchmarks:
>      - are we really happy with the status quo?
>    - if not what outlets do we have?
>=20
> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.
>=20
>  Luis

Thanks for proposing this, Luis.=20

I=E2=80=99d like to join this discussion too.=20

Thanks,
Javier=20=
