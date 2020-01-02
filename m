Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59DCC3276D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C121655
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="NISew5di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgABJUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:20:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43063 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgABJUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 04:20:20 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so36137308ioo.10
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbUMnEhVONcUmTCG15aMUc7YiHySA5edf1F2K8qXpwQ=;
        b=NISew5diJ/aBKZxasMIUwOzyPWudSlvP8zgOWJPV/DgnuW/8IDiT0Qhuz1AGUS9Jdo
         Wp9Om8LgUWEgGDa/8ZcmupRSjFxK1wwDT7+HTihMHnkbBVPmywXxKECIhHQ/FgobD25J
         tZK+4HLJy3ZNhokZ8XHscenXNrsrptr0cOK7skYsLjs2OYrHTHf6tZAnXvDyqrZr8WrL
         AIIE2zdYcr+a/rGloxFKDXMom9XsJzcFWd5ONH1GEbBJAU144YCf9HJgX+ayYj2NWkJz
         oNUyLy8S+3b6vh3Jm58kTOnpJpQM17+GCDc7hOI2Zne6MOL9EA1mIztHpv7wBxEL7VIc
         lb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbUMnEhVONcUmTCG15aMUc7YiHySA5edf1F2K8qXpwQ=;
        b=m5+Z2Y1M4l9vfW6/YjRBQhzetD4zRk7wq1jAoic6Iw7lvQxgwZJewpWJ8E+QUh94hN
         mYNkjCm3A+WGmlQthjtHTVRw2mR5lpF50gNxKkFHnGMvyhihftdAt6mUAzX52qQEvis6
         C3ppGRsQHASitUjht7Xf0P9v+SzDW6zB7RE3QYwGe7SgY7GGItNK5dFR07DvGyTVS70W
         my7GhVjZlRHeqObuzyprp+dy2IO3U+GXBSF6UFV89r2bs7w5TWAS8GIaaMCfY7/wZcoy
         hS2S4g/p88NVcf6hKlJyYA4S0ZJpAv6bIldpZJZ/ZJvQ2CsTT0A5PEWAI8Hs+fFo+hsI
         9plw==
X-Gm-Message-State: APjAAAUsfcKHTjjSnGBWUTl9897CXl/UKl4Njuwia2GmalkrVQvDO0gR
        Tw+4S6QgmMN0yRy7IQADICUBRzmDMLPXAVF88XefkQ==
X-Google-Smtp-Source: APXvYqyzBxl/QOWIAJrGW58UMnRiCgH15za7UccEuZ0hzX8YPObCcr18f+7efhszbjjY+fE3HcHXD3YIlrMCCsA/0Zs=
X-Received: by 2002:a5e:c606:: with SMTP id f6mr14388153iok.71.1577956819160;
 Thu, 02 Jan 2020 01:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
In-Reply-To: <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 10:20:08 +0100
Message-ID: <CAMGffEkrL44tuGd8CB4o_F30QNnQez4fZ46dazD+BOBBp0tNbA@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and
 RNBD (former IBNBD) rdma network block device
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 3:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > here is V6 of the RTRS (former IBTRS) rdma transport library and the
> > corresponding RNBD (former IBNBD) rdma network block device.
> >
> > Changelog since v5:
> > 1 rebased to linux-5.5-rc4
> > 2 fix typo in my email address in first patch
> > 3 cleanup copyright as suggested by Leon Romanovsky
> > 4 remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
> > 5 add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
>
> Please always include the full changelog when posting a new version.
> Every other Linux kernel patch series I have seen includes a full
> changelog in version two and later versions of its cover letter.
Sorry, it was my mistake, will include the full changelog next time.
>
> Information about how this patch series has been tested would be
> welcome. How big were the changes between v4 and v5 and how much testing
> have these changes received? Was this patch series tested in the Ionos
> data center or is it the out-of-tree version of these drivers that runs
> in the Ionos data center?
As mentioned in the v5 cover letter, the changes between v4 and v5
"'
 Main changes are the following:
1. Fix the security problem pointed out by Jason
2. Implement code-style/readability/API/etc suggestions by Bart van Assche
3. Rename IBTRS and IBNBD to RTRS and RNBD accordingly
4. Fileio mode support in rnbd-srv has been removed.

The main functional change is a fix for the security problem pointed out by
Jason and discussed both on the mailing list and during the last LPC
RDMA MC 2019.
On the server side we now invalidate in RTRS each rdma buffer before we hand it
over to RNBD server and in turn to the block layer. A new rkey is generated and
registered for the buffer after it returns back from the block layer and RNBD
server. The new rkey is sent back to the client along with the IO result.
The procedure is the default behaviour of the driver. This invalidation and
registration on each IO causes performance drop of up to 20%. A user of the
driver may choose to load the modules with this mechanism switched off
(always_invalidate=N), if he understands and can take the risk of a malicious
client being able to corrupt memory of a server it is connected to. This might
be a reasonable option in a scenario where all the clients and all the servers
are located within a secure datacenter.

Huge thanks to Bart van Assche for the very detailed review of both RNBD and
RTRS. These included suggestions for style fixes, better readability and
documentation, code simplifications, eliminating usage of deprecated APIs,
too many to name.

The transport library and the network block device using it have been renamed to
RTRS and RNBD accordingly in order to reflect the fact that they are based on
the rdma subsystem and not bound to InfiniBand only.

Fileio mode support in rnbd-server is not so efficent as pointed out by Bart,
and we can use loop device in between if there is need, hence we just
removed the fileio mode support.
"'
Regarding testing, all the changes have been tested with our
regression tests in our staging environment in IONOS data center.
it's around 200 test cases, for both always_invalidate=N and
always_invalidate=Y configurations.

I will mention it in the cover letter next time.

Thanks for your comments, Bart.
>
> Thanks,
>
> Bart.
