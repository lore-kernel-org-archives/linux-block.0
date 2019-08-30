Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD46C3A59B
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 17:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689562342F
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567184948;
	bh=gMd5xlYG8lJ3Gus8qIlNByXHRVxU/bMgXRnvywdLzM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RZmy8NOcuTrSXYrx0GSCOEyoaFS70a06Wjbzkr1OhklnIlrEpRMhqpdBp2mCGdzca
	 ocv131AaeuIfrIRI6CNT/Hj0wYS/IzdeUP3UFTgWc1Hi1QUKm4u1tRuahcTEzVCTRI
	 5F47gCIhfv1IcTEv+gwRx+U+uTyeGvRlNFF0wjYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfH3RJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:09:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33670 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3RJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 13:09:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so3106293qtd.0;
        Fri, 30 Aug 2019 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zag/cCurJuI8nINltP1hM69M5M7TCZ8LCVJ1Mr2Rw9E=;
        b=RNe+Qb5zoZXx6K4SAJ2I3Zg7N1BzEmvVWiTNb0YF2zfqjTcYHkhY9qX1bi4d8i1FGk
         r5oLZLXJoqeIx4V+/2k8Uv0HumpF+RyOTfj0Obk43jaimI4UPKRoRV6sd0+isOli0V6o
         X/madbTdHMGYh6q4hdTGhhNmB7eXSHU51hbAXjzsLDtOemDAqfHt0oziuvXhYvxstwjB
         XZmdVp1cjPl3cE06OpN8T/DhyL6ZzMy/O6kX3eiJBeAjDnjWeLGrOTe4i3Pa/GZJ3ehq
         X4lvG6Sn8TJrrFHAFfCPHo5waWEh9mJYemvG+wBOheerm120wHxeVbQYCwcpl2ctQLcl
         XFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zag/cCurJuI8nINltP1hM69M5M7TCZ8LCVJ1Mr2Rw9E=;
        b=R3c7vYX+xMsRuU5gHFsDCFpVQhxIFYEflBWv32WGAf/oV+zRCYPXpehT6+H/DcWjzm
         yFtQahp+n9GilQsEygo/zRQlG58ithiiKpBnhwX6w5xc5uD27IZn57pGaVT0JZEN3ASg
         dwMmKFiISeBPa3FIxvaea8HpInfsOol7B09CAc/rRpZ4NymwcEwmNj0YQYTS8lNxAX3J
         C7s7JcgVocy9dEUWUa7Q7G0Yfe8X3f9+y/Cxp/t1zsjFKpJkWlaPPAvbCfPjn1XhzQcg
         NQNITuaMxttKg2fponWnFMkNO6bo8ttUu2IaAAQA0Qg20RRax7C1A74NHewwr+ckFMZp
         sIDQ==
X-Gm-Message-State: APjAAAW2WFYWZtcQTbe73JEaFgHBLKFeVpeKOfCA/Za4gLkq2LGZIQ2y
        Dt18+3NQrOGKU2n/AHzFneM=
X-Google-Smtp-Source: APXvYqwchRBbgZEE4wNHzNdKzi1iP+TxhWNP/ayEstj1LZU/qPNuW9VAzfDU9gQJLA47VKDIagx+Lg==
X-Received: by 2002:a0c:a0e6:: with SMTP id c93mr6195303qva.109.1567184946122;
        Fri, 30 Aug 2019 10:09:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::677e])
        by smtp.gmail.com with ESMTPSA id c14sm1789122qta.80.2019.08.30.10.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 10:09:05 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:09:03 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
Message-ID: <20190830170903.GB2263813@devbig004.ftw2.facebook.com>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
 <20190830154023.GC25069@quack2.suse.cz>
 <20190830154921.GZ2263813@devbig004.ftw2.facebook.com>
 <20190830164211.GD25069@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830164211.GD25069@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Jan.

On Fri, Aug 30, 2019 at 06:42:11PM +0200, Jan Kara wrote:
> Well, but if you look at __set_page_dirty_nobuffers() it is careful. It
> does:
> 
> struct address_space *mapping = page_mapping(page);
> 
> if (!mapping) {
> 	bail
> }
> ... use mapping
> 
> Exactly because page->mapping can become NULL under your hands if you don't
> hold page lock. So I think you either need something similar in your
> tracepoint or handle this in the caller.

So, account_page_dirtied() is called from two places.

__set_page_dirty() and __set_page_dirty_nobuffers().  The following is
from the latter.

	lock_page_memcg(page);
	if (!TestSetPageDirty(page)) {
		struct address_space *mapping = page_mapping(page);
		...

		if (!mapping) {
			unlock_page_memcg(page);
			return 1;
		}

		xa_lock_irqsave(&mapping->i_pages, flags);
		BUG_ON(page_mapping(page) != mapping);
		WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
		account_page_dirtied(page, mapping);
		...

If I'm reading it right, it's saying that at this point if mapping
exists after setting page dirty, it must not change while locking
i_pages.

__set_page_dirty_nobuffers() is more brief but seems to be making the
same assumption.

	xa_lock_irqsave(&mapping->i_pages, flags);
	if (page->mapping) {	/* Race with truncate? */
		WARN_ON_ONCE(warn && !PageUptodate(page));
		account_page_dirtied(page, mapping);
		__xa_set_mark(&mapping->i_pages, page_index(page),
				PAGECACHE_TAG_DIRTY);
	}
	xa_unlock_irqrestore(&mapping->i_pages, flags);

Both are clearly assuming that once i_pages is locked, mapping can't
change.  So, inside account_page_dirtied(), mapping clearly can't
change.  The TP in question - track_foreign_dirty - is invoked from
mem_cgroup_track_foreign_dirty() which is only called from
account_page_dirty(), so I'm failing to see how mapping would change
there.

Thanks.

-- 
tejun
