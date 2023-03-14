Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A2C74A44
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 19:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCNTH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCNTH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 15:07:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123EFE
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:07:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd5so32353955edb.7
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678820875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XXQN4LaizH2j4eXVSdO1xOJU1STk3wgvGGHOknlOD8=;
        b=a6WyRdFfi0DT7KYrcVh8KTBoERDVjfv/XJ6l0uILwYMBAPnA/UBOlqSBYK5E8mAA5E
         gyMsC6wKiXOOl13zzf6+ip5YEB6dQ1oXi+QLJ8Z5sLuxArOr0GPojIVKAlN0eNCjCQTJ
         oTKawdKO94eDLMqkex9c7ds01Gql5IOB48HKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678820875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XXQN4LaizH2j4eXVSdO1xOJU1STk3wgvGGHOknlOD8=;
        b=7yUsAt/wyjm82qKQMF4oWceW5Pc4UWu3ERuT8cOWdYc9NzKi6Gpp2swa+s0C+XeFFO
         DiH2fj7pxA8O9VCzLoAw/Wk+HOYc0bxA4mtthR0a0Krqw/3oJPwxjxuL36J2yjePEJy/
         hjIWmgtGzbVjpqgK6LQymUZtWz1aaUt90cDtsU+xIML75AeEt3pA1Y6ztE4m/14Xxxvh
         DER4H0tjOe8uQs1hE+Q72hBGnd1MrwXvOCjTS62tkP07KtwmTeYw7Jwd3KrpTJ+KsVBI
         L5O+2G2DeJQwyZqOz8a5HiYJKL5rWOvS7+QcF80RghkgKF/1kPW7Yx6khZccLZnJl7Ic
         +HQw==
X-Gm-Message-State: AO0yUKXYVbvoiacIt7YkuXgt0a3MQ1Zt4hIOtVxyPbP4eVx+Enzdarrd
        4+I94lt0U+rMM7guTIjnWuTdM81BJ4HA1Upfy5VSew==
X-Google-Smtp-Source: AK7set9QkKQ6cE4hpWidMatx6R3+QqBmS9MpI7VoELicTPaPnAsgBSOiwp7gb07f4Yts0Igd/qZBXQ==
X-Received: by 2002:a17:906:d8a5:b0:8b1:7aaa:4c25 with SMTP id qc5-20020a170906d8a500b008b17aaa4c25mr3349252ejb.29.1678820875561;
        Tue, 14 Mar 2023 12:07:55 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id hp2-20020a1709073e0200b008b175c46867sm1483936ejc.116.2023.03.14.12.07.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:07:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id cy23so66119889edb.12
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:07:54 -0700 (PDT)
X-Received: by 2002:a50:d506:0:b0:4fb:482b:f93d with SMTP id
 u6-20020a50d506000000b004fb482bf93dmr106272edi.2.1678820874229; Tue, 14 Mar
 2023 12:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
 <3761465.1678818404@warthog.procyon.org.uk>
In-Reply-To: <3761465.1678818404@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 12:07:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
Message-ID: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 14, 2023 at 11:26=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Are you okay if we go with my current patch for the moment?

I  guess.

But please at least stop doing the

     get_page(buf->page);

on the zero-page (which includes using no-op .get and .put functions
in  zero_pipe_buf_ops().

Maybe we can do /dev/null some day and actually have a common case for thos=
e.

             Linus
