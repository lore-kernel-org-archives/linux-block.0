Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A2C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB37420874
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfBJS1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:27:25 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:46678 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJS1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 13:27:25 -0500
Received: from mx03.mta.xmission.com ([166.70.13.213])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gstp4-000613-Ag; Sun, 10 Feb 2019 11:27:22 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gstp3-0001xG-H4; Sun, 10 Feb 2019 11:27:22 -0700
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 79C4D221D90;
        Sun, 10 Feb 2019 18:27:20 +0000 (UTC)
Date:   Sun, 10 Feb 2019 13:26:55 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Message-ID: <20190210182655.GA20491@hacktheplanet>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190204145244.GJ31132@infradead.org>
 <alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz>
 <1549586652.11868.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549586652.11868.12.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gstp3-0001xG-H4;;;mid=<20190210182655.GA20491@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 08, 2019 at 12:44:14AM +0000, Derrick, Jonathan wrote:
> On Thu, 2019-02-07 at 23:56 +0100, David Kozub wrote:
> > On Mon, 4 Feb 2019, Christoph Hellwig wrote:
> > > >  static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
> > > >  					  struct opal_mbr_data *opal_mbr)
> > > >  {
> > > > +	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
> > > > +		? OPAL_TRUE : OPAL_FALSE;
> > > >  	const struct opal_step mbr_steps[] = {
> > > >  		{ opal_discovery0, },
> > > >  		{ start_admin1LSP_opal_session, &opal_mbr->key },
> > > > -		{ set_mbr_done, &opal_mbr->enable_disable },
> > > > +		{ set_mbr_done, &token },

> > Am I missing something here? This seems wrong to me. And I think this 
> > patch actually changes it by introducing:
> > 
> > +    u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
> > +            ? OPAL_TRUE : OPAL_FALSE;
> > 
> > which is essentially a negation (map 0 to 1 and 1 to 0).

Agreed the original code did the opposite of what the user wanted, looks like
when I authored it I messed up that enum which set everything off.



> > With regard to the new IOC_OPAL_MBR_STATUS: I find the usage of 
> > OPAL_MBR_ENABLE/DISABLE for this confusing: what should passing 
> > OPAL_MBR_ENABLE do? Should it enable the shadow MBR? Or should it 
> > enable the MBR-done flag? I think the implementation in this patch 
> > interprets OPAL_MBR_ENABLE as 'set the "done" flag to true', thus hiding 
> > the shadow MBR. But this is not obvious looking at the IOCTL name.

For the new ioctl I think we should just add a new enum with the correct
nomenclature.  So OPAL_MBR_DONE, OPAL_MBR_NOT_DONE.


> In order to keep the userspace interface consistent, I'll ACK your
> change in this patch, unless Scott can fill me in on why this looks
> wrong but is actually right.

I think it is just wrong. 


> 
> We have 7 bytes in the opal_mbr_data struct we could use for DONE/NOT
> DONE. I'm not sure how to go about keeping it consistent with old uapi,
> although arguably opal_enable_disable_shadow_mbr is already doing the
> wrong thing with DONE and ENABLE so it's low impact.

Can we keep the old mbr struct the same and just add a new struct with new enums
for the new done ioctl? I think this will keep the new ioctl cleaner instead
of trying to apply older, some what incorrectly named, enums.

Lastly someone will need to backport his

> > > > +       u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
> > > > +               ? OPAL_TRUE : OPAL_FALSE;

to stable so we can fix up my broken coding in older kernels.


I can do that or, if David wants to do that that's fine... just want to coordinate.







