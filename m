Return-Path: <SRS0=/Ic2=3Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D6C32771
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 10:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C7207FD
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 10:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twSPjZF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgA0K3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:29:45 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41174 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgA0K3p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 05:29:45 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so9353569ioo.8;
        Mon, 27 Jan 2020 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8smK5gP/nG8y3xUOFyqTowNi76jCKan8I/IqaA550Jg=;
        b=twSPjZF9ERl+JtZ2Bc4n4yjkQk5mMc4TsfSxeJr9KDsyIFWxepqNAThfwYS65+IXOt
         jI/1+1lZK8zEBOfJyr0+UvaK3RLccBVS3Ox0U/8aT0CBNdtZ88VD/LCKHVGiFNQ4udCE
         kBI3ja2Oj+crzFVqiVy1QvRGZO/eoqQIj5z5IiC0nkw1rpQahkaeoxuxBeU4Sg3+YDkL
         aC2bCoF7ApODxKGTcehoqAO5gc+0UuZS0UEzPPQp5eSnYwrsT6kz+GRp+n2F2vkoKevf
         eHHkOkc8tSjeWtg6Nl6/nTAC3MWmgK353VtaxvEUKCB8iIWcC5iVpV3f2f2Qm1psTvTz
         XgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8smK5gP/nG8y3xUOFyqTowNi76jCKan8I/IqaA550Jg=;
        b=FQQZY67Q0cGEg0hJqWdeHIWeKgDaoPz0iHpmzbnX5TVp/5VHAImXFVxeCN19AAOOer
         I/vLY8eo2dw0o8KTlbiSekuS9KGpoK6Q4xyuM1F9DqRvxWELgzMgRjwV6fzKmylt0VU6
         zpnbTS7LLO67VcMZMPsci2jbmhTGQaG5PUySMf4vUx8mP1lOmkEfMkEw+EVlAcZn+Q9L
         iDhMcZvAzjM7uqzOeaCyZMuzhfHtD99FKegFQ/cY6tWnOsjjzlPChHfHHhfw26zmD/7k
         8UqEdFwOwhuSESNnkeb1ONhLm+xxYalBcZHFeTTnOJ3kY3wH2k3/s9gzRtxI03NcfJOG
         3LVg==
X-Gm-Message-State: APjAAAW9YnO+PdS90UUwdbMoz2luOSWKORFzoqZpmgBLzBJWW1TH0Vaa
        vjQkQWyE2Cv1IPzXYrY8Nv+QWG52Qu0WoPxGSvk=
X-Google-Smtp-Source: APXvYqz7T+0EXbGyk0YeoKw4pqZFx7gtTJf9iDx40rHzqrhnP/ctayEi2YiUa++d6yOSehAyi6xD+/g8bggsPJfYE2Q=
X-Received: by 2002:a6b:17c4:: with SMTP id 187mr11646757iox.143.1580120984691;
 Mon, 27 Jan 2020 02:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20200123124433.121939-1-hare@suse.de> <CAOi1vP8Q44jLNoq+LTm8GRX687wfwLkJ3WRW_DWvY7nYUtPQxQ@mail.gmail.com>
 <fe3fcf53-94fb-84b8-75ed-6375d81e1452@suse.de>
In-Reply-To: <fe3fcf53-94fb-84b8-75ed-6375d81e1452@suse.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 27 Jan 2020 11:29:51 +0100
Message-ID: <CAOi1vP85wu8R3h2pQ7wt2udtwbTgbHq25_cxvQD+zwU0UCW+hw@mail.gmail.com>
Subject: Re: [PATCH] rbd: set the 'device' link in sysfs
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        David Disseldorp <ddiss@suse.com>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 24, 2020 at 8:03 AM Hannes Reinecke <hare@suse.de> wrote:
>
> On 1/23/20 7:45 PM, Ilya Dryomov wrote:
> > On Thu, Jan 23, 2020 at 1:44 PM Hannes Reinecke <hare@suse.de> wrote:
> >>
> >> The rbd driver already provides additional information in sysfs
> >> under /sys/bus/rbd, so we should set the 'device' link in the block
> >> device to reference this information.
> >>
> >> Cc: David Disseldorp <ddiss@suse.com>
> >> Signed-off-by: Hannes Reinecke <hare@suse.com>
> >> ---
> >>  drivers/block/rbd.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> >> index 9f1f8689e316..3240b7744aeb 100644
> >> --- a/drivers/block/rbd.c
> >> +++ b/drivers/block/rbd.c
> >> @@ -6938,7 +6938,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
> >>         if (rc)
> >>                 goto err_out_image_lock;
> >>
> >> -       add_disk(rbd_dev->disk);
> >> +       device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
> >>         /* see rbd_init_disk() */
> >>         blk_put_queue(rbd_dev->disk->queue);
> >
> > Hi Hannes,
> >
> > I looked at this a while ago and didn't go through with the patch
> > because I wasn't sure whether this symlink can point to something
> > arbitrary.  IIRC it usually points a couple of levels up, to some
> > parent.  In the rbd case, this would be a completely different tree:
> > /sys/devices/virtual -> /sys/bus/rbd.
> >
> Yes, this is expected.
> The 'device' link will _always_ point into a different tree; the
> accessor via /sys/block or /sys/bus are assumed to be virtual entries,
> with the 'device' link pointing to the underlying device.
> In our case the underlying device is also a virtual entity, but that's okay.
>
> > Do you know if there is precedent for this in some other driver?
> > Are you sure it's not going to break any assumptions?
> >
> Things like iscsi do the very same thing.
> And no, it doesn't break assumptions; quite the contrary.

I see, thanks for the explanation.

Queued up for 5.6.

Thanks,

                Ilya
