Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F35C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8A821775
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 20:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgCDUDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:03:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44140 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729307AbgCDUDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 15:03:02 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 024K2oI6030142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Mar 2020 15:02:51 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 54F3242045B; Wed,  4 Mar 2020 15:02:50 -0500 (EST)
Date:   Wed, 4 Mar 2020 15:02:50 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [git pull] device mapper fixes for 5.6-rc5
Message-ID: <20200304200250.GE74069@mit.edu>
References: <20200304150257.GA19885@redhat.com>
 <CAHk-=wgP=q648JXn8Hd9q7DuNaOEpLmxQp2W3RO3vkaD2CS_9g@mail.gmail.com>
 <20200304192335.GA24296@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304192335.GA24296@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 04, 2020 at 02:23:35PM -0500, Mike Snitzer wrote:
> 
> These versions are for userspace's benefit (be it lvm2, cryptsetup,
> multipath-tools, etc).  But yes, these versions are bogus even for
> that -- primarily because it requires userspace to know when a
> particular feature/fix it cares about was introduced.  In addition: if
> fixes, that also bump version, are marked for stable@ then we're quickly
> in versioning hell -- which is why I always try to decouple version
> bumps from fixes.
> 
> Others have suggested setting feature flags.  I expect you'd hate those
> too.  I suspect I quickly would too given flag bits are finite and
> really tedious to deal with.
> 
> I'll think further about this issue and consult with userspace
> developers and see what we might do.

What I do for e2fsprogs is that it looks for the existence of files in
/sys/fs/ext4/features:

% ls /sys/fs/ext4/features/
total 0
0 batched_discard  0 encryption        0 meta_bg_resize      0 verity
0 casefold         0 lazy_itable_init  0 metadata_csum_seed

I started this because sometimes ext4 features get backported
(sometimes to ancient 3.18 kernels for Android, sigh, but also once or
twice for enterprise distro kernels), and so this relieves e2fsprogs
from testing kernel versions when deciding which defaults at mke2fs
time (for example).

						- Ted
