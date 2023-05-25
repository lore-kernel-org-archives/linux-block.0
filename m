Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD937C77B73
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 03:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEYDYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 23:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjEYDYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 23:24:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4339187
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:24:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514454733b8so41902a12.3
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684985045; x=1687577045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WklgreaJr1H5odWwHdyB/w+TbDccazM/HUlb5QQjx0M=;
        b=k8D+Ctr2My6uDddVO7VRvePAcddA3tuz+tJIIUNiDvSNQ9HwhI+M0J0HJJqcgTyK5B
         Hae3tW8/HysNcaIeI0QhF5Sg1SPUz4i3uYtxt5pV1RBa7OEGNUfYUUmOhOrRZFAUlsjY
         u+h6vc9buaouJKvj54gPvsS9xG06C/k8bzeEWDUPPBf6wDzYpJIBSpHYn9517bh5ZeKU
         aSluocHV0SShgslkvyd+FoC7wIJiBie9RrGU1vEZT7GhAkaqrqIDm3OeuHSsPxispX98
         5Zl5r0MpQq6di/wYdgDf1lHlTGvWyMcpyEQXz4qAyEj4T+4tf6S77PqfEm/CTRCxi17q
         9SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684985045; x=1687577045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WklgreaJr1H5odWwHdyB/w+TbDccazM/HUlb5QQjx0M=;
        b=a3DgsDXMgrX0idbvy6dJRJqzPywZRnfcxdAlgiqrDshbquxkyWtiWrYW87xvd8J/ND
         m0mGvaOYuX/Pv00QB33qVHD2qAqi1BJOxG9JXKzlky7UB9VdxkbwyGn/cglwp/deGWK4
         T9mMn8D/U1hjcM9exUMa7U4YFwE6vRs384LmSIcJSef693ecv6kT5/IP1Xv8X5jJdCOc
         xOOMtIMjy87DhmAcjpHcl18/vRxJzCtccoaTszs9FJe4qmgAnee5lemdofzDNyo9t431
         dme0d32Piq0GqIj0xcBtn6pTUe01vb9xCN5TSawrUnnZYAtbT5ynw4VyXT0VmEPeF39T
         kVhw==
X-Gm-Message-State: AC+VfDxR4KSl5SCB1fcPA1fHVbJ4iZoEwT+Nz5881qB4W6wosyo6grjq
        IkPDDXlhIvhStfCkBH2ZLtEvNu8r6wz3l8GZHaTj3A==
X-Google-Smtp-Source: ACHHUZ4lfnPF2dq04PpDs4/bfnXkd4kXRJIfGYwm+uz6G83V5d6JzqwqbarDi4lRQrRCTqM6ffsN34rZ36VRW5Wavo8=
X-Received: by 2002:a17:907:25c3:b0:96b:e92:4feb with SMTP id
 ae3-20020a17090725c300b0096b0e924febmr127116ejc.60.1684985045105; Wed, 24 May
 2023 20:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230524035150.727407-1-ming.lei@redhat.com> <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com> <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com> <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com> <CAJD7tkYfwVSNrTibnv5BpyAfbyY0dnK0Cp-HQK_-2nxHmveAxw@mail.gmail.com>
 <9b06dceb-f26d-7faf-460c-ba554a0757ef@redhat.com> <25b603a5-8da6-af8c-93f0-5c0e81a2eb0b@redhat.com>
In-Reply-To: <25b603a5-8da6-af8c-93f0-5c0e81a2eb0b@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 24 May 2023 20:23:28 -0700
Message-ID: <CAJD7tkZz4MY5kuU7C0H5vFanR9QrXssgCsoRaqjWbAjTeTKATA@mail.gmail.com>
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
To:     Waiman Long <longman@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 8:11=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 5/24/23 23:04, Waiman Long wrote:
> >> Hi Waiman,
> >>
> >> I don't have context about blkcg, but isn't this exactly what
> >> cgroup_rstat_lock does? Is it too expensive to just call
> >> cgroup_rstat_flush () here?
> >
> > I have thought about that too. However, in my test, just calling
> > cgroup_rstat_flush() in blkcg_destroy_blkgs() did not prevent dying
> > blkcgs from increasing meaning that there are still some extra
> > references blocking its removal. I haven't figured out exactly why
> > that is the case. There may still be some races that we have not fully
> > understood yet. On the other hand, Ming's patch is verified to not do
> > that since it does not take extra blkg references. So I am leaning on
> > his patch now. I just have to make sure that there is no concurrent
> > rstat update.
>
> It is also true that calling cgroup_rstat_flush() is much more
> expensive, especially at the blkg level where there can be many blkgs to
> be destroyed when a blkcg is destroyed.

I see. For what's it worth, consequent flushes on the same cgroup
should be fast since the first flush should remove it from the rstat
updated list (unless updates come from another css on the same cgroup
while the blkgs are being destroyed).

I am assuming in this case we are sure that the cgroup does not have
children, otherwise we need to flush them as well, not just the
cgroup, so calling __blkcg_rstat_flush() directly might not be a
viable option.

Perhaps we can add an API to cgroup rstat flushing that just
holds/releases the rstat lock, to avoid adding one extra lock on the
blkcg side that does the same job.

Alternatively, we can have a version of cgroup_rstat_flush() that only
flushes one subsystem; but then we will have to iterate the cgroups on
the rstat updated tree without popping them. Another approach would be
to split the rstat updated tree to have one per-subsystem so that they
don't slow each other down; but then we need to figure out what to do
about base stat flush and BPF flushing. Just thinking out loud here :)

>
> Cheers,
> Longman
>
