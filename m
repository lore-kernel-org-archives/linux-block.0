Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17FC3F2CD
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 10:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E1420705
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 10:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXT5WtUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbgCDKdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:33:18 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38283 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgCDKdS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 05:33:18 -0500
Received: by mail-vs1-f68.google.com with SMTP id r18so798410vso.5
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oavuclMu1bzFOooB6OMmYHMNvudw3zSMha1bvQGFwlM=;
        b=mXT5WtUhyrlswngAqH6ya+Juu2LGtRuHOusP2nOG7HjjTZyzZfKHy5sBYZ+UyMuoGx
         1C9UM1j6DPFWmzU6eIMdSEHuH+Daaw7KNhAnz1qsp7m07VGBy6UCuzNAvI17a0JARLr5
         GgzJmucnCXZq06g5AKqMDKpJr9i7hC4NjXD4q4WNcTwQH74hs8uvjFZLDNsUPbfJMmxt
         s1GseK3iVpTYMg6sEJYBbxI59Y0pC5dkMYM3Chc2dpMkt5ItQ3DUbPebklsY6xgSgAgc
         sySj8ET3u8vjIpi8mF6gZAdbgHWwW4LPMW9oKEA8ygbzFx0BFAi+j7+ztl2Wdr8NNtWQ
         7qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oavuclMu1bzFOooB6OMmYHMNvudw3zSMha1bvQGFwlM=;
        b=XUAvNc9Z1HQ0/pFdP3HrJ+8oc8IyvSo0XU7PsWfMSo6Eq4Jq4vbRJ8VDnXoMBVEhIp
         QymCCaBtHnoBvRdKqOR02UX4EimOJLcGZWOYTlNkpDDwk6tdnKkesa5hYAN/NmnVjMrI
         4yq8MBwm0JcIk7VE7bpfeE7EG6r2WMzBp5oQ4coJzq7vYqAbpt6kluVpQqnokq/6Lm4l
         7+lS62In6hWE3fUhQDUcZNRUTF2QkOskNANXYNuYtQYCkyV/075diNBHdrSSsELc2Hhy
         ZXE4/9USzgJBHyG2hjGJW+RuCdipWKnrw/GwMZZQnuwpaTQ0zC0CWe2hNfnlGwn0b1xt
         HMvA==
X-Gm-Message-State: ANhLgQ0YjVUdyOAqMFwrfE8FYPdKXJi430qBO4SzdvUicwITo1bxKonD
        6mo3MlqfwGidNGa7NGKLPH0/tgSdnfLxdvwNoGZF+A==
X-Google-Smtp-Source: ADFU+vt8lszpIIskiGB9+FhpTPR1wmM1HuQk0VGywmC3a/Ll2JBX9fYN7Go6GOFSjkphJhvCqF2NGIj6hT+js/1446k=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr1253954vsa.35.1583317997633;
 Wed, 04 Mar 2020 02:33:17 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com> <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com> <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com> <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
In-Reply-To: <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 11:32:41 +0100
Message-ID: <CAPDyKFpPOA7VD0Qw3dnnSdF4i5pNK6buCNCV2izW6xr5Mr9ybA@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[...]

 >
> > Actually we always use R1B with CMD6 as per spec.
>
> I fully agree that R1B is preferable, but it's not against the spec to
> send CMD13 to poll for busy.
>
> Moreover, we need to cope with the scenario when the host has
> specified a maximum timeout that isn't sufficiently long enough for
> the requested operation. Do you have another proposal for how to
> manage this, but disabling MMC_RSP_BUSY?
>
> Let's assume you driver would get a R1B for the CMD6 (we force it),
> then what timeout would the driver be using if we would set
> cmd.busy_timeout to 30ms?

/s/30ms/30s

Kind regards
Uffe
