Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3BC4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 08:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiL2IQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 03:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiL2IPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 03:15:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C713DCB
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:14:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jo4so43443365ejb.7
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf4Oclx/s2DatfZfaRbzTJQI1IZBAeRXW5JK4LTSla4=;
        b=NU2n1cZSHmMnwavRmjaGTIOlZm9KKoVlTctPjkyNTmZUljpRpEn9h6P8v4Hs9lilpI
         mkCIQ2k2l/xfRvQXQ69rAtGkTcoyANDRbInSespNg/TQMBEiJJphNIESLhmtweJP/7+h
         Wp7m19/xGESByGcjrF6tidvzavgdhhzaF0/Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf4Oclx/s2DatfZfaRbzTJQI1IZBAeRXW5JK4LTSla4=;
        b=VkuQmedph/7Ur8rruKhIt5tgkq7DWLD/bjlyFY+KOxV32/iUxtT6ZBnM21Kjmj1b/U
         CDrbkNfNLI6092X53C3FVsdaOwoGCPHVJWDX6X3jZAmTgdotTW+KpOo3s6JPT5GO+Mkr
         xyUy2AypaGM/lADZIWrOu5KRsPGGVfp2IqJ3/+VGpefs0sIo0jc6ORTtpgYVeFiRGplF
         6GxlrpvEU0BcwBADnFwYQd/bF23MV6+Er4/FseT1HgXicCObo3MmaNRG1YwmQ1PnDz2I
         6WX3kq+VyMqkCjtgVyMrL6RIqPmzF82bGoc9NLUleVpO+iBGQnmXjE9jBQlaJcNSP9rK
         cNJQ==
X-Gm-Message-State: AFqh2kqmkBswlTKHo1+PC6lfs3S/fG7oXpkVIGLMmi6ZehDd+sGhoPZn
        J5KOuDndJ+UHgtbpExlLbv7UfNWcxZ5JAB8XafjZPw==
X-Google-Smtp-Source: AMrXdXs300Z+BXOJPxEJlPkjyVUzSJVOjoySN3yowIHivu+kDMNajS+vq938RArP6B2ta87auqxQOwl3KblSmt1bED8=
X-Received: by 2002:a17:907:c013:b0:7c0:eb3c:1037 with SMTP id
 ss19-20020a170907c01300b007c0eb3c1037mr2068068ejc.663.1672301676050; Thu, 29
 Dec 2022 00:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com> <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com> <Yy1yOGy7yF4AShDB@infradead.org>
In-Reply-To: <Yy1yOGy7yF4AShDB@infradead.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 29 Dec 2022 00:14:25 -0800
Message-ID: <CAG9=OMOLLjVJHTPmDSPM3t+Ko90CcN5C01UhEadZReECUE5umw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23, 2022 at 1:45 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Sep 20, 2022 at 10:54:32PM -0700, Sarthak Kukreti wrote:
> > [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> >
> > would be predicated on the guarantees of fallocate() per allocation
> > layer; if ext4(1) was replaced by a filesystem that did not support
> > fallocate(), then there would be no guarantee that a write to a file
> > on ext4(2) succeeds.
>
> a write or any unlimited number of writes?

(Apologies for the super late reply!) In this case, even a write won't
be guaranteed if we run out of space on the lower filesystem. Looking
at the fallocate() man page, I think the key part lies in the
following phrase (emphasis mine):

```
After a successful call, subsequent writes into the range
specified by offset and len are guaranteed not to fail _because of
lack of disk space_
```

So, it's not a blanket guarantee that all writes will always succeed,
but that any writes into that range will not fail due to lack of disk
space. As you mentioned, writes may happen out-of-place in one or more
layer. But the fallocate(FALLOC_FL_PROVISION) ensures that each layer
will preserve space for writes into that range to not fail with ENOSPC
(so eg. ext4 and dm-thinp will set aside enough extents to fulfil that
promise later on for all writes).

Best

Sarthak
