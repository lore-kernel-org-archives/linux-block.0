Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B949C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiBVSGc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiBVSGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 13:06:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF017289B
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 10:06:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 20CB61F43529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645553163;
        bh=x6TFpZoVnrWyZOsC7xD4FwaiNsEuXc7kDcAycSAEXw0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IipB9en9Nyx4ijm7dbIh/+YSg6odLXztXKDntHN2eVhVM+YrYCbOri6VzvAWTJ1w0
         R9q+tGjwVCzOfySEU4Gk9m+l95fqhLa3OhC31PXbqHbEJnAbTi/MjzaNgTYESYsvvU
         aoJu9qvvW2i9z3iBZN9lCgdy4jbNgb3q+U9oqqr45amsLSlEetXkXAM+qrFWWZhT7s
         RgdTb4Np7MShNCz5A4J/DY3mn/+sijVz/BR/YX80MKDiyUlvjBqad1jEzk7Sz85E+v
         LDZI4IvBhzvsZxyEIZpyDmxgPf7UvGuqyQEULQgdGZR/0w+kJXkpKUa8Tol8YnMWFx
         Ytab5A4QTCB6A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Organization: Collabora
References: <87tucsf0sr.fsf@collabora.com>
        <986caf55-65d1-0755-383b-73834ec04967@suse.de>
        <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
Date:   Tue, 22 Feb 2022 13:05:59 -0500
In-Reply-To: <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me> (Sagi
        Grimberg's message of "Tue, 22 Feb 2022 16:46:26 +0200")
Message-ID: <87bkyyg4jc.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> writes:

>> Actually, I'd rather have something like an 'inverse io_uring', where
>> an application creates a memory region separated into several 'ring'
>> for submission and completion.
>> Then the kernel could write/map the incoming data onto the rings, and
>> application can read from there.
>> Maybe it'll be worthwhile to look at virtio here.
>
> There is lio loopback backed by tcmu... I'm assuming that nvmet can
> hook into the same/similar interface. nvmet is pretty lean, and we
> can probably help tcmu/equivalent scale better if that is a concern...

Sagi,

I looked at tcmu prior to starting this work.  Other than the tcmu
overhead, one concern was the complexity of a scsi device interface
versus sending block requests to userspace.

What would be the advantage of doing it as a nvme target over delivering
directly to userspace as a block driver?

Also, when considering the case where userspace wants to just look at the IO
descriptor, without actually sending data to userspace, I'm not sure
that would be doable with tcmu?

Another attempt to do the same thing here, now with device-mapper:

https://patchwork.kernel.org/project/dm-devel/patch/20201203215859.2719888-4-palmer@dabbelt.com/

-- 
Gabriel Krisman Bertazi
