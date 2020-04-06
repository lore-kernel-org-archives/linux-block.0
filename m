Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4FBC2BA80
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 20:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6061420748
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586203798;
	bh=oa1efFd6GtvI/GiBJ5CvOCQZv1Q3v+njeAUyrD1pinU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ywYG9YguFKuCVQSSv/PdSly06Y6c4EBm3Jvz2gZZXPuFeC3cFCMZ+totqU3v4zecW
	 1lztN7+rav/wGsnBkv+8e+0fAy1oWRoF/gs1qBqfTxs0t8c+LuumK+M2pi8opsil8Y
	 2Rel1zSbH8i/8gnkfP4RtY6kPa6SEqFxsIZqbJYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDFUJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDFUJz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Apr 2020 16:09:55 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C724A206C0;
        Mon,  6 Apr 2020 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586203795;
        bh=oa1efFd6GtvI/GiBJ5CvOCQZv1Q3v+njeAUyrD1pinU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsko9dH35pM2dS0l2A7ezVj04vBa/bw4bcCcz9Xcob7ERLx2DR3BsOtTYQjonAkZX
         yq+GPoUSIkbWnM57lLx3lWPaDeDKer2Nw7ZrpH1hDP8aWZSQP1eBw9y7rKJ3K9W+6f
         iN2B9WnhDrTScqaCtiS4TIwU+tjFvsKzjtB94+OI=
Date:   Mon, 6 Apr 2020 16:09:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Deven Bowers <deven.desai@linux.microsoft.com>
Cc:     Jann Horn <jannh@google.com>, agk@redhat.com,
        Jens Axboe <axboe@kernel.dk>, snitzer@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com
Subject: Re: [RESEND PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200406200953.GH27528@sasha-vm>
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
 <CAG48ez3JV-tzjRLdcys6Fz9LKYaB1h-1GaeAzkUYtY1RgxsB6g@mail.gmail.com>
 <20200406185910.GA77950@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200406185910.GA77950@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 06, 2020 at 11:59:10AM -0700, Deven Bowers wrote:
>On Mon, Apr 06, 2020 at 08:50:46PM +0200, Jann Horn wrote:
>> On Mon, Apr 6, 2020 at 8:10 PM <deven.desai@linux.microsoft.com> wrote:
>> > Overview:
>> > ------------------------------------
>> > IPE is a Linux Security Module, which allows for a configurable
>> > policy to enforce integrity requirements on the whole system. It
>> > attempts to solve the issue of Code Integrity: that any code being
>> > executed (or files being read), are identical to the version that
>> > was built by a trusted source.
>>
>> Where's patch 02/11? lore at
>> https://lore.kernel.org/linux-security-module/20200406183619.GA77626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#t
>> has everything other than that patch.
>
>It looks like it's over majordomo's character limit by 7489 characters.
>I'll have to repost with this patch broken up. Apologies.

Looks like it didn't cc LKML either.

-- 
Thanks,
Sasha
