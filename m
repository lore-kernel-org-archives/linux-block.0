Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A617C3F2D7
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5162146E
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="d9zKSr3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCELkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:40:17 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:42702 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCELkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 06:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1583408416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rWfFlcPyjHJXPAlfpsMYZNMKC3g+tqMBgYd0nwObWMs=;
  b=d9zKSr3nr7qt5+8NdOfQpeIv7eocLEiHe9+mt8ugTUt7wbneemwc1Inl
   +wiy/mFm4j8U7e9bVvYonNAYpQOT70+9jnKUMtXw1jv1spplneVSmoq5U
   EujuM1CPJTQ/zVNTZPHMpme63U5iXwxmpQ/6Fw8i4DMNp+av9AZn7ntLZ
   o=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: IvvKxSg4dbeFbcCMb8mQg2hmNKN1dHBlv+hvJ5k3KFzLFrCUo54nSohVm1Nj9rwnVth2BJNI2x
 JPI6ajaUbFkFZkjmq5ELJNIuDQnJREtod5GEE0DAVNLzS2QjoYqf39Aqrjh5n4i0ckGXafk57+
 2o2KJs1bj6VUCj/ZnsetHXwDt6gEzKRo39oFksYnKVKsFne/J+GIhh9stUxLlPpJcGbu7AM9YR
 1f8O2R+xmwDcisfR2+SyZ8jIV2Hect5f8YyO0WH5ivNcnTuhJnwG5NSsUkSOn7qV4JsNMBVpAT
 mXA=
X-SBRS: 2.7
X-MesageID: 13798198
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,517,1574139600"; 
   d="scan'208";a="13798198"
Date:   Thu, 5 Mar 2020 12:40:10 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] xen/blkfront: fix ring info addressing
Message-ID: <20200305114010.GV24458@Air-de-Roger.citrite.net>
References: <20200305100331.16790-1-jgross@suse.com>
 <20200305104935.GU24458@Air-de-Roger.citrite.net>
 <20915d12-665e-bd23-2685-d2ec7e015679@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20915d12-665e-bd23-2685-d2ec7e015679@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 05, 2020 at 12:04:27PM +0100, Jürgen Groß wrote:
> On 05.03.20 11:49, Roger Pau Monné wrote:
> > On Thu, Mar 05, 2020 at 11:03:31AM +0100, Juergen Gross wrote:
> > > Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
> > > actual use case") made struct blkfront_ring_info size dynamic. This is
> > > fine when running with only one queue, but with multiple queues the
> > > addressing of the single queues has to be adapted as the structs are
> > > allocated in an array.
> > 
> > Thanks, and sorry for not catching this during review.
> > 
> > > 
> > > Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   drivers/block/xen-blkfront.c | 82 ++++++++++++++++++++++++--------------------
> > >   1 file changed, 45 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > > index e2ad6bba2281..a8d4a3838e5d 100644
> > > --- a/drivers/block/xen-blkfront.c
> > > +++ b/drivers/block/xen-blkfront.c
> > > @@ -213,6 +213,7 @@ struct blkfront_info
> > >   	struct blk_mq_tag_set tag_set;
> > >   	struct blkfront_ring_info *rinfo;
> > >   	unsigned int nr_rings;
> > > +	unsigned int rinfo_size;
> > >   	/* Save uncomplete reqs and bios for migration. */
> > >   	struct list_head requests;
> > >   	struct bio_list bio_list;
> > > @@ -259,6 +260,21 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
> > >   static void blkfront_gather_backend_features(struct blkfront_info *info);
> > >   static int negotiate_mq(struct blkfront_info *info);
> > > +#define rinfo_ptr(rinfo, off) \
> > > +	(struct blkfront_ring_info *)((unsigned long)(rinfo) + (off))
> >                                        ^ void * would seem more natural IMO.
> > 
> > Also if you use void * you don't need the extra (struct
> > blkfront_ring_info *) cast I think?
> 
> Yes, can change that.
> 
> > I however think this macro is kind of weird, since it's just doing an
> > addition. I would rather have that calculation in get_rinfo and code
> > for_each_rinfo on top of that.
> 
> I wanted to avoid the multiplication in the rather common
> for_each_rinfo() usage.

Can you undef it afterwards then? I don't think it's supposed to be
used by the rest of the file.

> 
> > 
> > I agree this might be a question of taste, so I'm not going to insist
> > but that would reduce the number of helpers from 3 to 2.
> > 
> > > +
> > > +#define for_each_rinfo(info, rinfo, idx)				\
> > > +	for (rinfo = info->rinfo, idx = 0;				\
> > > +	     idx < info->nr_rings;					\
> > > +	     idx++, rinfo = rinfo_ptr(rinfo, info->rinfo_size))
> > 
> > I think the above is missing proper parentheses around macro
> > parameters.
> 
> rinfo and idx are simple variables, so I don't think they need
> parentheses. info maybe. But just seeing it now: naming the
> parameter "rinfo" and trying to access info->rinfo isn't a good
> idea. It is working only as I always use "rinfo" as the pointer.

Dereferences of info and the increase of idx should have parentheses
IMO.

You could rename the rinfo parameter to entry or some such.

> > 
> > > +
> > > +static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,
> > > +					    unsigned int i)
> > 
> > inline attribute might be appropriate here.
> 
> See "the inline disease" in the kernel's coding style.

This function has two lines, so I think it's suitable to be inlined:
"A reasonable rule of thumb is to not put inline at functions that
have more than 3 lines of code in them"

I bet the compiler would do this already, but I think adding inline
here is fine according to coding style.

Thanks, Roger.
