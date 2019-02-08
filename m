Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE12FC282C2
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 01:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B6C21907
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 01:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBHBl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:41:57 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:45793 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfBHBl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 20:41:57 -0500
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1grvAw-00087y-LO; Thu, 07 Feb 2019 18:41:54 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1grvAv-0008AS-Lg; Thu, 07 Feb 2019 18:41:54 -0700
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id C000A221666;
        Fri,  8 Feb 2019 01:41:52 +0000 (UTC)
Date:   Thu, 7 Feb 2019 20:37:18 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Message-ID: <20190208013718.GA19254@hacktheplanet>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190204145244.GJ31132@infradead.org>
 <alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz>
 <1549586652.11868.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549586652.11868.12.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1grvAv-0008AS-Lg;;;mid=<20190208013718.GA19254@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
X-SA-Exim-Version: 4.2.1 (built Fri, 13 May 2016 17:07:30 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 08, 2019 at 12:44:14AM +0000, Derrick, Jonathan wrote:
> On Thu, 2019-02-07 at 23:56 +0100, David Kozub wrote:
> > On Mon, 4 Feb 2019, Christoph Hellwig wrote:
> > 
> > > On Fri, Feb 01, 2019 at 09:50:17PM +0100, David Kozub wrote:
> > > > From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > > > 
> > > > Enable users to mark the shadow mbr as done without completely
> > > > deactivating the shadow mbr feature. This may be useful on reboots,
> > > > when the power to the disk is not disconnected in between and the shadow
> > > > mbr stores the required boot files. Of course, this saves also the
> > > > (few) commands required to enable the feature if it is already enabled
> > > > and one only wants to mark the shadow mbr as done.
> > > > 
> > > > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > > > Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> > > > ---
> > > >  block/sed-opal.c              | 33 +++++++++++++++++++++++++++++++--
> > > >  include/linux/sed-opal.h      |  1 +
> > > >  include/uapi/linux/sed-opal.h |  1 +
> > > >  3 files changed, 33 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > > > index 4b0a63b9d7c9..e03838cfd31b 100644
> > > > --- a/block/sed-opal.c
> > > > +++ b/block/sed-opal.c
> > > > @@ -1996,13 +1996,39 @@ static int opal_erase_locking_range(struct opal_dev *dev,
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
> > > >  		{ end_opal_session, },
> > > >  		{ start_admin1LSP_opal_session, &opal_mbr->key },
> > > > -		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
> > > > +		{ set_mbr_enable_disable, &token },
> > > > +		{ end_opal_session, },
> > > > +		{ NULL, }
> > > 
> > > This seems to be a change of what we pass to set_mbr_done /
> > > set_mbr_enable_disable and not really related to the new functionality
> > > here, so it should be split into a separate patch.
> > > 
> > > That being said if we really care about this translation between
> > > the two sets of constants, why not do it inside
> > > set_mbr_done and set_mbr_enable_disable?
> > 
> > Hi Christoph,
> > 
> > I agree, this should be split. Furthermore I think I found an issue here: 
> > OPAL_MBR_ENABLE and OPAL_MBR_DISABLE are defined as follows:
> > 
> > enum opal_mbr {
> >  	OPAL_MBR_ENABLE = 0x0,
> >  	OPAL_MBR_DISABLE = 0x01,
> > };
> > 
> > ... while OPAL_TRUE and OPAL_FALSE tokens are:
> > 
> >  	OPAL_TRUE = 0x01,
> >  	OPAL_FALSE = 0x00,
> > 
> > so in the current code in kernel, when the IOCTL input is directly passed 
> > in place of the TRUE/FALSE tokens (in opal_enable_disable_shadow_mbr), 
> > passing OPAL_MBR_ENABLE (0) to IOC_OPAL_ENABLE_DISABLE_MBR ends up being 
> > interpreted as OPAL_FALSE (0) and passing OPAL_MBR_DISABLE (1) ended up 
> > being interpreted as OPAL_TRUE (1). So the behavior is:
> > 
> > OPAL_MBR_ENABLE: set MBR enable to OPAL_FALSE and done to OPAL_FALSE
> > OPAL_MBR_DISABLE: set MBR enable to OPAL_TRUE and done to OPAL_TRUE
> > 
> > Am I missing something here? This seems wrong to me. And I think this 
> > patch actually changes it by introducing:
> > 
> > +    u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
> > +            ? OPAL_TRUE : OPAL_FALSE;
> > 
> > which is essentially a negation (map 0 to 1 and 1 to 0).
> > 
> > I had a strange feeling of IOC_OPAL_ENABLE_DISABLE_MBR behaving 
> > incorrectly when I first tried it. But when I checked later I was not able 
> > to reproduce it - probably originally I tested without this patch.
> > 
> > With regard to the new IOC_OPAL_MBR_STATUS: I find the usage of 
> > OPAL_MBR_ENABLE/DISABLE for this confusing: what should passing 
> > OPAL_MBR_ENABLE do? Should it enable the shadow MBR? Or should it 
> > enable the MBR-done flag? I think the implementation in this patch 
> > interprets OPAL_MBR_ENABLE as 'set the "done" flag to true', thus hiding 
> > the shadow MBR. But this is not obvious looking at the IOCTL name.
> > 
> > What if I introduced two new constants for this? OPAL_MBR_DONE and 
> > OPAL_MBR_NOT_DONE? Maybe the IOCTL could be renamed too - 
> > IOC_OPAL_MBR_DONE? Or is it only me who finds this confusing?
> > 
> > Best regards,
> > David
> 
> Hi David,
> 
> Based on the spec and appnote [1], it does look like sed-opal-temp is
> providing the inverted value for shadow mbr enable:
> 
>         if (cfg.enable_mbr)
>                 mbr.enable_disable = OPAL_MBR_ENABLE;
>         else    
>                 mbr.enable_disable = OPAL_MBR_DISABLE;
> 
> where
> enum opal_mbr {
>         OPAL_MBR_ENABLE = 0x0,
>         OPAL_MBR_DISABLE = 0x01,
> };
> 
> The appnote says as much:
> 3.2.9.4
> Enable the MBR Shadowing feature
> session[TSN:HSN] -> MBRControl_UID.Set[Values = [Enable = TRUE]]
> 0000 00000000 07FE0000 00000000 00000000
> 0010 00000048 00001001 00000001 00000000
> 0020 00000000 00000000 00000030 00000000
> 0030 00000000 00000024 F8A80000 08030000
> 0040 0001A800 00000600 000017F0 F201F0F2
> 0050 0101F3F1 F3F1F9F0 000000F1 00000000
>       ^ ^
> 01: Tiny Atom Token: Name: “Enable”
> 01: Tiny Atom Token: Value: <1> (True)
> 
> In order to keep the userspace interface consistent, I'll ACK your
> change in this patch, unless Scott can fill me in on why this looks
> wrong but is actually right.
> 
> We have 7 bytes in the opal_mbr_data struct we could use for DONE/NOT
> DONE. I'm not sure how to go about keeping it consistent with old uapi,
> although arguably opal_enable_disable_shadow_mbr is already doing the
> wrong thing with DONE and ENABLE so it's low impact.
> 
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>

I don't have a good answer to this right now. I'm going to have to review
this portion of the spec, as well as the implementation to understand what
went wrong.

As for changing UAPI, I know that's usually a no-go, but no one actually
uses this portion of the opal driver as far as I can tell. No distro ships
sed-util, and enabling/disabling the mbr is a one shot deal during initial
bring up. If I had messed up the resume from suspsend portion we wouldn't
be able to change that, as I know people use that. But for this part I think
we'd be okay to do this small modification.

If util-linux, will take a patch for the opal driver, then
we'd be locked in for 5.1 or when ever this lands (as distros would now be
shipping).

Anyway, let me review again whats happened here over the weekend when I have
some free time and mental cycles left to spare.








