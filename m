Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90854C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 15:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjC0Pm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjC0PmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 11:42:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2D468F
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 08:41:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31CB321E6D;
        Mon, 27 Mar 2023 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679931706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dATKDqCvVXeJ9TcnGg6ZU1IR7mgHqAsS7oKpVK6JZE=;
        b=wTWxfUGWsQUjzbIWQqnBfKK/41XEV8Cuo3FKR2MsR/EmG9OvcgCkVM9zFc8qeOlSo8ganI
        bNMDGJiu0QJRgujLwVC4P+ZWY6bM/uXKDrqwdAnOvWbc7xsnElSDwP8fFWf0z1U8XqevD0
        vj2WxaHaIFe7F45Hmd/fmvG7mEjZ4e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679931706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dATKDqCvVXeJ9TcnGg6ZU1IR7mgHqAsS7oKpVK6JZE=;
        b=uA7CXS/yZTH8j6eBOd+uDIPFln4Njvv55afCDwtSvUTiJRHYDxrFmWT5yPby2SZUSktOww
        dgnKYD4ZQ/ohg1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 236B913329;
        Mon, 27 Mar 2023 15:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fFxLCDq5IWQPPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 27 Mar 2023 15:41:46 +0000
Date:   Mon, 27 Mar 2023 17:41:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Message-ID: <20230327154145.ev5m33q4rl4jf7r5@carbon.lan>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230323110651.fdblmaj4fac2x5qh@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323110651.fdblmaj4fac2x5qh@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 23, 2023 at 11:06:53AM +0000, Shinichiro Kawasaki wrote:
> On Mar 22, 2023 / 11:16, Daniel Wagner wrote:
> > Setup different queues, e.g. read and poll queues.
> > 
> > There is still the problem that _require_nvme_trtype_is_fabrics also includes
> > the loop transport which has no support for different queue types.
> > 
> > See also https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@meta.com/
> 
> Hi Daniel, thanks for the patches. The new test case catches some bugs. Looks
> valuable.
> 
> I ran the test case using various nvme_trtype on kernel v6.2 and v6.3-rc3, and
> observed hangs. I applied the 3rd patch in the link above on top of v6.3-rc3 and
> confirmed the hang disappears. I would like to wait for the kernel fix patch
> delivered to upstream, before adding this test case to blktests master.

Okay makes sense.

> When I ran the test case without setting nvme_trtype, kernel reported messages
> below:
> 
> [  199.621431][ T1001] nvme_fabrics: invalid parameter 'nr_write_queues=%d'
> [  201.271200][ T1030] nvme_fabrics: invalid parameter 'nr_write_queues=%d'
> [  201.272155][ T1030] nvme_fabrics: invalid parameter 'nr_poll_queues=%d'

BTW, I've added a '|| echo FAIL' to catch those.

> Is it useful to run the test case with default nvme_trtype=loop?

No, we should run this test only for those transport which actually support the
different queue types. Christoph suggest to figure out before running the test
if it is actually supported. So my first idea was to check what options are
supported by reading /dev/nvme-fabrics. But this will return all options we are
parsed by fabrics.c but not the subset which each transport might only support.

So to figure this out we would need to do a full setup just to figure out if it
is supported. I think the currently best approach would just to limit this test
to tcp and rdma. Maybe we could add something like

rc:
_require_nvme_trtype() {
	local trtype
	for trtype in "$@"; do
		if [[ "${nvme_trtype}" == "$trtype" ]]; then
			return 0
		fi
	done
	SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
	return 1
}

047:
requires() {
	_nvme_requires
	_have_xfs
	_have_fio
	_require_nvme_trtype tcp rdma
	_have_kver 4 21
}

What do you think?

Thanks,
Daniel
