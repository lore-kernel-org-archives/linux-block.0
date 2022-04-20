Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A424BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 03:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiDTDnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 23:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiDTDnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 23:43:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B77111E
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 20:41:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso749843pjj.3
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 20:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g6/MrA4kS4PnBATPMqACMizmtts6ajNKwoKUGa90Tq8=;
        b=wcYhQbEEClOBBWPjFDu48G9JmLOBWGH5p64nz94mgFlM/ofE2R81TB08KoE2HWJd/U
         speFuT8H6j7K2saM17q5RaNiM5JbOFbvVSc2FjcSYrybIlmu040jTue2Td2H1SFdQWsn
         G/3skcUh0Pvav9C33jQpNK0V2+KEwhbFeZGEMW6Vr8YEjSGEfqQ5XIykcgKh/627ZeiF
         lwcfZERCH8T/ZcBzE8hyfYlMA6a0T+1Dnb6SLuvpEelOIa8bf7Tl/y79WwYu/TQEhuvB
         FFSuOaf1YR86Cuo0MO2FXeszD0avPO1yW5Jz91d78VaYSgx4mvRAsk/FBoWf9CUiNn0F
         /OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g6/MrA4kS4PnBATPMqACMizmtts6ajNKwoKUGa90Tq8=;
        b=qtScYnzE2a6nLRRXAmPcaLvIKk65Yly0fGxC9eqkTUWtqzXveFh8mn9+i/8wpdCy3V
         4QKs00vlP7KeAN+J5YlhIAfgO15H6zr3ZqOln9bs4KlSvFj0Ltic40HAjNuBkthQ//J+
         peB2f0ys+BOldz/KtGnVIQbKrKMHpcKzJsQkIWrx2Q77gpbZpqKVXx2aY5O8jSfWyUa/
         78nMWLvbD3Ob28XFmdtl8DkXzHIo87fnkT8X9WBcjdwTOwC7Qxgf+HAJlGRsXAH3hQ7f
         hxRmwjJCmD7ZweqA2mTOevk10BG/oJ3ulOyxqkyqR3gXjwL60LlgUfoBz2gDuBW5XwS1
         y8MA==
X-Gm-Message-State: AOAM531m/Bkdgd+6exKuj4yudtYCwV4gLiYItzZSq/KbkulwBX3ElygG
        xgT9Blfl2WnY8UrCNJtZO0NFuCG1oc43Iu5EOC2Hkw==
X-Google-Smtp-Source: ABdhPJx2JYmRYr2FDqsHZRmTwLt6v6bUSczTBzSpOlXW8naG9laKf3TN/n4V2b01dif/wl45a2jaiUlux3n0UAInH7g=
X-Received: by 2002:a17:90b:4b01:b0:1d2:abf5:c83f with SMTP id
 lx1-20020a17090b4b0100b001d2abf5c83fmr2027130pjb.93.1650426063240; Tue, 19
 Apr 2022 20:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220318130144.1066064-1-ming.lei@redhat.com> <20220318130144.1066064-3-ming.lei@redhat.com>
 <eac2af72d9e73f79bbdbe8253f7562d9f17046b3.camel@intel.com> <292908e4-8721-20a0-2720-e60641a1fbe4@huawei.com>
In-Reply-To: <292908e4-8721-20a0-2720-e60641a1fbe4@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Apr 2022 20:40:52 -0700
Message-ID: <CAPcyv4iUcSnGJrCx6gMRqRTwowk7wxNHPHarZTyBqHsDxcPLJg@mail.gmail.com>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 19, 2022 at 7:02 PM yukuai (C) <yukuai3@huawei.com> wrote:
>
> =E5=9C=A8 2022/04/20 9:46, Williams, Dan J =E5=86=99=E9=81=93:
> > On Fri, 2022-03-18 at 21:01 +0800, Ming Lei wrote:
> >> In the whole lifetime of blkcg_gq instance, ->q will be referred, such
> >> as, ->pd_free_fn() is called in blkg_free, and throtl_pd_free() still
> >> may touch the request queue via &tg->service_queue.pending_timer which
> >> is handled by throtl_pending_timer_fn(), so it is reasonable to grab
> >> request queue's refcnt by blkcg_gq instance.
> >>
> >> Previously blkcg_exit_queue() is called from blk_release_queue, and it
> >> is hard to avoid the use-after-free. But recently commit 1059699f87eb =
("block:
> >> move blkcg initialization/destroy into disk allocation/release handler=
")
> >> is merged to for-5.18/block, it becomes simple to fix the issue by sim=
ply
> >> grabbing request queue's refcnt.
> >
> > This patch, upstream as commit 0a9a25ca7843 ("block: let blkcg_gq grab
> > request queue's refcnt") causes the nvdimm unit tests to spam messages
> > like:
> >
> > [   51.439133] debugfs: Directory 'pmem2' with parent 'block' already p=
resent!
> > [   52.095679] debugfs: Directory 'pmem3' with parent 'block' already p=
resent!
> > [   52.505613] block device autoloading is deprecated and will be remov=
ed.
> > [   52.791693] debugfs: Directory 'pmem2' with parent 'block' already p=
resent!
> > [   53.240314] debugfs: Directory 'pmem3' with parent 'block' already p=
resent!
> > [   53.373472] debugfs: Directory 'pmem3' with parent 'block' already p=
resent!
> > [   53.688876] nd_pmem btt2.0: No existing arenas
> > [   53.773097] debugfs: Directory 'pmem2s' with parent 'block' already =
present!
> > [   53.884493] debugfs: Directory 'pmem2s' with parent 'block' already =
present!
> > [   54.042946] debugfs: Directory 'pmem2s' with parent 'block' already =
present!
> > [   54.195954] debugfs: Directory 'pmem2s' with parent 'block' already =
present!
> > [   54.383989] debugfs: Directory 'pmem2' with parent 'block' already p=
resent!
> > [   54.577206] nd_pmem btt3.0: No existing arenas
> >
> Hi,
>
> I saw the same warning in our test, and I posted a patch to fix the
> problem:
>
> https://patchwork.kernel.org/project/linux-block/patch/20220415035607.183=
6495-1-yukuai3@huawei.com/
>
> The root cause is not relate to the above commit, see details in
> the commit message.

Nice. I offered a late tested-by on that thread.
