Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D69C41513
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjHPSvW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345656AbjHPSvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 14:51:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BB26A8
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 11:51:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c0290f0a8so852069366b.1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692211875; x=1692816675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaKaeU51JPSPyvo4LO/gtZBA5F2n47wdQ6cksSuHE10=;
        b=fActoLYapvYatp3BhqIIHFa7afpVUfbRmNLj+3diEzvHES+AYjublIkhtmIOX9kg+Y
         gF0sFYtTPoeu6+U9v7D6JyEtUHF/XcjF8Qu4L8o8ftiwiy8vdZuS3YJKoYljq6C7Zp8U
         XapjcDw7BAY+29BhsfAA7mfdmQuqWLm7Tv9u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692211875; x=1692816675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaKaeU51JPSPyvo4LO/gtZBA5F2n47wdQ6cksSuHE10=;
        b=Xn9rLn2YKcEc0gXl9xQ68ok1+II9UaSHscsZ7bpxaWUjPyHXuzpD+8yA2n0ZhIiYlQ
         WfxkgoZ+LdN2SkEEL6GmsLmsP/7NUULNiHxrItwnTaikqIRJ0/Mjy8OIWG+5amf28wk9
         p7LtpziCD3c4e2nUQKEIA4HJaQtStgdBFyJ0IAF22SD6d66gfGmejNkoS6x2dTdOQN5c
         AMnYvCBySyAMn/SZ0e38MFoY3pECD/10xq4TP3Le0wrLm9IJHrDaLa4CTL7m8U6+8AK6
         pgb2p9FauQlWhAw/0/WKC+gqixI9LP95YFutGXtrBUVxeottZCO+V6BrBp1rdbnyIr9B
         M8hQ==
X-Gm-Message-State: AOJu0YyD5T/tu5cGPysVoW5nukbJMuO8cr3qkaRD4tLpZ5yw9VWfMBsB
        1efopNRyU+hTMxHbzc89TljV20RGTUFLuj34kaSynk4q
X-Google-Smtp-Source: AGHT+IHJd6/HHr7/76iCjHTFNZxIQgCVpBJD7kEgNW3TcvPpOWCY+lCghjY6gCnfIS4THUUv/LqLxw==
X-Received: by 2002:a17:906:769a:b0:99d:f34c:7a0f with SMTP id o26-20020a170906769a00b0099df34c7a0fmr1782606ejm.23.1692211875661;
        Wed, 16 Aug 2023 11:51:15 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id qt27-20020a170906ecfb00b0099bd046170fsm8792605ejb.104.2023.08.16.11.51.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:51:14 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so9269883a12.1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 11:51:13 -0700 (PDT)
X-Received: by 2002:a05:6402:1854:b0:525:69ec:e1c8 with SMTP id
 v20-20020a056402185400b0052569ece1c8mr1797634edy.40.1692211873612; Wed, 16
 Aug 2023 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
In-Reply-To: <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Aug 2023 18:50:56 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
Message-ID: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Aug 2023 at 14:19, David Laight <David.Laight@aculab.com> wrote:
>
> What about ITER_BVEC_MC ??

That probably would be the best option. Just make it a proper
ITER_xyz, instead of an odd sub-case for one ITER (but set up in such
a way that it looks like it might happen for other ITER_xyz cases).

                Linus
