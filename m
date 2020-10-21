Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237BBC388F9
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DA62242F
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 17:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DVzkzBJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503718AbgJURsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503716AbgJURsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 13:48:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31080C0613CF
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2020 10:48:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l16so3471777eds.3
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2020 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
        b=DVzkzBJthtEEE9BytDByy1Zyi6AvIrMMfqilJKnpXorOKZpcoMkmRc0+51O1rnlt68
         bMY0od0cPkgr22Fq/K+EKbRk9QUUZlKvr9mGhIHdkRS+RFdmguKEoaDMpwVT2MTekysU
         aICew+9IVF+RRyoiu/PaGJVFHpxpM2ZfnviDOpSraD9hqMuMque7/usM9pzF/eaK9iyi
         qZF3JdUTjmf2nLs5oVUYf43A1aDD3wYoYI9oxDRZY55ia14p0XqJNtzi/CDl0A92VIsH
         Ytn7i5HZw9HsfFtKjUgs2Sf+IlYn4ti3aGTMDIrNugvXoKAtZI0M50rVaCu67NNkO/yB
         jfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
        b=jOQmR3p0/j4ZSLDsR3I1jro1dHGaK5QnqlXXqQa9xQaCYWUUcGT3incGkLQ16/gnDk
         SnEw8wnzI+7vIYxqLd7lfrNKQPQ/2KEo6yauMYk7z0dGPSrvi9qUoMDiG9C/osUKOf8J
         ig7b7SiPUJpDPOZeLaxTBgimHfsYNIvcYMCcM1RlYljwFZoRcadtwqwlesQAxdbMSf6I
         s+S56siQPkXtpY1+KnCQE1xcgtmDYqrFgvSFLtFbNI/1IPeHIO9fI6UQbXEhiPj8HKrd
         YRpCyEdpPwhFAcf1V987uFw8Ic1f3bgl+D+nVPWnpMbu0chpyyP5KQC1kj5r2j2g2uLu
         D+Jw==
X-Gm-Message-State: AOAM533AH58NiY7t9DzwzKj87MxJSk9M1sW5AwNHP/mzOXheW+TZ7j/e
        VGyADeh1pz5peWghQTaC3sDGBc/Gs5MkQJ93R05SXA==
X-Google-Smtp-Source: ABdhPJyjfO8m3iOuqLFtlf+FomXd1BC4F7cQcApVrqZXlZQ1jUukEoyZcjOKoq++KT+r97hpdUtXqWK1yOAZ0wQ8O8o=
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr4292662edb.210.1603302515911;
 Wed, 21 Oct 2020 10:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com> <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Oct 2020 10:48:24 -0700
Message-ID: <CAPcyv4gOGi392Q3knF=cAuvKONnmp2AoKX82VQEQJU0c7o7AKA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 21, 2020 at 10:11 AM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Tuesday, October 20, 2020 3:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >     What does Linux get from merging mpool?
> >
>
> What Linux gets from merging mpool is a generic object store target with some
> unique and beneficial features:

I'll try to make the point a different way. Mpool points out places
where the existing apis fail to scale. Rather than attempt to fix that
problem it proposes to replace the old apis. However, the old apis are
still there. So now upstream has 2 maintenance burdens when it could
have just had one. So when I ask "what does Linux get" it is in
reference to the fact that Linux gets a compounded maintenance problem
and whether the benefits of mpool outweigh that burden. Historically
Linux has been able to evolve to meet the scaling requirements of new
applications, so I am asking whether you have tried to solve the
application problem by evolving rather than replacing existing
infrastructure? The justification to replace rather than evolve is
high because that's how core Linux stays relevant.
