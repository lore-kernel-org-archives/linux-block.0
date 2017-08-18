Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34841 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdHRIFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 04:05:43 -0400
Received: by mail-yw0-f174.google.com with SMTP id n83so26868675ywn.2
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 01:05:43 -0700 (PDT)
Date: Fri, 18 Aug 2017 01:05:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>, Karel Zak <kzak@redhat.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
Message-ID: <20170818080539.GI2459@vader>
References: <cover.1503036471.git.osandov@fb.com>
 <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
 <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de>
 <20170818073838.GG2459@vader>
 <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de>
 <20170818074700.GH2459@vader>
 <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 18, 2017 at 09:56:26AM +0200, Hannes Reinecke wrote:
> On 08/18/2017 09:47 AM, Omar Sandoval wrote:
> > On Fri, Aug 18, 2017 at 09:43:19AM +0200, Hannes Reinecke wrote:
> >> On 08/18/2017 09:38 AM, Omar Sandoval wrote:
> >>> On Fri, Aug 18, 2017 at 09:18:52AM +0200, Hannes Reinecke wrote:
> [ .. ]
> >>>> I've got quite some flak for daring to break existing interfaces, most
> >>>> notably setting logical and physical blocksize per default (which I
> >>>> would _love_ to have done, seeing that it really makes sense here).
> >>>> But as this would change the behaviour I've gone through pains (and
> >>>> several _years_ of iterations) to get this sorted.
> >>>>
> >>>> So if you  design a blocktest for that ensure that
> >>>> a) the sysfs attributes before and after the patch are _identical_
> >>>> b) the sysfs attributes will only change if the 'LO_FLAGS_BLOCKSIZE'
> >>>> flag has been set
> >>>> and
> >>>> c) validate the written blocksizes; this is required to be able to
> >>>> install bootloaders there
> >>>>
> >>>> This whole interface was designed such that you can prepare bootable
> >>>> diskimages for S/390 DASDs, which use a native 4k blocksize.
> >>>
> >>> Hi, Hannes,
> >>>
> >>> Wasn't insulting you at all, the only part of the interface I'm
> >>> complaining about is LOOP_GET_STATUS missing information :)
> >>>
> >> Sure. Just saying.
> >> But please make sure only to return that information if the
> >> LO_FLAGS_BLOCKSIZE flag is set; otherwise there's a rick of confusing
> >> losetup.
> > 
> > I actually checked losetup, it works just fine with LO_FLAGS_BLOCKSIZE
> > always set and lo_init[0] always filled in.
> > 
> The original argument I had with the util-linux maintainer did not
> revolve so much around technical details :-)

Karel, what were your concerns here?
