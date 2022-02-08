Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3082C352B6
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 22:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386579AbiBHW0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386922AbiBHVVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 16:21:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0FC0612B8
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MEcfNAJvaE7mW6qFLMfAKdyTamVFCzaZ2UMAPksa7eQ=; b=gxYD89ofKC7H/dZAQV3hGIcGd6
        i+QAQ8ERqzX1SiiOWe9YT4bZyn62qiiVgpEvN/CgKXf7+pnnYb4upqz+QcmgZAkQnzbA28OGV+bNz
        LZu7Huttrjb5ECFthwEF9ON43Ix472FN2o1RTA+OX8e7zvrRx6ZCmjohdeipZZWBnaB8Oe73c7z42
        yti3oZ3KU8HrP7uC1yLoT0BeKOIVxo40Bj5mHWZ2WTlOd1M9pz3Okyb7jPKH0bfHve4jnsxSoZtWc
        3uYRuNkfoKDCAcFsWCXXyKAAKLOFG70ioWDIb2XKfelqnCwNedcAQ/vjqEu0U3YxPFThm3ULxnECs
        4TWLbC8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHXvU-00FbZ1-GA; Tue, 08 Feb 2022 21:21:28 +0000
Date:   Tue, 8 Feb 2022 13:21:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dwagner@suse.de, osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Message-ID: <YgLe2GXJW2vqFZc5@bombadil.infradead.org>
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <caa2ba82-b3e8-6d5a-d411-241eb147f697@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa2ba82-b3e8-6d5a-d411-241eb147f697@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 07, 2022 at 05:10:24PM -0800, Bart Van Assche wrote:
> On 11/16/21 09:29, Luis Chamberlain wrote:
> > for a while now. More wider testig is welcomed.
>                               ^^^^^^
>                               testing?
> 
> > @@ -427,14 +428,8 @@ stop_soft_rdma() {
> >   		      echo "$i ..."
> >   		      rdma link del "${i}" || echo "Failed to remove ${i}"
> >   		done
> > -	if ! unload_module rdma_rxe 10; then
> > -		echo "Unloading rdma_rxe failed"
> > -		return 1
> > -	fi
> > -	if ! unload_module siw 10; then
> > -		echo "Unloading siw failed"
> > -		return 1
> > -	fi
> > +	_patient_rmmod rdma_rxe || return 1
> > +	_patient_rmmod 1siw  || return 1
> 
> The above clearly has not been tested. There is an easy to spot typo in the
> above change. Please test your changes before publishing these.

Thanks, fixed. Please I stated:

	I've tested blktests with this for things which I can run virtually
	for a while now. More wider testig is welcomed.

> > +	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> 
> Please use -n instead of ! -z.

Sure...

> > +	if [[ -f /sys/module/$module/refcnt ]]; then
> 
> Has this patch been analyzed with 'make check'? I expect checkpatch to
> complain about missing double quotes for the above statement.

No, I was not aware this was a thing. I fixed all the stupid complaints
however I should note at least tests/srp/rc has existing complaints
before my changes. I won't address those.

I can't say I agree with the changes to remove checks for $?, but
whatever. Consinstancy is better than not having one. Perhaps we should
embrace this on fstests as well. Who knows how many crufty bugs lie
there.

> > +# Patiently tries to wait to remove a module by ensuring first
>      ^^^^^^^^^^^^^^^^^^^^^^^
> Tries to wait patiently?

Sure..

> > +	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then
> 
> Please use -n instead of ! -z and surround the variable expansion with
> double quotes.

Sure..

> > +	# If we have extra time left. Use the time left to now try to
> > +	# persistently remove the module. We do this because although through
> 
> What is persistent module removal? Is that perhaps removing a module such
> that it cannot be loaded again?

No, I'll clarify to this:

# Tries to wait patiently to remove a module by ensuring first                  
# the refcnt is 0 and then trying to remove the module over and over            
# again within the time allowed

> >   	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
> >   			 target_core_file target_core_stgt target_core_user \
> >   			 target_core_mod
> > -	do
> > -		unload_module $m 10 || return $?
> > -	done
> > +	_patient_rmmod $m || return $1
> 
> Please proofread your changes and test your changes before posting these. I
> think that both "do" and "done" should have been preserved above.

And the return value shoudl be $? not $1. I couldn't test srp so wanted
someone who would to help review, but sure, I should have caught this.

Thanks for the review, I'll post a v2.

  Luis
