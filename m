Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA45C4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F662344C
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600962355;
	bh=HpgA4t7U4Z9EnRNWOupT0nHkmf0YJ69c11DT/ilOQkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jbhH+b2C9V2Ribp/Ry9BFA1YFZERu2iojYkSgOOW5qnoVQoW1RApujkhWb8ZkT5M2
	 ZjY2EKH+vUD9qejssP0kdBzO9ej3T9Np0R7JxX85ZWS+ECsKr428/9CNFj7TbZg1KQ
	 Yp3+EY20zbfbyi9ljWa5PY2lo1xO+Ii21qMNFbQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgIXPpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 11:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgIXPpx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 11:45:53 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A352220C;
        Thu, 24 Sep 2020 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600962352;
        bh=HpgA4t7U4Z9EnRNWOupT0nHkmf0YJ69c11DT/ilOQkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnOAY6GRHn6dLZz5fydeqEsHe0EzdNDeZFd0K5h2uaQXZHwyLUmZ+LXTxOs/tSiQy
         TSKXqWcMOeGZbfaQpSsE/LOUCLmfOeJWCnWcqsOvztQJZYu1obLZ8v1cLcvKkPBb9b
         tU0hjvJw3t7T0tDdf2fyG3mvW/pTmeDezPFpqgBI=
Date:   Thu, 24 Sep 2020 08:45:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924154550.GA1266@sol.localdomain>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200922003255.GC32959@sol.localdomain>
 <20200924011438.GD10500@redhat.com>
 <20200924071721.GA1883346@google.com>
 <20200924134649.GB13849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924134649.GB13849@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 24, 2020 at 09:46:49AM -0400, Mike Snitzer wrote:
> > > Can you help me better understand the expected consumer of this code?
> > > If you have something _real_ please be explicit.  It makes justifying
> > > supporting niche code like this more tolerable.
> >
> > So the motivation for this code was that Android currently uses a device
> > mapper target on top of a phone's disk for user data. On many phones,
> > that disk has inline encryption support, and it'd be great to be able to
> > make use of that. The DM device configuration isn't changed at runtime.
> 
> OK, which device mapper target is used?

There are several device-mapper targets that Android can require for the
"userdata" partition -- potentially in a stack of more than one:

dm-linear: required for Dynamic System Updates
(https://developer.android.com/topic/dsu)

dm-bow: required for User Data Checkpoints on ext4
(https://source.android.com/devices/tech/ota/user-data-checkpoint)
(https://patchwork.kernel.org/patch/10838743/)

dm-default-key: required for metadata encryption
(https://source.android.com/security/encryption/metadata)

We're already carrying this patchset in the Android common kernels since late
last year, as it's required for inline encryption to work when any of the above
is used.  So this is something that is needed and is already being used.

Now, you don't have to "count" dm-bow and dm-default-key since they aren't
upstream; that leaves dm-linear.  But hopefully the others at least show that
architecturally, dm-linear is just the initial use case, and this patchset also
makes it easy to pass through inline crypto on any other target that can support
it (basically, anything that doesn't change the data itself as it goes through).

- Eric
