Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F5C3A59B
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A7E23428
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567180165;
	bh=nXSVc79MwADtvMh03MpKMbHC0zBWv30zWalqSvd2N88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zeyAdMnqt3GGcGy42la3odYxQm/xcNlVzGaBo9RhxRnfNMYVunRQS66CiWnyFiilf
	 K/me+T0NY95I/8ETTR/i+EmPt0hlq9+1MWUzPVDK/ZH9kMj/xb7OX+iZAe6u37cEYF
	 gDYuI3so/etnAzGsbmjVlG+8Hf3rCMuwMWo8JufY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH3PtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:49:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43964 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3PtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 11:49:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id b11so8052706qtp.10;
        Fri, 30 Aug 2019 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWG1xprHq5soDnqsOoV5sXd5YRcA3js3J4A3/q6CGlU=;
        b=Wgqj8hYGo0A/I1gghmpb6uViT1RJgL5Ci/oQGuwImhV3JUnrMed5W6Api9CJ4JKZmb
         jY/ufazdF5ggWnW70uWNMlWT1cKToe11F9WFbdSXajVHeyCRRXDzkotHY3xf9VDEyA7A
         JQD4yjvtNO20WNyKTLvfU88pTkfrk+FZ+BIdC9xtrc/qTUdY1cOmUC5IhhdbwCJTm9eD
         I/znZT9RBs31QbkRncZVHi5g8UE2o2JQDMWWxc1jXx3BISZ4D3lq4/F14jhTzfMfOpih
         8isdIRt9jNllkKjnRdMIH7l4sV1Gojj5gdUHbt0KActpBD/L3fu/QUTTMOuteCilHqth
         G4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWG1xprHq5soDnqsOoV5sXd5YRcA3js3J4A3/q6CGlU=;
        b=Yz+XfjDcGp+BsuDUxQQOFhUYRz+8+sfctyuk7or5hB1KR5DAwoGRWtMZa1+8naKzBa
         j7uA8Bdw3evI5uvyLP1YddIAtO9THfhKTARSQco8GTOB3VuP5130LjTkQOFCeYC6SmUR
         GJ6OCOZeazi046lq2/5n8FX8gR2UCDOfMt8VxTinAdeBki3acwFUAcGt2U0+qbC2QSgp
         lNXZmga8BJo8qmkR+nywe2EwRP9SwlWZFAoISKULUEgKniDuJDMtbsvkc7bGH3dEUeBA
         knB7+8IBtGistFEaM0EIvfQejQk8uHNYRSVRR+c9notF/B8P7HVjh+kRFSO9CIbYZMdZ
         kKsQ==
X-Gm-Message-State: APjAAAWhTAA1O8LYLs2Xd5YPBxgkLUuHX8cZiyFSUfDAbOTZNP1mXCwZ
        A+LHax2PCuLIUPi621o9iOM=
X-Google-Smtp-Source: APXvYqyFRZU9QBAkzb28H9Q+R/5xB+7uaYqUf2sCiz0G9RGsOQcoyI03rNeLOsDzNUFbov3MavZYTQ==
X-Received: by 2002:ac8:363c:: with SMTP id m57mr9461040qtb.240.1567180163904;
        Fri, 30 Aug 2019 08:49:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d0dd])
        by smtp.gmail.com with ESMTPSA id y67sm2965672qkd.40.2019.08.30.08.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:49:23 -0700 (PDT)
Date:   Fri, 30 Aug 2019 08:49:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
Message-ID: <20190830154921.GZ2263813@devbig004.ftw2.facebook.com>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
 <20190830154023.GC25069@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830154023.GC25069@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Jan.

On Fri, Aug 30, 2019 at 05:40:23PM +0200, Jan Kara wrote:
> > +	TP_fast_assign(
> > +		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
> > +		__entry->bdi_id		= wb->bdi->id;
> > +		__entry->ino		= page->mapping->host->i_ino;
> > +		__entry->memcg_id	= wb->memcg_css->id;
> > +		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
> > +		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
> > +	),
> 
> Are the page dereferences above safe? I suppose lock_page_memcg() protects
> the page->mem_cgroup->css.cgroup->kn->id dereference? But page->mapping
> does not seem to be protected by page lock?

Hah, I assumed it would work because there are preceding if
(page_mapping()) tests in the dirty paths -
e.g. __set_page_dirty_nobuffers().  Oh, regardless of that assumption,
I should have used page_mapping().

Thanks.

-- 
tejun
