Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A539C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 01:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506822076A
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589593208;
	bh=CrQSqVcXyXcpUeO9jqEtUIojA+IlBVFSMmxcqh7aAeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KNIn1ObbVHb4/Qu9ndqjSZvCdfhAYQ/iWnLuk7Yj1wK4KQr3iVMHmVBjcQ4UjsEzZ
	 6ks+84kY6jGxaNAm6L/7usp6cVYyHBm23xnwSLBPWooF1wt0rp/hh6p8xW5Ogk4Ut9
	 6jaS1duUajW7ANPMeaIbKKYvU65Ea9u3Kyl1iFns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEPBkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 21:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgEPBkH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 21:40:07 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86901207C4;
        Sat, 16 May 2020 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589593206;
        bh=CrQSqVcXyXcpUeO9jqEtUIojA+IlBVFSMmxcqh7aAeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cSlJChEPn9tokMbDKlEqAW4wizlqdgD60I2U+gwh8F1H4v0hqa40A2VCxiyroFduX
         vIiNzPhX9XpQuo3Dnps88ojyTUqASpZUaZ9i0621+yQdD0k7jhksZQCkssn8l/KE5M
         GXaZK7GC0nV2B0/x38EC954SB3oVy2KNMCCUxIfs=
Received: by mail-vk1-f171.google.com with SMTP id p7so1085558vkf.5;
        Fri, 15 May 2020 18:40:06 -0700 (PDT)
X-Gm-Message-State: AOAM532S6QNuCXZJypsR6s09TSgWlQOg3OgFgMvp6zl80W0qB7gqSUZJ
        BzyN8A8tEvfCu+MFvV0OMziyCRRcHjowvhgYL28=
X-Google-Smtp-Source: ABdhPJy/TNRRchVgh7/X0CJvCfGZI0vrN5WLUnFbW6V2DhjJpoH3YEqbC2Z6LQXWvVKiVLin1pfQ2PwKRAH9VrOZ1x8=
X-Received: by 2002:a1f:5fc5:: with SMTP id t188mr4836002vkb.34.1589593205572;
 Fri, 15 May 2020 18:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200509031058.8239-1-mcgrof@kernel.org> <20200509031058.8239-5-mcgrof@kernel.org>
 <e728acea-61c1-fcb5-489b-9be8cafe61ea@acm.org> <20200511133900.GL11244@42.do-not-panic.com>
In-Reply-To: <20200511133900.GL11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 15 May 2020 19:39:53 -0600
X-Gmail-Original-Message-ID: <CAB=NE6X-RaP2Qbfi5J23EdsVDTUys6AuYT7g6QDtCt=d5-GZ9w@mail.gmail.com>
Message-ID: <CAB=NE6X-RaP2Qbfi5J23EdsVDTUys6AuYT7g6QDtCt=d5-GZ9w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] blktrace: break out of blktrace setup on
 concurrent calls
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, yu kuai <yukuai3@huawei.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 11, 2020 at 7:39 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Sat, May 09, 2020 at 06:09:38PM -0700, Bart Van Assche wrote:
> > How about using the block device name instead of the partition name in
> > the error message since the concurrency context is the block device and
> > not the partition?
>
> blk device argument can be NULL here. sg-generic is one case.

I'm going to add a comment about this, as it is easily forgotten.

  Luis
