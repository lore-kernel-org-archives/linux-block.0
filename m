Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 17:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiEKRol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiEKRok (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 13:44:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A4223869
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fdbql12aOS2KSSMpsvHjuCsdrDaT82RhchbPkuB7CQA=; b=s6yel7t9GNAZwS6qrqSjlp3PPI
        3NVQyvEBMOpN65x9M5nO7+ZVX8cjD+Gu+wMUtNKFG0YBmZtZcHA42WkEs02oTPJQkwQXc/RF+9T4z
        slD7hGj25ix7YW9g+2KNquBufpZ+PtfsQ5Uxj+TySu94Oa7/VZ8p1Y1RFhseJymxQGDFrfBJPZ4Iz
        CRUL9mkVKsFLo43EIrFA59srOxr0q9nrme4b274/atvTdvTNKq50Tsi+W2mYGzvZvxDwIktav2sM9
        v8zatfQZy6acS7/cn049DeOXzwndgrqErMSgUE4e02Abu/pNH7kcSi53KQl9hZgUDAz48gcqGq3iS
        r5G/JO4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noqO5-0080ri-D7; Wed, 11 May 2022 17:44:37 +0000
Date:   Wed, 11 May 2022 10:44:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blktests: replace module removal with patient module
 removal
Message-ID: <Ynv2BaRJcL0I3vAR@bombadil.infradead.org>
References: <YlogluONIoc1VTCI@bombadil.infradead.org>
 <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
 <Yl2KU6vLxawrIXi/@bombadil.infradead.org>
 <1293a7e7-71d0-117e-1a4f-8ccfc609bc43@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293a7e7-71d0-117e-1a4f-8ccfc609bc43@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 18, 2022 at 09:39:06AM -0700, Bart Van Assche wrote:
> On 4/18/22 08:57, Luis Chamberlain wrote:
> > On Fri, Apr 15, 2022 at 09:01:03PM -0700, Bart Van Assche wrote:
> > > On 4/15/22 18:49, Luis Chamberlain wrote:
> > > > -	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
> > > > -	if [[ "${nvme_trtype}" != "loop" ]]; then
> > > > -		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
> > > > -	fi
> > > > -	modprobe -r nvmet 2>/dev/null
> > > > +	if [[ "${nvme_trtype}" == "loop" ]]; then
> > > > +		_patient_rmmod nvme_"${nvme_trtype}"
> > > > +        else
> > > > +                _patient_rmmod nvme-"${nvme_trtype}"
> > > > +                _patient_rmmod nvmet-"${nvme_trtype}"
> > > > +        fi
> > > > +	_patient_rmmod nvmet 2>/dev/null
> > > 
> > > The statement _patient_rmmod nvme-"${nvme_trtype}" occurs twice in the above
> > > code. How about preserving the structure of the existing code such that that
> > > statement only occurs once?
> > 
> > There is one call for nvme-"${nvme_trtype}", the other is for the
> > underscore version, so there are no two calls.
> > 
> > Did I miss something?
> 
> It's only now that I see the underscore/hyphen difference in the if and else
> branches. It is not clear to me why this behavior change has been introduced?
> The following command produces no output on my test setup:
> 
> find /lib/modules -name 'nvme_*'

Try:

find /sys/module/ -maxdepth 1 -type d | grep loop

I get:
/sys/module/nvme_loop

Blame scripts/Makefile.lib which does the s|-|_| for KBUILD_MODNAME:

name-fix-token = $(subst $(comma),_,$(subst -,_,$1))                            
name-fix = $(call stringify,$(call name-fix-token,$1))                          
basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))               
modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \                 
                 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))

I'm thinking now it is best to do this hack here:

diff --git a/common/rc b/common/rc
index 67bba70..cff0eb2 100644
--- a/common/rc
+++ b/common/rc
@@ -390,7 +390,10 @@ _patient_rmmod_check_refcnt()
 # ourselves.
 _patient_rmmod()
 {
-	local module=$1
+	# Since we are looking for a directory we must adopt the
+	# specific directory used by scripts/Makefile.lib for
+	# KBUILD_MODNAME
+	local module=$(echo $1 | sed 's|-|_|g')
 	local max_tries_max=$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
 	local max_tries=0
 	local mod_ret=0


That would allow us to keep the old order, and in fact
would be correct for the other targets as well.

> > > >    # Unload the SRP initiator driver.
> > > >    stop_srp_ini() {
> > > > -	local i
> > > > -
> > > >    	log_out
> > > > -	for ((i=40;i>=0;i--)); do
> > > > -		remove_mpath_devs || return $?
> > > > -		unload_module ib_srp >/dev/null 2>&1 && break
> > > > -		sleep 1
> > > > -	done
> > > > -	if [ -e /sys/module/ib_srp ]; then
> > > > -		echo "Error: unloading kernel module ib_srp failed"
> > > > -		return 1
> > > > -	fi
> > > > -	unload_module scsi_transport_srp || return $?
> > > > +	remove_mpath_devs || return $?
> > > > +	_patient_rmmod ib_srp || return 1
> > > > +	_patient_rmmod scsi_transport_srp || return $?
> > > >    }
> > > 
> > > Removing the loop from around remove_mpath_devs is wrong. It is important
> > > that that loop is preserved.
> > 
> > Why ? Can you test and verify?
> 
> If I remember correctly I put remove_mpath_devs call inside the loop because
> multipathd keeps running while the loop is ongoing and hence can modify paths
> while the loop is running.

I suspect you ran into the issue of the refcnt being bumped by anything
multipathd tried, and not being able to remove the module, but  if it is
adding *new* mpath devices that would seem like a bug which we'd need to
address. The point to the patient module removal is to keep on trying
until the recnt  is 0 and if that fails wait and keep trying, until the
the timeout. Anytihng userspace does, say multipathd does, like
bdev_open(), would be yielded to.

So I'd like to keep this change as it is exactly the sort of hack I am
chasing after with this crusade.

Let me know how you'd like to proceed so I can punt a v3.

  Luis
