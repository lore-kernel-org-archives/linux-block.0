Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E27FC282DA
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 01:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4B217FA
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 01:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9dfHNWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfDRBFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:05:51 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37790 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRBFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 21:05:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id w10so703901wrm.4
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ilo5fGIxOu4CERHfFXgKCQ3zsRDdd6H5dSxVkJcmWY=;
        b=R9dfHNWaLXVzgfjzB3fcOcy6KCTZasXFz1n/qR9mRjEyX6E/sPmem2NPs7Uan3CzgK
         hFN5Ht9hURDw9P3pVJQQaLPyNgnxLeYHzfy84mIWFqCNCobacMV7UB5PbYdzq2vcP3Zx
         5QQkaN6UKNF4pv7+77OI52i68En8l/L+bdFhgoik0ceaNSqPv9L3R2Oq/T60EgFx7WN2
         2lzf/h8FZgsa3LXDhn3zowECG6jEqwdvH6eP5z+jS51CguF9N5lg4Q5dNn5kmDb6w0no
         wf+MIq/j0u70IzEIViqpbUERhANh17e7av8Rs6jc4+nR37wBoJzggGkSC5TZ8EKYhUYs
         Yc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ilo5fGIxOu4CERHfFXgKCQ3zsRDdd6H5dSxVkJcmWY=;
        b=fhOPbcHeHF9goEAhQ6RsO5JaxJ+Sxo6is4NFU5r5SaUlyK5zHHNgPJYgFEekj+Zs14
         C0N4Ws6vVGUwjXSBL3h+PdEZb4lQ/WZ23fB0sTVMHxBixBkecuplH4PnRWTIKrhixyAE
         BHMu3ZwAbRTxILSdCdSXd9RPCcX9wP7GGHSg45T9YAefIuz76ibFadAuPsp46VO1wSKP
         HubgLPpoEVycMxXbqGVIHwx4Y3FAtp6ijJbQyr1fdYDpi/YhG5AAGQqoDU57//3zn7nr
         z4eH9uNqzECNLwiNPkyMNrx+MUNYD5V5j2oKz1CvTri2c2Mn25qHXkMI5egkd7CcuFZI
         CsEg==
X-Gm-Message-State: APjAAAX7EUZVnVV2SKYIpCU9r/ybFPoF0WTW6tKk1REHbHkgoRCITFk9
        zJTeUEHhJQXALBdvQpLbOsc3TwQwBa7cfy/7h1E=
X-Google-Smtp-Source: APXvYqxIDtU24Y5NweWoUW6matb9qPzJ1YShZsAFuss+8a1HOXUbVEw7lcMsG9IrshDsfX/jrYgzORY59dWUA9xX8DM=
X-Received: by 2002:a5d:4750:: with SMTP id o16mr5905006wrs.206.1555549549402;
 Wed, 17 Apr 2019 18:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de> <CACVXFVPKHUgbgsbFZSDWqF7GTPyBzKJjKCSq7EYygre_GvpbyQ@mail.gmail.com>
 <2fbeba35-38f3-22cf-a4d5-49f8af5e6802@web.de> <39218225-a402-fb3a-dbc6-db2d95e51bd3@suse.de>
 <7a49ec14-5f46-1b7c-3311-83fdaa5b1761@web.de>
In-Reply-To: <7a49ec14-5f46-1b7c-3311-83fdaa5b1761@web.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 18 Apr 2019 09:05:37 +0800
Message-ID: <CACVXFVNU_+rX2XA+t+Ac+Wu_+n3u=aWmk0rDhj7zJv9x7iP8pQ@mail.gmail.com>
Subject: Re: Adding QCOW2 reading/writing support
To:     Manuel Bentele <manuel-bentele@web.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 18, 2019 at 5:04 AM Manuel Bentele <manuel-bentele@web.de> wrote:
>
> On 17.04.19 14:16, Hannes Reinecke wrote:
> > On 4/17/19 1:32 PM, Manuel Bentele wrote:
> >> Hi,
> >>
> >> On 17.04.19 03:35, Ming Lei wrote:
> >>> Hi,
> >>>
> >>> On Wed, Apr 17, 2019 at 5:33 AM Manuel Bentele
> >>> <manuel-bentele@web.de> wrote:
> >>>> Hi everyone
> >>>>
> >>>> I'm going to implement an in-kernel reading of QCOW2 images.
> >>>> In the project, I only need the reading of QCOW2 images, but it's
> >>>> essential to make thoughts for the implementation of the writing, too.
> >>>> One of the difficulties seems to be the support of making an image
> >>>> sparse (resizing the disk image).
> >>> Could you describe this requirement in a bit more detail? Especially
> >>> why
> >>> do you want to read/write QCOW2 in kernel?
> >>
> >> Yes, of course. The implementation of reading a QCOW2 disk image
> >> in-kernel is required for an already existing system in the university
> >> environment.
> >> At the moment, the Linux kernel, initramfs, etc. for each client in the
> >> system is loaded via PXE boot and then the block device with the default
> >> file system is included with the help of a modified nbd version, called
> >> dnbd (distributed nbd).
> >> Due to the fact that the data on the default file system is only for non
> >> persistent one-time provision of a client, read access is sufficient.
> >> The user related data is stored on a network storage, as mostly done in
> >> large scale infrastructures.
> >>
> >> Now, the goal is to minimize the network usage and avoid nbd.
> >> Furthermore, fixed configured and packed boot images should be avoided.
> >> Therefore, the advantage of the sparse and compression functionality of
> >> QCOW2 should be used.
> >> A workaround for that problem could be the local usage of nbd to include
> >> the QCOW2 disk image as block device, but it involves a lot of
> >> interaction between user and kernel space and thus an decreasing
> >> performance. That leads to the motivation to implement the reading of
> >> QCOW2 disk images directly in the kernel and aim for an merge into the
> >> mainline kernel source to avoid out-of-kernel-tree maintenance.
> >>
> >> If you have any questions related to the described use case or if you
> >> require more information, please let me know.
> >> Thanks for your help.
> >>
> > cramfs?
> > Or btrfs with compression enabled?
> >
> > Cheers,
> >
> > Hannes
>
> Thanks for your simple idea to choose cramfs or btrfs with compression
> enabled.
> I will suggest that as alternative at the next project meeting.

Or vdo which provides compression in block device level:

https://github.com/dm-vdo/vdo


Thanks,
Ming Lei
