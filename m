Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD862E92719
	for <linux-block@archiver.kernel.org>; Thu,  5 Oct 2023 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJERVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjJERVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2023 13:21:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF442724
        for <linux-block@vger.kernel.org>; Thu,  5 Oct 2023 10:15:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4181bd07f25so7631191cf.1
        for <linux-block@vger.kernel.org>; Thu, 05 Oct 2023 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696526121; x=1697130921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kZZ+LzTQhw7SnaWxRb1LSoI3AuNMSpArazM0mZwyHk=;
        b=jFAzAjhe//Btj9YfCdZ4387UR49Vd+7ggJwFZ13BjOPQeN9j1s9FpTpO7aM6nNp5id
         Aml1Yeu6QV4t0/jbppFGa7n+Tk4BjXgFOBrN/i7+u9WF+c5E+6aVZl4CB+vULu3W3e0d
         Xkrj8WwscBRlLoSsRLAaMU+fMV+qsyidhpe64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526121; x=1697130921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kZZ+LzTQhw7SnaWxRb1LSoI3AuNMSpArazM0mZwyHk=;
        b=UbG1zaugRwkese4ilSBzf6KPcsvalDJVy5iQ9N3I+k4elkjDYIZtOyYP1/4JwbZBcK
         cGSc10eryVUtnIXSPqMkyU96z0pddN+jHCPf0U565jZkcvymmdcOIaJzZERWBhCaCaRc
         8Fcuqc2PSuvaVQFfDRL8R6XdaP3HGeBp76YcGHDEeCNXtaKoSDb+RoJulEyovg0ALfIx
         ITz5cCGIndAwagsPC3wyyIO/YnxxsXC1rFVdqbCkTEG91N+UkytIPPjBmUpxjoX1IO+2
         EGk2UZMO8ONWfR/zps/1RdsqgUbG9/whur3Q3myu4Hpx9uCv1NaYxNeXSc97dgHAWm9l
         VC1Q==
X-Gm-Message-State: AOJu0YzGPp+/4Zm6/rn4cwK72WqUOqvrg1SjsnRdcMuE4r8tJv13wLjj
        kdrjj9RQUxx7rFHC7YoGvEO8XUKI4JAwcM9fpbs=
X-Google-Smtp-Source: AGHT+IElQ5jUIptXmiLMH+2g3NReNhTI/GgAEhyvtVjNhhnk4AgWmzzfhTtIH8yJ+v7lDKdFXH2h0Q==
X-Received: by 2002:a05:622a:1001:b0:417:922b:f05f with SMTP id d1-20020a05622a100100b00417922bf05fmr5901515qte.57.1696526121455;
        Thu, 05 Oct 2023 10:15:21 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id ku15-20020a05622a0a8f00b00419732075b4sm613949qtb.84.2023.10.05.10.15.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:15:21 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-419768e69dfso22371cf.0
        for <linux-block@vger.kernel.org>; Thu, 05 Oct 2023 10:15:20 -0700 (PDT)
X-Received: by 2002:ac8:5786:0:b0:419:79c0:ef9a with SMTP id
 v6-20020ac85786000000b0041979c0ef9amr180288qta.6.1696526120141; Thu, 05 Oct
 2023 10:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005170413.GB32420@redhat.com>
In-Reply-To: <20231005170413.GB32420@redhat.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Thu, 5 Oct 2023 10:15:06 -0700
X-Gmail-Original-Message-ID: <CACGdZYJm312U70ysC_vpv=Pat063R=mRRVQGBiLocKc+QCkjnQ@mail.gmail.com>
Message-ID: <CACGdZYJm312U70ysC_vpv=Pat063R=mRRVQGBiLocKc+QCkjnQ@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 5, 2023 at 10:05=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> sorry, didn't notice this part before.
>
> I am not a asm expert (to say at least;) but
>
> On 10/05, Li Nan wrote:
> >
> > When (a * mul) overflows, a divide 0 error occurs in
> > mul_u64_u64_div_u64().
>
> Just in case... No, iirc it is divq which triggers #DE when the
> result of division doesn't fit u64.
Yeah, sorry for my incorrect wording here - but we're probably seeing
exactly that the final result doesn't fit in u64. (I wasn't familiar
with the intermediary registers here, thanks for explaining)
>
> (a * mul) can't overflow, the result is 128-bit rax:rdx number.
>
> Oleg.
>
