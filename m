Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBADAC10F14
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC07E218DE
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfJON1b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36271 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727745AbfJON1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 09:27:31 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9FDRICi023055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 09:27:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68F6D420287; Tue, 15 Oct 2019 09:27:18 -0400 (EDT)
Date:   Tue, 15 Oct 2019 09:27:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Project idea: Swap to zoned block devices
Message-ID: <20191015132718.GB7456@mit.edu>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
 <20191015113548.GD32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015113548.GD32665@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 15, 2019 at 04:35:48AM -0700, Matthew Wilcox wrote:
> On Tue, Oct 15, 2019 at 01:38:27PM +0900, Naohiro Aota wrote:
> > A zoned block device consists of a number of zones. Zones are
> > eitherconventional and accepting random writes or sequential and
> > requiringthat writes be issued in LBA order from each zone write
> > pointerposition. For the write restriction, zoned block devices are
> > notsuitable for a swap device. Disallow swapon on them.
> 
> That's unfortunate.  I wonder what it would take to make the swap code be
> suitable for zoned devices.  It might even perform better on conventional
> drives since swapout would be a large linear write.  Swapin would be a
> fragmented, seeky set of reads, but this would seem like an excellent
> university project.

Also maybe a great Outreachy or GSOC project?

