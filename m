Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FDC00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 21:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiHBVTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHBVTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 17:19:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9615CE3F
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 14:19:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i13so19170594edj.11
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=UJGYo5mU62eu/kV8jQ+RivWZOZtTlwmUPfgHy6ZWe7I=;
        b=P/1Ipm6OoJjTD/lhf7CgN79Qo4bK9/sKIrbiXvO+eXap5iMY871LUd++gnVLR2BetP
         qy9Ou5ZSQ0pWUSuO/TsMGrk/tM69I5BpfVEEO7vst033qev5+G03l6T0+qAvDg7wTWrI
         jY3ebMuY+G91ZxYxW3Ny5WehsBzhfoDuR2gFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=UJGYo5mU62eu/kV8jQ+RivWZOZtTlwmUPfgHy6ZWe7I=;
        b=2rtN47tav6DIyFPuUPJMA8v3Xk1ky2uvI5W1pgQNtM27Lxaf4ciXGQY9nZPw5p3B7A
         WqCOKPcShzB7oe6o5f1Ayj+15Y5hnmWlQAQutDl/EAU8Gg3njNgn36j3FVIdPQN10+2r
         W6Q/SVID3DUNbqVUXF3EovZGx4LjQ/uMav+KlN2toyzP0NuI//qdjZqV3wbi2q6Xi7MI
         GwJkqvIg/opoDk0dTR7ixEq3+VhJTarIpJhoUzIxjlI1LsKD45rHRyFoCCj2U/ILkAWn
         qOQrN+1QEem3D1nGIJrWaNKKgMxg/wOwRoGGdTtAYpHy3llmECc1OX03fRKx/fT1/C1E
         RIUA==
X-Gm-Message-State: ACgBeo3juqQTy+nPRuvX0VrJnWvUuQWEv/TMohnUgvqRWxsc5GFRE5jM
        2yruWkhZVwF9uX7bXr+nz7HYAN7XoehLTK2i
X-Google-Smtp-Source: AA6agR4d9Aj6bfb/Zn3/1XTdunMC3fExsTVPTCsG8+yaaBo5H9WveGGN3fYQ+Hwhcupit4eA+FvtKQ==
X-Received: by 2002:a05:6402:4385:b0:43d:4820:4532 with SMTP id o5-20020a056402438500b0043d48204532mr17673787edc.233.1659475155054;
        Tue, 02 Aug 2022 14:19:15 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906a08800b006fe0abb00f0sm6585692ejy.209.2022.08.02.14.19.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 14:19:14 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id z16so19262651wrh.12
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 14:19:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr14479503wry.97.1659475153876; Tue, 02
 Aug 2022 14:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
In-Reply-To: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 14:18:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
Message-ID: <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 31, 2022 at 8:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On top of the core block changes, here are the block driver changes for
> 5.20-rc1. In detail:

No.

I pulled, and I ended up immediately unpulling again.

Why?

This is pure garbage that doesn't even compile:

> - NVMe pull request via Christoph
>         - add support for In-Band authentication (Hannes Reinecke)

because it is  testing the address of an array member (NOT a pointer!)
being NULL.

Lookie here:

  static struct nvme_auth_dhgroup_map {
          const char name[16];
          const char kpp[16];
  } dhgroup_map[] =3D {
        ...

  const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
  {
        if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
            !dhgroup_map[dhgroup_id].name ||
            !strlen(dhgroup_map[dhgroup_id].name))
                return NULL;
        return dhgroup_map[dhgroup_id].name;
  }


That test of "name" being NULL is complete garbage, because "name[]"
is not a pointer, it's a member of the struct, so the address is
simply *within* the struct, and testing for NULL is nonsensical.

As a result, gcc quite reasonably complains

    drivers/nvme/common/auth.c: In function =E2=80=98nvme_auth_dhgroup_name=
=E2=80=99:
    drivers/nvme/common/auth.c:59:13: error: the comparison will
always evaluate as =E2=80=98true=E2=80=99 for the address of =E2=80=98name=
=E2=80=99 will never be NULL
[-Werror=3Daddress]
       59 |             !dhgroup_map[dhgroup_id].name ||
          |             ^

and the exact same completely broken pattern ends up existing about
five more times in that same source file with other structures and
other structure members (ie there another case of exactly the same
thing, except with 'kpp[]', and then there are other cases of the same
thing except with the 'hash_map[]' structure etc.

This code cannot have gotten much testing at all.

Sure, it's possible that the warnings are compiler version dependent,
but I have two completely different compilers that both complain about
this thing.

Clang just has a slightly different error string, and says

    drivers/nvme/common/auth.c:59:31: error: address of array
'dhgroup_map[dhgroup_id].name' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]
                !dhgroup_map[dhgroup_id].name ||
                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~

instead.

And no, I don't want some "fix up broken code after the fact" commit
on top. I want that code excised, and I don't want to see another pull
request before it's (a) gone and (b) somebody has looked at where the
testing of this COMPLETELY failed.

                   Linus
