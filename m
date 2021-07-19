Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08190C12002
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22E361186
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhGSJPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhGSJPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:15:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45AC061574;
        Mon, 19 Jul 2021 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4vk7KIdJCRC7TIVcjpvWczPZx7IvBjnY0IqBnPn8DYo=; b=m5vWPRSWx2lZkD8Ledo+GwIjEG
        q0b/4cwhoLB/6JL8e9Haz+iFOIkyYLYBFtl1v8DReF9xXOQuUmjAkuv+irsynbFlXMy3oL3/SKH01
        7HQcFLHfYRmPSat80LHGZ4Nj+niD8kRJxqX40CCZqKyCkaJ1syM65KWUbEsTOtyhFrDP2JcAxyn+A
        UqJyCBCeJwk2kbWgQN0a+Shb8RpJ2nj+xcSCREv7i1gvJTVz5k8KxzdBntveDRa1B5S2ZsU83d2t7
        uPze/t+W73PlyxyhdOpJVkZDXtg/DhgLsXI4jlO2lHgZeTviJuF9D6/4xWmwVDBH/lwZmUVsSbspr
        Xsb3gQ6A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5PxI-006igt-Jq; Mon, 19 Jul 2021 09:53:07 +0000
Date:   Mon, 19 Jul 2021 10:52:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/6] genhd: update docs for GENHD_FL_UP
Message-ID: <YPVLeAcJNb+2m6fc@infradead.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715202341.2016612-2-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 01:23:36PM -0700, Luis Chamberlain wrote:
> The GENHD_FL_UP is used internally so we can know when we can add and
> remove partitions, so just clarify that. Right now it has this 1980's
> description comparing it to network drivers "ifconfig up" idea, and
> that can easily lead to invalid uses.

GENHD_FL_UP actually is pretty horrible - it uses a value used for
something that should be mostly read only at device runtime for
state an does so badly.  I actually have a patch to kill it, as we can
just check if the inode for the whole device blockdev is hashed instead.
