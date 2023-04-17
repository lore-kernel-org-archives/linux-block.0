Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16702C77B76
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 19:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDQTdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDQTdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 15:33:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA10B5
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Jc+o+6YbLTZXG+ICxaVTF9PGwwFux/MpwWNMn4BL0A=; b=foVgaT390N3iIGMtM6U4qa7zeT
        TUl5SHAia+LZa5BpCNuzvabeThWaMqjezSXsGDRlUBi54QcFp35IFlKDYsce4rR54riG1DjUyrnZe
        BOs5QrbfLiwSq9+rYbVilRhilVuvCjn+OOdCbkgjeNZAjQJi+B5ydrFKukU8kWDd1MhEy/ih0vj9j
        c06XWBAaQ+G8aKf1LEyZbyRI3TUPSchGcz24n9tiSO/hnEheCB9KxkNuCeQEzVE3v7en9zy2q16F/
        sNOOhNhc2E6/kcn9vG8zqVFRw/kfmq96DFzc3e9xXmQmBHndyGN3tmgQw3uVnxWZUzs4r0PWBlo5N
        oSu0E87A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poUas-00BcOu-8q; Mon, 17 Apr 2023 19:32:54 +0000
Date:   Mon, 17 Apr 2023 20:32:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash when bio_for_each_folio_all iterates
 over an empty bio
Message-ID: <ZD2e5lw5CqueygSA@casper.infradead.org>
References: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 17, 2023 at 03:11:57PM -0400, Mikulas Patocka wrote:
> If we use bio_for_each_folio_all on an empty bio, it will access the first
> bio vector unconditionally (it is uninitialized) and it may crash
> depending on the uninitialized data.

Wait, how do we have an empty bio in the first place?
