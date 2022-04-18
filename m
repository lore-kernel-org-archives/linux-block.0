Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbiDRQAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbiDRQAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 12:00:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FCFF2B
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z1nNE2psavlCFIarcihZEIqCOPB3Sdq4D2KRmDjAReA=; b=euSrmbCPpT5wvZPlXNns8X+bpC
        OWz9ZUhQGu9761eltKEwthgbYVkPU+O0n1qq9yOJwmIVksp7fMzry8DyEFKbMeQgMinZxi/Qa+yH8
        SNwCmG09zyAjEA47cdfddyM5uscQejkDcrI67c65vrEwsdTV0rDR+GJTLUWzRru6S3sOQZtEvVDJP
        rcORkVcD+jHH6XkQfk2F8PDNkEqwhWqNzWlyRkHCD2cbwZs4fyLlzeRGo3f8kgSzICQstaxbwo5zu
        yAtOqE+qyhRxw/ZQwqKe7YXYMlM3MI+FKfgkDhhljOcQ4yeFu/DcWgiDDEezSn8bnyB5oOChkmZNj
        OYqNQujw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngTkR-00HZ6H-VM; Mon, 18 Apr 2022 15:57:08 +0000
Date:   Mon, 18 Apr 2022 08:57:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blktests: replace module removal with patient module
 removal
Message-ID: <Yl2KU6vLxawrIXi/@bombadil.infradead.org>
References: <YlogluONIoc1VTCI@bombadil.infradead.org>
 <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 15, 2022 at 09:01:03PM -0700, Bart Van Assche wrote:
> On 4/15/22 18:49, Luis Chamberlain wrote:
> > -	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
> > -		return 1
> > -	fi
> > +	_patient_rmmod null_blk || return 1
> > +	modprobe null_blk "$@" "${zoned}" || 1
> 
> "1" is not a valid command. Should "|| 1" perhaps be changed into "|| return
> 1"?

That was a typo, fixed.

> > +_has_modprobe_patient()
> > +{
> > +	modprobe --help >& /dev/null || return 1
> > +	modprobe --help | grep -q -1 "remove-patiently" || return 1
> > +	return 0
> > +}
> 
> I can't find the meaning of "-1" in the grep man page. Did I perhaps
> overlook something?

That's shorthand for -C 1, but we can remove it as it is not needed.

> > +# checks the refcount and returns 0 if we can safely remove the module. rmmod
> > +# does this check for us, but we can use this to also iterate checking for this
> > +# refcount before we even try to remove the module. This is useful when using
> > +# debug test modules which take a while to quiesce.
> > +_patient_rmmod_check_refcnt()
> > +{
> > +	local module=$1
> > +	local refcnt=0
> > +
> > +	if [[ -f "/sys/module/$module/refcnt" ]]; then
> > +		refcnt=$(cat "/sys/module/$module/refcnt" 2>/dev/null)
> > +		if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
> > +			return 0
> > +		fi
> > +		return 1
> > +	fi
> > +	return 0
> > +}
> 
> Hmm ... why is the check for existence of the refcnt separate from reading
> the refcnt? I think that just reading the refcnt should be sufficient.
> Additionally, that will avoid the race where the module is unloaded after
> the check and before the refcnt is read.

We can certainly simplify it as follows:

_patient_rmmod_check_refcnt()
{
	local module=$1
	local refcnt=0

	refcnt=$(cat "/sys/module/$module/refcnt" 2>/dev/null)
	if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
		return 0
	fi
	return 1
}

> > -	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
> > -	if [[ "${nvme_trtype}" != "loop" ]]; then
> > -		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
> > -	fi
> > -	modprobe -r nvmet 2>/dev/null
> > +	if [[ "${nvme_trtype}" == "loop" ]]; then
> > +		_patient_rmmod nvme_"${nvme_trtype}"
> > +        else
> > +                _patient_rmmod nvme-"${nvme_trtype}"
> > +                _patient_rmmod nvmet-"${nvme_trtype}"
> > +        fi
> > +	_patient_rmmod nvmet 2>/dev/null
> 
> The statement _patient_rmmod nvme-"${nvme_trtype}" occurs twice in the above
> code. How about preserving the structure of the existing code such that that
> statement only occurs once?

There is one call for nvme-"${nvme_trtype}", the other is for the
underscore version, so there are no two calls.

Did I miss something?

> >   # Unload the SRP initiator driver.
> >   stop_srp_ini() {
> > -	local i
> > -
> >   	log_out
> > -	for ((i=40;i>=0;i--)); do
> > -		remove_mpath_devs || return $?
> > -		unload_module ib_srp >/dev/null 2>&1 && break
> > -		sleep 1
> > -	done
> > -	if [ -e /sys/module/ib_srp ]; then
> > -		echo "Error: unloading kernel module ib_srp failed"
> > -		return 1
> > -	fi
> > -	unload_module scsi_transport_srp || return $?
> > +	remove_mpath_devs || return $?
> > +	_patient_rmmod ib_srp || return 1
> > +	_patient_rmmod scsi_transport_srp || return $?
> >   }
> 
> Removing the loop from around remove_mpath_devs is wrong. It is important
> that that loop is preserved.

Why ? Can you test and verify?

I can explain why I'm removing it. Code which typically used to try to
insist on a module removal were just running into situations where the
refcnt got bumped but they could not explain why, and the reason is
that module refcnt's are finicky. *Anything* in userspace can easily
trigger this, and this is module specific. While doing a module removal,
if you are running into this, the only thing you can do is to patiently
wait until userspace is done with whatever it may try to do. The old
re-try attempts are buggy because of this.

A future mechansim for kmod will be to allow userspace to try to remove
first the modules which hold a refcnt, but that does not do anything for
whatever userspace might do. These entry points from userspace are
completely module specific and cannot be generalized (nor do I think we
want to add semantics to the kernelf or it).

So the only thing one can sensibly do, specially in test frameworks, is
to wait and use a timeout for it.

  Luis
