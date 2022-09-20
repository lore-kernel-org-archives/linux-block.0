Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E31C6FA8E
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 10:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiITKmM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiITKly (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:54 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB915A3F
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 03:41:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b136so2776949yba.2
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ohwg6h5pt1L6UgZzvmkDlRzfFrSY3Rkz+ZdH2umFeZ4=;
        b=XscPul9vDtyKqAqDzBFblNHj4b/oP5GiZQ8WmwGknzA1uV7rOTTpqREmM7GV2K7Qaw
         jyou36soC7ryiQWzPt4CZ0fIDkDcBddfkjksrj5NEblaLL/TuWRM8V9qwbcADs7Qyf9r
         BNkSEp/0UyrfS4bTnXgmx2sWyFxmWVpLWYN+AMY/zbe45ZJCxPO6RyYWfGcg3QJ3AjH+
         x/Ljdi/2xh9V9XqzTfNEPDgrPDQlCTkdxS7NekVqNWyXjo1Tpean75A1u/UF1JiczrQR
         yg0Nc9q064/TTAe1Br6Tp/kT9QTRPferfp6szSG9sG5oA+45ruKeBR+4Mkwz6k6b6yVu
         +Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ohwg6h5pt1L6UgZzvmkDlRzfFrSY3Rkz+ZdH2umFeZ4=;
        b=Xmakuw5AcGfD0jM5K6klqx4X/EMeRRhWOcprVp02eIKjM6tLNNrCEwDmzfqTixEJyv
         zk/X2hcaM7spvpvvOJHoxwh1zrpzqYRNULwxsHu2/Xz6pSYCQi1AMqbUoAR+C9By4DKq
         ueCeBN+tluhAEWl1ugc6ETnOxoKIksFhnIezs691UEufCWMd7nsZ4Vt7oKuSZBbDz2Wk
         iEThBjRpHXpaPYR45xNsrUDkrQ5iRarxchVgFwxw8p3Zl+v8ZzAnn/0TYpIlVvhuY2I+
         ldU4k/7fD8soUsFxb+Lu7QmxqpAnCLMI8wMnDC43fwjl2mZZ7r+b+QjyqaTFQ58JS32d
         yf2Q==
X-Gm-Message-State: ACrzQf2jLRg9r9/E+jn1SYhz9ejwAF4wLrWzssuNrAiYr8C4RklsThQj
        P0I9Yf8sShxkEkOqNEkYT1SszbCIvP0pDIZgvg0=
X-Google-Smtp-Source: AMsMyM70Jm15MjTesJ1SrJF2r/Gx0S4iviH1odAjHGDcfr8nYuIv9WcV1P+e/jkig8B64pxwJ+gGLLURkGQrTIIIiLw=
X-Received: by 2002:a05:6902:44:b0:6af:f412:cfb7 with SMTP id
 m4-20020a056902004400b006aff412cfb7mr17495871ybh.366.1663670499850; Tue, 20
 Sep 2022 03:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com> <YylvChyEpFUiAuu8@infradead.org>
In-Reply-To: <YylvChyEpFUiAuu8@infradead.org>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Tue, 20 Sep 2022 06:41:27 -0400
Message-ID: <CAJSP0QWbLizQDTkPC74-DMm_fBR6w5ZboPWOqCx+T1KJGbcTPg@mail.gmail.com>
Subject: Re: [PATCH 0/3] virtio-blk: support zoned block devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>, linux-block@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 20 Sept 2022 at 03:43, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Sep 18, 2022 at 10:29:18PM -0400, Dmitry Fomichev wrote:
> > In its current form, the virtio protocol for block devices (virtio-blk)
> > is not aware of zoned block devices (ZBDs) but it allows the driver to
> > successfully scan a host-managed drive provided by the virtio block
> > device. As the result, the host-managed drive is recognized by the
> > virtio driver as a regular, non-zoned drive that will operate
> > erroneously under the most common write workloads. Host-aware ZBDs are
> > currently usable, but their performance may not be optimal because the
> > driver can only see them as non-zoned block devices.
>
> What is the advantage in extending virtio-blk vs just using virtio-scsi
> or nvme with shadow doorbells that just work?

virtio-blk is widely used and new request types are added as needed.

QEMU's NVMe emulation may support passing through zoned storage
devices in the future but it doesn't today. Support was implemented in
virtio-blk first because NVMe emulation isn't widely used in
production QEMU VMs.

Stefan
