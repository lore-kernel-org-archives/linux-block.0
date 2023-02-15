Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101FC636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 05:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjBOE76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 23:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjBOE75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 23:59:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DF34004
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 20:59:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bg2so7826135pjb.4
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 20:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaZgKqOUe0VVRH5ftQYEOTV1BVr4Wv8d3kXjdyKziRI=;
        b=rketxIr4gImJPorL4R5BRrbp+c0WJjOM6XhLDCzwXdV6Fj1IT4O0ZK8DFJCWACBnVd
         nQqxyMQoCbntnZoJztkq64u0znEbhYif7EjCaLuLvgcYkX3wlJnfr7QPAdnCDBpAsnK2
         k3NzSt9lKQC4InHgH1A7iKw/ayUkNVETC+TSIQ23+DvbBC0iCSuWLgyv5+Ju45HThA1t
         FyXFYz8rHviPYEGVGqvBo3x2vs7XvZ5irj2NGf8AeEK31To10XgAbZaWPY+h8D5LhBq/
         PjPpSBH8/eI5TO767b2bsmgSXYnTPhm5RHRDbBI8xY9wZHIFyHtYwGc3lkltkMvP3WcT
         It6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaZgKqOUe0VVRH5ftQYEOTV1BVr4Wv8d3kXjdyKziRI=;
        b=QdJfTA9eULddlQSSColp5FQPXvEpmNjiPse6cGbqh9BPS+9TXS6Y24+7dWc48hnKl1
         xIpPqlgH0i91e7qAt8NUbtW+WwnRtqDLsyOeGZqJLOuDVzDlrrVs9SBy12uZ3wLWCB1y
         kZ5lrV7JLNGw4rrzcWGif43rN82lfPELM0mcKW8N/lXY10zaIKPWBTfJR739l7TzrPEo
         rvvOQWAPaUAxUpaUinnJoVBew4KBzJ+PNuaoNOs9gdc4xKbWNI7OOoOFqbDI3I7NOOX5
         Hcy7/j2ybwlLpyVL1D6MonUnSJdg231XKj+Okvv+4Y1Od06Avjk40BZftDOn+fNrNZGJ
         eDtA==
X-Gm-Message-State: AO0yUKUKPPFv7QYT4OD8nSL4EARBXFqRIk/rIhA6pcwThmec6twe27UH
        JeOTqttoB+xs/iCtA001x+MEFQ==
X-Google-Smtp-Source: AK7set+JG/B78Wq9ZBXSoUQJVRPwNoUSoonIc9EyVLGDRxv5C5xNQ3cyJaZxI/N31YGytS8k0cKOHQ==
X-Received: by 2002:a17:903:2344:b0:19a:586c:2b81 with SMTP id c4-20020a170903234400b0019a586c2b81mr1271624plh.40.1676437195868;
        Tue, 14 Feb 2023 20:59:55 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id jm15-20020a17090304cf00b001994a0f3380sm11035857plb.265.2023.02.14.20.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 20:59:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pS9tY-00FTp0-LH; Wed, 15 Feb 2023 15:59:52 +1100
Date:   Wed, 15 Feb 2023 15:59:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <20230215045952.GF2825702@dread.disaster.area>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214135604.s5bygnthq7an5eoo@quack3>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 14, 2023 at 02:56:04PM +0100, Jan Kara wrote:
> On Mon 13-02-23 01:59:28, Christoph Hellwig wrote:
> > Eww.  The block bounc code really needs to go away, so a new user
> > makes me very unhappy.
> > 
> > But independent of that I don't think this is enough anyway.  Just
> > copying the data out into a new page in the block layer doesn't solve
> > the problem that this page needs to be tracked as dirtied for fs
> > accounting.  e.g. every time we write this copy it needs space allocated
> > for COW file systems.
> 
> Right, I forgot about this in my RFC. My original plan was to not clear the
> dirty bit in clear_page_dirty_for_io() even for WB_SYNC_ALL writeback when
> we do writeback the page and perhaps indicate this in the return value of
> clear_page_dirty_for_io() so that the COW filesystem can keep tracking this
> page as dirty.

I don't think this works, especially if the COW mechanism relies on
delayed allocation to prevent ENOSPC during writeback. That is, we
need a write() or page fault (to run ->page_mkwrite()) after every
call to folio_clear_dirty_for_io() in the writeback path to ensure
that new space is reserved for the allocation that will occur
during a future writeback of that page.

Hence we can't just leave the page dirty on COW filesystems - it has
to go through a clean state so that the clean->dirty event can be
gated on gaining the space reservation that allows it to be written
back again.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
