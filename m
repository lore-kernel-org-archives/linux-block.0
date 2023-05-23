Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F42C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 06:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjEWGTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjEWGS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 02:18:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2119133;
        Mon, 22 May 2023 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=75jy5j4PBNe+Q/HP75wXCzh0bnY+IGGowgZslWgr9Uc=; b=2rh1jdRSlFVWBkmVPPU5nQ1iq3
        xbzs1IfEBOlhOuBi9W8ZzInbFFOwg1/AtcevFI0qOTS8GVmykhhJrFIQ+SAo//dd5icd+IlZkPk9I
        /7jaVihTT8EAOamSlgsrnQ3aaQcM+l+j8Yl81taRluURoltYNPmgv/3FPlpONnXGJlHOFfVW4KXi3
        TOI6G1VbDrXF8wod8vUz5zZ1CZgosjaMDQO/2793RP/H50AwwOHLqmEQZgbbKM9vNFukJNtENPWB2
        lkXj5OnGM0FcFccweoZgI4SxFxKeas7ax7FNxWf2Du10ByKC7f7Xke6+4VoMDjFaG6gP/4vjfyVmw
        +Z1Ix6HA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1LM6-0093sT-0c;
        Tue, 23 May 2023 06:18:46 +0000
Date:   Mon, 22 May 2023 23:18:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Frederick Lawler <fred@cloudflare.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] capability: Introduce CAP_BLOCK_ADMIN
Message-ID: <ZGxaxnOeadVwb2gR@infradead.org>
References: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 11, 2023 at 03:05:18PM +0800, Tianjia Zhang wrote:
> Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
> For backward compatibility, the CAP_BLOCK_ADMIN capability is included
> within CAP_SYS_ADMIN.

Splitting out capabilities tends to massivel break userspace.  Don't
do it.

> CAP_SYS_ADMIN is required in the PR protocol implementation of existing
> block devices in the Linux kernel, which has too many sensitive
> permissions, which may lead to risks such as container escape. The
> kernel needs to provide more fine-grained permission management like
> CAP_NET_ADMIN to avoid online products directly relying on root to run.

I'm pretty sure the PR API can be keyed off just permissions on the
block device node as nothing in it is fundamentally unsafe.

Please work on relaxing the permissions checks there.

