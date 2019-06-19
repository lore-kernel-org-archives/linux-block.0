Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08941C48BDF
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62802147A
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560975099;
	bh=ufGXvlZ2oTEKufBzdv5TWcAajgtSj8R8w3ocK3xoc6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jI20ElD9aV9G/n1Rwpa+lDg/1JJwhPyKgTxtkgpkkd50YyjT3pKzfft/Y2WfS8jxD
	 NApSFXaNjiTPWpHCb0s7QzDduVr5YV9QDvIvrzER5OHIc2nStZUWwQAKmBCkJnbPCX
	 rSjZxRUeU/42HqEj4aKX0YHQlPpm/UGJq4t81PTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFSULj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSULi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 16:11:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A2E52084A;
        Wed, 19 Jun 2019 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560975098;
        bh=ufGXvlZ2oTEKufBzdv5TWcAajgtSj8R8w3ocK3xoc6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/P2ytqoa4CHBYW0h3D8zdoeGL6fXEhsCbYD1mjWA0M9en9jRSvjyLvTNAxxmXn8m
         wegd9U4u1hMoQHEs+mxLfEfCJVonMmLE8zqmKWViZ2GoVdW28j2rqbIaDsCRaWy+dP
         77Y974gtUinTHbNigAOz4ddSSxCc3iPmW9N5KL2Q=
Date:   Wed, 19 Jun 2019 16:11:36 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.1 35/70] loop: Don't change loop device under
 exclusive opener
Message-ID: <20190619201136.GD2226@sasha-vm>
References: <20190608113950.8033-1-sashal@kernel.org>
 <20190608113950.8033-35-sashal@kernel.org>
 <20190610090013.GF12765@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190610090013.GF12765@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 10, 2019 at 11:00:13AM +0200, Jan Kara wrote:
>On Sat 08-06-19 07:39:14, Sasha Levin wrote:
>> From: Jan Kara <jack@suse.cz>
>>
>> [ Upstream commit 33ec3e53e7b1869d7851e59e126bdb0fe0bd1982 ]
>
>Please don't push this to stable kernels because...

I've dropped this, but...

>> [Deliberately chosen not to CC stable as a user with priviledges to
>> trigger this race has other means of taking the system down and this
>> has a potential of breaking some weird userspace setup]
>
>... of this. Thanks!

Can't this be triggered by an "innocent" user, rather as part of an
attack? Why can't this race happen during regular usage?

--
Thanks,
Sasha
