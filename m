Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B9C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiBPWBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:01:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiBPWBR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 17:01:17 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F8529925C
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 14:01:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id a26so1463554iot.6
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7aZzAJ7eIu5QJbmd+PhcZrTGihRY4UQTElKA0+XExQo=;
        b=qXcgQlo2dXFyX+QpjhKZoeF3/dsruzavYOFV/tAHWWLtLyvISOf+ywWrQEmfXm47pb
         EEZdmdCieMtCiiYxmcpZaiwyMlK9TIk7bvT8tggIILo71oQm5Ma6x19kalqZsSEhwWKl
         s2bS4X+FiTfqq8DG9+NFFz04z9d0dOn5eNwhhOo7NrLPWs2/wdLF7lvcWKWsw1G9AhFd
         KG6U/blJ6A3KQn231Ws4SwSau5LBWnlmLf6zAStF/UlIxa2jsKADXrSje7mq5noNV4/y
         d42zt6eVbiXPL0cBoOgKtn87areTOfsisWzWE80ISEuGVHJpdR8LLHtFsxx82XaTvpC2
         FuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7aZzAJ7eIu5QJbmd+PhcZrTGihRY4UQTElKA0+XExQo=;
        b=CGg0Tn/CPCG/N/p/HZ1U9OfxwDeW4oPKpObuzDqgT7bdr0xULFcqJHIjcuDzbxCh1u
         nnBvwe9171b1vQ+O3I52fJaQvV4MKpXSluKtDOqUU7bX0GkfcDtHU/6On2U841CMKR8m
         +eiLxpO/Ijb7y+SB2XG96TR4DH1hBKxjtx/ErA1qxvUp4AG+cL/2gvQpWNVfkF5U4117
         AOAvE0QoMowGkdjH6jWHQHjmAu8q44seNgVF5tsSQfpVS4Hn9DQ/KD9ZbabE/uJdBfjT
         iz5GnpxN7ApPUNl7O4EeTW2pe5l/zTnn3EiNjOE02gZuGQVsGyV9GHqvSq/iUvYkcCzO
         lQ2Q==
X-Gm-Message-State: AOAM530i3/stCH9KpC3Wi/cOCxGN+VTyJsO3jbsF9dkbaoFl9Yde5KZ7
        xINwKQc50dgg8NTqfraIGoMD6A==
X-Google-Smtp-Source: ABdhPJww99WmkOEZ/fUhXlNY4rjl0ow5om1+rpHafSTQKr/wkjDASPwfKKgeMYrpyFDiis66IBEPyA==
X-Received: by 2002:a05:6602:482:b0:614:b990:28c9 with SMTP id y2-20020a056602048200b00614b99028c9mr3320749iov.6.1645048861011;
        Wed, 16 Feb 2022 14:01:01 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5929:5114:bf56:ccb6])
        by smtp.gmail.com with ESMTPSA id j14sm600635ilc.62.2022.02.16.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:01:00 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:00:56 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yg10GJjVQX6LJcr0@google.com>
References: <20220131230255.789059-1-mfo@canonical.com>
 <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
 <Yfr9UkEtLSHL2qhZ@google.com>
 <87o837cnnw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yg1zjHkctX0zkF+o@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg1zjHkctX0zkF+o@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 02:58:36PM -0700, Yu Zhao wrote:
> On Wed, Feb 16, 2022 at 02:48:19PM +0800, Huang, Ying wrote:
> > Yu Zhao <yuzhao@google.com> writes:
> > 
> > > On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
> > >> On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
> > >> >
> > >> > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> > >> > > Problem:
> > >> > > =======
> > >> >
> > >> > Thanks for the update. A couple of quick questions:
> > >> >
> > >> > > Userspace might read the zero-page instead of actual data from a
> > >> > > direct IO read on a block device if the buffers have been called
> > >> > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> > >> > > race between page reclaim on MADV_FREE and blkdev direct IO read.
> > >> >
> > >> > 1) would page migration be affected as well?
> > >> 
> > >> Could you please elaborate on the potential problem you considered?
> > >> 
> > >> I checked migrate_pages() -> try_to_migrate() holds the page lock,
> > >> thus shouldn't race with shrink_page_list() -> with try_to_unmap()
> > >> (where the issue with MADV_FREE is), but maybe I didn't get you
> > >> correctly.
> > >
> > > Could the race exist between DIO and migration? While DIO is writing
> > > to a page, could migration unmap it and copy the data from this page
> > > to a new page?
> > 
> > Check the migrate_pages() code,
> > 
> >   migrate_pages
> >     unmap_and_move
> >       __unmap_and_move
> >         try_to_migrate // set PTE to swap entry with PTL
> >         move_to_new_page
> >           migrate_page
> >             folio_migrate_mapping
> >               folio_ref_count(folio) != expected_count // check page ref count
> >             folio_migrate_copy
> > 
> > The page ref count is checked after unmapping and before copying.  This
> > is good, but it appears that we need a memory barrier between checking
> > page ref count and copying page.
> 
> I didn't look into this but, off the top of head, this should be
> similar if not identical to the DIO case. Therefore, it requires two
                                  ^^^ reclaim

> barriers -- before and after the refcnt check (which may or may not
> exist).
