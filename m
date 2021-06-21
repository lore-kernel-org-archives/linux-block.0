Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE580C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA341611C1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFUXxN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFUXxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 19:53:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF6C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rlYvPUD8gk4q9y4LqRUMw4oqjNtiYarrOGh98kJpUIE=; b=qxW9sq3vPMOxc0sLJsudQh0LYj
        bjfRk/CUUXcWA5Jf1Aqk5sbyvahyopAoBFmbQP+I5C8qLtpTHx659zkIEKimn2nrf94D5hyQSrH9N
        sxFKKs6nYe77oPY2Lq6kNKYV6an7CP5BL2uRv/3LZ/Lv31sZ4RWA8c0UV+5+sKkv2O4Y/a9ViVUOO
        mmIIqiXW9XvP0KvaoBcoMDY3CztkSAcmMAZ3de8/FkPXjXNUjuBuMup1lUYoZntAEw6aWZEnumteK
        OttzV0ZELEhqiFaOQ6CWaJGXGgIFm/cODapjYybT0amYXJ69Nj70qIzHp8f2kop2+2uoHoaIwuTy2
        Qr5FCzoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvTff-00Dh9v-0a; Mon, 21 Jun 2021 23:50:00 +0000
Date:   Tue, 22 Jun 2021 00:49:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: =?utf-8?B?4p2MIEZBSUw=?= =?utf-8?Q?=3A?= Test report for kernel
 5.13.0-rc6 (block, b0740de3)
Message-ID: <YNElkvvd83KboK3Q@casper.infradead.org>
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
 <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
 <CA+tGwn=8KMpRi+6M-Lcs5MjKTkPd36YL5wv84Ji2dEWLjzfDmA@mail.gmail.com>
 <YNELoqls01MVLsuT@casper.infradead.org>
 <8a7b26a3-a17d-e851-690a-5a33b06f5dec@gmail.com>
 <YNEhq/C5/T4J8r2/@casper.infradead.org>
 <5cf4b5ae-c6aa-d64d-53ec-3e073a77baef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf4b5ae-c6aa-d64d-53ec-3e073a77baef@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 05:42:15PM -0600, Jens Axboe wrote:
> On 6/21/21 5:32 PM, Matthew Wilcox wrote:
> > On Mon, Jun 21, 2021 at 11:57:06PM +0100, Pavel Begunkov wrote:
> >> On 6/21/21 10:58 PM, Matthew Wilcox wrote:
> >>> On Mon, Jun 21, 2021 at 11:07:16PM +0200, Veronika Kabatova wrote:
> >>>> On Mon, Jun 21, 2021 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>
> >>>>> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
> >>>>>> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> We ran automated tests on a recent commit from this kernel tree:
> >>>>>>>>
> >>>>>>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >>>>>>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
> >>>>>>>>
> >>>>>>>> The results of these automated tests are provided below.
> >>>>>>>>
> >>>>>>>>     Overall result: FAILED (see details below)
> >>>>>>>>              Merge: OK
> >>>>>>>>            Compile: FAILED
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> the failure is introduced between this commit and d142f908ebab64955eb48e.
> >>>>>>> Currently seeing if I can bisect it closer but maybe someone already has an
> >>>>>>> idea what went wrong.
> >>>>>>>
> >>>>>>
> >>>>>> First commit failing the compilation is 7a2b0ef2a3b83733d7.
> >>>>>
> >>>>> Where's the log? Adding Willy...
> >>>>>
> >>>>
> >>>> Logs and kernel configs for each arch are linked in the original email at
> >>>> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
> >>>
> >>> Which aren't there by the time they get to the original commit author.
> >>> You need to do better than this; the Intel build-bot bisects to the
> >>> commit which actually causes the error.
> >>
> >> Matthew, I've just followed the link out of curiosity:
> > 
> > the link _which isn't in the first email i got_.  the redhat cki system
> > is not very useful _because it doesn't do an automatic bisect and cc the
> > author of the commit_.
> 
> Kinks are still being worked out on that, nobody has claimed it's
> perfect yet. Some manual input/labor is still required.
> 
> But it's useful, as this report has indicated. So maybe try and be a bit
> nicer and appreciative, instead of grumpy and dismissive. It did find a
> problem with YOUR patch, fwiw.

and i've already fixed it, and tested it with a make allmodconfig.
turned out to be the only missing place.

i get grumpy when people implement auto-harassing systems badly.
