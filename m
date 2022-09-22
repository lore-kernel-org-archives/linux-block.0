Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E83C6FA90
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 08:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIVIIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiIVIIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 04:08:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45BCC8ED
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 01:08:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so19387765ejb.0
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iXb0cbDYs80FVQvp3dlURrNlpg98/EoNXEVRyzUkW50=;
        b=IHpFXTxMzEFLQHuCqKnKjLgk03sYFq1tMjEvHAzozOB9BfCb+i3KBMhvs3JlKgQj/+
         bEMZSL0mvAsy3XH8Hmf/XLkjX9u4gNiXsuA45KPErhXW9/EHW/LMcxrQm6ohuyOJEzLP
         WpezbHIfEgfsuCUS3VzgSBfjXcGiuMBnnuLlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iXb0cbDYs80FVQvp3dlURrNlpg98/EoNXEVRyzUkW50=;
        b=Z3yftKZpX0Hgz2RHlwyJ6rHiLqzApK46jUKTUrirxqW202w8l68/QzcIakuaTw4JeD
         hDjkPwUBogHfE6XdDkpmSmhZ6t0d2TindtrxHf/ENCtzNsx79e0y3p4EJlL+K00qbLWR
         n24x/XhEowB5P4Yjt7stZzez3Yd2SLmA0sxoqXEVDZUj4QYKZj1TEOPu4ukm+fgcJ7rp
         lIIT/0GGTnpAEV2vme2M9Al7n9EyA5WyrJ5pPx6SmwkcThVg5MDDf7pQJ8p3EQVz115E
         bAKZaQZMe49fghZWa8dOPcN25phVAuC1gAUGLFeNkuArBTKCTCUtt8XhJYwkYh261a0c
         TnfA==
X-Gm-Message-State: ACrzQf0vbzs1/B49BqypqUC/oBmefnJYTt52M/i8B3yJjjMEli8zCNlp
        skOmTTZarlRsau6Fw/G4DwQICKegSuC46/evVZT3Qg==
X-Google-Smtp-Source: AMsMyM7i6u9R9wd6F2HsmOaCSgsITPCe9fOhLfptS21SS36RpCCdvJBHZsBH+Qgv2Rg77TzYFsaXYBngYZEeV1fxkLM=
X-Received: by 2002:a17:907:968d:b0:782:66dc:4b89 with SMTP id
 hd13-20020a170907968d00b0078266dc4b89mr478912ejc.386.1663834095090; Thu, 22
 Sep 2022 01:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com> <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com> <YyssAb/zTcIG2bev@redhat.com>
In-Reply-To: <YyssAb/zTcIG2bev@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 22 Sep 2022 01:08:03 -0700
Message-ID: <CAG9=OMN6+ra3W2VcyvnnxRvxQz6uncSCNZvxZ8x9HgvV4GGB6w@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Wed, Sep 21, 2022 at 8:21 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Wed, Sep 21 2022 at  1:54P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > On Tue, Sep 20, 2022 at 12:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > >
> > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > sends a hint to (supported) thinly provisioned block devices to
> > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > >
> > > So, how does that "provisioning" actually work in todays world where
> > > storage is usually doing out of place writes in one or more layers,
> > > including the flash storage everyone is using.  Does it give you one
> > > write?  And unlimited number?  Some undecided number inbetween?
> >
> > Apologies, the patchset was a bit short on describing the semantics so
> > I'll expand more in the next revision; I'd say that it's the minimum
> > of regular mode fallocate() guarantees at each allocation layer. For
> > example, the guarantees from a contrived storage stack like (left to
> > right is bottom to top):
> >
> > [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> >
> > would be predicated on the guarantees of fallocate() per allocation
> > layer; if ext4(1) was replaced by a filesystem that did not support
> > fallocate(), then there would be no guarantee that a write to a file
> > on ext4(2) succeeds.
> >
> > For dm-thinp, in the current implementation, the provision request
> > allocates blocks for the range specified and adds the mapping to the
> > thinpool metadata. All subsequent writes are to the same block, so
> > you'll be able to write to the same block inifinitely. Brian mentioned
> > this above, one case it doesn't cover is if provision is called on a
> > shared block, but the natural extension would be to allocate and
> > assign a new block and copy the contents of the shared block (kind of
> > like copy-on-provision).
>
> It follows that ChromiumOS isn't using dm-thinp's snapshot support?
>
Not at the moment, but we definitely have ideas to explore re:snapshot
and dm-thinp (like A-B updates with thin volume snapshots), where this
would definitely be useful!

> But please do fold in incremental dm-thinp support to properly handle
> shared blocks (dm-thinp already handles breaking sharing, etc.. so
> I'll need to see where you're hooking into that you don't get this
> "for free").
>
Will do in v2. Thanks for the feedback.

Best
Sarthak

> Mike
>
