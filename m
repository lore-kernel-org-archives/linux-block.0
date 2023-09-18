Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F179C46CA1
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjIRU6O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIRU6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 16:58:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA327111;
        Mon, 18 Sep 2023 13:57:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340C3C433CC;
        Mon, 18 Sep 2023 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695070677;
        bh=1v0ZGhSwRTXLG9wlFUKoSk2qaGWwbEQ3ZBN31adiJGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyQ4qNA3cTHuUa50VsoFyLkcDOry7jj0AskmmAPeuio4TGtFkNj5lyQmRKZCQUH0S
         ChQNoWBb/Rd7Ltji4aI//LH3J+fu6OCQn65aL9WdCInq9ataKAwfe+SbYxjSqrRcDG
         xncfD4pIaGzM5vVP9nsuMsm0g8iC8HtCnsLicbWGo3GiLmR5jdAYJtR5WIGgaVOEy/
         eITgvWD/9HyBv8NK5A2VciRnvBl83hwlTylkwcTiQWBmEpdJfQhN7r+OvxATWqK4Hi
         c+C8jDbPvRprTDhING/o5klBN97EpLJToFnPjbvT4uy8CXEu2s4pQUSJbQjsGlMc/E
         3z72kUXNEv3GA==
Date:   Mon, 18 Sep 2023 16:57:55 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 20/22] block: Allow bio_iov_iter_get_pages()
 with bio->bi_bdev unset
Message-ID: <ZQi50xT1o/N2o8Bt@sashalap>
References: <20230908193407.3463368-1-sashal@kernel.org>
 <20230908193407.3463368-20-sashal@kernel.org>
 <ZP7j2MA5Qk6RBtAd@duo.ucw.cz>
 <d6da7de6-e603-4fb3-b68e-8d919f26fefe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d6da7de6-e603-4fb3-b68e-8d919f26fefe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 11, 2023 at 07:15:18AM -0600, Jens Axboe wrote:
>On 9/11/23 3:54 AM, Pavel Machek wrote:
>> Hi!
>>
>>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>>
>>> [ Upstream commit 168145f617d57bf4e474901b7ffa869337a802e6 ]
>>>
>>> bio_iov_iter_get_pages() trims the IO based on the block size of the
>>> block device the IO will be issued to.
>>>
>>> However, bcachefs is a multi device filesystem; when we're creating the
>>> bio we don't yet know which block device the bio will be submitted to -
>>> we have to handle the alignment checks elsewhere.
>>>
>>> Thus this is needed to avoid a null ptr deref.
>>
>> We are certainly not going to backport bcachefs to -stable. Please
>> drop.
>
>I already said as much 3 days ago:
>
>https://lore.kernel.org/all/cd341326-cfaf-4796-8894-2241e7b630d9@kernel.dk/
>
>but didn't hear back yet.

Dropped, and sorry for lack of timely replies on this - I let them
collect feedback for a few weeks before going through it and dropping
what needs to be dropped.

-- 
Thanks,
Sasha
