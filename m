Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B7C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEVRus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjEVRur (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 13:50:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33DFF
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 10:50:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso4803217e87.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684777843; x=1687369843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=bmpPa9zjlUzyjbeZlqxzu2zabV3bl9Mm+UYqg4JG6Ok1Tv+s0hgvqO6u15FubxI+su
         jWSD+MNvgdoYp80pJmKsynVPfeLe3AArwDF5HvAlS3TXL8Jsy5j6yf/wkFgyJsgNsSrB
         2CFm0tX49r98zxmjmEP/UgvkK1lnk1EOIYEcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777843; x=1687369843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=YRkfYQ81vGGr/TsPtDPiUXCG0+KPB/KKq95k1eTFhfKtjNZU5qyZHFWPnKpXXCnFSL
         sUPxKOsHcKWef9QXjBbyFakmtof504Kq7Wbue+FKzKEX68c8Kh1GeLCim79FoU6QRbGf
         qW67KkO5yl6RVBYogN2jKANkgl/k/mdH2yV2U4lZljxDIzbQ0Qf4yIpbzVW3rptysg+l
         ozVEATaHpP+VD78Su9ScbEasTRdVcHBZ9chjn9B3wTzvYpEz1kFCP1R1mMBKV6uk5VrP
         eZu9Gb/vztFxMUQtzQ67JG3oJLnBGj31JOJVkfz3zTMwpPoVwK4UPm7lmh/XseP2Jzlz
         d1XQ==
X-Gm-Message-State: AC+VfDxI9sIGa6IUAF29APk1JHK1jeKvLpzh+GQEU7mw+qCcwpx0DsP3
        fsCsTXZU1twz6D7i44zfR8LUzeXiwCo+kCbntVJ1Nieg
X-Google-Smtp-Source: ACHHUZ7tubMztUOrbbglvs2vvPu6KY8CkCGBbsgUJxwMEr2oYn6XUNBK7cCGpEwo3E0AYHhagw9l5Q==
X-Received: by 2002:a19:f613:0:b0:4f3:77f9:2bbe with SMTP id x19-20020a19f613000000b004f377f92bbemr3763341lfe.3.1684777843331;
        Mon, 22 May 2023 10:50:43 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512050100b004e843d6244csm1051736lfb.99.2023.05.22.10.50.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 10:50:43 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso4803199e87.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 10:50:42 -0700 (PDT)
X-Received: by 2002:a17:907:1688:b0:965:d7c7:24db with SMTP id
 hc8-20020a170907168800b00965d7c724dbmr9757222ejc.32.1684777349281; Mon, 22
 May 2023 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-24-dhowells@redhat.com>
 <20230522102920.0528d821@rorschach.local.home> <2812412.1684767005@warthog.procyon.org.uk>
In-Reply-To: <2812412.1684767005@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 10:42:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use direct_splice_read()
To:     David Howells <dhowells@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 7:50=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> We could implement seq_splice_read().  What we would need to do is to cha=
nge
> how the seq buffer is allocated: bulk allocate a bunch of arbitrary pages
> which we then vmap().  When we need to splice, we read into the buffer, d=
o a
> vunmap() and then splice the pages holding the data we used into the pipe=
.

Please don't use vmap as a way to do zero-copy.

The virtual mapping games are more expensive than a small copy from
some random seq file.

Yes, yes, seq_file currently uses "kvmalloc()", which does fall back
to vmalloc too. But the keyword there is "falls back". Most of the
time it's just a regular boring kmalloc, and most of the time a
seq-file is tiny.

                      Linus
