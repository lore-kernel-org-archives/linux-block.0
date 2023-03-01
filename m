Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC3C7EE23
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 03:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCADw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Feb 2023 22:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCADw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2023 22:52:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09BB366BC
        for <linux-block@vger.kernel.org>; Tue, 28 Feb 2023 19:52:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3213qF9v017148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 22:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677642738; bh=ZA1nW/swc2lOnU8SSLD4xZ2BivJ0oOyDYTicwUJAQBQ=;
        h=Date:From:To:Cc:Subject;
        b=CtSfW2AfVJuETan9DkrTe7BgH27KA+kstH6kyzBn0b36djJ81Du/Ryk5Xc312MM2C
         g8MZsNEXsDOBxtkV59JNATEo9BGCesvXmsNLySNwnghbGEPmW5lmlioxIwtGld7ZL6
         kVGnIFwBiCfmcf74Zo1CZf7YTBHYQW35KJpHriFjUquq+fnFt9YgOpA3g6gHUDAdEd
         VNVM87qlLYgXxmuLqhJcOXSnN74aD0q0qBiUAu5L6WaSiduHIQf78e1vWkzuLvq2iZ
         ZTB2hXG5mfwgaekXGtYFrbMwpb57q7hxEMPTEsYfTw/vGjQgYZf8mGw4nfd4Oy+NMw
         r61njsrh6z8UA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C522D15C3593; Tue, 28 Feb 2023 22:52:15 -0500 (EST)
Date:   Tue, 28 Feb 2023 22:52:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <Y/7L74P6jSWwOvWt@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Emulated block devices offered by cloud VM’s can provide functionality
to guest kernels and applications that traditionally have not been
available to users of consumer-grade HDD and SSD’s.  For example,
today it’s possible to create a block device in Google’s Persistent
Disk with a 16k physical sector size, which promises that aligned 16k
writes will be atomically.  With NVMe, it is possible for a storage
device to promise this without requiring read-modify-write updates for
sub-16k writes.  All that is necessary are some changes in the block
layer so that the kernel does not inadvertently tear a write request
when splitting a bio because it is too large (perhaps because it got
merged with some other request, and then it gets split at an
inconvenient boundary).

There are also more interesting, advanced optimizations that might be
possible.  For example, Jens had observed the passing hints that
journaling writes (either from file systems or databases) could be
potentially useful.  Unfortunately most common storage devices have
not supported write hints, and support for write hints were ripped out
last year.  That can be easily reversed, but there are some other
interesting related subjects that are very much suited for LSF/MM.

For example, most cloud storage devices are doing read-ahead to try to
anticipate read requests from the VM.  This can interfere with the
read-ahead being done by the guest kernel.  So being able to tell
cloud storage device whether a particular read request is stemming
from a read-ahead or not.  At the moment, as Matthew Wilcox has
pointed out, we currently use the read-ahead code path for synchronous
buffered reads.  So plumbing this information so it can passed through
multiple levels of the mm, fs, and block layers will probably be
needed.
